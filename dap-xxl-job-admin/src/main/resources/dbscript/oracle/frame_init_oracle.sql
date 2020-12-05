/*
Navicat MySQL Data Transfer
创建xxl-job需要的数据库数据库表
Date: 2018-08-21 16:18:13
*/
DROP TABLE xxl_job_info;
CREATE TABLE xxl_job_info (
  id int NOT NULL,
  job_group int NOT NULL,
  job_cron varchar(128) NOT NULL,
  job_desc varchar(255) NOT NULL,
  add_time DATE,
  update_time DATE,
  author varchar(64),
  alarm_email varchar(255),
  executor_route_strategy varchar(50),
  executor_handler varchar(255),
  executor_param varchar(512),
  executor_block_strategy varchar(50),
  executor_timeout int DEFAULT '0',
  executor_fail_retry_count int DEFAULT '0',
  glue_type varchar(50) NOT NULL,
  glue_source clob,
  glue_remark varchar(128),
  glue_updatetime DATE,
  child_jobid varchar(255),
  trigger_status NUMBER DEFAULT '0',
  trigger_last_time NUMBER DEFAULT '0',
  trigger_next_time NUMBER DEFAULT '0'
);

alter table xxl_job_info add primary key(ID);
/* 创建序列 */
create sequence seq_xxl_job_info
minvalue 1
maxvalue 9999999999999999999999999999
start with 1
increment by 1
nocache;
/* 创建触发器 */
create or replace trigger tr_seq_xxl_job_info
before insert on xxl_job_info
for each row
begin
select seq_xxl_job_info.nextval into:new.id from dual;
end;


CREATE TABLE xxl_job_log (
  id number NOT NULL,
  job_group int NOT NULL,
  job_id int NOT NULL,
  executor_address varchar(255),
  executor_handler varchar(255),
  executor_param varchar(512),
  executor_sharding_param varchar(20),
  executor_fail_retry_count int DEFAULT '0' NOT NULL,
  trigger_time date,
  trigger_code int NOT NULL,
  trigger_msg clob,
  handle_time date,
  handle_code int NOT NULL,
  handle_msg clob,
  alarm_status number DEFAULT '0'
);
alter table xxl_job_log add primary key(id);
/* 创建索引 */
create index I_trigger_time on xxl_job_log(trigger_time);
create index I_handle_code on xxl_job_log(handle_code);
/* 创建序列 */
create sequence seq_xxl_job_log
minvalue 1
maxvalue 9999999999999999999999999999
start with 1
increment by 1
nocache;
/* 创建触发器 */
create or replace trigger tr_seq_xxl_job_log
before insert on xxl_job_log
for each row
begin
select seq_xxl_job_log.nextval into:new.id from dual;
end;


CREATE TABLE xxl_job_log_report (
  id int NOT NULL,
  trigger_day date DEFAULT NULL ,
  running_count int DEFAULT '0' NOT NULL ,
  suc_count int DEFAULT '0' NOT NULL ,
  fail_count int DEFAULT '0' NOT NULL
);
alter table xxl_job_log_report add primary key(id);
create unique index i_trigger_day on xxl_job_log_report(trigger_day);
/* 创建序列 */
create sequence seq_xxl_job_log_report
minvalue 1
maxvalue 9999999999999999999999999999
start with 1
increment by 1
nocache;
/* 创建触发器 */
create or replace trigger tr_seq_xxl_job_log_report
before insert on xxl_job_log_report
for each row
begin
select seq_xxl_job_log_report.nextval into:new.id from dual;
end;




CREATE TABLE xxl_job_logglue (
  id int NOT NULL,
  job_id int NOT NULL,
  glue_type varchar(50) DEFAULT NULL ,
  glue_source clob,
  glue_remark varchar(128) NOT NULL ,
  add_time date DEFAULT NULL,
  update_time date DEFAULT NULL
);
alter table xxl_job_logglue add primary key(id);
/* 创建序列 */
create sequence seq_xxl_job_logglue
minvalue 1
maxvalue 9999999999999999999999999999
start with 1
increment by 1
nocache;
/* 创建触发器 */
create or replace trigger tr_seq_xxl_job_logglue
before insert on xxl_job_logglue
for each row
begin
select seq_xxl_job_logglue.nextval into:new.id from dual;
end;




CREATE TABLE xxl_job_registry (
  id int NOT NULL,
  registry_group varchar(50) NOT NULL,
  registry_key varchar(255) NOT NULL,
  registry_value varchar(255) NOT NULL,
  update_time date DEFAULT NULL
);
alter table xxl_job_registry add primary key(id);
create index i_gkv on xxl_job_registry(registry_group,registry_key,registry_value);
/* 创建序列 */
create sequence seq_xxl_job_registry
minvalue 1
maxvalue 9999999999999999999999999999
start with 1
increment by 1
nocache;
/* 创建触发器 */
create or replace trigger tr_seq_xxl_job_registry
before insert on xxl_job_registry
for each row
begin
select seq_xxl_job_registry.nextval into:new.id from dual;
end;



CREATE TABLE xxl_job_group (
  id int NOT NULL,
  app_name varchar(64) NOT NULL ,
  title varchar(64) NOT NULL ,
  /* order是关键字需加双引号 */
  "order" int DEFAULT '0' NOT NULL ,
  address_type number DEFAULT '0' NOT NULL ,
  address_list varchar(512) DEFAULT NULL
);
alter table xxl_job_group add primary key(id);
/* 创建序列 */
create sequence seq_xxl_job_group
minvalue 1
maxvalue 9999999999999999999999999999
start with 1
increment by 1
nocache;
/* 创建触发器 */
create or replace trigger tr_seq_xxl_job_group
before insert on xxl_job_group
for each row
begin
select seq_xxl_job_group.nextval into:new.id from dual;
end;



CREATE TABLE xxl_job_user (
  id int NOT NULL,
  username varchar(50) NOT NULL ,
  password varchar(50) NOT NULL ,
  role number NOT NULL ,
  permission varchar(255) DEFAULT NULL
);
 alter table xxl_job_user add primary key(id);
 create unique index i_username on xxl_job_user(username);
 /* 创建序列 */
create sequence seq_xxl_job_user
minvalue 1
maxvalue 9999999999999999999999999999
start with 1
increment by 1
nocache;
/* 创建触发器 */
create or replace trigger tr_seq_xxl_job_user
before insert on xxl_job_user
for each row
begin
select seq_xxl_job_user.nextval into:new.id from dual;
end;




CREATE TABLE xxl_job_lock (
  lock_name varchar(50) NOT NULL
);
alter table xxl_job_lock add primary key(lock_name);
/* *//* 创建序列 *//*
create sequence seq_xxl_job_lock
minvalue 1
maxvalue 9999999999999999999999999999
start with 1
increment by 1
nocache;
*//* 创建触发器 *//*
create or replace trigger tr_seq_xxl_job_lock
before insert on xxl_job_lock
for each row
begin
select seq_xxl_job_lock.nextval into:new.id from dual;
end;*/


INSERT INTO xxl_job_group(id, app_name, title, "order", address_type, address_list) VALUES (1, 'xxl-job-executor-sample', '示例执行器', 1, 0, NULL);
INSERT INTO xxl_job_info(id, job_group, job_cron, job_desc, add_time, update_time, author, alarm_email, executor_route_strategy, executor_handler, executor_param,executor_block_strategy, executor_timeout, executor_fail_retry_count, glue_type, glue_source, glue_remark, glue_updatetime, child_jobid) VALUES (1, 1, '0 0 0 * * ? *', '测试任务1',to_date('2018-11-03 22:21:31' , 'yyyy-mm-dd hh24:mi:ss'), to_date('2018-11-03 22:21:31', 'yyyy-mm-dd hh24:mi:ss'), 'XXL', '', 'FIRST', 'demoJobHandler', '', 'SERIAL_EXECUTION', 0, 0, 'BEAN', '', 'GLUE代码初始化', to_date('2018-11-03 22:21:31', 'yyyy-mm-dd hh24:mi:ss'), '');
INSERT INTO xxl_job_user(id, username, password, role, permission) VALUES (1, 'admin', 'e10adc3949ba59abbe56e057f20f883e', 1, NULL);
INSERT INTO xxl_job_lock (lock_name) VALUES ('schedule_lock');

commit;