<?php
if (isset($_GET['functionName'])){
	if($_GET['functionName'] == 'CheckProductCategoryID' && $_GET['strValue'] <> ""){
		echo CheckProductCategoryID($_GET['strValue']);
	} elseif($_GET['functionName'] == 'EditProductCategory' && $_GET['strValue'] <> ""){
		echo EditProductCategory($_GET['strValue']);
	} elseif($_GET['functionName'] == 'checkProductName' && $_GET['strValue'] <> ""){
		echo checkProductName($_GET['strValue']);
	}	
}

function CheckProductCategoryID($id){
	require '../connect.php';
	$result = mysql_query("SELECT * FROM wasi_cs_product_category where product_category_id='".$id."'");
	$num_rows = mysql_num_rows($result);
	return $num_rows;
}

function checkProductName($p_name){
	require '../connect.php';
	$result = mysql_query("SELECT * FROM wasi_product where lower(product_name)=lower('".$p_name."')");
	$num_rows = mysql_num_rows($result);
	return $num_rows;
}

function EditProductCategory($id){
	require '../connect.php';
	$strData = "";
	$result = mysql_query("SELECT product_category_id, product_category_name, product_category_description FROM wasi_cs_product_category where product_category_id='".$id."'");
	while($row = mysql_fetch_array($result)) { 
		$strData = $row['product_category_id']."^".$row['product_category_name']."^".$row['product_category_description'];
	}
	return $strData;
}

?>