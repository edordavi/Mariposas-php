<?php
require_once '../conexionMariposas.php';

    if (isset($_GET["accion"])){
        $accion = $_GET["accion"];
        switch ($accion) {
            case "insertar":
                insertaEspecie();
                break;
            case "eliminar":
                eliminaEspecie();
                break;
            case "actualizar":
                actualizaEspecie();
                break;
            default:
                break;
        }
    }
    function insertaEspecie(){
        global $server,$bd,$user,$password;
        
        $db = new PDO("mysql:host=".$server.";dbname=".$bd.";charset=utf8",$user, $password);
        if ($db->errorCode() != 0){
            die("No se ha podido conectar a la base de datos: " .  $db->errorInfo());
        }
        $esp = $_GET["esp"];
        $gen = $_GET["gen"];
        $nci = $_GET["nci"];
        $consulta=$db->prepare("CALL sp_nueva_especie(:esp,:gen,:nci);");
        $consulta->bindParam(":esp",$esp, PDO::PARAM_STR, 50);
        $consulta->bindParam(":gen",$gen, PDO::PARAM_STR, 50);
        $consulta->bindParam(":nci",$nci, PDO::PARAM_STR, 150);
        $consulta->execute();
        echo "<p>Filas Afectadas: ".$consulta->rowCount()."<br>";
        if($consulta->errorCode()!=="00000"){
            echo "Codigo de Error: ".$consulta->errorCode()."</p>".
                    "<br>Mensaje de Error: ". print_r($consulta->errorInfo())."</p>";
        }
        $db = null;
        consultaEspecies("");
    }
    
    function actualizaEspecie(){
        global $server,$bd,$user,$password;
        
        $db = new PDO("mysql:host=".$server.";dbname=".$bd.";charset=utf8",$user, $password);
        if ($db->errorCode() != 0){
            die("No se ha podido conectar a la base de datos: " .  $db->errorInfo());
        }
        
        if (isset($_GET["esp2"])){
            $esp1 = $_GET["esp1"];
            $esp2 = $_GET["esp2"];
            $gen = $_GET["gen"];
            $nci = $_GET["nci"];
            $consulta=$db->prepare("CALL sp_actualiza_especie(:esp1,:esp2,:gen,:nci);");
            $consulta->bindParam(":esp1",$esp1, PDO::PARAM_STR, 50);
            $consulta->bindParam(":esp2",$esp2, PDO::PARAM_STR, 50);
            $consulta->bindParam(":gen",$gen, PDO::PARAM_STR, 50);
            $consulta->bindParam(":nci",$nci, PDO::PARAM_STR, 150);
            $consulta->execute();
            echo "<p>Filas Afectadas: ".$consulta->rowCount()."<br>";
            if($consulta->errorCode()!=="00000"){
                echo "Codigo de Error: ".$consulta->errorCode().
                        "<br>Mensaje de Error: ". print_r($consulta->errorInfo())."</p>";
            }
            $db = null;
            consultaEspecies("");   
            
        }else{
            consultaEspeciesActualizar($_GET["esp"]);
        }
    }
    
    function eliminaEspecie(){
        global $server,$bd,$user,$password;
        
        $db = new PDO("mysql:host=".$server.";dbname=".$bd.";charset=utf8",$user, $password);
        if ($db->errorCode() != 0){
            die("No se ha podido conectar a la base de datos: " .  $db->errorInfo());
        }
        $esp = $_GET["esp"];
        $consulta=$db->prepare("CALL sp_elimina_especie(:esp);");
        $consulta->bindParam(":esp",$esp, PDO::PARAM_STR, 50);
        $consulta->execute();
        
        if($consulta->errorCode()!=="00000"){
            echo "Codigo de Error al Eliminar la Fila: ".$consulta->errorCode()."</p>";
        }else{
            echo "Fila eliminada Correctamente";
        }
        $db = null;
        consultaEspecies("");
    }
    
    function consultaEspeciesActualizar($esp){
        global $server,$bd,$user,$password;
        $db = new PDO("mysql:host=".$server.";dbname=".$bd.";charset=utf8",$user, $password);

        if ($db->errorCode() != 0){
            die("No se ha podido conectar a la base de datos: " .  $db->errorInfo());
        }
        $consulta=$db->prepare("CALL sp_get_especies(:esp);");
        $consulta->bindParam(":esp",$esp, PDO::PARAM_STR, 50);
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
                <td><input type="text" name="esp" id="esp" class="textEntry" 
                           placeholder="Especie" maxlength="50"
                           value="<?php echo $filas[0]["ESPECIE"];?>">
                            <input type="text" name="espo" id="espo" class="oculto" 
                           placeholder="Especie" maxlength="50"
                           value="<?php echo $filas[0]["ESPECIE"];?>"></td>
                <td><input type="text" name="gen" id="gen" class="textEntry" 
                           placeholder="Genero" maxlength="50"
                           value="<?php echo $filas[0]["GENERO"];?>"></td>
                <td><input type="text" name="nci" id="nci" class="textEntry" 
                           placeholder="Nombre Cientifico" maxlength="150"
                           value="<?php echo $filas[0]["NOMBRE CIENTIFICO"];?>"></td>
                <td colspan="1"><input type="button" value="Actualizar" onclick="actualizaEspecie();"></td>
            
            </tr>
    </table>
        <?php
    }
    
    function consultaEspecies($esp){
        global $server,$bd,$user,$password;
        $db = new PDO("mysql:host=".$server.";dbname=".$bd.";charset=utf8",$user, $password);

        if ($db->errorCode() != 0){
            die("No se ha podido conectar a la base de datos: " .  $db->errorInfo());
        }
        $consulta=$db->prepare("CALL sp_get_especies(:esp);");
        $consulta->bindParam(":esp",$esp, PDO::PARAM_STR, 50);
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
                    "cls_especies.php?accion=eliminar&esp={$fila["ESPECIE"]}");' value='ELIMINAR'>
                </td> 
                <td><input type='button' 
                    onclick='consulta("cls_especies.php?accion=actualizar&esp={$fila["ESPECIE"]}");'
                        value="ACTUALIZAR"></td>
HTML;
            echo "</tr>";
        }
        ?>
            <tr>
                <td><input type="text" name="esp" id="esp" class="textEntry" 
                           placeholder="Especie" maxlength="25">
                <td><input type="text" name="gen" id="gen" class="textEntry" 
                           placeholder="Genero" maxlength="50"></td>
                <td><input type="text" name="nci" id="nci" class="textEntry" 
                           placeholder="Nombre Cientifico" maxlength="150"></td>
                <td colspan="2"><input type="button" value="Agregar" onclick="insertaEspecie();"></td>
            
            </tr>
    </table>
        <?php
    }
?>