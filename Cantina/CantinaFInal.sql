-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 19-10-2022 a las 10:24:59
-- Versión del servidor: 10.4.25-MariaDB
-- Versión de PHP: 8.1.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `cantina`
--

DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `backups` ()   BEGIN
            DELETE FROM r_usuari_usuari_bk;
            DELETE FROM comentario_bk;
            DELETE FROM missatge_bk;
            DELETE FROM publicacio_bk;
            DELETE FROM historia_bk;
            DELETE FROM usuari_bk;

            INSERT INTO usuari_bk SELECT * from usuari;
            INSERT INTO historia_bk SELECT * FROM historia;
            INSERT INTO publicacio_bk SELECT * FROM publicacio;
            INSERT INTO missatge_bk SELECT * FROM missatge;
            INSERT INTO comentario_bk SELECT * FROM comentario;
            INSERT INTO r_usuari_usuari_bk SELECT * FROM r_usuari_usuari;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `NotifyNewPublication` (IN `idUsuari` INT, IN `idPublicacio` VARCHAR(255))   BEGIN
    DECLARE idSeguidor INT DEFAULT 0;
    DECLARE finished INT DEFAULT FALSE;

    DECLARE followers_cursor CURSOR FOR
        select r_usuari_usuari.idSeguidor from r_usuari_usuari WHERE r_usuari_usuari.idUsuari = idUsuari;

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET finished = TRUE;

    OPEN followers_cursor;

    iteration: LOOP
        FETCH followers_cursor INTO idSeguidor;
        IF finished THEN
            LEAVE iteration;
        END IF;
		
        INSERT INTO missatge(
            idUsusariEmisor,
            idUsusariReceptor,
            textMissatge
        )
        VALUES (
            idUsuari,
            idSeguidor,
            idPublicacio
        );


    END LOOP;
    CLOSE followers_cursor;

END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `comentario`
--

CREATE TABLE `comentario` (
  `idComent` int(10) NOT NULL,
  `idPub` int(10) NOT NULL,
  `idUsuari` int(10) NOT NULL,
  `textComent` varchar(255) DEFAULT NULL,
  `dataComentari` date NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `comentario`
--

INSERT INTO `comentario` (`idComent`, `idPub`, `idUsuari`, `textComent`, `dataComentari`) VALUES
(1, 4, 76, 'nice photo', '0000-00-00'),
(4, 5, 76, 'ddd', '0000-00-00'),
(5, 6, 76, 'nice image', '0000-00-00'),
(8, 3, 77, 'olee', '0000-00-00'),
(9, 4, 77, 'oleee', '0000-00-00'),
(10, 3, 77, 'diselooo', '2022-10-13');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `comentario_bk`
--

CREATE TABLE `comentario_bk` (
  `idComent` int(10) NOT NULL,
  `idPub` int(10) NOT NULL,
  `idUsuari` int(10) NOT NULL,
  `textComent` varchar(255) DEFAULT NULL,
  `dataComentari` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `comentario_bk`
--

INSERT INTO `comentario_bk` (`idComent`, `idPub`, `idUsuari`, `textComent`, `dataComentari`) VALUES
(1, 4, 76, 'nice photo', '0000-00-00'),
(4, 5, 76, 'ddd', '0000-00-00'),
(5, 6, 76, 'nice image', '0000-00-00'),
(8, 3, 77, 'olee', '0000-00-00'),
(9, 4, 77, 'oleee', '0000-00-00'),
(10, 3, 77, 'diselooo', '2022-10-13');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `historia`
--

CREATE TABLE `historia` (
  `idHistoria` int(10) NOT NULL,
  `idUsuari` int(10) NOT NULL,
  `nomHistoria` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `historia`
--

INSERT INTO `historia` (`idHistoria`, `idUsuari`, `nomHistoria`) VALUES
(26, 77, ''),
(27, 77, ''),
(28, 77, ''),
(29, 77, ''),
(30, 77, ''),
(31, 77, ''),
(32, 77, ''),
(33, 77, ''),
(34, 77, ''),
(35, 77, '');

--
-- Disparadores `historia`
--
DELIMITER $$
CREATE TRIGGER `newPublish` AFTER INSERT ON `historia` FOR EACH ROW BEGIN
    CALL NotifyNewPublication (
		new.idUsuari, 
        CONCAT("<a href='profile.php?user=",new.idUsuari,"'",">Nova Historia!</a>")
    );
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `historia_bk`
--

CREATE TABLE `historia_bk` (
  `idHistoria` int(10) NOT NULL,
  `idUsuari` int(10) NOT NULL,
  `nomHistoria` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `historia_bk`
--

INSERT INTO `historia_bk` (`idHistoria`, `idUsuari`, `nomHistoria`) VALUES
(26, 77, ''),
(27, 77, ''),
(28, 77, ''),
(29, 77, ''),
(30, 77, ''),
(31, 77, ''),
(32, 77, ''),
(33, 77, ''),
(34, 77, ''),
(35, 77, '');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `missatge`
--

CREATE TABLE `missatge` (
  `idMissatge` int(10) NOT NULL,
  `idUsusariEmisor` int(10) NOT NULL,
  `idUsusariReceptor` int(10) NOT NULL,
  `textMissatge` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `missatge`
--

INSERT INTO `missatge` (`idMissatge`, `idUsusariEmisor`, `idUsusariReceptor`, `textMissatge`) VALUES
(113, 77, 51, '<a href=\'profile.php?user=77\'>Nova Historia!</a>'),
(114, 77, 76, '<a href=\'profile.php?user=77\'>Nova Historia!</a>'),
(115, 51, 77, 'ueee'),
(116, 77, 51, 'hola tio'),
(117, 51, 77, 'como va?'),
(118, 51, 77, 'holiiis');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `missatge_bk`
--

CREATE TABLE `missatge_bk` (
  `idMissatge` int(10) NOT NULL,
  `idUsusariEmisor` int(10) NOT NULL,
  `idUsusariReceptor` int(10) NOT NULL,
  `textMissatge` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `missatge_bk`
--

INSERT INTO `missatge_bk` (`idMissatge`, `idUsusariEmisor`, `idUsusariReceptor`, `textMissatge`) VALUES
(113, 77, 51, '<a href=\'profile.php?user=77\'>Nova Historia!</a>'),
(114, 77, 76, '<a href=\'profile.php?user=77\'>Nova Historia!</a>'),
(115, 51, 77, 'ueee'),
(116, 77, 51, 'hola tio'),
(117, 51, 77, 'como va?'),
(118, 51, 77, 'holiiis');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `publicacio`
--

CREATE TABLE `publicacio` (
  `idPub` int(10) NOT NULL,
  `idHistoria` int(10) DEFAULT NULL,
  `idRevPub` int(10) DEFAULT NULL,
  `idUsuari` int(10) NOT NULL,
  `img` varchar(255) DEFAULT NULL,
  `textPubli` varchar(255) DEFAULT NULL,
  `dataPubli` date NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `publicacio`
--

INSERT INTO `publicacio` (`idPub`, `idHistoria`, `idRevPub`, `idUsuari`, `img`, `textPubli`, `dataPubli`) VALUES
(3, NULL, NULL, 51, 'Sunset-over-Mallorca.jpg', 'sesdsdsd', '2022-10-13'),
(4, NULL, NULL, 51, 'ACS_KeyArt01.jpg', 'Assassins creed', '2022-10-13'),
(5, NULL, NULL, 51, 'ACS_KeyArt02.jpg', '#Ass', '2022-10-13'),
(6, NULL, NULL, 51, 'ACS_KeyArt03.jpg', 'sdsdsd', '2022-10-13'),
(7, NULL, NULL, 76, 'ACS_Boxart.jpg', 'sdasdasd', '2022-10-13'),
(10, NULL, 4, 76, NULL, 'de locos', '2022-10-13'),
(11, NULL, NULL, 77, 'AC2_Screenshot04.jpg', 'ieee', '2022-10-13'),
(12, NULL, 10, 77, NULL, 'Buen juego', '2022-10-13'),
(13, NULL, NULL, 51, NULL, 'sdfsxd', '2022-10-13'),
(33, NULL, NULL, 77, 'AC2_KeyArt05.jpg', 'bbb', '2022-10-13'),
(65, 35, NULL, 77, 'ACO_KeyArt01.jpg', '', '2022-10-13'),
(66, 35, NULL, 77, 'ACO_KeyArt02.jpg', '', '2022-10-13'),
(67, 35, NULL, 77, 'ACO_KeyArt03.jpg', '', '2022-10-13'),
(68, 35, NULL, 77, 'ACO_KeyArt04.jpg', '', '2022-10-13'),
(69, NULL, 6, 77, NULL, 'Altair era mejor', '2022-10-13');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `publicacio_bk`
--

CREATE TABLE `publicacio_bk` (
  `idPub` int(10) NOT NULL,
  `idHistoria` int(10) DEFAULT NULL,
  `idRevPub` int(10) DEFAULT NULL,
  `idUsuari` int(10) NOT NULL,
  `img` varchar(255) DEFAULT NULL,
  `textPubli` varchar(255) DEFAULT NULL,
  `dataPubli` date NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `publicacio_bk`
--

INSERT INTO `publicacio_bk` (`idPub`, `idHistoria`, `idRevPub`, `idUsuari`, `img`, `textPubli`, `dataPubli`) VALUES
(3, NULL, NULL, 51, 'Sunset-over-Mallorca.jpg', 'sesdsdsd', '2022-10-13'),
(4, NULL, NULL, 51, 'ACS_KeyArt01.jpg', 'Assassins creed', '2022-10-13'),
(5, NULL, NULL, 51, 'ACS_KeyArt02.jpg', '#Ass', '2022-10-13'),
(6, NULL, NULL, 51, 'ACS_KeyArt03.jpg', 'sdsdsd', '2022-10-13'),
(7, NULL, NULL, 76, 'ACS_Boxart.jpg', 'sdasdasd', '2022-10-13'),
(10, NULL, 4, 76, NULL, 'de locos', '2022-10-13'),
(11, NULL, NULL, 77, 'AC2_Screenshot04.jpg', 'ieee', '2022-10-13'),
(12, NULL, 10, 77, NULL, 'Buen juego', '2022-10-13'),
(13, NULL, NULL, 51, NULL, 'sdfsxd', '2022-10-13'),
(33, NULL, NULL, 77, 'AC2_KeyArt05.jpg', 'bbb', '2022-10-13'),
(65, 35, NULL, 77, 'ACO_KeyArt01.jpg', '', '2022-10-13'),
(66, 35, NULL, 77, 'ACO_KeyArt02.jpg', '', '2022-10-13'),
(67, 35, NULL, 77, 'ACO_KeyArt03.jpg', '', '2022-10-13'),
(68, 35, NULL, 77, 'ACO_KeyArt04.jpg', '', '2022-10-13'),
(69, NULL, 6, 77, NULL, 'Altair era mejor', '2022-10-13');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `r_usuari_usuari`
--

CREATE TABLE `r_usuari_usuari` (
  `idUsuari` int(10) NOT NULL,
  `idSeguidor` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `r_usuari_usuari`
--

INSERT INTO `r_usuari_usuari` (`idUsuari`, `idSeguidor`) VALUES
(51, 77),
(76, 51),
(77, 51),
(77, 76);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `r_usuari_usuari_bk`
--

CREATE TABLE `r_usuari_usuari_bk` (
  `idUsuari` int(10) NOT NULL,
  `idSeguidor` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `r_usuari_usuari_bk`
--

INSERT INTO `r_usuari_usuari_bk` (`idUsuari`, `idSeguidor`) VALUES
(51, 77),
(76, 51),
(77, 51),
(77, 76);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuari`
--

CREATE TABLE `usuari` (
  `idUsuari` int(10) NOT NULL,
  `nomUsuari` varchar(20) NOT NULL,
  `pass` varchar(6) NOT NULL,
  `privacitat` enum('Privat','Public') NOT NULL DEFAULT 'Public',
  `imgProfile` varchar(255) NOT NULL,
  `textProfile` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `usuari`
--

INSERT INTO `usuari` (`idUsuari`, `nomUsuari`, `pass`, `privacitat`, `imgProfile`, `textProfile`) VALUES
(51, 'Telmiuse', '111', 'Privat', 'AC2_KeyArt01.jpg', 'ffffff'),
(52, 'Abdul', 'wqeqw', 'Public', '', ''),
(53, 'Abel', 'wqeqw', 'Public', '', ''),
(54, 'Abelardo', 'wqeqw', 'Public', '', ''),
(55, 'Abraham', 'wqeqw', 'Public', '', ''),
(56, 'Adam', 'wqeqw', 'Public', '', ''),
(57, 'Adán', 'wqeqw', 'Public', '', ''),
(58, 'Adolfo', 'wqeqw', 'Public', '', ''),
(59, 'Adrián', 'wqeqw', 'Public', '', ''),
(60, 'Adriano', 'wqeqw', 'Public', '', ''),
(61, 'Agustín', 'wqeqw', 'Public', '', ''),
(62, 'Aladino', 'wqeqw', 'Public', '', ''),
(63, 'Alan', 'wqeqw', 'Public', '', ''),
(64, 'Alberto', 'wqeqw', 'Public', '', ''),
(65, 'Alejandro', 'wqeqw', 'Public', '', ''),
(66, 'Alessandro', 'wqeqw', 'Public', '', ''),
(67, 'Alexis', 'wqeqw', 'Public', '', ''),
(68, 'Alfonso', 'wqeqw', 'Public', '', ''),
(69, 'Andrés', 'wqeqw', 'Public', '', ''),
(70, 'Angel', 'wqeqw', 'Public', '', ''),
(71, 'Antonio', 'wqeqw', 'Public', '', ''),
(72, 'Ariel', 'wqeqw', 'Public', '', ''),
(73, 'Armando', 'wqeqw', 'Public', '', ''),
(74, 'Arturo', 'wqeqw', 'Public', '', ''),
(75, 'Augusto', 'wqeqw', 'Public', '', ''),
(76, 'Joy', '111', 'Privat', 'ACS_KeyArt05.jpg', 'asdfasdf'),
(77, 'mario', '111', 'Privat', 'ACS_KeyArt10.jpg', 'WARIO');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuari_bk`
--

CREATE TABLE `usuari_bk` (
  `idUsuari` int(10) NOT NULL,
  `nomUsuari` varchar(20) NOT NULL,
  `pass` varchar(6) NOT NULL,
  `privacitat` enum('Privat','Public') NOT NULL DEFAULT 'Public',
  `imgProfile` varchar(255) NOT NULL,
  `textProfile` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `usuari_bk`
--

INSERT INTO `usuari_bk` (`idUsuari`, `nomUsuari`, `pass`, `privacitat`, `imgProfile`, `textProfile`) VALUES
(51, 'Telmiuse', '111', 'Privat', 'AC2_KeyArt01.jpg', 'ffffff'),
(52, 'Abdul', 'wqeqw', 'Public', '', ''),
(53, 'Abel', 'wqeqw', 'Public', '', ''),
(54, 'Abelardo', 'wqeqw', 'Public', '', ''),
(55, 'Abraham', 'wqeqw', 'Public', '', ''),
(56, 'Adam', 'wqeqw', 'Public', '', ''),
(57, 'Adán', 'wqeqw', 'Public', '', ''),
(58, 'Adolfo', 'wqeqw', 'Public', '', ''),
(59, 'Adrián', 'wqeqw', 'Public', '', ''),
(60, 'Adriano', 'wqeqw', 'Public', '', ''),
(61, 'Agustín', 'wqeqw', 'Public', '', ''),
(62, 'Aladino', 'wqeqw', 'Public', '', ''),
(63, 'Alan', 'wqeqw', 'Public', '', ''),
(64, 'Alberto', 'wqeqw', 'Public', '', ''),
(65, 'Alejandro', 'wqeqw', 'Public', '', ''),
(66, 'Alessandro', 'wqeqw', 'Public', '', ''),
(67, 'Alexis', 'wqeqw', 'Public', '', ''),
(68, 'Alfonso', 'wqeqw', 'Public', '', ''),
(69, 'Andrés', 'wqeqw', 'Public', '', ''),
(70, 'Angel', 'wqeqw', 'Public', '', ''),
(71, 'Antonio', 'wqeqw', 'Public', '', ''),
(72, 'Ariel', 'wqeqw', 'Public', '', ''),
(73, 'Armando', 'wqeqw', 'Public', '', ''),
(74, 'Arturo', 'wqeqw', 'Public', '', ''),
(75, 'Augusto', 'wqeqw', 'Public', '', ''),
(76, 'Joy', '111', 'Privat', 'ACS_KeyArt05.jpg', 'asdfasdf'),
(77, 'mario', '111', 'Privat', 'ACS_KeyArt10.jpg', 'WARIO');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `comentario`
--
ALTER TABLE `comentario`
  ADD PRIMARY KEY (`idComent`),
  ADD KEY `idPub` (`idPub`),
  ADD KEY `idUsuari` (`idUsuari`);

--
-- Indices de la tabla `comentario_bk`
--
ALTER TABLE `comentario_bk`
  ADD PRIMARY KEY (`idComent`),
  ADD KEY `idPub` (`idPub`),
  ADD KEY `idUsuari` (`idUsuari`);

--
-- Indices de la tabla `historia`
--
ALTER TABLE `historia`
  ADD PRIMARY KEY (`idHistoria`),
  ADD KEY `idUsuari` (`idUsuari`);

--
-- Indices de la tabla `historia_bk`
--
ALTER TABLE `historia_bk`
  ADD PRIMARY KEY (`idHistoria`),
  ADD KEY `idUsuari` (`idUsuari`);

--
-- Indices de la tabla `missatge`
--
ALTER TABLE `missatge`
  ADD PRIMARY KEY (`idMissatge`),
  ADD KEY `idUsusariEmisor` (`idUsusariEmisor`),
  ADD KEY `idUsusariReceptor` (`idUsusariReceptor`);

--
-- Indices de la tabla `missatge_bk`
--
ALTER TABLE `missatge_bk`
  ADD PRIMARY KEY (`idMissatge`),
  ADD KEY `idUsusariEmisor` (`idUsusariEmisor`),
  ADD KEY `idUsusariReceptor` (`idUsusariReceptor`);

--
-- Indices de la tabla `publicacio`
--
ALTER TABLE `publicacio`
  ADD PRIMARY KEY (`idPub`),
  ADD KEY `idHistoria` (`idHistoria`),
  ADD KEY `idRevPub` (`idRevPub`),
  ADD KEY `idUsuari` (`idUsuari`);

--
-- Indices de la tabla `publicacio_bk`
--
ALTER TABLE `publicacio_bk`
  ADD PRIMARY KEY (`idPub`),
  ADD KEY `idHistoria` (`idHistoria`),
  ADD KEY `idRevPub` (`idRevPub`),
  ADD KEY `idUsuari` (`idUsuari`);

--
-- Indices de la tabla `r_usuari_usuari`
--
ALTER TABLE `r_usuari_usuari`
  ADD PRIMARY KEY (`idUsuari`,`idSeguidor`),
  ADD KEY `idSeguidor` (`idSeguidor`);

--
-- Indices de la tabla `r_usuari_usuari_bk`
--
ALTER TABLE `r_usuari_usuari_bk`
  ADD PRIMARY KEY (`idUsuari`,`idSeguidor`),
  ADD KEY `idSeguidor` (`idSeguidor`);

--
-- Indices de la tabla `usuari`
--
ALTER TABLE `usuari`
  ADD PRIMARY KEY (`idUsuari`);

--
-- Indices de la tabla `usuari_bk`
--
ALTER TABLE `usuari_bk`
  ADD PRIMARY KEY (`idUsuari`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `comentario`
--
ALTER TABLE `comentario`
  MODIFY `idComent` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de la tabla `comentario_bk`
--
ALTER TABLE `comentario_bk`
  MODIFY `idComent` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de la tabla `historia`
--
ALTER TABLE `historia`
  MODIFY `idHistoria` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=36;

--
-- AUTO_INCREMENT de la tabla `historia_bk`
--
ALTER TABLE `historia_bk`
  MODIFY `idHistoria` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=36;

--
-- AUTO_INCREMENT de la tabla `missatge`
--
ALTER TABLE `missatge`
  MODIFY `idMissatge` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=119;

--
-- AUTO_INCREMENT de la tabla `missatge_bk`
--
ALTER TABLE `missatge_bk`
  MODIFY `idMissatge` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=119;

--
-- AUTO_INCREMENT de la tabla `publicacio`
--
ALTER TABLE `publicacio`
  MODIFY `idPub` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=70;

--
-- AUTO_INCREMENT de la tabla `publicacio_bk`
--
ALTER TABLE `publicacio_bk`
  MODIFY `idPub` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=70;

--
-- AUTO_INCREMENT de la tabla `usuari`
--
ALTER TABLE `usuari`
  MODIFY `idUsuari` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=78;

--
-- AUTO_INCREMENT de la tabla `usuari_bk`
--
ALTER TABLE `usuari_bk`
  MODIFY `idUsuari` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=78;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `comentario`
--
ALTER TABLE `comentario`
  ADD CONSTRAINT `comentario_ibfk_1` FOREIGN KEY (`idPub`) REFERENCES `publicacio` (`idPub`),
  ADD CONSTRAINT `comentario_ibfk_2` FOREIGN KEY (`idUsuari`) REFERENCES `usuari` (`idUsuari`);

--
-- Filtros para la tabla `comentario_bk`
--
ALTER TABLE `comentario_bk`
  ADD CONSTRAINT `comentario_bk_ibfk_1` FOREIGN KEY (`idPub`) REFERENCES `publicacio_bk` (`idPub`),
  ADD CONSTRAINT `comentario_bk_ibfk_2` FOREIGN KEY (`idUsuari`) REFERENCES `usuari_bk` (`idUsuari`);

--
-- Filtros para la tabla `historia`
--
ALTER TABLE `historia`
  ADD CONSTRAINT `historia_ibfk_1` FOREIGN KEY (`idUsuari`) REFERENCES `usuari` (`idUsuari`);

--
-- Filtros para la tabla `historia_bk`
--
ALTER TABLE `historia_bk`
  ADD CONSTRAINT `historia_bk_ibfk_1` FOREIGN KEY (`idUsuari`) REFERENCES `usuari_bk` (`idUsuari`);

--
-- Filtros para la tabla `missatge`
--
ALTER TABLE `missatge`
  ADD CONSTRAINT `missatge_ibfk_1` FOREIGN KEY (`idUsusariEmisor`) REFERENCES `usuari` (`idUsuari`),
  ADD CONSTRAINT `missatge_ibfk_2` FOREIGN KEY (`idUsusariReceptor`) REFERENCES `usuari` (`idUsuari`);

--
-- Filtros para la tabla `missatge_bk`
--
ALTER TABLE `missatge_bk`
  ADD CONSTRAINT `missatge_bk_ibfk_1` FOREIGN KEY (`idUsusariEmisor`) REFERENCES `usuari_bk` (`idUsuari`),
  ADD CONSTRAINT `missatge_bk_ibfk_2` FOREIGN KEY (`idUsusariReceptor`) REFERENCES `usuari_bk` (`idUsuari`);

--
-- Filtros para la tabla `publicacio`
--
ALTER TABLE `publicacio`
  ADD CONSTRAINT `publicacio_ibfk_1` FOREIGN KEY (`idHistoria`) REFERENCES `historia` (`idHistoria`),
  ADD CONSTRAINT `publicacio_ibfk_2` FOREIGN KEY (`idRevPub`) REFERENCES `publicacio` (`idPub`),
  ADD CONSTRAINT `publicacio_ibfk_3` FOREIGN KEY (`idUsuari`) REFERENCES `usuari` (`idUsuari`);

--
-- Filtros para la tabla `publicacio_bk`
--
ALTER TABLE `publicacio_bk`
  ADD CONSTRAINT `publicacio_bk_ibfk_1` FOREIGN KEY (`idHistoria`) REFERENCES `historia_bk` (`idHistoria`),
  ADD CONSTRAINT `publicacio_bk_ibfk_2` FOREIGN KEY (`idRevPub`) REFERENCES `publicacio_bk` (`idPub`),
  ADD CONSTRAINT `publicacio_bk_ibfk_3` FOREIGN KEY (`idUsuari`) REFERENCES `usuari_bk` (`idUsuari`);

--
-- Filtros para la tabla `r_usuari_usuari`
--
ALTER TABLE `r_usuari_usuari`
  ADD CONSTRAINT `r_usuari_usuari_ibfk_1` FOREIGN KEY (`idUsuari`) REFERENCES `usuari` (`idUsuari`),
  ADD CONSTRAINT `r_usuari_usuari_ibfk_2` FOREIGN KEY (`idSeguidor`) REFERENCES `usuari` (`idUsuari`);

--
-- Filtros para la tabla `r_usuari_usuari_bk`
--
ALTER TABLE `r_usuari_usuari_bk`
  ADD CONSTRAINT `r_usuari_usuari_bk_ibfk_1` FOREIGN KEY (`idUsuari`) REFERENCES `usuari_bk` (`idUsuari`),
  ADD CONSTRAINT `r_usuari_usuari_bk_ibfk_2` FOREIGN KEY (`idSeguidor`) REFERENCES `usuari_bk` (`idUsuari`);

DELIMITER $$
--
-- Eventos
--
CREATE DEFINER=`root`@`localhost` EVENT `BK` ON SCHEDULE EVERY 1 DAY STARTS '2022-10-19 10:14:17' ENDS '2030-10-09 10:14:17' ON COMPLETION NOT PRESERVE ENABLE DO EXECUTE backups$$

DELIMITER ;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
