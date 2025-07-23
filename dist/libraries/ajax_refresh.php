<?php
// PDO connect *********
$servername = "localhost";
$username = "root";
$password = "";
$dbname = "wasystem";
 /*
$conn =@mysql_connect($servername, $username, $password);
mysql_select_db($dbname,$conn);
$keyword = $_POST['keyword'].'%';
$result = mysql_query( "SELECT * FROM was_chart_of_account WHERE account_type LIKE ('".$keyword."') ORDER BY account_type ASC LIMIT 0, 10");
while($row = mysql_fetch_array($result)) { 

	 put in bold the written text
	$account_type = str_replace($_POST['keyword'], '<b>'.$_POST['keyword'].'</b>', $row['account_type']);
	 add new option
    echo '<li onclick="set_item(\''.str_replace("'", "\'", $row['account_type']).'\')">'.$account_type.'</li>';
}
*/
function autocomplete(){
	$result = mysql_query( "SELECT * FROM was_chart_of_account ORDER BY was_id ASC");
	$auto = "var availableTags = [";
	while($row = mysql_fetch_array($result)) {
		$auto = $auto. '"'.$row["was_id"].' - '.$row["account_type"].'",';
	}
	$auto = rtrim($auto,",");
	$auto = $auto. "];";
	return $auto;
}
?>