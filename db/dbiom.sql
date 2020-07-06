-- phpMyAdmin SQL Dump
-- version 4.6.5.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jul 06, 2020 at 03:52 AM
-- Server version: 10.1.21-MariaDB
-- PHP Version: 7.1.1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `dbiom`
--

-- --------------------------------------------------------

--
-- Table structure for table `tbiom`
--

CREATE TABLE `tbiom` (
  `noiom` char(13) NOT NULL,
  `tgliom` date NOT NULL,
  `kduser` char(10) NOT NULL,
  `ket` char(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tbiom`
--

INSERT INTO `tbiom` (`noiom`, `tgliom`, `kduser`, `ket`) VALUES
('2020/IOM/1', '2020-07-06', 'USR1000', 'INIT_IOM');

--
-- Triggers `tbiom`
--
DELIMITER $$
CREATE TRIGGER `nodiom_new` BEFORE INSERT ON `tbiom` FOR EACH ROW SET NEW.noiom = CONCAT(DATE_FORMAT(NOW(), "%Y"),"/IOM/",(SELECT SUBSTRING(MAX(noiom),10,13) + 1 from tbiom))
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `tbiomdet`
--

CREATE TABLE `tbiomdet` (
  `noiom` char(13) NOT NULL,
  `kditem` char(10) NOT NULL,
  `stsiom` char(1) NOT NULL,
  `tglselesai` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `tbitm`
--

CREATE TABLE `tbitm` (
  `kditem` char(10) NOT NULL,
  `nmitem` char(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tbitm`
--

INSERT INTO `tbitm` (`kditem`, `nmitem`) VALUES
('ITM1000', 'TEST ITEM');

-- --------------------------------------------------------

--
-- Table structure for table `tbuser`
--

CREATE TABLE `tbuser` (
  `kduser` char(10) NOT NULL,
  `nmuser` char(50) NOT NULL,
  `password` varchar(100) NOT NULL,
  `nmdept` char(50) NOT NULL,
  `stsappr` char(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tbuser`
--

INSERT INTO `tbuser` (`kduser`, `nmuser`, `password`, `nmdept`, `stsappr`) VALUES
('USR1000', 'admin', 'admin', 'admin', '2');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `tbiom`
--
ALTER TABLE `tbiom`
  ADD PRIMARY KEY (`noiom`),
  ADD KEY `kduser` (`kduser`);

--
-- Indexes for table `tbiomdet`
--
ALTER TABLE `tbiomdet`
  ADD KEY `noiom` (`noiom`),
  ADD KEY `kditem` (`kditem`);

--
-- Indexes for table `tbitm`
--
ALTER TABLE `tbitm`
  ADD PRIMARY KEY (`kditem`);

--
-- Indexes for table `tbuser`
--
ALTER TABLE `tbuser`
  ADD PRIMARY KEY (`kduser`);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `tbiom`
--
ALTER TABLE `tbiom`
  ADD CONSTRAINT `tbiom_ibfk_1` FOREIGN KEY (`kduser`) REFERENCES `tbuser` (`kduser`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `tbiomdet`
--
ALTER TABLE `tbiomdet`
  ADD CONSTRAINT `tbiomdet_ibfk_1` FOREIGN KEY (`noiom`) REFERENCES `tbiom` (`noiom`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `tbiomdet_ibfk_2` FOREIGN KEY (`kditem`) REFERENCES `tbitm` (`kditem`) ON DELETE CASCADE ON UPDATE CASCADE;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
