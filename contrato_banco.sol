// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

contract ContratoBonco {
    
    // Definemos un tipo de dato para el cliente
    struct Cliente {
        string nombre;
        address direccion;
        uint dinero;
    }

    // Mapping que nos relaciona la direccion del cliente con su informacion
    mapping(string => Cliente) clientes;

    // Funcion que nos permite crear un cliente
    function crearCliente(string memory _nombre) internal {
        clientes[_nombre] = Cliente(_nombre, msg.sender, 0);
    }
}

// Haciendo herencia del contrato ContratoBonco
contract ContratoCliente is ContratoBonco {
    function altaCliente(string memory _nombre) public {
        crearCliente(_nombre);
    }

    function ingresarDinero(string memory _nombre, uint _cantidadDinero) public {
        // Comprobamos que el cliente existe
        // require(clientes[_nombre].dinero != 0, "El cliente no existe");
        // Comprobamos que el cliente es el que esta haciendo la transaccion
        require(clientes[_nombre].direccion == msg.sender, "No eres el cliente");
        // Aumentamos el dinero del cliente
        clientes[_nombre].dinero += _cantidadDinero;
    }

    // Funcion que nos permita retirar dinero
    function retirarDinero(string memory _nombre, uint _cantidadDinero) public{
        // Comprobamos que el cliente existe
        require(clientes[_nombre].dinero != 0, "El cliente no existe");
        // Comprobamos que el cliente es el que esta haciendo la transaccion
        require(clientes[_nombre].direccion == msg.sender, "No eres el cliente");
        // Comprobamos que el cliente tiene dinero suficiente
        require(clientes[_nombre].dinero >= _cantidadDinero, "No tienes dinero suficiente");
        // Disminuimos el dinero del cliente
        clientes[_nombre].dinero -= _cantidadDinero;
    }

    // Funcion que nos permite consultar el dinero de un cliente
    function consultarDinero(string memory _nombre) public view returns(uint) {
        // Comprobamos que el cliente existe
        require(clientes[_nombre].dinero != 0, "El cliente no existe");
        // Comprobamos que el cliente es el que esta haciendo la transaccion
        require(clientes[_nombre].direccion == msg.sender, "No eres el cliente");
        // Devolvemos el dinero del cliente
        return clientes[_nombre].dinero;
    }
}