<?php
$titulo='Consulta Manipulaci&oacute;n #8';
require_once 'encabezado.php';

if (isset($_GET["resultado"]))
{
    echo $_GET["resultado"];
}
?>

<div class="full_width clear" id="datos">
<fieldset><legend>Consulta Manipulaci&oacute;n de Datos 008</legend>

    <?php
    
    $conexion=new mysqli("localhost", "eavila", "emildaniel","Mariposas");
    
    if ($conexion->connect_error != 0){
        die("No se ha podido conectar a la base de datos: " .  $conexion->connect_error);
    }
    
    $consulta = $conexion->prepare("CALL sp_personas_capturaron_sin_coleccion()");
    //$consulta->bind_param("s", "1999-04-30");
    $consulta->execute();
    $consulta->bind_result($dni,$nombre,$apellido);
    ?>
        <table border=2 width=100% id="datos1">
            <tr>
                <td><b>DNI</b></td>
                <td><b>NOMBRE</b></td>
                <td><b>APELLIDO</b></td>
            </tr>
    <?php 
    
    while($consulta->fetch()){
        
        echo "<tr>";
        echo "<td>".utf8_encode($dni)."</td>";
        echo "<td>".utf8_encode($nombre)."</td>";
        echo "<td>".utf8_encode($apellido)."</td>";
        
//        echo <<<HTML
//        <td><input type='button' onclick='viviendaconsulta(
//            "viveliminar.php?calle=$calle&numero=$numero");' value='ELIMINAR'>
//        </td> 
//        <td><input type='button' 
//            onclick='viviendaconsulta("vivactualizar.php?calle=$calle&numero=$numero");'
//                value="ACTUALIZAR"></td>'
//HTML;
        echo "</tr>";
    }
    $conexion->close();
    ?>
    </table>
</fieldset>
</div>
<script type="text/javascript">
    function viviendaconsulta(cadena)
    { 
    if (window.XMLHttpRequest)
      {// code for IE7+, Firefox, Chrome, Opera, Safari
      xmlhttp=new XMLHttpRequest();
      }
    else
      {// code for IE6, IE5
      xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
      }
    xmlhttp.onreadystatechange=function()
      {
      if (xmlhttp.readyState==4 && xmlhttp.status==200)
        {
         document.getElementById("datos").innerHTML=xmlhttp.responseText;
        }
      }
    xmlhttp.open("GET",cadena,true);
    xmlhttp.send();
    }
    
    function insertaVivienda(){
        var calle = document.getElementById("calle").value;
        var numero = document.getElementById("numero").value;
        var tipo_v = document.getElementById("tipo_v").value;
        var codigo_p = document.getElementById("codigo_p").value;
        var metros = document.getElementById("metros").value;
        var od_v = document.getElementById("od_v").value;
        var nombre_z = document.getElementById("nombre_z").value;
        
        if(calle!="" && numero != "" && tipo_v!="" && codigo_p!="" && metros!=""
            && od_v!=""){
            var cadena = "vivinsertar.php?calle=" + encodeURIComponent(calle) +
                    "&numero="+numero +
                    "&tipo_v=" + tipo_v + "&codigo_p=" + codigo_p +
                    "&metros="+metros+
                    "&od_v=" + encodeURIComponent(od_v) + 
                    "&nombre_z=" + encodeURIComponent(nombre_z)
            viviendaconsulta(cadena);
        }
        
    }
    
    function modificaVivienda(){
        var calle = document.getElementById("calle").value;
        var callev = document.getElementById("callev").value;
        var numero = document.getElementById("numero").value;
        var numerov = document.getElementById("numerov").value;
        var tipo_v = document.getElementById("tipo_v").value;
        var codigo_p = document.getElementById("codigo_p").value;
        var metros = document.getElementById("metros").value;
        var od_v = document.getElementById("od_v").value;
        var nombre_z = document.getElementById("nombre_z").value;
        
        if(calle!="" && numero != "" && tipo_v!="" && codigo_p!="" && metros!=""
            && od_v!=""){
            var cadena = "vivactualizar.php?calle=" + encodeURIComponent(calle) +
                    "&numero="+numero +
                    "&tipo_v=" + tipo_v + "&codigo_p=" + codigo_p +
                    "&metros="+metros+
                    "&od_v=" + encodeURIComponent(od_v) + 
                    "&nombre_z=" + encodeURIComponent(nombre_z)+
                    "&callev=" + encodeURIComponent(callev) +
                    "&numerov="+numerov;
            viviendaconsulta(cadena);
        }
        
    }
</script>


<?php
 require_once 'pie.php';
 ?>
