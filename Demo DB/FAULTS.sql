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
-- Database: `FAULTS`
--

-- --------------------------------------------------------

--
-- Table structure for table `Base_Faults`
--

CREATE TABLE `Base_Faults` (
  `ID` int(11) NOT NULL,
  `LEVEL` text NOT NULL,
  `SHORT` text NOT NULL,
  `SYSTEM` text NOT NULL,
  `DESCRIPTION` text NOT NULL,
  `FIXES` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `Rover_Faults`
--

CREATE TABLE `Rover_Faults` (
  `ID` int(11) NOT NULL,
  `LEVEL` text NOT NULL,
  `SHORT` text NOT NULL,
  `SYSTEM` text NOT NULL,
  `DESCRIPTION` text NOT NULL,
  `FIXES` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `Rover_Faults`
--

INSERT INTO `Rover_Faults` (`ID`, `LEVEL`, `SHORT`, `SYSTEM`, `DESCRIPTION`, `FIXES`) VALUES
(1, 'CRITICAL', 'ACAS NO DATALINK', 'ACAS', 'ACAS System is not receiving data or current data is stale.', 'CHECK ACAS LINK'),
(2, 'CRITICAL', 'MAIN BATTERY UNDERVOLT', 'ELEC', 'The main battery has a low voltage.', 'REDUCE LOAD\r\nCHARGE BATTERY'),
(3, 'EMERGENCY', 'MAIN BATTERY OVERVOLT', 'ELEC', 'Main battery has too high of a voltage.', 'EMERGENCY SHUTDOWN\r\nDANGEROUS LIPO PROCEDURE'),
(4, 'CAUTION', 'MOTOR CAUTION CURRENT', 'ELEC', 'Motor system total current is at a cautionary level.', '0'),
(5, 'WARNING', 'MOTOR WARNING CURRENT', 'ELEC', 'Motor system is drawing a abnormally large amount of current.', 'CONSIDER MOTOR POWER REDUCTION'),
(6, 'CRITICAL', 'MOTOR CRITICAL CURRENT', 'ELEC', 'Motor system is drawing critically high amount of current.', 'REDUCE MOTOR POWER\r\nSHUTDOWN MOTORS'),
(7, 'INFO', 'LOAD SHED', 'ELEC', 'Load is being shed from unnecessary systems.', '0'),
(8, 'CRITICAL', 'POWER DISTRIBUTION FAULT', 'ELEC', 'Power distribution has a fault, check elec panel for more info.', 'CHECK ELEC PANEL'),
(9, 'CRITICAL', 'DRIVE 1 FAULT', 'DRIVE', 'Drive system number 1 has failed.', 'RESTART DRIVE\r\nIF STILL FAILED SHUTDOWN OPPOSING DRIVE'),
(10, 'CRITICAL', 'DRIVE 2 FAULT', 'DRIVE', 'Drive system number 2 has failed.', 'RESTART DRIVE\r\nIF STILL FAILED SHUTDOWN OPPOSING DRIVE'),
(11, 'CRITICAL', 'DRIVE 3 FAULT', 'DRIVE', 'Drive system number 3 has failed.', 'RESTART DRIVE\r\nIF STILL FAILED SHUTDOWN OPPOSING DRIVE'),
(12, 'CRITICAL', 'DRIVE 4 FAULT', 'DRIVE', 'Drive system number 4 has failed.', 'RESTART DRIVE\r\nIF STILL FAILED SHUTDOWN OPPOSING DRIVE'),
(13, 'CRITICAL', 'DRIVE 5 FAULT', 'DRIVE', 'Drive system number 5 has failed.', 'RESTART DRIVE\r\nIF STILL FAILED SHUTDOWN OPPOSING DRIVE'),
(14, 'CRITICAL', 'DRIVE 6 FAULT', 'DRIVE', 'Drive system number 6 has failed.', 'RESTART DRIVE\r\nIF STILL FAILED SHUTDOWN OPPOSING DRIVE'),
(15, 'INFO', 'ADVISORY PACKET DROP (<10ppm)', 'COMMS', 'Less than 10 packets per minute are being dropped.', '0'),
(16, 'CAUTION', 'CAUTION PACKET DROP (>10ppm)', 'COMMS', 'More than 10 packets per minute are being dropped.', 'CONSIDER ROVER RELOCATION'),
(17, 'WARNING', 'WARNING PACKET DROP (>20ppm)', 'COMMS', 'More than 20 packets per minute are being dropped, Some systems may run at reduced or no function.', 'CHECK RF OUTPUT LEVEL\r\nRELOCATE ROVER'),
(18, 'CRITICAL', 'CRITICAL PACKET DROP (>40ppm)', 'COMMS', 'More than 40 packets per minute are being dropped. Many systems may inaccessible including live driving.', 'INCREASE RF POWER\r\nRELOCATE ROVER'),
(19, 'EMERGENCY', 'TELEMETRY LOST', 'COMMS', 'All communication has been lost to the rover.', 'INCREASE RF POWER\r\nCONSIDER RECOVERY'),
(20, 'CRITICAL', 'INTERMITTENT TELEMETRY LOSS', 'COMMS', 'Full communications are frequently being lost.', 'INCREASE OUTPUT POWER\r\nRELOCATE ROVER\r\nTRY LOWER DATA AIRSPEED'),
(21, 'WARNING', 'AUTODRIVE FAIL', 'AUTONOMOUS', 'The autodrive system has failed and cannot be engaged.', 'CHECK CONTROL LAW\r\nRESTART AUTODRIVE SYSTEM'),
(22, 'CAUTION', 'AUTODRIVE DISCON', 'AUTONOMOUS', 'The autodrive system has been disconnected.', '0'),
(23, 'CAUTION', 'NAV NO PATH', 'AUTONOMOUS', 'Autodrive NAV mode has been enabled but no nav path has been loaded into the system.', 'LOAD NAV PATH'),
(24, 'WARNING', 'SYSTEM DEGRADED', 'CONTROL', 'The control law is in a degraded state.', 'CHECK CONTROL SENSE\r\nREBOOT CONTROL SYSTEM'),
(25, 'WARNING', 'ALTERNATE LAW', 'CONTROL', 'The control system has degraded into alternate law and some features and protections will be lost.', 'CHECK CONTROL SENSE\r\nREBOOT CONTROL SYSTEM'),
(26, 'CRITICAL', 'DIRECT LAW', 'CONTROL', 'The control system has now degraded into direct law, All protections are now lost and all autonomous systems are lost.', 'CHECK CONTROL SENSE\r\nREBOOT CONTROL SYSTEM'),
(27, 'EMERGENCY', 'BATTERY OVERCURRENT', 'ELEC', 'Too much current is being drawn from the battery.', 'SHED LOAD');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `Base_Faults`
--
ALTER TABLE `Base_Faults`
  ADD UNIQUE KEY `DATABASE_ID` (`ID`) USING BTREE;

--
-- Indexes for table `Rover_Faults`
--
ALTER TABLE `Rover_Faults`
  ADD UNIQUE KEY `DATABASE_ID` (`ID`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `Base_Faults`
--
ALTER TABLE `Base_Faults`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `Rover_Faults`
--
ALTER TABLE `Rover_Faults`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
