-- phpMyAdmin SQL Dump
-- version 4.4.15.10
-- https://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Mar 23, 2020 at 11:08 PM
-- Server version: 5.5.64-MariaDB
-- PHP Version: 5.4.16

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `u435826_shop_tech`
--

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE IF NOT EXISTS `categories` (
  `id` int(11) NOT NULL,
  `title` varchar(100) NOT NULL,
  `name` varchar(50) NOT NULL,
  `img` varchar(100) NOT NULL
) ENGINE=MyISAM AUTO_INCREMENT=17 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`id`, `title`, `name`, `img`) VALUES
(12, '', 'Пылесосы для авто', 'Screenshot_7.jpg'),
(13, '', 'Флеш карты для iPhone/iPad', 'Screenshot_8.jpg'),
(11, '', 'Пылесосы для дома', 'Screenshot_6.jpg'),
(8, '', 'Увлажнители воздуха', 'Screenshot_4.jpg'),
(4, 'Для дома, для кафе', 'Миксеры и Блендер', 'ge-data-kitchenAid-blender-stacionar-5KSB1585ECL-1000x1000.jpg'),
(5, '', 'Автохолодильники', 'Alpicool-15L-dc.jpg'),
(7, '', 'Отпариватели', 'Оtparivatel_2-7.jpg'),
(9, '', 'Соковыжималки', 'Screenshot_5.jpg'),
(14, '', 'Зарядки для MacBook', 'Screenshot_9.jpg');

-- --------------------------------------------------------

--
-- Table structure for table `contacts`
--

CREATE TABLE IF NOT EXISTS `contacts` (
  `id` int(10) NOT NULL,
  `phone` varchar(50) NOT NULL,
  `email` varchar(50) NOT NULL,
  `city` varchar(50) NOT NULL,
  `street` varchar(50) NOT NULL,
  `house` varchar(10) NOT NULL,
  `whatsapp` varchar(100) NOT NULL,
  `telegram` varchar(100) NOT NULL,
  `vk` varchar(100) NOT NULL,
  `instagram` varchar(100) NOT NULL,
  `time1` varchar(100) NOT NULL,
  `time2` varchar(100) NOT NULL
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `contacts`
--

INSERT INTO `contacts` (`id`, `phone`, `email`, `city`, `street`, `house`, `whatsapp`, `telegram`, `vk`, `instagram`, `time1`, `time2`) VALUES
(1, '89776220480', 'thisisvegas@mail.ru', 'г.Москва', 'Северное Чертаново 1Ак1', '65', 'https://www.whatsapp.com/', 'https://tlgrm.ru/', 'https://vk.com/feed', 'https://www.instagram.com/', '07:00 - 23.00', '10.30 - 20.00');

-- --------------------------------------------------------

--
-- Table structure for table `feedbacks`
--

CREATE TABLE IF NOT EXISTS `feedbacks` (
  `id` int(11) NOT NULL,
  `id_prod` int(100) NOT NULL,
  `title` varchar(100) NOT NULL,
  `rating` int(1) NOT NULL DEFAULT '5',
  `user` varchar(50) NOT NULL,
  `email` varchar(50) NOT NULL,
  `allow` tinyint(1) NOT NULL,
  `text` text NOT NULL,
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `feedbacks`
--

INSERT INTO `feedbacks` (`id`, `id_prod`, `title`, `rating`, `user`, `email`, `allow`, `text`, `date`) VALUES
(1, 1, 'Apple как всегда на коне!', 5, 'Дмитрий', 'dim1034@yandex.ru', 0, 'Очень доволен покупкой, а в этом магазине и цена радует. Всем рекомендую!', '2019-12-18 19:17:05'),
(2, 2, 'Очень быстрая зарядка', 5, 'Василий', 'vasya1978@mail.ru', 0, 'До этого был другой зарядник, этот лучше', '2019-12-18 20:15:21');

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE IF NOT EXISTS `orders` (
  `id` int(200) NOT NULL,
  `name` varchar(50) NOT NULL,
  `email` varchar(50) NOT NULL,
  `address` varchar(100) NOT NULL,
  `phone` varchar(15) NOT NULL,
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `status` varchar(10) NOT NULL
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`id`, `name`, `email`, `address`, `phone`, `date`, `status`) VALUES
(1, 'Дмитрий Горкун', 'gorkundp@ya.ru', 'Санкт-Петербург, ул.Космонавтов, д.6', '89312108795', '2019-12-18 19:22:37', 'done'),
(2, 'Дмитрий Горкун', 'gorkundp@ya.ru', 'Новгород, Ленинградская 7', '89312107181', '2019-12-18 19:24:45', 'done'),
(3, 'Дмитрий Горкун', 'gorkundp@ya.ru', 'Москва', '8931287954', '2019-12-18 21:01:28', 'done'),
(4, 'Тест', 'test@ya.ru', 'Домой доставка', '+7924587458', '2020-02-03 12:45:52', 'done');

-- --------------------------------------------------------

--
-- Table structure for table `photos`
--

CREATE TABLE IF NOT EXISTS `photos` (
  `id` int(255) NOT NULL,
  `id_prod` int(100) NOT NULL,
  `src` varchar(150) NOT NULL,
  `alt` varchar(50) NOT NULL
) ENGINE=MyISAM AUTO_INCREMENT=36 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `photos`
--

INSERT INTO `photos` (`id`, `id_prod`, `src`, `alt`) VALUES
(35, 2, '79eeaa9078_cca1a-_prod_img_0-1000x1000.jpg', 'cca1a-_prod_img_0-1000x1000.jpg'),
(4, 2, '58d49ca4ae_4174302-t2b.jpg', '4174302-t2b.jpg'),
(5, 2, '719b6142d6_TJzU7zHlQeSR.jpg', 'TJzU7zHlQeSR.jpg'),
(6, 2, 'fe81f4f324_belaya.jpg', 'белая.jpg'),
(7, 3, '024c6c9ffe_Уvlajnitel_5-1.jpg', 'Увлажнитель 5-1.jpg'),
(8, 3, 'bbec7da70e_Уvlajnitel_5-2.jpg', 'Увлажнитель 5-2.jpg'),
(9, 3, 'e72ca52c3c_Уvlajnitel_5-3.jpg', 'Увлажнитель 5-3.jpg'),
(10, 5, '5d070f7209_Screenshot_6.jpg', 'Screenshot_6.jpg'),
(11, 4, 'a94680762b_Screenshot_10.jpg', 'Screenshot_10.jpg'),
(12, 6, '86332bbac8_2019-11-15_20-00-38.png', '2019-11-15_20-00-38.png'),
(13, 6, 'b14c25f547_2019-12-11_21-08-18.png', '2019-12-11_21-08-18.png'),
(14, 7, 'abf94a5a64_1.png', '1.png'),
(15, 8, 'c4810513c3_slider.png', 'slider.png'),
(16, 9, 'c9bc7604d0_2019-11-04_20-42-04.png', '2019-11-04_20-42-04.png'),
(17, 9, '24c04aa533_2019-11-06_13-36-36.png', '2019-11-06_13-36-36.png'),
(18, 10, 'f04d78ab46_2019-10-13_23-03-54.png', '2019-10-13_23-03-54.png'),
(19, 11, 'c4810513c3_slider.png', 'slider.png'),
(20, 12, '9dfe1d6e85_2019-09-08_22-31-22.png', '2019-09-08_22-31-22.png'),
(21, 13, '24c04aa533_2019-11-06_13-36-36.png', '2019-11-06_13-36-36.png'),
(22, 14, '118536e582_2019-10-19_19-32-42.png', '2019-10-19_19-32-42.png'),
(23, 15, 'c9bc7604d0_2019-11-04_20-42-04.png', '2019-11-04_20-42-04.png'),
(24, 16, 'c9bc7604d0_2019-11-04_20-42-04.png', '2019-11-04_20-42-04.png'),
(25, 17, 'c9bc7604d0_2019-11-04_20-42-04.png', '2019-11-04_20-42-04.png'),
(29, 23, 'c4810513c3_slider.png', 'slider.png'),
(28, 22, 'c4810513c3_slider.png', 'slider.png'),
(30, 24, '118536e582_2019-10-19_19-32-42.png', '2019-10-19_19-32-42.png'),
(31, 25, '5d070f7209_Screenshot_6.jpg', 'Screenshot_6.jpg'),
(32, 26, '5d070f7209_Screenshot_6.jpg', 'Screenshot_6.jpg'),
(33, 27, 'a001470e43_load.png', 'load.png'),
(34, 1, '79eeaa9078_cca1a-_prod_img_0-1000x1000.jpg', 'cca1a-_prod_img_0-1000x1000.jpg');

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE IF NOT EXISTS `products` (
  `id` int(10) NOT NULL,
  `title` varchar(50) NOT NULL,
  `detail` text NOT NULL,
  `features` text NOT NULL,
  `price_new` int(10) NOT NULL,
  `price_old` int(10) NOT NULL,
  `id_cat` int(11) NOT NULL
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`id`, `title`, `detail`, `features`, `price_new`, `price_old`, `id_cat`) VALUES
(2, 'Зарядка №1', 'Описание', 'Особенности', 4000, 5800, 14);

-- --------------------------------------------------------

--
-- Table structure for table `properties`
--

CREATE TABLE IF NOT EXISTS `properties` (
  `id` bigint(20) unsigned NOT NULL,
  `name` varchar(100) NOT NULL,
  `id_cat` int(10) unsigned NOT NULL,
  `unit` varchar(50) NOT NULL,
  `filter` tinyint(1) NOT NULL
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `properties`
--

INSERT INTO `properties` (`id`, `name`, `id_cat`, `unit`, `filter`) VALUES
(1, 'Мощность', 11, 'Вт', 1),
(2, 'Шум', 11, 'Дб', 1),
(3, 'Напряжение', 11, 'В', 0),
(4, 'Напряжение', 14, 'В', 1);

-- --------------------------------------------------------

--
-- Table structure for table `purchases`
--

CREATE TABLE IF NOT EXISTS `purchases` (
  `id` int(255) NOT NULL,
  `id_order` int(200) NOT NULL,
  `id_prod` int(100) NOT NULL,
  `count` int(10) NOT NULL
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COMMENT='Купленные товары';

--
-- Dumping data for table `purchases`
--

INSERT INTO `purchases` (`id`, `id_order`, `id_prod`, `count`) VALUES
(1, 1, 1, 1),
(2, 2, 1, 3),
(3, 3, 1, 1),
(4, 3, 2, 2),
(5, 4, 1, 2);

-- --------------------------------------------------------

--
-- Table structure for table `specifications`
--

CREATE TABLE IF NOT EXISTS `specifications` (
  `id` int(255) NOT NULL,
  `id_prod` int(100) NOT NULL,
  `id_prop` int(10) unsigned NOT NULL,
  `value` varchar(50) NOT NULL
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='Характеристики товаров';

--
-- Dumping data for table `specifications`
--

INSERT INTO `specifications` (`id`, `id_prod`, `id_prop`, `value`) VALUES
(1, 2, 4, '12');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE IF NOT EXISTS `users` (
  `id` int(100) NOT NULL,
  `login` varchar(100) NOT NULL,
  `pass` varchar(32) NOT NULL,
  `role` varchar(100) NOT NULL,
  `name` varchar(100) NOT NULL
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `login`, `pass`, `role`, `name`) VALUES
(1, 'admin', '5154f2a3a5fbdd51f8298b6297d57766', 'admin', 'Администратор');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `contacts`
--
ALTER TABLE `contacts`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `feedbacks`
--
ALTER TABLE `feedbacks`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `photos`
--
ALTER TABLE `photos`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `properties`
--
ALTER TABLE `properties`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `id` (`id`);

--
-- Indexes for table `purchases`
--
ALTER TABLE `purchases`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `specifications`
--
ALTER TABLE `specifications`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `login` (`login`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=17;
--
-- AUTO_INCREMENT for table `contacts`
--
ALTER TABLE `contacts`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `feedbacks`
--
ALTER TABLE `feedbacks`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `id` int(200) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT for table `photos`
--
ALTER TABLE `photos`
  MODIFY `id` int(255) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=36;
--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `properties`
--
ALTER TABLE `properties`
  MODIFY `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT for table `purchases`
--
ALTER TABLE `purchases`
  MODIFY `id` int(255) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=6;
--
-- AUTO_INCREMENT for table `specifications`
--
ALTER TABLE `specifications`
  MODIFY `id` int(255) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(100) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=2;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
