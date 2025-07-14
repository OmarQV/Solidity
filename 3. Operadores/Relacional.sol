// SPDX-License-Identifier: MIT
pragma solidity 0.8.22;

contract OperadorRelacional {
    // Inicializar variables
    uint16 public a = 10;
    uint16 public b = 30;

    // Inicializar una variable (bool) con el resultado de una comparación igual  
    bool public igual = a == b; 

    // Inicializar una variable (bool) con el resultado de una comparación diferente
    bool public diferente = a != b;
    
    // Inicializar una variable (bool) con el resultado de una comparación mayor
    bool public mayorQue = a > b;
    
    // Inicializar una variable (bool) con el resultado de una comparación menor
    bool public menorQue = a < b;
    
    // Inicializar una variable (bool) con el resultado de una comparación mayor o igual que
    bool public mayorIgual = a >= b;
    
    /// Inicializar una variable (bool) con el resultado de una comparación menor o igual que
    bool public menorIgual = a <= b;
    
}