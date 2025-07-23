<?php 
require '../../connect.php';
require '../../libraries/generate_menu_tree.php';
$result = mysql_query("SELECT gui.node_number, gui.menu_id, gui.menu_name, gui.parent_id, gui.parent_path, user.node_number user_node_number  FROM 		
			was_gui_menu_tree gui
			left join  was_gui_user_menu_tree user on
			gui.node_number = user.node_number
			order by gui.node_number;");
	$strPrevParentID = 0;
	$strPrevParent = 0;
	$c = 0;
	$x = 0;
	$select = "";
	$path = "";
	$menu =  "var treeData = [";
	while($row = mysql_fetch_array($result)) {
		if($row['menu_id'] <>'parent_menu'){
			
			if($row['user_node_number'] <> ""){
				$select = ", select: true";
				$path = $path . $row['parent_path'].",".$row['node_number'].",";
			}
			if($strPrevParentID <= $row['parent_id']){
				$menu = $menu . "{title: '".$row['menu_name']."', key: '".$row['parent_path'].",".$row['node_number']."' ".$select." }, ";
			} else {
				$menu = rtrim($menu, ", ");	
				$menu = $menu .  "]}, {title: '".$row['menu_name']."', key: '".$row['parent_path'].",".$row['node_number']."' ".$select." }, ";
				//$x--;
			} 
			$select = "";
			$strPrevParentID = $row['parent_id'];
		} else { 
			if( $c <> 0){
				if($strPrevParent < $row['parent_id'] ){
					echo $row['menu_name'];
					$x++;
				} else {
					for ($i = 1; $i <= $x; $i++) {
						$menu = rtrim($menu, ", ");
						$menu = $menu . "]}, ";
					}
					$x = 0;
				}
				if($row['parent_id'] == 0){
					$menu = rtrim($menu, ", ");
					$menu = $menu . "]}, {title: '".$row['menu_name']."', isFolder: true,hideCheckbox: true, unselectable: true, key: '".$row['parent_path'].",".$row['node_number']."', children: [ ";
				} else {
					$menu = $menu . " {title: '".$row['menu_name']."', isFolder: true,hideCheckbox: true, unselectable: true, key: '".$row['parent_path'].",".$row['node_number']."', children: [ ";
				}
			} else{			
			$menu = $menu . "{title: '".$row['menu_name']."', isFolder: true,hideCheckbox: true, unselectable: true, key: '".$row['parent_path'].",".$row['node_number']."', children: [ ";
			}
			$strPrevParent = $row['parent_id'];
		}
		$c = 1;
		$id = $row['node_number']; 
	}
	$menu = rtrim($menu, ",");
	$menu = $menu . "]}];";
	echo $menu;
?>

<html>
<head>
	<meta http-equiv="content-type" content="text/html; charset=ISO-8859-1">
	<title>Dynatree - Example</title>

	<script src="jquery/jquery.js" type="text/javascript"></script>
	<script src="jquery/jquery-ui.custom.js" type="text/javascript"></script>
	<script src="jquery/jquery.cookie.js" type="text/javascript"></script>

	<script src="jquery.dynatree.js" type="text/javascript"></script>
	<link href="skin-vista/ui.dynatree.css" rel="stylesheet" type="text/css" id="skinSheet">

<script type="text/javascript">
var treeData = [{title: 'Inventory', isFolder: true,hideCheckbox: true, unselectable: true, key: '0,1', children: [ {title: 'Products', isFolder: true,hideCheckbox: true, unselectable: true, key: '1,2', children: [ {title: 'Items', key: '1,2,3' }, {title: 'Categories', isFolder: true,hideCheckbox: true, unselectable: true, key: '1,2,4', children: [ {title: 'Purchase', key: '1,2,4,5' }]}, {title: 'Sales', key: '1,2,6' }, {title: 'Supplier', key: '1,2,7' }]}, {title: 'Product Reports', isFolder: true,hideCheckbox: true, unselectable: true, key: '1,8', children: [ {title: 'View Availability', key: '1,8,9' }, {title: 'View Daily Purchase', key: '1,8,10' }, {title: 'View Daily Sales', key: '1,8,11' }]}]}, {title: 'Accounting', isFolder: true,hideCheckbox: true, unselectable: true, key: '1,12', children: [ {title: 'Users List', key: '12,13' }]}, {title: 'Accounting', isFolder: true,hideCheckbox: true, unselectable: true, key: '1,14', children: [ {title: 'Users List', key: '1,15' }, ]}]; 
	$(function(){
			$("#tree").dynatree({
			checkbox: true,
			selectMode: 3,
			children: treeData,
			onSelect: function(select, node) {
				// Get a list of all selected nodes, and convert to a key array:
				var selKeys = $.map(node.tree.getSelectedNodes(), function(node){
					return node.data.key;
				});
				selKeys = selKeys.toString();
				var selTitle = $.map(node.tree.getSelectedNodes(), function(node){
					return node.data.title;
				});
				selTitle = selTitle.toString();
				var selSelect = $.map(node.tree.getSelectedNodes(), function(node){
					return node.data.unselectable;
				});
				selSelect = selSelect.toString();
				
				$("#echoSelection").text("");
				selTitle = selTitle.split(",");
				selSelect = selSelect.split(",");
				for (var i=0; i < selTitle.length; i++){
					if(selSelect[i] == "false"){
						$("#echoSelection").append(selTitle[i]+"<br>");
					}
				}
				
				
				//$('#echoSelectionRoots3').append(selTitle+"<br>")
				//alert(selTitle)
				//var selTitle = selTitle.replace(, "<br>");
	
				//$("#echoSelectionRoots3").text("<p>"+selTitle+"</p>");
			},
			onDblClick: function(node, event) {
				node.toggleSelect();
			},
			onKeydown: function(node, event) {
				if( event.which == 32 ) {
					node.toggleSelect();
					return false;
				}
			},
			// The following options are only required, if we have more than one tree on one page:
//				initId: "treeData",
			cookieId: "dynatree-Cb3",
			idPrefix: "dynatree-Cb3-"
		});

		

		$("#btnToggleSelect").click(function(){
			$("#tree2").dynatree("getRoot").visit(function(node){
				node.toggleSelect();
			});
			return false;
		});
		$("#btnDeselectAll").click(function(){
			$("#tree2").dynatree("getRoot").visit(function(node){
				node.select(false);
			});
			return false;
		});
		$("#btnSelectAll").click(function(){
			$("#tree2").dynatree("getRoot").visit(function(node){
				node.select(true);
			});
			return false;
		}); }); 
	
</script>
</head>

<body class="example">
	<br><br><br><br>
<?php
//echo generate_config_menu();
?>
	<table width="700px;" border="0" align="center">
		<tr>
			<td><div id="tree3" style="width:330px; height:200px;"></div></td>
			<td valign="top"><div style="width:300px;">Selected keys: <span id="echoSelection3">-</span></div></td>
		</tr>
		<tr>
			<td>View Tree</td>
			<td valign="top">Assign Page</div></td>
		</tr>
		<tr>
			<td><div id="tree" style="width:350px; height:400px; border:1px solid #ccc; padding:10px;overflow: auto;"></div></td>
			<td valign="top"><div style="width:350px;"><span id="echoSelection"></span></div></td>
		</tr>
	</table>
	<!---<div>Selected root keys: <span id="echoSelectionRootKeys3">-</span></div>
	<div>Selected root nodes: <span id="echoSelectionRoots3">-</span></div> --->


	<!-- End_Exclude -->
</body>
</html>
