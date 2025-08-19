// SPDX-License-Identifier: MIT
pragma solidity ^0.8.22;

contract EstructurasDeControl {
    uint public contador;

    // Ejemplo de condicional if/else
    function ejemploIfElse(uint valor) public {
        if (valor > 10) {
            contador = valor;
        } else if (valor == 10) {
            contador = 10;
        } else {
            contador = 0;
        }
    }

    // Ejemplo de bucle for
    function ejemploFor() public {
        contador = 0;
        for (uint i = 0; i < 5; i++) {
            contador += i;
        }
    }

    // Ejemplo de bucle while
    function ejemploWhile() public {
        contador = 0;
        uint i = 0;
        while (i < 3) {
            contador += i;
            i++;
        }
    }

    // Ejemplo de bucle do/while
    function ejemploDoWhile() public {
        contador = 0;
        uint i = 0;
        do {
            contador += i;
            i++;
        } while (i < 2);
    }
    
        // Ejercicio 1: Suma de números pares menores a n usando for
        // Explicación: Recorre desde 0 hasta n-1 y suma solo los pares
        function sumaPares(uint n) public pure returns (uint) {
            uint suma = 0;
            for (uint i = 0; i < n; i++) {
                if (i % 2 == 0) {
                    suma += i;
                }
            }
            return suma;
        }

        // Ejercicio 2: Cuenta regresiva usando while
        // Explicación: Decrementa desde n hasta 0 y almacena el último valor en contador
        function cuentaRegresiva(uint n) public {
            while (n > 0) {
                n--;
            }
            contador = n; // Siempre será 0
        }

        // Ejemplo extra: Uso de break y continue en bucle for
        // Explicación: Suma los números hasta encontrar el primer múltiplo de 7, luego se detiene
        function sumaHastaMultiploDeSiete(uint n) public pure returns (uint) {
            uint suma = 0;
            for (uint i = 0; i < n; i++) {
                if (i % 7 == 0 && i != 0) {
                    break;
                }
                if (i % 2 == 1) {
                    continue; // Salta los impares
                }
                suma += i;
            }
            return suma;
        }

        // Ejercicio 3: Validar si un número es primo usando for y break
        // Explicación: Devuelve true si el número es primo, false si no lo es
        function esPrimo(uint n) public pure returns (bool) {
            if (n <= 1) return false;
            for (uint i = 2; i < n; i++) {
                if (n % i == 0) {
                    return false;
                }
            }
            return true;
        }
}
