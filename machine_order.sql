/*
Navicat MySQL Data Transfer

Source Server         : SinsimProDb
Source Server Version : 50721
Source Host           : 115.231.6.43:3306
Source Database       : sinsim_db

Target Server Type    : MYSQL
Target Server Version : 50721
File Encoding         : 65001

Date: 2018-05-23 15:26:44
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `machine_order`
-- ----------------------------
DROP TABLE IF EXISTS `machine_order`;
CREATE TABLE `machine_order` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `order_num` varchar(255) NOT NULL COMMENT '订单编号',
  `original_order_id` int(10) unsigned DEFAULT NULL COMMENT '在改单/拆单情况发生时，原订单无效，为了做到数据恢复和订单原始记录，需要记录',
  `contract_id` int(10) unsigned NOT NULL COMMENT '合同号对应ID',
  `order_detail_id` int(10) unsigned NOT NULL COMMENT 'Order详细信息，通过它来多表关联',
  `create_user_id` int(10) unsigned NOT NULL COMMENT '创建订单的ID， 只有销售员和销售主管可以创建订单',
  `status` tinyint(4) unsigned NOT NULL DEFAULT '1' COMMENT '表示订单状态，默认是“1”，表示订单还未签核完成，签核完成则为“2”， 在改单后状态变为“3”， 拆单后订单状态变成“4”，取消后状态为“5”。取消时，需要检查订单中机器的安装状态，如果有机器已经开始安装，则需要先改变机器状态为取消后才能进行删除操作。如果取消时，签核还未开始，处于编辑状态，则可以直接取消，但是只要有后续部分完成签核时候，都需要填写取消原因以及记录取消的人、时间等。在order_cancel_record表中进行维护。因为order表和order_detail表中的内容比较多，所以建议在前端session中保存，这样也方便销售员在下一次填写订单时，只需要改部分内容即可',
  `country` varchar(255) DEFAULT NULL COMMENT '国家',
  `brand` varchar(255) NOT NULL DEFAULT 'SINSIM' COMMENT '商标',
  `machine_num` int(11) unsigned NOT NULL COMMENT '机器台数',
  `machine_type` int(10) unsigned NOT NULL COMMENT '机器类型',
  `needle_num` int(11) unsigned NOT NULL COMMENT '针数',
  `head_num` varchar(255) NOT NULL COMMENT '头数',
  `head_distance` int(11) unsigned NOT NULL COMMENT '头距(由销售预填、销售更改)',
  `x_distance` varchar(255) NOT NULL COMMENT 'X-行程',
  `y_distance` varchar(255) NOT NULL COMMENT 'Y-行程',
  `package_method` varchar(255) NOT NULL COMMENT '包装方式',
  `package_mark` text COMMENT '包装备注',
  `equipment` text COMMENT '机器装置，json的字符串，包含装置名称、数量、单价',
  `machine_price` varchar(255) NOT NULL COMMENT '机器价格（不包括装置）',
  `contract_ship_date` date NOT NULL,
  `plan_ship_date` date NOT NULL,
  `mark` text COMMENT '备注信息',
  `sellman` varchar(255) NOT NULL COMMENT '订单中文字输入的销售员，一般以创建订单销售员作为sellman，这边是sinsim的特殊需求',
  `valid` tinyint(3) unsigned NOT NULL DEFAULT '1',
  `maintain_type` varchar(255) NOT NULL COMMENT '保修方式',
  `create_time` datetime NOT NULL COMMENT '订单创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '订单信息更新时间',
  `end_time` datetime DEFAULT NULL COMMENT '订单结束时间',
  PRIMARY KEY (`id`),
  KEY `fk_o_machine_type` (`machine_type`),
  KEY `fk_o_order_detail_id` (`order_detail_id`),
  KEY `fk_o_contract_id` (`contract_id`),
  CONSTRAINT `fk_o_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `contract` (`id`),
  CONSTRAINT `fk_o_machine_type` FOREIGN KEY (`machine_type`) REFERENCES `machine_type` (`id`),
  CONSTRAINT `fk_o_order_detail_id` FOREIGN KEY (`order_detail_id`) REFERENCES `order_detail` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of machine_order
-- ----------------------------
INSERT INTO `machine_order` VALUES ('1', 'test01', '0', '1', '1', '1', '0', '中国', 'SINSIM电脑绣花机', '5', '1', '10', '20', '30', '100', '200', '单机', '暂无', '[{\"name\":\"简易绳绣\",\"number\":3,\"price\":\"500\"},{\"name\":\"简易绳绣\",\"number\":1,\"price\":\"600\"}]', '50000', '2018-06-09', '2018-06-10', '暂无', '谢侃', '1', 'SinSim保修', '2018-05-20 00:00:00', null, null);
INSERT INTO `machine_order` VALUES ('2', '曹445', null, '2', '2', '213', '5', '印度', 'SINSIM电脑绣花机', '3', '2', '9', '7', '400', '600', '1000', '叠机', null, '[]', '9400', '2018-06-08', '2018-06-08', null, '曹建挺', '0', 'SinSim保修', '2018-05-10 00:00:00', '2018-05-21 16:26:25', null);
INSERT INTO `machine_order` VALUES ('3', '骆1027', '0', '3', '3', '213', '2', '印度', 'Sudarshan+Gold', '4', '2', '9', '21', '300', '600', '1300', '叠机', '', '[]', '12900', '2018-06-30', '2018-06-30', '', '骆晓军', '1', 'SinSim保修', '2018-05-17 00:00:00', null, null);
INSERT INTO `machine_order` VALUES ('4', 'XS-1803025', null, '4', '4', '183', '1', '中国', 'SINSIM电脑绣花机', '2', '1', '4', '88', '110', '600', '1000', '单机', null, '[]', '258000', '2018-06-20', '2018-06-20', '前台板可拆，发货时拆除。线架前端装日光灯，操作头安台板上。', '何绍华', '1', '代理商保修', '2018-05-23 00:00:00', null, null);
INSERT INTO `machine_order` VALUES ('5', '111', null, '5', '5', '183', '0', '中国', 'SINSIM电脑绣花机', '1', '1', '4', '88', '110', '600', '1000', '单机', '', '[]', '258000', '2018-06-20', '2018-06-20', '前台板可拆，发货时拆除。线架前端装日光灯，操作头安台板上。', '1', '1', '代理商保修', '2018-05-23 00:00:00', null, null);
