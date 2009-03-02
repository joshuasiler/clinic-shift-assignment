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
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

/*Data for the table `config_values` */

insert  into `config_values`(`id`,`key`,`value`,`updated_at`,`created_at`) values (2,'admin_email','anne.c.siler@gmail.com','2009-02-28 15:19:27','2009-02-28 15:19:27'),(5,'req_open','1','2009-03-01 22:18:54',NULL);

/*Table structure for table `enrollments` */

DROP TABLE IF EXISTS `enrollments`;

CREATE TABLE `enrollments` (
  `id` int(11) NOT NULL auto_increment,
  `start_date` date default NULL,
  `end_date` date default NULL,
  `updated_at` datetime default NULL,
  `created_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

/*Data for the table `enrollments` */

insert  into `enrollments`(`id`,`start_date`,`end_date`,`updated_at`,`created_at`) values (1,'2009-03-01','2009-06-15',NULL,NULL),(3,'2009-06-16','2009-09-12','2009-03-01 22:11:25','2009-03-01 22:11:25');

/*Table structure for table `requestedshifts` */

DROP TABLE IF EXISTS `requestedshifts`;

CREATE TABLE `requestedshifts` (
  `id` int(11) NOT NULL auto_increment,
  `request_id` int(11) default NULL,
  `target_date` date default NULL,
  `assigned_flag` int(11) default '0',
  `updated_at` datetime default NULL,
  `created_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=53 DEFAULT CHARSET=latin1;

/*Data for the table `requestedshifts` */

insert  into `requestedshifts`(`id`,`request_id`,`target_date`,`assigned_flag`,`updated_at`,`created_at`) values (1,1,'2009-03-01',1,'2009-03-01 22:10:45','2009-03-01 21:23:53'),(2,1,'2009-03-03',1,'2009-03-01 22:10:45','2009-03-01 21:23:53'),(3,1,'2009-03-18',1,'2009-03-01 22:10:45','2009-03-01 21:23:53'),(4,1,'2009-03-23',1,'2009-03-01 22:13:48','2009-03-01 21:23:53'),(5,1,'2009-03-24',1,'2009-03-01 22:13:48','2009-03-01 21:23:53'),(6,1,'2009-04-07',0,'2009-03-01 22:10:45','2009-03-01 21:23:53'),(7,1,'2009-04-20',1,'2009-03-01 22:13:48','2009-03-01 21:23:53'),(8,1,'2009-04-22',1,'2009-03-01 22:13:48','2009-03-01 21:23:53'),(9,1,'2009-04-27',1,'2009-03-01 22:13:49','2009-03-01 21:23:53'),(10,1,'2009-05-13',0,'2009-03-01 22:10:45','2009-03-01 21:23:53'),(11,1,'2009-05-18',0,'2009-03-01 21:23:53','2009-03-01 21:23:53'),(12,1,'2009-05-19',1,'2009-03-01 22:13:48','2009-03-01 21:23:53'),(13,1,'2009-05-26',1,'2009-03-01 22:13:49','2009-03-01 21:23:53'),(14,1,'2009-06-14',0,'2009-03-01 22:10:45','2009-03-01 21:23:53'),(15,1,'2009-06-15',0,'2009-03-01 22:10:45','2009-03-01 21:23:53'),(16,2,'2009-03-01',1,'2009-03-01 22:10:45','2009-03-01 21:26:23'),(17,2,'2009-03-03',1,'2009-03-01 22:10:45','2009-03-01 21:26:23'),(18,2,'2009-03-11',1,'2009-03-01 22:10:45','2009-03-01 21:26:23'),(19,2,'2009-03-14',1,'2009-03-01 22:10:45','2009-03-01 21:26:23'),(20,2,'2009-03-17',1,'2009-03-01 22:10:45','2009-03-01 21:26:23'),(21,2,'2009-03-18',1,'2009-03-01 22:13:48','2009-03-01 21:26:23'),(22,2,'2009-03-20',1,'2009-03-01 22:13:48','2009-03-01 21:26:23'),(23,2,'2009-03-23',1,'2009-03-01 22:13:48','2009-03-01 21:26:23'),(24,2,'2009-03-24',1,'2009-03-01 22:13:48','2009-03-01 21:26:23'),(25,2,'2009-04-07',0,'2009-03-01 22:10:45','2009-03-01 21:26:23'),(26,2,'2009-04-20',0,'2009-03-01 21:26:23','2009-03-01 21:26:23'),(27,2,'2009-04-22',1,'2009-03-01 22:13:48','2009-03-01 21:26:23'),(28,2,'2009-04-27',1,'2009-03-01 22:13:49','2009-03-01 21:26:23'),(29,2,'2009-05-02',0,'2009-03-01 22:10:45','2009-03-01 21:26:23'),(30,2,'2009-05-07',0,'2009-03-01 21:26:23','2009-03-01 21:26:23'),(31,2,'2009-05-13',0,'2009-03-01 22:10:45','2009-03-01 21:26:23'),(32,2,'2009-05-16',1,'2009-03-01 22:13:48','2009-03-01 21:26:24'),(33,2,'2009-05-18',0,'2009-03-01 21:26:24','2009-03-01 21:26:24'),(34,2,'2009-05-19',1,'2009-03-01 22:13:48','2009-03-01 21:26:24'),(35,2,'2009-05-26',1,'2009-03-01 22:13:49','2009-03-01 21:26:24'),(36,2,'2009-06-14',0,'2009-03-01 21:26:24','2009-03-01 21:26:24'),(37,2,'2009-06-15',0,'2009-03-01 22:10:45','2009-03-01 21:26:24'),(38,3,'2009-03-07',1,'2009-03-01 22:10:45','2009-03-01 22:05:47'),(39,3,'2009-03-14',1,'2009-03-01 22:10:45','2009-03-01 22:05:47'),(40,3,'2009-03-21',1,'2009-03-01 22:10:45','2009-03-01 22:05:47'),(41,3,'2009-03-28',1,'2009-03-01 22:10:45','2009-03-01 22:05:47'),(42,3,'2009-04-04',1,'2009-03-01 22:10:45','2009-03-01 22:05:47'),(43,3,'2009-04-18',1,'2009-03-01 22:14:37','2009-03-01 22:05:47'),(44,3,'2009-04-25',1,'2009-03-01 22:10:45','2009-03-01 22:05:47'),(45,3,'2009-05-02',1,'2009-03-01 22:10:45','2009-03-01 22:05:47'),(46,3,'2009-05-09',1,'2009-03-01 22:10:45','2009-03-01 22:05:47'),(47,3,'2009-05-23',1,'2009-03-01 22:14:37','2009-03-01 22:05:47'),(48,3,'2009-05-30',1,'2009-03-01 22:10:45','2009-03-01 22:05:47'),(49,3,'2009-06-06',1,'2009-03-01 22:10:45','2009-03-01 22:05:47'),(50,3,'2009-06-13',1,'2009-03-01 22:10:45','2009-03-01 22:05:47'),(52,5,'2009-06-16',1,'2009-03-01 22:14:37','2009-03-01 22:14:35');

/*Table structure for table `requests` */

DROP TABLE IF EXISTS `requests`;

CREATE TABLE `requests` (
  `id` int(11) NOT NULL auto_increment,
  `email` varchar(300) default NULL,
  `name` varchar(100) default NULL,
  `req_type` varchar(255) default NULL,
  `shifts_desired` int(11) default NULL,
  `enrollment_id` int(11) default NULL,
  `updated_at` datetime default NULL,
  `created_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

/*Data for the table `requests` */

insert  into `requests`(`id`,`email`,`name`,`req_type`,`shifts_desired`,`enrollment_id`,`updated_at`,`created_at`) values (1,'test','test','MD',10,1,'2009-03-01 21:23:53','2009-03-01 21:23:53'),(2,'test2','test2','MD',10,1,'2009-03-01 21:26:23','2009-03-01 21:26:23'),(3,'lbelhrj','bleher bleh','MD',234,1,'2009-03-01 22:05:47','2009-03-01 22:05:47'),(4,'asdfasdf','adf','MD/PHD',234,3,'2009-03-01 22:13:25','2009-03-01 22:13:25'),(5,'asdf','adsf','MD',3,3,'2009-03-01 22:14:35','2009-03-01 22:14:35');

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
