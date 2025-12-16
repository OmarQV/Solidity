# 06. Mappings y Structs

Esta sección explora dos de las estructuras de datos más importantes y utilizadas en Solidity: **Mappings** y **Structs**. Aprenderás a crear estructuras de datos complejas y eficientes para almacenar y organizar información en tus contratos inteligentes.

## Temas cubiertos

### Mappings (Mapeos)

Los mappings son estructuras de datos clave-valor, similares a diccionarios o hash tables en otros lenguajes.

**Características:**
- Permiten buscar valores de forma eficiente mediante una clave
- No tienen longitud ni se pueden iterar directamente
- Todas las claves posibles existen, devuelven valor por defecto si no se ha asignado
- Son muy eficientes en gas para acceso y modificación

**Tipos comunes:**
- `mapping(address => uint256)` - Balances de cuentas
- `mapping(uint256 => string)` - IDs a nombres
- `mapping(address => bool)` - Listas blancas/negras
- `mapping(address => mapping(uint256 => bool))` - Mappings anidados

### Structs (Estructuras)

Los structs permiten crear tipos de datos personalizados agrupando variables relacionadas.

**Características:**
- Agrupan datos relacionados en una sola estructura
- Pueden contener cualquier tipo de dato (incluidos arrays y otros structs)
- Se pueden usar en arrays y mappings
- Permiten organizar código de forma más clara y mantenible

### Combinación de Mappings y Structs

La combinación de estas dos estructuras es muy poderosa:
- `mapping(address => Struct)` - Asociar estructuras complejas a direcciones
- `mapping(uint256 => Struct[])` - Arrays de structs indexados
- Structs que contienen mappings para relaciones complejas

## Casos de uso comunes

- **Sistema de usuarios**: `mapping(address => Usuario)`
- **Registro de productos**: `mapping(uint256 => Producto)`
- **Sistema de votación**: `mapping(uint256 => Propuesta)` con votos
- **Marketplace**: Vendedores, compradores y productos
- **Registros médicos**: Pacientes y sus historiales

## Ejemplo básico

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract EjemploBasico {
    // Struct para representar una persona
    struct Persona {
        string nombre;
        uint256 edad;
        bool activo;
    }
    
    // Mapping de address a Persona
    mapping(address => Persona) public personas;
    
    // Mapping simple de address a balance
    mapping(address => uint256) public balances;
    
    // Función para agregar persona
    function agregarPersona(string memory _nombre, uint256 _edad) public {
        personas[msg.sender] = Persona(_nombre, _edad, true);
    }
    
    // Función para obtener persona
    function obtenerPersona(address _addr) public view returns (string memory, uint256, bool) {
        Persona memory persona = personas[_addr];
        return (persona.nombre, persona.edad, persona.activo);
    }
}
```

## Mejores prácticas

1. **Uso de Mappings:**
   - Usa mappings cuando necesites buscar datos por clave
   - No intentes iterar sobre mappings (usa arrays adicionales si necesitas iterar)
   - Los mappings solo pueden ser variables de estado

2. **Uso de Structs:**
   - Agrupa datos relacionados lógicamente
   - Usa `memory` para structs temporales en funciones
   - Usa `storage` cuando modifiques structs de variables de estado

3. **Optimización de Gas:**
   - Ordena los campos del struct por tamaño para optimizar storage
   - Usa tipos de datos apropiados (uint8, uint16, etc.) cuando sea posible
   - Evita copiar structs grandes innecesariamente

4. **Seguridad:**
   - Valida datos antes de almacenarlos
   - Considera usar modificadores para controlar acceso
   - Ten cuidado con mappings anidados complejos

## Limitaciones importantes

- Los mappings no se pueden retornar directamente de funciones
- Los mappings no tienen longitud
- No puedes obtener todas las claves de un mapping
- Los structs no pueden contener miembros de su propio tipo (pero sí punteros)

---

Explora los ejemplos y experimenta con diferentes combinaciones de mappings y structs para crear estructuras de datos complejas y eficientes.