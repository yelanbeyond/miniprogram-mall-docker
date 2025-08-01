-- 创建数据库
CREATE DATABASE IF NOT EXISTS `123321qqqq` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE `123321qqqq`;

-- 创建用户
CREATE USER IF NOT EXISTS '123321qqqq'@'%' IDENTIFIED BY '123321qqqq';
GRANT ALL PRIVILEGES ON `123321qqqq`.* TO '123321qqqq'@'%';
FLUSH PRIVILEGES;

-- 商品分类表
CREATE TABLE IF NOT EXISTS `categories` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL COMMENT '分类名称',
  `parent_id` int(11) DEFAULT 0 COMMENT '父分类ID',
  `sort_order` int(11) DEFAULT 0 COMMENT '排序',
  `status` tinyint(1) DEFAULT 1 COMMENT '状态：1启用，0禁用',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_parent_id` (`parent_id`),
  KEY `idx_status` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='商品分类表';

-- 商品表
CREATE TABLE IF NOT EXISTS `goods` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(200) NOT NULL COMMENT '商品名称',
  `category_id` int(11) NOT NULL COMMENT '分类ID',
  `price` decimal(10,2) NOT NULL COMMENT '价格',
  `original_price` decimal(10,2) DEFAULT NULL COMMENT '原价',
  `stock` int(11) DEFAULT 0 COMMENT '库存',
  `description` text COMMENT '商品描述',
  `images` text COMMENT '商品图片，JSON格式',
  `status` tinyint(1) DEFAULT 1 COMMENT '状态：1上架，0下架',
  `sort_order` int(11) DEFAULT 0 COMMENT '排序',
  `sales_count` int(11) DEFAULT 0 COMMENT '销量',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_category_id` (`category_id`),
  KEY `idx_status` (`status`),
  KEY `idx_price` (`price`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='商品表';

-- 用户表
CREATE TABLE IF NOT EXISTS `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `openid` varchar(100) NOT NULL COMMENT '微信openid',
  `nickname` varchar(100) DEFAULT NULL COMMENT '昵称',
  `avatar` varchar(255) DEFAULT NULL COMMENT '头像',
  `phone` varchar(20) DEFAULT NULL COMMENT '手机号',
  `email` varchar(100) DEFAULT NULL COMMENT '邮箱',
  `status` tinyint(1) DEFAULT 1 COMMENT '状态：1正常，0禁用',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_openid` (`openid`),
  KEY `idx_status` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='用户表';

-- 订单表
CREATE TABLE IF NOT EXISTS `orders` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `order_no` varchar(50) NOT NULL COMMENT '订单号',
  `user_id` int(11) NOT NULL COMMENT '用户ID',
  `total_amount` decimal(10,2) NOT NULL COMMENT '订单总金额',
  `discount_amount` decimal(10,2) DEFAULT 0.00 COMMENT '优惠金额',
  `final_amount` decimal(10,2) NOT NULL COMMENT '实付金额',
  `status` tinyint(1) DEFAULT 1 COMMENT '订单状态：1待付款，2已付款，3已发货，4已收货，5已取消',
  `payment_method` varchar(20) DEFAULT NULL COMMENT '支付方式',
  `payment_time` timestamp NULL DEFAULT NULL COMMENT '支付时间',
  `shipping_address` text COMMENT '收货地址',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_order_no` (`order_no`),
  KEY `idx_user_id` (`user_id`),
  KEY `idx_status` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='订单表';

-- 订单商品表
CREATE TABLE IF NOT EXISTS `order_goods` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `order_id` int(11) NOT NULL COMMENT '订单ID',
  `goods_id` int(11) NOT NULL COMMENT '商品ID',
  `goods_name` varchar(200) NOT NULL COMMENT '商品名称',
  `goods_price` decimal(10,2) NOT NULL COMMENT '商品价格',
  `quantity` int(11) NOT NULL COMMENT '购买数量',
  `total_price` decimal(10,2) NOT NULL COMMENT '小计',
  PRIMARY KEY (`id`),
  KEY `idx_order_id` (`order_id`),
  KEY `idx_goods_id` (`goods_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='订单商品表';

-- 购物车表
CREATE TABLE IF NOT EXISTS `cart` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL COMMENT '用户ID',
  `goods_id` int(11) NOT NULL COMMENT '商品ID',
  `quantity` int(11) NOT NULL COMMENT '数量',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_user_goods` (`user_id`, `goods_id`),
  KEY `idx_user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='购物车表';

-- 优惠券表
CREATE TABLE IF NOT EXISTS `coupons` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL COMMENT '优惠券名称',
  `type` tinyint(1) NOT NULL COMMENT '类型：1满减券，2折扣券',
  `discount_value` decimal(10,2) NOT NULL COMMENT '优惠值（满减券为金额，折扣券为折扣比例）',
  `min_amount` decimal(10,2) DEFAULT 0.00 COMMENT '最低消费金额',
  `total_count` int(11) NOT NULL COMMENT '发放总数',
  `used_count` int(11) DEFAULT 0 COMMENT '已使用数量',
  `status` tinyint(1) DEFAULT 1 COMMENT '状态：1启用，0禁用',
  `start_time` timestamp NULL DEFAULT NULL COMMENT '开始时间',
  `end_time` timestamp NULL DEFAULT NULL COMMENT '结束时间',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_status` (`status`),
  KEY `idx_time` (`start_time`, `end_time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='优惠券表';

-- 用户优惠券表
CREATE TABLE IF NOT EXISTS `user_coupons` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL COMMENT '用户ID',
  `coupon_id` int(11) NOT NULL COMMENT '优惠券ID',
  `status` tinyint(1) DEFAULT 1 COMMENT '状态：1未使用，2已使用，3已过期',
  `used_time` timestamp NULL DEFAULT NULL COMMENT '使用时间',
  `order_id` int(11) DEFAULT NULL COMMENT '关联订单ID',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_user_id` (`user_id`),
  KEY `idx_coupon_id` (`coupon_id`),
  KEY `idx_status` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='用户优惠券表';

-- 插入测试数据
-- 分类数据
INSERT INTO `categories` (`name`, `parent_id`, `sort_order`) VALUES
('电子产品', 0, 1),
('服装鞋帽', 0, 2),
('食品饮料', 0, 3),
('手机', 1, 1),
('电脑', 1, 2),
('男装', 2, 1),
('女装', 2, 2);

-- 商品数据
INSERT INTO `goods` (`name`, `category_id`, `price`, `original_price`, `stock`, `description`) VALUES
('iPhone 15 Pro', 4, 7999.00, 8999.00, 50, '全新iPhone 15 Pro，A17 Pro芯片，超强性能'),
('MacBook Pro', 5, 12999.00, 14999.00, 30, '13英寸MacBook Pro，M2芯片，轻薄便携'),
('休闲T恤', 6, 199.00, 299.00, 100, '100%纯棉，舒适透气'),
('连衣裙', 7, 399.00, 599.00, 80, '优雅设计，多色可选');

-- 优惠券数据
INSERT INTO `coupons` (`name`, `type`, `discount_value`, `min_amount`, `total_count`, `start_time`, `end_time`) VALUES
('满100减10券', 1, 10.00, 100.00, 1000, NOW(), DATE_ADD(NOW(), INTERVAL 30 DAY)),
('8折优惠券', 2, 0.80, 200.00, 500, NOW(), DATE_ADD(NOW(), INTERVAL 15 DAY));

COMMIT;