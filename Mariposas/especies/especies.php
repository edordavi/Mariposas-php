<?php
    $titulo="Especies - Mariposas";
    $maindir="../";
    require_once $maindir . "conexionMariposas.php";
    require_once $maindir . "encabezado.php";
    require_once "cls_especies.php";

?>

<div class="full_width clear" id="datos2">
    <fieldset><legend>Datos de Especies</legend>
    <div class="full_width clear" id="datos">
<?php
    consultaEspecies("");
?>
    </div>
</fieldset>
</div>

<script type="text/javascript">
    function insertaEspecie(){
        var esp = document.getElementById("esp").value;
        var gen = document.getElementById("gen").value;
        var nci = document.getElementById("nci").value;
        
        //VALIDACIONES
        var resultado = ""; 
        var esValido = true;
        
        if(esp.length <2){
            resultado += "- Rellene correctamente el Nombre de Especie\n";
            esValido=false;
        }
        if(gen.length <2){
            resultado += "- Rellene correctamente el Nombre de Genero\n";
            esValido=false;
        }
        if(nci.length <2){
            resultado += "- Rellene correctamente el Nombre Cientifico\n";
            esValido=false;
        }
        
        if (!esValido){
            alert(resultado);
            return;
        }
            var cadena = "cls_especies.php?accion=" + encodeURIComponent("insertar") +
                    "&esp=" + encodeURIComponent(esp)+
                    "&nci=" + encodeURIComponent(nci) +
                    "&gen=" + encodeURIComponent(gen);
            consulta(cadena);
    }
    
    function actualizaEspecie(){
        var espo = document.getElementById("espo").value;
        var esp = document.getElementById("esp").value;
        var gen = document.getElementById("gen").value;
        var nci = document.getElementById("nci").value;
        
        //VALIDACIONES
        var resultado = ""; 
        var esValido = true;
        
        if(esp.length <2){
            resultado += "- Rellene correctamente el Nombre de Especie\n";
            esValido=false;
        }
        if(gen.length <2){
            resultado += "- Rellene correctamente el Nombre de Genero\n";
            esValido=false;
        }
        if(nci.length <2){
            resultado += "- Rellene correctamente el Nombre Cientifico\n";
            esValido=false;
        }
        
        if (!esValido){
            alert(resultado);
            return;
        }
            var cadena = "cls_especies.php?accion=" + encodeURIComponent("actualizar") +
                    "&esp1=" + encodeURIComponent(espo) +
                    "&esp2=" + encodeURIComponent(esp) +
                    "&nci=" + encodeURIComponent(nci) +
                    "&gen=" + encodeURIComponent(gen);
            consulta(cadena);
    }
</script>

<?php
    require_once "../pie.php";
?>