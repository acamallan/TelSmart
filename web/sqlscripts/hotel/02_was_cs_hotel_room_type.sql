CREATE TABLE was_cs_hotel_room_type (
	was_id VARCHAR(3) PRIMARY KEY NOT NULL,
	room_type VARCHAR(30) NOT NULL
);
insert into was_cs_hotel_room_type(was_id, room_type) values('101', 'Single');
insert into was_cs_hotel_room_type(was_id, room_type) values('102', 'Double');
insert into was_cs_hotel_room_type(was_id, room_type) values('103', 'Triple');
insert into was_cs_hotel_room_type(was_id, room_type) values('104', 'Quad');
insert into was_cs_hotel_room_type(was_id, room_type) values('105', 'Queen');
insert into was_cs_hotel_room_type(was_id, room_type) values('106', 'King');
insert into was_cs_hotel_room_type(was_id, room_type) values('107', 'Twin');
insert into was_cs_hotel_room_type(was_id, room_type) values('108', 'Double-double');
insert into was_cs_hotel_room_type(was_id, room_type) values('109', 'Studio');
insert into was_cs_hotel_room_type(was_id, room_type) values('110', 'Mini-Suite or junior suite');
insert into was_cs_hotel_room_type(was_id, room_type) values('111', 'Suite');
commit;