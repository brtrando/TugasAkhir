-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 05, 2024 at 03:30 PM
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
(615, 1, 'UWB', 0.130708, 3.94875, '2024-06-05 13:23:04'),
(616, 1, 'UWB', 4.77112, 4.10775, '2024-06-05 13:23:09'),
(617, 1, 'UWB', 4.7984, 4.12667, '2024-06-05 13:23:14'),
(618, 1, 'UWB', 4.80906, 4.03625, '2024-06-05 13:23:19'),
(619, 1, 'UWB', 4.80606, 4.083, '2024-06-05 13:23:24'),
(620, 1, 'UWB', 4.7807, 4.167, '2024-06-05 13:23:29'),
(621, 1, 'UWB', 4.80102, 4.04449, '2024-06-05 13:23:34'),
(622, 1, 'UWB', 96.0602, -300.042, '2024-06-05 13:23:39'),
(623, 1, 'UWB', 390.066, -1280.19, '2024-06-05 13:23:44'),
(624, 1, 'UWB', 5.4379, 1.97687, '2024-06-05 13:23:49'),
(625, 1, 'UWB', 4.81662, 4.04726, '2024-06-05 13:23:54'),
(626, 1, 'UWB', 4.78679, 4.10999, '2024-06-05 13:23:59'),
(627, 1, 'UWB', 4.82445, 4.00309, '2024-06-05 13:24:04'),
(628, 1, 'UWB', 4.80709, 4.11578, '2024-06-05 13:24:09'),
(629, 1, 'UWB', 4.83676, 4.01687, '2024-06-05 13:24:14'),
(630, 1, 'UWB', 4.8319, 4.08867, '2024-06-05 13:24:19'),
(631, 1, 'UWB', 4.83344, 4.02795, '2024-06-05 13:24:24'),
(632, 1, 'UWB', 4.81595, 4.05003, '2024-06-05 13:24:29'),
(633, 1, 'UWB', 4.8115, 4.083, '2024-06-05 13:24:34'),
(634, 1, 'UWB', 4.81595, 4.05003, '2024-06-05 13:24:39'),
(635, 1, 'UWB', 4.80709, 4.11578, '2024-06-05 13:24:44'),
(636, 1, 'UWB', 4.78424, 4.13753, '2024-06-05 13:24:49'),
(637, 1, 'UWB', 4.81355, 4.00309, '2024-06-05 13:24:54'),
(638, 1, 'UWB', 4.81809, 4.06104, '2024-06-05 13:24:59'),
(639, 1, 'UWB', 4.81693, 4.083, '2024-06-05 13:25:04'),
(640, 1, 'UWB', 4.82139, 4.05003, '2024-06-05 13:25:09'),
(641, 1, 'UWB', 4.95905, 4.37395, '2024-06-05 13:25:14'),
(642, 1, 'UWB', 4.58772, 4.86503, '2024-06-05 13:25:19'),
(643, 1, 'UWB', 4.50504, 5.14134, '2024-06-05 13:25:24'),
(644, 1, 'UWB', 4.22235, 6.08295, '2024-06-05 13:25:29'),
(645, 1, 'UWB', 4.63676, 4.68354, '2024-06-05 13:25:34'),
(646, 1, 'UWB', 4.66302, 4.7625, '2024-06-05 13:25:39'),
(647, 1, 'UWB', 4.62403, 4.68922, '2024-06-05 13:25:44'),
(648, 1, 'UWB', 4.63965, 4.63646, '2024-06-05 13:25:49'),
(649, 1, 'UWB', 4.62695, 4.6795, '2024-06-05 13:25:54'),
(650, 1, 'UWB', 4.65983, 4.62467, '2024-06-05 13:25:59'),
(651, 1, 'UWB', 4.6284, 4.656, '2024-06-05 13:26:04'),
(652, 1, 'UWB', 4.65058, 4.71117, '2024-06-05 13:26:09'),
(653, 1, 'UWB', 4.64217, 4.68354, '2024-06-05 13:26:14'),
(654, 1, 'UWB', 4.70685, 4.5965, '2024-06-05 13:26:19'),
(655, 1, 'UWB', 4.6328, 4.66, '2024-06-05 13:26:24'),
(656, 1, 'UWB', 4.64117, 4.68758, '2024-06-05 13:26:29'),
(657, 1, 'UWB', 4.65102, 4.58117, '2024-06-05 13:26:34'),
(658, 1, 'UWB', 4.63134, 4.68354, '2024-06-05 13:26:39'),
(659, 1, 'UWB', 4.6347, 4.6542, '2024-06-05 13:26:44'),
(660, 1, 'UWB', 4.64458, 4.62075, '2024-06-05 13:26:49'),
(661, 1, 'UWB', 4.65387, 4.60699, '2024-06-05 13:26:54'),
(662, 1, 'UWB', 4.65591, 4.601, '2024-06-05 13:26:59'),
(663, 1, 'UWB', 4.63821, 4.66, '2024-06-05 13:27:04'),
(664, 1, 'UWB', 4.65687, 4.63453, '2024-06-05 13:27:09'),
(665, 1, 'UWB', 4.64114, 4.65022, '2024-06-05 13:27:14'),
(666, 1, 'UWB', 4.65538, 4.62075, '2024-06-05 13:27:19'),
(667, 1, 'UWB', 4.66133, 4.63847, '2024-06-05 13:27:24'),
(668, 1, 'UWB', 4.65392, 4.64437, '2024-06-05 13:27:29'),
(669, 1, 'UWB', 4.65687, 4.63453, '2024-06-05 13:27:34'),
(670, 1, 'UWB', 4.63179, 4.62666, '2024-06-05 13:27:39'),
(671, 1, 'UWB', 4.63426, 4.63646, '2024-06-05 13:27:44'),
(672, 1, 'UWB', 4.65294, 4.61089, '2024-06-05 13:27:49'),
(673, 1, 'UWB', 4.63969, 4.67378, '2024-06-05 13:27:54');

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=677;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
