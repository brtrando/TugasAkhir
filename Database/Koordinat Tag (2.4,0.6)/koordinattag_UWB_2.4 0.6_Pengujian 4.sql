-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 05, 2024 at 02:39 PM
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
(340, 1, 'UWB', 2.19127, 0.699292, '2024-06-05 12:32:39'),
(341, 1, 'UWB', 2.18062, 0.684167, '2024-06-05 12:32:45'),
(342, 1, 'UWB', 2.10684, 0.771635, '2024-06-05 12:32:50'),
(343, 1, 'UWB', 2.16572, 0.32425, '2024-06-05 12:32:55'),
(344, 1, 'UWB', 1.93052, 0.8195, '2024-06-05 12:32:59'),
(345, 1, 'UWB', 2.08192, 0.600281, '2024-06-05 12:33:05'),
(346, 1, 'UWB', 1.79323, 0.605052, '2024-06-05 12:33:09'),
(347, 1, 'UWB', 1.64278, 0.759167, '2024-06-05 12:33:14'),
(348, 1, 'UWB', 1.7264, 0.92201, '2024-06-05 12:33:19'),
(349, 1, 'UWB', 1.65396, 0.841677, '2024-06-05 12:33:24'),
(350, 1, 'UWB', 1.69551, 0.892302, '2024-06-05 12:33:30'),
(351, 1, 'UWB', 1.70093, 0.732594, '2024-06-05 12:33:35'),
(352, 1, 'UWB', 1.76821, 0.821094, '2024-06-05 12:33:39'),
(353, 1, 'UWB', 1.70932, 0.858281, '2024-06-05 12:33:45'),
(354, 1, 'UWB', 1.8286, 0.896531, '2024-06-05 12:33:50'),
(355, 1, 'UWB', 1.70576, 0.680792, '2024-06-05 12:33:54'),
(356, 1, 'UWB', 1.72235, 0.636083, '2024-06-05 12:33:59'),
(357, 1, 'UWB', 1.80157, 0.63075, '2024-06-05 12:34:09'),
(358, 1, 'UWB', 1.7845, 0.823656, '2024-06-05 12:34:15'),
(359, 1, 'UWB', 2.19668, 0.4825, '2024-06-05 12:34:19'),
(360, 1, 'UWB', 2.29746, 0.229031, '2024-06-05 12:34:24'),
(361, 1, 'UWB', 2.34167, 0.303333, '2024-06-05 12:34:30'),
(362, 1, 'UWB', 2.53573, -0.221781, '2024-06-05 12:34:34'),
(363, 1, 'UWB', 2.21392, 0.737698, '2024-06-05 12:34:39'),
(364, 1, 'UWB', 2.21369, 0.492573, '2024-06-05 12:34:45'),
(365, 1, 'UWB', 2.43785, -0.110156, '2024-06-05 12:34:49'),
(366, 1, 'UWB', 2.34815, 0.201375, '2024-06-05 12:34:54'),
(367, 1, 'UWB', 2.33882, 0.514083, '2024-06-05 12:34:59'),
(368, 1, 'UWB', 2.35359, 0.701333, '2024-06-05 12:35:04'),
(369, 1, 'UWB', 2.42955, 0.31951, '2024-06-05 12:35:09'),
(370, 1, 'UWB', 2.20094, 0.560542, '2024-06-05 12:35:15'),
(371, 1, 'UWB', 2.23001, 0.45501, '2024-06-05 12:35:19'),
(372, 1, 'UWB', 2.2701, 0.175125, '2024-06-05 12:35:24'),
(373, 1, 'UWB', 2.23045, 0.495042, '2024-06-05 12:35:29'),
(374, 1, 'UWB', 2.37927, 0.499292, '2024-06-05 12:35:35'),
(375, 1, 'UWB', 2.4777, -0.0173333, '2024-06-05 12:35:39'),
(376, 1, 'UWB', 2.33094, 0.488542, '2024-06-05 12:35:44'),
(377, 1, 'UWB', 2.98371, 0.605, '2024-06-05 12:35:49'),
(378, 1, 'UWB', 2.33367, 0.585094, '2024-06-05 12:35:54'),
(379, 1, 'UWB', 2.29985, 0.555844, '2024-06-05 12:35:59'),
(380, 1, 'UWB', 2.34411, 0.624969, '2024-06-05 12:36:04'),
(381, 1, 'UWB', 2.27752, 0.531, '2024-06-05 12:36:09'),
(382, 1, 'UWB', 2.27366, 0.569875, '2024-06-05 12:36:14'),
(383, 1, 'UWB', 2.27657, 0.555219, '2024-06-05 12:36:19'),
(384, 1, 'UWB', 2.28749, 0.580031, '2024-06-05 12:36:24'),
(385, 1, 'UWB', 2.27875, 0.56551, '2024-06-05 12:36:29'),
(386, 1, 'UWB', 2.29352, 0.559948, '2024-06-05 12:36:35'),
(387, 1, 'UWB', 2.31632, 0.640667, '2024-06-05 12:36:39'),
(388, 1, 'UWB', 2.28067, 0.550333, '2024-06-05 12:36:45'),
(389, 1, 'UWB', 2.29313, 0.56525, '2024-06-05 12:36:49'),
(390, 1, 'UWB', 458.412, -1519.87, '2024-06-05 12:36:55'),
(391, 1, 'UWB', 2.2443, 0.693917, '2024-06-05 12:37:04'),
(392, 1, 'UWB', 2.16182, 0.640385, '2024-06-05 12:37:10'),
(393, 1, 'UWB', 2.19602, 0.737281, '2024-06-05 12:37:14'),
(394, 1, 'UWB', 2.27069, 0.798698, '2024-06-05 12:37:19'),
(395, 1, 'UWB', 2.27271, 0.758615, '2024-06-05 12:37:24');

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=400;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
