CREATE TABLE was_user_info (
userid INT(6) UNSIGNED AUTO_INCREMENT PRIMARY KEY,     
username VARCHAR(30) NOT NULL,
firstname VARCHAR(30) NOT NULL,
lastname VARCHAR(30) NOT NULL,
password VARCHAR(130) NOT NULL,
email VARCHAR(50),
record_date TIMESTAMP,
modified_date TIMESTAMP,
role VARCHAR( 130 ),
institution_id varchar(4) default ''
)

INSERT INTO `was_user_info` (`userid`, `username`, `firstname`, `lastname`, `password`, `email`, `record_date`, `modified_date`, `role`) VALUES
(100010, 'admin', 'admin', 'admin', '8450ECA01665516D9AEB5317764902B78495502637C96192C81B1683D32D691A0965CF037FECA8B9ED9EE6FC6AB8F27FCE8F77C4FD9B4A442A00FC317B8237E6', '222', '2015-09-19 12:47:08', '2015-09-19 12:47:08', '8450eca01665516d9aeb5317764902b78495502637c96192c81b1683d32d691a0965cf037feca8b9ed9ee6fc6ab8f27fce8f77c4fd9b4a442a00fc317b8237e6');