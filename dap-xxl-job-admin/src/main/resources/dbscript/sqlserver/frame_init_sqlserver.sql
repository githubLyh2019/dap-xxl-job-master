/*
Navicat MySQL Data Transfer

Source Server         : 55mysql
Source Server Version : 50721
Source Host           : 128.8.50.55:3306
Source Database       : eadp

Target Server Type    : MYSQL
Target Server Version : 50721
File Encoding         : 65001

Date: 2018-08-21 16:18:13
*/

IF not EXISTS(SELECT *FROM sysdatabases WHERE name = 'xxl_job') CREATE DATABASE [xxl_job]
use "xxl_job";


DROP TABLE [dbo].[xxl_job_info]
GO
CREATE TABLE [dbo].[xxl_job_info] (
  [id] int PRIMARY KEY identity(1,1) NOT NULL,
  [job_group] int NOT NULL,
  [job_cron] varchar(128) NOT NULL,
  [job_desc] varchar(255) NOT NULL,
  [add_time] datetime NULL,
  [update_time] datetime NULL,
  [author] varchar(64) DEFAULT NULL,
  [alarm_email] varchar(255) NULL ,
  [executor_route_strategy] varchar(50) NULL ,
  [executor_handler] varchar(255) NULL ,
  [executor_param] varchar(512) NULL ,
  [executor_block_strategy] varchar(50) NULL ,
  [executor_timeout] int DEFAULT '0' ,
  [executor_fail_retry_count] int NOT NULL DEFAULT '0' ,
  [glue_type] varchar(50) NOT NULL ,
  [glue_source] text ,
  [glue_remark] varchar(128) NULL ,
  [glue_updatetime] datetime NULL ,
  [child_jobid] varchar(255) NULL ,
  [trigger_status] tinyint DEFAULT '0' NOT NULL ,
  [trigger_last_time] bigint DEFAULT '0' NOT NULL ,
  [trigger_next_time] bigint DEFAULT '0' NOT NULL
);


GO

-- ----------------------------
-- Records of FRAME_ATTACH
-- ----------------------------

-- ----------------------------
-- Table structure for FRAME_ATTACH_RELATION
-- ----------------------------
DROP TABLE [dbo].[xxl_job_log]
GO
CREATE TABLE [xxl_job_log] (
  [id] bigint NOT NULL identity(1,1) primary key,
  [job_group] int NOT NULL,
  [job_id] int NOT NULL,
  [executor_address] varchar(255)  NULL,
  [executor_handler] varchar(255)  NULL,
  [executor_param] varchar(512)  NULL,
  [executor_sharding_param] varchar(20) NULL,
  [executor_fail_retry_count] int DEFAULT '0',
  [trigger_time] datetime NULL,
  [trigger_code] int NOT NULL,
  [trigger_msg] text,
  [handle_time] datetime NULL,
  [handle_code] int NOT NULL,
  [handle_msg] text,
  [alarm_status] tinyint DEFAULT '0',
);
create index I_trigger_time on xxl_job_log(trigger_time);
create index I_handle_code on xxl_job_log(handle_code);

GO

DROP TABLE [dbo].[xxl_job_log_report]
GO
CREATE TABLE [dbo].[xxl_job_log_report] (
  [id] int NOT NULL identity(1,1) primary key,
  [trigger_day] datetime NULL,
  [running_count] int DEFAULT '0',
  [suc_count] int DEFAULT '0',
  [fail_count] int DEFAULT '0',
);
create unique index i_trigger_day on xxl_job_log_report(trigger_day);


GO



DROP TABLE [dbo].[xxl_job_logglue]
GO
CREATE TABLE [dbo].[xxl_job_logglue] (
  [id] int NOT NULL identity(1,1) primary key,
  [job_id] int NOT NULL,
  [glue_type] varchar DEFAULT NULL,
  [glue_source] text,
  [glue_remark] varchar(128) NOT NULL,
  [add_time] datetime NULL,
  [update_time] datetime NULL,
);


GO



DROP TABLE [dbo].[xxl_job_registry]
GO
CREATE TABLE [dbo].[xxl_job_registry] (
  [id] int NOT NULL identity(1,1) primary key,
  [registry_group] varchar(50) NOT NULL,
  [registry_key] varchar(255) NOT NULL,
  [registry_value] varchar(255) NOT NULL,
  [update_time] datetime NULL,
);
create index i_gkv on xxl_job_registry(registry_group,registry_key,registry_value);


GO


DROP TABLE [dbo].[xxl_job_group]
GO
CREATE TABLE [dbo].[xxl_job_group] (
  [id] int NOT NULL identity(1,1) primary key,
  [app_name] varchar(64) NOT NULL,
  [title] varchar(12) NOT NULL,
  [order] int DEFAULT '0' ,
  [address_type] tinyint DEFAULT '0',
  [address_list] varchar(512) NULL,
);


GO


DROP TABLE [dbo].[xxl_job_user]
GO
CREATE TABLE [dbo].[xxl_job_user] (
  [id] int NOT NULL identity(1,1) primary key,
  [username] varchar(50) NOT NULL ,
  [password] varchar(50) NOT NULL,
  [role] tinyint NOT NULL,
  [permission] varchar(255) NULL,
);
create unique index i_username on xxl_job_user(username);


GO


DROP TABLE [dbo].[xxl_job_lock]
GO
CREATE TABLE [dbo].[xxl_job_lock] (
  [lock_name] varchar(50) NOT NULL primary key
);

INSERT INTO [dbo].[xxl_job_group]([app_name], [title], [order], [address_type], [address_list]) VALUES ('xxl-job-executor-sample', '示例执行器', 1, 0, NULL);
INSERT INTO [dbo].[xxl_job_info]([job_group], [job_cron], [job_desc], [add_time], [update_time], [author], [alarm_email], [executor_route_strategy], [executor_handler], [executor_param], [executor_block_strategy], [executor_timeout], [executor_fail_retry_count], [glue_type], [glue_source], [glue_remark], [glue_updatetime], [child_jobid]) VALUES (1, '0 0 0 * * ? *', '测试任务1', '2018-11-03 22:21:31', '2018-11-03 22:21:31', 'XXL', '', 'FIRST', 'demoJobHandler', '', 'SERIAL_EXECUTION', 0, 0, 'BEAN', '', 'GLUE代码初始化', '2018-11-03 22:21:31', '');
INSERT INTO [dbo].[xxl_job_user]([username], [password], [role], [permission]) VALUES ('admin', 'e10adc3949ba59abbe56e057f20f883e', 1, NULL);
INSERT INTO [dbo].[xxl_job_lock] ([lock_name]) VALUES ('schedule_lock');

commit;