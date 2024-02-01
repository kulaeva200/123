-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Хост: 127.0.0.1:3307
-- Время создания: Янв 25 2024 г., 07:17
-- Версия сервера: 8.0.30
-- Версия PHP: 7.2.34

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- База данных: `accounting`
--

-- --------------------------------------------------------

--
-- Структура таблицы `Faculties`
--

CREATE TABLE `Faculties` (
  `id_faculty` int NOT NULL,
  `name_faculty` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `Groups`
--

CREATE TABLE `Groups` (
  `id_group` int NOT NULL,
  `name_group` varchar(255) NOT NULL,
  `id_faculty` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `Oplaty`
--

CREATE TABLE `Oplaty` (
  `id_oplaty` int NOT NULL,
  `summa` decimal(10,0) DEFAULT NULL,
  `god_oplaty` date DEFAULT NULL,
  `status_oplaty` text,
  `id_perioda` int DEFAULT NULL,
  `Nbileta` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `Periods`
--

CREATE TABLE `Periods` (
  `id_perioda` int NOT NULL,
  `nazvanie_period` text,
  `nachalo_per` date DEFAULT NULL,
  `konec_per` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `Putevki`
--

CREATE TABLE `Putevki` (
  `id_putevki` int NOT NULL,
  `Nbileta` int NOT NULL,
  `Nzaezda` int DEFAULT NULL,
  `god` date DEFAULT NULL,
  `nachalo_zaezda` date DEFAULT NULL,
  `konec_zaezda` date DEFAULT NULL,
  `status_oplaty` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `student`
--

CREATE TABLE `student` (
  `id_student` int NOT NULL,
  `fio` varchar(255) NOT NULL,
  `date_birth` date NOT NULL,
  `obrazovanie` varchar(255) NOT NULL,
  `adres` varchar(255) NOT NULL,
  `telephone` int NOT NULL,
  `Nbileta` int NOT NULL,
  `id_group` int NOT NULL,
  `other_info` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `Tickets`
--

CREATE TABLE `Tickets` (
  `Nbileta` int NOT NULL,
  `data_vstypleniya` date DEFAULT NULL,
  `data_vihoda` date DEFAULT NULL,
  `id_oplaty` int DEFAULT NULL,
  `id_student` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Индексы сохранённых таблиц
--

--
-- Индексы таблицы `Faculties`
--
ALTER TABLE `Faculties`
  ADD PRIMARY KEY (`id_faculty`);

--
-- Индексы таблицы `Groups`
--
ALTER TABLE `Groups`
  ADD PRIMARY KEY (`id_group`),
  ADD KEY `id_faculty` (`id_faculty`);

--
-- Индексы таблицы `Oplaty`
--
ALTER TABLE `Oplaty`
  ADD PRIMARY KEY (`id_oplaty`),
  ADD KEY `id_perioda` (`id_perioda`);

--
-- Индексы таблицы `Periods`
--
ALTER TABLE `Periods`
  ADD PRIMARY KEY (`id_perioda`);

--
-- Индексы таблицы `Putevki`
--
ALTER TABLE `Putevki`
  ADD PRIMARY KEY (`id_putevki`),
  ADD KEY `Nbileta` (`Nbileta`);

--
-- Индексы таблицы `student`
--
ALTER TABLE `student`
  ADD PRIMARY KEY (`id_student`),
  ADD KEY `Nbileta` (`Nbileta`),
  ADD KEY `id_group` (`id_group`);

--
-- Индексы таблицы `Tickets`
--
ALTER TABLE `Tickets`
  ADD PRIMARY KEY (`Nbileta`);

--
-- Ограничения внешнего ключа сохраненных таблиц
--

--
-- Ограничения внешнего ключа таблицы `Groups`
--
ALTER TABLE `Groups`
  ADD CONSTRAINT `groups_ibfk_1` FOREIGN KEY (`id_faculty`) REFERENCES `Faculties` (`id_faculty`) ON DELETE RESTRICT ON UPDATE RESTRICT;

--
-- Ограничения внешнего ключа таблицы `Oplaty`
--
ALTER TABLE `Oplaty`
  ADD CONSTRAINT `oplaty_ibfk_1` FOREIGN KEY (`id_perioda`) REFERENCES `Periods` (`id_perioda`) ON DELETE RESTRICT ON UPDATE RESTRICT;

--
-- Ограничения внешнего ключа таблицы `Putevki`
--
ALTER TABLE `Putevki`
  ADD CONSTRAINT `putevki_ibfk_1` FOREIGN KEY (`Nbileta`) REFERENCES `Tickets` (`Nbileta`) ON DELETE RESTRICT ON UPDATE RESTRICT;

--
-- Ограничения внешнего ключа таблицы `student`
--
ALTER TABLE `student`
  ADD CONSTRAINT `student_ibfk_1` FOREIGN KEY (`Nbileta`) REFERENCES `Tickets` (`Nbileta`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `student_ibfk_2` FOREIGN KEY (`id_group`) REFERENCES `Groups` (`id_group`) ON DELETE RESTRICT ON UPDATE RESTRICT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
