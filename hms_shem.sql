-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: localhost:8889
-- Generation Time: Jun 16, 2025 at 01:10 PM
-- Server version: 5.7.39
-- PHP Version: 8.2.0

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `hms_shem`
--

-- --------------------------------------------------------

--
-- Table structure for table `appointment_requests`
--

CREATE TABLE `appointment_requests` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `patient_id` bigint(20) UNSIGNED NOT NULL,
  `doctor_id` bigint(20) UNSIGNED NOT NULL,
  `preferred_date` datetime NOT NULL,
  `reason` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` enum('pending','approved','rejected','cancelled') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'pending',
  `doctor_remarks` text COLLATE utf8mb4_unicode_ci,
  `patient_notes` text COLLATE utf8mb4_unicode_ci,
  `responded_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `appointment_requests`
--

INSERT INTO `appointment_requests` (`id`, `patient_id`, `doctor_id`, `preferred_date`, `reason`, `status`, `doctor_remarks`, `patient_notes`, `responded_at`, `created_at`, `updated_at`) VALUES
(1, 2, 3, '2025-06-16 17:06:00', 'Test kkdjdjjd jdjd', 'pending', NULL, NULL, NULL, '2025-06-16 08:04:01', '2025-06-16 08:04:01'),
(2, 2, 3, '2025-06-16 17:06:00', 'Test kkdjdjjd jdjd', 'pending', NULL, NULL, NULL, '2025-06-16 08:04:09', '2025-06-16 08:04:09'),
(3, 2, 3, '2025-06-16 17:06:00', 'Test kkdjdjjd jdjd', 'pending', NULL, NULL, NULL, '2025-06-16 08:04:23', '2025-06-16 08:04:23'),
(4, 2, 3, '2025-06-16 17:06:00', 'Test kkdjdjjd jdjd', 'pending', NULL, NULL, NULL, '2025-06-16 08:04:41', '2025-06-16 08:04:41'),
(5, 2, 3, '2025-06-16 17:06:00', 'Test kkdjdjjd jdjd', 'pending', NULL, NULL, NULL, '2025-06-16 08:05:16', '2025-06-16 08:05:16'),
(6, 2, 3, '2025-06-16 17:06:00', 'Test kkdjdjjd jdjd', 'pending', NULL, NULL, NULL, '2025-06-16 08:05:17', '2025-06-16 08:05:17'),
(7, 2, 3, '2025-06-16 17:06:00', 'Test kkdjdjjd jdjd', 'pending', NULL, NULL, NULL, '2025-06-16 08:05:45', '2025-06-16 08:05:45'),
(8, 2, 3, '2025-06-16 14:06:00', 'TETSTSTS HSHSHHS', 'pending', NULL, NULL, NULL, '2025-06-16 08:06:55', '2025-06-16 08:06:55'),
(9, 2, 3, '2025-06-16 14:09:00', 'TEST OTOTO NNNS', 'pending', NULL, NULL, NULL, '2025-06-16 08:09:45', '2025-06-16 08:09:45'),
(10, 2, 3, '2025-06-16 14:11:00', 'pLEASE DESCRIPBE', 'pending', NULL, NULL, NULL, '2025-06-16 08:11:11', '2025-06-16 08:11:11'),
(11, 2, 3, '2025-06-16 18:20:00', 'JSJSJS JSJJSS', 'approved', NULL, NULL, '2025-06-16 09:05:48', '2025-06-16 08:16:36', '2025-06-16 09:05:48'),
(12, 2, 3, '2025-06-16 14:37:00', 'yoooeoe enenen', 'approved', NULL, NULL, '2025-06-16 08:59:35', '2025-06-16 08:37:55', '2025-06-16 08:59:35'),
(13, 2, 3, '2025-06-16 14:41:00', 'Test shshs shshsh', 'approved', NULL, NULL, '2025-06-16 08:58:57', '2025-06-16 08:41:13', '2025-06-16 08:58:57'),
(14, 2, 3, '2025-06-16 15:33:00', 'Next time please', 'pending', NULL, NULL, NULL, '2025-06-16 09:34:01', '2025-06-16 09:34:01'),
(15, 2, 3, '2025-06-16 22:00:00', 'Aliquam et maiores n', 'pending', NULL, NULL, NULL, '2025-06-16 09:43:22', '2025-06-16 09:43:22');

-- --------------------------------------------------------

--
-- Table structure for table `cache`
--

CREATE TABLE `cache` (
  `key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `cache_locks`
--

CREATE TABLE `cache_locks` (
  `key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `owner` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `uuid` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `connection` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `jobs`
--

CREATE TABLE `jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `queue` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `attempts` tinyint(3) UNSIGNED NOT NULL,
  `reserved_at` int(10) UNSIGNED DEFAULT NULL,
  `available_at` int(10) UNSIGNED NOT NULL,
  `created_at` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `jobs`
--

INSERT INTO `jobs` (`id`, `queue`, `payload`, `attempts`, `reserved_at`, `available_at`, `created_at`) VALUES
(1, 'default', '{\"uuid\":\"0a531bd2-7375-4f08-8ca5-df52fcee1887\",\"displayName\":\"App\\\\Notifications\\\\AppointmentStatusChanged\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\",\"command\":\"O:48:\\\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\\\":3:{s:11:\\\"notifiables\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:15:\\\"App\\\\Models\\\\User\\\";s:2:\\\"id\\\";a:1:{i:0;i:2;}s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:12:\\\"notification\\\";O:42:\\\"App\\\\Notifications\\\\AppointmentStatusChanged\\\":2:{s:14:\\\"\\u0000*\\u0000appointment\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:29:\\\"App\\\\Models\\\\AppointmentRequest\\\";s:2:\\\"id\\\";i:13;s:9:\\\"relations\\\";a:1:{i:0;s:7:\\\"patient\\\";}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:2:\\\"id\\\";s:36:\\\"926ae512-860f-46b9-a1ec-fcc7324a1f05\\\";}s:8:\\\"channels\\\";a:1:{i:0;s:4:\\\"mail\\\";}}\"},\"createdAt\":1750075138,\"delay\":null}', 0, NULL, 1750075138, 1750075138),
(2, 'default', '{\"uuid\":\"f3e354a8-f7df-4418-8c34-7ebbe3f48980\",\"displayName\":\"App\\\\Notifications\\\\AppointmentStatusChanged\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\",\"command\":\"O:48:\\\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\\\":3:{s:11:\\\"notifiables\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:15:\\\"App\\\\Models\\\\User\\\";s:2:\\\"id\\\";a:1:{i:0;i:2;}s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:12:\\\"notification\\\";O:42:\\\"App\\\\Notifications\\\\AppointmentStatusChanged\\\":2:{s:14:\\\"\\u0000*\\u0000appointment\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:29:\\\"App\\\\Models\\\\AppointmentRequest\\\";s:2:\\\"id\\\";i:13;s:9:\\\"relations\\\";a:1:{i:0;s:7:\\\"patient\\\";}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:2:\\\"id\\\";s:36:\\\"926ae512-860f-46b9-a1ec-fcc7324a1f05\\\";}s:8:\\\"channels\\\";a:1:{i:0;s:8:\\\"database\\\";}}\"},\"createdAt\":1750075138,\"delay\":null}', 0, NULL, 1750075138, 1750075138),
(3, 'default', '{\"uuid\":\"4bacb2ef-bf1d-4ad8-a5c1-6f92b18c45b2\",\"displayName\":\"App\\\\Events\\\\AppointmentStatusUpdated\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":14:{s:5:\\\"event\\\";O:35:\\\"App\\\\Events\\\\AppointmentStatusUpdated\\\":1:{s:11:\\\"appointment\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:29:\\\"App\\\\Models\\\\AppointmentRequest\\\";s:2:\\\"id\\\";i:13;s:9:\\\"relations\\\";a:2:{i:0;s:7:\\\"patient\\\";i:1;s:6:\\\"doctor\\\";}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\"},\"createdAt\":1750075138,\"delay\":null}', 0, NULL, 1750075138, 1750075138),
(4, 'default', '{\"uuid\":\"f4ab1444-97ee-43f0-a8ce-e388154541a9\",\"displayName\":\"App\\\\Notifications\\\\AppointmentStatusChanged\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\",\"command\":\"O:48:\\\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\\\":3:{s:11:\\\"notifiables\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:15:\\\"App\\\\Models\\\\User\\\";s:2:\\\"id\\\";a:1:{i:0;i:2;}s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:12:\\\"notification\\\";O:42:\\\"App\\\\Notifications\\\\AppointmentStatusChanged\\\":2:{s:14:\\\"\\u0000*\\u0000appointment\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:29:\\\"App\\\\Models\\\\AppointmentRequest\\\";s:2:\\\"id\\\";i:12;s:9:\\\"relations\\\";a:1:{i:0;s:7:\\\"patient\\\";}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:2:\\\"id\\\";s:36:\\\"3f0f83f9-ef50-4114-9473-7dbbc8273edc\\\";}s:8:\\\"channels\\\";a:1:{i:0;s:4:\\\"mail\\\";}}\"},\"createdAt\":1750075175,\"delay\":null}', 0, NULL, 1750075175, 1750075175),
(5, 'default', '{\"uuid\":\"2a2e60ba-c1a0-4738-98f1-71e79a7ddb4b\",\"displayName\":\"App\\\\Notifications\\\\AppointmentStatusChanged\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\",\"command\":\"O:48:\\\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\\\":3:{s:11:\\\"notifiables\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:15:\\\"App\\\\Models\\\\User\\\";s:2:\\\"id\\\";a:1:{i:0;i:2;}s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:12:\\\"notification\\\";O:42:\\\"App\\\\Notifications\\\\AppointmentStatusChanged\\\":2:{s:14:\\\"\\u0000*\\u0000appointment\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:29:\\\"App\\\\Models\\\\AppointmentRequest\\\";s:2:\\\"id\\\";i:12;s:9:\\\"relations\\\";a:1:{i:0;s:7:\\\"patient\\\";}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:2:\\\"id\\\";s:36:\\\"3f0f83f9-ef50-4114-9473-7dbbc8273edc\\\";}s:8:\\\"channels\\\";a:1:{i:0;s:8:\\\"database\\\";}}\"},\"createdAt\":1750075175,\"delay\":null}', 0, NULL, 1750075175, 1750075175),
(6, 'default', '{\"uuid\":\"b3e0eed5-94e7-4743-985f-79f56ec70f10\",\"displayName\":\"App\\\\Events\\\\AppointmentStatusUpdated\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":14:{s:5:\\\"event\\\";O:35:\\\"App\\\\Events\\\\AppointmentStatusUpdated\\\":1:{s:11:\\\"appointment\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:29:\\\"App\\\\Models\\\\AppointmentRequest\\\";s:2:\\\"id\\\";i:12;s:9:\\\"relations\\\";a:2:{i:0;s:7:\\\"patient\\\";i:1;s:6:\\\"doctor\\\";}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\"},\"createdAt\":1750075175,\"delay\":null}', 0, NULL, 1750075175, 1750075175),
(7, 'default', '{\"uuid\":\"400435f0-48d7-4824-b3a8-c5613e7f51eb\",\"displayName\":\"App\\\\Notifications\\\\AppointmentStatusChanged\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\",\"command\":\"O:48:\\\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\\\":3:{s:11:\\\"notifiables\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:15:\\\"App\\\\Models\\\\User\\\";s:2:\\\"id\\\";a:1:{i:0;i:2;}s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:12:\\\"notification\\\";O:42:\\\"App\\\\Notifications\\\\AppointmentStatusChanged\\\":2:{s:14:\\\"\\u0000*\\u0000appointment\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:29:\\\"App\\\\Models\\\\AppointmentRequest\\\";s:2:\\\"id\\\";i:11;s:9:\\\"relations\\\";a:1:{i:0;s:7:\\\"patient\\\";}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:2:\\\"id\\\";s:36:\\\"96466f82-2adb-4e4c-aa2c-0a11d5b945e1\\\";}s:8:\\\"channels\\\";a:1:{i:0;s:4:\\\"mail\\\";}}\"},\"createdAt\":1750075548,\"delay\":null}', 0, NULL, 1750075548, 1750075548),
(8, 'default', '{\"uuid\":\"0e23c675-ddb1-49ab-a006-340d76a34943\",\"displayName\":\"App\\\\Notifications\\\\AppointmentStatusChanged\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\",\"command\":\"O:48:\\\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\\\":3:{s:11:\\\"notifiables\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:15:\\\"App\\\\Models\\\\User\\\";s:2:\\\"id\\\";a:1:{i:0;i:2;}s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:12:\\\"notification\\\";O:42:\\\"App\\\\Notifications\\\\AppointmentStatusChanged\\\":2:{s:14:\\\"\\u0000*\\u0000appointment\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:29:\\\"App\\\\Models\\\\AppointmentRequest\\\";s:2:\\\"id\\\";i:11;s:9:\\\"relations\\\";a:1:{i:0;s:7:\\\"patient\\\";}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:2:\\\"id\\\";s:36:\\\"96466f82-2adb-4e4c-aa2c-0a11d5b945e1\\\";}s:8:\\\"channels\\\";a:1:{i:0;s:8:\\\"database\\\";}}\"},\"createdAt\":1750075548,\"delay\":null}', 0, NULL, 1750075548, 1750075548),
(9, 'default', '{\"uuid\":\"09337a30-29f4-4b9c-9cb9-1985f6b14856\",\"displayName\":\"App\\\\Events\\\\AppointmentStatusUpdated\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":14:{s:5:\\\"event\\\";O:35:\\\"App\\\\Events\\\\AppointmentStatusUpdated\\\":1:{s:11:\\\"appointment\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:29:\\\"App\\\\Models\\\\AppointmentRequest\\\";s:2:\\\"id\\\";i:11;s:9:\\\"relations\\\";a:2:{i:0;s:7:\\\"patient\\\";i:1;s:6:\\\"doctor\\\";}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\"},\"createdAt\":1750075548,\"delay\":null}', 0, NULL, 1750075548, 1750075548);

-- --------------------------------------------------------

--
-- Table structure for table `job_batches`
--

CREATE TABLE `job_batches` (
  `id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `total_jobs` int(11) NOT NULL,
  `pending_jobs` int(11) NOT NULL,
  `failed_jobs` int(11) NOT NULL,
  `failed_job_ids` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `options` mediumtext COLLATE utf8mb4_unicode_ci,
  `cancelled_at` int(11) DEFAULT NULL,
  `created_at` int(11) NOT NULL,
  `finished_at` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '0001_01_01_000000_create_users_table', 1),
(2, '0001_01_01_000001_create_cache_table', 1),
(3, '0001_01_01_000002_create_jobs_table', 1),
(4, '2025_06_16_012544_create_appointment_requests_table', 1),
(5, '2025_06_16_065302_create_personal_access_tokens_table', 1);

-- --------------------------------------------------------

--
-- Table structure for table `personal_access_tokens`
--

CREATE TABLE `personal_access_tokens` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `tokenable_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tokenable_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `abilities` text COLLATE utf8mb4_unicode_ci,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `personal_access_tokens`
--

INSERT INTO `personal_access_tokens` (`id`, `tokenable_type`, `tokenable_id`, `name`, `token`, `abilities`, `last_used_at`, `expires_at`, `created_at`, `updated_at`) VALUES
(1, 'App\\Models\\User', 1, 'auth-token', '9c24e6812825acc9c768525ccfe4d1994f44f2cfdb253c7ff6f9b33c87671f28', '[\"*\"]', NULL, NULL, '2025-06-16 04:23:18', '2025-06-16 04:23:18'),
(2, 'App\\Models\\User', 1, 'auth-token', '57693b5d479acffe2e598b32e12b2c86ce879040d2457b4accec95f72b49daa9', '[\"*\"]', '2025-06-16 04:25:43', NULL, '2025-06-16 04:24:02', '2025-06-16 04:25:43'),
(3, 'App\\Models\\User', 2, 'auth-token', '185d44b5c9ac0fee29a4e0153ef1ed3d6ed85b336aa175832546332105eec9e1', '[\"*\"]', NULL, NULL, '2025-06-16 07:25:33', '2025-06-16 07:25:33'),
(4, 'App\\Models\\User', 2, 'auth-token', '0a98f708955d45a18077351a3fffdaeff104b7703dde29c581472d67c3b163c7', '[\"*\"]', '2025-06-16 07:31:40', NULL, '2025-06-16 07:25:54', '2025-06-16 07:31:40'),
(5, 'App\\Models\\User', 3, 'auth-token', 'bdf05abf3f0179888c9daac19d4cf4f2e78b3bdc19d96f03baf67417d7db955a', '[\"*\"]', NULL, NULL, '2025-06-16 07:32:26', '2025-06-16 07:32:26'),
(6, 'App\\Models\\User', 2, 'auth-token', 'eeafd6af83af9b284d0f8a4ec7a4d94fea9cc74032f2c41e744cb6f10c278b81', '[\"*\"]', '2025-06-16 07:32:43', NULL, '2025-06-16 07:32:40', '2025-06-16 07:32:43'),
(7, 'App\\Models\\User', 2, 'auth-token', 'aeb038797f082942c5a6eae0d5ae87266baefb2f813a1b2f64fd806e0759d8f4', '[\"*\"]', '2025-06-16 07:34:07', NULL, '2025-06-16 07:33:12', '2025-06-16 07:34:07'),
(8, 'App\\Models\\User', 2, 'auth-token', '43425c17b92bcb24eeddb398068bfb9f75bf219a41082739ee5b0a4723b48502', '[\"*\"]', '2025-06-16 07:37:07', NULL, '2025-06-16 07:35:45', '2025-06-16 07:37:07'),
(9, 'App\\Models\\User', 2, 'auth-token', 'a0a28274c51269127c03e5e0aa9e6f1ccd0d5153b45ac64154993f3811cfe6d4', '[\"*\"]', '2025-06-16 07:49:14', NULL, '2025-06-16 07:37:25', '2025-06-16 07:49:14'),
(10, 'App\\Models\\User', 2, 'auth-token', '4f7406a2dec5ed6a1de05eeccfcd66b86a6df4a35776e8734ba3fc489d1231c3', '[\"*\"]', '2025-06-16 07:49:45', NULL, '2025-06-16 07:49:30', '2025-06-16 07:49:45'),
(11, 'App\\Models\\User', 2, 'auth-token', '2395cd3c5d2cc10de07a88a4667594cda33ca23645d74a3df3520d2183934339', '[\"*\"]', '2025-06-16 07:53:58', NULL, '2025-06-16 07:53:17', '2025-06-16 07:53:58'),
(12, 'App\\Models\\User', 2, 'auth-token', 'd3494aab9a66248840c2707b39bba9ca93a73cd7006bd3e00ecbfa8555de8b9b', '[\"*\"]', '2025-06-16 07:57:51', NULL, '2025-06-16 07:56:46', '2025-06-16 07:57:51'),
(13, 'App\\Models\\User', 2, 'auth-token', 'd903a1466a59a97285070160c47a364a3e40dfc29c57e6c33ff8b3c17b43bedf', '[\"*\"]', '2025-06-16 08:00:24', NULL, '2025-06-16 07:59:21', '2025-06-16 08:00:24'),
(14, 'App\\Models\\User', 2, 'auth-token', 'ba518e0c0c394965e9ed3b8f633c2b032b2d00fad66923875ccde0107113e7c7', '[\"*\"]', '2025-06-16 08:03:07', NULL, '2025-06-16 08:02:07', '2025-06-16 08:03:07'),
(15, 'App\\Models\\User', 2, 'auth-token', 'bf0c2aab0a69de0d538a087339068f5a24092496a7533f3e03b275dd57d97d4d', '[\"*\"]', '2025-06-16 08:06:18', NULL, '2025-06-16 08:03:34', '2025-06-16 08:06:18'),
(16, 'App\\Models\\User', 2, 'auth-token', '0bdea073e82fd6762917eb3012173b009bb0302221f5faa883c5b280fe81b9eb', '[\"*\"]', '2025-06-16 08:09:21', NULL, '2025-06-16 08:06:38', '2025-06-16 08:09:21'),
(17, 'App\\Models\\User', 2, 'auth-token', 'cb75f2e2d4277f7b3563f97a8281cac59772d5df8972f664e1abf62745fd9fa5', '[\"*\"]', '2025-06-16 08:10:35', NULL, '2025-06-16 08:09:26', '2025-06-16 08:10:35'),
(18, 'App\\Models\\User', 2, 'auth-token', '60475255f86ab9e8cd101fc12e2cde8a92bea69355a5a6b3838a93e2466c4b07', '[\"*\"]', '2025-06-16 08:11:16', NULL, '2025-06-16 08:10:52', '2025-06-16 08:11:16'),
(19, 'App\\Models\\User', 2, 'auth-token', 'c22dfd680c21e04b57f59cdf1ccecdac4c50bee8d96f3bbc568c4f9e215506f5', '[\"*\"]', '2025-06-16 08:12:11', NULL, '2025-06-16 08:12:07', '2025-06-16 08:12:11'),
(20, 'App\\Models\\User', 2, 'auth-token', 'caa4d87fa45f1c2997e32979ccc30643613d04ac374d156b29868567c89484c3', '[\"*\"]', '2025-06-16 08:15:17', NULL, '2025-06-16 08:12:48', '2025-06-16 08:15:17'),
(21, 'App\\Models\\User', 2, 'auth-token', '06abb526029121e0a2a27d1a29ca653ccb78a5f687105620a3c5616176662723', '[\"*\"]', '2025-06-16 08:16:38', NULL, '2025-06-16 08:15:28', '2025-06-16 08:16:38'),
(22, 'App\\Models\\User', 2, 'auth-token', 'bb719827a390f5dbeea67c5de889a4e37b49968f51ca40b016d2acfd1bb21465', '[\"*\"]', '2025-06-16 08:18:14', NULL, '2025-06-16 08:18:14', '2025-06-16 08:18:14'),
(23, 'App\\Models\\User', 2, 'auth-token', 'b90b1fbdbda8fbbbd0f36921170b4bfca49c182ca9ce88847d9d735a5714e0a8', '[\"*\"]', '2025-06-16 08:22:21', NULL, '2025-06-16 08:22:21', '2025-06-16 08:22:21'),
(24, 'App\\Models\\User', 2, 'auth-token', 'c70a9609ed4a47a279202788cabce21776ae23f434615b9bb39d7e27a62cab61', '[\"*\"]', '2025-06-16 08:25:19', NULL, '2025-06-16 08:23:32', '2025-06-16 08:25:19'),
(25, 'App\\Models\\User', 2, 'auth-token', '4eda270da0122824fe1ab0e1f59240e9e6711596eed689bb49ada5d7456bf569', '[\"*\"]', '2025-06-16 08:28:07', NULL, '2025-06-16 08:25:24', '2025-06-16 08:28:07'),
(26, 'App\\Models\\User', 2, 'auth-token', 'a560d2d84ea7d9094a4b5a364746d7c1b1f197b9e6583a12617c771d775599ca', '[\"*\"]', '2025-06-16 08:29:34', NULL, '2025-06-16 08:28:54', '2025-06-16 08:29:34'),
(27, 'App\\Models\\User', 2, 'auth-token', '0ed5d615ff5af908825ec9d868a13caaaaf3014de1759fd308b6ea35264d57ce', '[\"*\"]', '2025-06-16 08:33:22', NULL, '2025-06-16 08:29:45', '2025-06-16 08:33:22'),
(28, 'App\\Models\\User', 2, 'auth-token', 'b4364901673263bb3b8c49e5bb68a6a86916c9f22708ea066eb59e49014f7447', '[\"*\"]', '2025-06-16 08:33:33', NULL, '2025-06-16 08:33:28', '2025-06-16 08:33:33'),
(29, 'App\\Models\\User', 2, 'auth-token', '2034c6c8d48482de8c63d635220d5734cc6a55ff9ff2c71b09af519775aa2540', '[\"*\"]', '2025-06-16 08:34:00', NULL, '2025-06-16 08:33:48', '2025-06-16 08:34:00'),
(30, 'App\\Models\\User', 2, 'auth-token', '0eb8646ee8c14dc6ef3a1ca3620d3b40486922855d1cd06a24e34d264a3884a8', '[\"*\"]', '2025-06-16 08:36:06', NULL, '2025-06-16 08:34:35', '2025-06-16 08:36:06'),
(31, 'App\\Models\\User', 2, 'auth-token', 'e3de2f514ab7f016c2466851911eb1bdb20494055db782d72dd6725256d140e6', '[\"*\"]', '2025-06-16 08:40:44', NULL, '2025-06-16 08:36:13', '2025-06-16 08:40:44'),
(32, 'App\\Models\\User', 2, 'auth-token', 'f514168d2dc7a5d0c0375ed92812ac6593beaf17d7e2ddb1781148962340875b', '[\"*\"]', '2025-06-16 08:41:20', NULL, '2025-06-16 08:40:48', '2025-06-16 08:41:20'),
(33, 'App\\Models\\User', 3, 'auth-token', '09b78cce750453f1060bb8cfc88cd9fcb6b2b87b1dba0e8c8cb53ba5bb67b18d', '[\"*\"]', '2025-06-16 08:42:42', NULL, '2025-06-16 08:42:01', '2025-06-16 08:42:42'),
(34, 'App\\Models\\User', 3, 'auth-token', '24c854d803ec2530de4aa8331488bec7d05bbe444a72ff195bd822efd312a1ad', '[\"*\"]', '2025-06-16 08:43:36', NULL, '2025-06-16 08:43:31', '2025-06-16 08:43:36'),
(35, 'App\\Models\\User', 3, 'auth-token', '945c88ffedbfdc95e7eab3ee85ee5cb98067df267fa5ae4eb1f6082cd4048927', '[\"*\"]', '2025-06-16 08:46:44', NULL, '2025-06-16 08:44:07', '2025-06-16 08:46:44'),
(36, 'App\\Models\\User', 3, 'auth-token', '0279e042d04a3e684382816f1960473b6229a034faa323178563401a7fa32dbb', '[\"*\"]', '2025-06-16 08:49:05', NULL, '2025-06-16 08:47:02', '2025-06-16 08:49:05'),
(37, 'App\\Models\\User', 3, 'auth-token', '605e707bc569f7103a59524d3b35a0eb15046f7257f1d31931a4d506fe3466bb', '[\"*\"]', '2025-06-16 08:58:34', NULL, '2025-06-16 08:49:18', '2025-06-16 08:58:34'),
(38, 'App\\Models\\User', 3, 'auth-token', 'a61e631fe3701ea7f1ef7918a82243badbba23979db7c5a1097d05064ba7a1f5', '[\"*\"]', '2025-06-16 08:59:00', NULL, '2025-06-16 08:58:49', '2025-06-16 08:59:00'),
(39, 'App\\Models\\User', 3, 'auth-token', '40b2eedbbaf031326cd7447bdb8323005fb503eacf59f003127564bc1de53cb6', '[\"*\"]', '2025-06-16 09:03:00', NULL, '2025-06-16 08:59:27', '2025-06-16 09:03:00'),
(40, 'App\\Models\\User', 3, 'auth-token', '1d63714585ef67f68838731bfdb73fd76233ec87ed317e123d7859d0cdc3f4b0', '[\"*\"]', '2025-06-16 09:05:59', NULL, '2025-06-16 09:05:16', '2025-06-16 09:05:59'),
(41, 'App\\Models\\User', 2, 'auth-token', '1bf7a5e447d473992e8756ec94a94928134f862ee8ed2499d64c569e844cfca0', '[\"*\"]', '2025-06-16 09:08:08', NULL, '2025-06-16 09:08:05', '2025-06-16 09:08:08'),
(42, 'App\\Models\\User', 2, 'auth-token', 'aa245d68919a4b16109cd95362b3ed81c57ced80e7ec2e9d494a0cfda6c17da9', '[\"*\"]', '2025-06-16 09:15:04', NULL, '2025-06-16 09:08:26', '2025-06-16 09:15:04'),
(43, 'App\\Models\\User', 2, 'auth-token', '056d101637eeded6d4128d53028f9f5c0866d2ef0a67cd38e17a56f581818e66', '[\"*\"]', '2025-06-16 09:27:45', NULL, '2025-06-16 09:15:08', '2025-06-16 09:27:45'),
(44, 'App\\Models\\User', 2, 'auth-token', 'bf0991a7dc56d7dd29983b00164c571c56196eaae6936c72911ee8df85891f88', '[\"*\"]', '2025-06-16 09:27:58', NULL, '2025-06-16 09:27:56', '2025-06-16 09:27:58'),
(45, 'App\\Models\\User', 3, 'auth-token', '1a7704c8bbc77ba4591eb255d7ccc67382488d5cf5976a9e1a918e60a2b36e98', '[\"*\"]', '2025-06-16 09:32:44', NULL, '2025-06-16 09:31:00', '2025-06-16 09:32:44'),
(46, 'App\\Models\\User', 2, 'auth-token', '62154a9eb06d9db7416c4ba4b953e9c3bdc0b4a1504e687fb7ab3271f16943f5', '[\"*\"]', '2025-06-16 09:32:52', NULL, '2025-06-16 09:32:47', '2025-06-16 09:32:52'),
(47, 'App\\Models\\User', 3, 'auth-token', 'acfe359d13abdfae09ceafdfaaa64856d71ae87d97b3aefacc820d1f188943ba', '[\"*\"]', '2025-06-16 09:33:02', NULL, '2025-06-16 09:33:00', '2025-06-16 09:33:02'),
(48, 'App\\Models\\User', 3, 'auth-token', '3af98cb2c57e3c1e00d742d2c0784965b6d5f6bda533db8e11011900294ffd35', '[\"*\"]', '2025-06-16 09:33:08', NULL, '2025-06-16 09:33:08', '2025-06-16 09:33:08'),
(49, 'App\\Models\\User', 2, 'auth-token', '478a666bde5a0e9ac99560a49d1b3b1f35d819358f81faf5066b298c3798427f', '[\"*\"]', '2025-06-16 09:33:19', NULL, '2025-06-16 09:33:15', '2025-06-16 09:33:19'),
(50, 'App\\Models\\User', 2, 'auth-token', 'b69a6e506afc2cb89d29558f128207559bad8798bdad5068bc378cae31aef06c', '[\"*\"]', '2025-06-16 09:34:03', NULL, '2025-06-16 09:33:30', '2025-06-16 09:34:03'),
(51, 'App\\Models\\User', 3, 'auth-token', '6fa1ae49134922829a592dc53cfddaeb5d24cdf201322e7b2cc06e63e1a276c1', '[\"*\"]', '2025-06-16 09:35:02', NULL, '2025-06-16 09:35:01', '2025-06-16 09:35:02'),
(52, 'App\\Models\\User', 2, 'auth-token', 'fbc13e31593b0c57afcd9e7f9cf39b5c6ce691dfe15b7e1bbaef595b88747efa', '[\"*\"]', '2025-06-16 09:35:14', NULL, '2025-06-16 09:35:10', '2025-06-16 09:35:14'),
(53, 'App\\Models\\User', 2, 'auth-token', 'e07fee131758fb30ae0fa20035ec91b73d06e59c2cffdf86aef1138036260e88', '[\"*\"]', '2025-06-16 09:37:46', NULL, '2025-06-16 09:35:20', '2025-06-16 09:37:46'),
(54, 'App\\Models\\User', 2, 'auth-token', '4107aaad3d09ef1329feb0ae0bff96276af1e78c86df2708a2959dc1966e3fb9', '[\"*\"]', '2025-06-16 09:37:51', NULL, '2025-06-16 09:37:51', '2025-06-16 09:37:51'),
(55, 'App\\Models\\User', 2, 'auth-token', 'ef7f084a95c08086931b256b90b7496876afe01abbbfc1af4bba538d5a87c9d8', '[\"*\"]', '2025-06-16 09:43:22', NULL, '2025-06-16 09:43:00', '2025-06-16 09:43:22'),
(56, 'App\\Models\\User', 2, 'auth-token', '4de7d5f0521f61299783eb2d6a042f2adedee18024aa0f795e48e874d4c2db96', '[\"*\"]', '2025-06-16 09:43:47', NULL, '2025-06-16 09:43:47', '2025-06-16 09:43:47');

-- --------------------------------------------------------

--
-- Table structure for table `sessions`
--

CREATE TABLE `sessions` (
  `id` varchar(255) NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `user_agent` text,
  `payload` text NOT NULL,
  `last_activity` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `role` enum('doctor','patient') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'patient',
  `specialization` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `bio` text COLLATE utf8mb4_unicode_ci,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `email_verified_at`, `password`, `role`, `specialization`, `bio`, `is_active`, `remember_token`, `created_at`, `updated_at`) VALUES
(1, 'b', 'zbailw@eexample.net', NULL, '$2y$12$vOKtcIqbt28UYIB5aUxQPuaAnbTyQvGSmTOp/yNgcNFI7Hyvkade6', 'patient', 'a', 'y', 1, NULL, '2025-06-16 04:23:18', '2025-06-16 04:23:18'),
(2, 'Dr. Paul Paul', 'patient@example.com', NULL, '$2y$12$crQGHkgxT9xYlljdheUNL.JiHG8bN0H3JDarPOvT7lmzO2NbAlW82', 'patient', 'a', 'y', 1, NULL, '2025-06-16 07:25:33', '2025-06-16 07:25:33'),
(3, 'Dr. James Paul', 'doctor@example.com', NULL, '$2y$12$lGlmTeI1wu/09ENU.PldFO.dYRaeer9oO0B3NEoFWVpz1BnkfaVZa', 'doctor', 'a', 'y', 1, NULL, '2025-06-16 07:32:26', '2025-06-16 07:32:26');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `appointment_requests`
--
ALTER TABLE `appointment_requests`
  ADD PRIMARY KEY (`id`),
  ADD KEY `appointment_requests_patient_id_status_index` (`patient_id`,`status`),
  ADD KEY `appointment_requests_doctor_id_status_index` (`doctor_id`,`status`),
  ADD KEY `appointment_requests_status_created_at_index` (`status`,`created_at`);

--
-- Indexes for table `cache`
--
ALTER TABLE `cache`
  ADD PRIMARY KEY (`key`);

--
-- Indexes for table `cache_locks`
--
ALTER TABLE `cache_locks`
  ADD PRIMARY KEY (`key`);

--
-- Indexes for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

--
-- Indexes for table `jobs`
--
ALTER TABLE `jobs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `jobs_queue_index` (`queue`);

--
-- Indexes for table `job_batches`
--
ALTER TABLE `job_batches`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  ADD KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`);

--
-- Indexes for table `sessions`
--
ALTER TABLE `sessions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `last_activity` (`last_activity`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`),
  ADD KEY `users_role_is_active_index` (`role`,`is_active`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `appointment_requests`
--
ALTER TABLE `appointment_requests`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `jobs`
--
ALTER TABLE `jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=57;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `appointment_requests`
--
ALTER TABLE `appointment_requests`
  ADD CONSTRAINT `appointment_requests_doctor_id_foreign` FOREIGN KEY (`doctor_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `appointment_requests_patient_id_foreign` FOREIGN KEY (`patient_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
