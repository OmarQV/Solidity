# 05. Funciones y Visibilidad

Esta sección explora en profundidad las funciones en Solidity y sus diferentes niveles de visibilidad. Comprende cómo funcionan los modificadores de función y cuándo usar cada tipo para escribir contratos seguros y eficientes.

## Temas cubiertos

### Tipos de Función

- **`pure`**: Funciones que no leen ni modifican el estado del contrato. Solo trabajan con los parámetros de entrada.
- **`view`**: Funciones que leen el estado del contrato pero no lo modifican.
- **`payable`**: Funciones que pueden recibir Ether junto con la llamada a la función.
- **Funciones normales**: Pueden leer y modificar el estado del contrato.

### Niveles de Visibilidad

- **`public`**: Accesible desde cualquier lugar (dentro y fuera del contrato).
- **`private`**: Solo accesible desde el mismo contrato donde se define.
- **`internal`**: Accesible desde el mismo contrato y contratos que hereden de él.
- **`external`**: Solo accesible desde fuera del contrato (no desde el mismo contrato).

## Conceptos Importantes

### Gas y Eficiencia
- Las funciones `pure` y `view` no consumen gas cuando se llaman externamente.
- Las funciones `payable` son necesarias para recibir Ether.
- Elegir la visibilidad correcta es crucial para la seguridad del contrato.

### Mejores Prácticas
- Usa `pure` cuando no necesites acceso al estado.
- Usa `view` cuando solo necesites leer datos.
- Marca como `private` o `internal` las funciones auxiliares.
- Usa `external` para funciones que solo se llaman desde fuera.

## Ejemplo básico

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract FuncionesVisibilidad {
    uint256 private numero;
    
    // Función public que modifica estado
    function establecerNumero(uint256 _numero) public {
        numero = _numero;
    }
    
    // Función view que lee estado
    function obtenerNumero() public view returns (uint256) {
        return numero;
    }
    
    // Función pure que no accede al estado
    function sumar(uint256 a, uint256 b) public pure returns (uint256) {
        return a + b;
    }
    
    // Función payable que puede recibir Ether
    function depositar() public payable {
        // Función que puede recibir Ether
    }
}
```

## Recomendaciones

- Siempre usa el modificador más restrictivo posible para mayor seguridad.
- Las funciones `pure` y `view` ayudan a optimizar el gas y hacen el código más claro.
- Documentar claramente el propósito de cada función y su nivel de acceso.
- Evita hacer funciones `public` cuando `external` es suficiente.

---

Explora los ejemplos y experimenta con diferentes combinaciones de modificadores para entender su comportamiento y optimizar tus contratos.