<?php

function filas($datos){
    
    while($consulta->fetch()){
        
        echo "<tr>";
        echo "<td>".utf8_encode($especie)."</td>";
        echo "<td>".utf8_encode($nom_cient)."</td>";
        echo "<td>".utf8_encode($genero)."</td>";
        echo "</tr>";
    }
    
}

?>
