
CREATE TABLE was_cs_hotel_room_status (
	was_id VARCHAR(3) PRIMARY KEY NOT NULL,
	room_status VARCHAR(30) NOT NULL
);
insert into was_cs_hotel_room_status(was_id, room_status) values('101', 'Occupied');
insert into was_cs_hotel_room_status(was_id, room_status) values('102', 'Stayover');
insert into was_cs_hotel_room_status(was_id, room_status) values('103', 'On-Change');
insert into was_cs_hotel_room_status(was_id, room_status) values('104', 'Do Not Disturb');
insert into was_cs_hotel_room_status(was_id, room_status) values('105', 'Cleaning in progress');
insert into was_cs_hotel_room_status(was_id, room_status) values('106', 'Sleep-out');
insert into was_cs_hotel_room_status(was_id, room_status) values('107', 'Skipper');
insert into was_cs_hotel_room_status(was_id, room_status) values('108', 'Vacant and ready');
insert into was_cs_hotel_room_status(was_id, room_status) values('109', 'Out of Order');
commit;