// SPDX-License-Identifier: MIT
pragma solidity ^0.8.22;

contract OperatorAsignacion {
    // Inicializa variable de estado 
    uint public numero = 10;
    //Asignación simple
    function simpleAsignacion() public {
        numero = 20; 
    }

    //Asignación suma
    function suma() public {
        numero += 10; 
    }
        
    //Asignación resta
    function resta() public {
        numero -= 10; 
    }

    //Asignación multiplicación
    function multiplicacion() public {
        numero *= 10; 
    }

    //Asignación división
    function division () public {
        numero /=10 ;
    }

    //Asignación módulo
    function modulo() public {
        numero %= 3; 
    }

}