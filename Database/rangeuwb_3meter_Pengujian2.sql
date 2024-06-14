-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 05, 2024 at 11:27 AM
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
-- Table structure for table `rangeuwb`
--

CREATE TABLE `rangeuwb` (
  `id` int(11) NOT NULL,
  `idTag` int(11) NOT NULL,
  `idBeacon` int(11) NOT NULL,
  `dist` float NOT NULL,
  `time` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `rangeuwb`
--

INSERT INTO `rangeuwb` (`id`, `idTag`, `idBeacon`, `dist`, `time`) VALUES
(1, 1, 1, 2.6, '2024-06-05 09:20:19'),
(2, 1, 1, 2.6, '2024-06-05 09:20:24'),
(3, 1, 1, 2.61, '2024-06-05 09:20:29'),
(4, 1, 1, 2.6, '2024-06-05 09:20:34'),
(5, 1, 1, 2.6, '2024-06-05 09:20:39'),
(6, 1, 1, 2.59, '2024-06-05 09:20:44'),
(7, 1, 1, 2.61, '2024-06-05 09:20:49'),
(8, 1, 1, 2.6, '2024-06-05 09:20:54'),
(9, 1, 1, 2.59, '2024-06-05 09:20:59'),
(10, 1, 1, 2.6, '2024-06-05 09:21:04'),
(11, 1, 1, 2.6, '2024-06-05 09:21:09'),
(12, 1, 1, 2.59, '2024-06-05 09:21:14'),
(13, 1, 1, 2.6, '2024-06-05 09:21:19'),
(14, 1, 1, 2.6, '2024-06-05 09:21:24'),
(15, 1, 1, 2.6, '2024-06-05 09:21:29'),
(16, 1, 1, 2.6, '2024-06-05 09:21:34'),
(17, 1, 1, 2.61, '2024-06-05 09:21:39'),
(18, 1, 1, 2.61, '2024-06-05 09:21:44'),
(19, 1, 1, 2.61, '2024-06-05 09:21:49'),
(20, 1, 1, 2.59, '2024-06-05 09:21:54'),
(21, 1, 1, 2.6, '2024-06-05 09:21:59'),
(22, 1, 1, 2.61, '2024-06-05 09:22:04'),
(23, 1, 1, 2.67, '2024-06-05 09:22:09'),
(24, 1, 1, 2.59, '2024-06-05 09:22:14'),
(25, 1, 1, 2.61, '2024-06-05 09:22:19'),
(26, 1, 1, 2.59, '2024-06-05 09:22:24'),
(27, 1, 1, 2.6, '2024-06-05 09:22:29'),
(28, 1, 1, 2.59, '2024-06-05 09:22:34'),
(29, 1, 1, 2.59, '2024-06-05 09:22:39'),
(30, 1, 1, 2.58, '2024-06-05 09:22:44'),
(31, 1, 1, 2.59, '2024-06-05 09:22:49'),
(32, 1, 1, 2.6, '2024-06-05 09:22:54'),
(33, 1, 1, 2.6, '2024-06-05 09:22:59'),
(34, 1, 1, 2.59, '2024-06-05 09:23:04'),
(35, 1, 1, 2.59, '2024-06-05 09:23:09'),
(36, 1, 1, 2.58, '2024-06-05 09:23:14'),
(37, 1, 1, 2.59, '2024-06-05 09:23:19'),
(38, 1, 1, 2.58, '2024-06-05 09:23:24'),
(39, 1, 1, 2.58, '2024-06-05 09:23:29'),
(40, 1, 1, 2.58, '2024-06-05 09:23:34'),
(41, 1, 1, 2.58, '2024-06-05 09:23:39'),
(42, 1, 1, 2.59, '2024-06-05 09:23:44'),
(43, 1, 1, 2.57, '2024-06-05 09:23:49'),
(44, 1, 1, 2.59, '2024-06-05 09:23:54'),
(45, 1, 1, 2.59, '2024-06-05 09:23:59'),
(46, 1, 1, 2.6, '2024-06-05 09:24:04'),
(47, 1, 1, 2.58, '2024-06-05 09:24:09'),
(48, 1, 1, 2.59, '2024-06-05 09:24:14'),
(49, 1, 1, 2.6, '2024-06-05 09:24:19'),
(50, 1, 1, 2.59, '2024-06-05 09:24:24'),
(51, 1, 1, 2.58, '2024-06-05 09:24:29'),
(52, 1, 1, 2.59, '2024-06-05 09:24:34');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `rangeuwb`
--
ALTER TABLE `rangeuwb`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `rangeuwb`
--
ALTER TABLE `rangeuwb`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=53;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;