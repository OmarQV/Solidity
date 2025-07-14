// SPDX-License-Identifier: MIT
pragma solidity 0.8.22;

contract OperadorAritmetico {
    // Inicializar variables
    uint16 public a = 10;
    uint16 public b = 30;

    // Inicializar una variable con el operador de suma
    uint public adicion  = a + b;

    // Inicializar una variable con el operador de resta
    uint public resta  = b - a;
    
    // Inicializar una variable con una multiplicación
    uint public multiplicacion = a * b;

    // Inicializar una variable con el cociente de una división
    uint public division = b / a;

    // Inicializando una variable con módulo
    uint public modulo = b % a;

    // Inicializar una variable con un valor reducido en uno
    uint public decremento = --b;

    // Inicializar una variable con un valor incrementado en uno
    uint public incremento = ++a;

}