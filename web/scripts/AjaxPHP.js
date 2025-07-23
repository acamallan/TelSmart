/*------------------Inventory Function------------------*/
function AjaxPHPFunction(functionName,value){
	if(functionName == 'CheckProductCategoryID'){
		ShowLoading();
		var value = pad(value,'3');
		$.ajax({
			url: baseURL()+'libraries/product.php',
			data: {functionName: functionName, strValue:value},
			type: 'GET',
			success: function(response) {
				if (response == 1){
					alert("Product Category ID "+value+" already exist!");
					document.getElementById('product_category_id').focus();
				} 
				HideLoading();
			}
		});
	} else if(functionName == 'EditProductCategory'){
		ShowLoading();
		
		if(document.getElementById('strAction').value == "Add"){
			alert("Edit is not Allowed. "+document.getElementById('strAction').value+" mode is already enabled.");
			HideLoading();
			return;
		}
		var value = pad(value,'3');
		$.ajax({
			url: baseURL()+'libraries/product.php',
			data: {functionName: functionName, strValue:value},
			type: 'GET',
			success: function(response) {
				var value = response.split('^');
				document.getElementById("product_category_id").value = value[0];
				document.getElementById("product_category_name").value = value[1];
				document.getElementById("product_category_description").value = value[2];
				document.getElementById("strID").value = value[0];
				EnabledForm();
				document.getElementById("product_category_id").disabled = true;
				HideLoading();
			}
		});
		document.getElementById("strAction").value = "Edit";
	} else if(functionName == 'DeleteList'){
		ShowLoading();
		var pagefromHTML = parseInt(document.getElementById("current_page").value/10);
		var fields = document.getElementById("fields").value;
		var table = document.getElementById("table").value;
		var where = document.getElementById("where").value;
		var orderby = document.getElementById("orderby").value;
		$.ajax({
			url: baseURL()+'libraries/record_function.php',
			data: {functionName: functionName, strValue:value, page:pagefromHTML, fields:'product_category_id, '+fields, table:table, where:where, orderby:orderby},
			type: 'GET',
			success: function(response) {
				var value = response.split('^');
				if (value[0] == 1){
					$(function() {		
						$.notifyBar({ cssClass: 'success', html: 'Record Delete Successfully!' });
					});
				} else {
					$(function() {		
						$.notifyBar({ cssClass: 'error', html: 'Error when deleting record!' });
					});	
				}
				
				if(value[1] != ""){
					var rows = value[1].split('+');
					var strRecords = "";
					for (var i=0; i < rows.length; i++){
						var data = rows[i].split('~');
						strRecords = strRecords+"<tr>";
						for (var x=1; x < data.length; x++){
							
							strRecords = strRecords+"<td>"+data[x]+"</td>";
							
						}
						strRecords = strRecords+'<td style="text-align:right"><a href="#" class="action" onclick="AjaxPHPFunction(\'EditProductCategory\',\''+data[0]+'\', \'\');")><span class="typcn typcn-pencil" title="Edit"></span>Edit</a>&nbsp;&nbsp;&nbsp;<a href="#" class="action" onclick="Delete_JS(\'DeleteList\',\''+data[0]+'\')" title="Delete"><span class="typcn typcn-trash"></span>Delete</a></td>';
						strRecords = strRecords+"</tr>";
					}
					document.getElementById("displaylist").innerHTML = "";
					document.getElementById("displaylist").innerHTML = strRecords;
					
					var where = document.getElementById("where").value;
					$.ajax({
						url: 'libraries/navigation.php',
						data: {functionName: 'get_total_record', strTable:table, where:where},
						type: 'GET',
						success: function(response) {
							if (response == 10){
								document.getElementById("navigation").innerHTML = "";
							}
						}
					});
				} else {
					document.getElementById("displaylist").innerHTML = "<br/>No Records Found!";
				}
			HideLoading();
			}
		});
	} else if(functionName == 'Find_PHP'){
		ShowLoading();
		var fields = document.getElementById("fields").value;
		var table = document.getElementById("table").value;
		var orderby = document.getElementById("orderby").value;
		var record_count= 0;
		$.ajax({
			url: baseURL()+'libraries/record_function.php',
			data: {functionName: functionName, FindFilter:value, fields:fields, table:table, orderby:orderby},
			type: 'GET',
			success: function(response) {
				if(response == ""){
					document.getElementById("displaylist").innerHTML = "";
					alert('No Record Found!');
					HideLoading();
					return;
				}
				var rows = response.split('+');
				var strRecords = "";
				for (var i=0; i < rows.length; i++){
					var data = rows[i].split('~');
					strRecords = strRecords+"<tr>";
					for (var x=0; x < data.length; x++){
						strRecords = strRecords+"<td>"+data[x]+"</td>";
					}
					strRecords = strRecords+'<td style="text-align:right"><a href="main.php?menu_id=products&action=edit&p_id='+data[0]+'" class="action" id="edit" ><span class="typcn typcn-pencil" title="Edit Category"></span>Edit</a>&nbsp;&nbsp;&nbsp;<a href="#" class="action" onclick="Delete_JS(\'DeleteList\',\''+data[0]+'\')" title="Delete"><span class="typcn typcn-trash"></span>Delete</a></td>';
					strRecords = strRecords+"</tr>";
					document.getElementById("strID").value = data[0];
				}
				document.getElementById("displaylist").innerHTML = "";
				document.getElementById("displaylist").innerHTML = strRecords;
				document.getElementById("current_page").value = record_count
				HideLoading();
			}
		});
	} else if(functionName == 'checkProductName'){
		ShowLoading();
		$.ajax({
			url: baseURL()+'inventory_function/product.php',
			data: {functionName: functionName, strValue:value},
			type: 'GET',
			success: function(response) {
				if (response == 1){
					alert("Product Name already exist!");
					document.getElementById('product_name').focus();
					HideLoading();
					return;
				}
			}
		});
		HideLoading();
	}
}


/*------------------End Inventory Function------------------*/