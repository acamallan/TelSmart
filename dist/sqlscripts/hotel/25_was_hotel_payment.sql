ALTER TABLE `was_hotel_payment`
	ALTER `transaction_id` DROP DEFAULT;
ALTER TABLE `was_hotel_payment`
	CHANGE COLUMN `transaction_id` `invoice_number` VARCHAR(10) NOT NULL FIRST;