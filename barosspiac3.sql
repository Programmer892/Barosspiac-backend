-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Gép: 127.0.0.1
-- Létrehozás ideje: 2026. Már 04. 13:49
-- Kiszolgáló verziója: 10.4.28-MariaDB
-- PHP verzió: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Adatbázis: `barosspiac3`
--
CREATE DATABASE IF NOT EXISTS `barosspiac3` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `barosspiac3`;

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `adds`
--

CREATE TABLE `adds` (
  `add_id` int(10) UNSIGNED NOT NULL,
  `add_picture` varchar(500) NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `conversations`
--

CREATE TABLE `conversations` (
  `conversations_id` int(10) UNSIGNED NOT NULL,
  `user1_id` int(10) UNSIGNED NOT NULL,
  `user2_id` int(10) UNSIGNED NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `likes`
--

CREATE TABLE `likes` (
  `user_id` int(10) UNSIGNED NOT NULL,
  `product_id` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `main_categories`
--

CREATE TABLE `main_categories` (
  `category_id` int(10) UNSIGNED NOT NULL,
  `category_name` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- A tábla adatainak kiíratása `main_categories`
--

INSERT INTO `main_categories` (`category_id`, `category_name`) VALUES
(1, 'Női'),
(2, 'Férfi'),
(3, 'Iskolai felszerelés'),
(4, 'Elektronika'),
(5, 'Szórakozás'),
(6, 'Egyéb');

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `messages`
--

CREATE TABLE `messages` (
  `message_id` int(10) UNSIGNED NOT NULL,
  `conversations_id` int(10) UNSIGNED NOT NULL,
  `sender_id` int(10) UNSIGNED NOT NULL,
  `message` text NOT NULL,
  `sent_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `orders`
--

CREATE TABLE `orders` (
  `order_id` int(10) UNSIGNED NOT NULL,
  `buyer_id` int(10) UNSIGNED NOT NULL COMMENT 'Vevő',
  `seller_id` int(10) UNSIGNED NOT NULL COMMENT 'Eladó',
  `product_id` int(10) UNSIGNED NOT NULL,
  `order_status` enum('pending','completed','cancelled') NOT NULL DEFAULT 'pending',
  `order_date` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `product`
--

CREATE TABLE `product` (
  `product_id` int(10) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `product_title` varchar(255) NOT NULL,
  `product_desc` text NOT NULL,
  `product_price` int(10) UNSIGNED NOT NULL,
  `product_condition` enum('uj','kivalo','jo','kielegito') NOT NULL,
  `product_collpoint` varchar(255) NOT NULL COMMENT 'Átadás helye',
  `product_size` enum('XS','S','M','L','XL','XXL') DEFAULT NULL,
  `product_subject` enum('Tori','Magyar','Matek','Foldrajz','Informatika','Angol') DEFAULT NULL,
  `product_class` varchar(50) DEFAULT NULL,
  `category_id` int(10) UNSIGNED NOT NULL,
  `sub_category_id` int(10) UNSIGNED NOT NULL,
  `sub_sub_category_id` int(10) UNSIGNED NOT NULL,
  `is_sold` tinyint(1) NOT NULL DEFAULT 0,
  `product_upload` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- A tábla adatainak kiíratása `product`
--

INSERT INTO `product` (`product_id`, `user_id`, `product_title`, `product_desc`, `product_price`, `product_condition`, `product_collpoint`, `product_size`, `product_subject`, `product_class`, `category_id`, `sub_category_id`, `sub_sub_category_id`, `is_sold`, `product_upload`) VALUES
(25, 1, 'Fehér póló', 'Szép fehér póló, alig viselt.', 1500, 'jo', 'Iskola bejárat', NULL, NULL, NULL, 1, 1, 1, 0, '2026-03-04 07:13:44'),
(26, 1, 'Fehér póló 2', 'Szép fehér póló, alig viselt.', 1600, 'kivalo', 'Iskola bejárat', NULL, NULL, NULL, 1, 1, 1, 0, '2026-03-04 07:13:44'),
(27, 1, 'Fehér póló 3', 'Szép fehér póló, alig viselt.', 1700, 'uj', 'Iskola bejárat', NULL, NULL, NULL, 1, 1, 1, 0, '2026-03-04 07:13:44'),
(28, 1, 'Fehér póló 4', 'Szép fehér póló, alig viselt.', 1800, 'jo', 'Iskola bejárat', NULL, NULL, NULL, 1, 1, 1, 0, '2026-03-04 07:13:44'),
(29, 1, 'Fehér póló 5', 'Szép fehér póló, alig viselt.', 1900, 'kielegito', 'Iskola bejárat', NULL, NULL, NULL, 1, 1, 1, 0, '2026-03-04 07:13:44'),
(30, 1, 'Pulcsi', 'Meleg pulcsi télre.', 3000, 'jo', 'Iskola bejárat', NULL, NULL, NULL, 1, 1, 2, 0, '2026-03-04 07:13:44'),
(31, 1, 'Pulcsi 2', 'Meleg pulcsi télre.', 3100, 'kivalo', 'Iskola bejárat', NULL, NULL, NULL, 1, 1, 2, 0, '2026-03-04 07:13:44'),
(32, 1, 'Pulcsi 3', 'Meleg pulcsi télre.', 3200, 'uj', 'Iskola bejárat', NULL, NULL, NULL, 1, 1, 2, 0, '2026-03-04 07:13:44'),
(33, 1, 'Pulcsi 4', 'Meleg pulcsi télre.', 3300, 'jo', 'Iskola bejárat', NULL, NULL, NULL, 1, 1, 2, 0, '2026-03-04 07:13:44'),
(34, 1, 'Pulcsi 5', 'Meleg pulcsi télre.', 3400, 'kielegito', 'Iskola bejárat', NULL, NULL, NULL, 1, 1, 2, 0, '2026-03-04 07:13:44'),
(35, 1, 'Farmer nadrág', 'Kék farmer, 36-os méret.', 4000, 'jo', 'Iskola bejárat', NULL, NULL, NULL, 1, 1, 3, 0, '2026-03-04 07:13:44'),
(36, 1, 'Farmer nadrág 2', 'Kék farmer, 36-os méret.', 4100, 'kivalo', 'Iskola bejárat', NULL, NULL, NULL, 1, 1, 3, 0, '2026-03-04 07:13:44'),
(37, 1, 'Farmer nadrág 3', 'Kék farmer, 36-os méret.', 4200, 'uj', 'Iskola bejárat', NULL, NULL, NULL, 1, 1, 3, 0, '2026-03-04 07:13:44'),
(38, 1, 'Farmer nadrág 4', 'Kék farmer, 36-os méret.', 4300, 'jo', 'Iskola bejárat', NULL, NULL, NULL, 1, 1, 3, 0, '2026-03-04 07:13:44'),
(39, 1, 'Farmer nadrág 5', 'Kék farmer, 36-os méret.', 4400, 'kielegito', 'Iskola bejárat', NULL, NULL, NULL, 1, 1, 3, 0, '2026-03-04 07:13:44'),
(40, 1, 'Téli kabát', 'Meleg téli kabát, M-es.', 8000, 'jo', 'Iskola bejárat', NULL, NULL, NULL, 1, 1, 4, 0, '2026-03-04 07:13:44'),
(41, 1, 'Téli kabát 2', 'Meleg téli kabát, M-es.', 8100, 'kivalo', 'Iskola bejárat', NULL, NULL, NULL, 1, 1, 4, 0, '2026-03-04 07:13:44'),
(42, 1, 'Téli kabát 3', 'Meleg téli kabát, M-es.', 8200, 'uj', 'Iskola bejárat', NULL, NULL, NULL, 1, 1, 4, 0, '2026-03-04 07:13:44'),
(43, 1, 'Téli kabát 4', 'Meleg téli kabát, M-es.', 8300, 'jo', 'Iskola bejárat', NULL, NULL, NULL, 1, 1, 4, 0, '2026-03-04 07:13:44'),
(44, 1, 'Téli kabát 5', 'Meleg téli kabát, M-es.', 8400, 'kielegito', 'Iskola bejárat', NULL, NULL, NULL, 1, 1, 4, 0, '2026-03-04 07:13:44'),
(45, 1, 'Nike sportcipő', 'Nike Air, 38-as.', 12000, 'jo', 'Iskola bejárat', NULL, NULL, NULL, 1, 2, 5, 0, '2026-03-04 07:13:44'),
(46, 1, 'Nike sportcipő 2', 'Nike Air, 38-as.', 12100, 'kivalo', 'Iskola bejárat', NULL, NULL, NULL, 1, 2, 5, 0, '2026-03-04 07:13:44'),
(47, 1, 'Nike sportcipő 3', 'Nike Air, 38-as.', 12200, 'uj', 'Iskola bejárat', NULL, NULL, NULL, 1, 2, 5, 0, '2026-03-04 07:13:44'),
(48, 1, 'Nike sportcipő 4', 'Nike Air, 38-as.', 12300, 'jo', 'Iskola bejárat', NULL, NULL, NULL, 1, 2, 5, 0, '2026-03-04 07:13:44'),
(49, 1, 'Nike sportcipő 5', 'Nike Air, 38-as.', 12400, 'kielegito', 'Iskola bejárat', NULL, NULL, NULL, 1, 2, 5, 0, '2026-03-04 07:13:44'),
(50, 1, 'Bakancs', 'Barna bakancs, 38-as.', 9000, 'jo', 'Iskola bejárat', NULL, NULL, NULL, 1, 2, 6, 0, '2026-03-04 07:13:44'),
(51, 1, 'Bakancs 2', 'Barna bakancs, 38-as.', 9100, 'kivalo', 'Iskola bejárat', NULL, NULL, NULL, 1, 2, 6, 0, '2026-03-04 07:13:44'),
(52, 1, 'Bakancs 3', 'Barna bakancs, 38-as.', 9200, 'uj', 'Iskola bejárat', NULL, NULL, NULL, 1, 2, 6, 0, '2026-03-04 07:13:44'),
(53, 1, 'Bakancs 4', 'Barna bakancs, 38-as.', 9300, 'jo', 'Iskola bejárat', NULL, NULL, NULL, 1, 2, 6, 0, '2026-03-04 07:13:44'),
(54, 1, 'Bakancs 5', 'Barna bakancs, 38-as.', 9400, 'kielegito', 'Iskola bejárat', NULL, NULL, NULL, 1, 2, 6, 0, '2026-03-04 07:13:44'),
(55, 1, 'Tornacipő', 'Fehér tornacipő, 38-as.', 5000, 'jo', 'Tornaterem', NULL, NULL, NULL, 1, 2, 7, 0, '2026-03-04 07:13:44'),
(56, 1, 'Tornacipő 2', 'Fehér tornacipő, 38-as.', 5100, 'kivalo', 'Tornaterem', NULL, NULL, NULL, 1, 2, 7, 0, '2026-03-04 07:13:44'),
(57, 1, 'Tornacipő 3', 'Fehér tornacipő, 38-as.', 5200, 'uj', 'Tornaterem', NULL, NULL, NULL, 1, 2, 7, 0, '2026-03-04 07:13:44'),
(58, 1, 'Tornacipő 4', 'Fehér tornacipő, 38-as.', 5300, 'jo', 'Tornaterem', NULL, NULL, NULL, 1, 2, 7, 0, '2026-03-04 07:13:44'),
(59, 1, 'Tornacipő 5', 'Fehér tornacipő, 38-as.', 5400, 'kielegito', 'Tornaterem', NULL, NULL, NULL, 1, 2, 7, 0, '2026-03-04 07:13:44'),
(60, 1, 'Sapka', 'Téli sapka, kék.', 1000, 'jo', 'Iskola bejárat', NULL, NULL, NULL, 1, 3, 8, 0, '2026-03-04 07:13:44'),
(61, 1, 'Sapka 2', 'Téli sapka, kék.', 1100, 'kivalo', 'Iskola bejárat', NULL, NULL, NULL, 1, 3, 8, 0, '2026-03-04 07:13:44'),
(62, 1, 'Sapka 3', 'Téli sapka, kék.', 1200, 'uj', 'Iskola bejárat', NULL, NULL, NULL, 1, 3, 8, 0, '2026-03-04 07:13:44'),
(63, 1, 'Sapka 4', 'Téli sapka, kék.', 1300, 'jo', 'Iskola bejárat', NULL, NULL, NULL, 1, 3, 8, 0, '2026-03-04 07:13:44'),
(64, 1, 'Sapka 5', 'Téli sapka, kék.', 1400, 'kielegito', 'Iskola bejárat', NULL, NULL, NULL, 1, 3, 8, 0, '2026-03-04 07:13:44'),
(65, 1, 'Táska', 'Fekete válltáska.', 3500, 'jo', 'Iskola bejárat', NULL, NULL, NULL, 1, 3, 9, 0, '2026-03-04 07:13:44'),
(66, 1, 'Táska 2', 'Fekete válltáska.', 3600, 'kivalo', 'Iskola bejárat', NULL, NULL, NULL, 1, 3, 9, 0, '2026-03-04 07:13:44'),
(67, 1, 'Táska 3', 'Fekete válltáska.', 3700, 'uj', 'Iskola bejárat', NULL, NULL, NULL, 1, 3, 9, 0, '2026-03-04 07:13:44'),
(68, 1, 'Táska 4', 'Fekete válltáska.', 3800, 'jo', 'Iskola bejárat', NULL, NULL, NULL, 1, 3, 9, 0, '2026-03-04 07:13:44'),
(69, 1, 'Táska 5', 'Fekete válltáska.', 3900, 'kielegito', 'Iskola bejárat', NULL, NULL, NULL, 1, 3, 9, 0, '2026-03-04 07:13:44'),
(70, 1, 'Öv', 'Bőr öv, fekete.', 800, 'jo', 'Iskola bejárat', NULL, NULL, NULL, 1, 3, 10, 0, '2026-03-04 07:13:44'),
(71, 1, 'Öv 2', 'Bőr öv, fekete.', 900, 'kivalo', 'Iskola bejárat', NULL, NULL, NULL, 1, 3, 10, 0, '2026-03-04 07:13:44'),
(72, 1, 'Öv 3', 'Bőr öv, fekete.', 1000, 'uj', 'Iskola bejárat', NULL, NULL, NULL, 1, 3, 10, 0, '2026-03-04 07:13:44'),
(73, 1, 'Öv 4', 'Bőr öv, fekete.', 1100, 'jo', 'Iskola bejárat', NULL, NULL, NULL, 1, 3, 10, 0, '2026-03-04 07:13:44'),
(74, 1, 'Öv 5', 'Bőr öv, fekete.', 1200, 'kielegito', 'Iskola bejárat', NULL, NULL, NULL, 1, 3, 10, 0, '2026-03-04 07:13:44'),
(75, 1, 'Ékszer', 'Ezüst nyaklánc.', 2000, 'jo', 'Iskola bejárat', NULL, NULL, NULL, 1, 3, 11, 0, '2026-03-04 07:13:44'),
(76, 1, 'Ékszer 2', 'Ezüst nyaklánc.', 2100, 'kivalo', 'Iskola bejárat', NULL, NULL, NULL, 1, 3, 11, 0, '2026-03-04 07:13:44'),
(77, 1, 'Ékszer 3', 'Ezüst nyaklánc.', 2200, 'uj', 'Iskola bejárat', NULL, NULL, NULL, 1, 3, 11, 0, '2026-03-04 07:13:44'),
(78, 1, 'Ékszer 4', 'Ezüst nyaklánc.', 2300, 'jo', 'Iskola bejárat', NULL, NULL, NULL, 1, 3, 11, 0, '2026-03-04 07:13:44'),
(79, 1, 'Ékszer 5', 'Ezüst nyaklánc.', 2400, 'kielegito', 'Iskola bejárat', NULL, NULL, NULL, 1, 3, 11, 0, '2026-03-04 07:13:44'),
(80, 1, 'Szalagavatós ruha', 'Elegáns ruha szalagavatóra.', 15000, 'kivalo', 'Iskola bejárat', NULL, NULL, NULL, 1, 4, 12, 0, '2026-03-04 07:13:44'),
(81, 1, 'Szalagavatós ruha 2', 'Elegáns ruha szalagavatóra.', 15100, 'uj', 'Iskola bejárat', NULL, NULL, NULL, 1, 4, 12, 0, '2026-03-04 07:13:44'),
(82, 1, 'Szalagavatós ruha 3', 'Elegáns ruha szalagavatóra.', 15200, 'jo', 'Iskola bejárat', NULL, NULL, NULL, 1, 4, 12, 0, '2026-03-04 07:13:44'),
(83, 1, 'Szalagavatós ruha 4', 'Elegáns ruha szalagavatóra.', 15300, 'kivalo', 'Iskola bejárat', NULL, NULL, NULL, 1, 4, 12, 0, '2026-03-04 07:13:44'),
(84, 1, 'Szalagavatós ruha 5', 'Elegáns ruha szalagavatóra.', 15400, 'kielegito', 'Iskola bejárat', NULL, NULL, NULL, 1, 4, 12, 0, '2026-03-04 07:13:44'),
(85, 1, 'Ballagási ruha', 'Fehér ruha ballagásra.', 12000, 'kivalo', 'Iskola bejárat', NULL, NULL, NULL, 1, 4, 13, 0, '2026-03-04 07:13:44'),
(86, 1, 'Ballagási ruha 2', 'Fehér ruha ballagásra.', 12100, 'uj', 'Iskola bejárat', NULL, NULL, NULL, 1, 4, 13, 0, '2026-03-04 07:13:44'),
(87, 1, 'Ballagási ruha 3', 'Fehér ruha ballagásra.', 12200, 'jo', 'Iskola bejárat', NULL, NULL, NULL, 1, 4, 13, 0, '2026-03-04 07:13:44'),
(88, 1, 'Ballagási ruha 4', 'Fehér ruha ballagásra.', 12300, 'kivalo', 'Iskola bejárat', NULL, NULL, NULL, 1, 4, 13, 0, '2026-03-04 07:13:44'),
(89, 1, 'Ballagási ruha 5', 'Fehér ruha ballagásra.', 12400, 'kielegito', 'Iskola bejárat', NULL, NULL, NULL, 1, 4, 13, 0, '2026-03-04 07:13:44'),
(90, 1, 'Buliruha', 'Fekete buliruha.', 6000, 'jo', 'Iskola bejárat', NULL, NULL, NULL, 1, 4, 14, 0, '2026-03-04 07:13:44'),
(91, 1, 'Buliruha 2', 'Fekete buliruha.', 6100, 'kivalo', 'Iskola bejárat', NULL, NULL, NULL, 1, 4, 14, 0, '2026-03-04 07:13:44'),
(92, 1, 'Buliruha 3', 'Fekete buliruha.', 6200, 'uj', 'Iskola bejárat', NULL, NULL, NULL, 1, 4, 14, 0, '2026-03-04 07:13:44'),
(93, 1, 'Buliruha 4', 'Fekete buliruha.', 6300, 'jo', 'Iskola bejárat', NULL, NULL, NULL, 1, 4, 14, 0, '2026-03-04 07:13:44'),
(94, 1, 'Buliruha 5', 'Fekete buliruha.', 6400, 'kielegito', 'Iskola bejárat', NULL, NULL, NULL, 1, 4, 14, 0, '2026-03-04 07:13:44'),
(95, 1, 'Férfi póló', 'Fekete póló, M-es.', 1500, 'jo', 'Iskola bejárat', NULL, NULL, NULL, 2, 5, 15, 0, '2026-03-04 07:13:44'),
(96, 1, 'Férfi póló 2', 'Fekete póló, M-es.', 1600, 'kivalo', 'Iskola bejárat', NULL, NULL, NULL, 2, 5, 15, 0, '2026-03-04 07:13:44'),
(97, 1, 'Férfi póló 3', 'Fekete póló, M-es.', 1700, 'uj', 'Iskola bejárat', NULL, NULL, NULL, 2, 5, 15, 0, '2026-03-04 07:13:44'),
(98, 1, 'Férfi póló 4', 'Fekete póló, M-es.', 1800, 'jo', 'Iskola bejárat', NULL, NULL, NULL, 2, 5, 15, 0, '2026-03-04 07:13:44'),
(99, 1, 'Férfi póló 5', 'Fekete póló, M-es.', 1900, 'kielegito', 'Iskola bejárat', NULL, NULL, NULL, 2, 5, 15, 0, '2026-03-04 07:13:44'),
(100, 1, 'Férfi pulcsi', 'Szürke kapucnis pulcsi.', 4000, 'jo', 'Iskola bejárat', NULL, NULL, NULL, 2, 5, 16, 0, '2026-03-04 07:13:44'),
(101, 1, 'Férfi pulcsi 2', 'Szürke kapucnis pulcsi.', 4100, 'kivalo', 'Iskola bejárat', NULL, NULL, NULL, 2, 5, 16, 0, '2026-03-04 07:13:44'),
(102, 1, 'Férfi pulcsi 3', 'Szürke kapucnis pulcsi.', 4200, 'uj', 'Iskola bejárat', NULL, NULL, NULL, 2, 5, 16, 0, '2026-03-04 07:13:44'),
(103, 1, 'Férfi pulcsi 4', 'Szürke kapucnis pulcsi.', 4300, 'jo', 'Iskola bejárat', NULL, NULL, NULL, 2, 5, 16, 0, '2026-03-04 07:13:44'),
(104, 1, 'Férfi pulcsi 5', 'Szürke kapucnis pulcsi.', 4400, 'kielegito', 'Iskola bejárat', NULL, NULL, NULL, 2, 5, 16, 0, '2026-03-04 07:13:44'),
(105, 1, 'Férfi farmer', 'Sötétkék farmer, 32-es.', 5000, 'jo', 'Iskola bejárat', NULL, NULL, NULL, 2, 5, 17, 0, '2026-03-04 07:13:44'),
(106, 1, 'Férfi farmer 2', 'Sötétkék farmer, 32-es.', 5100, 'kivalo', 'Iskola bejárat', NULL, NULL, NULL, 2, 5, 17, 0, '2026-03-04 07:13:44'),
(107, 1, 'Férfi farmer 3', 'Sötétkék farmer, 32-es.', 5200, 'uj', 'Iskola bejárat', NULL, NULL, NULL, 2, 5, 17, 0, '2026-03-04 07:13:44'),
(108, 1, 'Férfi farmer 4', 'Sötétkék farmer, 32-es.', 5300, 'jo', 'Iskola bejárat', NULL, NULL, NULL, 2, 5, 17, 0, '2026-03-04 07:13:44'),
(109, 1, 'Férfi farmer 5', 'Sötétkék farmer, 32-es.', 5400, 'kielegito', 'Iskola bejárat', NULL, NULL, NULL, 2, 5, 17, 0, '2026-03-04 07:13:44'),
(110, 1, 'Férfi kabát', 'Fekete télikabát, L-es.', 10000, 'jo', 'Iskola bejárat', NULL, NULL, NULL, 2, 5, 18, 0, '2026-03-04 07:13:44'),
(111, 1, 'Férfi kabát 2', 'Fekete télikabát, L-es.', 10100, 'kivalo', 'Iskola bejárat', NULL, NULL, NULL, 2, 5, 18, 0, '2026-03-04 07:13:44'),
(112, 1, 'Férfi kabát 3', 'Fekete télikabát, L-es.', 10200, 'uj', 'Iskola bejárat', NULL, NULL, NULL, 2, 5, 18, 0, '2026-03-04 07:13:44'),
(113, 1, 'Férfi kabát 4', 'Fekete télikabát, L-es.', 10300, 'jo', 'Iskola bejárat', NULL, NULL, NULL, 2, 5, 18, 0, '2026-03-04 07:13:44'),
(114, 1, 'Férfi kabát 5', 'Fekete télikabát, L-es.', 10400, 'kielegito', 'Iskola bejárat', NULL, NULL, NULL, 2, 5, 18, 0, '2026-03-04 07:13:44'),
(115, 1, 'Férfi sportcipő', 'Adidas, 42-es.', 13000, 'jo', 'Iskola bejárat', NULL, NULL, NULL, 2, 6, 19, 0, '2026-03-04 07:13:44'),
(116, 1, 'Férfi sportcipő 2', 'Adidas, 42-es.', 13100, 'kivalo', 'Iskola bejárat', NULL, NULL, NULL, 2, 6, 19, 0, '2026-03-04 07:13:44'),
(117, 1, 'Férfi sportcipő 3', 'Adidas, 42-es.', 13200, 'uj', 'Iskola bejárat', NULL, NULL, NULL, 2, 6, 19, 0, '2026-03-04 07:13:44'),
(118, 1, 'Férfi sportcipő 4', 'Adidas, 42-es.', 13300, 'jo', 'Iskola bejárat', NULL, NULL, NULL, 2, 6, 19, 0, '2026-03-04 07:13:44'),
(119, 1, 'Férfi sportcipő 5', 'Adidas, 42-es.', 13400, 'kielegito', 'Iskola bejárat', NULL, NULL, NULL, 2, 6, 19, 0, '2026-03-04 07:13:44'),
(120, 1, 'Férfi bakancs', 'Barna bőr bakancs, 42-es.', 11000, 'jo', 'Iskola bejárat', NULL, NULL, NULL, 2, 6, 20, 0, '2026-03-04 07:13:44'),
(121, 1, 'Férfi bakancs 2', 'Barna bőr bakancs, 42-es.', 11100, 'kivalo', 'Iskola bejárat', NULL, NULL, NULL, 2, 6, 20, 0, '2026-03-04 07:13:44'),
(122, 1, 'Férfi bakancs 3', 'Barna bőr bakancs, 42-es.', 11200, 'uj', 'Iskola bejárat', NULL, NULL, NULL, 2, 6, 20, 0, '2026-03-04 07:13:44'),
(123, 1, 'Férfi bakancs 4', 'Barna bőr bakancs, 42-es.', 11300, 'jo', 'Iskola bejárat', NULL, NULL, NULL, 2, 6, 20, 0, '2026-03-04 07:13:44'),
(124, 1, 'Férfi bakancs 5', 'Barna bőr bakancs, 42-es.', 11400, 'kielegito', 'Iskola bejárat', NULL, NULL, NULL, 2, 6, 20, 0, '2026-03-04 07:13:44'),
(125, 1, 'Férfi tornacipő', 'Fehér tornacipő, 42-es.', 4500, 'jo', 'Tornaterem', NULL, NULL, NULL, 2, 6, 21, 0, '2026-03-04 07:13:44'),
(126, 1, 'Férfi tornacipő 2', 'Fehér tornacipő, 42-es.', 4600, 'kivalo', 'Tornaterem', NULL, NULL, NULL, 2, 6, 21, 0, '2026-03-04 07:13:44'),
(127, 1, 'Férfi tornacipő 3', 'Fehér tornacipő, 42-es.', 4700, 'uj', 'Tornaterem', NULL, NULL, NULL, 2, 6, 21, 0, '2026-03-04 07:13:44'),
(128, 1, 'Férfi tornacipő 4', 'Fehér tornacipő, 42-es.', 4800, 'jo', 'Tornaterem', NULL, NULL, NULL, 2, 6, 21, 0, '2026-03-04 07:13:44'),
(129, 1, 'Férfi tornacipő 5', 'Fehér tornacipő, 42-es.', 4900, 'kielegito', 'Tornaterem', NULL, NULL, NULL, 2, 6, 21, 0, '2026-03-04 07:13:44'),
(130, 1, 'Férfi sapka', 'Fekete baseball sapka.', 1200, 'jo', 'Iskola bejárat', NULL, NULL, NULL, 2, 7, 22, 0, '2026-03-04 07:13:44'),
(131, 1, 'Férfi sapka 2', 'Fekete baseball sapka.', 1300, 'kivalo', 'Iskola bejárat', NULL, NULL, NULL, 2, 7, 22, 0, '2026-03-04 07:13:44'),
(132, 1, 'Férfi sapka 3', 'Fekete baseball sapka.', 1400, 'uj', 'Iskola bejárat', NULL, NULL, NULL, 2, 7, 22, 0, '2026-03-04 07:13:44'),
(133, 1, 'Férfi sapka 4', 'Fekete baseball sapka.', 1500, 'jo', 'Iskola bejárat', NULL, NULL, NULL, 2, 7, 22, 0, '2026-03-04 07:13:44'),
(134, 1, 'Férfi sapka 5', 'Fekete baseball sapka.', 1600, 'kielegito', 'Iskola bejárat', NULL, NULL, NULL, 2, 7, 22, 0, '2026-03-04 07:13:44'),
(135, 1, 'Férfi táska', 'Fekete hátizsák.', 4000, 'jo', 'Iskola bejárat', NULL, NULL, NULL, 2, 7, 23, 0, '2026-03-04 07:13:44'),
(136, 1, 'Férfi táska 2', 'Fekete hátizsák.', 4100, 'kivalo', 'Iskola bejárat', NULL, NULL, NULL, 2, 7, 23, 0, '2026-03-04 07:13:44'),
(137, 1, 'Férfi táska 3', 'Fekete hátizsák.', 4200, 'uj', 'Iskola bejárat', NULL, NULL, NULL, 2, 7, 23, 0, '2026-03-04 07:13:44'),
(138, 1, 'Férfi táska 4', 'Fekete hátizsák.', 4300, 'jo', 'Iskola bejárat', NULL, NULL, NULL, 2, 7, 23, 0, '2026-03-04 07:13:44'),
(139, 1, 'Férfi táska 5', 'Fekete hátizsák.', 4400, 'kielegito', 'Iskola bejárat', NULL, NULL, NULL, 2, 7, 23, 0, '2026-03-04 07:13:44'),
(140, 1, 'Férfi öv', 'Fekete bőr öv, 85cm.', 1500, 'jo', 'Iskola bejárat', NULL, NULL, NULL, 2, 7, 24, 0, '2026-03-04 07:13:44'),
(141, 1, 'Férfi öv 2', 'Fekete bőr öv, 85cm.', 1600, 'kivalo', 'Iskola bejárat', NULL, NULL, NULL, 2, 7, 24, 0, '2026-03-04 07:13:44'),
(142, 1, 'Férfi öv 3', 'Fekete bőr öv, 85cm.', 1700, 'uj', 'Iskola bejárat', NULL, NULL, NULL, 2, 7, 24, 0, '2026-03-04 07:13:44'),
(143, 1, 'Férfi öv 4', 'Fekete bőr öv, 85cm.', 1800, 'jo', 'Iskola bejárat', NULL, NULL, NULL, 2, 7, 24, 0, '2026-03-04 07:13:44'),
(144, 1, 'Férfi öv 5', 'Fekete bőr öv, 85cm.', 1900, 'kielegito', 'Iskola bejárat', NULL, NULL, NULL, 2, 7, 24, 0, '2026-03-04 07:13:44'),
(145, 1, 'Férfi öltöny', 'Fekete öltöny ballagásra.', 20000, 'kivalo', 'Iskola bejárat', NULL, NULL, NULL, 2, 8, 25, 0, '2026-03-04 07:13:44'),
(146, 1, 'Férfi öltöny 2', 'Fekete öltöny ballagásra.', 20100, 'uj', 'Iskola bejárat', NULL, NULL, NULL, 2, 8, 25, 0, '2026-03-04 07:13:44'),
(147, 1, 'Férfi öltöny 3', 'Fekete öltöny ballagásra.', 20200, 'jo', 'Iskola bejárat', NULL, NULL, NULL, 2, 8, 25, 0, '2026-03-04 07:13:44'),
(148, 1, 'Férfi öltöny 4', 'Fekete öltöny ballagásra.', 20300, 'kivalo', 'Iskola bejárat', NULL, NULL, NULL, 2, 8, 25, 0, '2026-03-04 07:13:44'),
(149, 1, 'Férfi öltöny 5', 'Fekete öltöny ballagásra.', 20400, 'kielegito', 'Iskola bejárat', NULL, NULL, NULL, 2, 8, 25, 0, '2026-03-04 07:13:44'),
(150, 1, 'Férfi buliing', 'Fekete ing bulikra.', 5000, 'jo', 'Iskola bejárat', NULL, NULL, NULL, 2, 8, 26, 0, '2026-03-04 07:13:44'),
(151, 1, 'Férfi buliing 2', 'Fekete ing bulikra.', 5100, 'kivalo', 'Iskola bejárat', NULL, NULL, NULL, 2, 8, 26, 0, '2026-03-04 07:13:44'),
(152, 1, 'Férfi buliing 3', 'Fekete ing bulikra.', 5200, 'uj', 'Iskola bejárat', NULL, NULL, NULL, 2, 8, 26, 0, '2026-03-04 07:13:44'),
(153, 1, 'Férfi buliing 4', 'Fekete ing bulikra.', 5300, 'jo', 'Iskola bejárat', NULL, NULL, NULL, 2, 8, 26, 0, '2026-03-04 07:13:44'),
(154, 1, 'Férfi buliing 5', 'Fekete ing bulikra.', 5400, 'kielegito', 'Iskola bejárat', NULL, NULL, NULL, 2, 8, 26, 0, '2026-03-04 07:13:44'),
(155, 1, 'Toll csomag', 'Parker toll, 5db.', 1500, 'uj', 'Iskola bejárat', NULL, NULL, NULL, 3, 10, 30, 0, '2026-03-04 07:13:44'),
(156, 1, 'Toll csomag 2', 'Parker toll, 5db.', 1600, 'kivalo', 'Iskola bejárat', NULL, NULL, NULL, 3, 10, 30, 0, '2026-03-04 07:13:44'),
(157, 1, 'Toll csomag 3', 'Parker toll, 5db.', 1700, 'jo', 'Iskola bejárat', NULL, NULL, NULL, 3, 10, 30, 0, '2026-03-04 07:13:44'),
(158, 1, 'Toll csomag 4', 'Parker toll, 5db.', 1800, 'uj', 'Iskola bejárat', NULL, NULL, NULL, 3, 10, 30, 0, '2026-03-04 07:13:44'),
(159, 1, 'Toll csomag 5', 'Parker toll, 5db.', 1900, 'kivalo', 'Iskola bejárat', NULL, NULL, NULL, 3, 10, 30, 0, '2026-03-04 07:13:44'),
(160, 1, 'Ceruza készlet', 'Stabilo ceruza készlet.', 800, 'uj', 'Iskola bejárat', NULL, NULL, NULL, 3, 10, 31, 0, '2026-03-04 07:13:44'),
(161, 1, 'Ceruza készlet 2', 'Stabilo ceruza készlet.', 900, 'kivalo', 'Iskola bejárat', NULL, NULL, NULL, 3, 10, 31, 0, '2026-03-04 07:13:44'),
(162, 1, 'Ceruza készlet 3', 'Stabilo ceruza készlet.', 1000, 'jo', 'Iskola bejárat', NULL, NULL, NULL, 3, 10, 31, 0, '2026-03-04 07:13:44'),
(163, 1, 'Ceruza készlet 4', 'Stabilo ceruza készlet.', 1100, 'uj', 'Iskola bejárat', NULL, NULL, NULL, 3, 10, 31, 0, '2026-03-04 07:13:44'),
(164, 1, 'Ceruza készlet 5', 'Stabilo ceruza készlet.', 1200, 'kivalo', 'Iskola bejárat', NULL, NULL, NULL, 3, 10, 31, 0, '2026-03-04 07:13:44'),
(165, 1, 'Marker szett', 'Edding marker szett.', 1200, 'uj', 'Iskola bejárat', NULL, NULL, NULL, 3, 10, 32, 0, '2026-03-04 07:13:44'),
(166, 1, 'Marker szett 2', 'Edding marker szett.', 1300, 'kivalo', 'Iskola bejárat', NULL, NULL, NULL, 3, 10, 32, 0, '2026-03-04 07:13:44'),
(167, 1, 'Marker szett 3', 'Edding marker szett.', 1400, 'jo', 'Iskola bejárat', NULL, NULL, NULL, 3, 10, 32, 0, '2026-03-04 07:13:44'),
(168, 1, 'Marker szett 4', 'Edding marker szett.', 1500, 'uj', 'Iskola bejárat', NULL, NULL, NULL, 3, 10, 32, 0, '2026-03-04 07:13:44'),
(169, 1, 'Marker szett 5', 'Edding marker szett.', 1600, 'kivalo', 'Iskola bejárat', NULL, NULL, NULL, 3, 10, 32, 0, '2026-03-04 07:13:44'),
(170, 1, 'Iskolai hátizsák', 'JanSport hátizsák.', 5000, 'jo', 'Iskola bejárat', NULL, NULL, NULL, 3, 11, 33, 0, '2026-03-04 07:13:44'),
(171, 1, 'Iskolai hátizsák 2', 'JanSport hátizsák.', 5100, 'kivalo', 'Iskola bejárat', NULL, NULL, NULL, 3, 11, 33, 0, '2026-03-04 07:13:44'),
(172, 1, 'Iskolai hátizsák 3', 'JanSport hátizsák.', 5200, 'uj', 'Iskola bejárat', NULL, NULL, NULL, 3, 11, 33, 0, '2026-03-04 07:13:44'),
(173, 1, 'Iskolai hátizsák 4', 'JanSport hátizsák.', 5300, 'jo', 'Iskola bejárat', NULL, NULL, NULL, 3, 11, 33, 0, '2026-03-04 07:13:44'),
(174, 1, 'Iskolai hátizsák 5', 'JanSport hátizsák.', 5400, 'kielegito', 'Iskola bejárat', NULL, NULL, NULL, 3, 11, 33, 0, '2026-03-04 07:13:44'),
(175, 1, 'Oldaltáska', 'Vászon oldaltáska.', 2000, 'jo', 'Iskola bejárat', NULL, NULL, NULL, 3, 11, 34, 0, '2026-03-04 07:13:44'),
(176, 1, 'Oldaltáska 2', 'Vászon oldaltáska.', 2100, 'kivalo', 'Iskola bejárat', NULL, NULL, NULL, 3, 11, 34, 0, '2026-03-04 07:13:44'),
(177, 1, 'Oldaltáska 3', 'Vászon oldaltáska.', 2200, 'uj', 'Iskola bejárat', NULL, NULL, NULL, 3, 11, 34, 0, '2026-03-04 07:13:44'),
(178, 1, 'Oldaltáska 4', 'Vászon oldaltáska.', 2300, 'jo', 'Iskola bejárat', NULL, NULL, NULL, 3, 11, 34, 0, '2026-03-04 07:13:44'),
(179, 1, 'Oldaltáska 5', 'Vászon oldaltáska.', 2400, 'kielegito', 'Iskola bejárat', NULL, NULL, NULL, 3, 11, 34, 0, '2026-03-04 07:13:44'),
(180, 1, 'Tolltartó', 'Műbőr tolltartó.', 800, 'jo', 'Iskola bejárat', NULL, NULL, NULL, 3, 11, 35, 0, '2026-03-04 07:13:44'),
(181, 1, 'Tolltartó 2', 'Műbőr tolltartó.', 900, 'kivalo', 'Iskola bejárat', NULL, NULL, NULL, 3, 11, 35, 0, '2026-03-04 07:13:44'),
(182, 1, 'Tolltartó 3', 'Műbőr tolltartó.', 1000, 'uj', 'Iskola bejárat', NULL, NULL, NULL, 3, 11, 35, 0, '2026-03-04 07:13:44'),
(183, 1, 'Tolltartó 4', 'Műbőr tolltartó.', 1100, 'jo', 'Iskola bejárat', NULL, NULL, NULL, 3, 11, 35, 0, '2026-03-04 07:13:44'),
(184, 1, 'Tolltartó 5', 'Műbőr tolltartó.', 1200, 'kielegito', 'Iskola bejárat', NULL, NULL, NULL, 3, 11, 35, 0, '2026-03-04 07:13:44'),
(185, 1, 'Vonalzó szett', '30cm-es vonalzó.', 300, 'uj', 'Iskola bejárat', NULL, NULL, NULL, 3, 12, 36, 0, '2026-03-04 07:13:44'),
(186, 1, 'Vonalzó szett 2', '30cm-es vonalzó.', 400, 'kivalo', 'Iskola bejárat', NULL, NULL, NULL, 3, 12, 36, 0, '2026-03-04 07:13:44'),
(187, 1, 'Vonalzó szett 3', '30cm-es vonalzó.', 500, 'jo', 'Iskola bejárat', NULL, NULL, NULL, 3, 12, 36, 0, '2026-03-04 07:13:44'),
(188, 1, 'Vonalzó szett 4', '30cm-es vonalzó.', 600, 'uj', 'Iskola bejárat', NULL, NULL, NULL, 3, 12, 36, 0, '2026-03-04 07:13:44'),
(189, 1, 'Vonalzó szett 5', '30cm-es vonalzó.', 700, 'kivalo', 'Iskola bejárat', NULL, NULL, NULL, 3, 12, 36, 0, '2026-03-04 07:13:44'),
(190, 1, 'Körzőkészlet', 'Iskolai körzőkészlet.', 600, 'uj', 'Iskola bejárat', NULL, NULL, NULL, 3, 12, 37, 0, '2026-03-04 07:13:44'),
(191, 1, 'Körzőkészlet 2', 'Iskolai körzőkészlet.', 700, 'kivalo', 'Iskola bejárat', NULL, NULL, NULL, 3, 12, 37, 0, '2026-03-04 07:13:44'),
(192, 1, 'Körzőkészlet 3', 'Iskolai körzőkészlet.', 800, 'jo', 'Iskola bejárat', NULL, NULL, NULL, 3, 12, 37, 0, '2026-03-04 07:13:44'),
(193, 1, 'Körzőkészlet 4', 'Iskolai körzőkészlet.', 900, 'uj', 'Iskola bejárat', NULL, NULL, NULL, 3, 12, 37, 0, '2026-03-04 07:13:44'),
(194, 1, 'Körzőkészlet 5', 'Iskolai körzőkészlet.', 1000, 'kivalo', 'Iskola bejárat', NULL, NULL, NULL, 3, 12, 37, 0, '2026-03-04 07:13:44'),
(195, 1, 'Casio számológép', 'Casio fx-82, iskolai.', 3000, 'jo', 'Iskola bejárat', NULL, NULL, NULL, 3, 12, 38, 0, '2026-03-04 07:13:44'),
(196, 1, 'Casio számológép 2', 'Casio fx-82, iskolai.', 3100, 'kivalo', 'Iskola bejárat', NULL, NULL, NULL, 3, 12, 38, 0, '2026-03-04 07:13:44'),
(197, 1, 'Casio számológép 3', 'Casio fx-82, iskolai.', 3200, 'uj', 'Iskola bejárat', NULL, NULL, NULL, 3, 12, 38, 0, '2026-03-04 07:13:44'),
(198, 1, 'Casio számológép 4', 'Casio fx-82, iskolai.', 3300, 'jo', 'Iskola bejárat', NULL, NULL, NULL, 3, 12, 38, 0, '2026-03-04 07:13:44'),
(199, 1, 'Casio számológép 5', 'Casio fx-82, iskolai.', 3400, 'kielegito', 'Iskola bejárat', NULL, NULL, NULL, 3, 12, 38, 0, '2026-03-04 07:13:44'),
(200, 1, 'Laptop', 'Lenovo IdeaPad, 8GB RAM.', 80000, 'jo', 'Iskola bejárat', NULL, NULL, NULL, 4, 13, 39, 0, '2026-03-04 07:13:44'),
(201, 1, 'Laptop 2', 'Lenovo IdeaPad, 8GB RAM.', 82000, 'kivalo', 'Iskola bejárat', NULL, NULL, NULL, 4, 13, 39, 0, '2026-03-04 07:13:44'),
(202, 1, 'Laptop 3', 'Lenovo IdeaPad, 8GB RAM.', 84000, 'uj', 'Iskola bejárat', NULL, NULL, NULL, 4, 13, 39, 0, '2026-03-04 07:13:44'),
(203, 1, 'Laptop 4', 'Lenovo IdeaPad, 8GB RAM.', 86000, 'jo', 'Iskola bejárat', NULL, NULL, NULL, 4, 13, 39, 0, '2026-03-04 07:13:44'),
(204, 1, 'Laptop 5', 'Lenovo IdeaPad, 8GB RAM.', 88000, 'kielegito', 'Iskola bejárat', NULL, NULL, NULL, 4, 13, 39, 0, '2026-03-04 07:13:44'),
(205, 1, 'Gaming egér', 'Logitech G203.', 5000, 'jo', 'Iskola bejárat', NULL, NULL, NULL, 4, 13, 40, 0, '2026-03-04 07:13:44'),
(206, 1, 'Gaming egér 2', 'Logitech G203.', 5100, 'kivalo', 'Iskola bejárat', NULL, NULL, NULL, 4, 13, 40, 0, '2026-03-04 07:13:44'),
(207, 1, 'Gaming egér 3', 'Logitech G203.', 5200, 'uj', 'Iskola bejárat', NULL, NULL, NULL, 4, 13, 40, 0, '2026-03-04 07:13:44'),
(208, 1, 'Gaming egér 4', 'Logitech G203.', 5300, 'jo', 'Iskola bejárat', NULL, NULL, NULL, 4, 13, 40, 0, '2026-03-04 07:13:44'),
(209, 1, 'Gaming egér 5', 'Logitech G203.', 5400, 'kielegito', 'Iskola bejárat', NULL, NULL, NULL, 4, 13, 40, 0, '2026-03-04 07:13:44'),
(210, 1, 'Billentyűzet', 'Mechanikus billentyűzet.', 12000, 'jo', 'Iskola bejárat', NULL, NULL, NULL, 4, 13, 41, 0, '2026-03-04 07:13:44'),
(211, 1, 'Billentyűzet 2', 'Mechanikus billentyűzet.', 12100, 'kivalo', 'Iskola bejárat', NULL, NULL, NULL, 4, 13, 41, 0, '2026-03-04 07:13:44'),
(212, 1, 'Billentyűzet 3', 'Mechanikus billentyűzet.', 12200, 'uj', 'Iskola bejárat', NULL, NULL, NULL, 4, 13, 41, 0, '2026-03-04 07:13:44'),
(213, 1, 'Billentyűzet 4', 'Mechanikus billentyűzet.', 12300, 'jo', 'Iskola bejárat', NULL, NULL, NULL, 4, 13, 41, 0, '2026-03-04 07:13:44'),
(214, 1, 'Billentyűzet 5', 'Mechanikus billentyűzet.', 12400, 'kielegito', 'Iskola bejárat', NULL, NULL, NULL, 4, 13, 41, 0, '2026-03-04 07:13:44'),
(215, 1, 'Fejhallgató', 'Sony WH-1000XM4.', 25000, 'jo', 'Iskola bejárat', NULL, NULL, NULL, 4, 13, 42, 0, '2026-03-04 07:13:44'),
(216, 1, 'Fejhallgató 2', 'Sony WH-1000XM4.', 25100, 'kivalo', 'Iskola bejárat', NULL, NULL, NULL, 4, 13, 42, 0, '2026-03-04 07:13:44'),
(217, 1, 'Fejhallgató 3', 'Sony WH-1000XM4.', 25200, 'uj', 'Iskola bejárat', NULL, NULL, NULL, 4, 13, 42, 0, '2026-03-04 07:13:44'),
(218, 1, 'Fejhallgató 4', 'Sony WH-1000XM4.', 25300, 'jo', 'Iskola bejárat', NULL, NULL, NULL, 4, 13, 42, 0, '2026-03-04 07:13:44'),
(219, 1, 'Fejhallgató 5', 'Sony WH-1000XM4.', 25400, 'kielegito', 'Iskola bejárat', NULL, NULL, NULL, 4, 13, 42, 0, '2026-03-04 07:13:44'),
(220, 1, 'iPhone 12', 'iPhone 12, 64GB, fekete.', 60000, 'jo', 'Iskola bejárat', NULL, NULL, NULL, 4, 14, 43, 0, '2026-03-04 07:13:44'),
(221, 1, 'iPhone 12 2', 'iPhone 12, 64GB, fekete.', 62000, 'kivalo', 'Iskola bejárat', NULL, NULL, NULL, 4, 14, 43, 0, '2026-03-04 07:13:44'),
(222, 1, 'iPhone 12 3', 'iPhone 12, 64GB, fekete.', 64000, 'jo', 'Iskola bejárat', NULL, NULL, NULL, 4, 14, 43, 0, '2026-03-04 07:13:44'),
(223, 1, 'iPhone 12 4', 'iPhone 12, 64GB, fekete.', 66000, 'kivalo', 'Iskola bejárat', NULL, NULL, NULL, 4, 14, 43, 0, '2026-03-04 07:13:44'),
(224, 1, 'iPhone 12 5', 'iPhone 12, 64GB, fekete.', 68000, 'kielegito', 'Iskola bejárat', NULL, NULL, NULL, 4, 14, 43, 0, '2026-03-04 07:13:44'),
(225, 1, 'Telefon tok', 'iPhone 12 szilikon tok.', 800, 'uj', 'Iskola bejárat', NULL, NULL, NULL, 4, 14, 44, 0, '2026-03-04 07:13:44'),
(226, 1, 'Telefon tok 2', 'iPhone 12 szilikon tok.', 900, 'kivalo', 'Iskola bejárat', NULL, NULL, NULL, 4, 14, 44, 0, '2026-03-04 07:13:44'),
(227, 1, 'Telefon tok 3', 'iPhone 12 szilikon tok.', 1000, 'jo', 'Iskola bejárat', NULL, NULL, NULL, 4, 14, 44, 0, '2026-03-04 07:13:44'),
(228, 1, 'Telefon tok 4', 'iPhone 12 szilikon tok.', 1100, 'uj', 'Iskola bejárat', NULL, NULL, NULL, 4, 14, 44, 0, '2026-03-04 07:13:44'),
(229, 1, 'Telefon tok 5', 'iPhone 12 szilikon tok.', 1200, 'kivalo', 'Iskola bejárat', NULL, NULL, NULL, 4, 14, 44, 0, '2026-03-04 07:13:44'),
(230, 1, 'USB-C töltő', '65W USB-C töltő.', 2500, 'uj', 'Iskola bejárat', NULL, NULL, NULL, 4, 14, 45, 0, '2026-03-04 07:13:44'),
(231, 1, 'USB-C töltő 2', '65W USB-C töltő.', 2600, 'kivalo', 'Iskola bejárat', NULL, NULL, NULL, 4, 14, 45, 0, '2026-03-04 07:13:44'),
(232, 1, 'USB-C töltő 3', '65W USB-C töltő.', 2700, 'jo', 'Iskola bejárat', NULL, NULL, NULL, 4, 14, 45, 0, '2026-03-04 07:13:44'),
(233, 1, 'USB-C töltő 4', '65W USB-C töltő.', 2800, 'uj', 'Iskola bejárat', NULL, NULL, NULL, 4, 14, 45, 0, '2026-03-04 07:13:44'),
(234, 1, 'USB-C töltő 5', '65W USB-C töltő.', 2900, 'kivalo', 'Iskola bejárat', NULL, NULL, NULL, 4, 14, 45, 0, '2026-03-04 07:13:44'),
(235, 1, 'PS4', 'PlayStation 4, 500GB.', 40000, 'jo', 'Iskola bejárat', NULL, NULL, NULL, 4, 15, 46, 0, '2026-03-04 07:13:44'),
(236, 1, 'PS4 2', 'PlayStation 4, 500GB.', 41000, 'kivalo', 'Iskola bejárat', NULL, NULL, NULL, 4, 15, 46, 0, '2026-03-04 07:13:44'),
(237, 1, 'PS4 3', 'PlayStation 4, 500GB.', 42000, 'jo', 'Iskola bejárat', NULL, NULL, NULL, 4, 15, 46, 0, '2026-03-04 07:13:44'),
(238, 1, 'PS4 4', 'PlayStation 4, 500GB.', 43000, 'kivalo', 'Iskola bejárat', NULL, NULL, NULL, 4, 15, 46, 0, '2026-03-04 07:13:44'),
(239, 1, 'PS4 5', 'PlayStation 4, 500GB.', 44000, 'kielegito', 'Iskola bejárat', NULL, NULL, NULL, 4, 15, 46, 0, '2026-03-04 07:13:44'),
(240, 1, 'FIFA 24', 'FIFA 24 PS4-re.', 5000, 'jo', 'Iskola bejárat', NULL, NULL, NULL, 4, 15, 47, 0, '2026-03-04 07:13:44'),
(241, 1, 'FIFA 24 2', 'FIFA 24 PS4-re.', 5100, 'kivalo', 'Iskola bejárat', NULL, NULL, NULL, 4, 15, 47, 0, '2026-03-04 07:13:44'),
(242, 1, 'FIFA 24 3', 'FIFA 24 PS4-re.', 5200, 'uj', 'Iskola bejárat', NULL, NULL, NULL, 4, 15, 47, 0, '2026-03-04 07:13:44'),
(243, 1, 'FIFA 24 4', 'FIFA 24 PS4-re.', 5300, 'jo', 'Iskola bejárat', NULL, NULL, NULL, 4, 15, 47, 0, '2026-03-04 07:13:44'),
(244, 1, 'FIFA 24 5', 'FIFA 24 PS4-re.', 5400, 'kielegito', 'Iskola bejárat', NULL, NULL, NULL, 4, 15, 47, 0, '2026-03-04 07:13:44'),
(245, 1, 'PS4 kontroller', 'DualShock 4, fekete.', 8000, 'jo', 'Iskola bejárat', NULL, NULL, NULL, 4, 15, 48, 0, '2026-03-04 07:13:44'),
(246, 1, 'PS4 kontroller 2', 'DualShock 4, fekete.', 8100, 'kivalo', 'Iskola bejárat', NULL, NULL, NULL, 4, 15, 48, 0, '2026-03-04 07:13:44'),
(247, 1, 'PS4 kontroller 3', 'DualShock 4, fekete.', 8200, 'uj', 'Iskola bejárat', NULL, NULL, NULL, 4, 15, 48, 0, '2026-03-04 07:13:44'),
(248, 1, 'PS4 kontroller 4', 'DualShock 4, fekete.', 8300, 'jo', 'Iskola bejárat', NULL, NULL, NULL, 4, 15, 48, 0, '2026-03-04 07:13:44'),
(249, 1, 'PS4 kontroller 5', 'DualShock 4, fekete.', 8400, 'kielegito', 'Iskola bejárat', NULL, NULL, NULL, 4, 15, 48, 0, '2026-03-04 07:13:44'),
(250, 1, 'JBL hangszóró', 'JBL Flip 5, vízálló.', 15000, 'jo', 'Iskola bejárat', NULL, NULL, NULL, 4, 16, 49, 0, '2026-03-04 07:13:44'),
(251, 1, 'JBL hangszóró 2', 'JBL Flip 5, vízálló.', 15100, 'kivalo', 'Iskola bejárat', NULL, NULL, NULL, 4, 16, 49, 0, '2026-03-04 07:13:44'),
(252, 1, 'JBL hangszóró 3', 'JBL Flip 5, vízálló.', 15200, 'uj', 'Iskola bejárat', NULL, NULL, NULL, 4, 16, 49, 0, '2026-03-04 07:13:44'),
(253, 1, 'JBL hangszóró 4', 'JBL Flip 5, vízálló.', 15300, 'jo', 'Iskola bejárat', NULL, NULL, NULL, 4, 16, 49, 0, '2026-03-04 07:13:44'),
(254, 1, 'JBL hangszóró 5', 'JBL Flip 5, vízálló.', 15400, 'kielegito', 'Iskola bejárat', NULL, NULL, NULL, 4, 16, 49, 0, '2026-03-04 07:13:44'),
(255, 1, 'HDMI kábel', '2m HDMI 2.0 kábel.', 1200, 'uj', 'Iskola bejárat', NULL, NULL, NULL, 4, 16, 50, 0, '2026-03-04 07:13:44'),
(256, 1, 'HDMI kábel 2', '2m HDMI 2.0 kábel.', 1300, 'kivalo', 'Iskola bejárat', NULL, NULL, NULL, 4, 16, 50, 0, '2026-03-04 07:13:44'),
(257, 1, 'HDMI kábel 3', '2m HDMI 2.0 kábel.', 1400, 'jo', 'Iskola bejárat', NULL, NULL, NULL, 4, 16, 50, 0, '2026-03-04 07:13:44'),
(258, 1, 'HDMI kábel 4', '2m HDMI 2.0 kábel.', 1500, 'uj', 'Iskola bejárat', NULL, NULL, NULL, 4, 16, 50, 0, '2026-03-04 07:13:44'),
(259, 1, 'HDMI kábel 5', '2m HDMI 2.0 kábel.', 1600, 'kivalo', 'Iskola bejárat', NULL, NULL, NULL, 4, 16, 50, 0, '2026-03-04 07:13:44'),
(260, 1, 'Monopoly', 'Monopoly társasjáték.', 3000, 'jo', 'Iskola bejárat', NULL, NULL, NULL, 5, 17, 51, 0, '2026-03-04 07:13:44'),
(261, 1, 'Monopoly 2', 'Monopoly társasjáték.', 3100, 'kivalo', 'Iskola bejárat', NULL, NULL, NULL, 5, 17, 51, 0, '2026-03-04 07:13:44'),
(262, 1, 'Monopoly 3', 'Monopoly társasjáték.', 3200, 'uj', 'Iskola bejárat', NULL, NULL, NULL, 5, 17, 51, 0, '2026-03-04 07:13:44'),
(263, 1, 'Monopoly 4', 'Monopoly társasjáték.', 3300, 'jo', 'Iskola bejárat', NULL, NULL, NULL, 5, 17, 51, 0, '2026-03-04 07:13:44'),
(264, 1, 'Monopoly 5', 'Monopoly társasjáték.', 3400, 'kielegito', 'Iskola bejárat', NULL, NULL, NULL, 5, 17, 51, 0, '2026-03-04 07:13:44'),
(265, 1, 'UNO kártya', 'UNO kártyajáték.', 800, 'jo', 'Iskola bejárat', NULL, NULL, NULL, 5, 17, 52, 0, '2026-03-04 07:13:44'),
(266, 1, 'UNO kártya 2', 'UNO kártyajáték.', 900, 'kivalo', 'Iskola bejárat', NULL, NULL, NULL, 5, 17, 52, 0, '2026-03-04 07:13:44'),
(267, 1, 'UNO kártya 3', 'UNO kártyajáték.', 1000, 'uj', 'Iskola bejárat', NULL, NULL, NULL, 5, 17, 52, 0, '2026-03-04 07:13:44'),
(268, 1, 'UNO kártya 4', 'UNO kártyajáték.', 1100, 'jo', 'Iskola bejárat', NULL, NULL, NULL, 5, 17, 52, 0, '2026-03-04 07:13:44'),
(269, 1, 'UNO kártya 5', 'UNO kártyajáték.', 1200, 'kielegito', 'Iskola bejárat', NULL, NULL, NULL, 5, 17, 52, 0, '2026-03-04 07:13:44'),
(270, 1, '1000 db puzzle', 'Táj puzzle, 1000 db.', 2000, 'jo', 'Iskola bejárat', NULL, NULL, NULL, 5, 17, 53, 0, '2026-03-04 07:13:44'),
(271, 1, '1000 db puzzle 2', 'Táj puzzle, 1000 db.', 2100, 'kivalo', 'Iskola bejárat', NULL, NULL, NULL, 5, 17, 53, 0, '2026-03-04 07:13:44'),
(272, 1, '1000 db puzzle 3', 'Táj puzzle, 1000 db.', 2200, 'uj', 'Iskola bejárat', NULL, NULL, NULL, 5, 17, 53, 0, '2026-03-04 07:13:44'),
(273, 1, '1000 db puzzle 4', 'Táj puzzle, 1000 db.', 2300, 'jo', 'Iskola bejárat', NULL, NULL, NULL, 5, 17, 53, 0, '2026-03-04 07:13:44'),
(274, 1, '1000 db puzzle 5', 'Táj puzzle, 1000 db.', 2400, 'kielegito', 'Iskola bejárat', NULL, NULL, NULL, 5, 17, 53, 0, '2026-03-04 07:13:44'),
(275, 1, 'Focilabda', 'Nike focilabda, 5-ös.', 4000, 'jo', 'Tornaterem', NULL, NULL, NULL, 5, 18, 54, 0, '2026-03-04 07:13:44'),
(276, 1, 'Focilabda 2', 'Nike focilabda, 5-ös.', 4100, 'kivalo', 'Tornaterem', NULL, NULL, NULL, 5, 18, 54, 0, '2026-03-04 07:13:44'),
(277, 1, 'Focilabda 3', 'Nike focilabda, 5-ös.', 4200, 'uj', 'Tornaterem', NULL, NULL, NULL, 5, 18, 54, 0, '2026-03-04 07:13:44'),
(278, 1, 'Focilabda 4', 'Nike focilabda, 5-ös.', 4300, 'jo', 'Tornaterem', NULL, NULL, NULL, 5, 18, 54, 0, '2026-03-04 07:13:44'),
(279, 1, 'Focilabda 5', 'Nike focilabda, 5-ös.', 4400, 'kielegito', 'Tornaterem', NULL, NULL, NULL, 5, 18, 54, 0, '2026-03-04 07:13:44'),
(280, 1, 'Tollaslabda ütő', 'Babolat ütő pár.', 3000, 'jo', 'Tornaterem', NULL, NULL, NULL, 5, 18, 55, 0, '2026-03-04 07:13:44'),
(281, 1, 'Tollaslabda ütő 2', 'Babolat ütő pár.', 3100, 'kivalo', 'Tornaterem', NULL, NULL, NULL, 5, 18, 55, 0, '2026-03-04 07:13:44'),
(282, 1, 'Tollaslabda ütő 3', 'Babolat ütő pár.', 3200, 'uj', 'Tornaterem', NULL, NULL, NULL, 5, 18, 55, 0, '2026-03-04 07:13:44'),
(283, 1, 'Tollaslabda ütő 4', 'Babolat ütő pár.', 3300, 'jo', 'Tornaterem', NULL, NULL, NULL, 5, 18, 55, 0, '2026-03-04 07:13:44'),
(284, 1, 'Tollaslabda ütő 5', 'Babolat ütő pár.', 3400, 'kielegito', 'Tornaterem', NULL, NULL, NULL, 5, 18, 55, 0, '2026-03-04 07:13:44'),
(285, 1, 'Térdvédő', 'Nike térdvédő pár.', 2000, 'jo', 'Tornaterem', NULL, NULL, NULL, 5, 18, 56, 0, '2026-03-04 07:13:44'),
(286, 1, 'Térdvédő 2', 'Nike térdvédő pár.', 2100, 'kivalo', 'Tornaterem', NULL, NULL, NULL, 5, 18, 56, 0, '2026-03-04 07:13:44'),
(287, 1, 'Térdvédő 3', 'Nike térdvédő pár.', 2200, 'uj', 'Tornaterem', NULL, NULL, NULL, 5, 18, 56, 0, '2026-03-04 07:13:44'),
(288, 1, 'Térdvédő 4', 'Nike térdvédő pár.', 2300, 'jo', 'Tornaterem', NULL, NULL, NULL, 5, 18, 56, 0, '2026-03-04 07:13:44'),
(289, 1, 'Térdvédő 5', 'Nike térdvédő pár.', 2400, 'kielegito', 'Tornaterem', NULL, NULL, NULL, 5, 18, 56, 0, '2026-03-04 07:13:44'),
(290, 1, 'Gitár', 'Akusztikus gitár, kezdőknek.', 15000, 'jo', 'Iskola bejárat', NULL, NULL, NULL, 5, 19, 57, 0, '2026-03-04 07:13:44'),
(291, 1, 'Gitár 2', 'Akusztikus gitár, kezdőknek.', 15100, 'kivalo', 'Iskola bejárat', NULL, NULL, NULL, 5, 19, 57, 0, '2026-03-04 07:13:44'),
(292, 1, 'Gitár 3', 'Akusztikus gitár, kezdőknek.', 15200, 'uj', 'Iskola bejárat', NULL, NULL, NULL, 5, 19, 57, 0, '2026-03-04 07:13:44'),
(293, 1, 'Gitár 4', 'Akusztikus gitár, kezdőknek.', 15300, 'jo', 'Iskola bejárat', NULL, NULL, NULL, 5, 19, 57, 0, '2026-03-04 07:13:44'),
(294, 1, 'Gitár 5', 'Akusztikus gitár, kezdőknek.', 15400, 'kielegito', 'Iskola bejárat', NULL, NULL, NULL, 5, 19, 57, 0, '2026-03-04 07:13:44'),
(295, 1, 'Zongorakotta', 'Beethoven szonáták kotta.', 1000, 'jo', 'Könyvtár', NULL, NULL, NULL, 5, 19, 58, 0, '2026-03-04 07:13:44'),
(296, 1, 'Zongorakotta 2', 'Beethoven szonáták kotta.', 1100, 'kivalo', 'Könyvtár', NULL, NULL, NULL, 5, 19, 58, 0, '2026-03-04 07:13:44'),
(297, 1, 'Zongorakotta 3', 'Beethoven szonáták kotta.', 1200, 'jo', 'Könyvtár', NULL, NULL, NULL, 5, 19, 58, 0, '2026-03-04 07:13:44'),
(298, 1, 'Zongorakotta 4', 'Beethoven szonáták kotta.', 1300, 'kivalo', 'Könyvtár', NULL, NULL, NULL, 5, 19, 58, 0, '2026-03-04 07:13:44'),
(299, 1, 'Zongorakotta 5', 'Beethoven szonáták kotta.', 1400, 'kielegito', 'Könyvtár', NULL, NULL, NULL, 5, 19, 58, 0, '2026-03-04 07:13:44'),
(300, 1, 'Harry Potter', 'HP és a bölcsek köve.', 1500, 'jo', 'Könyvtár', NULL, NULL, NULL, 5, 20, 59, 0, '2026-03-04 07:13:44'),
(301, 1, 'Harry Potter 2', 'HP és a bölcsek köve.', 1600, 'kivalo', 'Könyvtár', NULL, NULL, NULL, 5, 20, 59, 0, '2026-03-04 07:13:44'),
(302, 1, 'Harry Potter 3', 'HP és a bölcsek köve.', 1700, 'uj', 'Könyvtár', NULL, NULL, NULL, 5, 20, 59, 0, '2026-03-04 07:13:44'),
(303, 1, 'Harry Potter 4', 'HP és a bölcsek köve.', 1800, 'jo', 'Könyvtár', NULL, NULL, NULL, 5, 20, 59, 0, '2026-03-04 07:13:44'),
(304, 1, 'Harry Potter 5', 'HP és a bölcsek köve.', 1900, 'kielegito', 'Könyvtár', NULL, NULL, NULL, 5, 20, 59, 0, '2026-03-04 07:13:44'),
(305, 1, 'Marvel képregény', 'Spider-Man képregény.', 800, 'jo', 'Iskola bejárat', NULL, NULL, NULL, 5, 20, 60, 0, '2026-03-04 07:13:44'),
(306, 1, 'Marvel képregény 2', 'Spider-Man képregény.', 900, 'kivalo', 'Iskola bejárat', NULL, NULL, NULL, 5, 20, 60, 0, '2026-03-04 07:13:44'),
(307, 1, 'Marvel képregény 3', 'Spider-Man képregény.', 1000, 'uj', 'Iskola bejárat', NULL, NULL, NULL, 5, 20, 60, 0, '2026-03-04 07:13:44'),
(308, 1, 'Marvel képregény 4', 'Spider-Man képregény.', 1100, 'jo', 'Iskola bejárat', NULL, NULL, NULL, 5, 20, 60, 0, '2026-03-04 07:13:44'),
(309, 1, 'Marvel képregény 5', 'Spider-Man képregény.', 1200, 'kielegito', 'Iskola bejárat', NULL, NULL, NULL, 5, 20, 60, 0, '2026-03-04 07:13:44'),
(310, 1, 'National Geographic', 'NG magazin, 2024.', 500, 'jo', 'Iskola bejárat', NULL, NULL, NULL, 5, 20, 61, 0, '2026-03-04 07:13:44'),
(311, 1, 'National Geographic 2', 'NG magazin, 2024.', 600, 'kivalo', 'Iskola bejárat', NULL, NULL, NULL, 5, 20, 61, 0, '2026-03-04 07:13:44'),
(312, 1, 'National Geographic 3', 'NG magazin, 2024.', 700, 'uj', 'Iskola bejárat', NULL, NULL, NULL, 5, 20, 61, 0, '2026-03-04 07:13:44'),
(313, 1, 'National Geographic 4', 'NG magazin, 2024.', 800, 'jo', 'Iskola bejárat', NULL, NULL, NULL, 5, 20, 61, 0, '2026-03-04 07:13:44'),
(314, 1, 'National Geographic 5', 'NG magazin, 2024.', 900, 'kielegito', 'Iskola bejárat', NULL, NULL, NULL, 5, 20, 61, 0, '2026-03-04 07:13:44'),
(315, 1, 'Anime poszter', 'A3-as anime poszter.', 500, 'uj', 'Iskola bejárat', NULL, NULL, NULL, 6, 21, 62, 0, '2026-03-04 07:13:44'),
(316, 1, 'Anime poszter 2', 'A3-as anime poszter.', 600, 'kivalo', 'Iskola bejárat', NULL, NULL, NULL, 6, 21, 62, 0, '2026-03-04 07:13:44'),
(317, 1, 'Anime poszter 3', 'A3-as anime poszter.', 700, 'jo', 'Iskola bejárat', NULL, NULL, NULL, 6, 21, 62, 0, '2026-03-04 07:13:44'),
(318, 1, 'Anime poszter 4', 'A3-as anime poszter.', 800, 'uj', 'Iskola bejárat', NULL, NULL, NULL, 6, 21, 62, 0, '2026-03-04 07:13:44'),
(319, 1, 'Anime poszter 5', 'A3-as anime poszter.', 900, 'kivalo', 'Iskola bejárat', NULL, NULL, NULL, 6, 21, 62, 0, '2026-03-04 07:13:44'),
(320, 1, 'LED lámpa', 'RGB LED szalag, 5m.', 2000, 'uj', 'Iskola bejárat', NULL, NULL, NULL, 6, 21, 63, 0, '2026-03-04 07:13:44'),
(321, 1, 'LED lámpa 2', 'RGB LED szalag, 5m.', 2100, 'kivalo', 'Iskola bejárat', NULL, NULL, NULL, 6, 21, 63, 0, '2026-03-04 07:13:44'),
(322, 1, 'LED lámpa 3', 'RGB LED szalag, 5m.', 2200, 'jo', 'Iskola bejárat', NULL, NULL, NULL, 6, 21, 63, 0, '2026-03-04 07:13:44'),
(323, 1, 'LED lámpa 4', 'RGB LED szalag, 5m.', 2300, 'uj', 'Iskola bejárat', NULL, NULL, NULL, 6, 21, 63, 0, '2026-03-04 07:13:44'),
(324, 1, 'LED lámpa 5', 'RGB LED szalag, 5m.', 2400, 'kivalo', 'Iskola bejárat', NULL, NULL, NULL, 6, 21, 63, 0, '2026-03-04 07:13:44'),
(325, 1, 'Dekoráció', 'Fa betűk névtáblának.', 800, 'uj', 'Iskola bejárat', NULL, NULL, NULL, 6, 21, 64, 0, '2026-03-04 07:13:44'),
(326, 1, 'Dekoráció 2', 'Fa betűk névtáblának.', 900, 'kivalo', 'Iskola bejárat', NULL, NULL, NULL, 6, 21, 64, 0, '2026-03-04 07:13:44'),
(327, 1, 'Dekoráció 3', 'Fa betűk névtáblának.', 1000, 'jo', 'Iskola bejárat', NULL, NULL, NULL, 6, 21, 64, 0, '2026-03-04 07:13:44'),
(328, 1, 'Dekoráció 4', 'Fa betűk névtáblának.', 1100, 'uj', 'Iskola bejárat', NULL, NULL, NULL, 6, 21, 64, 0, '2026-03-04 07:13:44'),
(329, 1, 'Dekoráció 5', 'Fa betűk névtáblának.', 1200, 'kivalo', 'Iskola bejárat', NULL, NULL, NULL, 6, 21, 64, 0, '2026-03-04 07:13:44'),
(330, 1, 'Házi sütemény', 'Házi csokis keksz, 20db.', 500, 'uj', 'Iskola büfé', NULL, NULL, NULL, 6, 22, 65, 0, '2026-03-04 07:13:44'),
(331, 1, 'Házi sütemény 2', 'Házi csokis keksz, 20db.', 600, 'uj', 'Iskola büfé', NULL, NULL, NULL, 6, 22, 65, 0, '2026-03-04 07:13:44'),
(332, 1, 'Házi sütemény 3', 'Házi csokis keksz, 20db.', 700, 'uj', 'Iskola büfé', NULL, NULL, NULL, 6, 22, 65, 0, '2026-03-04 07:13:44'),
(333, 1, 'Házi sütemény 4', 'Házi csokis keksz, 20db.', 800, 'uj', 'Iskola büfé', NULL, NULL, NULL, 6, 22, 65, 0, '2026-03-04 07:13:44'),
(334, 1, 'Házi sütemény 5', 'Házi csokis keksz, 20db.', 900, 'uj', 'Iskola büfé', NULL, NULL, NULL, 6, 22, 65, 0, '2026-03-04 07:13:44'),
(335, 1, 'Fotózás', 'Portré fotózás az iskolában.', 3000, 'uj', 'Iskola udvar', NULL, NULL, NULL, 6, 23, 67, 0, '2026-03-04 07:13:44'),
(336, 1, 'Fotózás 2', 'Portré fotózás az iskolában.', 3100, 'uj', 'Iskola udvar', NULL, NULL, NULL, 6, 23, 67, 0, '2026-03-04 07:13:44'),
(337, 1, 'Fotózás 3', 'Portré fotózás az iskolában.', 3200, 'uj', 'Iskola udvar', NULL, NULL, NULL, 6, 23, 67, 0, '2026-03-04 07:13:44'),
(338, 1, 'Fotózás 4', 'Portré fotózás az iskolában.', 3300, 'uj', 'Iskola udvar', NULL, NULL, NULL, 6, 23, 67, 0, '2026-03-04 07:13:44'),
(339, 1, 'Fotózás 5', 'Portré fotózás az iskolában.', 3400, 'uj', 'Iskola udvar', NULL, NULL, NULL, 6, 23, 67, 0, '2026-03-04 07:13:44'),
(340, 1, 'Egyéb termék', 'Vegyes holmi.', 500, 'jo', 'Iskola bejárat', NULL, NULL, NULL, 6, 24, 68, 0, '2026-03-04 07:13:44'),
(341, 1, 'Egyéb termék 2', 'Vegyes holmi.', 600, 'kivalo', 'Iskola bejárat', NULL, NULL, NULL, 6, 24, 68, 0, '2026-03-04 07:13:44'),
(342, 1, 'Egyéb termék 3', 'Vegyes holmi.', 700, 'jo', 'Iskola bejárat', NULL, NULL, NULL, 6, 24, 68, 0, '2026-03-04 07:13:44'),
(343, 1, 'Egyéb termék 4', 'Vegyes holmi.', 800, 'kivalo', 'Iskola bejárat', NULL, NULL, NULL, 6, 24, 68, 0, '2026-03-04 07:13:44'),
(344, 1, 'Egyéb termék 5', 'Vegyes holmi.', 900, 'kielegito', 'Iskola bejárat', NULL, NULL, NULL, 6, 24, 68, 0, '2026-03-04 07:13:44');

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `productimg`
--

CREATE TABLE `productimg` (
  `img_id` int(10) UNSIGNED NOT NULL,
  `product_id` int(10) UNSIGNED NOT NULL,
  `product_img` varchar(500) NOT NULL COMMENT 'Cloudinary URL'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `ratings`
--

CREATE TABLE `ratings` (
  `rating_id` int(10) UNSIGNED NOT NULL,
  `rater_id` int(10) UNSIGNED NOT NULL COMMENT 'Értékelő',
  `rated_id` int(10) UNSIGNED NOT NULL COMMENT 'Értékelt',
  `rate` tinyint(3) UNSIGNED NOT NULL COMMENT '1-5',
  `text` varchar(500) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- A tábla adatainak kiíratása `ratings`
--

INSERT INTO `ratings` (`rating_id`, `rater_id`, `rated_id`, `rate`, `text`, `created_at`) VALUES
(13, 1, 2, 2, 'dasd', '2026-03-04 08:28:20'),
(14, 1, 2, 4, 'ad', '2026-03-04 09:31:19'),
(15, 1, 2, 1, 'adasdas', '2026-03-04 09:31:19'),
(16, 2, 1, 3, 'dadas', '2026-03-04 09:31:40'),
(17, 2, 1, 5, 'dadas', '2026-03-04 09:31:58'),
(18, 2, 1, 3, 'dadas', '2026-03-04 09:31:58');

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `reports`
--

CREATE TABLE `reports` (
  `report_id` int(10) UNSIGNED NOT NULL,
  `reporter_id` int(10) UNSIGNED NOT NULL,
  `reported_id` int(10) UNSIGNED DEFAULT NULL COMMENT 'Jelentett user (opcionális)',
  `product_id` int(10) UNSIGNED DEFAULT NULL COMMENT 'Jelentett termék (opcionális)',
  `text` text NOT NULL,
  `sending_date` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `subsubcategory`
--

CREATE TABLE `subsubcategory` (
  `sub_sub_category_id` int(10) UNSIGNED NOT NULL,
  `sub_category_id` int(10) UNSIGNED NOT NULL,
  `sub_sub_name` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- A tábla adatainak kiíratása `subsubcategory`
--

INSERT INTO `subsubcategory` (`sub_sub_category_id`, `sub_category_id`, `sub_sub_name`) VALUES
(1, 1, 'Pólók'),
(2, 1, 'Pulcsik'),
(3, 1, 'Farmer'),
(4, 1, 'Kabátok'),
(5, 2, 'Sportcipők'),
(6, 2, 'Bakancsok'),
(7, 2, 'Tornacipők'),
(8, 3, 'Sapkák'),
(9, 3, 'Táskák'),
(10, 3, 'Övek'),
(11, 3, 'Ékszerek'),
(12, 4, 'Szalagavatóra'),
(13, 4, 'Ballagásra'),
(14, 4, 'Bulikra'),
(15, 5, 'Pólók'),
(16, 5, 'Pulcsik'),
(17, 5, 'Farmer'),
(18, 5, 'Kabátok'),
(19, 6, 'Sportcipők'),
(20, 6, 'Bakancsok'),
(21, 6, 'Tornacipők'),
(22, 7, 'Sapkák'),
(23, 7, 'Táskák'),
(24, 7, 'Övek'),
(25, 8, 'Ballagásra'),
(26, 8, 'Bulikra'),
(27, 9, 'Tankönyvek'),
(28, 9, 'Munkafüzetek'),
(29, 9, 'Saját jegyzetek'),
(30, 10, 'Tollak'),
(31, 10, 'Ceruzák'),
(32, 10, 'Markerek'),
(33, 11, 'Hátizsákok'),
(34, 11, 'Oldaltáskák'),
(35, 11, 'Tolltartók'),
(36, 12, 'Vonalzók'),
(37, 12, 'Körzők'),
(38, 12, 'Számológépek'),
(39, 13, 'Laptopok'),
(40, 13, 'Egerek'),
(41, 13, 'Billentyűzetek'),
(42, 13, 'Fejhallgatók'),
(43, 14, 'Okostelefonok'),
(44, 14, 'Tokok'),
(45, 14, 'Töltők'),
(46, 15, 'Konzolok'),
(47, 15, 'Játékok'),
(48, 15, 'Kontrollerek'),
(49, 16, 'Hangszórók'),
(50, 16, 'Kábelek'),
(51, 17, 'Társasjátékok'),
(52, 17, 'Kártyajátékok'),
(53, 17, 'Puzzle'),
(54, 18, 'Labdák'),
(55, 18, 'Ütők'),
(56, 18, 'Védőfelszerelés'),
(57, 19, 'Hangszerek'),
(58, 19, 'Kották'),
(59, 20, 'Regények'),
(60, 20, 'Képregények'),
(61, 20, 'Magazinok'),
(62, 21, 'Poszterek'),
(63, 21, 'Lámpák'),
(64, 21, 'Dekorációk'),
(65, 22, 'Házi készítésű finomságok'),
(66, 23, 'Korrepetálás'),
(67, 23, 'Fotózás'),
(68, 24, 'Egyéb');

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `sub_category`
--

CREATE TABLE `sub_category` (
  `sub_category_id` int(10) UNSIGNED NOT NULL,
  `category_id` int(10) UNSIGNED NOT NULL,
  `sub_category_name` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- A tábla adatainak kiíratása `sub_category`
--

INSERT INTO `sub_category` (`sub_category_id`, `category_id`, `sub_category_name`) VALUES
(1, 1, 'Alap ruhadarabok'),
(2, 1, 'Cipők'),
(3, 1, 'Kiegészítők'),
(4, 1, 'Alkalmi ruhák'),
(5, 2, 'Alap ruhadarabok'),
(6, 2, 'Cipők'),
(7, 2, 'Kiegészítők'),
(8, 2, 'Alkalmi ruhák'),
(9, 3, 'Könyvek & jegyzetek'),
(10, 3, 'Írószerek'),
(11, 3, 'Táskák & tolltartók'),
(12, 3, 'Egyéb'),
(13, 4, 'Számítástechnika'),
(14, 4, 'Telefonok'),
(15, 4, 'Játék'),
(16, 4, 'Egyéb'),
(17, 5, 'Játékok'),
(18, 5, 'Sport'),
(19, 5, 'Zene'),
(20, 5, 'Könyvek'),
(21, 6, 'Lakberendezés'),
(22, 6, 'Élelmiszer'),
(23, 6, 'Szolgáltatások'),
(24, 6, 'Minden más');

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `users`
--

CREATE TABLE `users` (
  `user_id` int(10) UNSIGNED NOT NULL,
  `pfp` varchar(500) DEFAULT NULL COMMENT 'Profilkép URL (Cloudinary)',
  `email` varchar(255) NOT NULL,
  `psw` varchar(255) NOT NULL,
  `fullname` varchar(255) NOT NULL,
  `userClass` varchar(50) NOT NULL,
  `role` enum('admin','regisztralt') NOT NULL DEFAULT 'regisztralt',
  `verified` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- A tábla adatainak kiíratása `users`
--

INSERT INTO `users` (`user_id`, `pfp`, `email`, `psw`, `fullname`, `userClass`, `role`, `verified`, `created_at`) VALUES
(1, NULL, 'teszt@dszcbaross.edu.hu', '$2b$10$teszt123hashedpwd', 'Teszt Felhasználó', '12/A', 'regisztralt', 1, '2026-03-04 07:07:25'),
(2, NULL, '123@dszcbaross.edu.hu', '$2b$10$X5LOKZEq3P9x8c87LbPGRu2rFUDhrSmis4xbQgZXxpLbsNCdUQBa2', 'Jani', '0', 'regisztralt', 0, '2026-03-04 07:24:57');

--
-- Indexek a kiírt táblákhoz
--

--
-- A tábla indexei `adds`
--
ALTER TABLE `adds`
  ADD PRIMARY KEY (`add_id`),
  ADD KEY `fk_adds_user` (`user_id`);

--
-- A tábla indexei `conversations`
--
ALTER TABLE `conversations`
  ADD PRIMARY KEY (`conversations_id`),
  ADD KEY `fk_conv_user1` (`user1_id`),
  ADD KEY `fk_conv_user2` (`user2_id`);

--
-- A tábla indexei `likes`
--
ALTER TABLE `likes`
  ADD PRIMARY KEY (`user_id`,`product_id`),
  ADD KEY `fk_likes_product` (`product_id`);

--
-- A tábla indexei `main_categories`
--
ALTER TABLE `main_categories`
  ADD PRIMARY KEY (`category_id`);

--
-- A tábla indexei `messages`
--
ALTER TABLE `messages`
  ADD PRIMARY KEY (`message_id`),
  ADD KEY `fk_msg_conversation` (`conversations_id`),
  ADD KEY `fk_msg_sender` (`sender_id`);

--
-- A tábla indexei `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`order_id`),
  ADD KEY `fk_orders_buyer` (`buyer_id`),
  ADD KEY `fk_orders_seller` (`seller_id`),
  ADD KEY `fk_orders_product` (`product_id`);

--
-- A tábla indexei `product`
--
ALTER TABLE `product`
  ADD PRIMARY KEY (`product_id`),
  ADD KEY `fk_product_user` (`user_id`),
  ADD KEY `fk_product_category` (`category_id`),
  ADD KEY `fk_product_sub` (`sub_category_id`),
  ADD KEY `fk_product_subsub` (`sub_sub_category_id`);

--
-- A tábla indexei `productimg`
--
ALTER TABLE `productimg`
  ADD PRIMARY KEY (`img_id`),
  ADD KEY `fk_productimg_product` (`product_id`);

--
-- A tábla indexei `ratings`
--
ALTER TABLE `ratings`
  ADD PRIMARY KEY (`rating_id`),
  ADD KEY `fk_ratings_rater` (`rater_id`),
  ADD KEY `fk_ratings_rated` (`rated_id`);

--
-- A tábla indexei `reports`
--
ALTER TABLE `reports`
  ADD PRIMARY KEY (`report_id`),
  ADD KEY `fk_reports_reporter` (`reporter_id`);

--
-- A tábla indexei `subsubcategory`
--
ALTER TABLE `subsubcategory`
  ADD PRIMARY KEY (`sub_sub_category_id`),
  ADD KEY `fk_subsubcategory_sub` (`sub_category_id`);

--
-- A tábla indexei `sub_category`
--
ALTER TABLE `sub_category`
  ADD PRIMARY KEY (`sub_category_id`),
  ADD KEY `fk_sub_category_category` (`category_id`);

--
-- A tábla indexei `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- A kiírt táblák AUTO_INCREMENT értéke
--

--
-- AUTO_INCREMENT a táblához `adds`
--
ALTER TABLE `adds`
  MODIFY `add_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT a táblához `conversations`
--
ALTER TABLE `conversations`
  MODIFY `conversations_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT a táblához `main_categories`
--
ALTER TABLE `main_categories`
  MODIFY `category_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT a táblához `messages`
--
ALTER TABLE `messages`
  MODIFY `message_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT a táblához `orders`
--
ALTER TABLE `orders`
  MODIFY `order_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT a táblához `product`
--
ALTER TABLE `product`
  MODIFY `product_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=345;

--
-- AUTO_INCREMENT a táblához `productimg`
--
ALTER TABLE `productimg`
  MODIFY `img_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT a táblához `ratings`
--
ALTER TABLE `ratings`
  MODIFY `rating_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT a táblához `reports`
--
ALTER TABLE `reports`
  MODIFY `report_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT a táblához `subsubcategory`
--
ALTER TABLE `subsubcategory`
  MODIFY `sub_sub_category_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=69;

--
-- AUTO_INCREMENT a táblához `sub_category`
--
ALTER TABLE `sub_category`
  MODIFY `sub_category_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT a táblához `users`
--
ALTER TABLE `users`
  MODIFY `user_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Megkötések a kiírt táblákhoz
--

--
-- Megkötések a táblához `adds`
--
ALTER TABLE `adds`
  ADD CONSTRAINT `fk_adds_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE;

--
-- Megkötések a táblához `conversations`
--
ALTER TABLE `conversations`
  ADD CONSTRAINT `fk_conv_user1` FOREIGN KEY (`user1_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_conv_user2` FOREIGN KEY (`user2_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE;

--
-- Megkötések a táblához `likes`
--
ALTER TABLE `likes`
  ADD CONSTRAINT `fk_likes_product` FOREIGN KEY (`product_id`) REFERENCES `product` (`product_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_likes_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE;

--
-- Megkötések a táblához `messages`
--
ALTER TABLE `messages`
  ADD CONSTRAINT `fk_msg_conversation` FOREIGN KEY (`conversations_id`) REFERENCES `conversations` (`conversations_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_msg_sender` FOREIGN KEY (`sender_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE;

--
-- Megkötések a táblához `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `fk_orders_buyer` FOREIGN KEY (`buyer_id`) REFERENCES `users` (`user_id`),
  ADD CONSTRAINT `fk_orders_product` FOREIGN KEY (`product_id`) REFERENCES `product` (`product_id`),
  ADD CONSTRAINT `fk_orders_seller` FOREIGN KEY (`seller_id`) REFERENCES `users` (`user_id`);

--
-- Megkötések a táblához `product`
--
ALTER TABLE `product`
  ADD CONSTRAINT `fk_product_category` FOREIGN KEY (`category_id`) REFERENCES `main_categories` (`category_id`),
  ADD CONSTRAINT `fk_product_sub` FOREIGN KEY (`sub_category_id`) REFERENCES `sub_category` (`sub_category_id`),
  ADD CONSTRAINT `fk_product_subsub` FOREIGN KEY (`sub_sub_category_id`) REFERENCES `subsubcategory` (`sub_sub_category_id`),
  ADD CONSTRAINT `fk_product_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE;

--
-- Megkötések a táblához `productimg`
--
ALTER TABLE `productimg`
  ADD CONSTRAINT `fk_productimg_product` FOREIGN KEY (`product_id`) REFERENCES `product` (`product_id`) ON DELETE CASCADE;

--
-- Megkötések a táblához `ratings`
--
ALTER TABLE `ratings`
  ADD CONSTRAINT `fk_ratings_rated` FOREIGN KEY (`rated_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_ratings_rater` FOREIGN KEY (`rater_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE;

--
-- Megkötések a táblához `reports`
--
ALTER TABLE `reports`
  ADD CONSTRAINT `fk_reports_reporter` FOREIGN KEY (`reporter_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE;

--
-- Megkötések a táblához `subsubcategory`
--
ALTER TABLE `subsubcategory`
  ADD CONSTRAINT `fk_subsubcategory_sub` FOREIGN KEY (`sub_category_id`) REFERENCES `sub_category` (`sub_category_id`) ON DELETE CASCADE;

--
-- Megkötések a táblához `sub_category`
--
ALTER TABLE `sub_category`
  ADD CONSTRAINT `fk_sub_category_category` FOREIGN KEY (`category_id`) REFERENCES `main_categories` (`category_id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
