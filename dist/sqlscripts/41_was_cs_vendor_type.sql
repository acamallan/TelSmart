drop table was_cs_vendor_type;
CREATE TABLE was_cs_vendor_type (
was_id VARCHAR(3) NOT NULL PRIMARY KEY ,
vendor_type VARCHAR( 30 ) NOT NULL);
insert into was_cs_vendor_type(was_id, vendor_type)
values(101,'Type 1');
insert into was_cs_vendor_type(was_id, vendor_type)
values(102,'Type 2');
