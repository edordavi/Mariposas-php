<?php
if (!isset($titulo)){
    $titulo = 'Mariposas';
}
if(!isset($maindir))
{
    $maindir="";
}
?>
<html lang="es" dir="ltr">
    <head>
        <title><?php echo $titulo; ?></title>
        <meta charset="ISO-8859-1">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="<?php echo $maindir;?>styles/layout.css" 
               type="text/css" media="all">
        <link rel="stylesheet" href="<?php echo $maindir;?>styles/mediaqueries.css" 
              type="text/css" media="all">
        <script src="<?php echo $maindir;?>scripts/jquery.1.9.0.min.js"></script>
        <script src="<?php echo $maindir;?>scripts/jquery-mobilemenu.min.js"></script>
        <script type="text/javascript" src="<?php echo $maindir;?>scripts/ajax.js"></script>
        <!--[if lt IE 9]>
        <link rel="stylesheet" href="styles/ie.css" type="text/css" media="all">
        <script src="scripts/ie/css3-mediaqueries.min.js"></script>
        <script src="scripts/ie/ie9.js"></script>
        <script src="scripts/ie/html5shiv.min.js"></script>
        <![endif]-->
        
    </head>
    <body>
        <div class="wrapper row1">
          <header id="header" class="clear">
            <hgroup>
              <h1>Mariposas</h1>
            </hgroup>
          </header>
        </div>
            <div class="wrapper row2">
                  <nav id="topnav">
                    <ul class="clear">
                      <li class="active first"><a href="index.php">Inicio</a></li>
                      <li><a class="drop" href="#">Manipulaci&oacute;n</a>
                          <ul>
                              <li><a href="<?php echo $maindir;?>manip01.php">Consulta # 1</a></li>
                              <li><a href="<?php echo $maindir;?>manip02.php">Consulta # 2</a></li>
                              <li><a href="<?php echo $maindir;?>manip03.php">Consulta # 3</a></li>
                              <li><a href="<?php echo $maindir;?>manip04.php">Consulta # 4</a></li>
                              <li><a href="<?php echo $maindir;?>manip05.php">Consulta # 5</a></li>
                              <li><a href="<?php echo $maindir;?>manip06.php">Consulta # 6</a></li>
                              <li><a href="<?php echo $maindir;?>manip07.php">Consulta # 7</a></li>
                              <li><a href="<?php echo $maindir;?>manip08.php">Consulta # 8</a></li>
                          </ul>
                      </li>
                      <li><a href="#" class="drop">Mantenimiento</a>
                          <ul>
                              <li><a href="<?php echo $maindir;?>personas/personas.php">Personas</a></li>
                              <li><a href="<?php echo $maindir;?>familias/familias.php">Familias</a></li>
                              <li><a href="<?php echo $maindir;?>zonas/zonas.php">Zonas</a></li>
                              <li><a href="<?php echo $maindir;?>generos/generos.php">Generos</a></li>
                              <li><a href="<?php echo $maindir;?>especies/especies.php">Especies</a></li>
                              <li><a href="<?php echo $maindir;?>colecciones/colecciones.php">Colecciones</a></li>
                              <li><a href="<?php echo $maindir;?>ejemplares/ejemplares.php">Ejemplares</a></li>
                          </ul>
                      </li>
                    </ul>
                      
                  </nav>
            </div>
        <div class="wrapper row3">
        <div id="container">