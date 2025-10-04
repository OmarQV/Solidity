// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract FuncionesVisibilidad {
    // Variables de estado para demostrar diferentes accesos
    uint256 private numeroPrivado;
    uint256 internal numeroInterno;
    uint256 public numeroPublico;
    
    address private propietario;
    mapping(address => uint256) private balances;
    
    // Eventos para mostrar actividad
    event NumeroActualizado(uint256 nuevoNumero);
    event DepositoRecibido(address from, uint256 amount);
    
    constructor() {
        propietario = msg.sender;
        numeroPublico = 100;
        numeroInterno = 50;
        numeroPrivado = 25;
    }
    
    // ==================== FUNCIONES PUBLIC ====================
    
    // Función public normal - puede ser llamada desde cualquier lugar
    function establecerNumeroPublico(uint256 _numero) public {
        numeroPublico = _numero;
        emit NumeroActualizado(_numero);
    }
    
    // Función public view - lee estado pero no lo modifica
    function obtenerNumerosPublicos() public view returns (uint256, uint256) {
        return (numeroPublico, numeroInterno);
    }
    
    // Función public pure - no accede al estado del contrato
    function calcularSuma(uint256 a, uint256 b) public pure returns (uint256) {
        return a + b;
    }
    
    // Función public payable - puede recibir Ether
    function depositar() public payable {
        require(msg.value > 0, "Debe enviar algo de Ether");
        balances[msg.sender] += msg.value;
        emit DepositoRecibido(msg.sender, msg.value);
    }
    
    // ==================== FUNCIONES EXTERNAL ====================
    
    // Función external - solo se puede llamar desde fuera del contrato
    function establecerNumeroPrivadoExternal(uint256 _numero) external {
        require(msg.sender == propietario, "Solo el propietario");
        numeroPrivado = _numero;
    }
    
    // Función external view - más eficiente en gas que public para llamadas externas
    function obtenerBalanceExternal(address _address) external view returns (uint256) {
        return balances[_address];
    }
    
    // Función external pure - cálculos complejos sin acceso al estado
    function calcularFactorial(uint256 n) external pure returns (uint256) {
        if (n == 0 || n == 1) return 1;
        uint256 resultado = 1;
        for (uint256 i = 2; i <= n; i++) {
            resultado *= i;
        }
        return resultado;
    }
    
    // ==================== FUNCIONES INTERNAL ====================
    
    // Función internal - accesible desde este contrato y contratos heredados
    function _calcularDescuento(uint256 monto) internal pure returns (uint256) {
        if (monto >= 1000) return monto * 10 / 100; // 10% descuento
        if (monto >= 500) return monto * 5 / 100;   // 5% descuento
        return 0; // Sin descuento
    }
    
    // Función internal que modifica estado
    function _actualizarNumeroInterno(uint256 _numero) internal {
        numeroInterno = _numero;
    }
    
    // ==================== FUNCIONES PRIVATE ====================
    
    // Función private - solo accesible desde este contrato
    function _validarPropietario() private view returns (bool) {
        return msg.sender == propietario;
    }
    
    // Función private para cálculos internos
    function _calcularInteres(uint256 principal, uint256 tasa) private pure returns (uint256) {
        return (principal * tasa) / 100;
    }
    
    // ==================== FUNCIONES QUE USAN FUNCIONES INTERNAS/PRIVADAS ====================
    
    // Función que demuestra uso de funciones internal
    function aplicarDescuento(uint256 monto) public pure returns (uint256) {
        uint256 descuento = _calcularDescuento(monto);
        return monto - descuento;
    }
    
    // Función que usa funciones private
    function calcularGanancia(uint256 inversion) public view returns (uint256) {
        require(_validarPropietario(), "Solo el propietario puede calcular ganancias");
        return _calcularInteres(inversion, 5); // 5% de interés
    }
    
    // Función que combina internal y private
    function actualizarNumeroConValidacion(uint256 _numero) public {
        require(_validarPropietario(), "Solo el propietario");
        _actualizarNumeroInterno(_numero);
    }
    
    // ==================== FUNCIONES DE UTILIDAD ====================
    
    // Getter para variable private (ya que no se genera automáticamente)
    function obtenerNumeroPrivado() public view returns (uint256) {
        require(_validarPropietario(), "Solo el propietario");
        return numeroPrivado;
    }
    
    // Función para obtener balance del contrato
    function obtenerBalanceContrato() public view returns (uint256) {
        return address(this).balance;
    }
    
    // Función para retirar fondos (solo propietario)
    function retirar() public {
        require(_validarPropietario(), "Solo el propietario");
        require(address(this).balance > 0, "No hay fondos para retirar");
        
        payable(propietario).transfer(address(this).balance);
    }
    
    // ==================== DEMOSTRACIÓN DE DIFERENCIAS ====================
    
    // Esta función muestra la diferencia entre llamar funciones internal vs external
    function demostrarLlamadasInternas() public view returns (uint256, uint256) {
        // Llamada a función internal (desde dentro del contrato)
        uint256 descuento = _calcularDescuento(1000);
        
        // No podemos llamar funciones external desde dentro del contrato directamente
        // uint256 factorial = calcularFactorial(5); // Esto causaría un error
        
        return (descuento, numeroInterno);
    }
}

// Contrato adicional para demostrar herencia y acceso a funciones internal
contract ContratoHijo is FuncionesVisibilidad {
    
    // Podemos acceder a variables y funciones internal del contrato padre
    function usarFuncionInternalDelPadre(uint256 monto) public pure returns (uint256) {
        return _calcularDescuento(monto); // Función internal del padre
    }
    
    // Podemos acceder a variables internal del padre
    function obtenerNumeroInternoDelPadre() public view returns (uint256) {
        return numeroInterno; // Variable internal del padre
    }
    
    // NO podemos acceder a funciones o variables private del padre
    // function usarFuncionPrivada() public view returns (bool) {
    //     return _validarPropietario(); // Error: no es accesible
    // }
}