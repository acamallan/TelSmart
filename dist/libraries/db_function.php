<?php
function DB_Update($table,$setValues,$strWhere){
	$strUpdate = "update ".$table." set ".$setValues." where ".$strWhere;
	$result = mysql_query($strUpdate);
	if($result){
		return true;
	} else{
		die('Could not update data: ' . mysql_error());
		return false;
	}
}

function DB_Add($table,$fields,$values){
	$strAddNew = "insert into ". $table ."(". $fields .") values (" . $values. ")";
	$result = mysql_query($strAddNew);
	if($result){
		return true;
	} else{
		die('Could not update data: ' . mysql_error());
		return false;
	}
}

function DB_Delete($table, $where){
	$strDelete = "delete from " . $table . $where;
	$result = mysql_query($strDelete);
	if($result){
		return 1;
	} else{
		die('Could not delete data: ' . mysql_error());
		return 0;
	}
}

function DB_Select($fields,$table, $where, $orderby, $limit){
	if($orderby != ""){
		$orderby = "order by ".$orderby;
	}
	if($limit != ""){
		$limit = "limit ".$limit;
	}
	if($where != ""){
		$where = "where ".$where;
	}
	$strSelect = "select ".$fields." from ".$table." ".$where." ".$orderby." ".$limit;
	$result = mysql_query($strSelect);
	if($result){
		return $result;
	} else{
		die('Could not select data: ' . mysql_error());
		return false;
	}
}
?>