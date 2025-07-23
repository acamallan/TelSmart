drop table was_configuration;
CREATE TABLE was_configuration(
config_id varchar(30) NOT NULL, 
config_name VARCHAR( 30 ) NOT NULL,
config_value VARCHAR( 30 ) NOT NULL,
config_desc VARCHAR( 30 ) NOT NULL,
primary key (config_id, config_name)
);

insert into was_configuration(config_id, config_name, config_value, config_desc)
values('INVENTORY','MovementOut','30', 'Product Movement');
insert into was_configuration(config_id, config_name, config_value, config_desc)
values('INVENTORY','DueDate','30', 'Due Date(Days)');
insert into was_configuration(config_id, config_name, config_value, config_desc)
values('SECURITY','PasswordMinimumLength','8', 'Password Minimum Length');