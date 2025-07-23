-- phpMyAdmin SQL Dump
-- version 4.5.1
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: Apr 18, 2016 at 05:58 AM
-- Server version: 10.1.8-MariaDB
-- PHP Version: 5.6.14

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `waya_t`
--

DELIMITER $$
--
-- Functions
--
CREATE DEFINER=`root`@`localhost` FUNCTION `TO_DATE` (`record_date` CHAR(10)) RETURNS VARCHAR(8) CHARSET latin1 BEGIN
  RETURN concat(right(record_date,4),left(record_date,2),SUBSTRING(record_date, 4,2));
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Stand-in structure for view `view_card_transaction_history`
--
CREATE TABLE `view_card_transaction_history` (
`card_number` varchar(16)
,`transaction_id` varchar(10)
,`transaction_date` varchar(10)
,`transaction_time` varchar(10)
,`transaction_type_id` varchar(3)
,`transaction_type_txt` varchar(30)
,`credit_amount` varchar(10)
,`debit_amount` varchar(10)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `view_daily_products_sale`
--
CREATE TABLE `view_daily_products_sale` (
`product_id` varchar(6)
,`product_name` varchar(30)
,`quantity` varchar(10)
,`total_amount` varchar(10)
,`record_date` varchar(10)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `view_hotel_book_transactions`
--
CREATE TABLE `view_hotel_book_transactions` (
`transaction_id` varchar(10)
,`transaction_date` varchar(10)
,`transaction_time` varchar(8)
,`customer_id` varchar(10)
,`customer_name` varchar(61)
,`room_id` varchar(4)
,`in_date` varchar(10)
,`out_date` varchar(10)
,`days` varchar(3)
,`transaction_amount` varchar(10)
,`book_status` varchar(1)
,`number_of_adult` varchar(2)
,`number_of_minor` varchar(2)
,`userid` varchar(6)
,`username` varchar(30)
,`room_status_id` varchar(3)
,`room_status_txt` varchar(30)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `view_hotel_revenue`
--
CREATE TABLE `view_hotel_revenue` (
`sales_invoice_number` varchar(16)
,`transaction_date` varchar(10)
,`transaction_amount` varchar(10)
,`userid` varchar(6)
,`user_fullname` varchar(61)
,`location` varchar(1)
,`location_txt` varchar(10)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `view_hotel_transactions_status`
--
CREATE TABLE `view_hotel_transactions_status` (
`transaction_id` varchar(10)
,`transaction_date` varchar(10)
,`transaction_time` varchar(8)
,`customer_id` varchar(10)
,`room_id` varchar(4)
,`transaction_amount` varchar(10)
,`description` varchar(10)
,`payment_status_id` varchar(3)
,`payment_status_txt` varchar(30)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `view_product_available`
--
CREATE TABLE `view_product_available` (
`product_id` varchar(6)
,`product_name` varchar(30)
,`category` varchar(30)
,`selling_price` varchar(10)
,`discount` varchar(10)
,`available` double
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `view_product_info`
--
CREATE TABLE `view_product_info` (
`reference_number` varchar(13)
,`product_id` varchar(6)
,`product_name` varchar(30)
,`category` varchar(30)
,`reorder_threshold` varchar(6)
,`cost_price` varchar(10)
,`selling_price` varchar(10)
,`discount` varchar(10)
,`product_in` varchar(20)
,`product_out` varchar(10)
,`type` bigint(20)
,`record_date` varchar(10)
,`description` varchar(30)
,`location` varchar(3)
,`location_text` varchar(30)
);

-- --------------------------------------------------------

--
-- Table structure for table `wasi_cs_product_category`
--

CREATE TABLE `wasi_cs_product_category` (
  `product_category_id` varchar(30) NOT NULL,
  `product_category_name` varchar(30) NOT NULL,
  `product_category_description` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `wasi_cs_product_category`
--

INSERT INTO `wasi_cs_product_category` (`product_category_id`, `product_category_name`, `product_category_description`) VALUES
('001', 'Desktop Computers', 'Desktop Computers'),
('002', 'Servers', 'Servers'),
('003', 'Netbooks', 'Netbooks'),
('004', 'Notebooks & Laptops', 'Notebooks & Laptops'),
('005', 'Tablet PCs', 'Tablet PCs1'),
('008', 'Cost of Goods Sold', 'Bar Ingredients'),
('008009', 'Beer', 'Beer'),
('008010', 'Coke', 'Coke');

-- --------------------------------------------------------

--
-- Table structure for table `was_accounting_details`
--

CREATE TABLE `was_accounting_details` (
  `accounting_id` varchar(10) NOT NULL,
  `transaction_id` varchar(11) NOT NULL,
  `record_date` varchar(10) NOT NULL,
  `transaction_type` varchar(3) NOT NULL,
  `gl_code` varchar(4) NOT NULL,
  `credit_amount` varchar(10) DEFAULT '',
  `debit_amount` varchar(10) DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `was_accounting_details`
--

INSERT INTO `was_accounting_details` (`accounting_id`, `transaction_id`, `record_date`, `transaction_type`, `gl_code`, `credit_amount`, `debit_amount`) VALUES
('0000000723', 'P0000000120', '02.08.2016', '101', '1001', '1500.00', ''),
('0000000724', 'P0000000120', '02.08.2016', '101', '1002', '', '1500.00'),
('0000000725', 'S0000000121', '02.08.2016', '102', '1001', '20.00', ''),
('0000000726', 'S0000000121', '02.08.2016', '102', '1002', '', '20.00'),
('0000000727', 'S0000000122', '02.08.2016', '102', '1001', '20.00', ''),
('0000000728', 'S0000000122', '02.08.2016', '102', '1002', '', '20.00'),
('0000000729', 'S0000000126', '02.08.2016', '102', '1001', '20.00', ''),
('0000000730', 'S0000000126', '02.08.2016', '102', '1002', '', '20.00'),
('0000000731', 'S0000000127', '02.09.2016', '102', '1001', '40.00', ''),
('0000000732', 'S0000000127', '02.09.2016', '102', '1002', '', '40.00'),
('0000000733', 'S0000000130', '02.09.2016', '102', '1001', '40.00', ''),
('0000000734', 'S0000000130', '02.09.2016', '102', '1002', '', '40.00'),
('0000000735', 'P0000000132', '02.10.2016', '101', '1001', '15.00', ''),
('0000000736', 'P0000000132', '02.10.2016', '101', '1002', '', '15.00'),
('0000000737', 'S0000000147', '02.13.2016', '102', '1001', '40.00', ''),
('0000000738', 'S0000000147', '02.13.2016', '102', '1002', '', '40.00'),
('0000000739', 'P0000000155', '02.15.2016', '101', '1001', '4785.00', ''),
('0000000740', 'P0000000155', '02.15.2016', '101', '1002', '', '4785.00'),
('0000000741', 'P0000000156', '02.15.2016', '101', '1001', '1500.00', ''),
('0000000742', 'P0000000156', '02.15.2016', '101', '1002', '', '1500.00'),
('0000000743', 'P0000000162', '02.16.2016', '101', '1001', '6500.00', ''),
('0000000744', 'P0000000162', '02.16.2016', '101', '1002', '', '6500.00'),
('0000000759', 'P0000000167', '02.16.2016', '101', '1001', '7700.00', ''),
('0000000760', 'P0000000167', '02.16.2016', '101', '1002', '', '7700.00'),
('0000000761', 'P0000000169', '02.16.2016', '101', '1001', '11750.00', ''),
('0000000762', 'P0000000169', '02.16.2016', '101', '1002', '', '11750.00'),
('0000000763', 'P0000000170', '02.16.2016', '101', '1001', '25000.00', ''),
('0000000764', 'P0000000170', '02.16.2016', '101', '1002', '', '25000.00'),
('0000000765', 'P0000000172', '02.16.2016', '101', '1001', '21000.00', ''),
('0000000766', 'P0000000172', '02.16.2016', '101', '1002', '', '21000.00'),
('0000000767', 'P0000000173', '02.16.2016', '101', '1001', '32000.00', ''),
('0000000768', 'P0000000173', '02.16.2016', '101', '1002', '', '32000.00'),
('0000000769', 'P0000000178', '02.16.2016', '101', '1001', '45000.00', ''),
('0000000770', 'P0000000178', '02.16.2016', '101', '1002', '', '45000.00'),
('0000000771', 'P0000000179', '02.16.2016', '101', '1001', '30000.00', ''),
('0000000772', 'P0000000179', '02.16.2016', '101', '1002', '', '30000.00'),
('0000000773', 'P0000000180', '02.16.2016', '101', '1001', '4000.00', ''),
('0000000774', 'P0000000180', '02.16.2016', '101', '1002', '', '4000.00'),
('0000000775', 'P0000000181', '02.16.2016', '101', '1001', '2400.00', ''),
('0000000776', 'P0000000181', '02.16.2016', '101', '1002', '', '2400.00'),
('0000000797', 'P0000000244', '03.04.2016', '101', '1001', '54500.00', ''),
('0000000798', 'P0000000244', '03.04.2016', '101', '1002', '', '54500.00'),
('0000000799', 'P0000000245', '03.04.2016', '101', '1001', '30000.00', ''),
('0000000800', 'P0000000245', '03.04.2016', '101', '1002', '', '30000.00'),
('0000000801', 'P0000000246', '03.04.2016', '101', '1001', '800.00', ''),
('0000000802', 'P0000000246', '03.04.2016', '101', '1002', '', '800.00'),
('0000000803', 'P0000000247', '03.04.2016', '101', '1001', '1200.00', ''),
('0000000804', 'P0000000247', '03.04.2016', '101', '1002', '', '1200.00'),
('0000000805', 'P0000000248', '03.04.2016', '101', '1001', '15000.00', ''),
('0000000806', 'P0000000248', '03.04.2016', '101', '1002', '', '15000.00'),
('0000000807', 'P0000000249', '03.04.2016', '101', '1001', '800.00', ''),
('0000000808', 'P0000000249', '03.04.2016', '101', '1002', '', '800.00'),
('0000000809', 'P0000000250', '03.04.2016', '101', '1001', '1500.00', ''),
('0000000810', 'P0000000250', '03.04.2016', '101', '1002', '', '1500.00'),
('0000000811', 'P0000000251', '03.04.2016', '101', '1001', '800.00', ''),
('0000000812', 'P0000000251', '03.04.2016', '101', '1002', '', '800.00'),
('0000000813', 'P0000000308', '03.26.2016', '101', '1001', '800.00', ''),
('0000000814', 'P0000000308', '03.26.2016', '101', '1002', '', '800.00'),
('0000000815', 'P0000000309', '03.26.2016', '101', '1001', '800.00', ''),
('0000000816', 'P0000000309', '03.26.2016', '101', '1002', '', '800.00');

-- --------------------------------------------------------

--
-- Table structure for table `was_account_balance_details`
--

CREATE TABLE `was_account_balance_details` (
  `account_number` varchar(10) NOT NULL,
  `record_date` varchar(10) NOT NULL,
  `account_balance` varchar(10) NOT NULL,
  `customer_id` varchar(10) NOT NULL,
  `link_number` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `was_account_balance_details`
--

INSERT INTO `was_account_balance_details` (`account_number`, `record_date`, `account_balance`, `customer_id`, `link_number`) VALUES
('1000000028', '02.09.2016', '1060.00', '0000000081', '1000000022');

-- --------------------------------------------------------

--
-- Table structure for table `was_card_details`
--

CREATE TABLE `was_card_details` (
  `card_number` varchar(19) NOT NULL,
  `record_date` varchar(10) NOT NULL,
  `record_time` varchar(8) NOT NULL,
  `expiry_date` varchar(10) NOT NULL,
  `card_status` varchar(3) NOT NULL,
  `card_type` varchar(3) NOT NULL,
  `link_number` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `was_card_details`
--

INSERT INTO `was_card_details` (`card_number`, `record_date`, `record_time`, `expiry_date`, `card_status`, `card_type`, `link_number`) VALUES
('1011011590187482', '02.08.2016', '00.00.00', '04.08.2016', '101', '101', '1000000022'),
('1011016862842706', '02.08.2016', '00.00.00', '04.08.2016', '103', '101', '1000000023');

-- --------------------------------------------------------

--
-- Table structure for table `was_card_details_history`
--

CREATE TABLE `was_card_details_history` (
  `card_number` varchar(19) NOT NULL,
  `record_date` varchar(10) NOT NULL,
  `record_time` varchar(8) NOT NULL,
  `expiry_date` varchar(10) NOT NULL,
  `card_status` varchar(3) NOT NULL,
  `card_type` varchar(3) NOT NULL,
  `link_number` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `was_card_transaction_details`
--

CREATE TABLE `was_card_transaction_details` (
  `transaction_id` varchar(10) NOT NULL,
  `transaction_date` varchar(10) NOT NULL,
  `transaction_time` varchar(10) NOT NULL,
  `card_number` varchar(16) NOT NULL,
  `customer_id` varchar(10) NOT NULL,
  `transaction_type` varchar(3) NOT NULL,
  `currency_type` varchar(3) NOT NULL,
  `transaction_amount` varchar(10) NOT NULL,
  `userid` varchar(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `was_card_transaction_details`
--

INSERT INTO `was_card_transaction_details` (`transaction_id`, `transaction_date`, `transaction_time`, `card_number`, `customer_id`, `transaction_type`, `currency_type`, `transaction_amount`, `userid`) VALUES
('0000000128', '02.09.2016', '10:40:28', '1011011590187482', '0000000081', '104', '101', '1000.00', '100010'),
('0000000129', '02.09.2016', '10:41:14', '1011011590187482', '0000000081', '104', '101', '100.00', '100010');

-- --------------------------------------------------------

--
-- Table structure for table `was_category`
--

CREATE TABLE `was_category` (
  `was_id` varchar(30) NOT NULL,
  `category_name` varchar(30) NOT NULL,
  `parent_category` varchar(30) NOT NULL,
  `category_description` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `was_category`
--

INSERT INTO `was_category` (`was_id`, `category_name`, `parent_category`, `category_description`) VALUES
('101', 'Drinks', '0', 'Drinks'),
('101101', 'Hard Drinks', '101', 'Hard Drinks'),
('101102', 'Softdrinks', '101', 'Softdrinks'),
('101103', 'Fruit Juice', '101', 'Fruit Juice'),
('101104', 'Shake', '101', 'Shake'),
('102', 'Food', '0', 'Food'),
('102101', 'Appetizer', '102', 'Appetizer'),
('102102', 'Sandwich', '102', 'Sandwich'),
('102103', 'Lutong Pinoy', '102', 'Lutong Pinoy'),
('102104', 'Pizza', '102', 'Pizza'),
('102105', 'Pasta', '102', 'Pasta'),
('103', 'Add-ons', '0', 'Add-ons');

-- --------------------------------------------------------

--
-- Table structure for table `was_chart_of_account`
--

CREATE TABLE `was_chart_of_account` (
  `was_id` varchar(4) NOT NULL,
  `account_type` varchar(40) NOT NULL,
  `group_id` varchar(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `was_chart_of_account`
--

INSERT INTO `was_chart_of_account` (`was_id`, `account_type`, `group_id`) VALUES
('1000', 'Cash', 'A'),
('1001', 'Petty Cash', 'A'),
('1002', 'Accounts Receivable', 'A'),
('1003', 'Inventory', 'A'),
('1004', 'Supplies', 'A'),
('1005', 'Land', 'A'),
('1006', 'Buildings', 'A'),
('1007', 'Equipment', 'A'),
('2000', 'Notes Payable', 'B'),
('2001', 'Accounts Payable', 'B'),
('2002', 'Salaries Payable', 'B'),
('2003', 'Wages Payable', 'B'),
('2004', 'Interest Payable', 'B'),
('2005', 'Income Taxes Payable', 'B'),
('2006', 'Customer Deposits', 'B'),
('2007', 'Lawsuits Payable', 'B'),
('3000', 'Common Stock', 'C'),
('3001', 'Preferred Stock', 'C'),
('3002', 'Retained Earnings', 'C'),
('4000', 'Sales', 'D'),
('6000', 'Salaries expense', 'F'),
('6001', 'Advertising expense', 'F'),
('6002', 'Rent expense', 'F'),
('6003', 'Travel expense', 'F'),
('6004', 'Communication expense', 'F'),
('6005', 'Insurance expense', 'F'),
('6006', 'Supplies expense', 'F'),
('6007', 'Utilities expense', 'F'),
('6008', 'Purchase', 'F');

-- --------------------------------------------------------

--
-- Table structure for table `was_client_information`
--

CREATE TABLE `was_client_information` (
  `institution_id` varchar(4) NOT NULL,
  `institution_name` varchar(30) NOT NULL,
  `record_date` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `was_client_information`
--

INSERT INTO `was_client_information` (`institution_id`, `institution_name`, `record_date`) VALUES
('1001', 'Test Company', '01.01.2016');

-- --------------------------------------------------------

--
-- Table structure for table `was_configuration`
--

CREATE TABLE `was_configuration` (
  `config_id` varchar(30) NOT NULL,
  `config_name` varchar(30) NOT NULL,
  `config_value` varchar(30) NOT NULL,
  `config_desc` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `was_configuration`
--

INSERT INTO `was_configuration` (`config_id`, `config_name`, `config_value`, `config_desc`) VALUES
('INVENTORY', 'DueDate', '30', 'Due Date(Days)'),
('INVENTORY', 'MovementOut', '30', 'Product Movement'),
('SECURITY', 'PasswordFailed', '3', 'Password Attempt Failed To Lock User'),
('SECURITY', 'PasswordMinimumLength', '8', 'Password Minimum Length');

-- --------------------------------------------------------

--
-- Table structure for table `was_counter`
--

CREATE TABLE `was_counter` (
  `counter_id` varchar(3) NOT NULL,
  `counter_value` varchar(10) NOT NULL,
  `description` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `was_counter`
--

INSERT INTO `was_counter` (`counter_id`, `counter_value`, `description`) VALUES
('001', '309', 'Transaction ID'),
('002', '816', 'Accounting ID'),
('003', '242', 'Journal Entry'),
('004', '200092', 'User ID'),
('005', '117', 'Supplier ID'),
('006', '116', 'Customer ID'),
('007', '272', 'Product Purchase'),
('008', '35', 'Loan ID'),
('009', '180', 'Invoice Number'),
('010', '1000000028', 'Link Number'),
('011', '1000000000', 'Account Number');

-- --------------------------------------------------------

--
-- Table structure for table `was_cr_dr`
--

CREATE TABLE `was_cr_dr` (
  `was_id` varchar(1) NOT NULL,
  `CR_DR` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `was_cr_dr`
--

INSERT INTO `was_cr_dr` (`was_id`, `CR_DR`) VALUES
('1', 'CR'),
('2', 'DR');

-- --------------------------------------------------------

--
-- Table structure for table `was_cs_address_category`
--

CREATE TABLE `was_cs_address_category` (
  `was_id` varchar(3) NOT NULL,
  `address_category` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `was_cs_address_category`
--

INSERT INTO `was_cs_address_category` (`was_id`, `address_category`) VALUES
('101', 'Headquarter'),
('102', 'Warehouse'),
('103', 'Shipping'),
('104', 'Billing');

-- --------------------------------------------------------

--
-- Table structure for table `was_cs_address_type`
--

CREATE TABLE `was_cs_address_type` (
  `was_id` varchar(3) NOT NULL,
  `address_type` varchar(30) NOT NULL,
  `group_id` varchar(1) NOT NULL,
  `description` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `was_cs_address_type`
--

INSERT INTO `was_cs_address_type` (`was_id`, `address_type`, `group_id`, `description`) VALUES
('101', 'Permanent', 'A', 'Loan'),
('102', 'Home', 'A', 'Loan'),
('103', 'Work', 'A', 'Loan'),
('104', 'Temporary', 'A', 'Loan'),
('105', 'Others', 'A', 'Loan');

-- --------------------------------------------------------

--
-- Table structure for table `was_cs_branch`
--

CREATE TABLE `was_cs_branch` (
  `was_id` varchar(3) NOT NULL,
  `branch` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `was_cs_branch`
--

INSERT INTO `was_cs_branch` (`was_id`, `branch`) VALUES
('101', 'Tigbauan'),
('102', 'Leon');

-- --------------------------------------------------------

--
-- Table structure for table `was_cs_card_status`
--

CREATE TABLE `was_cs_card_status` (
  `was_id` varchar(3) NOT NULL,
  `card_status` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `was_cs_card_status`
--

INSERT INTO `was_cs_card_status` (`was_id`, `card_status`) VALUES
('101', 'Active'),
('102', 'In Active'),
('103', 'Available');

-- --------------------------------------------------------

--
-- Table structure for table `was_cs_card_type`
--

CREATE TABLE `was_cs_card_type` (
  `was_id` varchar(3) NOT NULL,
  `card_type` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `was_cs_card_type`
--

INSERT INTO `was_cs_card_type` (`was_id`, `card_type`) VALUES
('101', 'Stored-value Card'),
('102', 'Gift Card');

-- --------------------------------------------------------

--
-- Table structure for table `was_cs_city`
--

CREATE TABLE `was_cs_city` (
  `was_id` varchar(3) NOT NULL,
  `city` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `was_cs_city`
--

INSERT INTO `was_cs_city` (`was_id`, `city`) VALUES
('145', 'Iloilo'),
('146', 'Roxas'),
('147', 'Capiz'),
('148', 'Passi'),
('149', 'Makati'),
('150', 'Manila');

-- --------------------------------------------------------

--
-- Table structure for table `was_cs_coa_type`
--

CREATE TABLE `was_cs_coa_type` (
  `was_id` varchar(1) NOT NULL,
  `coa_type` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `was_cs_coa_type`
--

INSERT INTO `was_cs_coa_type` (`was_id`, `coa_type`) VALUES
('A', 'Asset Accounts'),
('B', 'Liability Accounts'),
('C', 'Owner''s Equity Accou'),
('D', 'Revenue Accounts'),
('E', 'Cost of Sales Accoun'),
('F', 'Expense Accounts');

-- --------------------------------------------------------

--
-- Table structure for table `was_cs_country`
--

CREATE TABLE `was_cs_country` (
  `was_id` varchar(3) NOT NULL,
  `country` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `was_cs_country`
--

INSERT INTO `was_cs_country` (`was_id`, `country`) VALUES
('101', 'Afghanistan'),
('102', 'Bahrain'),
('103', 'Bangladesh'),
('104', 'Bhutan'),
('105', 'Brunei'),
('106', 'Myanmar'),
('107', 'Cambodia'),
('108', 'China'),
('109', 'Hong Kong'),
('110', 'India'),
('111', 'Indonesia'),
('112', 'Iran'),
('113', 'Iraq'),
('114', 'Israel'),
('115', 'Japan'),
('116', 'Jordan'),
('117', 'Kazakhstan'),
('118', 'North Korea'),
('119', 'South Korea'),
('120', 'Kuwait'),
('121', 'Kyrgyzstan'),
('122', 'Laos'),
('123', 'Lebanon'),
('124', 'Malaysia'),
('125', 'Maldives'),
('126', 'Mongolia'),
('127', 'Nepal'),
('128', 'Oman'),
('129', 'Pakistan'),
('130', 'Philippines'),
('131', 'Qatar'),
('132', 'Saudi Arabia'),
('133', 'Singapore'),
('134', 'Sri Lanka'),
('135', 'Syria'),
('136', 'Taiwan'),
('137', 'Tajikistan'),
('138', 'Thailand'),
('139', 'Timor-Leste'),
('140', 'Turkmenistan'),
('141', 'United Arab Emirates'),
('142', 'Uzbekistan'),
('143', 'Vietnam'),
('144', 'Yemen'),
('145', 'Iloilo'),
('146', 'Roxas'),
('147', 'Capiz'),
('148', 'Passi'),
('149', 'Makati'),
('150', 'Manila');

-- --------------------------------------------------------

--
-- Table structure for table `was_cs_currency_type`
--

CREATE TABLE `was_cs_currency_type` (
  `was_id` varchar(3) NOT NULL,
  `currency_type` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `was_cs_currency_type`
--

INSERT INTO `was_cs_currency_type` (`was_id`, `currency_type`) VALUES
('101', 'PHP');

-- --------------------------------------------------------

--
-- Table structure for table `was_cs_customer_category`
--

CREATE TABLE `was_cs_customer_category` (
  `was_id` varchar(3) NOT NULL,
  `customer_category` varchar(30) NOT NULL,
  `group_id` varchar(1) NOT NULL,
  `description` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `was_cs_customer_category`
--

INSERT INTO `was_cs_customer_category` (`was_id`, `customer_category`, `group_id`, `description`) VALUES
('101', 'Category 1', 'A', 'Loan'),
('102', 'Category 2', 'A', 'Loan');

-- --------------------------------------------------------

--
-- Table structure for table `was_cs_customer_type`
--

CREATE TABLE `was_cs_customer_type` (
  `was_id` varchar(3) NOT NULL,
  `customer_type` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `was_cs_customer_type`
--

INSERT INTO `was_cs_customer_type` (`was_id`, `customer_type`) VALUES
('100', 'Not Applicable'),
('101', 'Private Individuals'),
('102', 'Corporate Clients'),
('103', 'Government');

-- --------------------------------------------------------

--
-- Table structure for table `was_cs_employment_type`
--

CREATE TABLE `was_cs_employment_type` (
  `was_id` varchar(3) NOT NULL,
  `employment_type` varchar(30) NOT NULL,
  `group_id` varchar(1) NOT NULL,
  `description` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `was_cs_employment_type`
--

INSERT INTO `was_cs_employment_type` (`was_id`, `employment_type`, `group_id`, `description`) VALUES
('101', 'Full Time', 'A', 'Loan'),
('102', 'Part Time', 'A', 'Loan'),
('103', 'Contract Based', 'A', 'Loan');

-- --------------------------------------------------------

--
-- Table structure for table `was_cs_gender`
--

CREATE TABLE `was_cs_gender` (
  `was_id` varchar(3) NOT NULL,
  `gender` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `was_cs_gender`
--

INSERT INTO `was_cs_gender` (`was_id`, `gender`) VALUES
('101', 'Male'),
('102', 'Female');

-- --------------------------------------------------------

--
-- Table structure for table `was_cs_hotel_room_status`
--

CREATE TABLE `was_cs_hotel_room_status` (
  `was_id` varchar(3) NOT NULL,
  `room_status` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `was_cs_hotel_room_status`
--

INSERT INTO `was_cs_hotel_room_status` (`was_id`, `room_status`) VALUES
('101', 'Occupied'),
('102', 'Stayover'),
('103', 'On-Change'),
('104', 'Do Not Disturb'),
('105', 'Cleaning in progress'),
('106', 'Sleep-out'),
('107', 'Skipper'),
('108', 'Vacant and ready'),
('109', 'Out of Order'),
('110', 'Reserved');

-- --------------------------------------------------------

--
-- Table structure for table `was_cs_hotel_room_type`
--

CREATE TABLE `was_cs_hotel_room_type` (
  `was_id` varchar(3) NOT NULL,
  `room_type` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `was_cs_hotel_room_type`
--

INSERT INTO `was_cs_hotel_room_type` (`was_id`, `room_type`) VALUES
('101', 'Single'),
('102', 'Double'),
('103', 'Triple'),
('104', 'Quad'),
('105', 'Queen'),
('106', 'King'),
('107', 'Twin'),
('108', 'Double-double'),
('109', 'Studio'),
('110', 'Mini-Suite or junior suite'),
('111', 'Suite');

-- --------------------------------------------------------

--
-- Table structure for table `was_cs_id_type`
--

CREATE TABLE `was_cs_id_type` (
  `was_id` varchar(3) NOT NULL,
  `id_type` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `was_cs_id_type`
--

INSERT INTO `was_cs_id_type` (`was_id`, `id_type`) VALUES
('101', 'SSS'),
('102', 'PhilHealth'),
('103', 'Pag-ibig'),
('104', 'Driver Licence'),
('105', 'Company'),
('999', 'Other');

-- --------------------------------------------------------

--
-- Table structure for table `was_cs_language`
--

CREATE TABLE `was_cs_language` (
  `was_id` varchar(3) NOT NULL,
  `language` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `was_cs_language`
--

INSERT INTO `was_cs_language` (`was_id`, `language`) VALUES
('101', 'English'),
('102', 'Filipino');

-- --------------------------------------------------------

--
-- Table structure for table `was_cs_loan_application`
--

CREATE TABLE `was_cs_loan_application` (
  `was_id` varchar(3) NOT NULL,
  `loan_type` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `was_cs_loan_application`
--

INSERT INTO `was_cs_loan_application` (`was_id`, `loan_type`) VALUES
('101', 'Regular Loan'),
('102', 'Benifits/Bonus Loan');

-- --------------------------------------------------------

--
-- Table structure for table `was_cs_loan_payment_mode`
--

CREATE TABLE `was_cs_loan_payment_mode` (
  `was_id` varchar(3) NOT NULL,
  `payment_mode` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `was_cs_loan_payment_mode`
--

INSERT INTO `was_cs_loan_payment_mode` (`was_id`, `payment_mode`) VALUES
('101', 'Cash'),
('102', 'Check'),
('103', 'ATM');

-- --------------------------------------------------------

--
-- Table structure for table `was_cs_loan_payment_type`
--

CREATE TABLE `was_cs_loan_payment_type` (
  `was_id` varchar(3) NOT NULL,
  `payment_type` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `was_cs_loan_payment_type`
--

INSERT INTO `was_cs_loan_payment_type` (`was_id`, `payment_type`) VALUES
('101', 'Regular'),
('102', 'Partial'),
('103', 'Unpaid');

-- --------------------------------------------------------

--
-- Table structure for table `was_cs_loan_scheme`
--

CREATE TABLE `was_cs_loan_scheme` (
  `was_id` varchar(3) NOT NULL,
  `loan_scheme` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `was_cs_loan_scheme`
--

INSERT INTO `was_cs_loan_scheme` (`was_id`, `loan_scheme`) VALUES
('101', '15th'),
('102', '30th'),
('103', '15th/30th');

-- --------------------------------------------------------

--
-- Table structure for table `was_cs_loan_type`
--

CREATE TABLE `was_cs_loan_type` (
  `was_id` varchar(3) NOT NULL,
  `loan_type` varchar(30) NOT NULL,
  `interest` varchar(10) DEFAULT '',
  `group_id` varchar(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `was_cs_loan_type`
--

INSERT INTO `was_cs_loan_type` (`was_id`, `loan_type`, `interest`, `group_id`) VALUES
('101', 'Salary Loan', '', 'A');

-- --------------------------------------------------------

--
-- Table structure for table `was_cs_marital_status`
--

CREATE TABLE `was_cs_marital_status` (
  `was_id` varchar(3) NOT NULL,
  `marital_status` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `was_cs_marital_status`
--

INSERT INTO `was_cs_marital_status` (`was_id`, `marital_status`) VALUES
('101', 'Single'),
('102', 'Merried'),
('103', 'Divorce');

-- --------------------------------------------------------

--
-- Table structure for table `was_cs_nationality`
--

CREATE TABLE `was_cs_nationality` (
  `was_id` varchar(3) NOT NULL,
  `nationality` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `was_cs_nationality`
--

INSERT INTO `was_cs_nationality` (`was_id`, `nationality`) VALUES
('101', 'Cambodian'),
('102', 'Indonesian'),
('103', 'Malaysian'),
('104', 'Burmese'),
('105', 'Filipino'),
('106', 'Singaporean'),
('107', 'Thai'),
('108', 'Vietnamese');

-- --------------------------------------------------------

--
-- Table structure for table `was_cs_payment_method`
--

CREATE TABLE `was_cs_payment_method` (
  `was_id` varchar(3) NOT NULL,
  `payment_method` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `was_cs_payment_method`
--

INSERT INTO `was_cs_payment_method` (`was_id`, `payment_method`) VALUES
('101', 'Payment Method 1'),
('102', 'Payment Method 2');

-- --------------------------------------------------------

--
-- Table structure for table `was_cs_payment_mode`
--

CREATE TABLE `was_cs_payment_mode` (
  `was_id` varchar(3) NOT NULL,
  `payment_mode` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `was_cs_payment_mode`
--

INSERT INTO `was_cs_payment_mode` (`was_id`, `payment_mode`) VALUES
('101', 'Cash'),
('102', 'Credit Card'),
('103', 'Debit Card');

-- --------------------------------------------------------

--
-- Table structure for table `was_cs_payment_status`
--

CREATE TABLE `was_cs_payment_status` (
  `was_id` varchar(3) NOT NULL,
  `payment_status` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `was_cs_payment_status`
--

INSERT INTO `was_cs_payment_status` (`was_id`, `payment_status`) VALUES
('101', 'Paid'),
('102', 'Unpaid'),
('103', 'Hold'),
('104', 'Partial'),
('105', 'Cancel');

-- --------------------------------------------------------

--
-- Table structure for table `was_cs_product_location`
--

CREATE TABLE `was_cs_product_location` (
  `was_id` varchar(3) NOT NULL,
  `location` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `was_cs_product_location`
--

INSERT INTO `was_cs_product_location` (`was_id`, `location`) VALUES
('102', 'Pavillion'),
('101', 'Stock Room'),
('103', 'Reception'),
('104', 'Bar');

-- --------------------------------------------------------

--
-- Table structure for table `was_cs_product_method`
--

CREATE TABLE `was_cs_product_method` (
  `was_id` varchar(3) NOT NULL,
  `method` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `was_cs_product_method`
--

INSERT INTO `was_cs_product_method` (`was_id`, `method`) VALUES
('101', 'FIFO'),
('102', 'LIFO'),
('103', 'Average');

-- --------------------------------------------------------

--
-- Table structure for table `was_cs_product_type`
--

CREATE TABLE `was_cs_product_type` (
  `was_id` varchar(3) NOT NULL,
  `product_type` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `was_cs_product_type`
--

INSERT INTO `was_cs_product_type` (`was_id`, `product_type`) VALUES
('101', 'Retail'),
('102', 'Materials');

-- --------------------------------------------------------

--
-- Table structure for table `was_cs_purchase_status`
--

CREATE TABLE `was_cs_purchase_status` (
  `was_id` varchar(3) NOT NULL,
  `purchase_status` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `was_cs_purchase_status`
--

INSERT INTO `was_cs_purchase_status` (`was_id`, `purchase_status`) VALUES
('101', 'Open'),
('102', 'Closed'),
('103', 'Delivered'),
('104', 'Cancelled');

-- --------------------------------------------------------

--
-- Table structure for table `was_cs_rest_table_type`
--

CREATE TABLE `was_cs_rest_table_type` (
  `was_id` varchar(3) NOT NULL,
  `table_type` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `was_cs_rest_table_type`
--

INSERT INTO `was_cs_rest_table_type` (`was_id`, `table_type`) VALUES
('101', 'Type 1'),
('102', 'Type 2'),
('103', 'Type 3');

-- --------------------------------------------------------

--
-- Table structure for table `was_cs_salutation`
--

CREATE TABLE `was_cs_salutation` (
  `was_id` varchar(3) NOT NULL,
  `salutation` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `was_cs_salutation`
--

INSERT INTO `was_cs_salutation` (`was_id`, `salutation`) VALUES
('101', 'Mr'),
('102', 'Mrs'),
('103', 'Miss');

-- --------------------------------------------------------

--
-- Table structure for table `was_cs_shipping_method`
--

CREATE TABLE `was_cs_shipping_method` (
  `was_id` varchar(3) NOT NULL,
  `shipping_method` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `was_cs_shipping_method`
--

INSERT INTO `was_cs_shipping_method` (`was_id`, `shipping_method`) VALUES
('101', 'Shipping Method 1'),
('102', 'Shipping Method 2');

-- --------------------------------------------------------

--
-- Table structure for table `was_cs_tariff`
--

CREATE TABLE `was_cs_tariff` (
  `was_id` varchar(3) NOT NULL,
  `tariff` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `was_cs_tariff`
--

INSERT INTO `was_cs_tariff` (`was_id`, `tariff`) VALUES
('101', 'New Customer'),
('102', 'Regular Customer'),
('103', 'VIP');

-- --------------------------------------------------------

--
-- Table structure for table `was_cs_transaction_type`
--

CREATE TABLE `was_cs_transaction_type` (
  `was_id` varchar(3) NOT NULL,
  `transaction_type` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `was_cs_transaction_type`
--

INSERT INTO `was_cs_transaction_type` (`was_id`, `transaction_type`) VALUES
('101', 'Purchase'),
('102', 'Sales'),
('103', 'Load Card'),
('104', 'Reload');

-- --------------------------------------------------------

--
-- Table structure for table `was_cs_unit_measure`
--

CREATE TABLE `was_cs_unit_measure` (
  `was_id` varchar(3) NOT NULL,
  `unit_measure` varchar(30) NOT NULL,
  `group_id` varchar(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `was_cs_unit_measure`
--

INSERT INTO `was_cs_unit_measure` (`was_id`, `unit_measure`, `group_id`) VALUES
('101', 'n/a', 'A'),
('102', 'pcs', 'A'),
('201', 'liter', 'A'),
('103', 'meter', 'A');

-- --------------------------------------------------------

--
-- Table structure for table `was_cs_vendor_type`
--

CREATE TABLE `was_cs_vendor_type` (
  `was_id` varchar(3) NOT NULL,
  `vendor_type` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `was_cs_vendor_type`
--

INSERT INTO `was_cs_vendor_type` (`was_id`, `vendor_type`) VALUES
('101', 'Type 1'),
('102', 'Type 2');

-- --------------------------------------------------------

--
-- Table structure for table `was_customer_account`
--

CREATE TABLE `was_customer_account` (
  `account_number` varchar(10) NOT NULL,
  `record_date` varchar(10) NOT NULL,
  `link_number` varchar(10) NOT NULL,
  `customer_id` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `was_customer_account`
--

INSERT INTO `was_customer_account` (`account_number`, `record_date`, `link_number`, `customer_id`) VALUES
('1000000028', '02.09.2016', '1000000022', '0000000081');

-- --------------------------------------------------------

--
-- Table structure for table `was_customer_contact`
--

CREATE TABLE `was_customer_contact` (
  `customer_contact_id` mediumint(9) NOT NULL,
  `record_date` varchar(10) NOT NULL,
  `customer_id` varchar(10) NOT NULL,
  `address_category` varchar(3) NOT NULL,
  `contact_person` varchar(40) NOT NULL,
  `address_line_1` varchar(40) NOT NULL,
  `address_line_2` varchar(40) DEFAULT '',
  `address_line_3` varchar(40) DEFAULT '',
  `address_line_4` varchar(40) DEFAULT '',
  `city` varchar(3) NOT NULL,
  `country` varchar(3) NOT NULL,
  `zip_code` varchar(4) NOT NULL,
  `email` varchar(40) NOT NULL,
  `telephone` varchar(15) NOT NULL,
  `fax` varchar(15) NOT NULL,
  `mobile` varchar(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `was_customer_contact`
--

INSERT INTO `was_customer_contact` (`customer_contact_id`, `record_date`, `customer_id`, `address_category`, `contact_person`, `address_line_1`, `address_line_2`, `address_line_3`, `address_line_4`, `city`, `country`, `zip_code`, `email`, `telephone`, `fax`, `mobile`) VALUES
(3, '01.11.2016', '0000000081', '104', 'test', 'tes address', '', '', '', '103', '109', '1231', '3qw', '2131', 'qweq', 'qwe232'),
(8, '02.08.2016', '0000000081', '102', 'qweqwe', 'wewqe', 'wqewqe', 'wqeqwe', 'wqeqw', '103', '102', 'wewq', 'eqwe', 'weqwe', 'wweqw', 'qweqw'),
(9, '02.08.2016', '0000000081', '101', 'qqwe', 'q', 'w', '', '', '101', '101', 'weqw', 'qwe', 'qweqwe', 'wqeqw', 'qweqw'),
(10, '02.08.2016', '0000000081', '102', 'qwqwe', 'qwe', 'weqw', 'qwe', 'qwe', '101', '101', 'qwe', 'qwe', 'qweqw', 'qqwewe', 'qweqwe'),
(11, '02.08.2016', '0000000081', '103', 'qweq', 'qwe', 'qwe', 'qwe', 'qwe', '101', '102', 'qwe', 'qwe', 'qwe', 'qwe', 'qwe');

-- --------------------------------------------------------

--
-- Table structure for table `was_customer_info`
--

CREATE TABLE `was_customer_info` (
  `CUSTOMER_ID` varchar(10) NOT NULL,
  `RECORD_DATE` varchar(10) NOT NULL,
  `FIRST_NAME` varchar(30) NOT NULL,
  `LAST_NAME` varchar(30) NOT NULL,
  `GENDER` varchar(3) NOT NULL,
  `TARIFF` varchar(3) NOT NULL,
  `CUSTOMER_TYPE` varchar(3) NOT NULL,
  `ACCOUNT_NUMBER` varchar(19) DEFAULT '',
  `ACCOUNT_NAME` varchar(40) DEFAULT '',
  `BANK_NAME` varchar(40) DEFAULT '',
  `BRANCH` varchar(40) DEFAULT '',
  `CONTACT_NUMBER` varchar(15) NOT NULL,
  `EMAIL` varchar(30) NOT NULL,
  `FAX` varchar(30) DEFAULT '',
  `address` varchar(30) DEFAULT '',
  `city` varchar(3) DEFAULT '',
  `country` varchar(3) DEFAULT '',
  `has_multiple_address` varchar(1) DEFAULT '',
  `id_type` varchar(3) DEFAULT '',
  `id_number` varchar(15) DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `was_customer_info`
--

INSERT INTO `was_customer_info` (`CUSTOMER_ID`, `RECORD_DATE`, `FIRST_NAME`, `LAST_NAME`, `GENDER`, `TARIFF`, `CUSTOMER_TYPE`, `ACCOUNT_NUMBER`, `ACCOUNT_NAME`, `BANK_NAME`, `BRANCH`, `CONTACT_NUMBER`, `EMAIL`, `FAX`, `address`, `city`, `country`, `has_multiple_address`, `id_type`, `id_number`) VALUES
('0000000081', '01.11.2016', 'Juan', 'cruz', '101', '101', '101', '222131222', '', '', '', '312143', 's@yahoo.com', '2342w', '', '', '', '', '', ''),
('0000000090', '01.12.2016', 'bat', 'man', '101', '101', '101', '', '', '', '', '232', '23', '2323', '', '', '', '', '', ''),
('0000000091', '01.12.2016', 'Ro', 'Bin', '101', '101', '101', '', '', '', '', '212', '123', '123123', '', '', '', '', '', ''),
('0000000110', '', 'Juan', 'Dela Cruz', '101', '101', '101', '', '', '', '', '1234567898', 'a@test.com', '', 'Iloilo', '145', '130', '0', '101', '12322323342'),
('0000000111', '', 'Peter', 'Pendon', '101', '101', '101', '', '', '', '', '1234567890', 'a@gs.com', '', '121', '145', '102', '0', '101', '232131'),
('0000000112', '', 'Maria', 'Conchas', '102', '101', '101', '', '', '', '', '2323234423432', 'atest@yahoo.com', '', 'Iloilo', '147', '130', '0', '101', '234230000000'),
('0000000113', '', 'Jane', 'Franco', '102', '101', '101', '', '', '', '', '09336678978', 'jane@yahoo.com', '', 'Jaro', '145', '130', '0', '101', '12312312'),
('0000000114', '', 'Paul', 'Jacinto', '101', '101', '101', '', '', '', '', '09778905656', 'paul@yahoo.com', '', 'Lot 1', '146', '130', '0', '101', '22313'),
('0000000115', '02.21.2016', 'Claire', 'Samson', '102', '102', '101', '', '', '', '', '09996767456', 'claire@yahoo.com', '', 'St. Peter Subd.', '145', '130', '0', '102', '112213123123'),
('0000000116', '02.21.2016', 'Janice', 'Villafuerte', '102', '101', '101', '', '', '', '', '09993457675', 'janice@yahoo.com', '', 'St. Jane Subd.', '145', '130', '0', '102', '234234234');

-- --------------------------------------------------------

--
-- Table structure for table `was_customer_sale`
--

CREATE TABLE `was_customer_sale` (
  `customer_sale_id` mediumint(9) NOT NULL,
  `record_date` varchar(10) NOT NULL,
  `customer_id` varchar(10) NOT NULL,
  `shipping_method` varchar(3) NOT NULL,
  `payment_method` varchar(3) NOT NULL,
  `sales_representative` varchar(30) NOT NULL,
  `payment_terms` varchar(10) NOT NULL,
  `card_number` varchar(19) DEFAULT '',
  `cardholder_name` varchar(40) DEFAULT '',
  `expiry_date` varchar(5) DEFAULT '',
  `billing_address` varchar(40) DEFAULT '',
  `net_due` varchar(3) DEFAULT '',
  `discount` varchar(3) DEFAULT '',
  `percentage` varchar(3) DEFAULT '',
  `credit_limit` varchar(10) DEFAULT '',
  `credit_status` varchar(10) DEFAULT '',
  `receivable_gl` varchar(4) DEFAULT '',
  `revenue_gl` varchar(4) DEFAULT '',
  `discount_gl` varchar(4) DEFAULT '',
  `tax_gl` varchar(4) DEFAULT '',
  `surcharge_gl` varchar(4) DEFAULT '',
  `payment_gl` varchar(4) DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `was_customer_sale`
--

INSERT INTO `was_customer_sale` (`customer_sale_id`, `record_date`, `customer_id`, `shipping_method`, `payment_method`, `sales_representative`, `payment_terms`, `card_number`, `cardholder_name`, `expiry_date`, `billing_address`, `net_due`, `discount`, `percentage`, `credit_limit`, `credit_status`, `receivable_gl`, `revenue_gl`, `discount_gl`, `tax_gl`, `surcharge_gl`, `payment_gl`) VALUES
(3, '01.11.2016', '0000000081', '102', '101', 'qwe', 'dsa', 'sda', 'wdasd', 'ewq', 'qw', 'w21', 'qqw', 'w', 'q', 'q', '2003', '2005', '2006', '2007', '2004', '2004');

-- --------------------------------------------------------

--
-- Table structure for table `was_employee_info`
--

CREATE TABLE `was_employee_info` (
  `employee_id` int(6) UNSIGNED NOT NULL,
  `firstname` varchar(30) NOT NULL,
  `lastname` varchar(30) NOT NULL,
  `sss_id` varchar(30) DEFAULT NULL,
  `phil_health_id` varchar(50) DEFAULT NULL,
  `pag_ibig_id` varchar(50) DEFAULT NULL,
  `record_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `modified_date` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `was_gui_groups`
--

CREATE TABLE `was_gui_groups` (
  `group_id` mediumint(9) NOT NULL,
  `group_name` varchar(20) NOT NULL,
  `description` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `was_gui_groups`
--

INSERT INTO `was_gui_groups` (`group_id`, `group_name`, `description`) VALUES
(1, 'All Access', 'All Access');

-- --------------------------------------------------------

--
-- Table structure for table `was_gui_menu_tree`
--

CREATE TABLE `was_gui_menu_tree` (
  `node_number` int(4) NOT NULL,
  `menu_id` varchar(30) NOT NULL,
  `menu_name` varchar(30) NOT NULL,
  `parent_id` int(2) NOT NULL,
  `module_name` varchar(20) NOT NULL,
  `parent_path` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `was_gui_menu_tree`
--

INSERT INTO `was_gui_menu_tree` (`node_number`, `menu_id`, `menu_name`, `parent_id`, `module_name`, `parent_path`) VALUES
(1, 'parent_menu', 'Hotel Management', 0, 'hotel', '0'),
(2, 'hotel_room_details', 'Room Details', 1, 'hotel', '1'),
(3, 'rest_table_details', 'Table Details', 1, 'hotel', '1'),
(4, 'hotel_room_type_rpt', 'Room Type', 1, 'hotel', '1'),
(5, 'hotel_customer_info', 'Customer Info', 1, 'hotel', '1'),
(6, 'parent_menu', 'Purchasing to Payable', 0, 'purchasing', '0'),
(7, 'product_purchase', 'Purchase', 6, 'purchasing', '6'),
(8, 'product_receive', 'Receive', 6, 'purchasing', '6'),
(9, 'product_supplier', 'Supplier', 6, 'purchasing', '6'),
(10, 'parent_menu', 'Sales to Recievable', 0, 'sales', '0'),
(11, 'product_sales_order', 'Sales Order', 10, 'sales', '10'),
(12, 'product_sales_invoice', 'Sales Invoice', 10, 'sales', '10'),
(13, 'product_payment_receive', 'Receive Payment', 10, 'sales', '10'),
(14, 'parent_menu', 'Inventory', 0, 'inventory', '0'),
(15, 'acc_chart_of_acct', 'Chart of Account', 14, 'inventory', '14'),
(16, 'product_items', 'Items', 14, 'inventory', '14'),
(17, 'product_category', 'Categories', 14, 'inventory', '14'),
(18, 'inventory_mngt_rpt', 'Inventory Management', 14, 'inventory', '14'),
(19, 'parent_menu', 'Reports', 0, 'reports', '0'),
(20, 'parent_menu', 'Hotel', 19, 'hotelreports', '19'),
(21, 'hotel_room_activity_rpt', 'Room Activity', 20, 'hotelreports', '19,20'),
(22, 'hotel_revenue_rpt', 'Revenue', 20, 'hotelreports', '19,20');

-- --------------------------------------------------------

--
-- Table structure for table `was_gui_user_menu_tree`
--

CREATE TABLE `was_gui_user_menu_tree` (
  `group_id` varchar(8) NOT NULL,
  `node_number` int(4) NOT NULL,
  `menu_id` varchar(30) NOT NULL,
  `menu_name` varchar(30) NOT NULL,
  `parent_id` int(2) NOT NULL,
  `module_name` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `was_gui_user_menu_tree`
--

INSERT INTO `was_gui_user_menu_tree` (`group_id`, `node_number`, `menu_id`, `menu_name`, `parent_id`, `module_name`) VALUES
('1', 1, 'parent_menu', 'Hotel Management', 0, 'hotel'),
('1', 2, 'hotel_room_details', 'Room Details', 1, 'hotel'),
('1', 3, 'rest_table_details', 'Table Details', 1, 'hotel'),
('1', 4, 'hotel_room_type_rpt', 'Room Type', 1, 'hotel'),
('1', 5, 'hotel_customer_info', 'Customer Info', 1, 'hotel'),
('1', 6, 'parent_menu', 'Purchasing to Payable', 0, 'purchasing'),
('1', 7, 'product_purchase', 'Purchase', 6, 'purchasing'),
('1', 8, 'product_receive', 'Receive', 6, 'purchasing'),
('1', 9, 'product_supplier', 'Supplier', 6, 'purchasing'),
('1', 10, 'parent_menu', 'Sales to Recievable', 0, 'sales'),
('1', 11, 'product_sales_order', 'Sales Order', 10, 'sales'),
('1', 12, 'product_sales_invoice', 'Sales Invoice', 10, 'sales'),
('1', 13, 'product_payment_receive', 'Receive Payment', 10, 'sales'),
('1', 14, 'parent_menu', 'Inventory', 0, 'inventory'),
('1', 15, 'acc_chart_of_acct', 'Chart of Account', 14, 'inventory'),
('1', 16, 'product_items', 'Items', 14, 'inventory'),
('1', 17, 'product_category', 'Categories', 14, 'inventory'),
('1', 18, 'inventory_mngt_rpt', 'Inventory Management', 14, 'inventory'),
('1', 19, 'parent_menu', 'Reports', 0, 'reports'),
('1', 20, 'parent_menu', 'Hotel', 19, 'hotelreports'),
('1', 21, 'hotel_room_activity_rpt', 'Room Activity', 20, 'hotelreports'),
('1', 22, 'hotel_revenue_rpt', 'Revenue', 20, 'hotelreports');

-- --------------------------------------------------------

--
-- Table structure for table `was_hotel_book_transactions`
--

CREATE TABLE `was_hotel_book_transactions` (
  `transaction_id` varchar(10) NOT NULL,
  `transaction_date` varchar(10) NOT NULL,
  `transaction_time` varchar(8) NOT NULL,
  `customer_id` varchar(10) NOT NULL,
  `room_id` varchar(4) NOT NULL,
  `in_date` varchar(10) NOT NULL,
  `out_date` varchar(10) NOT NULL,
  `days` varchar(3) NOT NULL,
  `transaction_amount` varchar(10) NOT NULL,
  `book_status` varchar(1) NOT NULL,
  `number_of_adult` varchar(2) DEFAULT '',
  `number_of_minor` varchar(2) DEFAULT '',
  `userid` varchar(6) DEFAULT '',
  `deposit_mode` varchar(3) DEFAULT '',
  `deposit_amount` varchar(10) DEFAULT '',
  `payment_status` varchar(3) DEFAULT '',
  `room_status` varchar(3) DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `was_hotel_book_transactions`
--

INSERT INTO `was_hotel_book_transactions` (`transaction_id`, `transaction_date`, `transaction_time`, `customer_id`, `room_id`, `in_date`, `out_date`, `days`, `transaction_amount`, `book_status`, `number_of_adult`, `number_of_minor`, `userid`, `deposit_mode`, `deposit_amount`, `payment_status`, `room_status`) VALUES
('0000000271', '03.09.2016', '17:28:51', '0000000116', '202', '03.12.2016', '03.16.2016', '5', '7000.00', '0', '2', '0', '100010', '101', '0.00', '102', '110'),
('0000000278', '03.12.2016', '12:49:31', '0000000114', '102', '03.16.2016', '03.17.2016', '2', '1400.00', '0', '0', '0', '100010', '101', '0.00', '102', '110'),
('0000000282', '03.21.2016', '13:03:18', '0000000113', '301', '03.21.2016', '03.22.2016', '2', '2800.00', '0', '1', '0', '100010', '101', '0.00', '102', '110'),
('0000000283', '03.21.2016', '13:07:16', '0000000111', '303', '03.21.2016', '03.22.2016', '2', '2800.00', '0', '1', '0', '100010', '101', '0.00', '102', '110');

-- --------------------------------------------------------

--
-- Table structure for table `was_hotel_book_transactions_history`
--

CREATE TABLE `was_hotel_book_transactions_history` (
  `transaction_id` varchar(10) NOT NULL,
  `transaction_date` varchar(10) NOT NULL,
  `transaction_time` varchar(8) NOT NULL,
  `customer_id` varchar(10) NOT NULL,
  `room_id` varchar(4) NOT NULL,
  `in_date` varchar(10) NOT NULL,
  `out_date` varchar(10) NOT NULL,
  `days` varchar(3) NOT NULL,
  `transaction_amount` varchar(10) NOT NULL,
  `book_status` varchar(1) NOT NULL,
  `number_of_adult` varchar(2) DEFAULT '',
  `number_of_minor` varchar(2) DEFAULT '',
  `userid` varchar(6) DEFAULT '',
  `deposit_mode` varchar(3) DEFAULT '',
  `deposit_amount` varchar(10) DEFAULT '',
  `payment_status` varchar(3) DEFAULT '',
  `room_status` varchar(3) DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `was_hotel_book_transactions_history`
--

INSERT INTO `was_hotel_book_transactions_history` (`transaction_id`, `transaction_date`, `transaction_time`, `customer_id`, `room_id`, `in_date`, `out_date`, `days`, `transaction_amount`, `book_status`, `number_of_adult`, `number_of_minor`, `userid`, `deposit_mode`, `deposit_amount`, `payment_status`, `room_status`) VALUES
('0000000269', '03.09.2016', '13:03:24', '0000000110', '101', '03.09.2016', '03.11.2016', '2', '1400.00', '2', '2', '0', '', '101', '0.00', '101', '101'),
('0000000272', '03.09.2016', '18:00:37', '0000000114', '102', '03.10.2016', '03.11.2016', '1', '700.00', '2', '0', '0', '100010', '101', '0.00', '101', '101'),
('0000000273', '03.12.2016', '11:27:57', '0000000114', '102', '00.00.0000', '00.00.0000', '0', '0.00', '1', '0', '0', '100010', '101', '0.00', '101', '101'),
('0000000275', '03.12.2016', '12:06:37', '0000000112', '103', '03.10.2016', '03.13.2016', '4', '2800.00', '2', '2', '0', '100010', '101', '1000.00', '102', '110'),
('0000000276', '03.12.2016', '12:08:59', '0000000112', '103', '03.10.2016', '03.13.2016', '4', '2800.00', '2', '2', '0', '100010', '101', '1000.00', '101', '101'),
('0000000280', '03.21.2016', '12:54:16', '0000000115', '201', '03.21.2016', '03.22.2016', '2', '2400.00', '2', '1', '0', '', '101', '0.00', '101', '101'),
('0000000281', '03.21.2016', '13:02:41', '0000000116', '501', '03.21.2016', '03.23.2016', '3', '3600.00', '2', '1', '0', '100010', '101', '0.00', '101', '101'),
('0000000287', '03.22.2016', '17:55:20', '0000000110', '101', '00.00.0000', '00.00.0000', '0', '0.00', '1', '2', '0', '', '101', '0.00', '101', '101'),
('0000000288', '03.22.2016', '18:02:54', '0000000112', '103', '00.00.0000', '00.00.0000', '0', '0.00', '1', '2', '0', '100010', '101', '1000.00', '101', '101'),
('0000000291', '03.22.2016', '18:10:50', '0000000116', '501', '00.00.0000', '00.00.0000', '0', '0.00', '1', '1', '0', '100010', '101', '0.00', '101', '101'),
('0000000292', '03.22.2016', '18:11:04', '0000000110', '101', '03.22.2016', '03.23.2016', '1', '700.00', '2', '1', '0', '100010', '101', '0.00', '101', '101'),
('0000000303', '03.23.2016', '12:03:53', '0000000110', '101', '00.00.0000', '00.00.0000', '0', '0.00', '1', '1', '0', '100010', '101', '0.00', '101', '101'),
('undefined', '03.22.2016', '17:46:06', '0000000115', '201', '00.00.0000', '00.00.0000', '0', '0.00', '1', '1', '0', '', '101', '0.00', '101', '101');

-- --------------------------------------------------------

--
-- Table structure for table `was_hotel_customer_info`
--

CREATE TABLE `was_hotel_customer_info` (
  `customer_id` varchar(10) NOT NULL,
  `record_date` varchar(10) NOT NULL,
  `first_name` varchar(30) NOT NULL,
  `last_name` varchar(30) NOT NULL,
  `gender` varchar(3) NOT NULL,
  `contact_number` varchar(15) NOT NULL,
  `email` varchar(30) DEFAULT '',
  `address` varchar(30) NOT NULL,
  `city` varchar(3) NOT NULL,
  `country` varchar(3) NOT NULL,
  `id_number` varchar(30) DEFAULT '',
  `number_of_adult` varchar(2) NOT NULL,
  `number_of_minor` varchar(2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `was_hotel_customer_info`
--

INSERT INTO `was_hotel_customer_info` (`customer_id`, `record_date`, `first_name`, `last_name`, `gender`, `contact_number`, `email`, `address`, `city`, `country`, `id_number`, `number_of_adult`, `number_of_minor`) VALUES
('0000000097', '02.11.2016', 'ton', 'cam', '101', '1232434', 'test@gmail.com', 'leon', '130', '130', '', '2', '0'),
('0000000098', '02.11.2016', 'qweqwe', 'qweqwe', '101', '21323', '12312', '12321', '101', '101', '1123', '12', '13'),
('0000000103', '02.11.2016', '212', '123', '101', '123', '12312', '21312', '102', '102', '12312', '2', '1'),
('0000000104', '02.11.2016', '12312', 'wqq', '101', '123', '1212', '1212', '101', '101', '1212', '12', '12'),
('0000000105', '02.11.2016', 'test', 'qweqw', '101', '32', '23423', '23423', '104', '101', '23423', '22', '23'),
('0000000106', '02.11.2016', '121', '121', '101', '121', '12', '121', '102', '102', '121', '12', '12'),
('0000000107', '02.11.2016', 'qweqwe', 'qweqw', '101', '1212', '123', '12312', '102', '103', '12', '12', '1'),
('0000000108', '02.12.2016', 'weqe', 'qweqe', '101', '232', '2323', '231', '101', '101', '2132', '12', '1'),
('0000000109', '02.12.2016', 'weqe', 'qwe', '101', '23', '2323', '232', '101', '102', '232', '32', '2');

-- --------------------------------------------------------

--
-- Table structure for table `was_hotel_payment`
--

CREATE TABLE `was_hotel_payment` (
  `invoice_number` varchar(10) NOT NULL,
  `transaction_date` varchar(10) NOT NULL,
  `transaction_time` varchar(8) NOT NULL,
  `customer_id` varchar(10) NOT NULL,
  `room_id` varchar(4) NOT NULL,
  `payment_mode` varchar(3) NOT NULL,
  `transaction_amount` varchar(10) NOT NULL,
  `userid` varchar(6) DEFAULT '',
  `transaction_id` varchar(10) DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `was_hotel_payment`
--

INSERT INTO `was_hotel_payment` (`invoice_number`, `transaction_date`, `transaction_time`, `customer_id`, `room_id`, `payment_mode`, `transaction_amount`, `userid`, `transaction_id`) VALUES
('0000000149', '03.12.2016', '11:24:39', '0000000114', '102', '101', '1000.00', '100010', ''),
('0000000162', '03.22.2016', '17:56:02', '0000000112', '103', '101', '3000.00', '', ''),
('0000000163', '03.22.2016', '18:03:05', '0000000116', '501', '101', '4000.00', '100010', ''),
('0000000176', '03.23.2016', '12:03:40', '0000000110', '101', '101', '1000.00', '100010', '');

-- --------------------------------------------------------

--
-- Table structure for table `was_hotel_room_details`
--

CREATE TABLE `was_hotel_room_details` (
  `room_id` varchar(4) NOT NULL,
  `room_type` varchar(3) NOT NULL,
  `price` varchar(10) NOT NULL,
  `room_status` varchar(3) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `was_hotel_room_details`
--

INSERT INTO `was_hotel_room_details` (`room_id`, `room_type`, `price`, `room_status`) VALUES
('101', '101', '700.00', '108'),
('102', '101', '700.00', '108'),
('103', '101', '700.00', '108'),
('201', '102', '1200.00', '108'),
('202', '103', '1400.00', '108'),
('301', '103', '1400.00', '108'),
('302', '107', '1200.00', '108'),
('303', '103', '1400', '108'),
('501', '102', '1200.00', '108'),
('502', '102', '1200.00', '108');

-- --------------------------------------------------------

--
-- Table structure for table `was_hotel_room_type_desc`
--

CREATE TABLE `was_hotel_room_type_desc` (
  `inc_id` int(11) NOT NULL,
  `room_type` varchar(3) NOT NULL,
  `description` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `was_hotel_room_type_desc`
--

INSERT INTO `was_hotel_room_type_desc` (`inc_id`, `room_type`, `description`) VALUES
(17, '101', 'One single bed'),
(18, '101', 'Airconditioned'),
(19, '101', 'Hot and Cold Shower'),
(20, '101', 'Free wifi'),
(21, '101', 'Occupies 1 adult'),
(28, '110', 'One bedroom suit'),
(29, '110', 'Small living room'),
(30, '110', 'Hot and cold shower with bath tub'),
(31, '110', 'Airconditioned'),
(32, '110', 'Free wifi'),
(33, '110', 'Occupies 2 adults'),
(40, '103', 'Airconditioned'),
(41, '103', '1 bunk bed and 1 singe bed'),
(42, '103', 'Free wifi'),
(43, '102', 'One double bed'),
(44, '102', 'Airconditioned'),
(45, '102', 'Hot and cold shower'),
(46, '102', 'Free toiletries'),
(47, '102', 'Free Wifi'),
(48, '102', 'Occupies 2 adults');

-- --------------------------------------------------------

--
-- Table structure for table `was_journal_entry`
--

CREATE TABLE `was_journal_entry` (
  `auto_inc_id` int(10) UNSIGNED NOT NULL,
  `journal_id` varchar(10) NOT NULL,
  `narrative` varchar(50) NOT NULL,
  `account_type` varchar(4) DEFAULT NULL,
  `notes` varchar(100) DEFAULT NULL,
  `record_date` varchar(10) NOT NULL,
  `transaction_date` varchar(10) DEFAULT NULL,
  `credit` varchar(10) DEFAULT NULL,
  `debit` varchar(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `was_journal_entry`
--

INSERT INTO `was_journal_entry` (`auto_inc_id`, `journal_id`, `narrative`, `account_type`, `notes`, `record_date`, `transaction_date`, `credit`, `debit`) VALUES
(89, '0000000126', '2', '6008', 'First Journal', '09/30/2015', NULL, NULL, '10000.00'),
(90, '0000000126', '1', '1000', 'First Journal', '09/30/2015', NULL, '10000.00', NULL),
(91, '0000000126', '2', '6006', 'First Journal', '09/30/2015', NULL, NULL, '500.00'),
(92, '0000000126', '1', '1000', 'First Journal', '09/30/2015', NULL, '500.00', NULL),
(93, '0000000126', '2', '6007', 'First Journal', '09/30/2015', NULL, NULL, '2000.00'),
(94, '0000000126', '1', '1000', 'First Journal', '09/30/2015', NULL, '2000.00', NULL),
(95, '0000000126', '2', '1000', 'First Journal', '09/30/2015', NULL, NULL, '100000.00'),
(96, '0000000126', '1', '4000', 'First Journal', '09/30/2015', NULL, '100000.00', NULL),
(97, '0000000126', '2', '1005', 'First Journal', '09/30/2015', NULL, NULL, '4000.00'),
(98, '0000000126', '1', '4000', 'First Journal', '09/30/2015', NULL, '4000.00', NULL),
(99, '0000000126', '2', '6002', 'First Journal', '09/30/2015', NULL, NULL, '800.00'),
(100, '0000000126', '1', '1000', 'First Journal', '09/30/2015', NULL, '800.00', NULL),
(101, '0000000126', '2', '6000', 'First Journal', '09/30/2015', NULL, NULL, '8000.00'),
(102, '0000000126', '1', '1000', 'First Journal', '09/30/2015', NULL, '8000.00', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `was_journal_transaction`
--

CREATE TABLE `was_journal_transaction` (
  `transaction_type` varchar(3) NOT NULL,
  `notes` varchar(100) NOT NULL,
  `record_date` varchar(10) NOT NULL,
  `transaction_date` varchar(10) NOT NULL,
  `credit` decimal(10,2) DEFAULT NULL,
  `debit` decimal(10,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `was_loan_customer_addresses`
--

CREATE TABLE `was_loan_customer_addresses` (
  `inc_id` int(11) NOT NULL,
  `customer_id` varchar(10) NOT NULL,
  `record_date` varchar(10) NOT NULL,
  `address_type` varchar(3) NOT NULL,
  `address_line_1` varchar(30) NOT NULL,
  `address_line_2` varchar(30) DEFAULT '',
  `address_line_3` varchar(30) DEFAULT '',
  `contact_number` varchar(15) DEFAULT '',
  `zip_code` varchar(5) DEFAULT '',
  `country` varchar(3) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `was_loan_customer_addresses`
--

INSERT INTO `was_loan_customer_addresses` (`inc_id`, `customer_id`, `record_date`, `address_type`, `address_line_1`, `address_line_2`, `address_line_3`, `contact_number`, `zip_code`, `country`) VALUES
(1, '0000000092', '02.02.2016', '101', '23423qwewqeqqweqweq', '23423', '2342', '2342', '34234', '101'),
(4, '0000000092', '02.02.2016', '101', 'qweqwqwqw', 'qwe', 'qwe', 'wqe2', '2323', '116');

-- --------------------------------------------------------

--
-- Table structure for table `was_loan_customer_details`
--

CREATE TABLE `was_loan_customer_details` (
  `customer_id` varchar(10) NOT NULL,
  `record_date` varchar(10) NOT NULL,
  `salutation` varchar(3) NOT NULL,
  `first_name` varchar(30) NOT NULL,
  `middle_name` varchar(30) NOT NULL,
  `last_name` varchar(30) NOT NULL,
  `short_name` varchar(30) DEFAULT '',
  `gender` varchar(3) NOT NULL,
  `birth_date` varchar(10) NOT NULL,
  `mother_maiden_name` varchar(30) DEFAULT '',
  `customer_category` varchar(3) DEFAULT '',
  `country` varchar(3) NOT NULL,
  `nationality` varchar(3) NOT NULL,
  `language` varchar(3) NOT NULL,
  `mobile_number` varchar(15) DEFAULT '',
  `landline_number` varchar(15) DEFAULT '',
  `office_number` varchar(15) DEFAULT '',
  `fax` varchar(15) DEFAULT '',
  `email` varchar(30) DEFAULT '',
  `dependents` varchar(2) DEFAULT '',
  `marital_status` varchar(3) DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `was_loan_customer_details`
--

INSERT INTO `was_loan_customer_details` (`customer_id`, `record_date`, `salutation`, `first_name`, `middle_name`, `last_name`, `short_name`, `gender`, `birth_date`, `mother_maiden_name`, `customer_category`, `country`, `nationality`, `language`, `mobile_number`, `landline_number`, `office_number`, `fax`, `email`, `dependents`, `marital_status`) VALUES
('0000000092', '02.02.2016', '101', 'eqweqw', 'qweqw', 'qweqw', 'qweqw', '101', '11.11.1111', '', '', '101', '101', '101', '', '', '', '', '', '', ''),
('0000000096', '02.02.2016', '101', 'wqeqwe', 'qwe', 'wqe', 'qwe', '101', '11.11.1111', '', '', '101', '101', '101', '', '', '', '', '', '', '');

-- --------------------------------------------------------

--
-- Table structure for table `was_loan_employee_details`
--

CREATE TABLE `was_loan_employee_details` (
  `inc_id` int(11) NOT NULL,
  `customer_id` varchar(10) NOT NULL,
  `record_date` varchar(10) NOT NULL,
  `employment_type` varchar(3) NOT NULL,
  `employer_name` varchar(30) NOT NULL,
  `occupation` varchar(30) DEFAULT '',
  `designation` varchar(30) DEFAULT '',
  `employee_id` varchar(15) DEFAULT '',
  `address_line_1` varchar(30) NOT NULL,
  `address_line_2` varchar(30) DEFAULT '',
  `address_line_3` varchar(30) DEFAULT '',
  `zip_code` varchar(5) DEFAULT '',
  `country` varchar(3) NOT NULL,
  `phone_number` varchar(15) DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `was_loan_employee_details`
--

INSERT INTO `was_loan_employee_details` (`inc_id`, `customer_id`, `record_date`, `employment_type`, `employer_name`, `occupation`, `designation`, `employee_id`, `address_line_1`, `address_line_2`, `address_line_3`, `zip_code`, `country`, `phone_number`) VALUES
(1, '0000000092', '02.02.2016', '102', 'qweqwe123123', 'qwe', 'qwe', 'weqe', 'qweqweqwe', 'qwe', 'qwe', '2243', '101', '');

-- --------------------------------------------------------

--
-- Table structure for table `was_menu_tree`
--

CREATE TABLE `was_menu_tree` (
  `node_number` varchar(4) NOT NULL,
  `menu_id` varchar(30) NOT NULL,
  `menu_name` varchar(30) NOT NULL,
  `parent_menu` varchar(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `was_product`
--

CREATE TABLE `was_product` (
  `product_id` varchar(6) NOT NULL,
  `product_name` varchar(30) NOT NULL,
  `product_type` varchar(3) NOT NULL,
  `coa_type` varchar(4) NOT NULL,
  `category` varchar(30) NOT NULL,
  `supplier` varchar(6) NOT NULL,
  `cost_price` varchar(10) DEFAULT NULL,
  `selling_price` varchar(10) DEFAULT NULL,
  `note` varchar(30) NOT NULL,
  `discount` varchar(2) NOT NULL DEFAULT '0',
  `barcode` varchar(20) DEFAULT '',
  `reorder_quantity` varchar(6) DEFAULT '',
  `reorder_threshold` varchar(6) DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `was_product`
--

INSERT INTO `was_product` (`product_id`, `product_name`, `product_type`, `coa_type`, `category`, `supplier`, `cost_price`, `selling_price`, `note`, `discount`, `barcode`, `reorder_quantity`, `reorder_threshold`) VALUES
('000070', 'Bourbon', '101', '1003', '101101', '000116', NULL, NULL, 'Bourbon', '0', '', '100', '100'),
('000071', 'J&B', '101', '1003', '101101', '000116', NULL, NULL, 'J&B', '0', '', '100', '100'),
('000072', 'Johnnie Walker', '101', '1003', '101101', '000116', NULL, NULL, 'Johnnie Walker', '0', '', '100', '100'),
('000073', 'Irish Whiskey', '101', '1003', '101101', '000116', NULL, NULL, 'Irish Whiskey', '0', '', '100', '100'),
('000074', 'Brandy', '101', '1003', '101101', '000116', NULL, NULL, 'Brandy', '0', '', '100', '100'),
('000080', 'Red Horse', '101', '1003', '101101', '000116', '30.00', '25.00', 'red horse', '0', '', '100', '20'),
('000081', 'San Mig Light', '101', '1003', '101101', '000116', '28.00', '23.00', 'San Mig Light', '0', '', '100', '20'),
('000082', 'Coke', '101', '1003', '101102', '000116', '10.00', '15.00', 'Coke Regular', '0', '', '100', '10'),
('000083', 'Sprite', '101', '4000', '101102', '000116', '10.00', '15.00', 'Sprite', '0', '', '200', '10'),
('000084', 'Pepperoni', '101', '1003', '102104', '000117', '100.00', '150.00', 'Pepperoni', '0', '', '30', '2'),
('000085', 'Ham and Cheese', '102', '1000', '102102', '000116', '20.00', '30.00', 'Ham and Cheese', '0', '', '300', '40'),
('000086', 'Royal', '101', '1003', '101102', '000116', NULL, NULL, 'Royal', '0', '', '100', '100'),
('000087', 'Coke Zero', '101', '1003', '101102', '000116', NULL, NULL, 'Coke Zero', '0', '', '100', '100'),
('000088', 'Coke Light', '101', '1003', '101102', '000116', NULL, NULL, 'Coke Light', '0', '', '100', '100'),
('000090', 'Orange Juice', '101', '1003', '101103', '000117', NULL, NULL, 'Orange Juice', '0', '', '100', '100'),
('000091', 'Pineapple Juice', '101', '1003', '101103', '000117', NULL, NULL, 'Pineapple Juice', '0', '', '100', '100'),
('000092', 'Mango Juice', '101', '1003', '101103', '000117', NULL, NULL, 'Mango Juice', '0', '', '100', '100'),
('000098', 'Beer', '101', '1003', '101101', '000116', '1.00', '1.00', 'Beer', '1', '', '200', '30'),
('000100', 'Crispy Pata', '101', '1003', '102103', '000117', NULL, NULL, 'Crispy Pata', '0', '', '100', '100'),
('000101', 'Kare-kare', '101', '1003', '102103', '000117', NULL, NULL, 'Kare-kare', '0', '', '100', '2'),
('000102', 'Sinigang na Isda', '101', '1003', '102103', '000117', NULL, NULL, 'Sinigang na Isda', '0', '', '100', '100'),
('000103', 'Bulalo', '101', '1003', '102103', '000117', NULL, NULL, 'Bulalo', '0', '', '100', '100'),
('000104', 'Pork Sisig', '101', '1003', '102103', '000117', NULL, NULL, 'Pork Sisig', '0', '', '100', '100');

-- --------------------------------------------------------

--
-- Table structure for table `was_product_location_info`
--

CREATE TABLE `was_product_location_info` (
  `product_id` varchar(6) NOT NULL,
  `location` varchar(3) NOT NULL,
  `quantity` varchar(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `was_product_location_info`
--

INSERT INTO `was_product_location_info` (`product_id`, `location`, `quantity`) VALUES
('000048', '101', '2'),
('000031', '101', '10'),
('000031', '102', '10');

-- --------------------------------------------------------

--
-- Table structure for table `was_product_payment`
--

CREATE TABLE `was_product_payment` (
  `payment_id` varchar(10) NOT NULL,
  `invoice_number` varchar(10) NOT NULL,
  `due_date` varchar(10) NOT NULL,
  `due_amount` varchar(10) NOT NULL,
  `description` varchar(100) NOT NULL DEFAULT '',
  `discount` varchar(10) NOT NULL DEFAULT '',
  `amount` varchar(10) NOT NULL,
  `record_date` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `was_product_payment_header`
--

CREATE TABLE `was_product_payment_header` (
  `payment_id` varchar(15) NOT NULL,
  `customer_id` varchar(10) NOT NULL,
  `record_date` varchar(10) NOT NULL,
  `userid` varchar(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `was_product_price_info`
--

CREATE TABLE `was_product_price_info` (
  `record_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `product_id` varchar(6) DEFAULT NULL,
  `method` varchar(3) DEFAULT NULL,
  `normal_price` varchar(10) DEFAULT NULL,
  `last_purch_price` varchar(10) DEFAULT NULL,
  `discount` varchar(10) DEFAULT NULL,
  `cost_unit_measure` varchar(10) DEFAULT NULL,
  `cost_description` varchar(100) DEFAULT NULL,
  `cogs_account` varchar(4) DEFAULT '',
  `average_cost` varchar(4) DEFAULT '',
  `srp` varchar(10) DEFAULT NULL,
  `discounted` varchar(10) DEFAULT NULL,
  `wholesale` varchar(10) DEFAULT NULL,
  `selling_unit_measure` varchar(10) DEFAULT NULL,
  `selling_description` varchar(100) DEFAULT NULL,
  `income_account` varchar(4) DEFAULT '',
  `tax_code` varchar(6) DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `was_product_price_info`
--

INSERT INTO `was_product_price_info` (`record_date`, `product_id`, `method`, `normal_price`, `last_purch_price`, `discount`, `cost_unit_measure`, `cost_description`, `cogs_account`, `average_cost`, `srp`, `discounted`, `wholesale`, `selling_unit_measure`, `selling_description`, `income_account`, `tax_code`) VALUES
('2016-01-21 15:17:22', '000080', '101', '15.00', '15.00', '1', '101', 'Red Horse', '1000', '121', '20.00', '1', '1', '101', 'Red Horse', '1000', '111'),
('2016-02-13 14:30:54', '000081', '101', '18.00', '20.00', '0', '101', 'San Mig Light', '6008', '', '30.00', '0.00', '28', '101', 'San Mig Light', '4000', ''),
('2016-02-13 14:32:19', '000082', '101', '8.00', '8.00', '0', '101', 'Coke Regular', '6008', '', '20.00', '0.00', '20', '101', 'Coke Regular', '4000', ''),
('2016-02-13 14:33:24', '000083', '101', '8.00', '8.00', '0', '101', 'Sprite', '6008', '', '25.00', '0', '25', '101', 'Sprite', '4000', ''),
('2016-02-16 07:16:31', '000085', '101', '20.00', '20.00', '0', '101', 'Ham and Cheese', '6008', '', '35.00', '0.00', '35', '101', 'Ham and Cheese', '4000', ''),
('2016-02-16 08:49:32', '000101', '101', '150.00', '150.00', '0', '101', 'Kare-kare', '6008', '', '300.00', '300', '300', '101', 'Kare-kare', '4000', ''),
('2016-02-16 08:50:29', '000098', '101', '10.00', '10.00', '', '101', 'Beer', '6008', '', '30.00', '30', '30', '101', 'Beer', '4000', ''),
('2016-02-16 08:51:32', '000084', '101', '100.00', '100.00', '', '101', 'Pizza', '6008', '', '200.00', '200', '200', '101', 'Pizza', '4000', ''),
('2016-02-16 10:49:38', '000100', '101', '250.00', '250.00', '0', '101', 'Crispy Pata', '6008', '', '350.00', '350', '350', '101', 'Crispy Pata', '4000', ''),
('2016-02-16 11:16:47', '000102', '101', '120.00', '120.00', '0', '101', 'Sinigang na Isda', '1003', '', '280.00', '280', '0.00', '101', 'Sinigang na Isda', '4000', ''),
('2016-02-16 11:17:22', '000103', '101', '230.00', '230.00', '0', '101', 'Bulalo', '1003', '', '400.00', '400', '400', '101', 'Bulalo', '4000', ''),
('2016-02-16 11:17:52', '000104', '101', '90.00', '90.00', '0', '101', 'Pork Sisig', '1003', '', '170.00', '0', '170', '101', 'Pork Sisig', '4000', ''),
('2016-02-16 15:25:02', '000070', '101', '150.00', '150.00', '', '101', 'Bourbon', '1003', '', '250.00', '250', '250', '101', 'Bourbon', '4000', ''),
('2016-02-16 15:26:05', '000071', '101', '150.00', '150.00', '0', '101', 'J&B', '1003', '', '250.00', '250', '250', '101', 'J&B', '4000', ''),
('2016-02-16 15:27:11', '000072', '101', '150.00', '150.00', '0', '101', 'Johnnie Walker', '1003', '', '250.00', '250', '0.00', '101', 'Johnnie Walker', '4000', ''),
('2016-02-16 15:28:26', '000073', '101', '150.00', '150.00', '0', '101', 'Irish Whiskey', '1003', '', '250.00', '250', '250', '101', 'Irish Whiskey', '4000', ''),
('2016-02-16 15:29:46', '000074', '101', '150.00', '150.00', '0', '101', 'Brandy', '1003', '', '250.00', '250', '250', '101', 'Brandy', '4000', ''),
('2016-02-16 15:36:53', '000086', '101', '8.00', '8.00', '0', '101', 'Royal', '6008', '', '20.00', '20', '20', '101', 'Royal', '4000', ''),
('2016-02-16 15:38:38', '000087', '101', '8.00', '8.00', '0', '101', 'Coke Zero', '6008', '', '20.00', '20', '20', '101', 'Coke Zero', '4000', ''),
('2016-02-16 15:39:42', '000088', '101', '8.00', '8.00', '8', '101', 'Coke Light', '6008', '', '20.00', '20', '20', '101', 'Coke Light', '4000', ''),
('2016-02-16 15:41:08', '000090', '101', '15.00', '16.00', '15', '101', 'Orange Juice', '6008', '', '35.00', '35', '35', '101', 'Orange Juice', '4000', ''),
('2016-02-16 15:42:13', '000091', '101', '12.00', '12.00', '0', '101', 'Pineapple Juice', '6008', '', '35.00', '35', '35', '101', 'Pineapple Juice', '4000', ''),
('2016-02-16 15:43:16', '000092', '101', '13.00', '13.00', '13', '101', 'Mango Juice', '6008', '', '35.00', '35', '35', '101', 'Mango Juice', '4000', ''),
('2016-02-17 14:06:15', '000084', '101', '100.00', '100.00', '0', '101', 'Pepperoni', '6008', '', '200.00', '200', '200', '101', 'Pepperoni', '4000', '');

-- --------------------------------------------------------

--
-- Table structure for table `was_product_purchase`
--

CREATE TABLE `was_product_purchase` (
  `purchase_id` varchar(10) DEFAULT NULL,
  `record_date` varchar(10) NOT NULL,
  `product_id` varchar(6) NOT NULL,
  `quantity` varchar(10) NOT NULL,
  `description` varchar(30) NOT NULL,
  `cost_price` varchar(10) NOT NULL,
  `total_price` varchar(10) NOT NULL,
  `purchase_status` varchar(3) NOT NULL,
  `partial` varchar(6) DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `was_product_purchase`
--

INSERT INTO `was_product_purchase` (`purchase_id`, `record_date`, `product_id`, `quantity`, `description`, `cost_price`, `total_price`, `purchase_status`, `partial`) VALUES
('0000000242', '02.10.2016', '000080', '100', 'Red Horse', '15.00', '1500.00', '102', '100'),
('0000000243', '02.10.2016', '000081', '100', 'qeqweq', '15', '1500.00', '102', '100'),
('0000000244', '02.15.2016', '000081', '100', 'San Mig Light', '18.00', '1800.00', '102', '100'),
('0000000245', '02.15.2016', '000080', '100', 'Red Horse', '15.00', '1500.00', '102', '100'),
('0000000241', '02.08.2016', '000080', '100', 'Red Horse', '15.00', '1500.00', '102', '100'),
('0000000241', '02.08.2016', '000085', '200', 'Sandwhich', '25', '5000.00', '102', '200'),
('0000000246', '02.16.2016', '000080', '100', 'Red Horse', '15.00', '1500.00', '102', '100'),
('0000000246', '02.16.2016', '000081', '100', 'San Mig Light', '18.00', '1800.00', '102', '100'),
('0000000246', '02.16.2016', '000082', '100', 'Coke Regular', '8.00', '800.00', '102', '100'),
('0000000246', '02.16.2016', '000083', '200', 'Sprite', '8.00', '1600.00', '102', '200'),
('0000000246', '02.16.2016', '000098', '200', 'Beer', '10.00', '2000.00', '102', '200'),
('0000000247', '02.16.2016', '000084', '30', 'Pizza', '100.00', '3000.00', '102', '30'),
('0000000247', '02.16.2016', '000085', '300', 'Ham and Cheese', '20.00', '6000.00', '102', '300'),
('0000000247', '02.16.2016', '000098', '200', 'Beer', '10.00', '2000.00', '102', '200'),
('0000000247', '02.16.2016', '000101', '5', 'Kare-kare', '150.00', '750.00', '102', '5'),
('0000000248', '02.16.2016', '000100', '100', 'Crispy Pata', '250.00', '25000.00', '102', '100'),
('0000000249', '02.16.2016', '000102', '100', 'Sinigang na Isda', '120.00', '12000.00', '102', '100'),
('0000000249', '02.16.2016', '000102', '100', 'Sinigang na Isda', '120.00', '12000.00', '102', '100'),
('0000000249', '02.16.2016', '000104', '100', 'Pork Sisig', '90.00', '9000.00', '102', '100'),
('0000000250', '02.16.2016', '000104', '100', 'Pork Sisig', '90.00', '9000.00', '102', '100'),
('0000000250', '02.16.2016', '000103', '100', 'Bulalo', '230.00', '23000.00', '102', '100'),
('0000000251', '02.16.2016', '000070', '100', 'Bourbon', '150.00', '15000.00', '102', '100'),
('0000000251', '02.16.2016', '000071', '100', 'J&B', '150.00', '15000.00', '102', '100'),
('0000000251', '02.16.2016', '000072', '100', 'Johnnie Walker', '150.00', '15000.00', '102', '100'),
('0000000252', '02.16.2016', '000073', '100', 'Irish Whiskey', '150.00', '15000.00', '102', '100'),
('0000000252', '02.16.2016', '000074', '100', 'Brandy', '150.00', '15000.00', '102', '100'),
('0000000253', '02.16.2016', '000090', '100', 'Orange Juice', '15.00', '1500.00', '102', '100'),
('0000000253', '02.16.2016', '000091', '100', 'Pineapple Juice', '12.00', '1200.00', '102', '100'),
('0000000253', '02.16.2016', '000092', '100', 'Mango Juice', '13.00', '1300.00', '102', '100'),
('0000000254', '02.16.2016', '000086', '100', 'Royal', '8.00', '800.00', '102', '100'),
('0000000254', '02.16.2016', '000087', '100', 'Coke Zero', '8.00', '800.00', '102', '100'),
('0000000254', '02.16.2016', '000088', '100', 'Coke Light', '8.00', '800.00', '102', '100'),
('0000000255', '02.28.2016', '000074', '100', 'Brandy', '150.00', '15000.00', '102', '100'),
('0000000255', '02.28.2016', '000072', '100', 'Johnnie Walker', '150.00', '15000.00', '102', '100'),
('0000000255', '02.28.2016', '000080', '100', 'Red Horse', '15.00', '1500.00', '102', '100'),
('0000000255', '02.28.2016', '000087', '100', 'Coke Zero', '8.00', '800.00', '102', '100'),
('0000000255', '02.28.2016', '000084', '30', 'Pepperoni', '100.00', '3000.00', '102', '30'),
('0000000255', '02.28.2016', '000081', '100', 'San Mig Light', '18.00', '1800.00', '102', '100'),
('0000000255', '02.28.2016', '000083', '200', 'Sprite', '8.00', '1600.00', '102', '200'),
('0000000255', '02.28.2016', '000073', '100', 'Irish Whiskey', '150.00', '15000.00', '102', '100'),
('0000000255', '02.28.2016', '000088', '100', 'Coke Light', '8.00', '800.00', '102', '100'),
('0000000256', '03.04.2016', '000070', '100', 'Bourbon', '150.00', '15000.00', '102', '200'),
('0000000256', '03.04.2016', '000071', '100', 'J&B', '150.00', '15000.00', '102', '200'),
('0000000257', '03.04.2016', '000082', '100', 'Coke Regular', '8.00', '800.00', '102', '100'),
('0000000258', '03.04.2016', '000091', '100', 'Pineapple Juice', '12.00', '1200.00', '102', '100'),
('0000000259', '03.04.2016', '000073', '100', 'Irish Whiskey', '150.00', '15000.00', '102', '100'),
('0000000260', '03.04.2016', '000082', '100', 'Coke Regular', '8.00', '800.00', '102', '100'),
('0000000261', '03.04.2016', '000090', '100', 'Orange Juice', '15.00', '1500.00', '102', '100'),
('0000000262', '03.04.2016', '000086', '100', 'Royal', '8.00', '800.00', '102', '100'),
('0000000263', '03.26.2016', '000081', '100', 'San Mig Light', '18.00', '1800.00', '102', '0'),
('0000000269', '03.26.2016', '000082', '100', 'Coke Regular', '8.00', '800.00', '102', '0'),
('0000000271', '03.26.2016', '000083', '200', 'Sprite', '8.00', '1600.00', '102', '0'),
('0000000272', '03.26.2016', '000073', '100', 'Irish Whiskey', '150.00', '15000.00', '102', '0'),
('0000000307', '03.26.2016', '000087', '100', 'Coke Zero', '8.00', '800.00', '102', '100');

-- --------------------------------------------------------

--
-- Table structure for table `was_product_purchase_header`
--

CREATE TABLE `was_product_purchase_header` (
  `purchase_id` varchar(10) NOT NULL,
  `supplier_id` varchar(6) NOT NULL,
  `record_date` varchar(10) NOT NULL,
  `userid` varchar(6) NOT NULL,
  `invoice_number` varchar(10) DEFAULT '',
  `status` varchar(3) NOT NULL,
  `transaction_id` varchar(10) DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `was_product_purchase_header`
--

INSERT INTO `was_product_purchase_header` (`purchase_id`, `supplier_id`, `record_date`, `userid`, `invoice_number`, `status`, `transaction_id`) VALUES
('0000000241', '000116', '02.08.2016', '100010', '', '101', '0000000241'),
('0000000242', '000116', '02.10.2016', '100010', 'qwewq', '101', '0000000242'),
('0000000243', '000116', '02.10.2016', '100010', '', '101', '0000000243'),
('0000000244', '000116', '02.15.2016', '100010', '', '101', '0000000244'),
('0000000245', '000116', '02.15.2016', '100010', '', '101', '0000000245'),
('0000000246', '000117', '02.16.2016', '100010', '', '101', '0000000246'),
('0000000247', '000117', '02.16.2016', '100010', '', '101', '0000000247'),
('0000000248', '000116', '02.16.2016', '100010', '', '101', '0000000248'),
('0000000249', '000117', '02.16.2016', '100010', '', '101', '0000000249'),
('0000000250', '000117', '02.16.2016', '100010', '', '101', '0000000250'),
('0000000251', '000116', '02.16.2016', '100010', '', '101', '0000000251'),
('0000000252', '000117', '02.16.2016', '100010', '', '101', '0000000252'),
('0000000253', '000117', '02.16.2016', '100010', '', '101', '0000000253'),
('0000000254', '000116', '02.16.2016', '100010', '', '101', '0000000254'),
('0000000255', '000116', '02.28.2016', '100010', '', '101', '0000000255'),
('0000000256', '000116', '03.04.2016', '100010', '2323', '101', '0000000256'),
('0000000257', '000116', '03.04.2016', '100010', '', '101', '0000000257'),
('0000000258', '000116', '03.04.2016', '100010', '', '101', '0000000258'),
('0000000259', '000116', '03.04.2016', '100010', '', '101', '0000000259'),
('0000000260', '000117', '03.04.2016', '100010', '', '101', '0000000260'),
('0000000261', '000116', '03.04.2016', '100010', '', '101', '0000000261'),
('0000000262', '000116', '03.04.2016', '100010', '', '101', '0000000262'),
('0000000263', '000116', '03.26.2016', '100010', '', '101', '0000000263'),
('0000000271', '000116', '03.26.2016', '100010', '', '101', '0000000271'),
('0000000272', '000116', '03.26.2016', '100010', '', '101', '0000000272'),
('0000000307', '000117', '03.26.2016', '100010', '', '101', '0000000307');

-- --------------------------------------------------------

--
-- Table structure for table `was_product_receive`
--

CREATE TABLE `was_product_receive` (
  `receive_id` varchar(10) NOT NULL,
  `purchase_id` varchar(10) NOT NULL,
  `record_date` varchar(10) NOT NULL,
  `product_id` varchar(6) NOT NULL,
  `quantity` varchar(10) NOT NULL,
  `description` varchar(30) NOT NULL,
  `cost_price` varchar(10) NOT NULL,
  `total_price` varchar(10) NOT NULL,
  `purchase_status` varchar(3) NOT NULL,
  `location` varchar(3) DEFAULT NULL,
  `tab` varchar(1) NOT NULL,
  `gl_code` varchar(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `was_product_receive`
--

INSERT INTO `was_product_receive` (`receive_id`, `purchase_id`, `record_date`, `product_id`, `quantity`, `description`, `cost_price`, `total_price`, `purchase_status`, `location`, `tab`, `gl_code`) VALUES
('0000000120', '0000000241', '02.08.2016', '000080', '100', 'Red Horse', '15.00', '1500.00', '101', '104', '1', ''),
('0000000132', '0000000242', '02.10.2016', '000080', '1', 'Red Horse', '15.00', '15.00', '101', '104', '1', '2001'),
('0000000155', '0000000242', '02.15.2016', '000080', '99', 'Red Horse', '15.00', '1485.00', '101', '104', '2', '2001'),
('0000000155', '0000000243', '02.15.2016', '000081', '100', 'qeqweq', '15', '1500.00', '101', '104', '2', '2001'),
('0000000155', '0000000244', '02.15.2016', '000081', '100', 'San Mig Light', '18.00', '1800.00', '101', '104', '2', '2001'),
('0000000156', '0000000245', '02.15.2016', '000080', '100', 'Red Horse', '15.00', '1500.00', '101', '104', '2', '2001'),
('0000000162', '0000000241', '02.16.2016', '000080', '100', 'Red Horse', '15.00', '1500.00', '101', '102', '2', '6008'),
('0000000162', '0000000241', '02.16.2016', '000085', '200', 'Sandwhich', '25', '5000.00', '101', '102', '2', '6008'),
('0000000167', '0000000246', '02.16.2016', '000080', '100', 'Red Horse', '15.00', '1500.00', '101', '104', '2', '6008'),
('0000000167', '0000000246', '02.16.2016', '000081', '100', 'San Mig Light', '18.00', '1800.00', '101', '104', '2', '6008'),
('0000000167', '0000000246', '02.16.2016', '000082', '100', 'Coke Regular', '8.00', '800.00', '101', '104', '2', '6008'),
('0000000167', '0000000246', '02.16.2016', '000083', '200', 'Sprite', '8.00', '1600.00', '101', '104', '2', '6008'),
('0000000167', '0000000246', '02.16.2016', '000098', '200', 'Beer', '10.00', '2000.00', '101', '104', '2', '6008'),
('0000000169', '0000000247', '02.16.2016', '000084', '30', 'Pizza', '100.00', '3000.00', '101', '102', '2', '6008'),
('0000000169', '0000000247', '02.16.2016', '000085', '300', 'Ham and Cheese', '20.00', '6000.00', '101', '102', '2', '6008'),
('0000000169', '0000000247', '02.16.2016', '000098', '200', 'Beer', '10.00', '2000.00', '101', '102', '2', '6008'),
('0000000169', '0000000247', '02.16.2016', '000101', '5', 'Kare-kare', '150.00', '750.00', '101', '102', '2', '6008'),
('0000000170', '0000000248', '02.16.2016', '000100', '100', 'Crispy Pata', '250.00', '25000.00', '101', '102', '2', '6008'),
('0000000172', '0000000249', '02.16.2016', '000102', '100', 'Sinigang na Isda~100', '120.00', '12000.00', '101', '102', '2', '6008'),
('0000000172', '0000000249', '02.16.2016', '000104', '100', 'Pork Sisig', '90.00', '9000.00', '101', '102', '2', '6008'),
('0000000173', '0000000250', '02.16.2016', '000104', '100', 'Pork Sisig', '90.00', '9000.00', '101', '104', '2', '6008'),
('0000000173', '0000000250', '02.16.2016', '000103', '100', 'Bulalo', '230.00', '23000.00', '101', '104', '2', '6008'),
('0000000178', '0000000251', '02.16.2016', '000070', '100', 'Bourbon', '150.00', '15000.00', '101', '104', '2', '6008'),
('0000000178', '0000000251', '02.16.2016', '000071', '100', 'J&B', '150.00', '15000.00', '101', '104', '2', '6008'),
('0000000178', '0000000251', '02.16.2016', '000072', '100', 'Johnnie Walker', '150.00', '15000.00', '101', '104', '2', '6008'),
('0000000179', '0000000252', '02.16.2016', '000073', '100', 'Irish Whiskey', '150.00', '15000.00', '101', '104', '2', '3001'),
('0000000179', '0000000252', '02.16.2016', '000074', '100', 'Brandy', '150.00', '15000.00', '101', '104', '2', '6008'),
('0000000180', '0000000253', '02.16.2016', '000090', '100', 'Orange Juice', '15.00', '1500.00', '101', '102', '2', '6008'),
('0000000180', '0000000253', '02.16.2016', '000091', '100', 'Pineapple Juice', '12.00', '1200.00', '101', '102', '2', '6008'),
('0000000180', '0000000253', '02.16.2016', '000092', '100', 'Mango Juice', '13.00', '1300.00', '101', '102', '2', '6008'),
('0000000181', '0000000254', '02.16.2016', '000086', '100', 'Royal', '8.00', '800.00', '101', '104', '2', '6008'),
('0000000181', '0000000254', '02.16.2016', '000087', '100', 'Coke Zero', '8.00', '800.00', '101', '104', '2', '6008'),
('0000000181', '0000000254', '02.16.2016', '000088', '100', 'Coke Light', '8.00', '800.00', '101', '104', '2', '6008'),
('0000000244', '0000000255', '03.04.2016', '000074', '100', 'Brandy', '150.00', '15000.00', '101', '104', '2', '6008'),
('0000000244', '0000000255', '03.04.2016', '000072', '100', 'Johnnie Walker', '150.00', '15000.00', '101', '104', '2', '6008'),
('0000000244', '0000000255', '03.04.2016', '000080', '100', 'Red Horse', '15.00', '1500.00', '101', '104', '2', '6008'),
('0000000244', '0000000255', '03.04.2016', '000087', '100', 'Coke Zero', '8.00', '800.00', '101', '104', '2', '6008'),
('0000000244', '0000000255', '03.04.2016', '000084', '30', 'Pepperoni', '100.00', '3000.00', '101', '104', '2', '6008'),
('0000000244', '0000000255', '03.04.2016', '000081', '100', 'San Mig Light', '18.00', '1800.00', '101', '104', '2', '6008'),
('0000000244', '0000000255', '03.04.2016', '000083', '200', 'Sprite', '8.00', '1600.00', '101', '104', '2', '6008'),
('0000000244', '0000000255', '03.04.2016', '000073', '100', 'Irish Whiskey', '150.00', '15000.00', '101', '104', '2', '6008'),
('0000000244', '0000000255', '03.04.2016', '000088', '100', 'Coke Light', '8.00', '800.00', '101', '104', '2', '6008'),
('0000000245', '0000000256', '03.04.2016', '000070', '100', 'Bourbon', '150.00', '15000.00', '101', '104', '2', '6008'),
('0000000245', '0000000256', '03.04.2016', '000071', '100', 'J&B', '150.00', '15000.00', '101', '104', '2', '6008'),
('0000000246', '0000000257', '03.04.2016', '000082', '100', 'Coke Regular', '8.00', '800.00', '101', '104', '1', '2001'),
('0000000247', '0000000258', '03.04.2016', '000091', '100', 'Pineapple Juice', '12.00', '1200.00', '101', '102', '1', '2001'),
('0000000248', '0000000259', '03.04.2016', '000073', '100', 'Irish Whiskey', '150.00', '15000.00', '101', '104', '1', '2001'),
('0000000249', '0000000260', '03.04.2016', '000082', '100', 'Coke Regular', '8.00', '800.00', '101', '102', '1', '2001'),
('0000000250', '0000000261', '03.04.2016', '000090', '100', 'Orange Juice', '15.00', '1500.00', '101', '104', '1', '6001'),
('0000000251', '0000000262', '03.04.2016', '000086', '100', 'Royal', '8.00', '800.00', '101', '104', '1', '2001'),
('0000000308', '0000000307', '03.26.2016', '000087', '100', 'Coke Zero', '8.00', '800.00', '101', '104', '1', '2001'),
('0000000309', '0000000262', '03.26.2016', '000086', '100', 'Royal', '8.00', '800.00', '101', '104', '1', '2001');

-- --------------------------------------------------------

--
-- Table structure for table `was_product_receive_header`
--

CREATE TABLE `was_product_receive_header` (
  `receive_id` varchar(10) NOT NULL,
  `record_date` varchar(10) NOT NULL,
  `userid` varchar(6) NOT NULL,
  `invoice_number` varchar(10) DEFAULT '',
  `not_invoiced` varchar(1) DEFAULT '0',
  `supplier_id` varchar(6) DEFAULT NULL,
  `transaction_id` varchar(10) DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `was_product_receive_header`
--

INSERT INTO `was_product_receive_header` (`receive_id`, `record_date`, `userid`, `invoice_number`, `not_invoiced`, `supplier_id`, `transaction_id`) VALUES
('0000000120', '02.08.2016', '100010', '232323', '', '000116', '0000000120'),
('0000000132', '02.10.2016', '100010', 'sdasdasd', '', '000116', '0000000132'),
('0000000155', '02.15.2016', '100010', '24233243', '', '000116', '0000000155'),
('0000000156', '02.15.2016', '100010', 'qweqwe', '', '000116', '0000000156'),
('0000000162', '02.16.2016', '100010', '1001', '', '000116', '0000000162'),
('0000000167', '02.16.2016', '100010', '223331', '', '000117', '0000000167'),
('0000000169', '02.16.2016', '100010', '999877', '', '000117', '0000000169'),
('0000000170', '02.16.2016', '100010', '333333', '', '000116', '0000000170'),
('0000000172', '02.16.2016', '100010', '7777778', '', '000117', '0000000172'),
('0000000173', '02.16.2016', '100010', '3434343444', '', '000117', '0000000173'),
('0000000178', '02.16.2016', '100010', '7774950', '', '000116', '0000000178'),
('0000000179', '02.16.2016', '100010', '34222123', '', '000117', '0000000179'),
('0000000180', '02.16.2016', '100010', '444444', '', '000117', '0000000180'),
('0000000181', '02.16.2016', '100010', '33331', '', '000116', '0000000181'),
('0000000244', '03.04.2016', '100010', 'qweqwewq', '', '000116', '0000000244'),
('0000000245', '03.04.2016', '100010', 'eqwe23', '', '000116', '0000000245'),
('0000000246', '03.04.2016', '100010', '2233', '', '000116', '0000000246'),
('0000000247', '03.04.2016', '100010', 'weweew', '', '000116', '0000000247'),
('0000000248', '03.04.2016', '100010', '34534534', '', '000116', '0000000248'),
('0000000249', '03.04.2016', '100010', '23423', '', '', '0000000249'),
('0000000250', '03.04.2016', '100010', '34534', '', '000116', '0000000250'),
('0000000251', '03.04.2016', '100010', '53453', '', '000116', '0000000251'),
('0000000308', '03.26.2016', '100010', '2323', '', '000116', '0000000308'),
('0000000309', '03.26.2016', '100010', '2323232', '', '000116', '0000000309');

-- --------------------------------------------------------

--
-- Table structure for table `was_product_sales_invoice`
--

CREATE TABLE `was_product_sales_invoice` (
  `sales_id` varchar(10) NOT NULL,
  `product_id` varchar(6) NOT NULL,
  `price` varchar(10) NOT NULL,
  `quantity` varchar(10) NOT NULL,
  `discount` varchar(10) DEFAULT '',
  `discount_amount` varchar(10) DEFAULT '',
  `total_amount` varchar(10) DEFAULT '',
  `location` varchar(3) NOT NULL DEFAULT '',
  `description` varchar(100) NOT NULL DEFAULT '',
  `record_date` varchar(10) NOT NULL,
  `record_time` varchar(8) DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `was_product_sales_invoice`
--

INSERT INTO `was_product_sales_invoice` (`sales_id`, `product_id`, `price`, `quantity`, `discount`, `discount_amount`, `total_amount`, `location`, `description`, `record_date`, `record_time`) VALUES
('0000000279', '000070', '250.00', '1', '', '', '250.00', '104', 'Bourbon', '03.21.2016', '11:26:35'),
('0000000279', '000071', '250.00', '1', '', '', '250.00', '104', 'J&B', '03.21.2016', '11:26:35'),
('0000000151', '000070', '250.00', '1', '', '', '250.00', '104', 'Bourbon', '03.21.2016', '14:55:40'),
('0000000151', '000071', '250.00', '1', '', '', '250.00', '104', 'J&B', '03.21.2016', '14:55:40'),
('0000000152', '000081', '30.00', '1', '', '', '30.00', '104', 'San Mig Light', '03.21.2016', '15:07:43'),
('0000000152', '000070', '250.00', '1', '', '', '250.00', '104', 'Bourbon', '03.21.2016', '15:07:43'),
('0000000289', '000070', '250.00', '1', '', '', '250.00', '104', 'Bourbon', '03.22.2016', '18:07:56'),
('0000000290', '000071', '250.00', '1', '', '', '250.00', '104', 'J&B', '03.22.2016', '18:10:26'),
('0000000166', '000070', '250.00', '1', '', '', '250.00', '104', 'Bourbon', '03.22.2016', '18:14:32'),
('0000000294', '000070', '250.00', '1', '', '', '250.00', '104', 'Bourbon', '03.22.2016', '18:22:44'),
('0000000295', '000070', '250.00', '1', '', '', '250.00', '104', 'Bourbon', '03.23.2016', '11:18:35'),
('0000000296', '000071', '250.00', '1', '', '', '250.00', '104', 'J&B', '03.23.2016', '11:19:35'),
('0000000297', '000070', '250.00', '1', '', '', '250.00', '104', 'Bourbon', '03.23.2016', '11:32:03'),
('0000000298', '000071', '250.00', '1', '', '', '250.00', '104', 'J&B', '03.23.2016', '11:45:31'),
('0000000299', '000070', '250.00', '1', '', '', '250.00', '104', 'Bourbon', '03.23.2016', '11:47:59'),
('0000000300', '000072', '250.00', '1', '', '', '250.00', '104', 'Johnnie Walker', '03.23.2016', '11:48:27'),
('0000000301', '000071', '250.00', '1', '', '', '250.00', '104', 'J&B', '03.23.2016', '11:53:40'),
('0000000302', '000071', '250.00', '1', '', '', '250.00', '104', 'J&B', '03.23.2016', '12:01:47'),
('0000000304', '000073', '250.00', '1', '', '', '250.00', '104', 'Irish Whiskey', '03.23.2016', '12:08:39'),
('0000000305', '000073', '250.00', '1', '', '', '250.00', '104', 'Irish Whiskey', '03.23.2016', '12:28:33'),
('0000000306', '000071', '250.00', '1', '', '', '250.00', '104', 'J&B', '03.26.2016', '12:59:35');

-- --------------------------------------------------------

--
-- Table structure for table `was_product_sales_invoice_header`
--

CREATE TABLE `was_product_sales_invoice_header` (
  `invoice_number` varchar(15) NOT NULL,
  `sales_id` varchar(10) NOT NULL,
  `customer_id` varchar(10) NOT NULL,
  `record_date` varchar(10) NOT NULL,
  `userid` varchar(6) NOT NULL,
  `due_date` varchar(10) DEFAULT '',
  `payment_status` varchar(3) NOT NULL,
  `due_amount` varchar(10) NOT NULL,
  `actual_amount` varchar(10) NOT NULL,
  `card_number` varchar(16) DEFAULT '',
  `room_id` varchar(4) DEFAULT '',
  `record_time` varchar(8) DEFAULT '',
  `payment_mode` varchar(3) DEFAULT '',
  `transaction_id` varchar(10) DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `was_product_sales_invoice_header`
--

INSERT INTO `was_product_sales_invoice_header` (`invoice_number`, `sales_id`, `customer_id`, `record_date`, `userid`, `due_date`, `payment_status`, `due_amount`, `actual_amount`, `card_number`, `room_id`, `record_time`, `payment_mode`, `transaction_id`) VALUES
('0000000150', '0000000279', '0000000000', '03.21.2016', '100010', '', '101', '500.00', '500.00', '', '', '11:26:35', '101', '0000000279'),
('0000000164', '0000000289', '0000000000', '03.22.2016', '100010', '', '101', '250.00', '250.00', '', '', '18:07:56', '101', '0000000289'),
('0000000165', '0000000290', '0000000000', '03.22.2016', '100010', '', '101', '250.00', '250.00', '', '', '18:10:26', '101', '0000000290'),
('0000000167', '0000000294', '0000000000', '03.22.2016', '100010', '', '101', '250.00', '250.00', '', '', '18:22:44', '101', '0000000294'),
('0000000168', '0000000295', '0000000000', '03.23.2016', '100010', '', '101', '250.00', '250.00', '', '', '11:18:35', '101', '0000000295'),
('0000000169', '0000000296', '0000000000', '03.23.2016', '100010', '', '101', '250.00', '250.00', '', '', '11:19:35', '101', '0000000296'),
('0000000170', '0000000297', '0000000000', '03.23.2016', '100010', '', '101', '250.00', '250.00', '', '', '11:32:03', '101', '0000000297'),
('0000000171', '0000000298', '0000000000', '03.23.2016', '100010', '', '101', '250.00', '250.00', '', '', '11:45:31', '101', '0000000298'),
('0000000172', '0000000299', '0000000000', '03.23.2016', '100010', '', '101', '250.00', '250.00', '', '', '11:47:59', '101', '0000000299'),
('0000000173', '0000000300', '0000000000', '03.23.2016', '100010', '', '101', '250.00', '250.00', '', '', '11:48:27', '101', '0000000300'),
('0000000174', '0000000301', '0000000000', '03.23.2016', '100010', '', '101', '250.00', '250.00', '', '', '11:53:40', '101', '0000000301'),
('0000000175', '0000000302', '0000000000', '03.23.2016', '100010', '', '101', '250.00', '250.00', '', '', '12:01:47', '101', '0000000302'),
('0000000177', '0000000304', '0000000000', '03.23.2016', '100010', '', '101', '250.00', '250.00', '', '', '12:08:39', '101', '0000000304'),
('0000000178', '0000000305', '0000000000', '03.23.2016', '100010', '', '101', '250.00', '250.00', '', '', '12:28:33', '101', '0000000305'),
('0000000179', '0000000306', '0000000000', '03.26.2016', '100010', '', '101', '250.00', '250.00', '', '', '12:59:35', '101', '0000000306');

-- --------------------------------------------------------

--
-- Table structure for table `was_product_sales_order`
--

CREATE TABLE `was_product_sales_order` (
  `sales_id` varchar(10) NOT NULL,
  `product_id` varchar(6) NOT NULL,
  `price` varchar(10) NOT NULL,
  `quantity` varchar(10) NOT NULL,
  `discount` varchar(10) DEFAULT '',
  `discount_amount` varchar(10) DEFAULT '',
  `total_amount` varchar(10) DEFAULT '',
  `location` varchar(3) NOT NULL DEFAULT '',
  `description` varchar(100) NOT NULL DEFAULT '',
  `record_date` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `was_product_sales_order_header`
--

CREATE TABLE `was_product_sales_order_header` (
  `sales_id` varchar(10) NOT NULL,
  `customer_id` varchar(10) NOT NULL,
  `record_date` varchar(10) NOT NULL,
  `userid` varchar(6) NOT NULL,
  `status` varchar(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `was_rest_hold_transaction`
--

CREATE TABLE `was_rest_hold_transaction` (
  `sales_id` varchar(10) NOT NULL,
  `transaction_date` varchar(10) NOT NULL,
  `transaction_time` varchar(8) NOT NULL,
  `table_id` varchar(3) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `was_rest_hold_transaction`
--

INSERT INTO `was_rest_hold_transaction` (`sales_id`, `transaction_date`, `transaction_time`, `table_id`) VALUES
('0000000151', '03.21.2016', '14:55:40', ''),
('0000000152', '03.21.2016', '15:07:43', ''),
('0000000166', '03.22.2016', '18:14:32', ''),
('0000000279', '03.21.2016', '11:26:35', ''),
('0000000289', '03.22.2016', '18:07:56', ''),
('0000000290', '03.22.2016', '18:10:26', ''),
('0000000294', '03.22.2016', '18:22:44', ''),
('0000000295', '03.23.2016', '11:18:35', ''),
('0000000296', '03.23.2016', '11:19:35', ''),
('0000000297', '03.23.2016', '11:32:03', ''),
('0000000298', '03.23.2016', '11:45:31', ''),
('0000000299', '03.23.2016', '11:47:59', ''),
('0000000300', '03.23.2016', '11:48:27', ''),
('0000000301', '03.23.2016', '11:53:40', ''),
('0000000302', '03.23.2016', '12:01:47', ''),
('0000000304', '03.23.2016', '12:08:39', ''),
('0000000305', '03.23.2016', '12:28:33', ''),
('0000000306', '03.26.2016', '12:59:35', '');

-- --------------------------------------------------------

--
-- Table structure for table `was_rest_table_details`
--

CREATE TABLE `was_rest_table_details` (
  `table_id` varchar(4) NOT NULL,
  `table_type` varchar(3) NOT NULL,
  `table_status` varchar(3) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `was_rest_table_details`
--

INSERT INTO `was_rest_table_details` (`table_id`, `table_type`, `table_status`) VALUES
('1', '101', '108'),
('10', '101', '108'),
('11', '101', '108'),
('2', '101', '108'),
('3', '101', '108'),
('4', '101', '108'),
('5', '101', '108'),
('6', '101', '108'),
('7', '101', '108'),
('8', '101', '108'),
('9', '101', '108');

-- --------------------------------------------------------

--
-- Table structure for table `was_sale_info`
--

CREATE TABLE `was_sale_info` (
  `sale_id` varchar(10) NOT NULL,
  `customer_name` varchar(30) NOT NULL,
  `total_items` varchar(10) NOT NULL,
  `grand_total` varchar(10) NOT NULL,
  `record_date` varchar(10) NOT NULL,
  `customer_id` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `was_sale_info`
--

INSERT INTO `was_sale_info` (`sale_id`, `customer_name`, `total_items`, `grand_total`, `record_date`, `customer_id`) VALUES
('0000000077', 'Chiz Escudero', '3', '75401.20', '09.19.2015', ''),
('0000000079', 'Pinoy Aquino', '9', '202255.25', '09.19.2015', ''),
('0000000080', 'Jojo Binay', '9', '258173.00', '09.19.2015', '');

-- --------------------------------------------------------

--
-- Table structure for table `was_supplier`
--

CREATE TABLE `was_supplier` (
  `supplier_id` varchar(6) NOT NULL,
  `company_name` varchar(30) NOT NULL,
  `vendor_type` varchar(3) NOT NULL,
  `website` varchar(30) NOT NULL,
  `account_number` varchar(19) NOT NULL,
  `account_name` varchar(40) NOT NULL,
  `bank_name` varchar(40) NOT NULL,
  `branch` varchar(40) NOT NULL,
  `contact_person` varchar(40) NOT NULL,
  `position` varchar(30) DEFAULT NULL,
  `contact_number` varchar(15) NOT NULL,
  `fax` varchar(15) DEFAULT NULL,
  `email` varchar(30) DEFAULT NULL,
  `record_date` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `was_supplier`
--

INSERT INTO `was_supplier` (`supplier_id`, `company_name`, `vendor_type`, `website`, `account_number`, `account_name`, `bank_name`, `branch`, `contact_person`, `position`, `contact_number`, `fax`, `email`, `record_date`) VALUES
('000116', 'Vendor A', '101', 'www.vendorA.com', '000122034500', 'Vendor A Inc', 'Banco de Oro', 'Mandaluyong', 'Mr. Roger Tuloso', 'Senior Sales Manager', '09457785690', '63023357870', 'rtuloso@vendorA.com', '02.08.2016'),
('000117', 'Vendor B', '101', 'www.vendorB.com', '30045678001', 'Vendor B', 'BPI', 'Cebu Fuentes', 'Ms. Diana Yap', 'Operations Manager', '3367323', '033374846', 'yap@vendorB.com', '02.13.2016');

-- --------------------------------------------------------

--
-- Table structure for table `was_supplier_address`
--

CREATE TABLE `was_supplier_address` (
  `supplier_address_id` mediumint(9) NOT NULL,
  `record_date` varchar(10) NOT NULL,
  `supplier_id` varchar(6) NOT NULL,
  `address_category` varchar(3) NOT NULL,
  `contact_person` varchar(40) NOT NULL,
  `address_line_1` varchar(40) NOT NULL,
  `address_line_2` varchar(40) DEFAULT '',
  `address_line_3` varchar(40) DEFAULT '',
  `address_line_4` varchar(40) DEFAULT '',
  `city` varchar(3) NOT NULL,
  `country` varchar(3) NOT NULL,
  `zip_code` varchar(4) NOT NULL,
  `email` varchar(40) NOT NULL,
  `telephone` varchar(15) NOT NULL,
  `mobile` varchar(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `was_supplier_address`
--

INSERT INTO `was_supplier_address` (`supplier_address_id`, `record_date`, `supplier_id`, `address_category`, `contact_person`, `address_line_1`, `address_line_2`, `address_line_3`, `address_line_4`, `city`, `country`, `zip_code`, `email`, `telephone`, `mobile`) VALUES
(1, '02.09.2016', '000116', '101', '21322', '24234', '', '', '', '101', '102', '3423', '32423', '23424', '3423'),
(2, '02.13.2016', '000117', '101', 'Ms. Dianna Yap', 'YRW Bldg', 'Santa Ana St.', '', '', '104', '130', '4000', 'yap@vendorB.com', '3345678', '09956637273');

-- --------------------------------------------------------

--
-- Table structure for table `was_supplier_purchase`
--

CREATE TABLE `was_supplier_purchase` (
  `supplier_purchase_id` mediumint(9) NOT NULL,
  `record_date` varchar(10) NOT NULL,
  `supplier_id` varchar(6) NOT NULL,
  `shipping_method` varchar(3) NOT NULL,
  `payment_method` varchar(3) NOT NULL,
  `net_due` varchar(3) NOT NULL,
  `discount` varchar(3) NOT NULL,
  `percentage` varchar(3) NOT NULL,
  `credit_limit` varchar(10) NOT NULL,
  `payable_gl` varchar(4) NOT NULL,
  `discount_gl` varchar(4) NOT NULL,
  `tax_gl` varchar(4) NOT NULL,
  `surcharge_gl` varchar(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `was_supplier_purchase`
--

INSERT INTO `was_supplier_purchase` (`supplier_purchase_id`, `record_date`, `supplier_id`, `shipping_method`, `payment_method`, `net_due`, `discount`, `percentage`, `credit_limit`, `payable_gl`, `discount_gl`, `tax_gl`, `surcharge_gl`) VALUES
(1, '02.09.2016', '000116', '101', '101', '232', '234', '424', '234234', '1000', '1000', '1001', '1000');

-- --------------------------------------------------------

--
-- Table structure for table `was_top_up`
--

CREATE TABLE `was_top_up` (
  `transaction_id` varchar(10) NOT NULL,
  `record_date` varchar(10) NOT NULL,
  `customer_id` varchar(10) NOT NULL,
  `card_number` varchar(15) NOT NULL,
  `amount` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `was_top_up`
--

INSERT INTO `was_top_up` (`transaction_id`, `record_date`, `customer_id`, `card_number`, `amount`) VALUES
('0000000558', '11.24.2015', '0000000072', '987654321', '100.00'),
('0000000559', '11.24.2015', '0000000072', '987654321', '200.00');

-- --------------------------------------------------------

--
-- Table structure for table `was_transaction_description`
--

CREATE TABLE `was_transaction_description` (
  `was_id` varchar(3) NOT NULL,
  `description` varchar(10) NOT NULL,
  `cr_dr` varchar(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `was_transaction_description`
--

INSERT INTO `was_transaction_description` (`was_id`, `description`, `cr_dr`) VALUES
('1', 'Accounts R', '1'),
('2', 'Accounts P', '2'),
('3', 'Office Sup', '2'),
('4', 'Electricit', '2'),
('5', 'Telephone ', '2'),
('6', 'Miscellane', '2');

-- --------------------------------------------------------

--
-- Table structure for table `was_transaction_details`
--

CREATE TABLE `was_transaction_details` (
  `reference_number` varchar(10) NOT NULL,
  `transaction_id` varchar(10) DEFAULT '',
  `debit` varchar(15) DEFAULT '',
  `credit` varchar(15) DEFAULT '',
  `gl_id` varchar(8) DEFAULT '',
  `gl_category` varchar(30) DEFAULT '',
  `eod_date` varchar(10) DEFAULT '',
  `transaction_date` varchar(10) DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `was_user_info`
--

CREATE TABLE `was_user_info` (
  `userid` varchar(6) NOT NULL,
  `username` varchar(30) NOT NULL,
  `firstname` varchar(30) NOT NULL,
  `lastname` varchar(30) NOT NULL,
  `password` varchar(130) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `record_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `modified_date` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `role` varchar(130) DEFAULT NULL,
  `groups` varchar(130) DEFAULT NULL,
  `institution_id` varchar(4) DEFAULT NULL,
  `current_login` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `last_login` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `last_logoff` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `password_status` varchar(1) NOT NULL,
  `password_failed` varchar(2) NOT NULL,
  `modules` varchar(10) DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `was_user_info`
--

INSERT INTO `was_user_info` (`userid`, `username`, `firstname`, `lastname`, `password`, `email`, `record_date`, `modified_date`, `role`, `groups`, `institution_id`, `current_login`, `last_login`, `last_logoff`, `password_status`, `password_failed`, `modules`) VALUES
('100010', 'admin', 'admin', 'ako', '6328E9133A9158A5BA00C6E2CF063295940851D5447E05555FE38DB2F251634DD3B954ADA238793C0BD9B7A74C0E173B8A2A2485B0CDD36E04FF1B2A1F58E889', '222', '2016-03-26 08:57:32', '2015-09-19 04:47:08', 'mxB4mOx6YWnkPfiRA9Fz4+NLf9Y1nxS8VFxzWnnhTfU=', '1', '1001', '2016-03-26 08:57:32', '2016-03-26 03:50:06', '2016-03-22 09:09:24', '1', '0', '11'),
('200088', 'DEV', 'Ako si', 'BatMan', '5EA1414192FF9C64DDD6F3E5DE24791720B53B89DD5575061E995B1879241936BE475B82E594AE47669ABA7761DC128238E2EA39D154CC9AF839CB49FDB5CCD8', NULL, '2016-03-04 04:34:58', '0000-00-00 00:00:00', 'YWSoKV9j4CfTNbs5Ngfp4Q==', '', '1001', '2016-03-04 04:34:45', '2016-03-04 04:32:42', '2016-03-04 04:34:58', '1', '0', '10'),
('200089', 'demo', 'demo', 'user', 'B0BBDC3978E82BDC7ADF42A872C188A12FC6D323A705CF556D1EFF3668506B570ED77B844BA5F4EC940FB83657AF0960657AC38C29994AD78A2A165A61731407', NULL, '2016-03-04 06:41:48', '0000-00-00 00:00:00', '', '1', '1001', '2016-03-04 06:41:35', '2016-03-04 04:36:32', '2016-03-04 06:41:48', '1', '0', '11');

-- --------------------------------------------------------

--
-- Structure for view `view_card_transaction_history`
--
DROP TABLE IF EXISTS `view_card_transaction_history`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_card_transaction_history`  AS  select `details`.`card_number` AS `card_number`,`details`.`transaction_id` AS `transaction_id`,`details`.`transaction_date` AS `transaction_date`,`details`.`transaction_time` AS `transaction_time`,`details`.`transaction_type` AS `transaction_type_id`,`type`.`transaction_type` AS `transaction_type_txt`,`details`.`transaction_amount` AS `credit_amount`,'' AS `debit_amount` from (`was_card_transaction_details` `details` join `was_cs_transaction_type` `type`) where (`details`.`transaction_type` = `type`.`was_id`) union all select `header`.`card_number` AS `card_number`,`sales`.`sales_id` AS `sales_id`,`sales`.`record_date` AS `record_date`,`sales`.`record_time` AS `record_time`,'102' AS `102`,'Sales' AS `Sales`,'' AS `credit_amount`,`sales`.`total_amount` AS `debit_amount` from (`was_product_sales_invoice` `sales` join `was_product_sales_invoice_header` `header`) where ((`sales`.`sales_id` = `header`.`sales_id`) and (`header`.`card_number` <> '')) ;

-- --------------------------------------------------------

--
-- Structure for view `view_daily_products_sale`
--
DROP TABLE IF EXISTS `view_daily_products_sale`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_daily_products_sale`  AS  select `prod`.`product_id` AS `product_id`,`prod`.`product_name` AS `product_name`,`sale`.`quantity` AS `quantity`,`sale`.`total_amount` AS `total_amount`,`sale`.`record_date` AS `record_date` from (`was_product` `prod` join `was_product_sales_order` `sale`) where (`prod`.`product_id` = `sale`.`product_id`) order by `prod`.`product_name` ;

-- --------------------------------------------------------

--
-- Structure for view `view_hotel_book_transactions`
--
DROP TABLE IF EXISTS `view_hotel_book_transactions`;

CREATE ALGORITHM=UNDEFINED DEFINER=`` SQL SECURITY DEFINER VIEW `view_hotel_book_transactions`  AS  select `trans`.`transaction_id` AS `transaction_id`,`trans`.`transaction_date` AS `transaction_date`,`trans`.`transaction_time` AS `transaction_time`,`trans`.`customer_id` AS `customer_id`,concat(`cust`.`FIRST_NAME`,' ',`cust`.`LAST_NAME`) AS `customer_name`,`trans`.`room_id` AS `room_id`,`trans`.`in_date` AS `in_date`,`trans`.`out_date` AS `out_date`,`trans`.`days` AS `days`,`trans`.`transaction_amount` AS `transaction_amount`,`trans`.`book_status` AS `book_status`,`trans`.`number_of_adult` AS `number_of_adult`,`trans`.`number_of_minor` AS `number_of_minor`,`trans`.`userid` AS `userid`,`user`.`username` AS `username`,`trans`.`room_status` AS `room_status_id`,`status`.`room_status` AS `room_status_txt` from (((`was_hotel_book_transactions` `trans` join `was_user_info` `user`) join `was_customer_info` `cust`) join `was_cs_hotel_room_status` `status`) where ((`trans`.`userid` = `user`.`userid`) and (`trans`.`customer_id` = `cust`.`CUSTOMER_ID`) and (`trans`.`room_status` = `status`.`was_id`)) union all select `trans`.`transaction_id` AS `transaction_id`,`trans`.`transaction_date` AS `transaction_date`,`trans`.`transaction_time` AS `transaction_time`,`trans`.`customer_id` AS `customer_id`,concat(`cust`.`FIRST_NAME`,' ',`cust`.`LAST_NAME`) AS `customer_name`,`trans`.`room_id` AS `room_id`,`trans`.`in_date` AS `in_date`,`trans`.`out_date` AS `out_date`,`trans`.`days` AS `days`,`trans`.`transaction_amount` AS `transaction_amount`,`trans`.`book_status` AS `book_status`,`trans`.`number_of_adult` AS `number_of_adult`,`trans`.`number_of_minor` AS `number_of_minor`,`trans`.`userid` AS `userid`,`user`.`username` AS `username`,`trans`.`room_status` AS `room_status_id`,`status`.`room_status` AS `room_status_txt` from (((`was_hotel_book_transactions_history` `trans` join `was_user_info` `user`) join `was_customer_info` `cust`) join `was_cs_hotel_room_status` `status`) where ((`trans`.`userid` = `user`.`userid`) and (`trans`.`customer_id` = `cust`.`CUSTOMER_ID`) and (`trans`.`room_status` = `status`.`was_id`)) ;

-- --------------------------------------------------------

--
-- Structure for view `view_hotel_revenue`
--
DROP TABLE IF EXISTS `view_hotel_revenue`;

CREATE ALGORITHM=UNDEFINED DEFINER=`` SQL SECURITY DEFINER VIEW `view_hotel_revenue`  AS  select concat('S',`hotel`.`invoice_number`) AS `sales_invoice_number`,`hotel`.`transaction_date` AS `transaction_date`,`hotel`.`transaction_amount` AS `transaction_amount`,`hotel`.`userid` AS `userid`,concat(`user`.`firstname`,' ',`user`.`lastname`) AS `user_fullname`,'1' AS `location`,'Hotel' AS `location_txt` from (`was_hotel_payment` `hotel` join `was_user_info` `user`) where (`hotel`.`userid` = `user`.`userid`) union all select concat('S',`sales`.`invoice_number`) AS `concat('S',invoice_number)`,`sales`.`record_date` AS `record_date`,`sales`.`actual_amount` AS `actual_amount`,`sales`.`userid` AS `userid`,concat(`user`.`firstname`,' ',`user`.`lastname`) AS `concat(user.firstname, " ", user.lastname)`,'2' AS `2`,'Restaurant' AS `Restaurant` from (`was_product_sales_invoice_header` `sales` join `was_user_info` `user`) where (`sales`.`userid` = `user`.`userid`) ;

-- --------------------------------------------------------

--
-- Structure for view `view_hotel_transactions_status`
--
DROP TABLE IF EXISTS `view_hotel_transactions_status`;

CREATE ALGORITHM=UNDEFINED DEFINER=`` SQL SECURITY DEFINER VIEW `view_hotel_transactions_status`  AS  select `trans`.`transaction_id` AS `transaction_id`,`trans`.`transaction_date` AS `transaction_date`,`trans`.`transaction_time` AS `transaction_time`,`trans`.`customer_id` AS `customer_id`,`trans`.`room_id` AS `room_id`,`trans`.`transaction_amount` AS `transaction_amount`,'Room' AS `description`,`trans`.`payment_status` AS `payment_status_id`,`status`.`payment_status` AS `payment_status_txt` from (`was_hotel_book_transactions` `trans` join `was_cs_payment_status` `status`) where (`trans`.`payment_status` = `status`.`was_id`) union all select `trans`.`sales_id` AS `sales_id`,`trans`.`record_date` AS `record_date`,`trans`.`record_time` AS `record_time`,`trans`.`customer_id` AS `customer_id`,`trans`.`room_id` AS `room_id`,`trans`.`actual_amount` AS `actual_amount`,'Restaurant' AS `Restaurant`,`trans`.`payment_status` AS `payment_status_id`,`status`.`payment_status` AS `payment_status_txt` from (`was_product_sales_invoice_header` `trans` join `was_cs_payment_status` `status`) where ((`trans`.`payment_status` = `status`.`was_id`) and (`trans`.`room_id` <> '')) ;

-- --------------------------------------------------------

--
-- Structure for view `view_product_available`
--
DROP TABLE IF EXISTS `view_product_available`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_product_available`  AS  select `view_product_info`.`product_id` AS `product_id`,`view_product_info`.`product_name` AS `product_name`,`view_product_info`.`category` AS `category`,`view_product_info`.`selling_price` AS `selling_price`,`view_product_info`.`discount` AS `discount`,sum((`view_product_info`.`product_in` - `view_product_info`.`product_out`)) AS `available` from `view_product_info` group by `view_product_info`.`product_id` ;

-- --------------------------------------------------------

--
-- Structure for view `view_product_info`
--
DROP TABLE IF EXISTS `view_product_info`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_product_info`  AS  select distinct concat('PO-',`rec`.`purchase_id`) AS `reference_number`,`prod`.`product_id` AS `product_id`,`prod`.`product_name` AS `product_name`,`prod`.`category` AS `category`,`prod`.`reorder_threshold` AS `reorder_threshold`,`price`.`normal_price` AS `cost_price`,`price`.`srp` AS `selling_price`,`price`.`discounted` AS `discount`,`rec`.`quantity` AS `product_in`,0 AS `product_out`,1 AS `type`,`rec`.`record_date` AS `record_date`,`rec`.`description` AS `description`,`rec`.`location` AS `location`,`loc`.`location` AS `location_text` from (((`was_product` `prod` join `was_product_price_info` `price`) join `was_product_receive` `rec`) join `was_cs_product_location` `loc`) where ((`prod`.`product_id` = `rec`.`product_id`) and (`prod`.`product_id` = `price`.`product_id`) and (`rec`.`location` = `loc`.`was_id`) and (`price`.`record_date` = (select max(`was_product_price_info`.`record_date`) from `was_product_price_info` where (`was_product_price_info`.`product_id` = `prod`.`product_id`)))) union all select distinct concat('SO-',`sale`.`sales_id`) AS `reference_number`,`prod`.`product_id` AS `product_id`,`prod`.`product_name` AS `product_name`,`prod`.`category` AS `category`,`prod`.`reorder_threshold` AS `reorder_threshold`,`price`.`normal_price` AS `cost_price`,`price`.`srp` AS `selling_price`,`price`.`discounted` AS `discount`,0 AS `quantity_in`,`sale`.`quantity` AS `quantity_out`,2 AS `type`,`sale`.`record_date` AS `record_date`,'Sales' AS `Sales`,`sale`.`location` AS `location`,`loc`.`location` AS `location` from (((`was_product` `prod` join `was_product_price_info` `price`) join `was_product_sales_invoice` `sale`) join `was_cs_product_location` `loc`) where ((`prod`.`product_id` = `price`.`product_id`) and (`prod`.`product_id` = `sale`.`product_id`) and (`sale`.`location` = `loc`.`was_id`) and (`price`.`record_date` = (select max(`was_product_price_info`.`record_date`) from `was_product_price_info` where (`was_product_price_info`.`product_id` = `prod`.`product_id`)))) ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `wasi_cs_product_category`
--
ALTER TABLE `wasi_cs_product_category`
  ADD PRIMARY KEY (`product_category_id`);

--
-- Indexes for table `was_accounting_details`
--
ALTER TABLE `was_accounting_details`
  ADD PRIMARY KEY (`accounting_id`);

--
-- Indexes for table `was_account_balance_details`
--
ALTER TABLE `was_account_balance_details`
  ADD PRIMARY KEY (`account_number`);

--
-- Indexes for table `was_card_details`
--
ALTER TABLE `was_card_details`
  ADD PRIMARY KEY (`card_number`);

--
-- Indexes for table `was_card_details_history`
--
ALTER TABLE `was_card_details_history`
  ADD KEY `fk_card_number` (`card_number`);

--
-- Indexes for table `was_card_transaction_details`
--
ALTER TABLE `was_card_transaction_details`
  ADD PRIMARY KEY (`transaction_id`),
  ADD KEY `fk_card_number_details` (`card_number`);

--
-- Indexes for table `was_category`
--
ALTER TABLE `was_category`
  ADD PRIMARY KEY (`was_id`);

--
-- Indexes for table `was_chart_of_account`
--
ALTER TABLE `was_chart_of_account`
  ADD PRIMARY KEY (`was_id`);

--
-- Indexes for table `was_client_information`
--
ALTER TABLE `was_client_information`
  ADD PRIMARY KEY (`institution_id`);

--
-- Indexes for table `was_configuration`
--
ALTER TABLE `was_configuration`
  ADD PRIMARY KEY (`config_id`,`config_name`);

--
-- Indexes for table `was_counter`
--
ALTER TABLE `was_counter`
  ADD PRIMARY KEY (`counter_id`);

--
-- Indexes for table `was_cr_dr`
--
ALTER TABLE `was_cr_dr`
  ADD PRIMARY KEY (`was_id`);

--
-- Indexes for table `was_cs_address_category`
--
ALTER TABLE `was_cs_address_category`
  ADD PRIMARY KEY (`was_id`);

--
-- Indexes for table `was_cs_address_type`
--
ALTER TABLE `was_cs_address_type`
  ADD PRIMARY KEY (`was_id`);

--
-- Indexes for table `was_cs_branch`
--
ALTER TABLE `was_cs_branch`
  ADD PRIMARY KEY (`was_id`);

--
-- Indexes for table `was_cs_card_status`
--
ALTER TABLE `was_cs_card_status`
  ADD PRIMARY KEY (`was_id`);

--
-- Indexes for table `was_cs_card_type`
--
ALTER TABLE `was_cs_card_type`
  ADD PRIMARY KEY (`was_id`);

--
-- Indexes for table `was_cs_coa_type`
--
ALTER TABLE `was_cs_coa_type`
  ADD PRIMARY KEY (`was_id`);

--
-- Indexes for table `was_cs_currency_type`
--
ALTER TABLE `was_cs_currency_type`
  ADD PRIMARY KEY (`was_id`);

--
-- Indexes for table `was_cs_customer_category`
--
ALTER TABLE `was_cs_customer_category`
  ADD PRIMARY KEY (`was_id`);

--
-- Indexes for table `was_cs_customer_type`
--
ALTER TABLE `was_cs_customer_type`
  ADD PRIMARY KEY (`was_id`);

--
-- Indexes for table `was_cs_employment_type`
--
ALTER TABLE `was_cs_employment_type`
  ADD PRIMARY KEY (`was_id`);

--
-- Indexes for table `was_cs_gender`
--
ALTER TABLE `was_cs_gender`
  ADD PRIMARY KEY (`was_id`);

--
-- Indexes for table `was_cs_hotel_room_status`
--
ALTER TABLE `was_cs_hotel_room_status`
  ADD PRIMARY KEY (`was_id`);

--
-- Indexes for table `was_cs_hotel_room_type`
--
ALTER TABLE `was_cs_hotel_room_type`
  ADD PRIMARY KEY (`was_id`);

--
-- Indexes for table `was_cs_id_type`
--
ALTER TABLE `was_cs_id_type`
  ADD PRIMARY KEY (`was_id`);

--
-- Indexes for table `was_cs_language`
--
ALTER TABLE `was_cs_language`
  ADD PRIMARY KEY (`was_id`);

--
-- Indexes for table `was_cs_loan_application`
--
ALTER TABLE `was_cs_loan_application`
  ADD PRIMARY KEY (`was_id`);

--
-- Indexes for table `was_cs_loan_payment_mode`
--
ALTER TABLE `was_cs_loan_payment_mode`
  ADD PRIMARY KEY (`was_id`);

--
-- Indexes for table `was_cs_loan_payment_type`
--
ALTER TABLE `was_cs_loan_payment_type`
  ADD PRIMARY KEY (`was_id`);

--
-- Indexes for table `was_cs_loan_scheme`
--
ALTER TABLE `was_cs_loan_scheme`
  ADD PRIMARY KEY (`was_id`);

--
-- Indexes for table `was_cs_loan_type`
--
ALTER TABLE `was_cs_loan_type`
  ADD PRIMARY KEY (`was_id`);

--
-- Indexes for table `was_cs_marital_status`
--
ALTER TABLE `was_cs_marital_status`
  ADD PRIMARY KEY (`was_id`);

--
-- Indexes for table `was_cs_nationality`
--
ALTER TABLE `was_cs_nationality`
  ADD PRIMARY KEY (`was_id`);

--
-- Indexes for table `was_cs_payment_method`
--
ALTER TABLE `was_cs_payment_method`
  ADD PRIMARY KEY (`was_id`);

--
-- Indexes for table `was_cs_payment_mode`
--
ALTER TABLE `was_cs_payment_mode`
  ADD PRIMARY KEY (`was_id`);

--
-- Indexes for table `was_cs_product_method`
--
ALTER TABLE `was_cs_product_method`
  ADD PRIMARY KEY (`was_id`);

--
-- Indexes for table `was_cs_product_type`
--
ALTER TABLE `was_cs_product_type`
  ADD PRIMARY KEY (`was_id`);

--
-- Indexes for table `was_cs_rest_table_type`
--
ALTER TABLE `was_cs_rest_table_type`
  ADD PRIMARY KEY (`was_id`);

--
-- Indexes for table `was_cs_salutation`
--
ALTER TABLE `was_cs_salutation`
  ADD PRIMARY KEY (`was_id`);

--
-- Indexes for table `was_cs_shipping_method`
--
ALTER TABLE `was_cs_shipping_method`
  ADD PRIMARY KEY (`was_id`);

--
-- Indexes for table `was_cs_tariff`
--
ALTER TABLE `was_cs_tariff`
  ADD PRIMARY KEY (`was_id`);

--
-- Indexes for table `was_cs_transaction_type`
--
ALTER TABLE `was_cs_transaction_type`
  ADD PRIMARY KEY (`was_id`);

--
-- Indexes for table `was_cs_vendor_type`
--
ALTER TABLE `was_cs_vendor_type`
  ADD PRIMARY KEY (`was_id`);

--
-- Indexes for table `was_customer_account`
--
ALTER TABLE `was_customer_account`
  ADD PRIMARY KEY (`account_number`);

--
-- Indexes for table `was_customer_contact`
--
ALTER TABLE `was_customer_contact`
  ADD PRIMARY KEY (`customer_contact_id`);

--
-- Indexes for table `was_customer_info`
--
ALTER TABLE `was_customer_info`
  ADD PRIMARY KEY (`CUSTOMER_ID`);

--
-- Indexes for table `was_customer_sale`
--
ALTER TABLE `was_customer_sale`
  ADD PRIMARY KEY (`customer_sale_id`);

--
-- Indexes for table `was_employee_info`
--
ALTER TABLE `was_employee_info`
  ADD PRIMARY KEY (`employee_id`);

--
-- Indexes for table `was_gui_groups`
--
ALTER TABLE `was_gui_groups`
  ADD PRIMARY KEY (`group_id`);

--
-- Indexes for table `was_hotel_book_transactions`
--
ALTER TABLE `was_hotel_book_transactions`
  ADD PRIMARY KEY (`transaction_id`);

--
-- Indexes for table `was_hotel_book_transactions_history`
--
ALTER TABLE `was_hotel_book_transactions_history`
  ADD PRIMARY KEY (`transaction_id`);

--
-- Indexes for table `was_hotel_customer_info`
--
ALTER TABLE `was_hotel_customer_info`
  ADD PRIMARY KEY (`customer_id`);

--
-- Indexes for table `was_hotel_payment`
--
ALTER TABLE `was_hotel_payment`
  ADD PRIMARY KEY (`invoice_number`);

--
-- Indexes for table `was_hotel_room_details`
--
ALTER TABLE `was_hotel_room_details`
  ADD PRIMARY KEY (`room_id`);

--
-- Indexes for table `was_hotel_room_type_desc`
--
ALTER TABLE `was_hotel_room_type_desc`
  ADD PRIMARY KEY (`inc_id`);

--
-- Indexes for table `was_journal_entry`
--
ALTER TABLE `was_journal_entry`
  ADD PRIMARY KEY (`auto_inc_id`),
  ADD KEY `auto_inc_id` (`auto_inc_id`);

--
-- Indexes for table `was_loan_customer_addresses`
--
ALTER TABLE `was_loan_customer_addresses`
  ADD PRIMARY KEY (`inc_id`),
  ADD KEY `fk_loan_customer_id` (`customer_id`);

--
-- Indexes for table `was_loan_customer_details`
--
ALTER TABLE `was_loan_customer_details`
  ADD PRIMARY KEY (`customer_id`);

--
-- Indexes for table `was_loan_employee_details`
--
ALTER TABLE `was_loan_employee_details`
  ADD PRIMARY KEY (`inc_id`),
  ADD KEY `fk_emp_customer_id` (`customer_id`);

--
-- Indexes for table `was_menu_tree`
--
ALTER TABLE `was_menu_tree`
  ADD PRIMARY KEY (`node_number`);

--
-- Indexes for table `was_product`
--
ALTER TABLE `was_product`
  ADD PRIMARY KEY (`product_id`);

--
-- Indexes for table `was_product_payment_header`
--
ALTER TABLE `was_product_payment_header`
  ADD PRIMARY KEY (`payment_id`);

--
-- Indexes for table `was_product_price_info`
--
ALTER TABLE `was_product_price_info`
  ADD PRIMARY KEY (`record_date`),
  ADD KEY `fk_product_id` (`product_id`);

--
-- Indexes for table `was_product_purchase`
--
ALTER TABLE `was_product_purchase`
  ADD KEY `purchase_fk_product_id` (`product_id`);

--
-- Indexes for table `was_product_purchase_header`
--
ALTER TABLE `was_product_purchase_header`
  ADD PRIMARY KEY (`purchase_id`);

--
-- Indexes for table `was_product_receive`
--
ALTER TABLE `was_product_receive`
  ADD KEY `receive_fk_purchase_id` (`purchase_id`);

--
-- Indexes for table `was_product_receive_header`
--
ALTER TABLE `was_product_receive_header`
  ADD PRIMARY KEY (`receive_id`);

--
-- Indexes for table `was_product_sales_invoice_header`
--
ALTER TABLE `was_product_sales_invoice_header`
  ADD PRIMARY KEY (`invoice_number`);

--
-- Indexes for table `was_product_sales_order_header`
--
ALTER TABLE `was_product_sales_order_header`
  ADD PRIMARY KEY (`sales_id`);

--
-- Indexes for table `was_rest_hold_transaction`
--
ALTER TABLE `was_rest_hold_transaction`
  ADD PRIMARY KEY (`sales_id`);

--
-- Indexes for table `was_rest_table_details`
--
ALTER TABLE `was_rest_table_details`
  ADD PRIMARY KEY (`table_id`);

--
-- Indexes for table `was_sale_info`
--
ALTER TABLE `was_sale_info`
  ADD PRIMARY KEY (`sale_id`);

--
-- Indexes for table `was_supplier`
--
ALTER TABLE `was_supplier`
  ADD PRIMARY KEY (`supplier_id`);

--
-- Indexes for table `was_supplier_address`
--
ALTER TABLE `was_supplier_address`
  ADD PRIMARY KEY (`supplier_address_id`);

--
-- Indexes for table `was_supplier_purchase`
--
ALTER TABLE `was_supplier_purchase`
  ADD PRIMARY KEY (`supplier_purchase_id`);

--
-- Indexes for table `was_transaction_description`
--
ALTER TABLE `was_transaction_description`
  ADD PRIMARY KEY (`was_id`);

--
-- Indexes for table `was_transaction_details`
--
ALTER TABLE `was_transaction_details`
  ADD PRIMARY KEY (`reference_number`);

--
-- Indexes for table `was_user_info`
--
ALTER TABLE `was_user_info`
  ADD PRIMARY KEY (`userid`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `was_customer_contact`
--
ALTER TABLE `was_customer_contact`
  MODIFY `customer_contact_id` mediumint(9) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;
--
-- AUTO_INCREMENT for table `was_customer_sale`
--
ALTER TABLE `was_customer_sale`
  MODIFY `customer_sale_id` mediumint(9) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT for table `was_employee_info`
--
ALTER TABLE `was_employee_info`
  MODIFY `employee_id` int(6) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `was_gui_groups`
--
ALTER TABLE `was_gui_groups`
  MODIFY `group_id` mediumint(9) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `was_hotel_room_type_desc`
--
ALTER TABLE `was_hotel_room_type_desc`
  MODIFY `inc_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=49;
--
-- AUTO_INCREMENT for table `was_journal_entry`
--
ALTER TABLE `was_journal_entry`
  MODIFY `auto_inc_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=103;
--
-- AUTO_INCREMENT for table `was_loan_customer_addresses`
--
ALTER TABLE `was_loan_customer_addresses`
  MODIFY `inc_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT for table `was_loan_employee_details`
--
ALTER TABLE `was_loan_employee_details`
  MODIFY `inc_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `was_supplier_address`
--
ALTER TABLE `was_supplier_address`
  MODIFY `supplier_address_id` mediumint(9) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `was_supplier_purchase`
--
ALTER TABLE `was_supplier_purchase`
  MODIFY `supplier_purchase_id` mediumint(9) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- Constraints for dumped tables
--

--
-- Constraints for table `was_account_balance_details`
--
ALTER TABLE `was_account_balance_details`
  ADD CONSTRAINT `fk_account_number` FOREIGN KEY (`account_number`) REFERENCES `was_customer_account` (`account_number`);

--
-- Constraints for table `was_card_details_history`
--
ALTER TABLE `was_card_details_history`
  ADD CONSTRAINT `fk_card_number` FOREIGN KEY (`card_number`) REFERENCES `was_card_details` (`card_number`);

--
-- Constraints for table `was_card_transaction_details`
--
ALTER TABLE `was_card_transaction_details`
  ADD CONSTRAINT `fk_card_number_details` FOREIGN KEY (`card_number`) REFERENCES `was_card_details` (`card_number`);

--
-- Constraints for table `was_loan_customer_addresses`
--
ALTER TABLE `was_loan_customer_addresses`
  ADD CONSTRAINT `fk_loan_customer_id` FOREIGN KEY (`customer_id`) REFERENCES `was_loan_customer_details` (`customer_id`);

--
-- Constraints for table `was_loan_employee_details`
--
ALTER TABLE `was_loan_employee_details`
  ADD CONSTRAINT `fk_emp_customer_id` FOREIGN KEY (`customer_id`) REFERENCES `was_loan_customer_details` (`customer_id`);

--
-- Constraints for table `was_product_price_info`
--
ALTER TABLE `was_product_price_info`
  ADD CONSTRAINT `fk_product_id` FOREIGN KEY (`product_id`) REFERENCES `was_product` (`product_id`);

--
-- Constraints for table `was_product_purchase`
--
ALTER TABLE `was_product_purchase`
  ADD CONSTRAINT `purchase_fk_product_id` FOREIGN KEY (`product_id`) REFERENCES `was_product` (`product_id`);

--
-- Constraints for table `was_product_receive`
--
ALTER TABLE `was_product_receive`
  ADD CONSTRAINT `receive_fk_purchase_id` FOREIGN KEY (`purchase_id`) REFERENCES `was_product_purchase_header` (`purchase_id`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
