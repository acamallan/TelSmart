<?php 
if (isset($_GET['functionName'])){
	if($_GET['functionName'] == 'get_page_record' && $_GET['strValue'] <> ""){
		echo get_page_record($_GET['strValue'],$_GET['strTable'],$_GET['fields'],$_GET['where'],$_GET['orderby']);
	} else if($_GET['functionName'] == 'get_total_record'){
		echo get_total_record($_GET['strTable'],$_GET['where']);
	}  
}
function get_page_record($limit,$table,$fields,$where,$orderby){
	require '../connect.php';
	require '../libraries/db_function.php';
	require '../libraries/was_function.php';
	$limit = $limit.",10";
	$result = DB_Select($fields,$table,$where,$orderby,$limit);
	$result = PHPQueryToJavascript($result,$fields);
	return $result;
}

function get_total_record($table,$where){
	require '../connect.php';
	require '../libraries/db_function.php';
	$fields = "count(*) as total";
	$orderby = "";
	$limit = "";
	$result = DB_Select($fields,$table,$where,$orderby,$limit);
	$row = mysql_fetch_array($result);
	$result = $row['total'];
	return $result;
}
?>