// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract EjerciciosFunciones {
    
    // ==================== EJERCICIO 1: CALCULADORA AVANZADA ====================
    
    // Ejercicio: Implementa una calculadora que use diferentes tipos de funciones
    
    // Función pure para operaciones básicas
    function sumar(uint256 a, uint256 b) public pure returns (uint256) {
        return a + b;
    }
    
    function restar(uint256 a, uint256 b) public pure returns (uint256) {
        require(a >= b, "El resultado no puede ser negativo");
        return a - b;
    }
    
    function multiplicar(uint256 a, uint256 b) public pure returns (uint256) {
        return a * b;
    }
    
    function dividir(uint256 a, uint256 b) public pure returns (uint256) {
        require(b != 0, "No se puede dividir por cero");
        return a / b;
    }
    
    // ==================== EJERCICIO 2: SISTEMA DE PUNTUACIÓN ====================
    
    uint256 private puntuacionTotal;
    mapping(address => uint256) private puntuacionesJugadores;
    address private admin;
    
    constructor() {
        admin = msg.sender;
    }
    
    // Función private para validar admin
    function _esAdmin() private view returns (bool) {
        return msg.sender == admin;
    }
    
    // Función internal para calcular bonus
    function _calcularBonus(uint256 puntuacion) internal pure returns (uint256) {
        if (puntuacion >= 1000) return 100;
        if (puntuacion >= 500) return 50;
        if (puntuacion >= 100) return 10;
        return 0;
    }
    
    // Función external para agregar puntuación
    function agregarPuntuacion(address jugador, uint256 puntos) external {
        require(_esAdmin(), "Solo el admin puede agregar puntuacion");
        puntuacionesJugadores[jugador] += puntos;
        puntuacionTotal += puntos;
    }
    
    // Función public view para obtener puntuación de jugador
    function obtenerPuntuacion(address jugador) public view returns (uint256) {
        return puntuacionesJugadores[jugador];
    }
    
    // Función public view para obtener puntuación con bonus
    function obtenerPuntuacionConBonus(address jugador) public view returns (uint256, uint256) {
        uint256 puntuacion = puntuacionesJugadores[jugador];
        uint256 bonus = _calcularBonus(puntuacion);
        return (puntuacion, bonus);
    }
    
    // ==================== EJERCICIO 3: SISTEMA DE DONACIONES ====================
    
    mapping(address => uint256) private donaciones;
    uint256 private totalDonaciones;
    
    event DonacionRecibida(address donante, uint256 cantidad);
    
    // Función payable para recibir donaciones
    function donar() public payable {
        require(msg.value > 0, "La donacion debe ser mayor a 0");
        donaciones[msg.sender] += msg.value;
        totalDonaciones += msg.value;
        emit DonacionRecibida(msg.sender, msg.value);
    }
    
    // Función external view para obtener donación de una dirección
    function obtenerDonacion(address donante) external view returns (uint256) {
        return donaciones[donante];
    }
    
    // Función public view para obtener total de donaciones
    function obtenerTotalDonaciones() public view returns (uint256) {
        return totalDonaciones;
    }
    
    // ==================== EJERCICIO 4: VALIDADOR DE NÚMEROS ====================
    
    // Funciones pure para validaciones
    function esPar(uint256 numero) public pure returns (bool) {
        return numero % 2 == 0;
    }
    
    function esPrimo(uint256 numero) public pure returns (bool) {
        if (numero <= 1) return false;
        if (numero <= 3) return true;
        if (numero % 2 == 0 || numero % 3 == 0) return false;
        
        for (uint256 i = 5; i * i <= numero; i += 6) {
            if (numero % i == 0 || numero % (i + 2) == 0) {
                return false;
            }
        }
        return true;
    }
    
    function esPerfecto(uint256 numero) public pure returns (bool) {
        if (numero <= 1) return false;
        
        uint256 suma = 1;
        for (uint256 i = 2; i * i <= numero; i++) {
            if (numero % i == 0) {
                suma += i;
                if (i != numero / i) {
                    suma += numero / i;
                }
            }
        }
        return suma == numero;
    }
    
    // ==================== EJERCICIO 5: BIBLIOTECA DE STRINGS ====================
    
    // Función pure para obtener longitud de string
    function longitudString(string memory texto) public pure returns (uint256) {
        return bytes(texto).length;
    }
    
    // Función pure para comparar strings
    function sonIguales(string memory texto1, string memory texto2) public pure returns (bool) {
        return keccak256(abi.encodePacked(texto1)) == keccak256(abi.encodePacked(texto2));
    }
    
    // Función pure para concatenar strings
    function concatenar(string memory texto1, string memory texto2) public pure returns (string memory) {
        return string(abi.encodePacked(texto1, texto2));
    }
    
    // ==================== EJERCICIO 6: SISTEMA DE VOTACIÓN ====================
    
    struct Propuesta {
        string descripcion;
        uint256 votosAFavor;
        uint256 votosEnContra;
        bool activa;
    }
    
    mapping(uint256 => Propuesta) private propuestas;
    mapping(address => mapping(uint256 => bool)) private haVotado;
    uint256 private contadorPropuestas;
    
    // Función external para crear propuesta
    function crearPropuesta(string memory descripcion) external {
        require(_esAdmin(), "Solo el admin puede crear propuestas");
        propuestas[contadorPropuestas] = Propuesta({
            descripcion: descripcion,
            votosAFavor: 0,
            votosEnContra: 0,
            activa: true
        });
        contadorPropuestas++;
    }
    
    // Función external para votar
    function votar(uint256 idPropuesta, bool aFavor) external {
        require(propuestas[idPropuesta].activa, "Propuesta no activa");
        require(!haVotado[msg.sender][idPropuesta], "Ya has votado");
        
        if (aFavor) {
            propuestas[idPropuesta].votosAFavor++;
        } else {
            propuestas[idPropuesta].votosEnContra++;
        }
        
        haVotado[msg.sender][idPropuesta] = true;
    }
    
    // Función public view para obtener resultado de propuesta
    function obtenerResultadoPropuesta(uint256 idPropuesta) 
        public 
        view 
        returns (string memory, uint256, uint256, bool) 
    {
        Propuesta memory propuesta = propuestas[idPropuesta];
        return (
            propuesta.descripcion,
            propuesta.votosAFavor,
            propuesta.votosEnContra,
            propuesta.activa
        );
    }
    
    // Función internal para determinar ganador
    function _determinarGanador(uint256 idPropuesta) internal view returns (string memory) {
        Propuesta memory propuesta = propuestas[idPropuesta];
        if (propuesta.votosAFavor > propuesta.votosEnContra) {
            return "A favor";
        } else if (propuesta.votosEnContra > propuesta.votosAFavor) {
            return "En contra";
        } else {
            return "Empate";
        }
    }
    
    // Función external para cerrar propuesta y obtener resultado
    function cerrarPropuesta(uint256 idPropuesta) external returns (string memory) {
        require(_esAdmin(), "Solo el admin puede cerrar propuestas");
        require(propuestas[idPropuesta].activa, "Propuesta ya cerrada");
        
        propuestas[idPropuesta].activa = false;
        return _determinarGanador(idPropuesta);
    }
}