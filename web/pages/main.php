<table>
	<tr>
		<td align="center">
			<?php $result = mysql_query("SELECT CONCAT('', FORMAT(sum(total_price), 2)) total FROM was_product_purchase");
			while($row = mysql_fetch_array($result)) { 
			?>
			<span style="font-size:15px; font-weight: bold;">Total Purchase: <u> <?php echo $row['total']; ?> </u></span>
			<?php } ?>
		</td>
		<td align="center">
			<?php $result = mysql_query("SELECT CONCAT('', FORMAT(sum(total_amount), 2)) total FROM was_product_sales_order");
			while($row = mysql_fetch_array($result)) { 
			?>
			<span style="font-size:15px; font-weight: bold;">Total Sales: <u> <?php echo $row['total']; ?> </u></span>
			<?php } ?>
		</td>
	</tr>
</table><br><br><br>
<table border="1" style="width:80%; border:1px #F2F2F2 solid;#F2F2F2" align="center">
	<tr>
		<td style="width:50%; padding:10px;" align="center">PRODUCT RANKING<br><br>
			<div style="width: 100%; height:100%; overflow: auto;">
				<table>
					<thead>
						<tr>
							<th style="background:#3399cc;">RANK</th>
							<th style="background:#3399cc;">PRODUCT NAME</th>
							<th style="background:#3399cc;">QUANTITY</th>
							<th style="background:#3399cc;">AMOUNT</th>
						</tr>
					</thead>
					<tbody style="padding:10px;">
					<?php 
					$count = 0;
					$result = mysql_query("SELECT product_id, product_name, quantity,   CONCAT('', FORMAT(sum(total_amount), 2)) total_amount FROM view_daily_products_sale group by product_id order by convert(CONCAT('', FORMAT(sum(total_amount), 2)), decimal) desc");
					while($row = mysql_fetch_array($result)) { 
					$count++;
						
					?>
					<tr >
						<td align="center" style="padding:5px;"><?php echo $count; ?></td>
						<td><?php echo $row['product_name']; ?></td>
						<td align="center"><?php echo $row['quantity']; ?></td>
						<td  style="float:right; padding-right:5px;"><?php echo $row['total_amount']; ?></td>
						
					</tr>				
					<?php } ?>
					</tbody>
				</table>
			</div>
		</td>

	</tr>
	<tr>
		<td colspan="2" style="padding:10px;" align="center"><br>PRODUCT PURCHASE RANKING<br><br>
		<!-- JQPlot Chart -->	
			<div class="example-plot" id="chart2">

			<link class="include" rel="stylesheet" type="text/css" href="plugin/jqplot/style/jquery.jqplot.min.css" />
				<style type="text/css">
				  .jqplot-point-label {white-space: nowrap;}
			/*    .jqplot-yaxis-label {font-size: 14pt;}*/
			/*    .jqplot-yaxis-tick {font-size: 7pt;}*/

				div.jqplot-target {
					height: 400px;
					width: 750px;
				}
				</style>
				
			<script class="code" type="text/javascript" language="javascript">
			$(document).ready(function(){   
				$.ajax({
					url: 'libraries/jqPlot.php',
					data: {functionName: 'lineChart'},
					type: 'GET',
					success: function(response) {
				var line2 = eval(response);
				var plot2 = $.jqplot('chart2', [line2], {
				  axes: {
					xaxis: {
					  renderer: $.jqplot.DateAxisRenderer,
					  label: '',
					  labelRenderer: $.jqplot.CanvasAxisLabelRenderer,
					  tickRenderer: $.jqplot.CanvasAxisTickRenderer,
					  tickOptions: {
						  // labelPosition: 'middle',
						  formatString: '%b/%Y',
						  angle: 20
					  }
					  
					},
					yaxis: {
					  
					  labelRenderer: $.jqplot.CanvasAxisLabelRenderer
					}
				  }
				});
				} });

			});
			</script>
			
			<script class="include" type="text/javascript" src="plugin/jqplot/script/jquery.jqplot.min.js"></script>
			<script class="include" type="text/javascript" src="plugin/jqplot/script/jqplot.canvasTextRenderer.min.js"></script>
			<script class="include" type="text/javascript" src="plugin/jqplot/script/jqplot.canvasAxisTickRenderer.min.js"></script>
			<script class="include" type="text/javascript" src="plugin/jqplot/script/jqplot.dateAxisRenderer.min.js"></script>
		</td>
	</tr>
</table>