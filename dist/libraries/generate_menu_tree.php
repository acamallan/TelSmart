<?php
if (isset($_GET['functionName'])){
	if($_GET['functionName'] == 'generate_config_menu'){
		echo generate_config_menu();
	}
}

function generate_menu(){
	$result = mysql_query("SELECT node_number, menu_id, menu_name, parent_id from was_gui_menu_tree order by CAST(node_number AS SIGNED INTEGER)");
	$id = 1;
	$c = 0;
	
	echo "<ul>";
	while($row = mysql_fetch_array($result)) {
		if($row['menu_id'] <>'parent_menu'){
			if($row['menu_id'] == 'main'){
				echo "<li ><a href='main.php' tabindex='-1'><span>".$row['menu_name']."</span></a></li>";
			} else {
				echo "<li ><a href=?menu_id=".$row['menu_id']." tabindex='-1'><span>".$row['menu_name']."</span></a></li>";
			}
			$li =0;
		} else { 
			if($li == 0 ){
				if ($c == 1){
					echo "</ul>";
				}
			}
			echo "<li class='has-sub'><a href='#' tabindex='-1'><span>".$row['menu_name']."</span></a>";
			echo "<ul>";
			$li =1; 
			$c= 1;
		}
		$id = $row['parent_id']; 
	}
echo "</ul></li><li class='last'><a href='logout.php' tabindex='-1'><span>Signout</span></a></li></ul>";
 }
 
function generate_user_menu(){
	$result = mysql_query("SELECT node_number, menu_id, menu_name, parent_id, module_name from was_gui_user_menu_tree where userid = ". $_SESSION['userid']." order by node_number");
	$strParentID = "";
	$c = 0;
	$base = baseURL();
	$menu = "<script type='text/javascript'>var menu=new jktreeview('tree2');";
	while($row = mysql_fetch_array($result)) {
		if($row['menu_id'] <>'parent_menu'){
			if($strParentID = $row['parent_id']){
				$menu = $menu . "menu.addItem('".$row['menu_name']."',menu_$strParentID, '".$base.$row['module_name']."/".$row['menu_id'].".php');";
			} 
		} else { 
			if( $c <> 0){
				if($row['parent_id'] == 0){
						$menu = $menu . "var menu_".$row['node_number']."=menu.addItem('".$row['menu_name']."');";
				} else {
					$menu = $menu . "var menu_".$row['node_number']."=menu.addItem('".$row['menu_name']."',menu_".$row['parent_id'].");";
				}
			} else{			
				$menu = $menu . "var menu_".$row['node_number']."=menu.addItem('".$row['menu_name']."');";
			}
			$strParentID = $row['node_number'];
			
		}
		$c = 1;
		$id = $row['node_number']; 
	}
	$menu = $menu . "menu.treetop.draw()</script>"; //REQUIRED LINE: Initalize tree
	
return $menu;
 }
  
function generate_config_menu(){
	$result = mysql_query("SELECT gui.node_number, gui.menu_id, gui.menu_name, gui.parent_id, gui.parent_path, user.node_number user_node_number, gui.module_name
			FROM was_gui_menu_tree gui
			left join  was_gui_user_menu_tree user on
			gui.node_number = user.node_number
			order by gui.node_number;");
	$strPrevParentID = 0;
	$strPrevParent = 0;
	$c = 0;
	$x = 0;
	$select = "";
	$path = "";
	$menu =  "<script type='text/javascript'> var treeData = [";
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
					
					$x++;
				} else {
					if(is_numeric($row['module_name'])){
						for ($i = 1; $i <= $row['module_name']; $i++) {
							$menu = rtrim($menu, ", ");
							$menu = $menu . "]}, ";
						} 
					} else  {
					
						for ($i = 1; $i <= $x; $i++) {
							$menu = rtrim($menu, ", ");
							$menu = $menu . "]}, ";
						}
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
	$menu = rtrim($menu, ", ");
	$path = rtrim($path, ",");
	$menu = $menu . ']}]; $(function(){
			document.getElementById("strNode").value="'.$path.'";
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
				document.getElementById("strNode").value=selKeys;
				selTitle = selTitle.split(",");
				selSelect = selSelect.split(",");
				for (var i=0; i < selTitle.length; i++){
					if(selSelect[i] == "false"){
						$("#echoSelection").append(selTitle[i]+"<br>");
					}
				}
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
		}); });</script> ';
	return $menu;
 }
?>