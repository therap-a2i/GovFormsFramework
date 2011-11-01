-- phpMyAdmin SQL Dump
-- version 3.3.9
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Oct 16, 2011 at 08:27 AM
-- Server version: 5.5.8
-- PHP Version: 5.3.5

SET FOREIGN_KEY_CHECKS=0;
SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT=0;
START TRANSACTION;


--
-- Database: `gov_forms`
--

-- --------------------------------------------------------

--
-- Table structure for table `field`
--

CREATE TABLE IF NOT EXISTS `field` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `field_id` text NOT NULL,
  `form_id` int(11) NOT NULL,
  `type` text NOT NULL,
  `input_type` text,
  `col_name` text,
  `label` text NOT NULL,
  `help_text` longtext,
  `options` longtext,
  `list_data_id` int(11) DEFAULT NULL,
  `def_value` text,
  `field_order` int(11) NOT NULL,
  `required` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `field`
--


-- --------------------------------------------------------

--
-- Table structure for table `form`
--

CREATE TABLE IF NOT EXISTS `form` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `form_id` text NOT NULL,
  `title` text NOT NULL,
  `subtitle` text,
  `detail` longtext,
  `table_name` text,
  `status` int(11) NOT NULL,
  `template_file` longblob,
  `template_file_name` text,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `form`
--


-- --------------------------------------------------------

--
-- Table structure for table `list_data`
--

CREATE TABLE IF NOT EXISTS `list_data` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sys_id` text NOT NULL,
  `name` text NOT NULL,
  `detail` longtext,
  `list_values` longtext NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `list_data`
--


-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE IF NOT EXISTS `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sys_id` text NOT NULL,
  `user` text NOT NULL,
  `password` text NOT NULL,
  `name` text NOT NULL,
  `title` text NOT NULL,
  `mobile` text NOT NULL,
  `email` text NOT NULL,
  `active` int(11) NOT NULL,
  `admin` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`id`, `sys_id`, `user`, `password`, `name`, `title`, `mobile`, `email`, `active`, `admin`) VALUES
(1, '1', 'admin', 'admin', '', '', '', '', 1, 1);
SET FOREIGN_KEY_CHECKS=1;
COMMIT;
