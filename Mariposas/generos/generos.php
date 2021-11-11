<?php
    $titulo="Generos - Mariposas";
    $maindir="../";
    require_once $maindir . "conexionMariposas.php";
    require_once $maindir . "encabezado.php";
    require_once "cls_generos.php";

?>

<div class="full_width clear" id="datos2">
<fieldset><legend>Datos de Generos</legend>
    <div class="full_width clear" id="datos">
<?php
    consultaGeneros("");
?>
    </div>
</fieldset>
</div>

<script type="text/javascript">
    function insertaGenero(){
        var gen = document.getElementById("gen").value;
        var fam = document.getElementById("fam").value;
        
        //VALIDACIONES
        var resultado = ""; 
        var esValido = true;
        
        if(gen.length <2){
            resultado += "- Rellene correctamente el Nombre de Genero\n";
            esValido=false;
        }
        if(fam.length <2){
            resultado += "- Rellene correctamente el Nombre de Familia\n";
            esValido=false;
        }
        
        if (!esValido){
            alert(resultado);
            return;
        }
            var cadena = "cls_generos.php?accion=" + encodeURIComponent("insertar") +
                    "&gen=" + encodeURIComponent(gen)+
                    "&fam=" + encodeURIComponent(fam);
            consulta(cadena);
    }
    
    function actualizaGenero(){
        var geno = document.getElementById("geno").value;
        var gen = document.getElementById("gen").value;
        var fam = document.getElementById("fam").value;
        
        //VALIDACIONES
        var resultado = ""; 
        var esValido = true;
        
        if(gen.length <2){
            resultado += "- Rellene correctamente el Nombre de Genero\n";
            esValido=false;
        }
        if(fam.length <2){
            resultado += "- Rellene correctamente el Nombre de Familia\n";
            esValido=false;
        }
        
        if (!esValido){
            alert(resultado);
            return;
        }
            var cadena = "cls_generos.php?accion=" + encodeURIComponent("actualizar") +
                    "&gen1=" + encodeURIComponent(geno) +
                    "&gen2=" + encodeURIComponent(gen) +
                    "&fam=" + encodeURIComponent(fam);
            consulta(cadena);
    }
</script>

<?php
    require_once "../pie.php";
?>