<?php
function UpdateEmpInfo($emp_id, $fields, $values){
	$fields = explode(",",encrypt_decrypt('decrypt',$fields));
	$values = explode(",",encrypt_decrypt('decrypt',$values));
	$strLen = count($fields);
	$strSet = "";
	$set = "";
	for ($x = 0; $x <= $strLen-5; $x++) {
		$set = $fields[$x]."='".$values[$x]."'";
		$strSet = $strSet.$set.", ";
	}
	$strSet = $strSet."modified_date=now()";
	$strTable = " was_employee_info ";
	$strWhere = " employee_id='".encrypt_decrypt('decrypt',$emp_id)."'";
	$strReturn = DB_Update($strTable,$strSet,$strWhere);
	return $strReturn;
}

function AddNewEmpInfo($fields, $values){
	$fields = explode(",",encrypt_decrypt('decrypt',$fields));
	$values = explode(",",encrypt_decrypt('decrypt',$values));
	$strLen = count($fields);
	$strFields = "";
	$strValues = "";
	for ($x = 0; $x <= $strLen-5; $x++) {
		$strFields = $strFields.$fields[$x].",";
		$strValues = $strValues."'".$values[$x]."',";
	}
	$strFields = $strFields. "record_date";
	$strValues = $strValues. "now()";
	$strTable = " was_employee_info ";
	$strReturn = DB_Add($strTable,$strFields,$strValues);
	return $strReturn;
}

function DeleteEmp($strEmpID){
	$strTable = " was_employee_info ";
	$strWhere = " where employee_id='".encrypt_decrypt('decrypt',$strEmpID)."'";
	$strReturn = DB_Delete($strTable,$strWhere);
	return $strReturn;
}
?>