// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract MappingsStructs {
    
    // ==================== EJEMPLO 1: MAPPINGS BÁSICOS ====================
    
    // Mapping simple: address -> balance
    mapping(address => uint256) public balances;
    
    // Mapping de address a booleano (lista blanca)
    mapping(address => bool) public listaBlanca;
    
    // Mapping de uint a string
    mapping(uint256 => string) public nombres;
    
    // Funciones para mappings básicos
    function establecerBalance(uint256 _balance) public {
        balances[msg.sender] = _balance;
    }
    
    function agregarAListaBlanca(address _addr) public {
        listaBlanca[_addr] = true;
    }
    
    function asignarNombre(uint256 _id, string memory _nombre) public {
        nombres[_id] = _nombre;
    }
    
    // ==================== EJEMPLO 2: STRUCTS BÁSICOS ====================
    
    // Definición de struct Persona
    struct Persona {
        string nombre;
        uint256 edad;
        address wallet;
        bool activo;
    }
    
    // Array de structs
    Persona[] public personas;
    
    // Función para agregar persona al array
    function agregarPersona(string memory _nombre, uint256 _edad, address _wallet) public {
        personas.push(Persona({
            nombre: _nombre,
            edad: _edad,
            wallet: _wallet,
            activo: true
        }));
    }
    
    // Función para obtener cantidad de personas
    function cantidadPersonas() public view returns (uint256) {
        return personas.length;
    }
    
    // Función para actualizar persona
    function actualizarPersona(uint256 _index, string memory _nombre, uint256 _edad) public {
        require(_index < personas.length, "Indice invalido");
        Persona storage persona = personas[_index];
        persona.nombre = _nombre;
        persona.edad = _edad;
    }
    
    // ==================== EJEMPLO 3: MAPPING + STRUCT ====================
    
    // Struct más complejo para usuarios
    struct Usuario {
        string nombre;
        uint256 edad;
        uint256 saldo;
        uint256 fechaRegistro;
        bool verificado;
    }
    
    // Mapping de address a Usuario
    mapping(address => Usuario) public usuarios;
    
    // Contador de usuarios registrados
    uint256 public totalUsuarios;
    
    // Función para registrar usuario
    function registrarUsuario(string memory _nombre, uint256 _edad) public {
        require(bytes(usuarios[msg.sender].nombre).length == 0, "Usuario ya registrado");
        
        usuarios[msg.sender] = Usuario({
            nombre: _nombre,
            edad: _edad,
            saldo: 0,
            fechaRegistro: block.timestamp,
            verificado: false
        });
        
        totalUsuarios++;
    }
    
    // Función para verificar usuario
    function verificarUsuario(address _addr) public {
        require(bytes(usuarios[_addr].nombre).length > 0, "Usuario no existe");
        usuarios[_addr].verificado = true;
    }
    
    // Función para depositar saldo
    function depositarSaldo() public payable {
        require(bytes(usuarios[msg.sender].nombre).length > 0, "Usuario no registrado");
        usuarios[msg.sender].saldo += msg.value;
    }
    
    // ==================== EJEMPLO 4: MAPPINGS ANIDADOS ====================
    
    // Mapping anidado: curso -> alumno -> calificación
    mapping(uint256 => mapping(address => uint256)) public calificaciones;
    
    // Mapping anidado: propietario -> operador -> aprobado
    mapping(address => mapping(address => bool)) public operadores;
    
    // Función para asignar calificación
    function asignarCalificacion(uint256 _idCurso, address _alumno, uint256 _nota) public {
        require(_nota <= 100, "Nota invalida");
        calificaciones[_idCurso][_alumno] = _nota;
    }
    
    // Función para aprobar operador
    function aprobarOperador(address _operador, bool _aprobado) public {
        operadores[msg.sender][_operador] = _aprobado;
    }
    
    // ==================== EJEMPLO 5: STRUCT COMPLEJO ====================
    
    // Struct con múltiples tipos de datos
    struct Producto {
        uint256 id;
        string nombre;
        string descripcion;
        uint256 precio;
        uint256 stock;
        address vendedor;
        bool disponible;
        string[] categorias;
        uint256 fechaCreacion;
    }
    
    // Mapping de productos
    mapping(uint256 => Producto) public productos;
    uint256 public contadorProductos;
    
    // Función para crear producto
    function crearProducto(
        string memory _nombre,
        string memory _descripcion,
        uint256 _precio,
        uint256 _stock,
        string[] memory _categorias
    ) public returns (uint256) {
        uint256 nuevoId = contadorProductos;
        
        Producto storage nuevoProducto = productos[nuevoId];
        nuevoProducto.id = nuevoId;
        nuevoProducto.nombre = _nombre;
        nuevoProducto.descripcion = _descripcion;
        nuevoProducto.precio = _precio;
        nuevoProducto.stock = _stock;
        nuevoProducto.vendedor = msg.sender;
        nuevoProducto.disponible = true;
        nuevoProducto.fechaCreacion = block.timestamp;
        
        // Agregar categorías
        for (uint256 i = 0; i < _categorias.length; i++) {
            nuevoProducto.categorias.push(_categorias[i]);
        }
        
        contadorProductos++;
        return nuevoId;
    }
    
    // Función para actualizar stock
    function actualizarStock(uint256 _idProducto, uint256 _nuevoStock) public {
        require(_idProducto < contadorProductos, "Producto no existe");
        require(productos[_idProducto].vendedor == msg.sender, "No eres el vendedor");
        
        productos[_idProducto].stock = _nuevoStock;
    }
    
    // Función para obtener categorías de producto
    function obtenerCategorias(uint256 _idProducto) public view returns (string[] memory) {
        require(_idProducto < contadorProductos, "Producto no existe");
        return productos[_idProducto].categorias;
    }
    
    // ==================== EJEMPLO 6: STRUCT CON MAPPING ====================
    
    // Struct que contiene un mapping (solo en storage)
    struct Empresa {
        string nombre;
        address propietario;
        mapping(address => bool) empleados;
        mapping(address => uint256) salarios;
        uint256 totalEmpleados;
    }
    
    // Mapping de empresas
    mapping(uint256 => Empresa) public empresas;
    uint256 public contadorEmpresas;
    
    // Función para crear empresa
    function crearEmpresa(string memory _nombre) public returns (uint256) {
        uint256 nuevaId = contadorEmpresas;
        
        Empresa storage nuevaEmpresa = empresas[nuevaId];
        nuevaEmpresa.nombre = _nombre;
        nuevaEmpresa.propietario = msg.sender;
        nuevaEmpresa.totalEmpleados = 0;
        
        contadorEmpresas++;
        return nuevaId;
    }
    
    // Función para agregar empleado
    function agregarEmpleado(uint256 _idEmpresa, address _empleado, uint256 _salario) public {
        require(_idEmpresa < contadorEmpresas, "Empresa no existe");
        require(empresas[_idEmpresa].propietario == msg.sender, "No eres el propietario");
        require(!empresas[_idEmpresa].empleados[_empleado], "Empleado ya existe");
        
        empresas[_idEmpresa].empleados[_empleado] = true;
        empresas[_idEmpresa].salarios[_empleado] = _salario;
        empresas[_idEmpresa].totalEmpleados++;
    }
    
    // Función para verificar si es empleado
    function esEmpleado(uint256 _idEmpresa, address _empleado) public view returns (bool) {
        require(_idEmpresa < contadorEmpresas, "Empresa no existe");
        return empresas[_idEmpresa].empleados[_empleado];
    }
    
    // Función para obtener salario
    function obtenerSalario(uint256 _idEmpresa, address _empleado) public view returns (uint256) {
        require(_idEmpresa < contadorEmpresas, "Empresa no existe");
        require(empresas[_idEmpresa].empleados[_empleado], "No es empleado");
        return empresas[_idEmpresa].salarios[_empleado];
    }
    
    // ==================== EJEMPLO 7: ITERAR CON ARRAY + MAPPING ====================
    
    // Para iterar sobre mappings, necesitamos un array de claves
    address[] public listaUsuarios;
    mapping(address => bool) private usuarioExiste;
    
    // Función para agregar usuario a lista iterable
    function agregarUsuarioIterable(address _usuario) public {
        require(!usuarioExiste[_usuario], "Usuario ya existe");
        
        listaUsuarios.push(_usuario);
        usuarioExiste[_usuario] = true;
    }
    
    // Función para obtener todos los usuarios
    function obtenerTodosUsuarios() public view returns (address[] memory) {
        return listaUsuarios;
    }
    
    // Función para contar usuarios con saldo mayor a X
    function contarUsuariosConSaldo(uint256 _minimo) public view returns (uint256) {
        uint256 contador = 0;
        
        for (uint256 i = 0; i < listaUsuarios.length; i++) {
            if (usuarios[listaUsuarios[i]].saldo >= _minimo) {
                contador++;
            }
        }
        
        return contador;
    }
    
    // ==================== FUNCIONES DE UTILIDAD ====================
    
    // Función para obtener información completa de usuario
    function obtenerInfoUsuario(address _addr) public view returns (
        string memory nombre,
        uint256 edad,
        uint256 saldo,
        uint256 fechaRegistro,
        bool verificado
    ) {
        Usuario memory user = usuarios[_addr];
        return (
            user.nombre,
            user.edad,
            user.saldo,
            user.fechaRegistro,
            user.verificado
        );
    }
    
    // Función para resetear datos de un usuario (solo el mismo usuario)
    function resetearUsuario() public {
        delete usuarios[msg.sender];
        totalUsuarios--;
    }
}