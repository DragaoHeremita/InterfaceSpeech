-- phpMyAdmin SQL Dump
-- version 4.2.7.1
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Oct 17, 2014 at 07:36 
-- Server version: 5.6.20
-- PHP Version: 5.5.15

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `Db_Interface`
--

-- --------------------------------------------------------

--
-- Table structure for table `Registros`
--

CREATE TABLE IF NOT EXISTS `Registros` (
`Id` int(11) NOT NULL,
  `Palavra` tinytext NOT NULL,
  `Data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=47 ;

--
-- Dumping data for table `Registros`
--

INSERT INTO `Registros` (`Id`, `Palavra`, `Data`) VALUES
(46, 'Calor', '2014-10-16 19:32:55');

-- --------------------------------------------------------

--
-- Table structure for table `Tb_Palavras`
--

CREATE TABLE IF NOT EXISTS `Tb_Palavras` (
`Id` int(11) NOT NULL,
  `Palavra` tinytext NOT NULL,
  `File` tinytext NOT NULL,
  `Ordem` int(11) NOT NULL
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=7 ;

--
-- Dumping data for table `Tb_Palavras`
--

INSERT INTO `Tb_Palavras` (`Id`, `Palavra`, `File`, `Ordem`) VALUES
(1, 'Sim', 'sim.mp3', 1),
(2, 'Não', 'nao.mp3', 2),
(3, 'Fome', 'fome.mp3', 3),
(4, 'Sede', 'sede.mp3', 4),
(5, 'Frio', 'frio.mp3', 6),
(6, 'Calor', 'calor.mp3', 5);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `Registros`
--
ALTER TABLE `Registros`
 ADD PRIMARY KEY (`Id`), ADD UNIQUE KEY `Id_2` (`Id`), ADD KEY `Id` (`Id`);

--
-- Indexes for table `Tb_Palavras`
--
ALTER TABLE `Tb_Palavras`
 ADD PRIMARY KEY (`Id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `Registros`
--
ALTER TABLE `Registros`
MODIFY `Id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=47;
--
-- AUTO_INCREMENT for table `Tb_Palavras`
--
ALTER TABLE `Tb_Palavras`
MODIFY `Id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=7;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
