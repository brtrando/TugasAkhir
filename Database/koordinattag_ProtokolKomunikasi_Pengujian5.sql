-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 14, 2024 at 07:54 AM
-- Server version: 10.4.24-MariaDB
-- PHP Version: 7.4.29

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `ips_database`
--

-- --------------------------------------------------------

--
-- Table structure for table `koordinattag`
--

CREATE TABLE `koordinattag` (
  `id` int(11) NOT NULL,
  `idTag` int(11) NOT NULL,
  `tipe` varchar(255) NOT NULL,
  `xtag` float NOT NULL,
  `ytag` float NOT NULL,
  `time` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `koordinattag`
--

INSERT INTO `koordinattag` (`id`, `idTag`, `tipe`, `xtag`, `ytag`, `time`) VALUES
(693, 1, 'BLE', 2.88962, 2.71772, '2024-06-11 09:58:57'),
(694, 1, 'BLE', 2.88962, 2.71772, '2024-06-11 09:58:57'),
(695, 1, 'UWB', 2.12289, 4.35563, '2024-06-11 09:59:07'),
(696, 1, 'UWB', 2.12289, 4.35563, '2024-06-11 09:59:07'),
(697, 1, 'UWB', 2.12289, 4.35563, '2024-06-11 09:59:07'),
(698, 1, 'UWB', 2.09689, 4.34342, '2024-06-11 09:59:13'),
(699, 1, 'UWB', 2.09689, 4.34342, '2024-06-11 09:59:13'),
(700, 1, 'UWB', 2.09689, 4.34342, '2024-06-11 09:59:13'),
(701, 1, 'UWB', 2.11524, 4.38013, '2024-06-11 09:59:17'),
(702, 1, 'UWB', 2.11524, 4.38013, '2024-06-11 09:59:17'),
(703, 1, 'UWB', 2.11524, 4.38013, '2024-06-11 09:59:17'),
(704, 1, 'UWB', 2.0943, 4.37493, '2024-06-11 09:59:22'),
(705, 1, 'UWB', 2.0943, 4.37493, '2024-06-11 09:59:22'),
(706, 1, 'UWB', 2.0943, 4.37493, '2024-06-11 09:59:22'),
(707, 1, 'UWB', 2.10078, 4.40156, '2024-06-11 09:59:27'),
(708, 1, 'UWB', 2.10078, 4.40156, '2024-06-11 09:59:27'),
(709, 1, 'UWB', 2.10078, 4.40156, '2024-06-11 09:59:27'),
(710, 1, 'UWB', 2.10146, 4.35257, '2024-06-11 09:59:33'),
(711, 1, 'UWB', 2.10146, 4.35257, '2024-06-11 09:59:33'),
(712, 1, 'UWB', 2.10146, 4.35257, '2024-06-11 09:59:33'),
(713, 1, 'UWB', 2.10541, 4.41082, '2024-06-11 09:59:37'),
(714, 1, 'UWB', 2.10541, 4.41082, '2024-06-11 09:59:37'),
(715, 1, 'UWB', 2.10541, 4.41082, '2024-06-11 09:59:37'),
(716, 1, 'UWB', 2.08235, 4.3647, '2024-06-11 09:59:42'),
(717, 1, 'UWB', 2.08235, 4.3647, '2024-06-11 09:59:42'),
(718, 1, 'UWB', 2.08235, 4.3647, '2024-06-11 09:59:42');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `koordinattag`
--
ALTER TABLE `koordinattag`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `koordinattag`
--
ALTER TABLE `koordinattag`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=884;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
