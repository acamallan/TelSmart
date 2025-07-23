<?php
if (isset($_GET['functionName'])){
	if($_GET['functionName'] == 'DeleteList' && $_GET['strValue'] <> ""){
		echo DeleteList($_GET['strValue'],$_GET['page'],$_GET['fields'],$_GET['table'],$_GET['where'],$_GET['orderby']);
	} else if($_GET['functionName'] == 'Find_PHP' && $_GET['FindFilter'] <> ""){
		echo Find_PHP($_GET['FindFilter'],$_GET['fields'],$_GET['table'],$_GET['orderby']);
	} else if($_GET['functionName'] == 'CheckRecord'){
		echo CheckRecord($_GET['table'],$_GET['fields'],$_GET['where']);
	} else if($_GET['functionName'] == 'DeleteRecord'){
		echo DeleteRecord($_GET['table'],$_GET['where']);
	} else if($_GET['functionName'] == 'DisplayList_JS'){
		echo DisplayList_JS($_GET['page'],$_GET['fields'],$_GET['table'],$_GET['where'],$_GET['orderby']);
	}
}
	
function AddNewRecord($table, $fields, $values, $countFields){
	$table = encrypt_decrypt('decrypt',$table);
	$fields = explode(",",encrypt_decrypt('decrypt',$fields));
	$values = explode(",",encrypt_decrypt('decrypt',$values));
	$countFields = count(explode(",",encrypt_decrypt('decrypt',$countFields)));
	$strLen = count($fields);
	
	$diff = ($strLen - $countFields) + 1;
	$strFields = "";
	$strValues = "";
	for ($x = 0; $x <= $strLen-$diff; $x++) {
		$strFields = $strFields.$fields[$x].",";
		$strValues = $strValues."'".$values[$x]."',";
	}
	
	$strReturn = DB_Add($table,rtrim($strFields, ","),rtrim($strValues, ","));
	return $strReturn;
}

function UpdateRecord($table, $fields, $values, $where, $id, $countFields){
	$table = encrypt_decrypt('decrypt',$table);
	$where = encrypt_decrypt('decrypt',$where);
	$fields = explode(",",encrypt_decrypt('decrypt',$fields));
	$values = explode(",",encrypt_decrypt('decrypt',$values));
	$countFields = count(explode(",",encrypt_decrypt('decrypt',$countFields)));
	$strLen = count($fields);
	
	$diff = ($strLen - $countFields) + 1;
	$strSet = "";
	$set = "";
	for ($x = 0; $x <= $strLen-$diff; $x++) {
			$set = $fields[$x]."='".$values[$x]."'";
			$strSet = $strSet.$set.",";
		
	}
	$strWhere = " ".$where."='".encrypt_decrypt('decrypt',$id)."'";
	$strReturn = DB_Update($table,rtrim($strSet, ","),$strWhere);
	return $strReturn;
}

function DeleteList($id, $page, $fields, $table, $where, $orderby){
	require '../connect.php';
	require 'db_function.php';
	require 'was_function.php';
	$strWhere = " where ".$where."='".$id."'";
	$strDelete = DB_Delete($table,$strWhere);
	$strQryList = PHPQueryToJavascript(DisplayList($page,$fields, $table, $where, $orderby),$fields);
	$strReturn = $strDelete;
	return $strReturn."^".$strQryList;
}

function DisplayList($page,$fields, $table, $where, $orderby){
	$_SESSION['navPage'] = $page;
	$limit = $page.",10";
	$result = DB_Select($fields,$table,$where,$orderby,$limit);
	return $result;
}

function Find_PHP($FindFilter, $fields, $table,  $orderby){
	require '../connect.php';
	require 'db_function.php';
	require 'was_function.php';
	$where = $FindFilter;
	$page = "0";
	$strReturn = PHPQueryToJavascript(DisplayList($page,$fields, $table, $where, $orderby),$fields);
	return $strReturn;
}

function CheckRecord($table, $fields, $where){
	require '../connect.php';
	require 'was_function.php';
	$result = mysql_query("SELECT ".$fields." FROM ".$table." where ".$where);
	$strReturn = PHPQueryToJavascript($result,$fields);
	return $strReturn;
}

function DeleteRecord($table, $where){
	require '../connect.php';
	require 'db_function.php';
	$where = "where ". $where;
	$strDelete = DB_Delete($table,$where);
	return $strDelete;
}

function DeleteRecordPHP($table, $field, $value){
	$strTable = encrypt_decrypt('decrypt',$table);
	$strWhere = " where " . encrypt_decrypt('decrypt',$field) ." = '".encrypt_decrypt('decrypt',$value)."'";
	$strReturn = DB_Delete($strTable,$strWhere);
	return $strReturn;
}

function DisplayList_JS($page,$fields, $table, $where, $orderby){
	require '../connect.php';
	require 'db_function.php';
	require 'was_function.php';
	$strReturn = PHPQueryToJavascript(DisplayList($page,$fields, $table, $where, $orderby),$fields);
	return $strReturn;
}

function AddSales($fields,$values){
	$strReturn = DB_Add('wasi_product_sale',encrypt_decrypt('decrypt',$fields),encrypt_decrypt('decrypt',$values));
	return $strReturn;
}

function AddJournal($fields,$values){
	$strReturn = DB_Add('was_journal_entry',encrypt_decrypt('decrypt',$fields),encrypt_decrypt('decrypt',$values));
	return $strReturn;
}

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