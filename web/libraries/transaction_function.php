<?php
if (isset($_GET['functionName'])){
	if($_GET['functionName'] == 'checkCrDr'){
		checkCrDr($_GET['strValue']);
	} 
}

function AddJournal($fields,$values){
	$strReturn = DB_Add('was_journal_transaction',encrypt_decrypt('decrypt',$fields),encrypt_decrypt('decrypt',$values));
	return $strReturn;
}

function checkCrDr($strValue){
	require '../connect.php';
	$result = mysql_query("SELECT cr_dr FROM was_transaction_description where was_id ='".$strValue."'");
	while($row = mysql_fetch_array($result)) { 			
		echo $row['cr_dr'];
	}
}
?>