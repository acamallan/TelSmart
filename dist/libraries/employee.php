<div id="normal" >
	<?php 
	require 'libraries/employee_function.php';
	if(isset($_POST['UpdateRecordBtn']) && !pageWasRefreshed()){
		if ($_POST['strAction'] == "edit"){
			$strValue = UpdateEmpInfo($_GET['emp_id'],encrypt_decrypt('encrypt',$_POST['strField']),encrypt_decrypt('encrypt',$_POST['strValue']));
			if($strValue == 1){
				MessageInfo('success','Record Update Successfully!');			
			} else {
				MessageInfo('error','Record Update Not Successfully!');	
			}
		} else { //add
			$strValue = AddNewEmpInfo(encrypt_decrypt('encrypt',$_POST['strField']),encrypt_decrypt('encrypt',$_POST['strValue']));
			if($strValue == 1){
				MessageInfo('success','New Record Update Successfully!');			
			} else {
				MessageInfo('error','New Record Update Not Successfully!');	
			}
		}
	}
	
	if(isset($_GET['action']) && $_GET['action'] == "delete" && !pageWasRefreshed()){
		$strValue = DeleteEmp($_GET['emp_id']);
		if($strValue == 1){
			MessageInfo('success','Record Delete Successfully!');			
		} else {
			MessageInfo('error','Record Delete Not Successfully!');	
		}
	}
	
	if(!isset($_GET['action']) || $_GET['action'] == "delete"){
	?>
	<h2>List of Employees</h2><br/>
	<div class="component">
		<table>
			<thead>
				<tr>
					<th>Last Name</th>
					<th>First Name</th>
					<th style="text-align:right; margin-left:8px;"><a href="main.php?url=employee&action=add"" class="add_emp"><span class="typcn typcn-plus-outline" ></span>Add</span></th>
				</tr>
			</thead>
			<tbody>
			<?php 
			$result = mysql_query("SELECT employee_id, firstname, lastname FROM was_employee_info order by lastname");
			while($row = mysql_fetch_array($result)) { 
				$encrypt = encrypt_decrypt('encrypt',$row['employee_id']);
				$edit = "main.php?url=employee&emp_id=".$encrypt."&action=edit";
				$delete = "main.php?url=employee&emp_id=".$encrypt."&action=delete";
			?>
			<tr>
				<td><?php echo $row['lastname']; ?></td>
				<td><?php echo $row['firstname']; ?></td>
				<td style="text-align:right"><a href="<?php echo $edit;?>" class="action"><span class="typcn typcn-pencil"></span>Edit</a>&nbsp;&nbsp;&nbsp;<a href="<?php echo $delete;?>" class="action"><span class="typcn typcn-trash"></span>Delete</a></td>
			</tr>				
	<?php
			}
	} else { 
		if($_GET['action'] == 'edit' || $_GET['action'] == 'add'){
			$url = "main.php?url=employee";
			$lastname = "";
			$firstname = "";
			$sss_id = "";
			$phil_health_id = "";
			$pag_ibig_id = "";
			$strH2 = "Add Employee";
			$strAction = "add";
			if ($_GET['action'] == 'edit' ){
				$strH2 = "Edit Employee";
				$result = mysql_query("SELECT * FROM was_employee_info where employee_id='".encrypt_decrypt('decrypt',$_GET['emp_id'])."'");
				$row  = mysql_fetch_array($result);
				if(is_array($row)) {
					$url = "main.php?url=employee&emp_id=".$_GET['emp_id'];
					$lastname = $row['lastname'];
					$firstname = $row['firstname'];
					$sss_id = $row['sss_id'];
					$phil_health_id = $row['phil_health_id'];
					$pag_ibig_id = $row['pag_ibig_id'];
					$strAction = "edit";
				}
			}	
			echo "<h2>".$strH2."</h2><br/>";
		?>
			<form action="<?php echo $url; ?>" method="post" name="UpdateEmployee" id="UpdateEmployee" autocomplete="off">
				<table>
					<tr>
						<td class="tdfield">Last Name &nbsp;&nbsp;&nbsp;</td>
						<td><input type="text" name="lastname" value="<?php echo $lastname; ?>"></td>
					</tr>
					<tr>
						<td class="tdfield">First Name &nbsp;&nbsp;&nbsp;</td>
						<td><input type="text" name="firstname" value="<?php echo $firstname; ?>"></td>
					</tr>
					<tr>
						<td class="tdfield">SSS ID &nbsp;&nbsp;&nbsp;</td>
						<td><input type="text" name="sss_id" value="<?php echo $sss_id; ?>"></td>
					</tr>
					<tr>
						<td class="tdfield">Phil Healtd ID &nbsp;&nbsp;&nbsp;</td>
						<td><input type="text" name="phil_health_id" value="<?php echo $phil_health_id; ?>"></td>
					</tr>
					<tr>
						<td class="tdfield">Pagibig ID &nbsp;&nbsp;&nbsp;</td>
						<td><input type="text" name="pag_ibig_id" value="<?php echo $pag_ibig_id; ?>"></td>
					</tr>
					<tr>
						<td></td>
						<td><input type="submit" name="UpdateRecordBtn" id="UpdateRecordBtn" value="Update Record" onclick="GetInputName('strField'); GetRecord('strValue')"/></td>
					</tr>
				</table>
				<input type="hidden" name="strField" id="strField" value="">
				<input type="hidden" name="strValue" id="strValue" value="">
				<input type="hidden" name="strAction" id="strAction" value="<?php echo $strAction; ?>">
			</form>
	<?php
						
		}
	}
	?>
		</tbody>
		</table>
	</div>
</div>
