-- phpMyAdmin SQL Dump
-- version 4.5.1
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: Feb 08, 2016 at 07:11 AM
-- Server version: 10.1.8-MariaDB
-- PHP Version: 5.6.14

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `waya`
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
-- Stand-in structure for view `view_lend_loan_payment_info`
--
CREATE TABLE `view_lend_loan_payment_info` (
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
-- Table structure for table `was_account_balance_details`
--

CREATE TABLE `was_account_balance_details` (
  `account_number` varchar(10) NOT NULL,
  `record_date` varchar(10) NOT NULL,
  `account_balance` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `was_account_balance_details`
--

INSERT INTO `was_account_balance_details` (`account_number`, `record_date`, `account_balance`) VALUES
('1000000025', '02.08.2016', '12.00');

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
('1011011590187482', '02.08.2016', '00.00.00', '04.08.2016', '103', '101', '1000000022'),
('1011016862842706', '02.08.2016', '00.00.00', '04.08.2016', '101', '101', '1000000023');

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
  `transaction_reference` varchar(10) NOT NULL,
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

INSERT INTO `was_card_transaction_details` (`transaction_reference`, `transaction_date`, `transaction_time`, `card_number`, `customer_id`, `transaction_type`, `currency_type`, `transaction_amount`, `userid`) VALUES
('0000000089', '02.08.2016', '13:44:53', '1011011590187482', '0000000081', '103', '101', '12.00', '100010');

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
('102', 'Food', '0', 'Food'),
('102101', 'Curls', '102', 'Curls'),
('102102', 'Bread', '102', 'Bread');

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
('2212', '12', '1'),
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
('001', '105', 'Product Items'),
('002', '696', 'Product Sales'),
('003', '242', 'Journal Entry'),
('004', '200085', 'User ID'),
('005', '115', 'Supplier ID'),
('006', '96', 'Customer ID'),
('007', '237', 'Product Purchase'),
('008', '35', 'Loan ID'),
('009', '89', 'Invoice Number'),
('010', '1000000025', 'Link Number'),
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
('103', 'Link to Customer');

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
('C', 'Owner’s Equity Accou'),
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
('144', 'Yemen');

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
('101', 'Type 1'),
('102', 'Type 2');

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
('101', 'Tariff 1'),
('102', 'Tariff 2');

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
('101', 'n/a', 'A');

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
('1000000025', '02.08.2016', '1000000022', '0000000081');

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
(2, '01.11.2016', '0000000081', '101', '22', '23', '23', '2', '', '102', '102', '23', '232', '23', '23', '23'),
(3, '01.11.2016', '0000000081', '104', 'test', 'tes address', '', '', '', '103', '109', '1231', '3qw', '2131', 'qweq', 'qwe232');

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
  `FAX` varchar(30) DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `was_customer_info`
--

INSERT INTO `was_customer_info` (`CUSTOMER_ID`, `RECORD_DATE`, `FIRST_NAME`, `LAST_NAME`, `GENDER`, `TARIFF`, `CUSTOMER_TYPE`, `ACCOUNT_NUMBER`, `ACCOUNT_NAME`, `BANK_NAME`, `BRANCH`, `CONTACT_NUMBER`, `EMAIL`, `FAX`) VALUES
('0000000081', '01.11.2016', 'Juan', 'cruz', '101', '101', '101', '222131222', '', '', '', '312143', 's@yahoo.com', '2342w'),
('0000000090', '01.12.2016', 'bat', 'man', '101', '101', '101', '', '', '', '', '232', '23', '2323'),
('0000000091', '01.12.2016', 'Ro', 'Bin', '101', '101', '101', '', '', '', '', '212', '123', '123123');

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
(1, 'All Access', 'All Access'),
(2, 'Inventory Group', 'Inventory Group'),
(3, 'Loan Group', 'Loan Group'),
(4, 'Test All', 'Test All'),
(5, 'test', 'ttest');

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
(1, 'parent_menu', 'Purchasing to Payable', 0, 'purchasing', '0'),
(2, 'product_purchase', 'Purchase', 1, 'purchasing', '1'),
(3, 'product_receive', 'Receive', 1, 'purchasing', '1'),
(4, 'product_supplier', 'Supplier', 1, 'purchasing', '1'),
(5, 'parent_menu', 'Sales to Recievable', 0, 'sales', '0'),
(6, 'product_sales_order', 'Sales Order', 5, 'sales', '5'),
(7, 'product_sales_invoice', 'Sales Invoice', 5, 'sales', '5'),
(8, 'product_payment_receive', 'Receive Payment', 5, 'sales', '5'),
(9, 'parent_menu', 'Card Management', 0, 'sales', '0'),
(10, 'card_creation_rpt', 'Card Creation', 9, 'sales', '9'),
(11, 'card_details', 'Card Details', 9, 'sales', '9'),
(12, 'card_link_to_customer_rpt', 'Card Link to Customer', 9, 'sales', '9'),
(13, 'card_reload_rpt', 'Card Reload', 9, 'sales', '9'),
(14, 'customer_account', 'Customer Account', 9, 'sales', '9'),
(15, 'parent_menu', 'Inventory', 0, 'inventory', '0'),
(16, 'parent_menu', 'Products', 15, 'inventory', '15'),
(17, 'product_items', 'Items', 16, 'inventory', '15,16'),
(18, 'product_category', 'Categories', 16, 'inventory', '15,16'),
(19, 'parent_menu', 'Product Reports', 16, '1', '16'),
(20, 'products_avail_rpt', 'View Availability', 19, 'inventory', '15,19'),
(21, 'products_daily_purchase_rpt', 'View Daily Purchase', 19, 'inventory', '15,19'),
(22, 'view_daily_sale', 'View Daily Sales', 19, 'inventory', '15,19'),
(23, 'parent_menu', 'Accounting', 0, '2', '0'),
(24, 'acc_chart_of_acct', 'Chart of Account Setup', 23, 'accounting', '23'),
(25, 'acc_journal_entry', 'Journal Entry', 23, 'accounting', '23'),
(26, 'acc_trial_balance_rpt', 'Trial Balance', 23, 'accounting', '23'),
(27, 'parent_menu', 'Customer Information', 0, 'loans', '0'),
(28, 'customer_info', 'Customer Information', 27, 'loans', '27'),
(29, 'view_sales_trans_rpt', 'Sales Transaction', 27, 'sales', '27'),
(30, 'parent_menu', 'Lending', 0, 'loan', '0'),
(31, 'parent_menu', 'Setup', 30, 'loan', '30'),
(32, 'loan_interest_setup', 'Interest', 31, 'loan', '30,31'),
(33, 'loan_entity_setup', 'Entity', 31, 'loan', '30,31'),
(34, 'loan_benefits_bonus_setup', 'Benefits/Bonus Setup', 30, 'loan', '30'),
(35, 'loan_customer_details', 'Customer Details', 30, 'loan', '30');

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
('0', 1, 'parent_menu', 'Inventory', 0, 'inventory'),
('0', 2, 'parent_menu', 'Products', 1, 'inventory'),
('0', 3, 'product_items', 'Items', 2, 'inventory'),
('0', 4, 'product_category', 'Categories', 2, 'inventory'),
('0', 5, 'product_purchase', 'Purchase', 2, 'Inventory'),
('0', 6, 'product_sale', 'Sales', 2, 'inventory'),
('0', 7, 'product_supplier', 'Supplier', 2, 'Inventory'),
('0', 8, 'parent_menu', 'Product Reports', 1, '1'),
('0', 9, 'products_avail', 'View Availability', 8, 'Inventory'),
('0', 10, 'view_daily_purchase', 'View Daily Purchase', 8, 'Inventory'),
('0', 11, 'view_daily_sale', 'View Daily Sales', 8, 'inventory'),
('0', 12, 'parent_menu', 'Accounting', 0, '1'),
('0', 13, 'acc_journal_entry', 'Journal Entry', 12, 'accounting'),
('0', 14, 'acc_trial_balance', 'Trial Balance', 12, 'accounting'),
('0', 15, 'parent_menu', 'Loans', 0, 'loans'),
('0', 16, 'test', 'Loan Page 1', 15, 'loans'),
('0', 17, 'test', 'Loan Page 2', 15, 'loans'),
('2', 1, 'parent_menu', 'Purchasing to Payable', 0, 'purchasing'),
('2', 2, 'product_purchase', 'Purchase', 1, 'purchasing'),
('2', 4, 'product_supplier', 'Supplier', 1, 'purchasing'),
('2', 9, 'parent_menu', 'Inventory', 0, 'inventory'),
('2', 10, 'parent_menu', 'Products', 9, 'inventory'),
('2', 11, 'product_items', 'Items', 10, 'inventory'),
('2', 12, 'product_category', 'Categories', 10, 'inventory'),
('2', 13, 'parent_menu', 'Product Reports', 10, '1'),
('2', 16, 'view_daily_sale', 'View Daily Sales', 13, 'inventory'),
('3', 26, 'parent_menu', 'Lending', 0, 'lending'),
('3', 27, 'parent_menu', 'Setup', 26, 'lending'),
('3', 28, 'lend_interest_setup', 'Interest', 27, 'lending'),
('3', 29, 'lend_entity_setup', 'Entity', 27, 'lending'),
('3', 30, 'lend_benefits_bonus_setup', 'Benefits/Bonus Setup', 26, 'lending'),
('3', 31, 'lend_customer_info', 'Customer Info', 26, 'lending'),
('4', 1, 'parent_menu', 'Purchasing to Payable', 0, 'purchasing'),
('4', 2, 'product_purchase', 'Purchase', 1, 'purchasing'),
('4', 4, 'product_supplier', 'Supplier', 1, 'purchasing'),
('4', 9, 'parent_menu', 'Inventory', 0, 'inventory'),
('4', 10, 'parent_menu', 'Products', 9, 'inventory'),
('4', 11, 'product_items', 'Items', 10, 'inventory'),
('4', 12, 'product_category', 'Categories', 10, 'inventory'),
('4', 13, 'parent_menu', 'Product Reports', 10, '1'),
('4', 16, 'view_daily_sale', 'View Daily Sales', 13, 'inventory'),
('4', 17, 'parent_menu', 'Accounting', 0, '2'),
('4', 19, 'acc_journal_entry', 'Journal Entry', 17, 'accounting'),
('5', 1, 'parent_menu', 'Purchasing to Payable', 0, 'purchasing'),
('5', 2, 'product_purchase', 'Purchase', 1, 'purchasing'),
('5', 4, 'product_supplier', 'Supplier', 1, 'purchasing'),
('5', 9, 'parent_menu', 'Inventory', 0, 'inventory'),
('5', 10, 'parent_menu', 'Products', 9, 'inventory'),
('5', 11, 'product_items', 'Items', 10, 'inventory'),
('5', 12, 'product_category', 'Categories', 10, 'inventory'),
('5', 13, 'parent_menu', 'Product Reports', 10, '1'),
('5', 16, 'view_daily_sale', 'View Daily Sales', 13, 'inventory'),
('5', 17, 'parent_menu', 'Accounting', 0, '2'),
('5', 19, 'acc_journal_entry', 'Journal Entry', 17, 'accounting'),
('1', 1, 'parent_menu', 'Purchasing to Payable', 0, 'purchasing'),
('1', 2, 'product_purchase', 'Purchase', 1, 'purchasing'),
('1', 3, 'product_receive', 'Receive', 1, 'purchasing'),
('1', 4, 'product_supplier', 'Supplier', 1, 'purchasing'),
('1', 5, 'parent_menu', 'Sales to Recievable', 0, 'sales'),
('1', 6, 'product_sales_order', 'Sales Order', 5, 'sales'),
('1', 7, 'product_sales_invoice', 'Sales Invoice', 5, 'sales'),
('1', 8, 'product_payment_receive', 'Receive Payment', 5, 'sales'),
('1', 9, 'parent_menu', 'Card Management', 0, 'sales'),
('1', 10, 'card_creation_rpt', 'Card Creation', 9, 'sales'),
('1', 11, 'card_details', 'Card Details', 9, 'sales'),
('1', 12, 'card_link_to_customer_rpt', 'Card Link to Customer', 9, 'sales'),
('1', 13, 'card_reload_rpt', 'Card Reload', 9, 'sales'),
('1', 14, 'customer_account', 'Customer Account', 9, 'sales'),
('1', 15, 'parent_menu', 'Inventory', 0, 'inventory'),
('1', 16, 'parent_menu', 'Products', 15, 'inventory'),
('1', 17, 'product_items', 'Items', 16, 'inventory'),
('1', 18, 'product_category', 'Categories', 16, 'inventory'),
('1', 19, 'parent_menu', 'Product Reports', 16, '1'),
('1', 20, 'products_avail_rpt', 'View Availability', 19, 'inventory'),
('1', 21, 'products_daily_purchase_rpt', 'View Daily Purchase', 19, 'inventory'),
('1', 22, 'view_daily_sale', 'View Daily Sales', 19, 'inventory'),
('1', 23, 'parent_menu', 'Accounting', 0, '2'),
('1', 24, 'acc_chart_of_acct', 'Chart of Account Setup', 23, 'accounting'),
('1', 25, 'acc_journal_entry', 'Journal Entry', 23, 'accounting'),
('1', 26, 'acc_trial_balance_rpt', 'Trial Balance', 23, 'accounting'),
('1', 27, 'parent_menu', 'Customer Information', 0, 'loans'),
('1', 28, 'customer_info', 'Customer Information', 27, 'loans'),
('1', 29, 'view_sales_trans_rpt', 'Sales Transaction', 27, 'sales'),
('1', 30, 'parent_menu', 'Lending', 0, 'loan'),
('1', 31, 'parent_menu', 'Setup', 30, 'loan'),
('1', 32, 'loan_interest_setup', 'Interest', 31, 'loan'),
('1', 33, 'loan_entity_setup', 'Entity', 31, 'loan'),
('1', 34, 'loan_benefits_bonus_setup', 'Benefits/Bonus Setup', 30, 'loan'),
('1', 35, 'loan_customer_details', 'Customer Details', 30, 'loan');

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
('000080', 'Red Horse', '101', '1003', '101101', '', '30.00', '25.00', 'red horse', '0', '', '100', '20'),
('000081', 'San Mig Light', '101', '1003', '101101', '000110', '28.00', '23.00', 'San Mig Light', '0', '', '100', '20'),
('000082', 'Coke', '101', '1003', '101101', '000102', '10.00', '15.00', 'coke', '0', '', '', ''),
('000083', 'Sprite', '101', '4000', '101102', '000102', '10.00', '15.00', '', '0', '', '', ''),
('000084', 'Pizza', '102', '4000', '102102', '000102', '100.00', '150.00', '', '0', '', '', ''),
('000085', 'Sandwich', '102', '1000', '102102', '000102', '20.00', '30.00', '', '0', '', '', ''),
('000098', 'Beer', '101', '1000', '101101', '000102', '1.00', '1.00', '', '1', '', '', '');

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
('2016-01-21 15:17:22', '000080', '101', '15.00', '15.00', '1', '101', 'Red Horse', '1000', '121', '20.00', '1', '1', '101', 'Red Horse', '1000', '111');

-- --------------------------------------------------------

--
-- Table structure for table `was_product_purchase`
--

CREATE TABLE `was_product_purchase` (
  `purchase_id` varchar(10) NOT NULL,
  `record_date` varchar(10) NOT NULL,
  `product_id` varchar(6) NOT NULL,
  `quantity` varchar(10) NOT NULL,
  `description` varchar(30) NOT NULL,
  `cost_price` varchar(10) NOT NULL,
  `total_price` varchar(10) NOT NULL,
  `purchase_status` varchar(3) NOT NULL,
  `partial` varchar(6) DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

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
  `status` varchar(3) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

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
  `tab` varchar(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

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
  `supplier_id` varchar(6) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

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
  `record_date` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `was_product_sales_invoice`
--

INSERT INTO `was_product_sales_invoice` (`sales_id`, `product_id`, `price`, `quantity`, `discount`, `discount_amount`, `total_amount`, `location`, `description`, `record_date`) VALUES
('0000000691', '000080', '20.00', '1', '', '', '20.00', '104', 'Red Horse', '01.27.2016'),
('0000000692', '000080', '20.00', '1', '', '', '20.00', '104', 'Red Horse', '01.27.2016');

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
  `card_number` varchar(16) DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `was_product_sales_invoice_header`
--

INSERT INTO `was_product_sales_invoice_header` (`invoice_number`, `sales_id`, `customer_id`, `record_date`, `userid`, `due_date`, `payment_status`, `due_amount`, `actual_amount`, `card_number`) VALUES
('0000000077', '0000000692', '0000000000', '01.27.2016', '100010', '', '101', '20.00', '20.00', '');

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
  `transaction_id` varchar(10) NOT NULL,
  `record_date` varchar(10) NOT NULL,
  `customer_id` varchar(10) NOT NULL,
  `card_number` varchar(15) DEFAULT NULL,
  `transaction_type` varchar(3) NOT NULL,
  `crdr` varchar(1) NOT NULL,
  `amount` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `was_transaction_details`
--

INSERT INTO `was_transaction_details` (`transaction_id`, `record_date`, `customer_id`, `card_number`, `transaction_type`, `crdr`, `amount`) VALUES
('0000000510', '11.10.2015', '0000000063', '2342342323', '101', '1', '15900.00'),
('0000000511', '11.10.2015', '0000000063', '2342342323', '101', '1', '49294.50'),
('0000000517', '11.11.2015', '0000000072', '987654321', '101', '1', '6295.50'),
('0000000518', '11.12.2015', '0000000072', '987654321', '101', '1', '34985.00'),
('0000000553', '11.24.2015', '0000000072', '987654321', '101', '1', '25.00'),
('0000000554', '11.24.2015', '0000000072', '987654321', '101', '1', '48.00'),
('0000000556', '11.24.2015', '0000000072', '987654321', '101', '1', '23.00'),
('0000000561', '11.27.2015', '0000000072', '987654321', '101', '1', '73.00'),
('0000000562', '11.28.2015', '', '', '101', '1', '1198.00'),
('0000000563', '12.03.2015', '', '', '101', '1', '38.00'),
('0000000564', '12.04.2015', '', '', '101', '1', '249.00');

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
  `password_failed` varchar(2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `was_user_info`
--

INSERT INTO `was_user_info` (`userid`, `username`, `firstname`, `lastname`, `password`, `email`, `record_date`, `modified_date`, `role`, `groups`, `institution_id`, `current_login`, `last_login`, `last_logoff`, `password_status`, `password_failed`) VALUES
('100010', 'admin', 'admin', 'ako', '8450ECA01665516D9AEB5317764902B78495502637C96192C81B1683D32D691A0965CF037FECA8B9ED9EE6FC6AB8F27FCE8F77C4FD9B4A442A00FC317B8237E6', '222', '2016-02-08 05:02:11', '2015-09-19 04:47:08', '1', '1', '1001', '2016-02-08 05:02:11', '2016-02-08 04:36:49', '2016-02-08 05:01:25', '1', '0'),
('200001', 'werwe', 'werwe', 'ewweqqqqqqq111', 'AABB153CCC5D10E77816566AEB351F7F86FA51A193F6A87A37936C744E65B32496C99B350750CEE1608BE206262513F8B429E600348FC49B2AFBF7457219273E', NULL, '2016-02-08 05:02:04', '0000-00-00 00:00:00', '', '1^5^2^3^4', '1001', '2016-02-08 05:01:40', '2016-02-08 02:56:18', '2016-02-08 05:02:04', '1', '0'),
('200009', 'qweq', 'qeq', 'qweq', '0412D2FF3FEECEA36BE3F8161AE028B213512AF44CAA845B386AD36EFF4D543EF707B96FD8ED63DD557612C83DDCCAF664CA5B37865F4683FBFDC94C2B06ADC0', NULL, '2016-02-04 07:06:36', '0000-00-00 00:00:00', '1', '', '1001', '2009-10-02 08:52:30', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '1', '0'),
('200024', 'werwe', 'ewrw333', 'werwe111', '40A7F5FCB922A5DD9D4309BB72A3BBC1CF8EF097B2CEF75D95A1D02CDBEF25888062D81E7BDB46267905D89A482DB9BF41A59BD5848B7BEEEBE8ADD2750805D6', NULL, '2016-02-04 07:06:38', '0000-00-00 00:00:00', '1', '', '1001', '2009-10-02 08:52:30', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '1', '0'),
('200068', 'test', 'test', 'test', 'B16ED7D24B3ECBD4164DCDAD374E08C0AB7518AA07F9D3683F34C2B3C67A15830268CB4A56C1FF6F54C8E54A795F5B87C08668B51F82D0093F7BAEE7D2981181', NULL, '2016-02-04 07:06:40', '0000-00-00 00:00:00', '1', '2', '1001', '2009-10-02 08:52:30', '2009-10-02 08:52:30', '0000-00-00 00:00:00', '1', '0');

-- --------------------------------------------------------

--
-- Structure for view `view_daily_products_sale`
--
DROP TABLE IF EXISTS `view_daily_products_sale`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_daily_products_sale`  AS  select `prod`.`product_id` AS `product_id`,`prod`.`product_name` AS `product_name`,`sale`.`quantity` AS `quantity`,`sale`.`total_amount` AS `total_amount`,`sale`.`record_date` AS `record_date` from (`was_product` `prod` join `was_product_sales_order` `sale`) where (`prod`.`product_id` = `sale`.`product_id`) order by `prod`.`product_name` ;

-- --------------------------------------------------------

--
-- Structure for view `view_lend_loan_payment_info`
--
DROP TABLE IF EXISTS `view_lend_loan_payment_info`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_lend_loan_payment_info`  AS  select '1' AS `type`,concat('L-',`was_lend_loan_info`.`loan_id`) AS `reference_number`,`was_lend_loan_info`.`customer_id` AS `customer_id`,`was_lend_loan_info`.`loan_application` AS `loan_application`,`was_lend_loan_info`.`loan_type` AS `loan_type`,`was_lend_loan_info`.`loan_amount` AS `loan_amount`,`was_lend_loan_info`.`principal_amount` AS `principal_amount`,`was_lend_loan_info`.`interest` AS `interest`,`was_lend_loan_info`.`record_date` AS `record_date`,'' AS `payable_amount`,'' AS `payment_mode`,'' AS `payment_type` from `was_lend_loan_info` union all select '2' AS `2`,concat('P-',`was_lend_payment_info`.`payment_id`) AS `concat('P-',payment_id)`,`was_lend_payment_info`.`customer_id` AS `customer_id`,`was_lend_payment_info`.`loan_application` AS `loan_application`,`was_lend_payment_info`.`loan_type` AS `loan_type`,'' AS `Name_exp_6`,'' AS `Name_exp_7`,'' AS `Name_exp_8`,`was_lend_payment_info`.`record_date` AS `record_date`,`was_lend_payment_info`.`payable_amount` AS `payable_amount`,`was_lend_payment_info`.`payment_mode` AS `payment_mode`,`was_lend_payment_info`.`payment_type` AS `payment_type` from `was_lend_payment_info` ;

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
  ADD PRIMARY KEY (`transaction_reference`),
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
-- Indexes for table `was_gui_menu_tree`
--
ALTER TABLE `was_gui_menu_tree`
  ADD PRIMARY KEY (`node_number`);

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
  MODIFY `customer_contact_id` mediumint(9) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
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
  MODIFY `group_id` mediumint(9) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
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
  MODIFY `supplier_address_id` mediumint(9) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `was_supplier_purchase`
--
ALTER TABLE `was_supplier_purchase`
  MODIFY `supplier_purchase_id` mediumint(9) NOT NULL AUTO_INCREMENT;
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
