// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract EjerciciosMappingsStructs {
    
    // ==================== EJERCICIO 1: BIBLIOTECA DIGITAL ====================
    
    struct Libro {
        string titulo;
        string autor;
        uint256 anioPublicacion;
        bool disponible;
        address prestadoA;
        uint256 fechaPrestamo;
    }
    
    mapping(uint256 => Libro) public libros;
    uint256 public totalLibros;
    
    // Agregar libro a la biblioteca
    function agregarLibro(
        string memory _titulo,
        string memory _autor,
        uint256 _anio
    ) public returns (uint256) {
        uint256 nuevoId = totalLibros;
        
        libros[nuevoId] = Libro({
            titulo: _titulo,
            autor: _autor,
            anioPublicacion: _anio,
            disponible: true,
            prestadoA: address(0),
            fechaPrestamo: 0
        });
        
        totalLibros++;
        return nuevoId;
    }
    
    // Prestar libro
    function prestarLibro(uint256 _idLibro) public {
        require(_idLibro < totalLibros, "Libro no existe");
        require(libros[_idLibro].disponible, "Libro no disponible");
        
        libros[_idLibro].disponible = false;
        libros[_idLibro].prestadoA = msg.sender;
        libros[_idLibro].fechaPrestamo = block.timestamp;
    }
    
    // Devolver libro
    function devolverLibro(uint256 _idLibro) public {
        require(_idLibro < totalLibros, "Libro no existe");
        require(libros[_idLibro].prestadoA == msg.sender, "No tienes este libro");
        
        libros[_idLibro].disponible = true;
        libros[_idLibro].prestadoA = address(0);
        libros[_idLibro].fechaPrestamo = 0;
    }
    
    // Obtener libros disponibles
    function contarLibrosDisponibles() public view returns (uint256) {
        uint256 contador = 0;
        for (uint256 i = 0; i < totalLibros; i++) {
            if (libros[i].disponible) {
                contador++;
            }
        }
        return contador;
    }
    
    // ==================== EJERCICIO 2: SISTEMA DE TAREAS ====================
    
    struct Tarea {
        string descripcion;
        bool completada;
        uint256 prioridad; // 1: baja, 2: media, 3: alta
        uint256 fechaCreacion;
        uint256 fechaCompletada;
    }
    
    mapping(address => Tarea[]) public tareasUsuario;
    
    // Crear tarea
    function crearTarea(string memory _descripcion, uint256 _prioridad) public {
        require(_prioridad >= 1 && _prioridad <= 3, "Prioridad invalida");
        
        tareasUsuario[msg.sender].push(Tarea({
            descripcion: _descripcion,
            completada: false,
            prioridad: _prioridad,
            fechaCreacion: block.timestamp,
            fechaCompletada: 0
        }));
    }
    
    // Completar tarea
    function completarTarea(uint256 _index) public {
        require(_index < tareasUsuario[msg.sender].length, "Tarea no existe");
        require(!tareasUsuario[msg.sender][_index].completada, "Tarea ya completada");
        
        tareasUsuario[msg.sender][_index].completada = true;
        tareasUsuario[msg.sender][_index].fechaCompletada = block.timestamp;
    }
    
    // Obtener cantidad de tareas
    function cantidadTareas(address _usuario) public view returns (uint256) {
        return tareasUsuario[_usuario].length;
    }
    
    // Obtener tareas pendientes
    function contarTareasPendientes() public view returns (uint256) {
        uint256 contador = 0;
        Tarea[] memory tareas = tareasUsuario[msg.sender];
        
        for (uint256 i = 0; i < tareas.length; i++) {
            if (!tareas[i].completada) {
                contador++;
            }
        }
        
        return contador;
    }
    
    // ==================== EJERCICIO 3: MERCADO DE TOKENS NFT ====================
    
    struct NFT {
        uint256 tokenId;
        string nombre;
        string uri;
        address propietario;
        uint256 precio;
        bool enVenta;
    }
    
    mapping(uint256 => NFT) public nfts;
    mapping(address => uint256[]) public nftsDelPropietario;
    uint256 public contadorNFTs;
    
    event NFTCreado(uint256 tokenId, address propietario, string nombre);
    event NFTVendido(uint256 tokenId, address vendedor, address comprador, uint256 precio);
    
    // Crear NFT
    function crearNFT(string memory _nombre, string memory _uri) public returns (uint256) {
        uint256 nuevoId = contadorNFTs;
        
        nfts[nuevoId] = NFT({
            tokenId: nuevoId,
            nombre: _nombre,
            uri: _uri,
            propietario: msg.sender,
            precio: 0,
            enVenta: false
        });
        
        nftsDelPropietario[msg.sender].push(nuevoId);
        contadorNFTs++;
        
        emit NFTCreado(nuevoId, msg.sender, _nombre);
        return nuevoId;
    }
    
    // Poner NFT a la venta
    function ponerEnVenta(uint256 _tokenId, uint256 _precio) public {
        require(_tokenId < contadorNFTs, "NFT no existe");
        require(nfts[_tokenId].propietario == msg.sender, "No eres el propietario");
        require(_precio > 0, "Precio invalido");
        
        nfts[_tokenId].enVenta = true;
        nfts[_tokenId].precio = _precio;
    }
    
    // Comprar NFT
    function comprarNFT(uint256 _tokenId) public payable {
        require(_tokenId < contadorNFTs, "NFT no existe");
        require(nfts[_tokenId].enVenta, "NFT no esta en venta");
        require(msg.value >= nfts[_tokenId].precio, "Pago insuficiente");
        require(nfts[_tokenId].propietario != msg.sender, "Ya eres el propietario");
        
        address vendedor = nfts[_tokenId].propietario;
        uint256 precio = nfts[_tokenId].precio;
        
        // Transferir NFT
        nfts[_tokenId].propietario = msg.sender;
        nfts[_tokenId].enVenta = false;
        nfts[_tokenId].precio = 0;
        
        // Agregar a la lista del nuevo propietario
        nftsDelPropietario[msg.sender].push(_tokenId);
        
        // Transferir pago
        (bool success, ) = payable(vendedor).call{value: precio}("");
        require(success, "Transferencia fallida");
        
        emit NFTVendido(_tokenId, vendedor, msg.sender, precio);
    }
    
    // Obtener NFTs de un propietario
    function obtenerNFTsPropietario(address _propietario) public view returns (uint256[] memory) {
        return nftsDelPropietario[_propietario];
    }
    
    // ==================== EJERCICIO 4: SISTEMA DE VOTACIÓN AVANZADO ====================
    
    struct Candidato {
        string nombre;
        string propuesta;
        uint256 votos;
        bool activo;
    }
    
    struct Eleccion {
        string nombre;
        uint256 fechaInicio;
        uint256 fechaFin;
        bool activa;
        mapping(uint256 => Candidato) candidatos;
        uint256 totalCandidatos;
        mapping(address => bool) haVotado;
        uint256 totalVotos;
    }
    
    mapping(uint256 => Eleccion) public elecciones;
    uint256 public totalElecciones;
    address public admin;
    
    constructor() {
        admin = msg.sender;
    }
    
    modifier soloAdmin() {
        require(msg.sender == admin, "Solo el admin");
        _;
    }
    
    // Crear elección
    function crearEleccion(
        string memory _nombre,
        uint256 _duracionDias
    ) public soloAdmin returns (uint256) {
        uint256 nuevaId = totalElecciones;
        
        Eleccion storage nuevaEleccion = elecciones[nuevaId];
        nuevaEleccion.nombre = _nombre;
        nuevaEleccion.fechaInicio = block.timestamp;
        nuevaEleccion.fechaFin = block.timestamp + (_duracionDias * 1 days);
        nuevaEleccion.activa = true;
        nuevaEleccion.totalCandidatos = 0;
        nuevaEleccion.totalVotos = 0;
        
        totalElecciones++;
        return nuevaId;
    }
    
    // Agregar candidato
    function agregarCandidato(
        uint256 _idEleccion,
        string memory _nombre,
        string memory _propuesta
    ) public soloAdmin {
        require(_idEleccion < totalElecciones, "Eleccion no existe");
        require(elecciones[_idEleccion].activa, "Eleccion no activa");
        
        uint256 idCandidato = elecciones[_idEleccion].totalCandidatos;
        
        elecciones[_idEleccion].candidatos[idCandidato] = Candidato({
            nombre: _nombre,
            propuesta: _propuesta,
            votos: 0,
            activo: true
        });
        
        elecciones[_idEleccion].totalCandidatos++;
    }
    
    // Votar
    function votar(uint256 _idEleccion, uint256 _idCandidato) public {
        require(_idEleccion < totalElecciones, "Eleccion no existe");
        require(elecciones[_idEleccion].activa, "Eleccion no activa");
        require(block.timestamp <= elecciones[_idEleccion].fechaFin, "Eleccion finalizada");
        require(!elecciones[_idEleccion].haVotado[msg.sender], "Ya has votado");
        require(_idCandidato < elecciones[_idEleccion].totalCandidatos, "Candidato no existe");
        
        elecciones[_idEleccion].candidatos[_idCandidato].votos++;
        elecciones[_idEleccion].haVotado[msg.sender] = true;
        elecciones[_idEleccion].totalVotos++;
    }
    
    // Obtener información de candidato
    function obtenerCandidato(uint256 _idEleccion, uint256 _idCandidato) 
        public 
        view 
        returns (string memory, string memory, uint256, bool) 
    {
        require(_idEleccion < totalElecciones, "Eleccion no existe");
        require(_idCandidato < elecciones[_idEleccion].totalCandidatos, "Candidato no existe");
        
        Candidato memory candidato = elecciones[_idEleccion].candidatos[_idCandidato];
        return (candidato.nombre, candidato.propuesta, candidato.votos, candidato.activo);
    }
    
    // Cerrar elección
    function cerrarEleccion(uint256 _idEleccion) public soloAdmin {
        require(_idEleccion < totalElecciones, "Eleccion no existe");
        require(elecciones[_idEleccion].activa, "Eleccion ya cerrada");
        
        elecciones[_idEleccion].activa = false;
    }
    
    // Obtener ganador
    function obtenerGanador(uint256 _idEleccion) public view returns (string memory, uint256) {
        require(_idEleccion < totalElecciones, "Eleccion no existe");
        require(!elecciones[_idEleccion].activa, "Eleccion aun activa");
        
        uint256 maxVotos = 0;
        uint256 ganadorId = 0;
        
        for (uint256 i = 0; i < elecciones[_idEleccion].totalCandidatos; i++) {
            if (elecciones[_idEleccion].candidatos[i].votos > maxVotos) {
                maxVotos = elecciones[_idEleccion].candidatos[i].votos;
                ganadorId = i;
            }
        }
        
        return (elecciones[_idEleccion].candidatos[ganadorId].nombre, maxVotos);
    }
    
    // ==================== EJERCICIO 5: RED SOCIAL DESCENTRALIZADA ====================
    
    struct Publicacion {
        uint256 id;
        address autor;
        string contenido;
        uint256 timestamp;
        uint256 likes;
        mapping(address => bool) likesDe;
    }
    
    struct Perfil {
        string nombre;
        string bio;
        uint256[] publicaciones;
        uint256 seguidores;
        uint256 siguiendo;
    }
    
    mapping(address => Perfil) public perfiles;
    mapping(uint256 => Publicacion) public publicaciones;
    mapping(address => mapping(address => bool)) public siguiendo;
    uint256 public contadorPublicaciones;
    
    // Crear perfil
    function crearPerfil(string memory _nombre, string memory _bio) public {
        require(bytes(perfiles[msg.sender].nombre).length == 0, "Perfil ya existe");
        
        perfiles[msg.sender].nombre = _nombre;
        perfiles[msg.sender].bio = _bio;
        perfiles[msg.sender].seguidores = 0;
        perfiles[msg.sender].siguiendo = 0;
    }
    
    // Crear publicación
    function publicar(string memory _contenido) public {
        require(bytes(perfiles[msg.sender].nombre).length > 0, "Crea un perfil primero");
        
        uint256 nuevaId = contadorPublicaciones;
        
        Publicacion storage nuevaPublicacion = publicaciones[nuevaId];
        nuevaPublicacion.id = nuevaId;
        nuevaPublicacion.autor = msg.sender;
        nuevaPublicacion.contenido = _contenido;
        nuevaPublicacion.timestamp = block.timestamp;
        nuevaPublicacion.likes = 0;
        
        perfiles[msg.sender].publicaciones.push(nuevaId);
        contadorPublicaciones++;
    }
    
    // Dar like
    function darLike(uint256 _idPublicacion) public {
        require(_idPublicacion < contadorPublicaciones, "Publicacion no existe");
        require(!publicaciones[_idPublicacion].likesDe[msg.sender], "Ya diste like");
        
        publicaciones[_idPublicacion].likes++;
        publicaciones[_idPublicacion].likesDe[msg.sender] = true;
    }
    
    // Seguir usuario
    function seguir(address _usuario) public {
        require(_usuario != msg.sender, "No puedes seguirte a ti mismo");
        require(bytes(perfiles[_usuario].nombre).length > 0, "Usuario no existe");
        require(!siguiendo[msg.sender][_usuario], "Ya sigues a este usuario");
        
        siguiendo[msg.sender][_usuario] = true;
        perfiles[_usuario].seguidores++;
        perfiles[msg.sender].siguiendo++;
    }
    
    // Dejar de seguir
    function dejarDeSeguir(address _usuario) public {
        require(siguiendo[msg.sender][_usuario], "No sigues a este usuario");
        
        siguiendo[msg.sender][_usuario] = false;
        perfiles[_usuario].seguidores--;
        perfiles[msg.sender].siguiendo--;
    }
    
    // Obtener publicaciones de un usuario
    function obtenerPublicacionesUsuario(address _usuario) public view returns (uint256[] memory) {
        return perfiles[_usuario].publicaciones;
    }
}