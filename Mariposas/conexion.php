<?php

class coneccion {

    private $server;
    private $usuario;
    private $clave;
    private $base_datos;
    private $conexion;

    function __construct($server, $base_datos, $usuario, $clave) {
        $this->server = $server;
        $this->base_datos = $base_datos;
        $this->usuario = $usuario;
        $this->clave = $clave;
    }

    function conectar() {
        $this->conexion = new PDO("mysql:host=localhost;dbname=Mariposas;charset=utf8", "eavila", "emildaniel");
    }
    
    
    public function getConexion() {
        return $this->conexion;
    }

    public function setConexion($conexion) {
        $this->conexion = $conexion;
    }

        //GETTERS
    public function getServer() {
        return $this->server;
    }

    public function getUsuario() {
        return $this->usuario;
    }

    public function getClave() {
        return $this->clave;
    }

    public function getBase_datos() {
        return $this->base_datos;
    }

    //SETTERS
    public function setServer($server) {
        $this->server = $server;
    }

    public function setUsuario($usuario) {
        $this->usuario = $usuario;
    }

    public function setClave($clave) {
        $this->clave = $clave;
    }

    public function setBase_datos($base_datos) {
        $this->base_datos = $base_datos;
    }

}

?>
