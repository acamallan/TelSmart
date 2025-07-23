<?php
function login($username, $password){
	$strPass =  hash('sha512',$username.$_POST['password']);
	$result = mysql_query("SELECT userid, username FROM was_user_info where username='".$username."' and password='".$strPass."'");
	$row  = mysql_fetch_array($result);
	if(is_array($row)) {
		$_SESSION['userid'] = $row['userid'];
		$_SESSION['username'] = $row['username'];
		return true;
		
	} else {
		return false;
	}
}

function getUserPassword(){
	$result = mysql_query("SELECT password, username FROM was_user_info where userid='".$_SESSION['userid']."'");
	$row  = mysql_fetch_array($result);
	if(is_array($row)) {
		return $row['password'];
	}
}
function changepassword($NewPass){
	$strUserID = $_SESSION['userid'];
	$result = mysql_query("update was_user_info set password='".$NewPass."' where userid='".$strUserID."'");
	if(! $result ){
		die('Could not update data: ' . mysql_error());
	}
}
?>