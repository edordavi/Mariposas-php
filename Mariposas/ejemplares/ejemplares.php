<?php
    $titulo="Ejemplares - Mariposas";
    $maindir="../";
    require_once $maindir . "conexionMariposas.php";
    require_once $maindir . "encabezado.php";
    require_once "cls_ejemplares.php";

?>

<div class="full_width clear" id="datos2">
<fieldset><legend>Datos de Ejemplares</legend>
    <p>Seleccione el tipo de ejemplar a mostrar:<br>
        <select id="tip" name="tip" class="textEntry" onchange="consultaEjemplar();">
            <option value="" selected>Cualquiera</option>
            <option value="C">Coleccionada</option>
            <option value="O">Observada</option>
        </select>
    </p>
    <div class="full_width clear" id="datos">

    </div>
</fieldset>
</div>

<script type="text/javascript">
    consultaEjemplar();
    
    function consultaEjemplar(){        
        var tipo = document.getElementById("tip").value;
        
            var cadena = "cls_ejemplares.php?accion=consultar" +
                    "&tip=" + encodeURIComponent(tipo);
            consulta(cadena);
    }

    function insertaEjemplarCol(){
        var tipo = document.getElementById("tip").value;
        var zna = document.getElementById("zna").value;
        var fcp = document.getElementById("fcp").value;
        var esp = document.getElementById("esp").value;
        var cap = document.getElementById("cap").value;
        var nco = document.getElementById("nco").value;
        var prc = document.getElementById("prc").value;
        var col = document.getElementById("col").value;
        
        //VALIDACIONES
        var resultado = ""; 
        var esValido = true;
        
        if(tipo.length !== 1 && tipo.toUpperCase()!=='C'){
            resultado += "- Rellene correctamente el Tipo de Ejemplar\n";
            esValido=false;
        }
        if(zna.length < 2){
            resultado += "- Rellene correctamente la Zona\n";
            esValido=false;
        }
        if(fcp.length <8){
            resultado += "- Rellene correctamente la Fecha de Captura\n";
            esValido=false;
        }
        if(esp.length <2){
            resultado += "- Rellene correctamente la Especie\n";
            esValido=false;
        }
        if(cap.length <15){
            resultado += "- Rellene correctamente el DNI del Capturador\n";
            esValido=false;
        }
        if(nco.length <2){
            resultado += "- Rellene correctamente el Nombre Comun\n";
            esValido=false;
        }
        if(prc<0){
            resultado += "- Rellene correctamente el Precio\n";
            esValido=false;
        }
        if(col.length <2){
            resultado += "- Rellene correctamente el DNI del Coleccionista\n";
            esValido=false;
        }
        if (!esValido){
            alert(resultado);
            return;
        }
            var cadena = "cls_ejemplares.php?accion=insertarcol" +
                    "&zna=" + encodeURIComponent(zna)+
                    "&fcp=" + encodeURIComponent(fcp) +
                    "&cap=" + encodeURIComponent(cap) +
                    "&nco=" + encodeURIComponent(nco) +
                    "&prc=" + encodeURIComponent(prc) +
                    "&col=" + encodeURIComponent(col) +
                    "&tip=" + encodeURIComponent(tipo) +
                    "&esp=" + encodeURIComponent(esp);
            consulta(cadena);
    }
    
    function insertaEjemplarObs(){
        var tipo = document.getElementById("tip").value;
        var zna = document.getElementById("zna").value;
        var fcp = document.getElementById("fcp").value;
        var esp = document.getElementById("esp").value;
        var cap = document.getElementById("cap").value;
        var nco = document.getElementById("nco").value;
        var tmp = document.getElementById("tmp").value;
        var obs = document.getElementById("obs").value;
        
        //VALIDACIONES
        var resultado = ""; 
        var esValido = true;
        
        if(tipo.length !== 1 && tipo.toUpperCase()!=='O'){
            resultado += "- Rellene correctamente el Tipo de Ejemplar\n";
            esValido=false;
        }
        if(zna.length < 2){
            resultado += "- Rellene correctamente la Zona\n";
            esValido=false;
        }
        if(fcp.length <8){
            resultado += "- Rellene correctamente la Fecha de Captura\n";
            esValido=false;
        }
        if(esp.length <2){
            resultado += "- Rellene correctamente la Especie\n";
            esValido=false;
        }
        if(cap.length <15){
            resultado += "- Rellene correctamente el DNI del Capturador\n";
            esValido=false;
        }
        if(nco.length <2){
            resultado += "- Rellene correctamente el Nombre Comun\n";
            esValido=false;
        }
        if(tmp<0){
            resultado += "- Rellene correctamente el Tiempo\n";
            esValido=false;
        }
        if(obs.length <2){
            resultado += "- Rellene correctamente las observaciones\n";
            esValido=false;
        }
        if (!esValido){
            alert(resultado);
            return;
        }
            var cadena = "cls_ejemplares.php?accion=insertarobs" +
                    "&zna=" + encodeURIComponent(zna)+
                    "&fcp=" + encodeURIComponent(fcp) +
                    "&cap=" + encodeURIComponent(cap) +
                    "&nco=" + encodeURIComponent(nco) +
                    "&tmp=" + encodeURIComponent(tmp) +
                    "&obs=" + encodeURIComponent(obs) +
                    "&tip=" + encodeURIComponent(tipo) +
                    "&esp=" + encodeURIComponent(esp);
            consulta(cadena);
    }
    
    function actualizaEjemplar(){
        var tipo = document.getElementById("tip").value;
        var zna = document.getElementById("zna1").value;
        var fcp = document.getElementById("fcp1").value;
        var esp = document.getElementById("esp1").value;
        var zna2 = document.getElementById("zna2").value;
        var fcp2 = document.getElementById("fcp2").value;
        var esp2 = document.getElementById("esp2").value;
        var cap = document.getElementById("cap").value;
        var nco = document.getElementById("nco").value;
        var tmp = document.getElementById("tip1").value;
        var obs = document.getElementById("tip2").value;
        
        //VALIDACIONES
        var resultado = ""; 
        var esValido = true;

        if(!(tipo.toUpperCase()==='O' || tipo.toUpperCase()==='C')){
            resultado += "- Rellene correctamente el Tipo de Ejemplar\n";
            esValido=false;
        }
        if(zna.length < 2){
            resultado += "- Rellene correctamente la Zona\n";
            esValido=false;
        }
        if(fcp.length <8){
            resultado += "- Rellene correctamente la Fecha de Captura\n";
            esValido=false;
        }
        if(esp.length <2){
            resultado += "- Rellene correctamente la Especie\n";
            esValido=false;
        }
        if(cap.length <15){
            resultado += "- Rellene correctamente el DNI del Capturador\n";
            esValido=false;
        }
        if(nco.length <2){
            resultado += "- Rellene correctamente el Nombre Comun\n";
            esValido=false;
        }
        if(tmp<0){
            resultado += "- Rellene correctamente el Tiempo\n";
            esValido=false;
        }
        if(obs.length <2){
            resultado += "- Rellene correctamente las observaciones\n";
            esValido=false;
        }
        
        if (!esValido){
            alert(resultado);
            return;
        }
            var cadena = "cls_ejemplares.php?accion=actualizar" +
                    "&zna1=" + encodeURIComponent(zna)+
                    "&fcp1=" + encodeURIComponent(fcp) +
                    "&zna2=" + encodeURIComponent(zna2)+
                    "&fcp2=" + encodeURIComponent(fcp2) +
                    "&esp2=" + encodeURIComponent(esp2) +
                    "&cap=" + encodeURIComponent(cap) +
                    "&nco=" + encodeURIComponent(nco) +
                    "&tip1=" + encodeURIComponent(tmp) +
                    "&tip2=" + encodeURIComponent(obs) +
                    "&tip=" + encodeURIComponent(tipo) +
                    "&esp1=" + encodeURIComponent(esp);
            consulta(cadena);
    }
</script>

<?php
    require_once "../pie.php";
?>