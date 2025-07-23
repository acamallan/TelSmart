<?php
if (isset($_GET['functionName'])){
	if($_GET['functionName'] == 'lineChart'){
		echo lineChart();
	} 
}
	
function lineChart(){
	require '../connect.php';
	$strDate ="";
	for($x = 1; $x <= 12; $x++){
		$date = date('Ym',strtotime("-$x months"));
		$strDate = $strDate .",". $date;
	}
	
	$strDate = substr($strDate, 1);
	$result = mysql_query("select sum(total_amount) as total_amount, concat(left(record_date,2),'/',1,'/',right(record_date,4)) as whole_date, concat(right(record_date,4),left(record_date,2)) trim_date 
		FROM view_daily_products_sale 
		where concat(right(record_date,4),left(record_date,2)) in ($strDate)
		group by concat(right(record_date,4),left(record_date,2))
		order by concat(right(record_date,4),left(record_date,2))");
			
	$date = explode(",",$strDate);
	$num_rows = mysql_num_rows($result);
	$strLine = "";
	for($x = 12; $x >= 1+$num_rows; $x--){
		$chartDate = date('m/01/Y',strtotime("-$x months"));
		$strLine = $strLine.","."['".$chartDate."',0]";
	}
		
	while($row = mysql_fetch_array($result)) {
		for ($x = 0; $x <= 11; $x++) {
			if($date[$x] == $row['trim_date']){
				$strLine = $strLine.","."['".$row['whole_date']."',".$row['total_amount']."]";
			}
		}
	}
	$strReturn = substr($strLine, 1);
	return "[".$strReturn."]";
}

?>