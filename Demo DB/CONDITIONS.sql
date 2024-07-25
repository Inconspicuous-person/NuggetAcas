-- phpMyAdmin SQL Dump
-- version 5.2.1deb1
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Jul 25, 2024 at 12:36 PM
-- Server version: 10.11.6-MariaDB-0+deb12u1
-- PHP Version: 8.2.18

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `CONDITIONS`
--

-- --------------------------------------------------------

--
-- Table structure for table `Rover_Limits`
--

CREATE TABLE `Rover_Limits` (
  `ID` int(11) NOT NULL,
  `NAME` text NOT NULL,
  `VALUE` text NOT NULL,
  `DESCRIPTION` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `Rover_Limits`
--

INSERT INTO `Rover_Limits` (`ID`, `NAME`, `VALUE`, `DESCRIPTION`) VALUES
(1, 'BATTERY_VOLT_MIN', '11.1', 'Minimum allowed battery voltage'),
(2, 'BATTERY_VOLT_MAX', '14', 'Maximum allowed battery voltage.'),
(3, 'MOTOR_CURRENT_MAX', '10', 'Maximum allowed total motor current.'),
(4, 'BATTERY_CURRENT_MAX', '20', 'Maximum allowable current to be drawn from the battery.'),
(5, 'ACAS_TIMEOUT', '2', 'Time in seconds since last acas update until \"ACAS NO DATALINK\" is displayed');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `Rover_Limits`
--
ALTER TABLE `Rover_Limits`
  ADD UNIQUE KEY `DATABASE_ID` (`ID`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `Rover_Limits`
--
ALTER TABLE `Rover_Limits`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
