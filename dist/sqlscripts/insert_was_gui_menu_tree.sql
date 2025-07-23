delete from was_gui_menu_tree;
insert into was_gui_menu_tree(node_number, menu_id, menu_name, parent_id, module_name, parent_path)
values(1,'parent_menu','Products',0, 'Inventory','0');
insert into was_gui_menu_tree(node_number, menu_id, menu_name, parent_id, module_name, parent_path)
values(2,'product_items','Items',1, 'Inventory','1');
insert into was_gui_menu_tree(node_number, menu_id, menu_name, parent_id, module_name, parent_path)
values(3,'product_category','Categories',1, 'Inventory','1');
insert into was_gui_menu_tree(node_number, menu_id, menu_name, parent_id, module_name, parent_path)
values(4,'product_purchase','Purchase',1, 'Inventory','1');
insert into was_gui_menu_tree(node_number, menu_id, menu_name, parent_id, module_name, parent_path)
values(5,'product_sale','Sales',1, 'Inventory','1');
insert into was_gui_menu_tree(node_number, menu_id, menu_name, parent_id, module_name, parent_path)
values(6,'product_supplier','Supplier',1, 'Inventory','1');
insert into was_gui_menu_tree(node_number, menu_id, menu_name, parent_id, module_name, parent_path)
values(7,'parent_menu','Product Reports',0, 'Inventory','0');
insert into was_gui_menu_tree(node_number, menu_id, menu_name, parent_id, module_name, parent_path)
values(8,'products_avail','View Availability',7, 'Inventory','7');
insert into was_gui_menu_tree(node_number, menu_id, menu_name, parent_id, module_name, parent_path)
values(9,'view_daily_purchase','View Daily Purchase',7, 'Inventory','7');
insert into was_gui_menu_tree(node_number, menu_id, menu_name, parent_id, module_name, parent_path)
values(10,'view_daily_sale','View Daily Sales',7, 'Inventory','1');
insert into was_gui_menu_tree(node_number, menu_id, menu_name, parent_id, module_name, parent_path)
values(11,'parent_menu','Settings',0, 'Inventory','0');
insert into was_gui_menu_tree(node_number, menu_id, menu_name, parent_id, module_name, parent_path)
values(12,'user','Users List',11, 'Inventory','11');
insert into was_gui_menu_tree(node_number, menu_id, menu_name, parent_id, module_name, parent_path)
values(13,'change_password','Change Password',11, 'Inventory','11');