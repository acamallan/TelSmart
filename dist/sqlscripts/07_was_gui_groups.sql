CREATE TABLE was_gui_groups(
group_id MEDIUMINT NOT NULL AUTO_INCREMENT,    
group_name VARCHAR( 20 ) NOT NULL,
description VARCHAR( 30 ) NOT NULL,
CONSTRAINT group_pk PRIMARY KEY (group_id)
);