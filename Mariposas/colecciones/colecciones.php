<?php
    $titulo="Colecciones - Mariposas";
    $maindir="../";
    require_once $maindir . "conexionMariposas.php";
    require_once $maindir . "encabezado.php";
    require_once "cls_colecciones.php";

?>

<div class="full_width clear" id="datos2">
<fieldset><legend>Datos de Colecciones</legend>
    <div class="full_width clear" id="datos">
<?php
    consultaColecciones("");
?>
    </div>
</fieldset>
</div>

<script type="text/javascript">
    function insertaColeccion(){
        var dni = document.getElementById("dni").value;
        var ptl = document.getElementById("ptl").value;
        var fin = document.getElementById("fin").value;
        
        //VALIDACIONES
        var resultado = ""; 
        var esValido = true;
        
        if(dni.length <15){
            resultado += "- Rellene correctamente el Coleccionista\n";
            esValido=false;
        }
        if(ptl < 0){
            resultado += "- El Precio Total Debe ser Mayor o Igual que Cero\n";
            esValido=false;
        }
        if(fin.length <2){
            resultado += "- Rellene correctamente la Fecha Inicial\n";
            esValido=false;
        }
        
        if (!esValido){
            alert(resultado);
            return;
        }
            var cadena = "cls_colecciones.php?accion=insertar" +
                    "&ptl=" + encodeURIComponent(ptl)+
                    "&fin=" + encodeURIComponent(fin) +
                    "&dni=" + encodeURIComponent(dni);
            consulta(cadena);
    }
    
    function actualizaColeccion(){
        var dnio = document.getElementById("dnio").value;
        var dni = document.getElementById("dni").value;
        var ptl = document.getElementById("ptl").value;
        var fin = document.getElementById("fin").value;
        
        //VALIDACIONES
        var resultado = ""; 
        var esValido = true;
        
        if(ptl < 0){
            resultado += "- El Precio Total Debe ser Mayor o Igual que Cero\n";
            esValido=false;
        }
        if(dni.length <15){
            resultado += "- Rellene correctamente el Nombre del Coleccionsta\n";
            esValido=false;
        }
        if(fin.length <2){
            resultado += "- Rellene correctamente la Fecha Inicial\n";
            esValido=false;
        }
        
        if (!esValido){
            alert(resultado);
            return;
        }
            var cadena = "cls_colecciones.php?accion=actualizar" +
                    "&dni1=" + encodeURIComponent(dnio) +
                    "&dni2=" + encodeURIComponent(dni) +
                    "&fin=" + encodeURIComponent(fin) +
                    "&ptl=" + encodeURIComponent(ptl);
            consulta(cadena);
    }
</script>

<?php
    require_once "../pie.php";
?>