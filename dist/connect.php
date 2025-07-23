<?php
$servername = "localhost";
$username = "root";
$password = "";
$dbname = "wasystem";

// Create connection
$conn =mysql_connect($servername, $username, $password);
mysql_select_db($dbname,$conn);
// Check connection
//echo "Connected successfully";
?>