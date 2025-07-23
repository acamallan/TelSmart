CREATE TABLE was_gui_menu_tree(
node_number int( 4 ) PRIMARY KEY ,
menu_id VARCHAR( 30 ) NOT NULL ,
menu_name VARCHAR( 30 ) NOT NULL ,
parent_id int( 2 ) NOT NULL,
module_name VARCHAR( 20 ) NOT NULL,
parent_path VARCHAR( 30 ) NOT NULL 
)