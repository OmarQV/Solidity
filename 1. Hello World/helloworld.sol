// SPDX-License-Identifier: MIT
pragma solidity 0.8.22; // Especifica la versión del compilador Solidity

/**
 * @title HolaMundo
 * @dev Un contrato simple que almacena y retorna un mensaje de "Hola Mundo".
 */

contract HolaMundo {
    // Declara una variable de estado de tipo string (cadena de texto)
    // 'public' significa que se puede leer desde fuera del contrato sin una función getter explícita
    string public mensaje;

    /**
     * @dev Constructor del contrato.
     * Se ejecuta una sola vez cuando el contrato es desplegado en la blockchain.
     * Inicializa la variable 'mensaje' con un valor predeterminado.
     */
    constructor() {
        mensaje = "Hola Mundo desde Solidity!!!";
    }

    /**
     * @dev Función para actualizar el mensaje del contrato.
     * @param _nuevoMensaje El nuevo mensaje a establecer.
     * Esta función es 'public' para que pueda ser llamada desde fuera del contrato.
     */
    function establecerMensaje(string memory _nuevoMensaje) public {
        mensaje = _nuevoMensaje;
    }

    /**
     * @dev Función para obtener el mensaje actual del contrato.
     * @return El mensaje actual del contrato.
     * 'view' indica que la función no modifica el estado del contrato (no cuesta gas por ejecución).
     * 'public' significa que se puede llamar desde fuera del contrato.
     */
    function obtenerMensaje() public view returns (string memory) {
        return mensaje;
    }
}