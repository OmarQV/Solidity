# 🛠️ Configuración y Herramientas para Desarrollo en Solidity

¡Bienvenido a la sección de configuración de tu viaje de aprendizaje de Solidity! Aquí encontrarás los pasos y herramientas esenciales para poner en marcha tu entorno de desarrollo de contratos inteligentes.

Dominar estas herramientas te permitirá escribir, compilar, desplegar e interactuar con tus contratos de Solidity de manera efectiva.

---

## 1. Editor de Código (Recomendado: Visual Studio Code)

**Visual Studio Code (VS Code)** es el editor de código más popular para el desarrollo de Solidity debido a su gran flexibilidad y ecosistema de extensiones.

* **Descarga e Instalación:**
    Descarga VS Code desde su sitio oficial: [code.visualstudio.com](https://code.visualstudio.com/)

* **Extensiones Esenciales para Solidity en VS Code:**
    Una vez instalado VS Code, ve a la sección de extensiones (el icono de cuadrados en la barra lateral izquierda o `Ctrl+Shift+X`) e instala las siguientes:
    * **Solidity** (de Juan Blanco): Proporciona resaltado de sintaxis, autocompletado, formateo, detección de errores y más. Es la extensión indispensable.
    * **Prettier - Code formatter** (opcional, pero muy recomendable): Para mantener tu código de Solidity (y otros lenguajes) formateado de manera consistente.
        * _Configuración de Prettier para Solidity:_ Una vez instalada, es posible que necesites configurarla para que funcione bien con Solidity. Puedes añadir estas líneas a tu archivo de configuración de VS Code (`settings.json`):
            ```json
            "[solidity]": {
                "editor.defaultFormatter": "esbenp.prettier-vscode",
                "editor.formatOnSave": true
            },
            "prettier.documentSelectors": ["**/*.sol"]
            ```

---

## 2. Remix IDE (Online - Para empezar rápidamente)

**Remix IDE** es una herramienta muy popular para desarrolladores de Solidity, especialmente para principiantes. Es un entorno de desarrollo integrado basado en navegador, lo que significa que no necesitas instalar nada localmente para empezar a escribir, compilar y desplegar contratos.

* **Acceso a Remix:**
    Simplemente abre tu navegador y ve a: [remix.ethereum.org](https://remix.ethereum.org/)

* **¿Por qué Remix?**
    * **Cero Configuración:** No requiere instalación.
    * **Entorno Integrado:** Incluye compilador, desplegador, depurador y analizador estático.
    * **Ideal para Prototipos:** Perfecto para probar ideas rápidas y aprender los fundamentos.

* **Guía Rápida:**
    Consulta el archivo `00_Remix_Basics.md` en esta misma carpeta para una introducción rápida a cómo usar Remix.

---

## 3. Entornos de Desarrollo Local (Para el futuro - Hardhat/Truffle/Foundry)

A medida que tus proyectos crezcan, querrás usar un entorno de desarrollo local más robusto. Los frameworks más populares son **Hardhat**, **Truffle** y **Foundry**. Estos te permiten:

* Desarrollar, compilar y probar contratos localmente.
* Automatizar el despliegue a diferentes redes.
* Gestionar dependencias y plugins.

**Por ahora, no necesitas instalar estos.** Concéntrate en VS Code y Remix. Los exploraremos en secciones futuras cuando los conceptos básicos estén claros.

---

## 4. Ganache (Opcional, para simular una blockchain localmente)

**Ganache** es una cadena de bloques personal que puedes ejecutar en tu escritorio para desarrollo. Proporciona una interfaz de usuario limpia para inspeccionar transacciones, cuentas y contratos.

* **Descarga e Instalación:**
    Descarga Ganache desde el sitio web de TruffleSuite: [trufflesuite.com/ganache](https://trufflesuite.com/ganache/)

* **¿Por qué Ganache?**
    * **Desarrollo Rápido:** No necesitas desplegar en una red de prueba real para cada pequeña prueba.
    * **Cuentas Ficticias:** Proporciona un conjunto de cuentas con Ether falso.
    * **Visibilidad:** Te permite ver las transacciones y el estado de la cadena en tiempo real.

Puedes usar Ganache junto con Remix, VS Code y un framework local.

---

### ¡Listo para Codificar!

Con estas herramientas configuradas, estás listo para sumergirte en la escritura de tus primeros contratos inteligentes. ¡Vamos a la siguiente sección para ver cómo empezar en Remix!