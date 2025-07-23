CREATE TABLE was_configuration(
config_id varchar(3) NOT NULL PRIMARY KEY, 
config_name VARCHAR( 30 ) NOT NULL,
config_value VARCHAR( 30 ) NOT NULL,
config_desc VARCHAR( 30 ) NOT NULL
);

insert into was_configuration(config_id, config_name, config_value, config_desc)
values('1','MovementOut','30', 'Product Movement');