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