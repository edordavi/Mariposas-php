<?php
    $titulo="Zonas - Mariposas";
    $maindir="../";
    require_once $maindir . "conexionMariposas.php";
    require_once $maindir . "encabezado.php";
    require_once "cls_zonas.php";

?>

<div class="full_width clear" id="datos2">
<fieldset><legend>Datos de Zonas</legend>
    <div class="full_width clear" id="datos">
<?php
    consultaZonas("");
?>
    </div>
</fieldset>
</div>

<script type="text/javascript">
    function insertaZona(){
        var zna = document.getElementById("zna").value;
        var pais = document.getElementById("pais").value;
        var rgn = document.getElementById("rgn").value;
        
        //VALIDACIONES
        var resultado = ""; 
        var esValido = true;
        
        if(zna.length <2){
            resultado += "- Rellene correctamente el Nombre de Zona\n";
            esValido=false;
        }
        if(pais.length <2){
            resultado += "- Rellene correctamente el Nombre de Pais\n";
            esValido=false;
        }
        if(rgn.length <2){
            resultado += "- Rellene correctamente el Nombre de Region\n";
            esValido=false;
        }
        
        if (!esValido){
            alert(resultado);
            return;
        }
            var cadena = "cls_zonas.php?accion=" + encodeURIComponent("insertar") +
                    "&zna=" + encodeURIComponent(zna)+
                    "&pais=" + encodeURIComponent(pais) +
                    "&rgn=" + encodeURIComponent(rgn);
            consulta(cadena);
    }
    
    function actualizaZona(){
        var znao = document.getElementById("znao").value;
        var zna = document.getElementById("zna").value;
        var pais = document.getElementById("pais").value;
        var rgn = document.getElementById("rgn").value;
        
        //VALIDACIONES
        var resultado = ""; 
        var esValido = true;
        
        if(zna.length <2){
            resultado += "- Rellene correctamente el Nombre de Zona\n";
            esValido=false;
        }
        if(pais.length <2){
            resultado += "- Rellene correctamente el Nombre de Pais\n";
            esValido=false;
        }
        if(rgn.length <2){
            resultado += "- Rellene correctamente el Nombre de Region\n";
            esValido=false;
        }
        
        if (!esValido){
            alert(resultado);
            return;
        }
            var cadena = "cls_zonas.php?accion=" + encodeURIComponent("actualizar") +
                    "&zna1=" + encodeURIComponent(znao) +
                    "&zna2=" + encodeURIComponent(zna) +
                    "&pais=" + encodeURIComponent(pais) +
                    "&rgn=" + encodeURIComponent(rgn);
            consulta(cadena);
    }
</script>

<?php
    require_once "../pie.php";
?>