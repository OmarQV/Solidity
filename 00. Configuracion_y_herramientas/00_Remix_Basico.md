# 🚀 Guía Rápida de Remix IDE (Ethereum Remix Online IDE)

Remix es una herramienta poderosa y accesible para empezar a desarrollar en Solidity. Aquí te muestro los pasos básicos para escribir, compilar y desplegar tu primer contrato "Hola Mundo" en Remix.

---

## 1. Abrir Remix IDE

* Abre tu navegador web y navega a: [remix.ethereum.org](https://remix.ethereum.org/)
* Serás recibido por la interfaz principal de Remix, con un editor de código en el centro y paneles laterales.

---

## 2. Crear un Nuevo Archivo de Contrato

* En la barra lateral izquierda, busca el **"File Explorers"** (icono de carpeta).
* Haz clic en el icono de **"Create new file"** (parece un documento con un signo `+`).
* Nombra tu archivo, por ejemplo, `HolaMundo.sol`. Asegúrate de que termine con `.sol`.

---

## 3. Escribir el Código del Contrato

* Copia y pega el siguiente código de tu contrato `HolaMundo.sol` en el editor central de Remix:

    ```solidity
    // SPDX-License-Identifier: MIT
    pragma solidity ^0.8.0;

    contract HolaMundo {
        string public mensaje;

        constructor() {
            mensaje = "¡Hola Mundo desde Solidity!";
        }

        function establecerMensaje(string memory _nuevoMensaje) public {
            mensaje = _nuevoMensaje;
        }

        function obtenerMensaje() public view returns (string memory) {
            return mensaje;
        }
    }
    ```

---

## 4. Compilar el Contrato

* En la barra lateral izquierda, haz clic en el icono del **"Solidity Compiler"** (parece un logo de Solidity).
* Asegúrate de que la versión del compilador seleccionada (`COMPILER`) sea compatible con tu `pragma solidity` (por ejemplo, `0.8.x`). Remix suele seleccionar la versión correcta automáticamente.
* Haz clic en el botón **"Compile HolaMundo.sol"**.
* Si no hay errores, verás una marca verde junto al icono del compilador. Si hay errores o advertencias, Remix te los mostrará en la parte inferior.

---

## 5. Desplegar el Contrato

* En la barra lateral izquierda, haz clic en el icono de **"Deploy & Run Transactions"** (parece un logo de Ethereum con una flecha hacia abajo).
* **Environment (Entorno):**
    * Para pruebas locales rápidas, selecciona `JavaScript VM` (Máquina Virtual de JavaScript). Esta es una blockchain simulada directamente en tu navegador y es muy rápida.
    * Remix te mostrará varias cuentas de prueba con Ether ficticio.
* **Contract:**
    * Asegúrate de que `HolaMundo` esté seleccionado en el menú desplegable "Contract".
* Haz clic en el botón **"Deploy"**.
* Si el despliegue es exitoso, verás tu contrato listado bajo "Deployed Contracts" en la misma sección, y una transacción verde en la consola inferior.

---

## 6. Interactuar con el Contrato Desplegado

* Expande el contrato `HOLAMUNDO` bajo "Deployed Contracts" en la barra lateral izquierda.
* Verás los botones correspondientes a las funciones de tu contrato:
    * **`mensaje` (botón naranja):** Este es el _getter_ automático para la variable `public mensaje`. Haz clic para ver el mensaje inicial ("¡Hola Mundo desde Solidity!").
    * **`obtenerMensaje` (botón azul):** Haz clic para llamar a tu función `obtenerMensaje()` y ver el mensaje actual. (Nota: Para funciones `view` o `pure`, los botones suelen ser azules o verdes).
    * **`establecerMensaje` (botón naranja/rojo):**
        * A su lado, verás un campo de entrada. Escribe un nuevo mensaje, por ejemplo, `"¡Hola desde Remix!"`.
        * Haz clic en el botón `establecerMensaje`. Esta es una transacción y verás un log en la consola inferior.
    * Vuelve a hacer clic en `mensaje` u `obtenerMensaje` para confirmar que el mensaje ha cambiado.

---

¡Felicidades! Has compilado y desplegado tu primer contrato inteligente en Remix y has interactuado con él. Este es el flujo de trabajo básico que usarás para muchos de tus ejemplos iniciales.