<?php
require_once '../conexionMariposas.php';

    if (isset($_GET["accion"])){
        $accion = $_GET["accion"];
        switch ($accion) {
            case "insertar":
                insertaGenero();
                break;
            case "eliminar":
                eliminaGenero();
                break;
            case "actualizar":
                actualizaGenero();
                break;
            default:
                break;
        }
    }
    function insertaGenero(){
        global $server,$bd,$user,$password;
        
        $db = new PDO("mysql:host=".$server.";dbname=".$bd.";charset=utf8",$user, $password);
        if ($db->errorCode() != 0){
            die("No se ha podido conectar a la base de datos: " .  $db->errorInfo());
        }
        $gen = $_GET["gen"];
        $fam = $_GET["fam"];
        $consulta=$db->prepare("CALL sp_nuevo_genero(:gen,:fam);");
        $consulta->bindParam(":gen",$gen, PDO::PARAM_STR, 50);
        $consulta->bindParam(":fam",$fam, PDO::PARAM_STR, 50);
        $consulta->execute();
        echo "<p>Filas Afectadas: ".$consulta->rowCount()."<br>";
        if($consulta->errorCode()!=="00000"){
            echo "Codigo de Error: ".$consulta->errorCode()."</p>".
                    "<br>Mensaje de Error: ". print_r($consulta->errorInfo())."</p>";
        }
        $db = null;
        consultaGeneros("");
    }
    
    function actualizaGenero(){
        global $server,$bd,$user,$password;
        
        $db = new PDO("mysql:host=".$server.";dbname=".$bd.";charset=utf8",$user, $password);
        if ($db->errorCode() != 0){
            die("No se ha podido conectar a la base de datos: " .  $db->errorInfo());
        }
        
        if (isset($_GET["gen2"])){
            $gen1 = $_GET["gen1"];
            $gen2 = $_GET["gen2"];
            $fam = $_GET["fam"];
            $consulta=$db->prepare("CALL sp_actualiza_genero(:gen1,:gen2,:fam);");
            $consulta->bindParam(":gen1",$gen1, PDO::PARAM_STR, 50);
            $consulta->bindParam(":gen2",$gen2, PDO::PARAM_STR, 50);
            $consulta->bindParam(":fam",$fam, PDO::PARAM_STR, 50);
            $consulta->execute();
            echo "<p>Filas Afectadas: ".$consulta->rowCount()."<br>";
            if($consulta->errorCode()!=="00000"){
                echo "Codigo de Error: ".$consulta->errorCode().
                        "<br>Mensaje de Error: ". print_r($consulta->errorInfo())."</p>";
            }
            $db = null;
            consultaGeneros("");   
            
        }else{
            consultaGenerosActualizar($_GET["gen"]);
        }
    }
    
    function eliminaGenero(){
        global $server,$bd,$user,$password;
        
        $db = new PDO("mysql:host=".$server.";dbname=".$bd.";charset=utf8",$user, $password);
        if ($db->errorCode() != 0){
            die("No se ha podido conectar a la base de datos: " .  $db->errorInfo());
        }
        $gen = $_GET["gen"];
        $consulta=$db->prepare("CALL sp_elimina_genero(:gen);");
        $consulta->bindParam(":gen",$gen, PDO::PARAM_STR, 50);
        $consulta->execute();
        
        if($consulta->errorCode()!=="00000"){
            echo "Codigo de Error al Eliminar la Fila: ".$consulta->errorCode()."</p>";
        }else{
            echo "Fila eliminada Correctamente";
        }
        $db = null;
        consultaGeneros("");
    }
    
    function consultaGenerosActualizar($gen){
        global $server,$bd,$user,$password;
        $db = new PDO("mysql:host=".$server.";dbname=".$bd.";charset=utf8",$user, $password);

        if ($db->errorCode() != 0){
            die("No se ha podido conectar a la base de datos: " .  $db->errorInfo());
        }
        $consulta=$db->prepare("CALL sp_get_generos(:gen);");
        $consulta->bindParam(":gen",$gen, PDO::PARAM_STR, 50);
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
                <td><input type="text" name="gen" id="gen" class="textEntry" 
                           placeholder="Genero" maxlength="50"
                           value="<?php echo $filas[0]["GENERO"];?>">
                            <input type="text" name="geno" id="geno" class="oculto" 
                           placeholder="Genero" maxlength="50"
                           value="<?php echo $filas[0]["GENERO"];?>"></td>
                <td><input type="text" name="fam" id="fam" class="textEntry" 
                           placeholder="Familia" maxlength="50"
                           value="<?php echo $filas[0]["FAMILIA"];?>"></td>
                <td colspan="1"><input type="button" value="Actualizar" onclick="actualizaGenero();"></td>
            
            </tr>
    </table>
        <?php
    }
    
    function consultaGeneros($gen){
        global $server,$bd,$user,$password;
        $db = new PDO("mysql:host=".$server.";dbname=".$bd.";charset=utf8",$user, $password);

        if ($db->errorCode() != 0){
            die("No se ha podido conectar a la base de datos: " .  $db->errorInfo());
        }
        $consulta=$db->prepare("CALL sp_get_generos(:gen);");
        $consulta->bindParam(":gen",$gen, PDO::PARAM_STR, 50);
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
                    "cls_generos.php?accion=eliminar&gen={$fila["GENERO"]}");' value='ELIMINAR'>
                </td> 
                <td><input type='button' 
                    onclick='consulta("cls_generos.php?accion=actualizar&gen={$fila["GENERO"]}");'
                        value="ACTUALIZAR"></td>
HTML;
            echo "</tr>";
        }
        ?>
            <tr>
                <td><input type="text" name="gen" id="gen" class="textEntry" 
                           placeholder="Genero" maxlength="25">
                <td><input type="text" name="fam" id="fam" class="textEntry" 
                           placeholder="Familia" maxlength="50"></td>
                <td colspan="2"><input type="button" value="Agregar" onclick="insertaGenero();"></td>
            
            </tr>
    </table>
        <?php
    }
?>