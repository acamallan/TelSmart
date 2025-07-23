<?php
function MessageInfo($class, $msg){
	echo "<script>";
	echo "$(function() {";		
	echo "$.notifyBar({ cssClass: '".$class."', html: '".$msg."' });";
	echo "});";
	echo "</script>";
}

function AfterSubmit(){
	$_SESSION['pageWasRefreshed'] = "";
}

function checkSession(){
	if ($_SESSION['timeout'] + 60 * 60 < time()) {
		session_unset();     // unset $_SESSION variable for the run-time 
		session_destroy();   // destroy session data in storage
		echo "<script> alert('Your session has been expired!'); document.location = '".baseURL()."index.php';</script>";
	} 
}

function PHPQueryToJavascript($query,$fields){
	require '../libraries/encrypt_decrypt.php';
	$strRow = "";
	$strRecords = "";
	while($row = mysql_fetch_array($query)) { 
		$strLen = substr_count($fields,', ');
			$str = "";
			$strRow = "";
			for($x = 0; $x <= $strLen; $x++){
				if($x == 0){
					$str = encrypt_decrypt('encrypt',$row[$x])."~";
					//$str = $row[$x]."~";
				} else {
					$str = $row[$x]."~";
				}
				
				$strRow = $strRow.$str;
			}
		$strRecords = $strRecords.rtrim($strRow, "~")."+";
	}
	return rtrim($strRecords, "+");
}

function GetCounter($counter_id,$length){
	$strSelect = "select max(counter_value) as counter_value from was_counter where counter_id = '".$counter_id."'";
	$result = mysql_query($strSelect);
	$row = mysql_fetch_array($result);
	$strRuselt =  leadingzero($row['counter_value']+1,$length);
	DB_Update("was_counter","counter_value = '".$strRuselt."'", "counter_id = '".$counter_id."'" );
	return $strRuselt;
}

function leadingzero($value,$pad){
	return str_pad($value, $pad, '0', STR_PAD_LEFT);

}

function baseURL(){
  return sprintf(
    "%s://%s%s",
    isset($_SERVER['HTTPS']) && $_SERVER['HTTPS'] != 'off' ? 'https' : 'http',
    $_SERVER['SERVER_NAME'],
    "/dboard/"
  );
}
 ?>