<?php
require_once '../conexionMariposas.php';

    if (isset($_GET["accion"])){
        $accion = $_GET["accion"];
        switch ($accion) {
            case "insertar":
                insertaColeccion();
                break;
            case "eliminar":
                eliminaColeccion();
                break;
            case "actualizar":
                actualizaColeccion();
                break;
            default:
                break;
        }
    }
    function insertaColeccion(){
        global $server,$bd,$user,$password;
        
        $db = new PDO("mysql:host=".$server.";dbname=".$bd.";charset=utf8",$user, $password);
        if ($db->errorCode() != 0){
            die("No se ha podido conectar a la base de datos: " .  $db->errorInfo());
        }
        $dni = $_GET["dni"];
        $ptl = $_GET["ptl"];
        $fin = $_GET["fin"];
        $consulta=$db->prepare("CALL sp_nueva_coleccion(:dni,:fin);");
        $consulta->bindParam(":dni",$dni, PDO::PARAM_STR, 15);
        $consulta->bindParam(":fin",$fin);
        $consulta->execute();
        echo "<p>Filas Afectadas: ".$consulta->rowCount()."<br>";
        if($consulta->errorCode()!=="00000"){
            echo "Codigo de Error: ".$consulta->errorCode()."</p>".
                    "<br>Mensaje de Error: ". print_r($consulta->errorInfo())."</p>";
        }
        $db = null;
        consultaColecciones("");
    }
    
    function actualizaColeccion(){
        global $server,$bd,$user,$password;
        
        $db = new PDO("mysql:host=".$server.";dbname=".$bd.";charset=utf8",$user, $password);
        if ($db->errorCode() != 0){
            die("No se ha podido conectar a la base de datos: " .  $db->errorInfo());
        }
        
        if (isset($_GET["dni2"])){
            $dni1 = $_GET["dni1"];
            $dni2 = $_GET["dni2"];
            $ptl = $_GET["ptl"];
            $fin = $_GET["fin"];
            $consulta=$db->prepare("CALL sp_actualiza_coleccion(:dni1,:dni2,:fin);");
            $consulta->bindParam(":dni1",$dni1, PDO::PARAM_STR, 15);
            $consulta->bindParam(":dni2",$dni2, PDO::PARAM_STR, 15);
            $consulta->bindParam(":fin",$fin);
            $consulta->execute();
            echo "<p>Filas Afectadas: ".$consulta->rowCount()."<br>";
            if($consulta->errorCode()!=="00000"){
                echo "Codigo de Error: ".$consulta->errorCode().
                        "<br>Mensaje de Error: ". print_r($consulta->errorInfo())."</p>";
            }
            $db = null;
            consultaColecciones("");   
            
        }else{
            consultaColeccionesActualizar($_GET["dni"]);
        }
    }
    
    function eliminaColeccion(){
        global $server,$bd,$user,$password;
        
        $db = new PDO("mysql:host=".$server.";dbname=".$bd.";charset=utf8",$user, $password);
        if ($db->errorCode() != 0){
            die("No se ha podido conectar a la base de datos: " .  $db->errorInfo());
        }
        print_r($_GET);
        $dni = $_GET["dni"];
        $consulta=$db->prepare("CALL sp_elimina_coleccion(:dn);");
        $consulta->bindParam(":dn",$dni, PDO::PARAM_STR, 15);
        $consulta->execute();
        
        if($consulta->errorCode()!=="00000"){
            echo "Codigo de Error al Eliminar la Fila: ".$consulta->errorCode().
                        "<br>Mensaje de Error: ". print_r($consulta->errorInfo())."</p>";
        }else{
            echo "Fila eliminada Correctamente";
        }
        $db = null;
        consultaColecciones("");
    }
    
    function consultaColeccionesActualizar($dni){
        global $server,$bd,$user,$password;
        $db = new PDO("mysql:host=".$server.";dbname=".$bd.";charset=utf8",$user, $password);

        if ($db->errorCode() != 0){
            die("No se ha podido conectar a la base de datos: " .  $db->errorInfo());
        }
        $consulta=$db->prepare("CALL sp_get_colecciones(:dni);");
        $consulta->bindParam(":dni",$dni, PDO::PARAM_STR, 15);
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
                <td><input type="text" name="dni" id="dni" class="textEntry" 
                           placeholder="DNI Coleccionista" maxlength="15"
                           value="<?php echo $filas[0]["COLECCIONISTA"];?>">
                            <input type="text" name="dnio" id="dnio" class="oculto" 
                           placeholder="DNI Coleccionista" maxlength="15"
                           value="<?php echo $filas[0]["COLECCIONISTA"];?>"></td>
                <td><input type="text" name="fin" id="fin" class="textEntry" 
                           placeholder="Fecha de Inicio"
                           value="<?php echo $filas[0]["FECHA INICIO"];?>"></td>
                <td><input type="number" name="ptl" id="ptl" class="textEntry" 
                           placeholder="Precio Total" max="9999999" min="0" disabled="true"
                           value="<?php echo $filas[0]["PRECIO TOTAL"];?>"></td>
                <td colspan="1"><input type="button" value="Actualizar" onclick="actualizaColeccion();"></td>
            
            </tr>
    </table>
        <?php
    }
    
    function consultaColecciones($dni){
        global $server,$bd,$user,$password;
        $db = new PDO("mysql:host=".$server.";dbname=".$bd.";charset=utf8",$user, $password);

        if ($db->errorCode() != 0){
            die("No se ha podido conectar a la base de datos: " .  $db->errorInfo());
        }
        $consulta=$db->prepare("CALL sp_get_colecciones(:dni);");
        $consulta->bindParam(":dni",$dni, PDO::PARAM_STR, 15);
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
                    "cls_colecciones.php?accion=eliminar&dni={$fila["COLECCIONISTA"]}");' value='ELIMINAR'>
                </td> 
                <td><input type='button' 
                    onclick='consulta("cls_colecciones.php?accion=actualizar&dni={$fila["COLECCIONISTA"]}");'
                        value="ACTUALIZAR"></td>
HTML;
            echo "</tr>";
        }
        ?>
            <tr>
                <td><input type="text" name="dni" id="dni" class="textEntry" 
                           placeholder="DNI Coleccionista" maxlength="15">
                <td><input type="datetime-local" name="fin" id="fin" class="textEntry" 
                           placeholder="Fecha de Inicio"></td>
                <td><input type="number" name="ptl" id="ptl" class="textEntry" 
                           placeholder="Precio Total" max="99999999" min="0" disabled="true"></td>
                <td colspan="2"><input type="button" value="Agregar" onclick="insertaColeccion();"></td>
            
            </tr>
    </table>
        <?php
    }
?>