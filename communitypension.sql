/*
 Navicat Premium Data Transfer

 Source Server         : 123
 Source Server Type    : MySQL
 Source Server Version : 50719
 Source Host           : localhost:3306
 Source Schema         : communitypension

 Target Server Type    : MySQL
 Target Server Version : 50719
 File Encoding         : 65001

 Date: 05/06/2022 07:00:26
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for mainmenu
-- ----------------------------
DROP TABLE IF EXISTS `mainmenu`;
CREATE TABLE `mainmenu`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `path` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 601 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of mainmenu
-- ----------------------------
INSERT INTO `mainmenu` VALUES (100, '用戶管理', '/admin');
INSERT INTO `mainmenu` VALUES (200, '社区管理', '/community');
INSERT INTO `mainmenu` VALUES (300, '健康档案管理', '/files');
INSERT INTO `mainmenu` VALUES (400, '互助管理', '/help');
INSERT INTO `mainmenu` VALUES (500, '健康知识推荐', '/knowledge');
INSERT INTO `mainmenu` VALUES (600, '活动管理', '/active');

-- ----------------------------
-- Table structure for submenu
-- ----------------------------
DROP TABLE IF EXISTS `submenu`;
CREATE TABLE `submenu`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `path` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `mid` int(11) NOT NULL,
  `roleId` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `mid`(`mid`) USING BTREE,
  CONSTRAINT `submenu_ibfk_1` FOREIGN KEY (`mid`) REFERENCES `mainmenu` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 602 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of submenu
-- ----------------------------
INSERT INTO `submenu` VALUES (101, '社区员工列表', '/worker', 100, '1');
INSERT INTO `submenu` VALUES (102, '监护人列表', '/user', 100, '12');
INSERT INTO `submenu` VALUES (103, '老人列表', '/older', 100, '14');
INSERT INTO `submenu` VALUES (201, '社区管理', '/community', 200, '1');
INSERT INTO `submenu` VALUES (301, '健康档案管理', '/files', 300, '24');
INSERT INTO `submenu` VALUES (302, '健康数据检测', '/healthyData', 300, '24');
INSERT INTO `submenu` VALUES (401, '医疗互助', '/medicine', 400, '1234');
INSERT INTO `submenu` VALUES (402, '代购互助', '/shop', 400, '134');
INSERT INTO `submenu` VALUES (403, '餐饮互助', '/food', 400, '134');
INSERT INTO `submenu` VALUES (501, '健康知识推荐', '/knowledge', 500, '1234');
INSERT INTO `submenu` VALUES (601, '活动管理', '/active', 600, '14');

-- ----------------------------
-- Table structure for tb_actives
-- ----------------------------
DROP TABLE IF EXISTS `tb_actives`;
CREATE TABLE `tb_actives`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `active_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '活动名称',
  `active_time` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '活动开始时间',
  `duration` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '时长',
  `active_area` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '活动地点',
  `active_style` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '活动形式',
  `create_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '活动创建人',
  `active_number` int(11) NULL DEFAULT NULL COMMENT '活动人数',
  `del_flag` int(10) UNSIGNED NULL DEFAULT NULL COMMENT '是否删除',
  `createId` int(11) NULL DEFAULT NULL COMMENT '创建Id',
  `createtime` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `updateId` int(11) NULL DEFAULT NULL COMMENT '修改Id',
  `updatetime` datetime NULL DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 10 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of tb_actives
-- ----------------------------
INSERT INTO `tb_actives` VALUES (1, '广场舞', '2022/04/23 18:30:00', '3', '小区广场', '一起跳舞', '管理员', 1, 0, 1, '2022-04-21 20:42:08', 1, '2022-05-13 09:58:56');
INSERT INTO `tb_actives` VALUES (2, '麻将', '2022-04-23 05:00:00', '5', '小区大厅', '四人一组打麻将', '管理员', 1, 0, 1, '2022-04-22 22:34:12', NULL, NULL);
INSERT INTO `tb_actives` VALUES (3, '象棋', '2022-04-25 01:00:00', '2.5', '小区二楼', '双人Pk争霸', '管理员', 2, 0, 1, '2022-04-22 22:38:35', 1, '2022-04-22 23:17:45');
INSERT INTO `tb_actives` VALUES (4, '老年交谊舞', '2022-04-29 05:00:00', '2', '小区广场', '一男一女一起跳舞', '管理员', 1, 0, 1, '2022-04-22 23:02:51', NULL, NULL);
INSERT INTO `tb_actives` VALUES (5, '掼蛋', '2022/04/27 08:00:00', '5', '小区大厅', '四人一桌，两人一队', '管理员', 1, 0, 1, '2022-04-27 15:08:06', 1, '2022-05-13 12:52:35');
INSERT INTO `tb_actives` VALUES (6, '听书会', '2022-04-30 05:00:00', '2', '小区广场', '上台讲故事', '管理员', 1, 0, 1, '2022-04-29 14:21:57', NULL, NULL);
INSERT INTO `tb_actives` VALUES (7, '围棋比赛', '2022-05-19 06:00:00', '3', '小区大厅二楼', '两人一组比赛，淘汰制。', '管理员', 1, 0, 1, '2022-05-13 09:42:04', 1, '2022-05-13 09:47:24');
INSERT INTO `tb_actives` VALUES (8, '社区老年活动庆典', '2022/05/25 17:00:00', '2', '小区广场', '广场举行活动开幕式', '管理员', 1, 0, 1, '2022-05-13 09:52:31', NULL, NULL);
INSERT INTO `tb_actives` VALUES (9, '老年广播操', '2022/05/24 09:00:00', '2', '小区广场', '集体跳操', '管理员', 1, 0, 1, '2022-05-13 09:58:25', 1, '2022-05-13 09:59:16');

-- ----------------------------
-- Table structure for tb_appointment
-- ----------------------------
DROP TABLE IF EXISTS `tb_appointment`;
CREATE TABLE `tb_appointment`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `appointNo` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '预约单号',
  `hospitalName` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '医院',
  `doctorId` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '医生',
  `departmentId` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '科室',
  `appointTime` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '预约时间',
  `price` decimal(10, 2) NULL DEFAULT NULL COMMENT '门诊费',
  `del_flag` int(11) NULL DEFAULT NULL COMMENT '是否删除0，1删除',
  `createId` int(11) NULL DEFAULT NULL COMMENT '创建Id',
  `createtime` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `updateId` int(11) NULL DEFAULT NULL COMMENT '修改Id',
  `updatetime` datetime NULL DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of tb_appointment
-- ----------------------------
INSERT INTO `tb_appointment` VALUES (1, 'YY49768087', '苏州大学附属独墅湖医院', '4', '2', '2022/05/21 09:00:00', 12.00, 0, 1, '2022-05-13 13:24:47', 1, '2022-05-16 00:43:24');
INSERT INTO `tb_appointment` VALUES (2, 'YY69419594', '苏州市立医院', '5', '1', '2022/05/19 09:00', 12.00, 0, 2, '2022-05-16 16:25:30', NULL, NULL);
INSERT INTO `tb_appointment` VALUES (3, 'YY33427050', '九龙医院', '8', '6', '2022/05/26 06:30', 12.00, 0, 1, '2022-05-20 13:12:16', NULL, NULL);

-- ----------------------------
-- Table structure for tb_assess
-- ----------------------------
DROP TABLE IF EXISTS `tb_assess`;
CREATE TABLE `tb_assess`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `assess` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '评价：1：极差，2：失望，3：一般，4：满意，5：惊喜',
  `createName` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '评估人',
  `createTime` datetime NULL DEFAULT NULL COMMENT '评估时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 10 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of tb_assess
-- ----------------------------
INSERT INTO `tb_assess` VALUES (1, '4', '徐医生', '2022-04-29 16:43:20');
INSERT INTO `tb_assess` VALUES (2, '5', '超级管理员', '2022-04-29 16:46:01');
INSERT INTO `tb_assess` VALUES (3, '5', '闵某', '2022-04-29 16:48:17');
INSERT INTO `tb_assess` VALUES (4, '2', '叶某', '2022-04-29 16:57:44');
INSERT INTO `tb_assess` VALUES (5, '3', '羽生', '2022-04-29 17:04:53');
INSERT INTO `tb_assess` VALUES (6, '5', '徐某', '2022-04-29 17:34:27');
INSERT INTO `tb_assess` VALUES (7, '1', '顾某', '2022-04-29 17:37:15');
INSERT INTO `tb_assess` VALUES (8, '1', '风某', '2022-05-02 16:14:37');
INSERT INTO `tb_assess` VALUES (9, '3', '华某', '2022-05-02 19:16:15');

-- ----------------------------
-- Table structure for tb_communities
-- ----------------------------
DROP TABLE IF EXISTS `tb_communities`;
CREATE TABLE `tb_communities`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `community_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '社区名称',
  `community_code` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '社区编号',
  `community_place` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '社区位置',
  `community_area` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '社区面积',
  `people_number` int(11) NULL DEFAULT NULL COMMENT '社区人数',
  `old_number` int(11) NULL DEFAULT NULL COMMENT '老年人数量',
  `state` tinyint(4) NULL DEFAULT 0 COMMENT '状态，1：正常，0：失效',
  `del_flag` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '是否删除，0正常，1删除',
  `createId` int(11) NULL DEFAULT NULL COMMENT '创建Id',
  `createtime` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `updateId` int(11) NULL DEFAULT NULL COMMENT '修改Id',
  `updatetime` datetime NULL DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of tb_communities
-- ----------------------------
INSERT INTO `tb_communities` VALUES (1, '社区A', '001', '苏州园区松涛街867号', '45000', 5000, 1200, 1, '0', 1, '2022-03-26 11:08:49', 1, '2022-05-18 11:39:57');
INSERT INTO `tb_communities` VALUES (2, '社区B', '002', '苏州园区现代大道227号', '70000', 7000, 2500, 1, '0', 1, '2022-03-26 11:10:00', 1, '2022-05-19 11:26:00');
INSERT INTO `tb_communities` VALUES (3, '社区C', '003', '苏州园区钟园路129号', '57000', 8500, 3800, 1, '0', 1, '2022-03-01 11:13:52', 1, '2022-05-18 11:40:09');
INSERT INTO `tb_communities` VALUES (4, '社区D', '004', '苏州吴中区斜塘街道886号', '62000', 7800, 2300, 1, '0', 1, '2022-03-26 11:16:17', 1, '2022-05-18 12:54:57');
INSERT INTO `tb_communities` VALUES (5, '社区E', '005', '苏州园区星湖街234号', '77000', 9800, 4100, 1, '0', 1, '2022-03-26 11:17:16', 1, '2022-05-19 11:25:58');
INSERT INTO `tb_communities` VALUES (6, '社区F', '006', '苏州吴中区玲珑街1号', '850000', 7000, 1200, 1, '0', 1, '2022-04-06 10:03:22', 1, '2022-05-18 11:39:50');

-- ----------------------------
-- Table structure for tb_communityrestaurant
-- ----------------------------
DROP TABLE IF EXISTS `tb_communityrestaurant`;
CREATE TABLE `tb_communityrestaurant`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `communityCd` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '社区编号',
  `restaurant` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '餐厅',
  `del_flag` int(10) UNSIGNED NULL DEFAULT NULL COMMENT '是否删除',
  `createId` int(11) NULL DEFAULT NULL COMMENT '创建Id',
  `createtime` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `updateId` int(11) NULL DEFAULT NULL COMMENT '修改Id',
  `updatetime` datetime NULL DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 12 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tb_communityrestaurant
-- ----------------------------
INSERT INTO `tb_communityrestaurant` VALUES (7, '001', '嘉园餐厅', 0, 1, '2022-05-21 16:15:47', NULL, NULL);
INSERT INTO `tb_communityrestaurant` VALUES (8, '002', '乾元餐馆', 0, 1, '2022-05-21 16:16:49', NULL, NULL);
INSERT INTO `tb_communityrestaurant` VALUES (9, '001', '风味餐厅', 0, 1, '2022-05-21 16:17:07', NULL, NULL);
INSERT INTO `tb_communityrestaurant` VALUES (10, '001', 'adad', 0, 1, '2022-05-24 19:01:54', NULL, NULL);
INSERT INTO `tb_communityrestaurant` VALUES (11, '001', 'add', 0, 1, '2022-05-24 19:02:06', NULL, NULL);

-- ----------------------------
-- Table structure for tb_department
-- ----------------------------
DROP TABLE IF EXISTS `tb_department`;
CREATE TABLE `tb_department`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `departmentName` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '科室名称',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 14 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of tb_department
-- ----------------------------
INSERT INTO `tb_department` VALUES (1, '神经内科');
INSERT INTO `tb_department` VALUES (2, '消化内科');
INSERT INTO `tb_department` VALUES (3, '呼吸内科');
INSERT INTO `tb_department` VALUES (4, '内科');
INSERT INTO `tb_department` VALUES (5, '神经外科');
INSERT INTO `tb_department` VALUES (6, '妇科');
INSERT INTO `tb_department` VALUES (7, '产科');
INSERT INTO `tb_department` VALUES (8, '儿科');
INSERT INTO `tb_department` VALUES (9, '皮肤科');
INSERT INTO `tb_department` VALUES (10, '耳鼻喉科');
INSERT INTO `tb_department` VALUES (11, '眼科');
INSERT INTO `tb_department` VALUES (12, '口腔科');
INSERT INTO `tb_department` VALUES (13, '急诊科');

-- ----------------------------
-- Table structure for tb_doctor
-- ----------------------------
DROP TABLE IF EXISTS `tb_doctor`;
CREATE TABLE `tb_doctor`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `doctor` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '医生名称',
  `hospitalId` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '组织编号',
  `departmentId` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '科室编号',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of tb_doctor
-- ----------------------------
INSERT INTO `tb_doctor` VALUES (1, '徐医生', '3', '5');
INSERT INTO `tb_doctor` VALUES (2, '沈医生', '1', '2');
INSERT INTO `tb_doctor` VALUES (3, '秦医生', '2', '4');
INSERT INTO `tb_doctor` VALUES (4, '王医生', '1', '2');
INSERT INTO `tb_doctor` VALUES (5, '李医生', '3', '1');
INSERT INTO `tb_doctor` VALUES (6, '夏医生', '3', '4');
INSERT INTO `tb_doctor` VALUES (7, '陈医生', '3', '6');
INSERT INTO `tb_doctor` VALUES (8, '赵医生', '2', '6');

-- ----------------------------
-- Table structure for tb_drug
-- ----------------------------
DROP TABLE IF EXISTS `tb_drug`;
CREATE TABLE `tb_drug`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `pharmacy_id` int(11) NULL DEFAULT NULL COMMENT '药店ID',
  `drugName` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '药名',
  `photo` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '图片',
  `drugNumber` int(11) NULL DEFAULT NULL COMMENT '药存量',
  `unit` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '药量单位',
  `price` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '药价',
  `termOfValidity` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '有效期',
  `explain` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '说明',
  `drugTypeId` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '药类',
  `del_flag` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '是否删除，0正常，1删除',
  `createId` int(11) NULL DEFAULT NULL COMMENT '创建Id',
  `createtime` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `updateId` int(11) NULL DEFAULT NULL COMMENT '修改Id',
  `updatetime` datetime NULL DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of tb_drug
-- ----------------------------
INSERT INTO `tb_drug` VALUES (1, 1, '999感冒灵颗粒', 'assets/999ganmao.jpg', 200, '10g*9袋/盒', '9.5', '24个月', '开水冲服，一次1袋，一日3次', '1', '0', 1, '2022-05-10 10:24:39', NULL, NULL);
INSERT INTO `tb_drug` VALUES (2, 1, '云南白药气雾剂', 'assets/yunnan.jpg', 300, '145g', '78.2', '36个月', '外用。喷于伤患处', '2', '0', 1, '2022-05-10 10:28:07', NULL, NULL);
INSERT INTO `tb_drug` VALUES (3, 1, '青原感冒灵胶囊', 'assets/999ganmao.jpg', 500, '0.5g*12粒*3板/盒', '21.5', '24个月', '口服，一次2粒，一日3次', '1', '0', 1, '2022-05-10 14:14:45', NULL, NULL);
INSERT INTO `tb_drug` VALUES (4, 1, '邦迪创口贴', 'assets/bangdi.jpg', 300, '70mm*22mm*10片/盒', '10.63', '36个月', '贴在伤口上', '2', '0', 1, '2022-05-10 23:24:24', NULL, NULL);
INSERT INTO `tb_drug` VALUES (5, 1, '三九胃泰温胃舒颗粒', 'assets/39weitai.jpg', 200, '10g*10袋/盒', '32', '36个月', '开水冲服，一次1-2袋，一日2次', '4', '0', 1, '2022-05-10 23:34:33', NULL, NULL);
INSERT INTO `tb_drug` VALUES (6, 2, '三九胃泰温胃舒颗粒', 'assets/39weitai.jpg', 140, '10g*10袋/盒', '31', '36个月', '开水冲服，一次1-2袋，一日2次', '4', '0', 1, '2022-05-10 23:38:59', NULL, NULL);
INSERT INTO `tb_drug` VALUES (7, 2, '云南白药气雾剂', 'assets/yunnan.jpg', 70, '145g', '79', '36个月', '外用。喷于伤患处', '2', '0', 1, '2022-05-10 23:41:29', NULL, NULL);

-- ----------------------------
-- Table structure for tb_drugtype
-- ----------------------------
DROP TABLE IF EXISTS `tb_drugtype`;
CREATE TABLE `tb_drugtype`  (
  `id` int(11) NOT NULL COMMENT '主键ID',
  `drugType` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '药品类型'
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of tb_drugtype
-- ----------------------------
INSERT INTO `tb_drugtype` VALUES (1, '感冒药');
INSERT INTO `tb_drugtype` VALUES (2, '外用药');
INSERT INTO `tb_drugtype` VALUES (3, '皮肤病用药');
INSERT INTO `tb_drugtype` VALUES (4, '消化系统');
INSERT INTO `tb_drugtype` VALUES (5, '儿童用药');
INSERT INTO `tb_drugtype` VALUES (6, '维生素');
INSERT INTO `tb_drugtype` VALUES (7, '风湿骨痛用药');
INSERT INTO `tb_drugtype` VALUES (8, '慢性病用药');
INSERT INTO `tb_drugtype` VALUES (9, '其他');

-- ----------------------------
-- Table structure for tb_food
-- ----------------------------
DROP TABLE IF EXISTS `tb_food`;
CREATE TABLE `tb_food`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `communityCd` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '社区编号',
  `restaurant` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '餐厅名称',
  `foodName` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '菜名',
  `foodImgUrl` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '图片',
  `foodPrice` decimal(10, 2) UNSIGNED ZEROFILL NULL DEFAULT NULL COMMENT '菜价',
  `del_flag` int(10) UNSIGNED NULL DEFAULT NULL COMMENT '是否删除',
  `createId` int(11) NULL DEFAULT NULL COMMENT '创建Id',
  `createtime` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `updateId` int(11) NULL DEFAULT NULL COMMENT '修改Id',
  `updatetime` datetime NULL DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tb_food
-- ----------------------------
INSERT INTO `tb_food` VALUES (5, '001', '嘉园餐厅', '宫保鸡丁', 'assets/gongbaojiding.jpg', 00000017.00, 0, 1, '2022-05-21 17:48:37', NULL, NULL);
INSERT INTO `tb_food` VALUES (6, '001', '嘉园餐厅', '番茄炒鸡蛋', 'assets/fanqiechaojidan.jpg', 00000012.00, 0, 1, '2022-05-21 19:59:11', NULL, NULL);
INSERT INTO `tb_food` VALUES (7, '002', '乾元餐馆', '宫保鸡丁', 'assets/gongbaojiding.jpg', 00000017.00, 0, 1, '2022-05-21 22:40:14', NULL, NULL);

-- ----------------------------
-- Table structure for tb_foodorder
-- ----------------------------
DROP TABLE IF EXISTS `tb_foodorder`;
CREATE TABLE `tb_foodorder`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `foodOrderNo` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '订单号',
  `contactNumber` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '联系号码',
  `orderPerson` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '联系人',
  `address` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '取餐地址',
  `communityRestaurant` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '餐厅',
  `communityId` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '社区编号',
  `foodNames` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '订单内容',
  `foodPrice` decimal(10, 2) NULL DEFAULT NULL COMMENT '价格',
  `orderStatus` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '订单状态',
  `del_flag` int(10) UNSIGNED NULL DEFAULT NULL COMMENT '是否删除',
  `createId` int(11) NULL DEFAULT NULL COMMENT '创建Id',
  `createtime` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `updateId` int(11) NULL DEFAULT NULL COMMENT '修改Id',
  `updatetime` datetime NULL DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 17 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tb_foodorder
-- ----------------------------
INSERT INTO `tb_foodorder` VALUES (1, 'CY59807422', '15951055308', '闵某', NULL, '嘉园餐厅', NULL, 'undefined1份宫保鸡丁2份番茄炒鸡蛋', NULL, '1', 1, NULL, '2022-05-21 21:23:56', 1, '2022-05-21 22:55:29');
INSERT INTO `tb_foodorder` VALUES (2, 'CY75466370', '15951055308', '闵某', NULL, '嘉园餐厅', NULL, 'undefined3份宫保鸡丁', NULL, '1', 1, NULL, '2022-05-21 21:46:29', 2, '2022-05-21 22:37:00');
INSERT INTO `tb_foodorder` VALUES (3, 'CY98725776', '15951055308', '闵某', NULL, '嘉园餐厅', NULL, '3份宫保鸡丁', 0.00, '1', 1, 2, '2022-05-21 21:57:49', 2, '2022-05-21 22:37:03');
INSERT INTO `tb_foodorder` VALUES (4, 'CY91241232', '15951055308', '闵某', NULL, '嘉园餐厅', NULL, '2份番茄炒鸡蛋', 0.00, '1', 1, 2, '2022-05-21 22:11:08', 2, '2022-05-21 22:37:06');
INSERT INTO `tb_foodorder` VALUES (5, 'CY36397718', '15951055308', '闵某', '社区A', '嘉园餐厅', NULL, '2份番茄炒鸡蛋', 0.00, '1', 1, 2, '2022-05-21 22:12:04', 2, '2022-05-21 22:37:09');
INSERT INTO `tb_foodorder` VALUES (6, 'CY39334303', '15951055308', '闵某', '社区A', '嘉园餐厅', NULL, '2份番茄炒鸡蛋', 0.00, '1', 1, 2, '2022-05-21 22:15:35', 2, '2022-05-21 22:37:11');
INSERT INTO `tb_foodorder` VALUES (7, 'CY69091399', '15951055308', '闵某', '社区A', '嘉园餐厅', NULL, '2份宫保鸡丁', 0.00, '1', 1, 2, '2022-05-21 22:16:14', 2, '2022-05-21 22:37:12');
INSERT INTO `tb_foodorder` VALUES (8, 'CY46758817', '15951055308', '闵某', '社区A', '嘉园餐厅', NULL, '2份宫保鸡丁', 0.00, '1', 1, 2, '2022-05-21 22:17:58', 2, '2022-05-21 22:37:14');
INSERT INTO `tb_foodorder` VALUES (9, 'CY66298768', '15951055308', '闵某', '社区A', '嘉园餐厅', NULL, '1份番茄炒鸡蛋', 12.00, '0', 0, 2, '2022-05-21 22:21:21', NULL, NULL);
INSERT INTO `tb_foodorder` VALUES (10, 'CY47161764', '15951055308', '闵某', '社区A', '嘉园餐厅', NULL, '2份番茄炒鸡蛋', 12.00, '2', 0, 2, '2022-05-21 22:21:51', NULL, NULL);
INSERT INTO `tb_foodorder` VALUES (11, 'CY38361236', '15951055308', '闵某', '社区A', '嘉园餐厅', NULL, '2份番茄炒鸡蛋', 24.00, '0', 0, 2, '2022-05-21 22:22:52', NULL, NULL);
INSERT INTO `tb_foodorder` VALUES (12, 'CY6884159', '15951055308', '闵某', '社区A', '嘉园餐厅', NULL, '3份番茄炒鸡蛋', 36.00, '1', 0, 2, '2022-05-21 22:24:28', NULL, NULL);
INSERT INTO `tb_foodorder` VALUES (13, 'CY68227466', '18857765503', '徐某', '社区B', '乾元餐馆', NULL, '2份宫保鸡丁', 34.00, '1', 0, 1, '2022-05-21 22:41:10', NULL, NULL);
INSERT INTO `tb_foodorder` VALUES (14, 'CY83710131', '15951055308', '闵某', '社区A', '嘉园餐厅', NULL, '2份宫保鸡丁3份番茄炒鸡蛋', 70.00, '1', 0, 2, '2022-05-23 22:54:09', NULL, NULL);
INSERT INTO `tb_foodorder` VALUES (15, 'CY60073854', '15951055308', '闵某', '社区A', '嘉园餐厅', NULL, '10份宫保鸡丁', 170.00, '1', 0, 2, '2022-05-24 19:09:58', NULL, NULL);
INSERT INTO `tb_foodorder` VALUES (16, 'CY86276230', '18857765503', '徐某', '社区A', '嘉园餐厅', NULL, '2份番茄炒鸡蛋', 24.00, '1', 0, 1, '2022-06-05 02:33:23', NULL, NULL);

-- ----------------------------
-- Table structure for tb_healthyfiles
-- ----------------------------
DROP TABLE IF EXISTS `tb_healthyfiles`;
CREATE TABLE `tb_healthyfiles`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键Id',
  `older_id` int(11) NOT NULL COMMENT '老人Id',
  `user_id` int(11) NOT NULL COMMENT '监护人Id',
  `height` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '身高m',
  `weight` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '体重kg',
  `nation` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '民族',
  `native_place` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '籍贯',
  `marital_status` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '婚姻：0：未婚，1：已婚，2：离异',
  `work_year` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '工作年限',
  `education_level` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '文化程度：0：文盲，1：小学，2：中学，3：大学，4：硕士，5：博士',
  `career` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '职业',
  `files` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '档案描述',
  `del_flag` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '是否删除，0正常，1删除',
  `createId` int(11) NULL DEFAULT NULL COMMENT '创建Id',
  `createtime` date NULL DEFAULT NULL COMMENT '创建时间',
  `updateId` int(11) NULL DEFAULT NULL COMMENT '修改Id',
  `updatetime` datetime NULL DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 13 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of tb_healthyfiles
-- ----------------------------
INSERT INTO `tb_healthyfiles` VALUES (1, 1, 1, '1.73', '65', '汉族', '苏邮', '1', '25', '2', '自由职业', '一月健康报告', '0', 2, '2022-01-01', 0, '2022-04-29 14:24:36');
INSERT INTO `tb_healthyfiles` VALUES (2, 2, 1, '1.73', '65', '汉族', '扬州', '1', '25', '2', '自由职业', '一月健康报告', '0', 2, '2022-01-01', 0, '2022-05-13 14:26:25');
INSERT INTO `tb_healthyfiles` VALUES (3, 3, 2, '1.71', '61', '汉族', '苏邮', '1', '30', '1', '钢厂工', '一月健康档案', '0', 1, '2022-01-02', 1, NULL);
INSERT INTO `tb_healthyfiles` VALUES (4, 5, 2, '1.58', '62', '布依族', '贵州', '1', '15', '0', '长工', '一月健康档案', '0', 1, '2022-01-07', NULL, NULL);
INSERT INTO `tb_healthyfiles` VALUES (5, 1, 1, '1.73', '64', '汉族', '苏邮', '1', '25', '2', '自由职业', '二月健康档案', '0', 1, '2022-02-01', NULL, NULL);
INSERT INTO `tb_healthyfiles` VALUES (6, 2, 1, '1.66', '65', '汉族', '扬州', '1', '23', '2', '服装员工', '二月健康报告', '0', 1, '2022-02-01', NULL, NULL);
INSERT INTO `tb_healthyfiles` VALUES (7, 3, 2, '1.71', '60', '汉族', '苏邮', '1', '30', '1', '钢厂工', '二月健康档案', '0', 1, '2022-02-01', NULL, NULL);
INSERT INTO `tb_healthyfiles` VALUES (8, 5, 2, '1.58', '62', '布依族', '贵州', '1', '15', '0', '长工', '二月健康报告', '0', 1, '2022-02-01', NULL, NULL);
INSERT INTO `tb_healthyfiles` VALUES (9, 1, 1, '1.73', '65', '汉族', '苏邮', '1', '25', '2', '自由职业', '三月健康报告', '0', 1, '2022-03-01', 1, '2022-04-21 15:03:25');
INSERT INTO `tb_healthyfiles` VALUES (10, 1, 1, '1.73', '67', '汉族', '苏邮', '1', '25', '2', '自由职业', '四月健康档案', '0', 1, '2022-04-01', NULL, NULL);
INSERT INTO `tb_healthyfiles` VALUES (11, 1, 1, '1.73', '66', '汉族', '苏邮', '1', '25', '2', '自由职业', '五月健康档案', '0', 1, '2022-05-01', NULL, NULL);
INSERT INTO `tb_healthyfiles` VALUES (12, 1, 1, '1.73', '62', '汉族', '苏邮', '1', '25', '2', '自由职业', '六月健康报告', '0', 1, '2022-06-01', NULL, NULL);

-- ----------------------------
-- Table structure for tb_hospital
-- ----------------------------
DROP TABLE IF EXISTS `tb_hospital`;
CREATE TABLE `tb_hospital`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `hospitalName` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '医院名称',
  `logo` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '医院logo',
  `address` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '地址',
  `grade` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '级别',
  `registerTime` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '放号时间',
  `del_flag` int(10) UNSIGNED NULL DEFAULT NULL COMMENT '是否删除',
  `createId` int(11) NULL DEFAULT NULL COMMENT '创建Id',
  `createtime` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `updateId` int(11) NULL DEFAULT NULL COMMENT '修改Id',
  `updatetime` datetime NULL DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of tb_hospital
-- ----------------------------
INSERT INTO `tb_hospital` VALUES (1, '苏州大学附属独墅湖医院', 'assets/23176368020632682.jpg', '工业园区', '三级甲等', '09:00', 0, 1, '2022-05-11 16:44:26', NULL, NULL);
INSERT INTO `tb_hospital` VALUES (2, '九龙医院', 'assets/23176410054422867.jpg', '园区万盛街', '私立医院', '06:30', 0, 1, '2022-05-11 17:21:39', NULL, NULL);
INSERT INTO `tb_hospital` VALUES (3, '苏州市立医院', 'assets/23176875181268638.jpg', '吴中区', '三级甲等', '09:00', 0, 1, '2022-05-11 21:37:24', NULL, NULL);
INSERT INTO `tb_hospital` VALUES (4, '苏州市第一人民医院', 'assets/23177084467557645.jpg', '姑苏区平龙路', '三级甲等', '08:30', 0, 1, '2022-05-12 21:16:07', NULL, NULL);

-- ----------------------------
-- Table structure for tb_internal
-- ----------------------------
DROP TABLE IF EXISTS `tb_internal`;
CREATE TABLE `tb_internal`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键Id',
  `older_Id` int(11) NOT NULL COMMENT '老人Id',
  `healthy_Id` int(11) NOT NULL COMMENT '档案Id',
  `heart_rate` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '心率',
  `blood_pressure` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '血压',
  `blood_sugar` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '血糖',
  `blood_fat` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '血脂',
  `pulse` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '脉搏',
  `liver_function` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '肝功能',
  `renal_function` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '肾功能',
  `blood_routine` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '血常规',
  `urinalysis` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '尿常规',
  `work_Id` int(11) NULL DEFAULT NULL COMMENT '医生Id',
  `del_flag` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '是否删除，0正常，1删除',
  `createId` int(11) NULL DEFAULT NULL COMMENT '创建Id',
  `createtime` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `updateId` int(11) NULL DEFAULT NULL COMMENT '修改Id',
  `updatetime` datetime NULL DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 13 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of tb_internal
-- ----------------------------
INSERT INTO `tb_internal` VALUES (1, 1, 1, '70', '90/60', '4.1', '2.6', '70', '正常', '正常', '110', '2', 2, '0', 1, '2022-04-18 15:53:51', 0, '2022-04-29 14:24:36');
INSERT INTO `tb_internal` VALUES (2, 2, 2, '70', '90/60', '4.1', '2.6', '70', '正常', '正常', '110', '2', 2, '0', 1, '2022-04-18 15:55:26', 0, '2022-05-13 14:26:25');
INSERT INTO `tb_internal` VALUES (3, 3, 3, '78', '110/70', '4.2', '2.9', '78', '正常', '正常', '120', '3', 4, '0', 1, '2022-04-19 11:29:02', NULL, NULL);
INSERT INTO `tb_internal` VALUES (4, 5, 4, '88', '110/80', '4.4', '3.6', '88', '正常', '正常', '112', '3.1', 4, '0', 1, '2022-04-19 11:53:29', NULL, NULL);
INSERT INTO `tb_internal` VALUES (5, 1, 5, '74', '96/69', '3.9', '2.7', '70', '正常', '正常', '112', '3', 5, '0', 1, '2022-04-19 22:13:39', NULL, NULL);
INSERT INTO `tb_internal` VALUES (6, 2, 6, '133', '130/78', '5.3', '3.7', '133', '正常', '正常', '135', '5.4', 4, '0', 1, '2022-04-19 22:25:59', NULL, NULL);
INSERT INTO `tb_internal` VALUES (7, 3, 7, '80', '114/68', '4.7', '3.1', '80', '正常', '正常', '124', '3.2', 3, '0', 1, '2022-04-19 22:43:52', NULL, NULL);
INSERT INTO `tb_internal` VALUES (8, 5, 8, '90', '119/67', '4.1', '3.5', '90', '正常', '正常', '118', '3.2', 5, '0', 1, '2022-04-19 22:50:39', NULL, NULL);
INSERT INTO `tb_internal` VALUES (9, 1, 9, '99', '109/68', '4.9', '3.2', '99', '正常', '正常', '123', '3.9', 2, '0', 1, '2022-04-19 23:23:55', 1, '2022-04-21 15:03:25');
INSERT INTO `tb_internal` VALUES (10, 1, 10, '110', '120/99', '4.5', '3.2', '110', '正常', '正常', '122', '3.8', 2, '0', 1, '2022-04-27 11:47:31', NULL, NULL);
INSERT INTO `tb_internal` VALUES (11, 1, 11, '101', '110/70', '4.3', '3.5', '101', '正常', '正常', '113', '3.5', 3, '0', 1, '2022-04-27 13:01:24', NULL, NULL);
INSERT INTO `tb_internal` VALUES (12, 1, 12, '155', '130/66', '3.1', '4.1', '155', '正常', '正常', '116', '3.2', 3, '0', 1, '2022-06-01 17:49:38', NULL, NULL);

-- ----------------------------
-- Table structure for tb_joins
-- ----------------------------
DROP TABLE IF EXISTS `tb_joins`;
CREATE TABLE `tb_joins`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `activeId` int(11) NULL DEFAULT NULL COMMENT '活动Id',
  `joinId` int(11) NULL DEFAULT NULL COMMENT '参与者ID',
  `joinName` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '参加者',
  `joinTime` datetime NULL DEFAULT NULL COMMENT '报名时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 15 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of tb_joins
-- ----------------------------
INSERT INTO `tb_joins` VALUES (1, 1, 2, '闵某', '2022-05-18 17:01:35');
INSERT INTO `tb_joins` VALUES (2, 2, 2, '闵某', '2022-05-18 17:02:41');
INSERT INTO `tb_joins` VALUES (3, 3, 2, '闵某', '2022-05-18 17:02:43');
INSERT INTO `tb_joins` VALUES (4, 4, 2, '闵某', '2022-05-18 17:02:43');
INSERT INTO `tb_joins` VALUES (5, 5, 2, '闵某', '2022-05-18 17:02:44');
INSERT INTO `tb_joins` VALUES (6, 6, 2, '闵某', '2022-05-18 17:02:44');
INSERT INTO `tb_joins` VALUES (7, 7, 2, '闵某', '2022-05-18 17:02:44');
INSERT INTO `tb_joins` VALUES (8, 8, 2, '闵某', '2022-05-18 17:02:45');
INSERT INTO `tb_joins` VALUES (12, 3, 1, '徐某', '2022-05-18 17:09:22');
INSERT INTO `tb_joins` VALUES (14, 9, 2, '闵某', '2022-05-20 17:25:13');

-- ----------------------------
-- Table structure for tb_knowledge
-- ----------------------------
DROP TABLE IF EXISTS `tb_knowledge`;
CREATE TABLE `tb_knowledge`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `book_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '书名',
  `read_number` int(11) NULL DEFAULT NULL COMMENT '阅读量',
  `introduction` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '简介',
  `content` varchar(5000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '内容',
  `style` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '类型0：草稿，1：发布',
  `del_flag` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '是否删除，0正常，1删除',
  `roleId` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '角色Id',
  `create_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '作者名',
  `createId` int(11) NULL DEFAULT NULL COMMENT '创建Id',
  `createtime` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `updateId` int(11) NULL DEFAULT NULL COMMENT '修改Id',
  `updatetime` datetime NULL DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 10 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of tb_knowledge
-- ----------------------------
INSERT INTO `tb_knowledge` VALUES (1, '健康饮食', 13, '关于老年人健康饮食习惯，以及一日三餐食谱推荐。', 'sadasdkahkjh\n\n\n\n\n\n\n', '0', '0', '1', '管理员', 1, '2022-04-21 10:11:55', 1, '2022-04-23 09:44:43');
INSERT INTO `tb_knowledge` VALUES (2, '坚持健康锻炼', 19, '关于老年人健康运动问题，提供了一些适合老年锻炼身体的方法', '坚持锻炼哈哈哈哈\n\n\n\n\n', '0', '0', '1', '管理员', 1, '2022-04-21 12:44:33', 1, '2022-05-05 10:36:26');
INSERT INTO `tb_knowledge` VALUES (3, '《健康中国家庭必备健康生活丛书》', 20, '《健康中国家庭必备健康生活丛书》由钟南山、曾益新、陈君石三大院士领衔“南湘雅北协和”33位资深专家教授耗时3年联手打造。这不再是一套传统意义上的健康丛书,而是承载...', NULL, '1', '0', '1', '管理员', 1, '2022-04-21 16:28:32', NULL, NULL);
INSERT INTO `tb_knowledge` VALUES (4, '《百岁非梦》', 6, ' 本书从大量古今中外老人的长寿资料和作者实地调研的材料出发,向读者证明:人类延长寿命并非梦想,而是有规律可循的。长期以来人们一直追求的“长命百岁”的目的有希望达到。', ' 本书从大量古今中外老人的长寿资料和作者实地调研的材料出发,向读者证明:人类延长寿命并非梦想,而是有规律可循的。长期以来人们一直追求的“长命百岁”的目的有希望达到。', '0', '0', '2', '徐医生', 2, '2022-04-21 17:56:22', 2, '2022-05-18 15:23:45');
INSERT INTO `tb_knowledge` VALUES (5, '《牙医门诊日记》', 7, ' 本书是一位口腔科主任医师的日记随笔,她用个人眼光打量门诊室发生的一切,呈现一个个故事。。', ' 本书是一位口腔科主任医师的日记随笔,她用个人眼光打量门诊室发生的一切,呈现一个个故事。', '1', '0', '2', '徐医生', 2, '2022-04-21 17:58:42', NULL, NULL);
INSERT INTO `tb_knowledge` VALUES (6, '《汪芳说 血管清爽活百岁》', 3, '北京医院心内科主任医师汪芳教授从医近30工作感悟首度结集出版。精准的科学分析、温暖的人文关怀、健康的生活理念。用讲故事的方式以最浅显的语言讲解普通读者最需了解的心血管知识。', '北京医院心内科主任医师汪芳教授从医近30工作感悟首度结集出版。精准的科学分析、温暖的人文关怀、健康的生活理念。用讲故事的方式以最浅显的语言讲解普通读者最需了解的心血管知识。', '1', '0', '2', '王医生', 5, '2022-04-21 18:07:12', NULL, NULL);
INSERT INTO `tb_knowledge` VALUES (7, '《36.5℃决定健康》', 3, '《36.5℃决定健康》为日本著名健康养生专家石原结实所著。书中提到，医学研究表明，体温在正常范围内升高1℃，人体免疫力就会提高5-6倍；相反，体温降低1℃，免疫力下降30%，加速危险细胞生长。', '《36.5℃决定健康》为日本著名健康养生专家石原结实所著。书中提到，医学研究表明，体温在正常范围内升高1℃，人体免疫力就会提高5-6倍；相反，体温降低1℃，免疫力下降30%，加速危险细胞生长.哈哈哈哈哈哈哈哈哈哈\n\n', '1', '0', '2', '王医生', 5, '2022-04-21 18:16:55', 1, '2022-04-22 00:04:35');
INSERT INTO `tb_knowledge` VALUES (8, '《老老恒言》', 6, '老老恒言》又称《养生随笔》，清代著名养生学家、文学家曹庭栋著，是汇集清以前各家养生思想，并结合作者自己的切身体会，总结编纂而成的养生学专著。', '老老恒言》又称《养生随笔》，清代著名养生学家、文学家曹庭栋著，是汇集清以前各家养生思想，并结合作者自己的切身体会，总结编纂而成的养生学专著。分别从饮食起居、精神调摄、运动导引、服药卫生、预防疾病等方面，阐述老年养生的指导思想和具体方法。作者养生理论始终贯穿“ 道贵自然”的思想，主张养生应顺应自然，生活习惯应合四时阴阳，并且紧密结合老年人自身的特点，把养生寓于日常生活琐事之中。全书共5卷，前4 卷涉及饮食起居及日常用品的保健措施。第5卷为粥谱，粥分上、中、下三品。作者非常重视养静和顾护脾胃的重要性，并力推粥食在养生中的重要地位。null\n', '1', '0', '1', '管理员', 1, '2022-04-21 23:22:11', NULL, NULL);
INSERT INTO `tb_knowledge` VALUES (9, '人与自然', 1, '大自然与人类和睦相处、。。。。', '\n大自然与人类和睦相处、亲近大自然\n\n\n\n', '1', '0', '2', '徐医生', 2, '2022-05-18 15:16:00', NULL, NULL);

-- ----------------------------
-- Table structure for tb_medical
-- ----------------------------
DROP TABLE IF EXISTS `tb_medical`;
CREATE TABLE `tb_medical`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `businessNo` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '业务编号',
  `businessType` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '0：买药，1：预约挂号',
  `businessContent` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '业务内容',
  `businessOrganization` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '业务机构',
  `businessStatus` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '0：完成；1：进行中；2：废弃',
  `price` decimal(10, 2) NULL DEFAULT NULL COMMENT '业务费',
  `del_flag` int(11) NULL DEFAULT NULL COMMENT '是否删除0，1删除',
  `createId` int(11) NULL DEFAULT NULL COMMENT '创建Id',
  `createtime` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `updateId` int(11) NULL DEFAULT NULL COMMENT '修改Id',
  `updatetime` datetime NULL DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of tb_medical
-- ----------------------------
INSERT INTO `tb_medical` VALUES (1, 'YY49768087', '1', '2022/05/21 09:00:00在苏州大学附属独墅湖医院预约挂号', '苏州大学附属独墅湖医院', '0', 12.00, 0, 1, '2022-05-16 00:43:24', 5, '2022-06-05 02:22:00');
INSERT INTO `tb_medical` VALUES (2, 'MY5696034', '0', '徐某在富仁大药房买了青原感冒灵胶囊999感冒灵颗粒', '富仁大药房', '2', 31.00, 0, 1, '2022-05-16 16:16:49', 2, '2022-05-18 21:02:42');
INSERT INTO `tb_medical` VALUES (3, 'MY17156733', '0', '闵某在标智药房买了云南白药气雾剂', '标智药房', '2', 78.20, 0, 2, '2022-05-16 16:18:53', 2, '2022-06-05 02:08:50');
INSERT INTO `tb_medical` VALUES (4, 'MY21669975', '0', '闵某在富仁大药房买了三九胃泰温胃舒颗粒云南白药气雾剂', '富仁大药房', '1', 110.20, 0, 2, '2022-05-16 16:23:33', NULL, NULL);
INSERT INTO `tb_medical` VALUES (5, 'YY69419594', '1', '2022/05/19 09:00在苏州市立医院预约挂号', '苏州市立医院', '2', 12.00, 0, 2, '2022-05-16 16:25:30', 2, '2022-05-16 18:31:15');
INSERT INTO `tb_medical` VALUES (6, 'YY33427050', '1', '2022/05/26 06:30在九龙医院预约挂号', '九龙医院', '1', 12.00, 0, 1, '2022-05-20 13:12:16', NULL, NULL);
INSERT INTO `tb_medical` VALUES (7, 'MY29508284', '0', '徐某在富仁大药房买了云南白药气雾剂', '富仁大药房', '0', 78.20, 0, 1, '2022-06-05 02:34:43', 7, '2022-06-05 06:18:57');

-- ----------------------------
-- Table structure for tb_news
-- ----------------------------
DROP TABLE IF EXISTS `tb_news`;
CREATE TABLE `tb_news`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键Id',
  `username` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '用户名',
  `news` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '内容',
  `createtime` datetime NULL DEFAULT NULL COMMENT '发布时间',
  `del_flag` int(11) NULL DEFAULT NULL COMMENT '是否删除0，1删除',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 10 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of tb_news
-- ----------------------------
INSERT INTO `tb_news` VALUES (1, '超级管理员', '哈哈哈', '2022-04-29 13:16:04', 0);
INSERT INTO `tb_news` VALUES (2, '超级管理员', 'hhhhhh', '2022-04-29 13:17:04', 0);
INSERT INTO `tb_news` VALUES (3, '超级管理员', '哎呦我去', '2022-04-29 13:18:03', 0);
INSERT INTO `tb_news` VALUES (4, '徐医生', '我是徐颖', '2022-04-29 13:45:34', 0);
INSERT INTO `tb_news` VALUES (5, '徐医生', '天降异象，剑仙陨落', '2022-04-29 13:54:10', 0);
INSERT INTO `tb_news` VALUES (6, '徐医生', '大王烦烦烦', '2022-04-29 14:03:47', 0);
INSERT INTO `tb_news` VALUES (7, '超级管理员', '关爱老人，共建幸福家园。', '2022-05-03 14:13:16', 0);
INSERT INTO `tb_news` VALUES (8, '超级管理员', '系统升级中。。。。。', '2022-05-09 17:18:12', 0);
INSERT INTO `tb_news` VALUES (9, '闵某', '天干缔造', '2022-06-05 03:31:04', 0);

-- ----------------------------
-- Table structure for tb_older
-- ----------------------------
DROP TABLE IF EXISTS `tb_older`;
CREATE TABLE `tb_older`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键Id',
  `user_Id` int(11) NOT NULL COMMENT '用户主键',
  `older_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '老人姓名',
  `photo` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '图片地址',
  `sex` int(11) NULL DEFAULT NULL COMMENT '性别：0：男1：女',
  `older_age` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '老人年龄',
  `communityCd` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '所在社区Id',
  `medical_history` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '病史',
  `birthday` date NULL DEFAULT NULL COMMENT '出生日期',
  `state` tinyint(4) NOT NULL DEFAULT 0 COMMENT '状态，0：正常，1：失效',
  `del_flag` int(10) UNSIGNED NULL DEFAULT NULL COMMENT '是否删除',
  `createId` int(11) NULL DEFAULT NULL COMMENT '创建Id',
  `createtime` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `updateId` int(11) NULL DEFAULT NULL COMMENT '修改Id',
  `updatetime` datetime NULL DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 20 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of tb_older
-- ----------------------------
INSERT INTO `tb_older` VALUES (1, 1, '徐老', 'assets/sportlogo.jpg', 0, '59', '003', '无', '1963-02-19', 1, 0, 1, '2022-04-07 09:43:11', 0, '2022-04-29 14:24:36');
INSERT INTO `tb_older` VALUES (2, 1, '李老', 'assets/sportback.jpg', 1, '59', '001', '血糖高，血脂高', '1967-02-19', 1, 0, 1, '2022-04-07 21:24:04', 0, '2022-05-13 14:26:25');
INSERT INTO `tb_older` VALUES (3, 2, '闵老', 'common/community.jpg', 0, '58', '001', '风湿性关节炎', '1964-04-14', 1, 0, 1, '2022-04-22 00:59:38', 1, '2022-04-23 09:35:57');
INSERT INTO `tb_older` VALUES (5, 2, '杨老', 'assets/sportlogo.jpg', 1, '48', '001', '结石', '1974-03-14', 1, 0, 1, '2022-04-11 11:40:44', 1, '2022-05-06 16:04:33');
INSERT INTO `tb_older` VALUES (6, 5, '顾老', 'assets/sportlogo.jpg', 0, '59', '003', '无', '1963-03-21', 1, 0, 1, '2022-04-21 09:57:09', 1, '2022-05-06 16:28:33');
INSERT INTO `tb_older` VALUES (7, 6, '风老', 'assets/sportlogo.jpg', 0, '68', '002', '高血压', '1954-02-01', 1, 0, 1, '2022-04-29 10:34:31', 1, '2022-05-06 16:28:33');
INSERT INTO `tb_older` VALUES (8, 7, '李老', 'assets/sportlogo.jpg', 0, '72', '006', '无', '1950-02-01', 0, 0, 1, '2022-05-06 15:15:07', NULL, '2022-05-06 15:15:20');
INSERT INTO `tb_older` VALUES (9, 4, '叶老', 'assets/sportlogo.jpg', 0, '66', '004', '无', '1956-08-23', 0, 0, 1, '2022-05-06 15:28:02', 1, '2022-05-06 15:28:02');
INSERT INTO `tb_older` VALUES (10, 18, '江老', 'assets/sportlogo.jpg', 1, '55', '001', '无', '1967-05-15', 0, 0, 1, '2022-05-06 15:31:20', 1, '2022-05-06 15:31:20');
INSERT INTO `tb_older` VALUES (11, 20, '易老', 'assets/sportlogo.jpg', 0, '54', '003', '无', '1968-04-13', 1, 0, 1, '2022-05-06 17:16:05', 1, '2022-05-09 13:08:23');
INSERT INTO `tb_older` VALUES (12, 12, '韩老', 'assets/xupopo.jpg', 0, '61', '002', '无', '1961-10-25', 1, 0, 1, '2022-05-09 09:28:07', 1, '2022-05-09 09:47:50');
INSERT INTO `tb_older` VALUES (13, 12, '王老', 'assets/xupopo.jpg', 1, '56', '004', '无', '1966-07-09', 1, 0, 1, '2022-05-09 09:48:38', 1, '2022-05-09 13:08:19');
INSERT INTO `tb_older` VALUES (14, 2, '钱老', 'assets/xupopo.jpg', 1, '56', '002', '无', '1966-12-19', 0, 0, 1, '2022-05-09 10:02:29', 1, '2022-05-09 10:02:29');
INSERT INTO `tb_older` VALUES (15, 19, '赵老', 'assets/xupopo.jpg', 0, '61', '003', '无', '1961-06-05', 1, 0, 1, '2022-05-09 10:07:20', 1, '2022-05-09 13:08:18');
INSERT INTO `tb_older` VALUES (16, 12, '郑老', 'assets/boy.jpg', 0, '52', '002', '无', '1970-05-04', 1, 0, 1, '2022-05-09 13:01:10', 1, '2022-05-09 13:08:17');
INSERT INTO `tb_older` VALUES (17, 14, '天老', 'assets/boy.jpg', 0, '52', '001', '无', '1970-05-05', 1, 0, 1, '2022-05-09 13:04:33', 1, '2022-05-09 13:08:17');
INSERT INTO `tb_older` VALUES (18, 11, '曹老', 'assets/xupopo.jpg', 1, '51', '003', '无', '1971-10-13', 0, 0, 1, '2022-05-09 13:12:38', 1, '2022-05-09 13:12:38');
INSERT INTO `tb_older` VALUES (19, 11, '张老', 'assets/xupopo.jpg', 1, '47', '005', '无', '1975-06-02', 0, 0, 1, '2022-05-09 13:15:05', 1, '2022-05-09 13:15:05');

-- ----------------------------
-- Table structure for tb_order
-- ----------------------------
DROP TABLE IF EXISTS `tb_order`;
CREATE TABLE `tb_order`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `goodsId` int(11) NULL DEFAULT NULL COMMENT '商品Id',
  `orderNo` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '订单编号',
  `shopName` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '商家',
  `imgUrl` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '图片地址',
  `goodsName` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '商品名称',
  `orderPrice` decimal(10, 2) NULL DEFAULT NULL COMMENT '价格',
  `orderNumber` int(11) NULL DEFAULT NULL COMMENT '商品下单数量',
  `orderStatus` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '订单状态，0：完成，1：进行中，2：废弃',
  `del_flag` int(11) NULL DEFAULT NULL COMMENT '是否删除0，1删除',
  `createId` int(11) NULL DEFAULT NULL COMMENT '创建Id',
  `createtime` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `updateId` int(11) NULL DEFAULT NULL COMMENT '修改Id',
  `updatetime` datetime NULL DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of tb_order
-- ----------------------------
INSERT INTO `tb_order` VALUES (2, 1, 'SP15097472', '京东', 'assets/niunai.jpg', '伊利纯牛奶', 46.90, 5, '0', 0, 2, '2022-05-19 22:35:35', NULL, NULL);
INSERT INTO `tb_order` VALUES (3, 2, 'SP64898548', '京东', 'assets/shuiguo.jpg', '新疆库尔勒香梨', 58.80, 4, '0', 0, 2, '2022-05-19 22:35:35', NULL, NULL);
INSERT INTO `tb_order` VALUES (6, 3, 'SP43480763', '京东', 'assets/yangcong.jpg', '紫洋葱', 21.90, 2, '0', 0, 3, '2022-05-20 16:49:23', NULL, NULL);
INSERT INTO `tb_order` VALUES (7, 4, 'SP80873021', '京东', 'assets/fanqie.jpg', '云南硬粉番茄', 24.90, 1, '1', 0, 3, '2022-05-20 16:51:53', NULL, NULL);

-- ----------------------------
-- Table structure for tb_ordercustomer
-- ----------------------------
DROP TABLE IF EXISTS `tb_ordercustomer`;
CREATE TABLE `tb_ordercustomer`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `orderNo` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '订单编号',
  `userId` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '用户Id',
  `orderCustomer` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '用户名称',
  `orderTime` datetime NULL DEFAULT NULL COMMENT '下单时间',
  `number` int(11) NULL DEFAULT NULL COMMENT '下单数量',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 14 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of tb_ordercustomer
-- ----------------------------
INSERT INTO `tb_ordercustomer` VALUES (3, 'SP15097472', '2', '闵某', '2022-05-19 22:35:35', 2);
INSERT INTO `tb_ordercustomer` VALUES (4, 'SP64898548', '2', '闵某', '2022-05-19 22:35:35', 1);
INSERT INTO `tb_ordercustomer` VALUES (7, 'SP15097472', '1', '徐某', '2022-05-20 14:00:27', 1);
INSERT INTO `tb_ordercustomer` VALUES (8, 'SP64898548', '1', '徐某', '2022-05-20 14:06:27', 2);
INSERT INTO `tb_ordercustomer` VALUES (9, 'SP15097472', '3', '羽生', '2022-05-20 14:10:15', 1);
INSERT INTO `tb_ordercustomer` VALUES (10, 'SP64898548', '3', '羽生', '2022-05-20 14:17:40', 1);
INSERT INTO `tb_ordercustomer` VALUES (11, 'SP43480763', '3', '羽生', '2022-05-20 16:49:23', 1);
INSERT INTO `tb_ordercustomer` VALUES (12, 'SP80873021', '3', '羽生', '2022-05-20 16:51:53', 1);
INSERT INTO `tb_ordercustomer` VALUES (13, 'SP15097472', '1', '徐某', '2022-06-05 02:33:53', 1);

-- ----------------------------
-- Table structure for tb_pharmacy
-- ----------------------------
DROP TABLE IF EXISTS `tb_pharmacy`;
CREATE TABLE `tb_pharmacy`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '药店名称',
  `photo` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '照片地址',
  `address` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '药店地址',
  `value` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '药店评分',
  `monthlySale` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '月售',
  `startDelivery` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '起送费',
  `delivery` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '有无配送费',
  `distance` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '配送距离',
  `deliveryTime` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '配送时间',
  `del_flag` int(10) UNSIGNED NULL DEFAULT NULL COMMENT '是否删除',
  `createId` int(11) NULL DEFAULT NULL COMMENT '创建Id',
  `createtime` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `updateId` int(11) NULL DEFAULT NULL COMMENT '修改Id',
  `updatetime` datetime NULL DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of tb_pharmacy
-- ----------------------------
INSERT INTO `tb_pharmacy` VALUES (1, '富仁大药房', 'assets/furen.jpg', '车坊普惠路店', '4.2', '1563', '20', '免配送费', '3.5', '25', 0, 1, '2022-05-06 10:57:26', NULL, NULL);
INSERT INTO `tb_pharmacy` VALUES (2, '标智药房', 'assets/biaozhi.jpg', '莲花店', '4.5', '1688', '22', '2元配送费', '4.8', '35', 0, 1, '2022-05-06 12:51:53', NULL, NULL);
INSERT INTO `tb_pharmacy` VALUES (3, '君钰康大药房', 'assets/junyu.jpg', '东沙湖邻里中心店', '5', '0', '20', '免配送费', '3.6', '30', 0, 1, '2022-05-09 14:38:05', NULL, NULL);
INSERT INTO `tb_pharmacy` VALUES (4, '连旺大药房', 'assets/lianwang.jpg', '独墅湖店', '5', '0', '25', '5元配送费', '3.6', '30', 0, 1, '2022-05-09 14:40:27', NULL, NULL);
INSERT INTO `tb_pharmacy` VALUES (5, '康华大药房', 'assets/kanghua.jpg', '玲珑街店', '5', '0', '20', '3元配送费', '3.6', '30', 0, 1, '2022-05-10 17:00:56', NULL, NULL);

-- ----------------------------
-- Table structure for tb_role
-- ----------------------------
DROP TABLE IF EXISTS `tb_role`;
CREATE TABLE `tb_role`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主鍵Id',
  `role` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '角色',
  `roleId` int(11) NULL DEFAULT NULL COMMENT '関連easyuser表',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of tb_role
-- ----------------------------
INSERT INTO `tb_role` VALUES (1, '管理員', 1);
INSERT INTO `tb_role` VALUES (2, '医生', 2);
INSERT INTO `tb_role` VALUES (3, '员工', 3);
INSERT INTO `tb_role` VALUES (4, '监护人', 4);

-- ----------------------------
-- Table structure for tb_shopmall
-- ----------------------------
DROP TABLE IF EXISTS `tb_shopmall`;
CREATE TABLE `tb_shopmall`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `goodsName` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '商品名称',
  `goodsImgUrl` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '图片地址',
  `goodsUnit` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '商品单位',
  `goodsPrice` decimal(10, 2) NULL DEFAULT NULL COMMENT '商品单价',
  `shopName` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '商家',
  `qualityGuarantee` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '保质期',
  `stock` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '存量',
  `del_flag` int(10) UNSIGNED NULL DEFAULT NULL COMMENT '是否删除',
  `createId` int(11) NULL DEFAULT NULL COMMENT '创建Id',
  `createtime` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `updateId` int(11) NULL DEFAULT NULL COMMENT '修改Id',
  `updatetime` datetime NULL DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of tb_shopmall
-- ----------------------------
INSERT INTO `tb_shopmall` VALUES (1, '伊利纯牛奶', 'assets/niunai.jpg', '250ml*16', 46.90, '京东', '12个月', '195', 0, 1, '2022-05-19 14:40:23', 1, '2022-05-19 16:01:45');
INSERT INTO `tb_shopmall` VALUES (2, '新疆库尔勒香梨', 'assets/shuiguo.jpg', '2.5kg', 58.80, '京东', '12个月', '226', 0, 1, '2022-05-19 15:44:47', NULL, NULL);
INSERT INTO `tb_shopmall` VALUES (3, '紫洋葱', 'assets/yangcong.jpg', '1kg', 21.90, '京东', '1个月', '48', 0, 1, '2022-05-20 14:21:19', NULL, NULL);
INSERT INTO `tb_shopmall` VALUES (4, '云南硬粉番茄', 'assets/fanqie.jpg', '1.25kg', 24.90, '京东', '15天', '149', 0, 1, '2022-05-20 14:26:49', NULL, NULL);
INSERT INTO `tb_shopmall` VALUES (5, '黑猪五花肉', 'assets/lengxianrou.jpg', '248g', 56.90, '京东', '20天', '30', 0, 1, '2022-05-20 14:31:13', 1, '2022-05-20 14:39:37');

-- ----------------------------
-- Table structure for tb_surgery
-- ----------------------------
DROP TABLE IF EXISTS `tb_surgery`;
CREATE TABLE `tb_surgery`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键Id',
  `healthy_Id` int(11) NOT NULL COMMENT '档案Id',
  `older_Id` int(11) NOT NULL COMMENT '老人Id',
  `skin` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '皮肤',
  `lymph` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '淋巴',
  `thyroid` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '甲状腺',
  `spine` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '脊柱',
  `limb` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '四肢',
  `joint` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '关节',
  `head` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '头部',
  `eye` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '眼睛',
  `ears` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '耳朵',
  `nose` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '鼻子',
  `oral_cavity` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '口腔',
  `throat` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '咽喉',
  `work_Id` int(11) NULL DEFAULT NULL COMMENT '医生Id',
  `del_flag` int(10) UNSIGNED NULL DEFAULT NULL COMMENT '是否删除',
  `createId` int(11) NULL DEFAULT NULL COMMENT '创建Id',
  `createtime` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `updateId` int(11) NULL DEFAULT NULL COMMENT '修改Id',
  `updatetime` datetime NULL DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 13 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of tb_surgery
-- ----------------------------
INSERT INTO `tb_surgery` VALUES (1, 1, 1, '正常', '正常', '正常', '略微向右弯曲', '正常', '微肿', '正常', '红血丝，过于疲劳', '正常', '发炎', '舌苔发黄，有蛀牙', '正常', 2, 0, 1, '2022-04-17 21:14:09', 0, '2022-04-29 14:24:36');
INSERT INTO `tb_surgery` VALUES (2, 2, 2, '正常', '正常', '正常', '略微向右弯曲', '正常', '微肿', '正常', '红血丝，过于疲劳', '正常', '发炎', '舌苔发黄，有蛀牙', '正常', 2, 0, 1, '2022-04-17 21:27:54', 0, '2022-05-13 14:26:25');
INSERT INTO `tb_surgery` VALUES (3, 3, 3, '正常', '正常', '正常', '弯曲', '手指，脚趾变形', '肿大', '正常', '正常', '正常', '正常', '牙齿脱落', '正常', 4, 0, 0, '2022-04-19 11:29:02', NULL, NULL);
INSERT INTO `tb_surgery` VALUES (4, 4, 5, '正常', '正常', '正常', '弯曲', '正常', '右腿膝盖有损伤', '正常', '正常', '正常', '正常', '牙齿损坏', '正常', 4, 0, 0, '2022-04-19 11:53:29', NULL, NULL);
INSERT INTO `tb_surgery` VALUES (5, 5, 1, '正常', '正常', '脖子右侧略微发肿', '弯曲', '正常', '正常', '正常', '正常', '右耳耳鸣', '正常', '正常', '正常', 5, 0, 1, '2022-04-19 22:13:39', NULL, NULL);
INSERT INTO `tb_surgery` VALUES (6, 6, 2, '局部皮肤有湿疹', '正常', '正常', '正常', '正常', '右手腕有损伤', '正常', '正常', '正常', '轻微鼻炎', '正常', '正常', 4, 0, 1, '2022-04-19 22:25:59', NULL, NULL);
INSERT INTO `tb_surgery` VALUES (7, 7, 3, '正常', '正常', '正常', '弯曲', '变形', '肿大', '正常', '正常', '正常', '正常', '牙齿脱落', '正常', 3, 0, 1, '2022-04-19 22:43:17', NULL, NULL);
INSERT INTO `tb_surgery` VALUES (8, 8, 5, '正常', '正常', '正常', '弯曲', '正常', '正常', '正常', '红血丝密布', '左耳耳鸣', '轻微鼻炎', '正常', '咽喉发炎', 5, 0, 1, '2022-04-19 22:50:39', NULL, NULL);
INSERT INTO `tb_surgery` VALUES (9, 9, 1, '正常', '正常', '正常', '弯曲', '正常', '正常', '正常', '正常', '正常', '正常', '正常', '正常', 2, 0, 1, '2022-04-19 23:23:52', 1, '2022-04-21 15:03:25');
INSERT INTO `tb_surgery` VALUES (10, 10, 1, '正常', '正常', '正常', '静脉曲张', '正常', '正常', '正常', '正常', '正常', '鼻炎', '口腔溃疡', '正常', 2, 0, 1, '2022-04-27 11:47:31', NULL, NULL);
INSERT INTO `tb_surgery` VALUES (11, 11, 1, '正常', '正常', '脖子肿大', '正常', '正常', '左手腕损伤', '正常', '正常', '正常', '正常', '正常', '正常', 3, 0, 1, '2022-04-27 13:01:24', NULL, NULL);
INSERT INTO `tb_surgery` VALUES (12, 12, 1, '正常', '正常', '正常', '正常', '正常', '肩关节劳损', '正常', '正常', '正常', '鼻炎', '正常', '正常', 3, 0, 1, '2022-05-03 17:49:38', NULL, NULL);

-- ----------------------------
-- Table structure for tb_user
-- ----------------------------
DROP TABLE IF EXISTS `tb_user`;
CREATE TABLE `tb_user`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键Id',
  `username` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '用户姓名',
  `sex` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '性别：0：男，1：女',
  `password` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '密码',
  `phone` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '电话号码',
  `roleId` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '角色',
  `communityCd` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '社区CD',
  `state` tinyint(4) NOT NULL DEFAULT 1 COMMENT '状态，1：正常，0：失效',
  `isAssess` int(11) NULL DEFAULT 0 COMMENT '是否已评价0：否，1：是',
  `del_flag` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '是否删除，0正常，1删除',
  `loginTime` date NULL DEFAULT NULL COMMENT '登录日期',
  `createId` int(11) NULL DEFAULT NULL COMMENT '创建Id',
  `createtime` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `updateId` int(11) NULL DEFAULT NULL COMMENT '修改Id',
  `updatetime` datetime NULL DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 22 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of tb_user
-- ----------------------------
INSERT INTO `tb_user` VALUES (1, '徐某', '1', '123456', '18857765503', '4', '001', 1, 1, '0', '2022-06-04', 1, '2022-03-23 15:15:13', 1, '2022-04-23 11:15:18');
INSERT INTO `tb_user` VALUES (2, '闵某', '0', '123456', '15951055308', '4', '001', 1, 1, '0', '2022-06-05', 1, '2022-03-23 15:31:37', 2, '2022-05-18 10:52:42');
INSERT INTO `tb_user` VALUES (3, '羽生', '0', '123456', '11111111', '4', '002', 1, 1, '0', '2022-06-04', 1, '2022-03-23 15:31:42', 1, '2022-04-02 16:56:04');
INSERT INTO `tb_user` VALUES (4, '叶某', '0', '123456', '222222223', '4', '002', 1, 1, '0', '2022-06-05', 1, '2022-03-23 15:31:51', 1, '2022-03-30 21:16:12');
INSERT INTO `tb_user` VALUES (5, '顾某', '1', '123456', '5555555512', '4', '004', 1, 1, '0', '2022-06-06', 1, '2022-03-23 15:31:56', 2, '2022-05-18 10:52:45');
INSERT INTO `tb_user` VALUES (6, '风某', '0', '123456', '7777777777', '4', '001', 1, 1, '0', '2022-06-07', 1, '2022-03-23 15:32:01', 1, '2022-04-29 10:36:20');
INSERT INTO `tb_user` VALUES (7, '东方', '1', '123456', '66666666', '4', '003', 0, 0, '0', '2022-06-07', 1, '2022-03-23 15:32:05', 2, '2022-05-18 10:52:48');
INSERT INTO `tb_user` VALUES (8, '华某', '0', '123456', '111111112', '4', '005', 0, 1, '0', '2022-06-08', 1, '2022-03-23 15:32:10', 2, '2022-05-18 10:52:48');
INSERT INTO `tb_user` VALUES (9, '古某', '1', '123456', '999999992', '4', '004', 0, 0, '0', '2022-06-09', 1, '2022-03-23 15:32:15', 2, '2022-05-18 10:52:49');
INSERT INTO `tb_user` VALUES (10, '陈某', '1', '123456', '99999999', '4', '005', 0, 0, '1', '2022-06-08', 1, '2022-03-24 16:04:26', 1, '2022-03-30 21:19:24');
INSERT INTO `tb_user` VALUES (11, '刘某', '0', '123456', '88888888', '4', '001', 1, 0, '0', '2022-06-08', 1, '2022-03-24 16:05:12', 1, '2022-03-28 09:28:34');
INSERT INTO `tb_user` VALUES (12, '郑某', '0', '123456', '15151515151', '4', '005', 1, 0, '0', '2022-06-07', 1, '2022-03-30 21:19:05', 1, '2022-03-30 21:26:17');
INSERT INTO `tb_user` VALUES (13, '江某', '1', '123456', '1775126789', '4', '001', 0, 0, '0', '2022-06-06', 1, '2022-03-31 13:12:49', 1, '2022-03-31 13:13:38');
INSERT INTO `tb_user` VALUES (14, '天某', '0', '123456', '18851269705', '4', '002', 1, 0, '0', '2022-06-09', 1, '2022-03-31 13:21:27', 1, '2022-04-06 17:11:24');
INSERT INTO `tb_user` VALUES (15, '无痕', '0', '123456', '19885123', '4', '002', 0, 0, '0', '2022-06-08', 0, '2022-04-22 17:21:17', 0, '2022-04-22 17:21:17');
INSERT INTO `tb_user` VALUES (16, '王道', '0', '123456', '123456789', '4', '003', 0, 0, '0', '2022-06-04', 0, '2022-04-22 17:28:26', 0, '2022-04-22 17:28:26');
INSERT INTO `tb_user` VALUES (17, '风采臣', '0', '123456', '963852741', '4', '003', 0, 0, '0', '2022-06-03', 0, '2022-04-22 17:50:05', 0, '2022-04-22 17:50:05');
INSERT INTO `tb_user` VALUES (18, '胡某', '1', '123456', '17125963', '4', '002', 1, 0, '0', '2022-06-02', 0, '2022-04-22 17:51:26', 0, '2022-04-22 17:51:26');
INSERT INTO `tb_user` VALUES (19, '赵子龙', '0', '123456', '9906121516', '4', '006', 1, 0, '0', '2022-06-02', 0, '2022-04-22 17:56:22', 0, '2022-04-22 17:56:22');
INSERT INTO `tb_user` VALUES (20, '十四', '1', '123456', '555555555', '4', '006', 1, 0, '0', '2022-06-03', 0, '2022-04-22 17:57:36', 0, '2022-04-22 17:57:36');
INSERT INTO `tb_user` VALUES (21, '方羽', '0', '123456', '99176852', '4', '006', 1, 0, '0', '2022-06-09', 1, '2022-04-29 14:56:35', 1, '2022-04-29 14:56:35');

-- ----------------------------
-- Table structure for tb_worker
-- ----------------------------
DROP TABLE IF EXISTS `tb_worker`;
CREATE TABLE `tb_worker`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键Id',
  `workNo` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '登录账号',
  `password` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '密码',
  `workname` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '职工名称',
  `sex` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '性别：0：男，1：女',
  `phone` varchar(11) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '电话号码',
  `roleId` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '角色',
  `state` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '0' COMMENT '状态，0：正常，1：失效',
  `isAssess` int(11) NULL DEFAULT 0 COMMENT '是否已评价0：否，1：是',
  `del_flag` int(11) NULL DEFAULT 0 COMMENT '删除，0：正常，2:   删除',
  `loginTime` date NULL DEFAULT NULL COMMENT '登录日期',
  `createId` int(11) NULL DEFAULT NULL COMMENT '创建Id',
  `createtime` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `updateId` int(11) NULL DEFAULT NULL COMMENT '修改Id',
  `updatetime` datetime NULL DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 20 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of tb_worker
-- ----------------------------
INSERT INTO `tb_worker` VALUES (1, 'admin', 'admin', '管理员', '1', '12345665411', '1', '1', 1, 0, '2022-06-05', 1, '2022-03-07 21:28:06', 1, '2022-06-05 01:20:58');
INSERT INTO `tb_worker` VALUES (2, 'admin1', 'admin1', '徐医生', '0', '18888888', '2', '1', 1, 0, '2022-06-05', 1, '2022-03-07 21:28:06', 2, '2022-06-05 01:21:52');
INSERT INTO `tb_worker` VALUES (3, 'admin2', 'admin', '沈医生', '1', '123456789', '2', '1', 0, 0, '2022-06-03', 1, '2022-03-07 21:28:06', 1, '2022-04-01 10:13:12');
INSERT INTO `tb_worker` VALUES (4, 'admin3', 'admin', '秦医生', '0', '300002222', '2', '1', 0, 0, '2022-06-04', 1, '2022-03-31 09:31:06', 14, '2022-03-31 22:08:44');
INSERT INTO `tb_worker` VALUES (5, 'admin4', 'admin', '王医生', '0', '77777777', '2', '1', 1, 0, '2022-06-02', 1, '2022-03-31 09:35:54', 1, '2022-04-01 10:13:23');
INSERT INTO `tb_worker` VALUES (6, 'admin5', 'admin', '员工1', '0', '11111111', '3', '0', 1, 0, '2022-06-03', 1, '2022-03-31 09:37:12', 1, '2022-04-02 16:56:23');
INSERT INTO `tb_worker` VALUES (7, 'admin6', 'admin', '员工2', '1', '96357801', '3', '1', 0, 0, '2022-06-05', 1, '2022-03-31 09:37:12', 1, '2022-04-02 14:29:55');
INSERT INTO `tb_worker` VALUES (8, 'admin7', 'admin', '员工3', '0', '888888888', '3', '1', 1, 0, '2022-06-06', 1, '2022-03-31 09:37:12', 1, '2022-04-07 21:22:50');
INSERT INTO `tb_worker` VALUES (9, 'admin8', 'admin', '员工4', '0', '122222222', '3', '0', 0, 1, '2022-06-08', 1, '2022-03-31 09:37:12', 1, '2022-05-16 12:54:39');
INSERT INTO `tb_worker` VALUES (10, 'admin9', 'admin', '员工5', '0', '999999999', '3', '0', 0, 0, '2022-06-07', 1, '2022-03-31 09:39:48', 1, '2022-04-01 10:15:26');
INSERT INTO `tb_worker` VALUES (11, 'admin10', 'admin', '员工6', '0', '15951055308', '3', '0', 0, 0, '2022-06-09', 1, '2022-03-31 09:40:34', 1, '2022-04-01 10:15:43');
INSERT INTO `tb_worker` VALUES (12, 'admin11', 'admin', '员工7', '1', '17355308441', '3', '0', 0, 0, '2022-06-08', 1, '2022-03-31 09:40:15', 1, '2022-04-01 10:16:13');
INSERT INTO `tb_worker` VALUES (13, 'admin12', 'admin', '员工8', '1', '996969635', '3', '0', 0, 0, '2022-06-07', 1, '2022-03-31 09:43:41', 1, '2022-04-01 10:17:11');
INSERT INTO `tb_worker` VALUES (14, 'admin001', 'admin123', '管理者2', '0', '188502165', '1', '1', 0, 1, '2022-06-03', 1, '2022-03-31 15:02:00', 1, '2022-05-11 21:41:42');
INSERT INTO `tb_worker` VALUES (15, 'admin14', 'admin', '李医生', '1', '199030201', '2', '1', 0, 0, '2022-06-08', 0, '2022-04-01 13:23:00', 1, '2022-05-12 09:44:26');
INSERT INTO `tb_worker` VALUES (16, 'admin16', '123456', '员工甲', '0', '22222222', '3', '0', 0, 0, '2022-06-07', 0, '2022-04-10 21:22:47', 0, '2022-04-10 21:22:47');
INSERT INTO `tb_worker` VALUES (17, 'H001', '123456', '夏医生', '0', '1735546985', '2', '1', 0, 0, '2022-06-08', 0, '2022-05-12 10:07:26', 1, '2022-05-12 10:14:10');
INSERT INTO `tb_worker` VALUES (18, 'D001', '123456', '陈医生', '1', '80003156', '2', '1', 0, 0, '2022-06-09', 0, '2022-05-12 10:14:01', 1, '2022-05-12 10:14:11');
INSERT INTO `tb_worker` VALUES (19, 'YS2001', 'admin', '赵医生', '0', '3210551999', '2', '1', 0, 0, '2022-06-06', 0, '2022-05-20 13:11:36', 1, '2022-05-20 13:11:42');

SET FOREIGN_KEY_CHECKS = 1;
