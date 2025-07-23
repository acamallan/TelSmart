CREATE TABLE was_hotel_room_details (
room_id VARCHAR(4) NOT NULL,     
room_type VARCHAR(3) NOT NULL,
price varchar(10) not null,
room_status varchar(3) not null
);
ALTER TABLE was_hotel_room_details ADD PRIMARY KEY(room_id);