// SPDX-License-Identifier: MIT
pragma solidity ^0.8.22;

contract OperatorLogico { 
    // Inicializar variables
    bool public solea = true;
    bool public llueve = false;

    // Inicializar una variable con el resultado de un AND
    bool public and = solea && llueve; 

    // Inicializar una variable con el resultado de un OR
    bool public or  = solea || llueve;
        
    // Inicializar una variable con el resultado de un NOT
    bool public not = !solea;
}