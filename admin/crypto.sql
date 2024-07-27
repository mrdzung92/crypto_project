/*
SQLyog Community v13.2.1 (64 bit)
MySQL - 8.0.37-0ubuntu0.20.04.3 : Database - crypto
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`crypto` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;

USE `crypto`;

/*Table structure for table `coin_define` */

DROP TABLE IF EXISTS `coin_define`;

CREATE TABLE `coin_define` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'id',
  `name` varchar(45) DEFAULT NULL COMMENT '虚拟币名称',
  `image` varchar(255) DEFAULT NULL COMMENT '虚拟币图片',
  `type` tinyint(1) DEFAULT '1' COMMENT '类型 1：虚拟币',
  `status` tinyint(1) DEFAULT '1' COMMENT '状态：0禁用，1启用',
  `code` varchar(45) NOT NULL COMMENT '虚拟币代码',
  `home_top` tinyint(1) DEFAULT '0' COMMENT '首页上方显示 1：显示，0 不显示，只能显示3个',
  `rate_setting` json DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `coin_define` */

insert  into `coin_define`(`id`,`name`,`image`,`type`,`status`,`code`,`home_top`,`rate_setting`) values 
(1,'Bitcoin','btc.png',1,1,'BTC',1,NULL),
(2,'Ethereum','eth.png',1,1,'ETH',1,NULL),
(3,'BNB','bnb.png',1,1,'BNB',1,NULL),
(4,'Litecoin','ltc.png',1,1,'LTC',0,NULL),
(5,'XRP','xrp.png',1,1,'XRP',0,NULL),
(6,'TRON','tron.png',1,1,'TRX',0,NULL),
(7,'USDC','usdc.png',1,1,'USDC',0,NULL),
(8,'Polygon','matic.png',1,1,'MATIC',0,NULL),
(9,'Dogecoin','doge.png',1,1,'DOGE',0,NULL),
(10,'Solana','sol.png',1,1,'SOL',0,NULL),
(11,'Bluzelle','blz.png',1,1,'BLZ',0,NULL),
(12,'LeverFi','lever.png',1,1,'LEVER',0,NULL);

/*Table structure for table `migrations` */

DROP TABLE IF EXISTS `migrations`;

CREATE TABLE `migrations` (
  `version` bigint NOT NULL,
  `migration_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `start_time` timestamp NULL DEFAULT NULL,
  `end_time` timestamp NULL DEFAULT NULL,
  `breakpoint` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`version`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `migrations` */

insert  into `migrations`(`version`,`migration_name`,`start_time`,`end_time`,`breakpoint`) values 
(20221013031925,'InstallAdmin','2024-06-02 23:19:25','2024-06-02 23:19:26',0),
(20221013031926,'InstallAdminData','2024-06-02 23:19:26','2024-06-02 23:19:26',0),
(20221013031927,'InstallAdmin20230325','2024-06-02 23:19:26','2024-06-02 23:19:26',0),
(20221013031928,'InstallAdmin20230621','2024-06-02 23:19:26','2024-06-02 23:19:26',0);

/*Table structure for table `second_contract_order` */

DROP TABLE IF EXISTS `second_contract_order`;

CREATE TABLE `second_contract_order` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `username` varchar(45) DEFAULT NULL,
  `uid` bigint DEFAULT NULL COMMENT '用户id',
  `code` varchar(25) DEFAULT NULL COMMENT '虚拟币代码',
  `order_num` varchar(255) DEFAULT NULL COMMENT '订单号',
  `time` int DEFAULT NULL COMMENT '投注时间（30,60,120）',
  `rate` decimal(6,2) DEFAULT NULL COMMENT '汇率百分比',
  `direction` varchar(10) DEFAULT NULL COMMENT '投注方向',
  `start_price` decimal(16,6) DEFAULT NULL COMMENT '开始价格',
  `end_price` decimal(16,6) DEFAULT NULL COMMENT '结束价格',
  `add_time` bigint DEFAULT NULL COMMENT '投注时间',
  `settlement_time` bigint DEFAULT NULL COMMENT '结算时间',
  `bet_result` decimal(16,6) DEFAULT NULL COMMENT '输赢',
  `bet_amount` decimal(14,6) DEFAULT NULL COMMENT '投注金额',
  `status` tinyint(1) DEFAULT '1' COMMENT '订单状态，1=》等待结算，2已结算，3撤销，4作废（扣除盈利，退本金）',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  `op_admin` varchar(45) DEFAULT NULL COMMENT '操作日志',
  `op_time` bigint DEFAULT NULL COMMENT '最后操作时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=67 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `second_contract_order` */

insert  into `second_contract_order`(`id`,`username`,`uid`,`code`,`order_num`,`time`,`rate`,`direction`,`start_price`,`end_price`,`add_time`,`settlement_time`,`bet_result`,`bet_amount`,`status`,`remark`,`op_admin`,`op_time`) values 
(2,'ceshi2233',1,'BTC','T20240722000000000002',180,100.00,'down',66794.010000,66799.680000,1721661986,1721662166,-2000.000000,2000.000000,2,NULL,NULL,NULL),
(3,'ceshi2233',1,'BTC','T20240722000000000003',180,100.00,'down',66816.010000,66810.010000,1721662032,1721662212,2000.000000,2000.000000,2,NULL,NULL,NULL),
(4,'ceshi2233',1,'BTC','T20240722000000000004',30,100.00,'down',66843.610000,66856.760000,1721662038,1721662068,-1000.000000,1000.000000,2,NULL,NULL,NULL),
(5,'ceshi2233',1,'BTC','T20240722000000000005',180,100.00,'down',66868.000000,66911.660000,1721662306,1721662486,-2000.000000,2000.000000,2,NULL,NULL,NULL),
(6,'ceshi2233',1,'BTC','T20240722000000000006',180,100.00,'up',66910.010000,67030.420000,1721662536,1721662716,2000.000000,2000.000000,2,NULL,NULL,NULL),
(7,'ceshi2233',1,'BTC','T20240722000000000007',180,100.00,'up',67124.640000,67145.840000,1721663298,1721663478,2000.000000,2000.000000,2,NULL,NULL,NULL),
(8,'ceshi2233',1,'BTC','T20240722000000000008',180,100.00,'up',67128.010000,67070.510000,1721663756,1721663936,-2000.000000,2000.000000,2,NULL,NULL,NULL),
(9,'ceshi2233',1,'BTC','T20240723000000000009',180,100.00,'up',67145.990000,67152.010000,1721667110,1721667290,1000.000000,1000.000000,2,NULL,NULL,NULL),
(10,'ceshi2233',1,'BTC','T20240723000000000010',120,100.00,'up',67112.010000,67136.000000,1721668345,1721668465,2000.000000,2000.000000,2,NULL,NULL,NULL),
(11,'ceshi2233',1,'BTC','T20240723000000000011',120,100.00,'up',67124.000000,67116.010000,1721668358,1721668478,-2000.000000,2000.000000,2,NULL,NULL,NULL),
(12,'ceshi2233',1,'BTC','T20240723000000000012',180,100.00,'up',67136.010000,67148.000000,1721668435,1721668615,2000.000000,2000.000000,2,NULL,NULL,NULL),
(13,'ceshi2233',1,'BTC','T20240723000000000013',180,100.00,'up',67116.010000,67154.000000,1721668480,1721668660,2000.000000,2000.000000,2,NULL,NULL,NULL),
(14,'ceshi2233',1,'BTC','T20240723000000000014',180,100.00,'up',67128.010000,67220.490000,1721668592,1721668772,2000.000000,2000.000000,2,NULL,NULL,NULL),
(15,'ceshi2233',1,'BTC','T20240723000000000015',180,100.00,'up',67194.010000,67202.010000,1721668720,1721668900,2000.000000,2000.000000,2,NULL,NULL,NULL),
(16,'ceshi2233',1,'BTC','T20240723000000000016',30,100.00,'up',67202.000000,67220.500000,1721668732,1721668762,2000.000000,2000.000000,2,NULL,NULL,NULL),
(17,'ceshi2233',1,'BTC','T20240723000000000017',180,100.00,'up',67214.430000,67234.000000,1721668818,1721668998,2000.000000,2000.000000,2,NULL,NULL,NULL),
(18,'ceshi2233',1,'BTC','T20240723000000000018',180,100.00,'down',67246.230000,67234.000000,1721668824,1721669004,2000.000000,2000.000000,2,NULL,NULL,NULL),
(19,'ceshi2233',1,'BTC','T20240723000000000019',180,100.00,'up',67208.010000,67231.310000,1721668928,1721669108,2000.000000,2000.000000,2,NULL,NULL,NULL),
(20,'ceshi2233',1,'BTC','T20240723000000000020',180,100.00,'down',67208.010000,67231.310000,1721668933,1721669113,-2000.000000,2000.000000,2,NULL,NULL,NULL),
(21,'ceshi2233',1,'BTC','T20240723000000000021',30,100.00,'up',67188.010000,67220.000000,1721668945,1721668975,10.000000,10.000000,2,NULL,NULL,NULL),
(22,'ceshi2233',1,'BTC','T20240723000000000022',180,100.00,'up',67249.560000,67303.000000,1721669173,1721669353,2000.000000,2000.000000,2,NULL,NULL,NULL),
(23,'ceshi2233',1,'BTC','T20240723000000000023',180,100.00,'up',67250.010000,67303.000000,1721669200,1721669380,2000.000000,2000.000000,2,NULL,NULL,NULL),
(24,'ceshi2233',1,'BTC','T20240723000000000024',180,100.00,'up',67271.050000,67270.010000,1721669228,1721669408,-2000.000000,2000.000000,2,NULL,NULL,NULL),
(25,'ceshi2233',1,'BTC','T20240723000000000025',180,100.00,'down',67271.050000,67274.000000,1721669236,1721669416,-2000.000000,2000.000000,2,NULL,NULL,NULL),
(26,'ceshi2233',1,'BTC','T20240723000000000026',180,100.00,'up',67278.670000,67350.000000,1721669427,1721669607,2000.000000,2000.000000,2,NULL,NULL,NULL),
(27,'ceshi2233',1,'BTC','T20240723000000000027',120,100.00,'up',67260.010000,67382.670000,1721669436,1721669556,2000.000000,2000.000000,2,NULL,NULL,NULL),
(28,'ceshi2233',1,'BTC','T20240723000000000028',120,100.00,'up',67382.670000,67359.150000,1721669550,1721669670,-2000.000000,2000.000000,2,NULL,NULL,NULL),
(29,'ceshi2233',1,'BTC','T20240723000000000029',180,100.00,'down',67370.000000,67412.010000,1721669708,1721669888,-2000.000000,2000.000000,2,NULL,NULL,NULL),
(30,'ceshi2233',1,'BTC','T20240723000000000030',180,100.00,'up',67374.010000,67366.010000,1721669951,1721670131,-2000.000000,2000.000000,2,NULL,NULL,NULL),
(31,'ceshi2233',1,'BTC','T20240723000000000031',180,100.00,'down',67376.010000,67362.290000,1721669962,1721670142,2000.000000,2000.000000,2,NULL,NULL,NULL),
(32,'ceshi2233',1,'BTC','T20240723000000000032',180,100.00,'up',67388.010000,67358.410000,1721669972,1721670152,-2000.000000,2000.000000,2,NULL,NULL,NULL),
(33,'ceshi2233',1,'BTC','T20240723000000000033',180,100.00,'down',67382.010000,67397.990000,1721670748,1721670928,-2000.000000,2000.000000,2,NULL,NULL,NULL),
(34,'ceshi2233',1,'BTC','T20240723000000000034',30,100.00,'up',67552.010000,67586.000000,1721671479,1721671509,1000.000000,1000.000000,2,NULL,NULL,NULL),
(35,'ceshi2233',1,'BTC','T20240723000000000035',180,100.00,'down',67536.320000,67588.010000,1721706365,1721706545,-2000.000000,2000.000000,2,NULL,NULL,NULL),
(36,'ceshi2233',1,'BTC','T20240723000000000036',120,100.00,'up',67531.910000,67584.470000,1721706374,1721706494,2000.000000,2000.000000,2,NULL,NULL,NULL),
(37,'ceshi2233',1,'BTC','T20240723000000000037',180,100.00,'up',67105.090000,67160.010000,1721710172,1721710352,2000.000000,2000.000000,2,NULL,NULL,NULL),
(38,'ceshi2233',1,'BTC','T20240723000000000038',30,100.00,'up',67102.010000,67086.020000,1721710181,1721710211,-500.000000,500.000000,2,NULL,NULL,NULL),
(39,'ceshi2233',1,'BTC','T20240723000000000039',30,100.00,'up',67190.000000,67170.010000,1721710275,1721710305,-20.000000,20.000000,2,NULL,NULL,NULL),
(40,'ceshi2233',1,'BTC','T20240723000000000040',30,100.00,'up',67167.810000,67150.010000,1721710334,1721710364,-20.000000,20.000000,2,NULL,NULL,NULL),
(41,'ceshi2233',1,'BTC','T20240723000000000041',30,100.00,'up',67138.010000,67138.010000,1721710392,1721710422,0.000000,20.000000,2,NULL,NULL,NULL),
(42,'ceshi2233',1,'BTC','T20240723000000000042',30,100.00,'up',67138.010000,67130.820000,1721710401,1721710431,-20.000000,20.000000,2,NULL,NULL,NULL),
(43,'ceshi2233',1,'BTC','T20240723000000000043',120,100.00,'up',67136.000000,67063.520000,1721710461,1721710581,-1000.000000,1000.000000,2,NULL,NULL,NULL),
(44,'ceshi2233',1,'BTC','T20240723000000000044',30,100.00,'up',67130.010000,67120.010000,1721710468,1721710498,-500.000000,500.000000,2,NULL,NULL,NULL),
(45,'ceshi2233',1,'BTC','T20240723000000000045',120,100.00,'down',66968.010000,66926.010000,1721710756,1721710876,2000.000000,2000.000000,2,NULL,NULL,NULL),
(46,'ceshi2233',1,'BTC','T20240723000000000046',30,100.00,'up',66932.000000,66940.000000,1721710807,1721710837,1000.000000,1000.000000,2,NULL,NULL,NULL),
(47,'ceshi2233',1,'BTC','T20240723000000000047',30,100.00,'up',66518.020000,66462.010000,1721712660,1721712690,-10.000000,10.000000,2,NULL,NULL,NULL),
(48,'ceshi2233',1,'BTC','T20240723000000000048',30,100.00,'up',66422.000000,66392.690000,1721712802,1721712832,-20.000000,20.000000,2,NULL,NULL,NULL),
(49,'ceshi2233',1,'BTC','T20240723000000000049',60,100.00,'up',66426.010000,66386.000000,1721713096,1721713156,-1000.000000,1000.000000,2,NULL,NULL,NULL),
(50,'ceshi2233',1,'BTC','T20240723000000000050',120,100.00,'up',66400.010000,66472.010000,1721713521,1721713641,1000.000000,1000.000000,2,NULL,NULL,NULL),
(51,'ceshi2233',1,'BTC','T20240723000000000051',30,100.00,'up',66354.000000,66395.980000,1721713529,1721713559,10.000000,10.000000,2,NULL,NULL,NULL),
(52,'ceshi2233',1,'BTC','T20240723000000000052',30,100.00,'up',66612.000000,66582.040000,1721722310,1721722340,-20.000000,20.000000,2,NULL,NULL,NULL),
(53,'ceshi2233',1,'BTC','T20240723000000000053',30,100.00,'up',66646.980000,66641.010000,1721722684,1721722714,-20.000000,20.000000,2,NULL,NULL,NULL),
(54,'ceshi2233',1,'BTC','T20240723000000000054',30,100.00,'up',66648.660000,66648.660000,1721722759,1721722789,0.000000,20.000000,2,NULL,NULL,NULL),
(55,'ceshi2233',1,'BTC','T20240723000000000055',30,100.00,'up',66666.010000,66702.000000,1721723261,1721723291,20.000000,20.000000,2,NULL,NULL,NULL),
(56,'ceshi2233',1,'BTC','T20240723000000000056',30,100.00,'up',66743.250000,66768.000000,1721723406,1721723436,20.000000,20.000000,2,NULL,NULL,NULL),
(57,'ceshi2233',1,'BTC','T20240723000000000057',60,100.00,'up',66993.050000,66964.000000,1721723573,1721723633,-20.000000,20.000000,2,NULL,NULL,NULL),
(58,'ceshi2233',1,'BTC','T20240723000000000058',60,100.00,'up',66976.010000,66927.000000,1721723649,1721723709,-20.000000,20.000000,2,NULL,NULL,NULL),
(59,'ceshi2233',1,'BTC','T20240723000000000059',60,100.00,'up',66890.010000,66908.010000,1721723729,1721723789,20.000000,20.000000,2,NULL,NULL,NULL),
(60,'ceshi2233',1,'BTC','T20240723000000000060',30,100.00,'up',66930.010000,66924.010000,1721724543,1721724573,-20.000000,20.000000,2,NULL,NULL,NULL),
(61,'ceshi2233',1,'BTC','T20240723000000000061',30,100.00,'up',66914.010000,66964.010000,1721724618,1721724648,10.000000,10.000000,2,NULL,NULL,NULL),
(62,'ceshi2233',1,'BTC','T20240723000000000062',30,100.00,'up',66929.360000,66968.010000,1721724627,1721724657,20.000000,20.000000,2,NULL,NULL,NULL),
(63,'ceshi2233',1,'BTC','T20240723000000000063',60,100.00,'up',66950.000000,66968.260000,1721724638,1721724698,20.000000,20.000000,2,NULL,NULL,NULL),
(64,'ceshi2233',1,'BTC','T20240723000000000064',30,100.00,'up',66964.010000,66970.000000,1721724645,1721724675,10.000000,10.000000,2,NULL,NULL,NULL),
(65,'ceshi2233',1,'BTC','T20240723000000000065',30,100.00,'up',66968.260000,66956.010000,1721724702,1721724732,-20.000000,20.000000,2,NULL,NULL,NULL),
(66,'ceshi2233',1,'BTC','T20240723000000000066',30,100.00,'up',66926.260000,66960.010000,1721724778,1721724808,20.000000,20.000000,2,NULL,NULL,NULL);

/*Table structure for table `second_contract_rate_default` */

DROP TABLE IF EXISTS `second_contract_rate_default`;

CREATE TABLE `second_contract_rate_default` (
  `id` int NOT NULL AUTO_INCREMENT,
  `time` int DEFAULT NULL COMMENT '结算时间（秒）',
  `rate` decimal(8,2) DEFAULT NULL COMMENT '盈利百分比',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `second_contract_rate_default` */

insert  into `second_contract_rate_default`(`id`,`time`,`rate`) values 
(1,30,100.00),
(2,60,100.00),
(3,120,100.00),
(4,180,100.00);

/*Table structure for table `system_auth` */

DROP TABLE IF EXISTS `system_auth`;

CREATE TABLE `system_auth` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '权限名称',
  `utype` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '身份权限',
  `desc` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '备注说明',
  `sort` bigint DEFAULT '0' COMMENT '排序权重',
  `status` int DEFAULT '1' COMMENT '权限状态(1使用,0禁用)',
  `create_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `i73a781d61_sort` (`sort`),
  KEY `i73a781d61_title` (`title`),
  KEY `i73a781d61_status` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='系统-权限';

/*Data for the table `system_auth` */

/*Table structure for table `system_auth_node` */

DROP TABLE IF EXISTS `system_auth_node`;

CREATE TABLE `system_auth_node` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `auth` bigint DEFAULT '0' COMMENT '角色',
  `node` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '节点',
  PRIMARY KEY (`id`),
  KEY `i4cd9aaff6_auth` (`auth`),
  KEY `i4cd9aaff6_node` (`node`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='系统-授权';

/*Data for the table `system_auth_node` */

/*Table structure for table `system_base` */

DROP TABLE IF EXISTS `system_base`;

CREATE TABLE `system_base` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `type` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '数据类型',
  `code` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '数据代码',
  `name` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '数据名称',
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT '数据内容',
  `sort` bigint DEFAULT '0' COMMENT '排序权重',
  `status` int DEFAULT '1' COMMENT '数据状态(0禁用,1启动)',
  `deleted` int DEFAULT '0' COMMENT '删除状态(0正常,1已删)',
  `deleted_at` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '删除时间',
  `deleted_by` bigint DEFAULT '0' COMMENT '删除用户',
  `create_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `i2a29c450f_type` (`type`),
  KEY `i2a29c450f_code` (`code`),
  KEY `i2a29c450f_name` (`name`),
  KEY `i2a29c450f_sort` (`sort`),
  KEY `i2a29c450f_status` (`status`),
  KEY `i2a29c450f_deleted` (`deleted`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='系统-字典';

/*Data for the table `system_base` */

/*Table structure for table `system_config` */

DROP TABLE IF EXISTS `system_config`;

CREATE TABLE `system_config` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `type` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '配置分类',
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '配置名称',
  `value` varchar(2048) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '配置内容',
  PRIMARY KEY (`id`),
  KEY `i48e345b98_type` (`type`),
  KEY `i48e345b98_name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='系统-配置';

/*Data for the table `system_config` */

insert  into `system_config`(`id`,`type`,`name`,`value`) values 
(1,'base','app_name','ThinkAdmin'),
(2,'base','app_version','v6'),
(3,'base','editor','ckeditor5'),
(4,'base','login_name','系统管理'),
(5,'base','site_copy','©版权所有 2014-2024 ThinkAdmin'),
(6,'base','site_icon','https://thinkadmin.top/static/img/logo.png'),
(7,'base','site_name','ThinkAdmin'),
(8,'base','site_theme','default'),
(9,'storage','allow_exts','doc,gif,ico,jpg,mp3,mp4,p12,pem,png,zip,rar,xls,xlsx'),
(10,'storage','type','local'),
(11,'wechat','type','api'),
(12,'base','site_host','http://crypto.local'),
(13,'storage','link_type','none'),
(14,'storage','name_type','xmd5'),
(15,'storage','local_http_protocol','follow');

/*Table structure for table `system_data` */

DROP TABLE IF EXISTS `system_data`;

CREATE TABLE `system_data` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '配置名',
  `value` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT '配置值',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `icbccedc16_name` (`name`),
  KEY `icbccedc16_create_time` (`create_time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='系统-数据';

/*Data for the table `system_data` */

/*Table structure for table `system_file` */

DROP TABLE IF EXISTS `system_file`;

CREATE TABLE `system_file` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `type` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '上传类型',
  `hash` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '文件哈希',
  `tags` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '文件标签',
  `name` varchar(180) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '文件名称',
  `xext` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '文件后缀',
  `xurl` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '访问链接',
  `xkey` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '文件路径',
  `mime` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '文件类型',
  `size` bigint DEFAULT '0' COMMENT '文件大小',
  `uuid` bigint DEFAULT '0' COMMENT '用户编号',
  `unid` bigint DEFAULT '0' COMMENT '会员编号',
  `isfast` int DEFAULT '0' COMMENT '是否秒传',
  `issafe` int DEFAULT '0' COMMENT '安全模式',
  `status` int DEFAULT '1' COMMENT '上传状态(1悬空,2落地)',
  `create_at` datetime DEFAULT NULL COMMENT '创建时间',
  `update_at` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `i738a363ca_type` (`type`),
  KEY `i738a363ca_hash` (`hash`),
  KEY `i738a363ca_uuid` (`uuid`),
  KEY `i738a363ca_xext` (`xext`),
  KEY `i738a363ca_unid` (`unid`),
  KEY `i738a363ca_tags` (`tags`),
  KEY `i738a363ca_name` (`name`),
  KEY `i738a363ca_status` (`status`),
  KEY `i738a363ca_issafe` (`issafe`),
  KEY `i738a363ca_isfast` (`isfast`),
  KEY `i738a363ca_create_at` (`create_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='系统-文件';

/*Data for the table `system_file` */

/*Table structure for table `system_menu` */

DROP TABLE IF EXISTS `system_menu`;

CREATE TABLE `system_menu` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `pid` bigint DEFAULT '0' COMMENT '上级ID',
  `title` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '菜单名称',
  `icon` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '菜单图标',
  `node` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '节点代码',
  `url` varchar(400) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '链接节点',
  `params` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '链接参数',
  `target` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '_self' COMMENT '打开方式',
  `sort` bigint DEFAULT '0' COMMENT '排序权重',
  `status` int DEFAULT '1' COMMENT '状态(0:禁用,1:启用)',
  `create_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `i29b9da675_pid` (`pid`),
  KEY `i29b9da675_sort` (`sort`),
  KEY `i29b9da675_status` (`status`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='系统-菜单';

/*Data for the table `system_menu` */

insert  into `system_menu`(`id`,`pid`,`title`,`icon`,`node`,`url`,`params`,`target`,`sort`,`status`,`create_at`) values 
(1,0,'系统管理','','','#','','_self',100,1,'2024-06-02 23:19:26'),
(2,1,'系统配置','','','#','','_self',0,1,'2024-06-02 23:19:26'),
(3,2,'系统参数配置','layui-icon layui-icon-set','admin/config/index','admin/config/index','','_self',0,1,'2024-06-02 23:19:26'),
(4,2,'系统任务管理','layui-icon layui-icon-log','admin/queue/index','admin/queue/index','','_self',0,1,'2024-06-02 23:19:26'),
(5,2,'系统日志管理','layui-icon layui-icon-form','admin/oplog/index','admin/oplog/index','','_self',0,1,'2024-06-02 23:19:26'),
(6,2,'数据字典管理','layui-icon layui-icon-code-circle','admin/base/index','admin/base/index','','_self',0,1,'2024-06-02 23:19:26'),
(7,2,'系统文件管理','layui-icon layui-icon-carousel','admin/file/index','admin/file/index','','_self',0,1,'2024-06-02 23:19:26'),
(8,2,'系统菜单管理','layui-icon layui-icon-layouts','admin/menu/index','admin/menu/index','','_self',0,1,'2024-06-02 23:19:26'),
(9,1,'权限管理','','','#','','_self',0,1,'2024-06-02 23:19:26'),
(10,9,'系统权限管理','layui-icon layui-icon-vercode','admin/auth/index','admin/auth/index','','_self',0,1,'2024-06-02 23:19:26'),
(11,9,'系统用户管理','layui-icon layui-icon-username','admin/user/index','admin/user/index','','_self',0,1,'2024-06-02 23:19:26'),
(12,0,'玩家管理','layui-icon layui-icon-friends','','#','','_self',0,1,'2024-07-04 20:26:25'),
(13,12,'玩家用户','layui-icon layui-icon-friends','users/users/index','users/users/index','','_self',0,1,'2024-07-04 20:27:09');

/*Table structure for table `system_oplog` */

DROP TABLE IF EXISTS `system_oplog`;

CREATE TABLE `system_oplog` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `node` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '当前操作节点',
  `geoip` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '操作者IP地址',
  `action` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '操作行为名称',
  `content` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '操作内容描述',
  `username` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '操作人用户名',
  `create_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `id7cb1c775_create_at` (`create_at`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='系统-日志';

/*Data for the table `system_oplog` */

insert  into `system_oplog`(`id`,`node`,`geoip`,`action`,`content`,`username`,`create_at`) values 
(1,'admin/login/index','127.0.0.1','系统用户登录','登录系统后台成功','admin','2024-06-03 00:16:09'),
(2,'admin/login/index','127.0.0.1','系统用户登录','登录系统后台成功','admin','2024-07-04 16:54:54'),
(3,'admin/login/index','127.0.0.1','系统用户登录','登录系统后台成功','admin','2024-07-04 20:24:29'),
(4,'admin/menu/add','127.0.0.1','系统菜单管理','增加系统菜单[12]成功','admin','2024-07-04 20:26:24'),
(5,'admin/menu/add','127.0.0.1','系统菜单管理','增加系统菜单[13]成功','admin','2024-07-04 20:27:08');

/*Table structure for table `system_queue` */

DROP TABLE IF EXISTS `system_queue`;

CREATE TABLE `system_queue` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `code` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '任务编号',
  `title` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '任务名称',
  `command` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '执行指令',
  `exec_pid` bigint DEFAULT '0' COMMENT '执行进程',
  `exec_data` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT '执行参数',
  `exec_time` bigint DEFAULT '0' COMMENT '执行时间',
  `exec_desc` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '执行描述',
  `enter_time` decimal(20,4) DEFAULT '0.0000' COMMENT '开始时间',
  `outer_time` decimal(20,4) DEFAULT '0.0000' COMMENT '结束时间',
  `loops_time` bigint DEFAULT '0' COMMENT '循环时间',
  `attempts` bigint DEFAULT '0' COMMENT '执行次数',
  `message` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT '最新消息',
  `rscript` int DEFAULT '1' COMMENT '任务类型(0单例,1多例)',
  `status` int DEFAULT '1' COMMENT '任务状态(1新任务,2处理中,3成功,4失败)',
  `create_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `if64376974_code` (`code`),
  KEY `if64376974_title` (`title`),
  KEY `if64376974_status` (`status`),
  KEY `if64376974_rscript` (`rscript`),
  KEY `if64376974_create_at` (`create_at`),
  KEY `if64376974_exec_time` (`exec_time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='系统-任务';

/*Data for the table `system_queue` */

/*Table structure for table `system_user` */

DROP TABLE IF EXISTS `system_user`;

CREATE TABLE `system_user` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `usertype` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '用户类型',
  `username` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '用户账号',
  `password` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '用户密码',
  `nickname` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '用户昵称',
  `headimg` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '头像地址',
  `authorize` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '权限授权',
  `contact_qq` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '联系QQ',
  `contact_mail` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '联系邮箱',
  `contact_phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '联系手机',
  `login_ip` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '登录地址',
  `login_at` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '登录时间',
  `login_num` bigint DEFAULT '0' COMMENT '登录次数',
  `describe` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '备注说明',
  `sort` bigint DEFAULT '0' COMMENT '排序权重',
  `status` int DEFAULT '1' COMMENT '状态(0禁用,1启用)',
  `is_deleted` int DEFAULT '0' COMMENT '删除(1删除,0未删)',
  `create_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `i34b957835_sort` (`sort`),
  KEY `i34b957835_status` (`status`),
  KEY `i34b957835_username` (`username`),
  KEY `i34b957835_is_deleted` (`is_deleted`)
) ENGINE=InnoDB AUTO_INCREMENT=10001 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='系统-用户';

/*Data for the table `system_user` */

insert  into `system_user`(`id`,`usertype`,`username`,`password`,`nickname`,`headimg`,`authorize`,`contact_qq`,`contact_mail`,`contact_phone`,`login_ip`,`login_at`,`login_num`,`describe`,`sort`,`status`,`is_deleted`,`create_at`) values 
(10000,'','admin','21232f297a57a5a743894a0e4a801fc3','超级管理员','https://thinkadmin.top/static/img/head.png','','','','','127.0.0.1','2024-07-04 20:24:29',3,'',0,1,0,'2024-06-02 23:19:27');

/*Table structure for table `users` */

DROP TABLE IF EXISTS `users`;

CREATE TABLE `users` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'id',
  `username` varchar(45) DEFAULT NULL COMMENT '用户名',
  `password` varchar(255) DEFAULT NULL COMMENT '登录密码',
  `password2` varchar(255) DEFAULT NULL COMMENT '交易密码',
  `login_ip` bigint DEFAULT NULL COMMENT '登录IP',
  `login_time` bigint DEFAULT NULL COMMENT '登录时间',
  `invite_code` varchar(6) DEFAULT NULL,
  `register_time` bigint DEFAULT NULL,
  `register_ip` bigint DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `user_type` tinyint(1) DEFAULT '1' COMMENT '用户类型：1真实用户，0虚拟用户',
  `status` tinyint(1) DEFAULT '1' COMMENT '用户状态：1 正常， 0 禁用，（）',
  `recharge_status` tinyint(1) DEFAULT '1' COMMENT '充值状态：1正常 0 禁用',
  `withdraw_status` tinyint(1) DEFAULT '1' COMMENT '提款状态：1正常 0 禁用',
  `trade_status` tinyint(1) DEFAULT '1' COMMENT '交易状态：1正常 0 禁用',
  `online_status` tinyint(1) DEFAULT '0' COMMENT '在线状态：1在线 0 离线',
  `usdt` decimal(16,5) DEFAULT '0.00000' COMMENT 'usdt钱包',
  `parent_id` bigint DEFAULT '0' COMMENT '上级id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `users` */

insert  into `users`(`id`,`username`,`password`,`password2`,`login_ip`,`login_time`,`invite_code`,`register_time`,`register_ip`,`email`,`user_type`,`status`,`recharge_status`,`withdraw_status`,`trade_status`,`online_status`,`usdt`,`parent_id`) values 
(1,'ceshi2233','$2y$10$NYNVWknuiEYDTJn3GQ5z4uxU6dTgrKselh1MUZRfnnbn3GS8qX9Ua',NULL,2130706433,1720779412,'123456',1720240778,2130706433,NULL,1,1,1,1,1,0,100003.00000,0),
(2,'ceshia','$2y$10$CzU.4fag6CYzTcFZsubPDuE0Gjh3CNQJ3L9sufOfdwjvViCZRrK8.',NULL,2130706433,1720618021,'123455',1720618021,2130706433,NULL,1,1,1,1,1,0,0.00000,1),
(3,'ceshib','$2y$10$JR2F.fwC0yTNikLaeMi.Q.HMLq.piJle/AIzH7SsjsZJbxsWKtjey',NULL,2130706433,1720618997,'39n8yq',1720618997,2130706433,NULL,1,1,1,1,1,0,0.00000,0),
(4,'ceshic','$2y$10$FV08G8j0.SMKGWdt1aDwCu0ZfSnsc4WkZtNyzro98lu3jeyLXLwHe',NULL,2130706433,1720619178,'fwmj8i',1720619178,2130706433,NULL,1,1,1,1,1,0,0.00000,1),
(5,'ceshi2235','$2y$10$RCPZsmQ.wpivyN/fOQNZzOw42TLDfx3dy3EXITT321JSkEAaWBjKi',NULL,2130706433,1720619364,'jhvf7g',1720619364,2130706433,NULL,1,1,1,1,1,0,0.00000,4),
(6,'ceshi2236','$2y$10$9hKtdDgVEVuY1MbAlu6LGe7ATn0xiXlq0WoImKYjG.sZOaqG68b9u',NULL,2130706433,1720619393,'itbiau',1720619393,2130706433,NULL,1,1,1,1,1,0,0.00000,4),
(7,'ceshi2238','$2y$10$gRbVa2wcJnKW9z1FRWzvcugiZW64uuqGO4elCKTO37yyG7PfuaOMK',NULL,2130706433,1720623337,'4btzgf',1720623337,2130706433,NULL,1,1,1,1,1,0,0.00000,6),
(8,'ceshi2239','$2y$10$MK6Lv8GFPXHqrDOlMPT4SuyAjgv4u9TcOYVG66F0SKGEah/18uNS6',NULL,2130706433,1720625911,'7efyo2',1720625911,2130706433,NULL,1,1,1,1,1,0,0.00000,7);

/*Table structure for table `users_secondary wallet` */

DROP TABLE IF EXISTS `users_secondary wallet`;

CREATE TABLE `users_secondary wallet` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `uid` bigint DEFAULT NULL COMMENT '用户id',
  `wallet_id` int DEFAULT NULL COMMENT '钱包id',
  `balance` decimal(16,5) DEFAULT NULL COMMENT '钱包',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `users_secondary wallet` */

/*Table structure for table `users_secondary wallet_define` */

DROP TABLE IF EXISTS `users_secondary wallet_define`;

CREATE TABLE `users_secondary wallet_define` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '钱包id',
  `name` varchar(45) DEFAULT NULL COMMENT '钱包名称',
  `status` tinyint(1) DEFAULT NULL COMMENT '钱包状态',
  `image` varchar(255) DEFAULT NULL COMMENT '钱包图',
  `default` tinyint(1) DEFAULT '0' COMMENT '默认钱包 1:默认',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `users_secondary wallet_define` */

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
