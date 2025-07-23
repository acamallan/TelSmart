alter table was_user_info change userid userid varchar(6);

alter table was_user_info add 
current_login TIMESTAMP;
alter table was_user_info add 
last_login TIMESTAMP;
alter table was_user_info add 
password_status varchar(1);
alter table was_user_info add 
password_failed varchar(2) not null;