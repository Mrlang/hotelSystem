/*
 Navicat Premium Data Transfer

 Source Server         : localhost
 Source Server Type    : MySQL
 Source Server Version : 50710
 Source Host           : localhost
 Source Database       : hotel

 Target Server Type    : MySQL
 Target Server Version : 50710
 File Encoding         : utf-8

 Date: 12/27/2016 12:48:03 PM
*/

SET NAMES utf8;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
--  Table structure for `migrations`
-- ----------------------------
DROP TABLE IF EXISTS `migrations`;
CREATE TABLE `migrations` (
  `migration` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
--  Records of `migrations`
-- ----------------------------
BEGIN;
INSERT INTO `migrations` VALUES ('2014_10_12_000000_create_users_table', '1'), ('2014_10_12_100000_create_password_resets_table', '1'), ('2016_04_18_135252_create_room_types_table', '1'), ('2016_04_19_132321_create_rooms_table', '2'), ('2016_04_19_180240_create_orders_table', '2');
COMMIT;

-- ----------------------------
--  Table structure for `orders`
-- ----------------------------
DROP TABLE IF EXISTS `orders`;
CREATE TABLE `orders` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `room_no` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `phone` varchar(11) COLLATE utf8_unicode_ci NOT NULL,
  `idcard` varchar(18) COLLATE utf8_unicode_ci NOT NULL,
  `check_in_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `check_out_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `orders_room_no_foreign` (`room_no`),
  CONSTRAINT `orders_room_no_foreign` FOREIGN KEY (`room_no`) REFERENCES `rooms` (`no`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
--  Records of `orders`
-- ----------------------------
BEGIN;
INSERT INTO `orders` VALUES ('2', '4', '13032362945', '411324199602233475', '2016-12-28 00:00:00', '2016-12-30 00:00:00', '2016-12-27 12:27:56', '2016-12-27 12:27:56');
COMMIT;

-- ----------------------------
--  Table structure for `password_resets`
-- ----------------------------
DROP TABLE IF EXISTS `password_resets`;
CREATE TABLE `password_resets` (
  `email` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  KEY `password_resets_email_index` (`email`),
  KEY `password_resets_token_index` (`token`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
--  Table structure for `room_types`
-- ----------------------------
DROP TABLE IF EXISTS `room_types`;
CREATE TABLE `room_types` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
--  Records of `room_types`
-- ----------------------------
BEGIN;
INSERT INTO `room_types` VALUES ('1', '标准单人间', '2016-12-27 10:56:05', '2016-12-27 10:56:07'), ('2', '标准双人间', '2016-12-27 10:56:09', '2016-12-27 10:56:11'), ('3', '标准三人间', null, null), ('4', '豪华套房', null, null);
COMMIT;

-- ----------------------------
--  Table structure for `rooms`
-- ----------------------------
DROP TABLE IF EXISTS `rooms`;
CREATE TABLE `rooms` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `no` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `room_type_id` int(10) unsigned NOT NULL,
  `price` int(11) NOT NULL,
  `discount` double(8,2) NOT NULL DEFAULT '10.00',
  `image` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'img/rooms/default.png',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `rooms_no_index` (`no`),
  KEY `rooms_room_type_id_index` (`room_type_id`),
  CONSTRAINT `rooms_room_type_id_foreign` FOREIGN KEY (`room_type_id`) REFERENCES `room_types` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
--  Records of `rooms`
-- ----------------------------
BEGIN;
INSERT INTO `rooms` VALUES ('1', '1', '1', '100', '10.00', 'img/rooms/1.jpg', null, null), ('2', '2', '2', '200', '8.00', 'img/rooms/2.jpg', null, null), ('3', '3', '3', '300', '9.00', 'img/rooms/3.jpg', null, null), ('4', '4', '4', '400', '10.00', 'img/rooms/4.jpg', null, null);
COMMIT;

-- ----------------------------
--  Table structure for `settings`
-- ----------------------------
DROP TABLE IF EXISTS `settings`;
CREATE TABLE `settings` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `company` varchar(255) NOT NULL,
  `welcome_title` varchar(255) NOT NULL,
  `welcome_content` varchar(255) NOT NULL,
  `service_title` varchar(255) NOT NULL,
  `service_content` varchar(255) NOT NULL,
  `weibo` varchar(255) DEFAULT NULL,
  `facebook` varchar(255) DEFAULT NULL,
  `twitter` varchar(255) DEFAULT NULL,
  `created_at` varchar(255) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `settings`
-- ----------------------------
BEGIN;
INSERT INTO `settings` VALUES ('1', '重邮宾馆', '欢迎光临', '管理人：15栋118(王良，周绍天，龙宪永，李术，李元术，陈熙)', '酒店查询服务', '尊敬的用户您好，您可以在本页面进行详细的酒店房间查询。如果喜欢的房间，可拨打电话预定：020-64527848.', '', '', '', null, '2016-12-27 12:12:24');
COMMIT;

-- ----------------------------
--  Table structure for `users`
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `password` varchar(60) COLLATE utf8_unicode_ci NOT NULL,
  `is_admin` tinyint(1) NOT NULL DEFAULT '0',
  `remember_token` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_email_unique` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
--  Records of `users`
-- ----------------------------
BEGIN;
INSERT INTO `users` VALUES ('1', 'wangliang', '578423625@qq.com', '$2y$10$d2GlZFy8Wfhqxnq7uf960uThJgKQD21fYgRWKOjFz1ovf1nOrvXUm', '0', 'Twjxtrm41AHl26z1rFyw10FnKnh4ShHHpoUuqzFnc8xtYkm2cR51L6ZExvcG', '2016-12-27 10:53:05', '2016-12-27 11:06:16'), ('2', '酒店管理员', 'manager@qq.com', '$2y$10$lRTgPTISzjX0.llS.OpMpem/vHy2WY/YHHwdctjG33yosN3ZUTcrW', '1', null, '2016-12-27 11:07:30', '2016-12-27 11:07:30');
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;
