-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 09, 2026 at 04:37 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `pweb_gio`
--

-- --------------------------------------------------------

--
-- Table structure for table `attendances`
--

CREATE TABLE `attendances` (
  `id` int(11) NOT NULL,
  `participant_id` int(11) NOT NULL,
  `session_id` int(11) NOT NULL,
  `attendance_time` datetime DEFAULT current_timestamp(),
  `status` varchar(20) DEFAULT 'present'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `certificates`
--

CREATE TABLE `certificates` (
  `id` int(11) NOT NULL,
  `participant_id` int(11) DEFAULT NULL,
  `event_id` int(11) DEFAULT NULL,
  `file_url` text DEFAULT NULL,
  `issued_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `events`
--

CREATE TABLE `events` (
  `id` int(11) NOT NULL,
  `title` varchar(150) NOT NULL,
  `description` text DEFAULT NULL,
  `date` date NOT NULL,
  `jam_mulai` time DEFAULT NULL,
  `jam_selesai` time DEFAULT NULL,
  `location` varchar(150) DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `end_date` date DEFAULT NULL,
  `start_time` time DEFAULT NULL,
  `end_time` time DEFAULT NULL,
  `category` varchar(100) DEFAULT NULL,
  `price` int(11) DEFAULT 0,
  `img_source` longtext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `events`
--

INSERT INTO `events` (`id`, `title`, `description`, `date`, `jam_mulai`, `jam_selesai`, `location`, `created_by`, `created_at`, `end_date`, `start_time`, `end_time`, `category`, `price`, `img_source`) VALUES
(6, 'Mengenal Dasar UI/UX', 'Kita belajar dari awal yaa', '2026-05-20', NULL, NULL, 'Tirtonadi Convention Main Hall', 21, '2026-05-19 17:59:14', '2026-05-21', '09:00:00', '17:00:00', 'seminar', 75000, '/uploads/events/6bc230e60b7b0d6b.png'),
(8, 'Cyber Security', 'Yuk belajar bareng.', '2026-05-21', NULL, NULL, 'Upitra Main Hall', 21, '2026-05-19 19:38:21', '2026-05-21', '08:00:00', '12:00:00', 'seminar', 0, '/uploads/events/9150c1380ccfbee6.jpeg'),
(10, 'Techno Cyber', 'Akan dihadiri oleh Bp. Walikota Surakarta', '2026-06-09', NULL, NULL, 'Solo Convention Hall', 21, '2026-06-06 19:40:00', '2026-06-09', '10:40:00', '12:00:00', 'pelatihan', 25000, '/uploads/events/f1803faeb2d405f2.jpg'),
(11, 'AI & Machine Learning Bootcamp 2026', 'Ada pembicara hebat datang', '2026-06-14', NULL, NULL, 'Universitas Pignatelli Triputra', 21, '2026-06-09 12:21:51', '2026-06-14', '08:00:00', '17:00:00', 'workshop', 0, '/uploads/events/8aad3ff3eb9aa348.jpg'),
(12, 'Full Stack Web Development Workshop', 'Let\'s Goooooo', '2026-06-16', NULL, NULL, 'Cititex Hall', 21, '2026-06-09 12:30:12', '2026-06-16', '08:00:00', '17:00:00', 'workshop', 100000, '/uploads/events/86fe85e0b58204d4.jpg'),
(13, 'Pembelajaran UI/UX 2026', 'Akan didatangi oleh Bpk. Walikota', '2026-06-11', NULL, NULL, 'Upitra Main Hall', 21, '2026-06-09 18:44:09', '2026-06-11', '09:00:00', '11:00:00', 'seminar', 10000, '/uploads/events/758be07fb5eb2562.jpeg'),
(14, 'Cyber Security', 'Akan ada banyak doorprize', '2026-06-20', NULL, NULL, 'Upitra Main Hall', 21, '2026-06-09 19:48:56', '2026-06-20', '08:00:00', '12:00:00', 'seminar', 0, '/uploads/events/c512a88c768ce484.jpeg');

-- --------------------------------------------------------

--
-- Table structure for table `feedback`
--

CREATE TABLE `feedback` (
  `id` int(11) NOT NULL,
  `participant_id` int(11) DEFAULT NULL,
  `event_id` int(11) DEFAULT NULL,
  `rating` int(11) DEFAULT NULL,
  `comment` text DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp()
) ;

--
-- Dumping data for table `feedback`
--

INSERT INTO `feedback` (`id`, `participant_id`, `event_id`, `rating`, `comment`, `created_at`) VALUES
(1, 3, 8, 1, 'yang ngajar tolol', '2026-06-06 13:14:55'),
(2, 2, 6, 5, 'keren coy', '2026-06-06 13:15:46'),
(3, 4, 6, 5, 'Mantab jiwa', '2026-06-06 14:03:53'),
(4, 6, 12, 4, 'Gokil Abissss', '2026-06-09 12:48:24'),
(5, 7, 12, 4, 'Acara Seru', '2026-06-09 19:53:29'),
(6, 8, 11, 5, 'Mantab Banget Acaranya', '2026-06-09 20:20:49');

-- --------------------------------------------------------

--
-- Table structure for table `participants`
--

CREATE TABLE `participants` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `event_id` int(11) DEFAULT NULL,
  `status` varchar(20) DEFAULT 'registered',
  `booking_code` varchar(50) DEFAULT NULL,
  `registered_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `participants`
--

INSERT INTO `participants` (`id`, `user_id`, `event_id`, `status`, `booking_code`, `registered_at`) VALUES
(2, 24, 6, 'attended', 'BK-17E3A0C7', '2026-06-06 11:05:58'),
(3, 24, 8, 'attended', 'BK-799E6F12', '2026-06-06 12:37:34'),
(4, 25, 6, 'attended', 'BK-D7308526', '2026-06-06 14:03:39'),
(5, 24, 10, 'attended', 'BK-ED72637C', '2026-06-06 19:45:48'),
(6, 24, 12, 'attended', 'BK-79C5E6C8', '2026-06-09 12:42:30'),
(7, 27, 12, 'attended', 'BK-5B11A2BB', '2026-06-09 19:45:09'),
(8, 28, 11, 'attended', 'BK-45DA2BAC', '2026-06-09 20:13:47'),
(9, 28, 12, 'registered', 'BK-876BE5AD', '2026-06-09 20:21:59');

-- --------------------------------------------------------

--
-- Table structure for table `permissions`
--

CREATE TABLE `permissions` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `permissions`
--

INSERT INTO `permissions` (`id`, `name`) VALUES
(1, 'create_event'),
(3, 'delete_event'),
(2, 'edit_event'),
(6, 'give_feedback'),
(7, 'manage_session'),
(5, 'register_event'),
(4, 'view_dashboard');

-- --------------------------------------------------------

--
-- Table structure for table `roles`
--

CREATE TABLE `roles` (
  `id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `roles`
--

INSERT INTO `roles` (`id`, `name`) VALUES
(1, 'penyelenggara'),
(2, 'peserta'),
(3, 'speaker');

-- --------------------------------------------------------

--
-- Table structure for table `role_permissions`
--

CREATE TABLE `role_permissions` (
  `role_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `role_permissions`
--

INSERT INTO `role_permissions` (`role_id`, `permission_id`) VALUES
(1, 1),
(1, 2),
(1, 3),
(1, 4),
(2, 5),
(2, 6),
(3, 7);

-- --------------------------------------------------------

--
-- Table structure for table `sessions`
--

CREATE TABLE `sessions` (
  `id` int(11) NOT NULL,
  `event_id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `session_date` date DEFAULT NULL,
  `session_time` varchar(100) DEFAULT NULL,
  `speaker` varchar(255) DEFAULT NULL,
  `capacity` int(11) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `sessions`
--

INSERT INTO `sessions` (`id`, `event_id`, `title`, `session_date`, `session_time`, `speaker`, `capacity`, `created_at`) VALUES
(1, 6, 'Opening Ceremony', '2026-05-18', '09.00-10.30', 'Dr. Sadarsa Handono', 50, '2026-05-19 11:16:27'),
(5, 6, 'Sesi 1 : Menentukan Pengguna dan Tujuan', '2026-05-20', '10.30 - 12.00', 'Norlan Kasino', 50, '2026-05-19 12:26:33'),
(6, 6, 'Ishoma', '2026-05-20', '12.00 - 13.00', '-', 50, '2026-05-19 12:29:30'),
(7, 6, 'Sesi 2 : Arsitektur Informasi', '2026-05-20', '13.00 - 14.30', 'Norberth Dahlan', 50, '2026-05-19 12:30:39'),
(8, 6, 'Sesi 3 : WireFraming', '2026-05-20', '14.30 - 16.00', 'Norberth Dahlan', 50, '2026-05-19 12:31:42'),
(9, 6, 'Sesi 4 : Prototyping', '2026-05-20', '14.30 - 16.00', 'Dedy Corbuzier', 50, '2026-05-19 12:32:22'),
(11, 8, 'Cara Melindungi Data Pribadi', '2026-05-20', '08.00 - 12.00', 'Cindy Arnanda', 30, '2026-05-19 12:38:26'),
(13, 10, 'Opening Ceremony', '2026-06-09', '10.50 - 11.15', 'Dedy Corbuzier', 25, '2026-06-06 12:40:51'),
(14, 10, 'Cara menjaga data pribadi', '2026-06-08', '11.15 - 14.00', 'Eag Magdalena', 25, '2026-06-06 12:41:47'),
(15, 11, 'Registrasi & Opening Ceremony', '2026-06-14', '08.00 - 08.30', 'Panitia', 50, '2026-06-09 05:22:52'),
(16, 11, 'Mengenal Artificial Intelligence di Era Digital', '2026-06-14', '08.30 - 10.00', 'Dr. Andi Prasetyo, M.Kom', 50, '2026-06-09 05:23:56'),
(17, 11, 'Dasar-Dasar Machine Learning', '2026-06-14', '10.15 - 11.45', 'Dr. Andi Prasetyo, M.Kom', 50, '2026-06-09 05:24:23'),
(18, 11, 'Praktik Machine Learning dengan Python', '2026-06-14', '13.00 - 14.30', 'Nabila Putri, S.Kom., M.Sc', 50, '2026-06-09 05:24:57'),
(19, 11, 'Implementasi AI dalam Dunia Industri', '2026-06-14', '14.45 - 16.15', 'Ir. Kevin Hartanto, M.T.', 50, '2026-06-09 05:26:05'),
(20, 11, 'Q&A dan Penutupan', '2026-06-14', '16.15 - 17.00', 'Seluruh Pembicara', 50, '2026-06-09 05:26:26'),
(21, 12, 'Registrasi Peserta', '2026-06-16', '08.00 - 08.30', 'Panitia', 50, '2026-06-09 05:31:14'),
(22, 12, 'Modern HTML, CSS & JavaScript', '2026-06-16', '08.30 - 10.00', 'Budi Santoso, S.Kom., M.T.', 50, '2026-06-09 05:31:40'),
(23, 12, 'Backend Development dengan PHP & Laravel', '2026-06-16', '10.15 - 11.45', 'Muhammad Rizky, S.T.', 50, '2026-06-09 05:33:02'),
(24, 12, 'Database Design & API Integration', '2026-06-16', '13.00 - 14.30', 'Siti Rahmawati, M.Kom', 50, '2026-06-09 05:34:19'),
(25, 12, 'Deploy Website ke Cloud Server', '2026-06-16', '14.45 - 16.15', 'Budi Santoso, S.Kom., M.T.', 50, '2026-06-09 05:34:53'),
(26, 12, 'Diskusi Karier Web Developer', '2026-06-16', '16.15 - 17.00', 'Para Pembicara', 50, '2026-06-09 05:35:25'),
(27, 13, 'Dasar dasar UI/UX', '2026-06-10', '09.00-11.00', 'Dr. Setiawan', 30, '2026-06-09 11:45:20'),
(28, 14, 'Opening Ceremony', '2026-06-19', '08.00 - 08.30', 'Norberth Dahlan', 25, '2026-06-09 12:49:52');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` text NOT NULL,
  `role_id` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `phone` varchar(20) DEFAULT NULL,
  `organization` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `password`, `role_id`, `created_at`, `phone`, `organization`) VALUES
(10, 'gio', 'gio@gmail.com', '$2b$10$tp3H9mnISrg/h99446k.c.gzBfOe5Mqd.gUWbRfRArUNRNmiVDk0G', 1, '2026-04-29 08:15:09', NULL, NULL),
(12, 'hindi', 'hendi@gmail.com', '$2b$10$uwc88fh0ci4TMd80TJfXyuGn4IYM4ZZfN7y19ixPpFl.G1eeQJzNa', 2, '2026-04-29 09:02:05', NULL, NULL),
(13, 'Budi', 'budi@mail.com', '$2b$10$DmhpUkq.Lcm7pCDy7MakHOc5xC6M3bHiE/Bad3gv0z0MJi5g8s.LS', 2, '2026-05-13 07:41:21', NULL, NULL),
(21, 'admin', 'wokrsnesia26@gmail.com', '$2b$10$wZrZ1ZpgxFGbIHzFU2VfjeRGSiqu4WMfUzQVaq2/GNhYN6chIYi9O', 1, '2026-05-13 23:36:10', NULL, NULL),
(22, 'Arya Santosa', 'kamu@gmail.com', '$2b$10$8wF732jwYxv74jr4qf90Y.9C8xQ0Zcmybixqe4/PJ5DyCtB/5SO4C', 2, '2026-05-21 19:10:58', '098824673290', 'pt.persana'),
(23, 'Rafael Naryadi', 'rafael@gmail.com', '$2b$10$kiztJRfD.qrVgVi0TWUE.OL5/byeW4nc15CMQ8Hk31UKRx.pKEQri', 2, '2026-05-21 19:24:01', '098212346783', 'pt.persana'),
(24, 'Surya Prakoso', 'surya2026@gmail.com', '$2b$10$Ft5UjAzJ9AoD2T1o4gcjYulQmBTWL7ulHJboH7M1Deskffg1U.U66', 2, '2026-06-02 20:02:05', '093433348982', 'pt.persana'),
(25, 'Ujang Setiawan', 'ujang@gmail.com', '$2b$10$deB4PtL2CjtL3vl8hGPwe.QNiIHbMbe9IcAZ6tcNOwqeT1enZ6mWa', 2, '2026-06-06 14:02:47', '081225142601', 'PSHT'),
(26, 'Sumargi Darmawan', 'sumargi@gmai.com', '$2b$10$67EdaDUEbfpsoMzutS2ro.rW2sY2acrYCiE4OA4FX8Hm2cvkFsl9.', 2, '2026-06-09 18:40:53', '0844578903456', 'pt.persana'),
(27, 'Suartoso Budianto', 'Suartoso@gmail.com', '$2b$10$1J1LeFCK0B6VDU6BO6dy3uWB3x94KJhhDU64oeWTv3ntNKkvemVNK', 2, '2026-06-09 19:43:53', '0912288467222', 'pt.persana'),
(28, 'Demian Wiriawan', 'demian@gmail.com', '$2b$10$ADyD9EAIjA76b6VT8bxba.dIsKCJAXCvyRmL41Ym2pn94Imtry.Pa', 2, '2026-06-09 20:12:58', '081225142601', 'pt.persana');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `attendances`
--
ALTER TABLE `attendances`
  ADD PRIMARY KEY (`id`),
  ADD KEY `participant_id` (`participant_id`),
  ADD KEY `session_id` (`session_id`);

--
-- Indexes for table `certificates`
--
ALTER TABLE `certificates`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `participant_id` (`participant_id`),
  ADD KEY `event_id` (`event_id`);

--
-- Indexes for table `events`
--
ALTER TABLE `events`
  ADD PRIMARY KEY (`id`),
  ADD KEY `created_by` (`created_by`),
  ADD KEY `idx_events_date` (`date`);

--
-- Indexes for table `feedback`
--
ALTER TABLE `feedback`
  ADD PRIMARY KEY (`id`),
  ADD KEY `participant_id` (`participant_id`),
  ADD KEY `idx_feedback_event` (`event_id`);

--
-- Indexes for table `participants`
--
ALTER TABLE `participants`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_participant` (`user_id`,`event_id`),
  ADD UNIQUE KEY `booking_code` (`booking_code`),
  ADD KEY `idx_participants_event` (`event_id`);

--
-- Indexes for table `permissions`
--
ALTER TABLE `permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Indexes for table `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Indexes for table `role_permissions`
--
ALTER TABLE `role_permissions`
  ADD PRIMARY KEY (`role_id`,`permission_id`),
  ADD KEY `permission_id` (`permission_id`);

--
-- Indexes for table `sessions`
--
ALTER TABLE `sessions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `event_id` (`event_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`),
  ADD KEY `idx_users_role` (`role_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `attendances`
--
ALTER TABLE `attendances`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `certificates`
--
ALTER TABLE `certificates`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `events`
--
ALTER TABLE `events`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `feedback`
--
ALTER TABLE `feedback`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `participants`
--
ALTER TABLE `participants`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `permissions`
--
ALTER TABLE `permissions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `roles`
--
ALTER TABLE `roles`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `sessions`
--
ALTER TABLE `sessions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=32;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `attendances`
--
ALTER TABLE `attendances`
  ADD CONSTRAINT `attendances_ibfk_1` FOREIGN KEY (`participant_id`) REFERENCES `participants` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `attendances_ibfk_2` FOREIGN KEY (`session_id`) REFERENCES `sessions` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `certificates`
--
ALTER TABLE `certificates`
  ADD CONSTRAINT `certificates_ibfk_1` FOREIGN KEY (`participant_id`) REFERENCES `participants` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `certificates_ibfk_2` FOREIGN KEY (`event_id`) REFERENCES `events` (`id`);

--
-- Constraints for table `events`
--
ALTER TABLE `events`
  ADD CONSTRAINT `events_ibfk_1` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`);

--
-- Constraints for table `feedback`
--
ALTER TABLE `feedback`
  ADD CONSTRAINT `feedback_ibfk_1` FOREIGN KEY (`participant_id`) REFERENCES `participants` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `feedback_ibfk_2` FOREIGN KEY (`event_id`) REFERENCES `events` (`id`);

--
-- Constraints for table `participants`
--
ALTER TABLE `participants`
  ADD CONSTRAINT `participants_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `participants_ibfk_2` FOREIGN KEY (`event_id`) REFERENCES `events` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `role_permissions`
--
ALTER TABLE `role_permissions`
  ADD CONSTRAINT `role_permissions_ibfk_1` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `role_permissions_ibfk_2` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `sessions`
--
ALTER TABLE `sessions`
  ADD CONSTRAINT `sessions_ibfk_1` FOREIGN KEY (`event_id`) REFERENCES `events` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `users_ibfk_1` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
