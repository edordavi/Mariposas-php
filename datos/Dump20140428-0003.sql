CREATE DATABASE  IF NOT EXISTS `mariposas` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `mariposas`;

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;




INSERT INTO Especie (especie, nombre_cientifico, genero) VALUES ('Adscita schmidti','Adscita schmidti Naufock','Adscita'),('Aglais urticae','Aglais urticae Linnaeus','Aglais'),('Agrotis trux','Agrotis trux Linnaeus','Agrotis'),('Ancylolomia aff tentaculella','Ancylolomia aff tentaculella (Hübner)','Ancylolomia');

INSERT INTO Familia (familia) VALUES ('Crambidae'),('Noctuidae'),('Nymphalidae'),('Zygaenidae');

INSERT INTO Genero (genero, familia) VALUES ('Ancylolomia','Crambidae'),('Agrotis','Noctuidae'),('Aglais','Nymphalidae'),('Adscita','Zygaenidae');




/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

