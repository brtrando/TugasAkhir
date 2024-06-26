-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 05, 2024 at 01:43 PM
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

-- Total Data = 60

INSERT INTO `koordinattag` (`id`, `idTag`, `tipe`, `xtag`, `ytag`, `time`) VALUES
(1, 1, 'BLE', 3.26811, 3.0794, '2024-06-05 11:27:52'),
(2, 1, 'BLE', 3.2321, 2.88543, '2024-06-05 11:28:04'),
(3, 1, 'BLE', 3.26658, 2.96573, '2024-06-05 11:28:10'),
(4, 1, 'BLE', 3.24138, 2.90288, '2024-06-05 11:28:17'),
(5, 1, 'BLE', 3.19798, 2.61511, '2024-06-05 11:28:23'),
(6, 1, 'BLE', 3.16888, 2.7928, '2024-06-05 11:28:28'),
(7, 1, 'BLE', 3.13507, 2.93715, '2024-06-05 11:28:47'),
(8, 1, 'BLE', 3.23711, 3.10692, '2024-06-05 11:28:53'),
(9, 1, 'BLE', 3.19884, 3.16476, '2024-06-05 11:28:59'),
(10, 1, 'BLE', 3.25437, 3.17051, '2024-06-05 11:29:05'),
(11, 1, 'BLE', 3.22737, 3.17051, '2024-06-05 11:29:11'),
(12, 1, 'BLE', 3.26043, 3.12911, '2024-06-05 11:29:17'),
(13, 1, 'BLE', 3.3225, 2.8366, '2024-06-05 11:29:23'),
(14, 1, 'BLE', 3.38956, 3.0395, '2024-06-05 11:29:29'),
(15, 1, 'BLE', 3.22661, 2.84831, '2024-06-05 11:29:35'),
(16, 1, 'BLE', 3.19314, 2.71043, '2024-06-05 11:29:41'),
(17, 1, 'BLE', 3.21137, 2.81479, '2024-06-05 11:29:47'),
(18, 1, 'BLE', 3.19859, 2.90044, '2024-06-05 11:29:53'),
(19, 1, 'BLE', 3.07192, 2.83478, '2024-06-05 11:29:59'),
(20, 1, 'BLE', 3.01499, 2.75281, '2024-06-05 11:30:05'),
(21, 1, 'BLE', 3.07644, 2.80816, '2024-06-05 11:30:11'),
(22, 1, 'BLE', 3.14756, 2.93064, '2024-06-05 11:30:17'),
(23, 1, 'BLE', 3.15769, 2.84834, '2024-06-05 11:30:23'),
(24, 1, 'BLE', 3.17711, 2.87807, '2024-06-05 11:30:29'),
(25, 1, 'BLE', 3.20026, 2.93495, '2024-06-05 11:30:35'),
(26, 1, 'BLE', 3.15112, 2.78691, '2024-06-05 11:30:41'),
(27, 1, 'BLE', 3.1252, 2.78691, '2024-06-05 11:30:47'),
(28, 1, 'BLE', 3.12889, 2.85683, '2024-06-05 11:30:53'),
(29, 1, 'BLE', 3.06062, 2.93715, '2024-06-05 11:30:59'),
(30, 1, 'BLE', 3.15069, 2.89544, '2024-06-05 11:31:06'),
(31, 1, 'BLE', 3.13689, 2.8533, '2024-06-05 11:31:11'),
(32, 1, 'BLE', 3.16406, 2.98508, '2024-06-05 11:31:17'),
(33, 1, 'BLE', 3.15605, 3.01765, '2024-06-05 11:31:23'),
(34, 1, 'BLE', 3.18489, 2.89544, '2024-06-05 11:31:29'),
(35, 1, 'BLE', 3.27258, 3.02095, '2024-06-05 11:31:35'),
(36, 1, 'BLE', 3.27323, 2.90171, '2024-06-05 11:31:41'),
(37, 1, 'BLE', 3.27033, 2.75339, '2024-06-05 11:31:54'),
(38, 1, 'BLE', 3.19028, 2.8533, '2024-06-05 11:32:00'),
(39, 1, 'BLE', 3.25446, 3.0526, '2024-06-05 11:32:06'),
(40, 1, 'BLE', 3.19929, 3.04042, '2024-06-05 11:32:18'),
(41, 1, 'BLE', 3.34843, 3.10174, '2024-06-05 11:32:24'),
(42, 1, 'BLE', 3.16535, 2.88611, '2024-06-05 11:32:30'),
(43, 1, 'BLE', 3.13179, 2.83794, '2024-06-05 11:32:36'),
(44, 1, 'BLE', 3.21358, 2.97977, '2024-06-05 11:32:42'),
(45, 1, 'BLE', 3.24503, 3.09962, '2024-06-05 11:32:48'),
(46, 1, 'BLE', 3.20679, 3.02971, '2024-06-05 11:32:54'),
(47, 1, 'BLE', 3.25358, 2.81479, '2024-06-05 11:33:00'),
(48, 1, 'BLE', 3.04773, 2.6149, '2024-06-05 11:33:12'),
(49, 1, 'BLE', 2.97577, 2.97243, '2024-06-05 11:33:18'),
(50, 1, 'BLE', 3.13471, 2.88611, '2024-06-05 11:33:24'),
(51, 1, 'BLE', 3.11183, 2.83794, '2024-06-05 11:33:30'),
(52, 1, 'BLE', 3.09454, 2.77744, '2024-06-05 11:33:36'),
(53, 1, 'BLE', 3.16176, 2.85989, '2024-06-05 11:33:42'),
(54, 1, 'BLE', 3.18067, 2.9846, '2024-06-05 11:33:48'),
(55, 1, 'BLE', 3.18831, 3.01812, '2024-06-05 11:33:54'),
(56, 1, 'BLE', 3.11883, 2.82153, '2024-06-05 11:34:00'),
(57, 1, 'BLE', 3.14474, 2.88968, '2024-06-05 11:34:06'),
(58, 1, 'BLE', 3.13689, 2.8533, '2024-06-05 11:34:18'),
(59, 1, 'BLE', 3.17464, 2.7928, '2024-06-05 11:34:24'),
(60, 1, 'BLE', 3.18563, 2.709, '2024-06-05 11:34:30');

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=127;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
