<?php
require_once '../conexionMariposas.php';

    if (isset($_GET["accion"])){
        $accion = $_GET["accion"];
        switch ($accion) {
            case "insertarcol":
                insertaEjemplarCol();
                break;
            case "insertarobs":
                insertaEjemplarObs();
                break;
            case "eliminar":
                eliminaEjemplar();
                break;
            case "actualizar":
                actualizaEjemplar();
                break;
            case "consultar":
                consultaEjemplares("", "", "", $_GET["tip"]);
                break;
            default:
                break;
        }
    }
    function insertaEjemplarCol(){
        global $server,$bd,$user,$password;
        
        $db = new PDO("mysql:host=".$server.";dbname=".$bd.";charset=utf8",$user, $password);
        if ($db->errorCode() != 0){
            die("No se ha podido conectar a la base de datos: " .  $db->errorInfo());
        }
        $zna = $_GET["zna"];
        $fcp = $_GET["fcp"];
        $esp = $_GET["esp"];
        $dnicap = $_GET["cap"];
        $tip = $_GET["tip"];
        $prc = $_GET["prc"];
        $dnicol = $_GET["col"];
        $ncomun = $_GET["nco"];
        $consulta=$db->prepare("CALL sp_nuevo_ejemplarColeccionado(:zna,:fcp,".
                ":esp,:cap,:tip,:nco,:prc,:col);");
        $consulta->bindParam(":zna",$zna, PDO::PARAM_STR, 25);
        $consulta->bindParam(":fcp",$fcp);
        $consulta->bindParam(":esp",$esp, PDO::PARAM_STR, 50);
        $consulta->bindParam(":cap",$dnicap, PDO::PARAM_STR, 15);
        $consulta->bindParam(":tip",$tip, PDO::PARAM_STR, 1);
        $consulta->bindParam(":prc",$prc);
        $consulta->bindParam(":col",$dnicol, PDO::PARAM_STR, 15);
        $consulta->bindParam(":nco",$ncomun, PDO::PARAM_STR, 50);
        $consulta->execute();
        echo "<p>Filas Afectadas: ".$consulta->rowCount()."<br>";

        if($consulta->errorCode()!=="00000"){
            echo "Codigo de Error al Consultar: ".$consulta->errorCode().
                        "<br>Mensaje de Error: ". print_r($consulta->errorInfo())."</p>";
        }
        
        $db = null;
        consultaEjemplares("","","",$_GET["tip"]);
    }
    
    function insertaEjemplarObs(){
        global $server,$bd,$user,$password;
        
        $db = new PDO("mysql:host=".$server.";dbname=".$bd.";charset=utf8",$user, $password);
        if ($db->errorCode() != 0){
            die("No se ha podido conectar a la base de datos: " .  $db->errorInfo());
        }
        $zna = $_GET["zna"];
        $fcp = $_GET["fcp"];
        $esp = $_GET["esp"];
        $dnicap = $_GET["cap"];
        $tip = $_GET["tip"];
        $tmp = $_GET["tmp"];
        $obs = $_GET["obs"];
        $ncomun = $_GET["nco"];
        $consulta=$db->prepare("CALL sp_nuevo_ejemplarObservado(:zna,:fcp,".
                ":esp,:cap,:tip,:nco,:tmp,:obs);");
        $consulta->bindParam(":zna",$zna, PDO::PARAM_STR, 25);
        $consulta->bindParam(":fcp",$fcp);
        $consulta->bindParam(":esp",$esp, PDO::PARAM_STR, 50);
        $consulta->bindParam(":cap",$dnicap, PDO::PARAM_STR, 15);
        $consulta->bindParam(":tip",$tip, PDO::PARAM_STR, 1);
        $consulta->bindParam(":tmp",$tmp,PDO::PARAM_INT);
        $consulta->bindParam(":obs",$obs, PDO::PARAM_STR, 1000);
        $consulta->bindParam(":nco",$ncomun, PDO::PARAM_STR, 50);
        $consulta->execute();
        echo "<p>Filas Afectadas: ".$consulta->rowCount()."<br>";
        
        if($consulta->errorCode()!=="00000"){
            echo "Codigo de Error al Consultar: ".$consulta->errorCode().
                        "<br>Mensaje de Error: ". print_r($consulta->errorInfo())."</p>";
        }
        
        $db = null;
        consultaEjemplares("","","",$_GET["tip"]);
    }
    
    function actualizaEjemplar(){
        global $server,$bd,$user,$password;
        
        $db = new PDO("mysql:host=".$server.";dbname=".$bd.";charset=utf8",$user, $password);
        if ($db->errorCode() != 0){
            die("No se ha podido conectar a la base de datos: " .  $db->errorInfo());
        }
        
        if (isset($_GET["zna2"])){
            $zna1 = $_GET["zna1"];
            $fcp1 = $_GET["fcp1"];
            $esp1 = $_GET["esp1"];
            $zna2 = $_GET["zna2"];
            $fcp2 = $_GET["fcp2"];
            $esp2 = $_GET["esp2"];
            $dnicap = $_GET["cap"];
            $tip = $_GET["tip"];
            $tip1 = $_GET["tip1"];
            $tip2 = $_GET["tip2"];
            $ncomun = $_GET["nco"];
            $consulta=$db->prepare("CALL sp_actualiza_ejemplar(:zna1,:fcp1,".
                ":esp1,:zna2,:fcp2,:esp2,:cap,:tip,:nco,:tip1,:tip2);");
            $consulta->bindParam(":zna1",$zna1, PDO::PARAM_STR, 25);
            $consulta->bindParam(":fcp1",$fcp1);
            $consulta->bindParam(":esp1",$esp1, PDO::PARAM_STR, 50);
            $consulta->bindParam(":zna2",$zna2, PDO::PARAM_STR, 25);
            $consulta->bindParam(":fcp2",$fcp2);
            $consulta->bindParam(":esp2",$esp2, PDO::PARAM_STR, 50);
            $consulta->bindParam(":cap",$dnicap, PDO::PARAM_STR, 15);
            $consulta->bindParam(":tip",$tip, PDO::PARAM_STR, 1);
            $consulta->bindParam(":tip1",$tip1,PDO::PARAM_INT);
            $consulta->bindParam(":tip2",$tip2, PDO::PARAM_STR, 1000);
            $consulta->bindParam(":nco",$ncomun, PDO::PARAM_STR, 50);
            $consulta->execute();
            echo "<p>Filas Afectadas: ".$consulta->rowCount()."<br>";

            if($consulta->errorCode()!=="00000"){
            echo "Codigo de Error al Consultar: ".$consulta->errorCode().
                        "<br>Mensaje de Error: ". print_r($consulta->errorInfo())."</p>";
            }

            $db = null;
            consultaEjemplares("","","",$_GET["tip"]);   
            
        }else{
            consultaEjemplaresActualizar($_GET["zna"],$_GET["fcp"],$_GET["esp"],$_GET["tip"]);
        }
    }
    
    function eliminaEjemplar(){
        global $server,$bd,$user,$password;
        
        $db = new PDO("mysql:host=".$server.";dbname=".$bd.";charset=utf8",$user, $password);
        if ($db->errorCode() != 0){
            die("No se ha podido conectar a la base de datos: " .  $db->errorInfo());
        }
        $zna = $_GET["zna"];
        $fcp = $_GET["fcp"];
        $esp = $_GET["esp"];
        $consulta=$db->prepare("CALL sp_elimina_ejemplar(:zna,:fcp,:esp);");
        $consulta->bindParam(":zna",$zna, PDO::PARAM_STR, 25);
        $consulta->bindParam(":fcp",$fcp);
        $consulta->bindParam(":esp",$esp, PDO::PARAM_STR, 50);
        $consulta->execute();

        if($consulta->errorCode()!=="00000"){
            echo "Codigo de Error al Consultar: ".$consulta->errorCode().
                        "<br>Mensaje de Error: ". print_r($consulta->errorInfo())."</p>";
        }
        $db = null;
        consultaEjemplares("","","","");
    }
    
    function consultaEjemplaresActualizar($zna,$fcp,$esp,$tipo){
        global $server,$bd,$user,$password;
        $db = new PDO("mysql:host=".$server.";dbname=".$bd.";charset=utf8",$user, $password);

        if ($db->errorCode() != 0){
            die("No se ha podido conectar a la base de datos: " .  $db->errorInfo());
        }
        $consulta=$db->prepare("CALL sp_get_ejemplares(:zna,:fcp,:esp,:tip);");
        $consulta->bindParam(":zna",$zna, PDO::PARAM_STR, 25);
        $consulta->bindParam(":fcp",$fcp);
        $consulta->bindParam(":esp",$esp, PDO::PARAM_STR, 50);
        $consulta->bindParam(":tip",$tipo, PDO::PARAM_STR, 1);
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
                <td><input type="text" name="zna1" id="zna1" class="textEntry" 
                           placeholder="Zona" maxlength="25"
                           value="<?php echo $filas[0]["ZONA"];?>">
                    <input type="text" name="zna2" id="zna2" class="oculto" 
                           placeholder="Zona" maxlength="25"
                           value="<?php echo $filas[0]["ZONA"];?>"></td>
                <td><input type="text" name="fcp1" id="fcp1" class="textEntry" 
                           placeholder="Fecha Captura"
                           value="<?php echo $filas[0]["FECHA CAPTURA"];?>">
                    <input type="text" name="fcp2" id="fcp2" class="oculto" 
                           placeholder="Fecha Captura"
                           value="<?php echo $filas[0]["FECHA CAPTURA"];?>"></td>
                <td><input type="text" name="esp1" id="esp1" class="textEntry" 
                           placeholder="Especie" maxlength="50"
                           value="<?php echo $filas[0]["ESPECIE"];?>">
                    <input type="text" name="esp2" id="esp2" class="oculto" 
                           placeholder="Especie" maxlength="50"
                           value="<?php echo $filas[0]["ESPECIE"];?>"></td>
                <td><input type="text" name="cap" id="cap" class="textEntry" 
                           placeholder="DNI Capturo" maxlength="15"
                           value="<?php echo $filas[0]["CAPTURO"];?>"></td>
                <td><input type="text" name="nco" id="nco" class="textEntry" 
                           placeholder="Nombre Comun" maxlength="50"
                           value="<?php echo $filas[0]["NOMBRE COMUN"];?>"></td>
                <td><input type="text" name="tip" id="tip" class="textEntry" 
                           placeholder="Tipo Ejemplar" maxlength="1" pattern="(c|C|o|O){1}"
                           value="<?php echo $filas[0]["TIPO"];?>"></td>
                <td><input type="number" name="tip1" id="tip1" class="textEntry" 
                           placeholder="Precio/Tiempo" max="99999999" min="0" step="1"
                           value="<?php if(isset($filas[0]["COLECCIONISTA"])){
                            echo $filas[0]["PRECIO"];}if(isset($filas[0]["OBSERVACIONES"])){
                            echo $filas[0]["TIEMPO"];
                           }?>"></td>
                <td><input type="text" name="tip2" id="tip2" class="textEntry" 
                           placeholder="Coleccionista/Observacion" maxlength="1000"
                           value="<?php if(isset($filas[0]["COLECCIONISTA"])){
                            echo $filas[0]["COLECCIONISTA"];}if(isset($filas[0]["OBSERVACIONES"])){
                            echo $filas[0]["OBSERVACIONES"];
                           }?>"></td>
                <td colspan="2"><input type="button" value="Actualizar" onclick="actualizaEjemplar();"></td>  
            </tr>
    </table>
        <?php
    }
    
    function consultaEjemplares($zna,$fcp,$esp,$tipo){
        global $server,$bd,$user,$password;
        $db = new PDO("mysql:host=".$server.";dbname=".$bd.";charset=utf8",$user, $password);

        if ($db->errorCode() != 0){
            die("No se ha podido conectar a la base de datos: " .  $db->errorInfo());
        }
        $consulta=$db->prepare("CALL sp_get_ejemplares(:zna,:fcp,:esp,:tip);");
        $consulta->bindParam(":zna",$zna, PDO::PARAM_STR, 25);
        $consulta->bindParam(":fcp",$fcp);
        $consulta->bindParam(":esp",$esp, PDO::PARAM_STR, 50);
        $consulta->bindParam(":tip",$tipo, PDO::PARAM_STR, 1);
        $consulta->execute();
        $filas=$consulta->fetchAll(PDO::FETCH_ASSOC);
        if($consulta->errorCode()!=="00000"){
            echo "Codigo de Error al Consultar: ".$consulta->errorCode().
                        "<br>Mensaje de Error: ". print_r($consulta->errorInfo())."</p>";
        }

        tabla($filas);
      
        $db = null;
    }
    
    function tabla($filas){
        ?><table border=2 width=100% id="datos1"><?php
        if(count($filas)>0){
            ?><tr><?php
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
                        "cls_ejemplares.php?accion=eliminar&zna={$fila["ZONA"]}&esp={$fila["ESPECIE"]}&fcp={$fila["FECHA CAPTURA"]}&tip={$fila["TIPO"]}");'
                            value='ELIMINAR'>
                    </td>
                    <td><input type='button'
                        onclick='consulta("cls_ejemplares.php?accion=actualizar&zna={$fila["ZONA"]}&esp={$fila["ESPECIE"]}&fcp={$fila["FECHA CAPTURA"]}&tip={$fila["TIPO"]}");'
                            value="ACTUALIZAR"></td>
HTML;
                echo "</tr>";
            }
            
        }else{echo "<p>NO HAY DATOS</p>";}
            if(isset($_GET["tip"])){
            if( strtoupper( $_GET["tip"])=="C"){    ?>
                <tr>
                    <td><input type="text" name="zna" id="zna" class="textEntry" 
                               placeholder="Zona" maxlength="25"></td>
                    <td><input type="datetime-local" name="fcp" id="fcp" class="textEntry" 
                               placeholder="Fecha Captura"></td>
                    <td><input type="text" name="esp" id="esp" class="textEntry" 
                               placeholder="Especie" maxlength="50"></td>
                    <td><input type="text" name="cap" id="cap" class="textEntry" 
                               placeholder="DNI Capturo" maxlength="15"></td>
                    <td><input type="text" name="nco" id="nco" class="textEntry" 
                               placeholder="Nombre Comun" maxlength="50"></td>
                    <td><input type="text" name="tip" id="tip" class="textEntry" 
                               placeholder="Tipo Ejemplar" maxlength="1" pattern="(c|C|o|O){1}"></td>
                    <td><input type="number" name="prc" id="prc" class="textEntry" 
                               placeholder="Precio" max="99999999" min="0" step="100"></td>
                    <td><input type="text" name="col" id="col" class="textEntry" 
                               placeholder="Coleccionista" maxlength="15"></td>
                    <td colspan="2"><input type="button" value="Agregar" onclick="insertaEjemplarCol();"></td>  
                </tr>
        <?php 
            }elseif(strtoupper( $_GET["tip"])=="O"){    ?>
                <tr>
                    <td><input type="text" name="zna" id="zna" class="textEntry" 
                               placeholder="Zona" maxlength="25"></td>
                    <td><input type="datetime-local" name="fcp" id="fcp" class="textEntry" 
                               placeholder="Fecha Captura"></td>
                    <td><input type="text" name="esp" id="esp" class="textEntry" 
                               placeholder="Especie" maxlength="50"></td>
                    <td><input type="text" name="cap" id="cap" class="textEntry" 
                               placeholder="DNI Capturo" maxlength="15"></td>
                    <td><input type="text" name="nco" id="nco" class="textEntry" 
                               placeholder="Nombre Comun" maxlength="50"></td>
                    <td><input type="text" name="tip" id="tip" class="textEntry" 
                               placeholder="Tipo Ejemplar" maxlength="1" pattern="(c|C|o|O){1}"></td>
                    <td><input type="number" name="tmp" id="tmp" class="textEntry" 
                               placeholder="Tiempo" max="999999" min="1" step="1"></td>
                    <td><input type="text" name="obs" id="obs" class="textEntry" 
                               placeholder="Observaciones" maxlength="1000"></td>
                    <td colspan="2"><input type="button" value="Agregar" onclick="insertaEjemplarObs();"></td>  
                </tr>
        <?php
            }
            }
        ?>
    </table>
        <?php
    }
?>