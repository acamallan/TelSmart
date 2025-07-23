alter table was_user_info add modules varchar(10) default '';
update was_user_info set modules='11' where username='admin';