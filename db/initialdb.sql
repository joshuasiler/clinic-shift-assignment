/*
SQLyog Community Edition- MySQL GUI v8.01 
MySQL - 5.0.51b-community-nt : Database - clinic-shift-assignment
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

CREATE DATABASE /*!32312 IF NOT EXISTS*/`clinic-shift-assignment` /*!40100 DEFAULT CHARACTER SET latin1 */;

USE `clinic-shift-assignment`;

/*Table structure for table `config_values` */

DROP TABLE IF EXISTS `config_values`;

CREATE TABLE `config_values` (
  `id` int(11) NOT NULL auto_increment,
  `key` varchar(255) default NULL,
  `value` varchar(2048) default NULL,
  `updated_at` datetime default NULL,
  `created_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

/*Data for the table `config_values` */

insert  into `config_values`(`id`,`key`,`value`,`updated_at`,`created_at`) values (1,'active_month','October 2009','2009-03-01 00:00:06','2009-02-28 15:19:27'),(2,'admin_email','anne.c.siler@gmail.com','2009-02-28 15:19:27','2009-02-28 15:19:27');

/*Table structure for table `requestedshifts` */

DROP TABLE IF EXISTS `requestedshifts`;

CREATE TABLE `requestedshifts` (
  `id` int(11) NOT NULL auto_increment,
  `request_id` int(11) default NULL,
  `target_date` datetime default NULL,
  `target_shift` varchar(50) default NULL,
  `assigned_flag` int(11) default '0',
  `updated_at` datetime default NULL,
  `created_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=51 DEFAULT CHARSET=latin1;

/*Data for the table `requestedshifts` */

insert  into `requestedshifts`(`id`,`request_id`,`target_date`,`target_shift`,`assigned_flag`,`updated_at`,`created_at`) values (1,2,'2009-03-02 08:00:00','Swing (noon to 5)',1,'2009-02-28 23:54:02','2009-02-28 22:01:46'),(2,2,'2009-03-03 08:00:00','Swing (noon to 5)',1,'2009-02-28 23:54:02','2009-02-28 22:01:46'),(3,2,'2009-03-18 07:00:00','Morning (8 to noon)',1,'2009-02-28 23:54:02','2009-02-28 22:01:46'),(4,2,'2009-03-20 07:00:00','Swing (noon to 5)',1,'2009-02-28 23:54:02','2009-02-28 22:01:46'),(5,2,'2009-03-29 07:00:00','Night (5 to 8)',1,'2009-02-28 23:54:02','2009-02-28 22:01:46'),(46,1,'2009-03-02 08:00:00','Swing (noon to 5)',0,'2009-02-28 22:11:32','2009-02-28 22:11:32'),(47,1,'2009-03-03 08:00:00','Swing (noon to 5)',0,'2009-02-28 22:11:32','2009-02-28 22:11:32'),(48,1,'2009-03-18 07:00:00','Morning (8 to noon)',0,'2009-02-28 22:11:32','2009-02-28 22:11:32'),(49,1,'2009-03-20 07:00:00','Swing (noon to 5)',0,'2009-02-28 22:11:32','2009-02-28 22:11:32'),(50,1,'2009-03-29 07:00:00','Night (5 to 8)',0,'2009-02-28 22:11:32','2009-02-28 22:11:32');

/*Table structure for table `requests` */

DROP TABLE IF EXISTS `requests`;

CREATE TABLE `requests` (
  `id` int(11) NOT NULL auto_increment,
  `email` varchar(300) default NULL,
  `req_type` varchar(255) default NULL,
  `target_month` varchar(20) default NULL,
  `shifts_desired` int(11) default NULL,
  `updated_at` datetime default NULL,
  `created_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

/*Data for the table `requests` */

insert  into `requests`(`id`,`email`,`req_type`,`target_month`,`shifts_desired`,`updated_at`,`created_at`) values (2,'joshua.siler@gmail.com','MD','March 2009',5,'2009-02-28 22:01:46','2009-02-28 22:01:46'),(3,'asdf','Medical Student','March 2009',0,'2009-02-28 23:10:49','2009-02-28 23:10:49');

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
