<?php
require_once '../conexionMariposas.php';

    if (isset($_GET["accion"])){
        $accion = $_GET["accion"];
        switch ($accion) {
            case "insertar":
                insertaZona();
                break;
            case "eliminar":
                eliminaZona();
                break;
            case "actualizar":
                actualizaZona();
                break;
            default:
                break;
        }
    }
    function insertaZona(){
        global $server,$bd,$user,$password;
        
        $db = new PDO("mysql:host=".$server.";dbname=".$bd.";charset=utf8",$user, $password);
        if ($db->errorCode() != 0){
            die("No se ha podido conectar a la base de datos: " .  $db->errorInfo());
        }
        $zna = $_GET["zna"];
        $pais = $_GET["pais"];
        $rgn = $_GET["rgn"];
        $consulta=$db->prepare("CALL sp_nueva_zona(:zna,:pais,:rgn);");
        $consulta->bindParam(":zna",$zna, PDO::PARAM_STR, 25);
        $consulta->bindParam(":pais",$pais, PDO::PARAM_STR, 50);
        $consulta->bindParam(":rgn",$rgn, PDO::PARAM_STR, 50);
        $consulta->execute();
        echo "<p>Filas Afectadas: ".$consulta->rowCount()."<br>";
        if($consulta->errorCode()!=="00000"){
            echo "Codigo de Error: ".$consulta->errorCode()."</p>".
                    "<br>Mensaje de Error: ". print_r($consulta->errorInfo())."</p>";
        }
        $db = null;
        consultaZonas("");
    }
    
    function actualizaZona(){
        global $server,$bd,$user,$password;
        
        $db = new PDO("mysql:host=".$server.";dbname=".$bd.";charset=utf8",$user, $password);
        if ($db->errorCode() != 0){
            die("No se ha podido conectar a la base de datos: " .  $db->errorInfo());
        }
        
        if (isset($_GET["zna2"])){
            $zna1 = $_GET["zna1"];
            $zna2 = $_GET["zna2"];
            $pais = $_GET["pais"];
            $rgn = $_GET["rgn"];
            $consulta=$db->prepare("CALL sp_actualiza_zona(:zna1,:zna2,:pais,:rgn);");
            $consulta->bindParam(":zna1",$zna1, PDO::PARAM_STR, 25);
            $consulta->bindParam(":zna2",$zna2, PDO::PARAM_STR, 25);
            $consulta->bindParam(":pais",$pais, PDO::PARAM_STR, 50);
            $consulta->bindParam(":rgn",$rgn, PDO::PARAM_STR, 50);
            $consulta->execute();
            echo "<p>Filas Afectadas: ".$consulta->rowCount()."<br>";
            if($consulta->errorCode()!=="00000"){
                echo "Codigo de Error: ".$consulta->errorCode().
                        "<br>Mensaje de Error: ". print_r($consulta->errorInfo())."</p>";
            }
            $db = null;
            consultaZonas("");   
            
        }else{
            consultaZonasActualizar($_GET["zna"]);
        }
    }
    
    function eliminaZona(){
        global $server,$bd,$user,$password;
        
        $db = new PDO("mysql:host=".$server.";dbname=".$bd.";charset=utf8",$user, $password);
        if ($db->errorCode() != 0){
            die("No se ha podido conectar a la base de datos: " .  $db->errorInfo());
        }
        $zna = $_GET["zna"];
        $consulta=$db->prepare("CALL sp_elimina_zona(:zna);");
        $consulta->bindParam(":zna",$zna, PDO::PARAM_STR, 25);
        $consulta->execute();
        
        if($consulta->errorCode()!=="00000"){
            echo "Codigo de Error al Eliminar la Fila: ".$consulta->errorCode()."</p>";
        }else{
            echo "Fila eliminada Correctamente";
        }
        $db = null;
        consultaZonas("");
    }
    
    function consultaZonasActualizar($zna){
        global $server,$bd,$user,$password;
        $db = new PDO("mysql:host=".$server.";dbname=".$bd.";charset=utf8",$user, $password);

        if ($db->errorCode() != 0){
            die("No se ha podido conectar a la base de datos: " .  $db->errorInfo());
        }
        $consulta=$db->prepare("CALL sp_get_zonas(:zna);");
        $consulta->bindParam(":zna",$zna, PDO::PARAM_STR, 25);
        $consulta->execute();
        $filas=$consulta->fetchAll(PDO::FETCH_ASSOC);
        
        tablaActualizar($filas);
        $db = null;
    }
    
    function tablaActualizar($filas){
        ?><table border=2 width=100% id="datos1"><tr><?php
        foreach($filas[0] as $indice => $valor){
            echo "<td>". $indice ."</td>";
        }
        
        ?><td colspan="1">ADMINISTRACI&Oacute;N</td></tr><?php
                
        ?>
            <tr>
                <td><input type="text" name="zna" id="zna" class="textEntry" 
                           placeholder="Zona" maxlength="25"
                           value="<?php echo $filas[0]["ZONA"];?>">
                            <input type="text" name="znao" id="znao" class="oculto" 
                           placeholder="Zona" maxlength="25"
                           value="<?php echo $filas[0]["ZONA"];?>"></td>
                <td><input type="text" name="pais" id="pais" class="textEntry" 
                           placeholder="Pais" maxlength="50"
                           value="<?php echo $filas[0]["PAIS"];?>"></td>
                <td><input type="text" name="rgn" id="rgn" class="textEntry" 
                           placeholder="Region" maxlength="50"
                           value="<?php echo $filas[0]["REGION"];?>"></td>
                <td colspan="1"><input type="button" value="Actualizar" onclick="actualizaZona();"></td>
            
            </tr>
    </table>
        <?php
    }
    
    function consultaZonas($zna){
        global $server,$bd,$user,$password;
        $db = new PDO("mysql:host=".$server.";dbname=".$bd.";charset=utf8",$user, $password);

        if ($db->errorCode() != 0){
            die("No se ha podido conectar a la base de datos: " .  $db->errorInfo());
        }
        $consulta=$db->prepare("CALL sp_get_zonas(:zna);");
        $consulta->bindParam(":zna",$zna, PDO::PARAM_STR, 25);
        $consulta->execute();
        $filas=$consulta->fetchAll(PDO::FETCH_ASSOC);
        tabla($filas);
        $db = null;
    }
    
    function tabla($filas){
        ?><table border=2 width=100% id="datos1"><tr><?php
         
        foreach($filas[0] as $indice => $valor){
            echo "<td>". $indice ."</td>";
        }
        
        ?><td colspan="2">ADMINISTRACI&Oacute;N</td></tr><?php
        
        foreach ($filas as $fila){
            echo "<tr>";
            foreach ($fila as $columna) {
                echo "<td>".utf8_encode($columna)."</td>";          
            }
            echo <<<HTML
                <td><input type='button' onclick='consulta(
                    "cls_zonas.php?accion=eliminar&zna={$fila["ZONA"]}");' value='ELIMINAR'>
                </td> 
                <td><input type='button' 
                    onclick='consulta("cls_zonas.php?accion=actualizar&zna={$fila["ZONA"]}");'
                        value="ACTUALIZAR"></td>
HTML;
            echo "</tr>";
        }
        ?>
            <tr>
                <td><input type="text" name="zna" id="zna" class="textEntry" 
                           placeholder="Zona" maxlength="25">
                <td><input type="text" name="pais" id="pais" class="textEntry" 
                           placeholder="Pais" maxlength="50"></td>
                <td><input type="text" name="rgn" id="rgn" class="textEntry" 
                           placeholder="Region" maxlength="50"></td>
                <td colspan="2"><input type="button" value="Agregar" onclick="insertaZona();"></td>
            
            </tr>
    </table>
        <?php
    }
?>