-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 05, 2024 at 11:32 AM
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
-- Table structure for table `rssible`
--

CREATE TABLE `rssible` (
  `id` int(11) NOT NULL,
  `idTag` int(11) NOT NULL,
  `idBeacon` int(11) NOT NULL,
  `rssi` int(11) NOT NULL,
  `time` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `rssible`
--

INSERT INTO `rssible` (`id`, `idTag`, `idBeacon`, `rssi`, `time`) VALUES
(1, 1, 1, -84, '2024-06-05 09:06:18'),
(2, 1, 1, -85, '2024-06-05 09:06:24'),
(3, 1, 1, -85, '2024-06-05 09:06:30'),
(4, 1, 1, -84, '2024-06-05 09:06:36'),
(5, 1, 1, -84, '2024-06-05 09:06:42'),
(6, 1, 1, -85, '2024-06-05 09:06:48'),
(7, 1, 1, -85, '2024-06-05 09:06:54'),
(8, 1, 1, -85, '2024-06-05 09:07:00'),
(9, 1, 1, -85, '2024-06-05 09:07:06'),
(10, 1, 1, -84, '2024-06-05 09:07:12'),
(11, 1, 1, -88, '2024-06-05 09:07:18'),
(12, 1, 1, -85, '2024-06-05 09:07:24'),
(13, 1, 1, -83, '2024-06-05 09:07:30'),
(14, 1, 1, -84, '2024-06-05 09:07:36'),
(15, 1, 1, -83, '2024-06-05 09:07:42'),
(16, 1, 1, -83, '2024-06-05 09:07:48'),
(17, 1, 1, -81, '2024-06-05 09:07:54'),
(18, 1, 1, -82, '2024-06-05 09:08:00'),
(19, 1, 1, -81, '2024-06-05 09:08:06'),
(20, 1, 1, -81, '2024-06-05 09:08:12'),
(21, 1, 1, -84, '2024-06-05 09:08:18'),
(22, 1, 1, -81, '2024-06-05 09:08:24'),
(23, 1, 1, -81, '2024-06-05 09:08:31'),
(24, 1, 1, -82, '2024-06-05 09:08:36'),
(25, 1, 1, -84, '2024-06-05 09:08:42'),
(26, 1, 1, -80, '2024-06-05 09:08:48'),
(27, 1, 1, -81, '2024-06-05 09:08:54'),
(28, 1, 1, -81, '2024-06-05 09:09:00'),
(29, 1, 1, -85, '2024-06-05 09:09:06'),
(30, 1, 1, -86, '2024-06-05 09:09:13'),
(31, 1, 1, -85, '2024-06-05 09:09:19'),
(32, 1, 1, -86, '2024-06-05 09:09:25'),
(33, 1, 1, -86, '2024-06-05 09:09:31'),
(34, 1, 1, -86, '2024-06-05 09:09:37'),
(35, 1, 1, -87, '2024-06-05 09:09:43'),
(36, 1, 1, -85, '2024-06-05 09:09:49'),
(37, 1, 1, -85, '2024-06-05 09:09:55'),
(38, 1, 1, -84, '2024-06-05 09:10:01'),
(39, 1, 1, -87, '2024-06-05 09:10:07'),
(40, 1, 1, -85, '2024-06-05 09:10:13'),
(41, 1, 1, -85, '2024-06-05 09:10:19'),
(42, 1, 1, -88, '2024-06-05 09:20:04'),
(43, 1, 1, -85, '2024-06-05 09:20:10'),
(44, 1, 1, -84, '2024-06-05 09:30:05'),
(45, 1, 1, -73, '2024-06-05 09:30:17'),
(46, 1, 1, -78, '2024-06-05 09:30:23'),
(47, 1, 1, -85, '2024-06-05 09:30:29'),
(48, 1, 1, -86, '2024-06-05 09:30:35'),
(49, 1, 1, -84, '2024-06-05 09:30:42'),
(50, 1, 1, -84, '2024-06-05 09:30:48'),
(51, 1, 1, -84, '2024-06-05 09:30:54');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `rssible`
--
ALTER TABLE `rssible`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `rssible`
--
ALTER TABLE `rssible`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=52;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
