

<?php
session_start();
$titulo='Mariposas Indice';
include "encabezado.php";

?>
<fieldset><legend>Ingrese su nombre</legend>
    <form action="index.php" method="POST">
        <input type="text" class="textEntry" name="user" 
            placeholder="Ingrese su primer nombre">
        <input type="submit" value="Iniciar Usario">
    </form>
</fieldset>
<?php
include "pie.php"
?>