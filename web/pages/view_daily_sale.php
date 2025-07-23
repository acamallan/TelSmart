<?php
include "../header.php";
if(isset($_GET['action']) && isset($_GET['action'])=='generate'){
?>
	<h2 style="margin-top:-2px;">View Daily Sale</h2>
	<div class="component" id="component">
		<table>
			<thead>
				<tr>
					<th>Product ID</th>
					<th>Customer Name</th>
					<th>Quantity</th>
					<th>Total Amount</th>
					<th>Record Date</th>
				</tr>
			</thead>
			<tbody id="displaylist">
			<?php 
			$total = 0;
			$result = mysql_query("SELECT product_id, product_name, sum(quantity) quantity, CONCAT('', FORMAT(sum(total_amount), 2)) total_amount, record_date FROM view_daily_products_sale where record_date='".$_POST['record_date']."' group by product_id order by product_name");
			while($row = mysql_fetch_array($result)) { 
			$total = $total + str_replace( ',', '', $row['total_amount'] );	
			?>
			<tr>
				<td><?php echo $row['product_id']; ?></td>
				<td><?php echo $row['product_name']; ?></td>
				<td><?php echo $row['quantity']; ?></td>
				<td style="text-align:right"><?php echo $row['total_amount']; ?></td>
				<td><?php echo $row['record_date']; ?></td>
				
			</tr>				
			<?php } ?>
			<tr>
				<td></td>
				<td></td>
				<td></td>
				<td style="text-align:right">TOTAL: &nbsp;&nbsp;<strong><?php echo number_format($total,2); ?></strong></td>
				<td></td>
			</tr>
		</tbody>
		</table>
	</div>
		<input type="button" value="Print" onclick="printDiv('component');">
		<input type="button" value="Back" name="back" id="back" onclick="window.location.assign('view_daily_sale.php')">
<?php
} else {
?>

<div style="padding:50px; margin-left:50px;">
<h2>View Daily Sale</h2>
<div class="add_entry_div" style="width: 40%; ">
	<form action="view_daily_sale.php?action=generate" method="post" name="WASForm" id="WASForm" autocomplete="off">
	<table>
		<tr>
			<td>Record Date</td>
			<td><input type="text" name="record_date" id="record_date" required style="width:80px;" value=""> </td>
		</tr>
		<tr>
			<td colspan="2" align="center"><br><br>
				<input type="submit" name="GenerateReport" id="GenerateReport" value="Generate" >
				<input type="button" value="Cancel" name="back" id="back" onclick="window.location.assign('<?php echo baseURL(); ?>main.php')">
			</td>
		</tr>
	</table>
	</form>
</div>

<?php } ?>

<script>
function printDiv(divName) {
    var divText = document.getElementById(divName).outerHTML;
	var myWindow = window.open('','','fullscreen=yes, top=10;');
	var print ="";
	var print = print +'<html><head><link href="'+baseURL()+'styles/style.css" rel="stylesheet" type="text/css" media="all"></head><body onload="window.print(); window.close();"><h2>View Daily Sale</h2>';
	var print = print +divText;
	var print = print + '</body></html>';
	var print = print.replace(/component/g, 'component1');
	var doc = myWindow.document;
	doc.open();
	doc.write(print);
	doc.close();
}
</script>
<?php include "../footer.php";?>