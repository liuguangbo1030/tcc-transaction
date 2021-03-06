create database tcc_demo;

CREATE TABLE `product` (
  `product_id` varchar(40) NOT NULL COMMENT '',
  `create_time` DATETIME not null DEFAULT CURRENT_TIMESTAMP COMMENT '事务开始时间',
  `remaining` int DEFAULT 0 COMMENT '剩余库存',
  `pre_remaining` DECIMAL(12,2) DEFAULT 0 COMMENT '预处理余额 初始化值跟remaining一样，最终值也一样',
  PRIMARY KEY (`product_id`),
  KEY `idx_create_time` (`create_time`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT '商品表';

CREATE TABLE `pre_product` (
  `xid` varchar(40) NOT NULL COMMENT '事务id',
  `product_id` varchar(40) NOT NULL COMMENT '',
  `create_time` DATETIME not null DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `delta` int DEFAULT 0 COMMENT '出货数量',
  PRIMARY KEY (`xid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT '商品库存预处理表';


CREATE TABLE `account` (
  `account_id` varchar(40) NOT NULL COMMENT '',
  `create_time` DATETIME not null DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `balance` DECIMAL(12,2) DEFAULT 0 COMMENT '余额',
  `pre_balance` DECIMAL(12,2) DEFAULT 0 COMMENT '预处理余额 初始化值跟balance一样，最终值也一样',
  PRIMARY KEY (`account_id`),
  KEY `idx_create_time` (`create_time`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT '账户表';

CREATE TABLE `pre_account` (
  `account_id` varchar(40) NOT NULL COMMENT '',
  `to_account_id` varchar(40) DEFAULT '' COMMENT '转账人账号id',
  `xid` varchar(40) NOT NULL COMMENT '事务id',
  `operation` int DEFAULT 0 COMMENT '操作类型 0 消费  1充值 2转账',
  `delta` DECIMAL(12,2) DEFAULT 0 COMMENT '金额',
  `create_time` DATETIME not null DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`xid`),
  KEY `idx_create_time` (`create_time`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT '账号预处理表';


-- init table
insert into account(account_id,balance,pre_balance) VALUES ("1",100000.00,100000.00);
insert into product(product_id, remaining,pre_remaining) VALUES ("1",100000,100000.00);