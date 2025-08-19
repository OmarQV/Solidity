# 04. Estructuras de Control

Esta sección explora las estructuras de control en Solidity, fundamentales para la lógica de los contratos inteligentes. Aquí aprenderás cómo tomar decisiones y repetir acciones dentro de tus contratos.

## Temas cubiertos

- **Condicionales (`if`, `else`, `else if`)**: Permiten ejecutar código dependiendo de si se cumple una condición.
- **Bucles `for`**: Ejecutan un bloque de código un número determinado de veces.
- **Bucles `while` y `do/while`**: Ejecutan código mientras se cumpla una condición.
- **Control de flujo (`break`, `continue`, `return`)**: Modifican el comportamiento de los bucles y funciones.

## Ejemplo básico

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract EstructurasDeControl {
    uint public contador;

    function ejemploIfElse(uint valor) public {
        if (valor > 10) {
            contador = valor;
        } else if (valor == 10) {
            contador = 10;
        } else {
            contador = 0;
        }
    }

    function ejemploFor() public {
        contador = 0;
        for (uint i = 0; i < 5; i++) {
            contador += i;
        }
    }

    function ejemploWhile() public {
        contador = 0;
        uint i = 0;
        while (i < 3) {
            contador += i;
            i++;
        }
    }
}
```

## Recomendaciones

- Evita bucles infinitos, ya que pueden agotar el gas y fallar la transacción.
- Usa condicionales para validar entradas y proteger la lógica del contrato.
- Los bucles deben ser simples y predecibles para evitar costos elevados de gas.

---

Explora los ejemplos y modifica el código para entender cómo funcionan las estructuras de control en Solidity.
