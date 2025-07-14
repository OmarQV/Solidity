// SPDX-License-Identifier: MIT
pragma solidity ^0.8.22;

contract TipodeDato {
    // Comentario
    /*
    Modulo 1
    Este es la seccion de tipo de dato
    */
    uint256 miNumero;
    uint8 number = 10;
    uint256 public maxVal = type(uint256).max;
    int8 numNegativo = -4;
    bool llueve = true;
    // address owner = 0x165468433;

    enum Cafe {Expreso, Latte, Capucchino}
    Cafe public miCafe;

    function servir() public {
        miCafe = Cafe.Capucchino;
    }

    function ObtenerCafe() public view returns (Cafe) {
        return miCafe;
    }

    // tipo de Bytes
    bytes4 public ejemploByte = "Hola";
    bytes32 public ejemploMayor = "Hola";
    
    // String 
    string public palabra = "Adios";

    /**
     * @dev Función para establecer un nuevo valor para la variable 'palabra'.
     * @param _nuevaPalabra El nuevo string que se desea asignar.
     */
    function setPalabra(string memory _nuevaPalabra) public {
        // Asignamos el valor del parámetro a la variable de estado 'palabra'.
        palabra = _nuevaPalabra;
    }

    /**
     * @dev Función para obtener el valor actual de la variable 'palabra'.
     *
     * Aunque 'palabra' es 'public' y ya tiene un getter automático,
     * se puede definir una función explícita para mayor claridad o lógica adicional.
     *
     * @return El string almacenado en la variable 'palabra'.
     */
    function obtenerPalabra() public view returns (string memory) {
        // Retornamos el valor actual de la variable de estado 'palabra'.
        return palabra;
    }
    
    // FUNCIONES
    function PublicFunction() public {
        // Accesible desde cualquier parte:
        // - Puede ser llamada por otras funciones dentro de este mismo contrato.
        // - Puede ser llamada por contratos externos que interactúen con este contrato.
        // - Puede ser llamada por cuentas externas (usuarios que envían transacciones).
        // Es el tipo de visibilidad más permisivo y a menudo se usa para la API principal de tu contrato.
    }

    function PrivateFunction() private {
        // Solo accesible dentro de este contrato:
        // - Únicamente puede ser llamada por otras funciones dentro de este mismo contrato.
        // - NO puede ser llamada por contratos que hereden de este.
        // - NO puede ser llamada por contratos externos.
        // - NO puede ser llamada por cuentas externas.
        // Se usa para funciones auxiliares internas que no deben exponerse.
    }

    function InternalFunction() internal { // IMPORTANTE: Cambiado a 'internal'
        // Accesible dentro de este contrato Y por contratos derivados:
        // - Puede ser llamada por otras funciones dentro de este mismo contrato.
        // - Puede ser llamada por funciones en contratos que HEREDAN de este contrato (contratos hijos).
        // - NO puede ser llamada por contratos externos que no heredan de este.
        // - NO puede ser llamada por cuentas externas.
        // Es útil para compartir lógica entre un contrato padre y sus hijos.
    }

    function ExternalFunction() external {
        // Solo accesible desde fuera del contrato:
        // - Puede ser llamada por otros contratos.
        // - Puede ser llamada por cuentas externas (usuarios).
        // - NO puede ser llamada por funciones dentro de este mismo contrato directamente (por ejemplo, `this.ExternalFunction()`).
        //   Si una función necesita ser llamada tanto interna como externamente, debe ser `public`.
        // Se usa para la interfaz externa de un contrato, a menudo para ahorrar gas.
    }
}