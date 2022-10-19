-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 11-10-2022 a las 16:48:06
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
CREATE DEFINER=`root`@`localhost` PROCEDURE `NotifyNewPublication` (IN `idUsuari` INT, IN `idPublicacio` INT)   BEGIN
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
            'JAJA TOMA NOVA PUBLICAÇAO BRO'
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
  `dataComentari` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `comentario`
--

INSERT INTO `comentario` (`idComent`, `idPub`, `idUsuari`, `textComent`, `dataComentari`) VALUES
(1, 4, 76, 'nice photo', '0000-00-00'),
(4, 5, 76, 'ddd', '0000-00-00'),
(5, 6, 76, 'nice image', '0000-00-00'),
(8, 3, 77, 'olee', '0000-00-00'),
(9, 4, 77, 'oleee', '0000-00-00');

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
(5, 77, 'ASPARIS'),
(6, 77, 'refe');

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
(3, 76, 51, 'Hola'),
(6, 51, 76, 'que pasa joy?'),
(7, 51, 76, 'aqui currando'),
(8, 76, 51, 'nice'),
(9, 76, 77, 'hola Mario'),
(10, 76, 76, 'newPost'),
(11, 77, 51, 'JAJA TOMA NOVA PUBLICAÇAO BRO'),
(12, 77, 76, 'JAJA TOMA NOVA PUBLICAÇAO BRO'),
(13, 77, 51, 'JAJA TOMA NOVA PUBLICAÇAO BRO'),
(14, 77, 76, 'JAJA TOMA NOVA PUBLICAÇAO BRO'),
(15, 77, 51, 'JAJA TOMA NOVA PUBLICAÇAO BRO'),
(16, 77, 76, 'JAJA TOMA NOVA PUBLICAÇAO BRO'),
(17, 77, 51, 'JAJA TOMA NOVA PUBLICAÇAO BRO'),
(18, 77, 76, 'JAJA TOMA NOVA PUBLICAÇAO BRO'),
(19, 77, 51, 'JAJA TOMA NOVA PUBLICAÇAO BRO'),
(20, 77, 76, 'JAJA TOMA NOVA PUBLICAÇAO BRO'),
(21, 77, 51, 'JAJA TOMA NOVA PUBLICAÇAO BRO'),
(22, 77, 76, 'JAJA TOMA NOVA PUBLICAÇAO BRO'),
(23, 77, 51, 'JAJA TOMA NOVA PUBLICAÇAO BRO'),
(24, 77, 76, 'JAJA TOMA NOVA PUBLICAÇAO BRO'),
(25, 77, 51, 'JAJA TOMA NOVA PUBLICAÇAO BRO'),
(26, 77, 76, 'JAJA TOMA NOVA PUBLICAÇAO BRO'),
(27, 77, 51, 'JAJA TOMA NOVA PUBLICAÇAO BRO'),
(28, 77, 76, 'JAJA TOMA NOVA PUBLICAÇAO BRO'),
(29, 77, 51, 'JAJA TOMA NOVA PUBLICAÇAO BRO'),
(30, 77, 76, 'JAJA TOMA NOVA PUBLICAÇAO BRO'),
(31, 77, 51, 'JAJA TOMA NOVA PUBLICAÇAO BRO'),
(32, 77, 76, 'JAJA TOMA NOVA PUBLICAÇAO BRO'),
(33, 77, 51, 'JAJA TOMA NOVA PUBLICAÇAO BRO'),
(34, 77, 76, 'JAJA TOMA NOVA PUBLICAÇAO BRO'),
(35, 77, 51, 'JAJA TOMA NOVA PUBLICAÇAO BRO'),
(36, 77, 76, 'JAJA TOMA NOVA PUBLICAÇAO BRO'),
(37, 77, 51, 'JAJA TOMA NOVA PUBLICAÇAO BRO'),
(38, 77, 76, 'JAJA TOMA NOVA PUBLICAÇAO BRO'),
(39, 77, 51, 'JAJA TOMA NOVA PUBLICAÇAO BRO'),
(40, 77, 76, 'JAJA TOMA NOVA PUBLICAÇAO BRO'),
(41, 77, 51, 'JAJA TOMA NOVA PUBLICAÇAO BRO'),
(42, 77, 76, 'JAJA TOMA NOVA PUBLICAÇAO BRO'),
(43, 77, 51, 'JAJA TOMA NOVA PUBLICAÇAO BRO'),
(44, 77, 76, 'JAJA TOMA NOVA PUBLICAÇAO BRO'),
(45, 77, 51, 'JAJA TOMA NOVA PUBLICAÇAO BRO'),
(46, 77, 76, 'JAJA TOMA NOVA PUBLICAÇAO BRO'),
(47, 77, 51, 'JAJA TOMA NOVA PUBLICAÇAO BRO'),
(48, 77, 76, 'JAJA TOMA NOVA PUBLICAÇAO BRO'),
(49, 77, 51, 'JAJA TOMA NOVA PUBLICAÇAO BRO'),
(50, 77, 76, 'JAJA TOMA NOVA PUBLICAÇAO BRO');

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
  `textPubli` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `publicacio`
--

INSERT INTO `publicacio` (`idPub`, `idHistoria`, `idRevPub`, `idUsuari`, `img`, `textPubli`) VALUES
(3, NULL, NULL, 51, 'Sunset-over-Mallorca.jpg', 'sesdsdsd'),
(4, NULL, NULL, 51, 'ACS_KeyArt01.jpg', 'Assassins creed'),
(5, NULL, NULL, 51, 'ACS_KeyArt02.jpg', '#Ass'),
(6, NULL, NULL, 51, 'ACS_KeyArt03.jpg', 'sdsdsd'),
(7, NULL, NULL, 76, 'ACS_Boxart.jpg', 'sdasdasd'),
(10, NULL, 4, 76, NULL, 'de locos'),
(11, NULL, NULL, 77, 'AC2_Screenshot04.jpg', 'ieee'),
(12, NULL, 10, 77, NULL, 'Buen juego'),
(13, NULL, NULL, 51, NULL, 'sdfsxd'),
(27, 5, NULL, 77, 'ACU_KeyArt03.jpg', 'ASPARIS'),
(28, 5, NULL, 77, 'ACU_KeyArt04.jpg', 'ASPARIS'),
(29, 5, NULL, 77, 'ACU_KeyArt05.jpg', 'ASPARIS'),
(30, 6, NULL, 77, 'ACS_KeyArt01.jpg', 'refe'),
(31, 6, NULL, 77, 'ACS_KeyArt02.jpg', 'refe'),
(32, 6, NULL, 77, 'ACS_KeyArt03.jpg', 'refe');

--
-- Disparadores `publicacio`
--
DELIMITER $$
CREATE TRIGGER `newPublish` AFTER INSERT ON `publicacio` FOR EACH ROW BEGIN
    CALL NotifyNewPublication (
        new.idUsuari, 
        new.idPub
    );
END
$$
DELIMITER ;

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
-- Indices de la tabla `historia`
--
ALTER TABLE `historia`
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
-- Indices de la tabla `publicacio`
--
ALTER TABLE `publicacio`
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
-- Indices de la tabla `usuari`
--
ALTER TABLE `usuari`
  ADD PRIMARY KEY (`idUsuari`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `comentario`
--
ALTER TABLE `comentario`
  MODIFY `idComent` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT de la tabla `historia`
--
ALTER TABLE `historia`
  MODIFY `idHistoria` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `missatge`
--
ALTER TABLE `missatge`
  MODIFY `idMissatge` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=51;

--
-- AUTO_INCREMENT de la tabla `publicacio`
--
ALTER TABLE `publicacio`
  MODIFY `idPub` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=33;

--
-- AUTO_INCREMENT de la tabla `usuari`
--
ALTER TABLE `usuari`
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
-- Filtros para la tabla `historia`
--
ALTER TABLE `historia`
  ADD CONSTRAINT `historia_ibfk_1` FOREIGN KEY (`idUsuari`) REFERENCES `usuari` (`idUsuari`);

--
-- Filtros para la tabla `missatge`
--
ALTER TABLE `missatge`
  ADD CONSTRAINT `missatge_ibfk_1` FOREIGN KEY (`idUsusariEmisor`) REFERENCES `usuari` (`idUsuari`),
  ADD CONSTRAINT `missatge_ibfk_2` FOREIGN KEY (`idUsusariReceptor`) REFERENCES `usuari` (`idUsuari`);

--
-- Filtros para la tabla `publicacio`
--
ALTER TABLE `publicacio`
  ADD CONSTRAINT `publicacio_ibfk_1` FOREIGN KEY (`idHistoria`) REFERENCES `historia` (`idHistoria`),
  ADD CONSTRAINT `publicacio_ibfk_2` FOREIGN KEY (`idRevPub`) REFERENCES `publicacio` (`idPub`),
  ADD CONSTRAINT `publicacio_ibfk_3` FOREIGN KEY (`idUsuari`) REFERENCES `usuari` (`idUsuari`);

--
-- Filtros para la tabla `r_usuari_usuari`
--
ALTER TABLE `r_usuari_usuari`
  ADD CONSTRAINT `r_usuari_usuari_ibfk_1` FOREIGN KEY (`idUsuari`) REFERENCES `usuari` (`idUsuari`),
  ADD CONSTRAINT `r_usuari_usuari_ibfk_2` FOREIGN KEY (`idSeguidor`) REFERENCES `usuari` (`idUsuari`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
