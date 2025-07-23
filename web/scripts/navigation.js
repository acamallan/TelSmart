function first_page(table,strUrl){
	ShowLoading();
	if(document.getElementById("current_page").value == 0 && document.getElementById("current_page").value != ""){
		alert('First page already');
		HideLoading();
		return;
	}
	var fields = document.getElementById("fields").value;
	var where = document.getElementById("where").value;
	var orderby = document.getElementById("orderby").value;
	var record_count= 0;
	$.ajax({
		url: baseURL()+'libraries/navigation.php',
		data: {functionName: 'get_page_record', strTable:table, strValue:record_count, fields:fields, table:table, where:where, orderby:orderby},
		type: 'GET',
		success: function(response) {
			var rows = response.split('+');
			var strRecords = "";
			for (var i=0; i < rows.length; i++){
				var data = rows[i].split('~');
				strRecords = strRecords+"<tr>";
				for (var x=1; x < data.length; x++){
					strRecords = strRecords+"<td>"+data[x]+"</td>";
				}
				if(table == 'wasi_cs_product_category'){
					strRecords = strRecords+'<td style="text-align:right"><a href="#" class="action" onclick="AjaxPHPFunction(\'EditProductCategory\',\''+data[0]+'\', \'\');")><span class="typcn typcn-pencil" title="Edit"></span>Edit</a>&nbsp;&nbsp;&nbsp;<a href="#" class="action" onclick="Delete_JS(\'DeleteList\',\''+data[0]+'\')" title="Delete"><span class="typcn typcn-trash"></span>Delete</a></td>';
					strRecords = strRecords+"</tr>";
				} else {
					strRecords = strRecords+'<td style="text-align:right"><a href="'+strUrl+'.php?action=edit&p_id='+data[0]+'" class="action" id="edit" ><span class="typcn typcn-pencil" title="Edit Category"></span>Edit</a>&nbsp;&nbsp;&nbsp;<a href="#" class="action" onclick="DeleteRecord(\''+data[1]+'\')" title="Delete"><span class="typcn typcn-trash"></span>Delete</a></td>';
					strRecords = strRecords+"</tr>";
				}
			}
			document.getElementById("displaylist").innerHTML = "";
			document.getElementById("displaylist").innerHTML = strRecords;
			document.getElementById("current_page").value = record_count
			HideLoading();
		}
	});
}


function previous_page(table,strUrl){
	var record_count = "";
	ShowLoading();
	if(document.getElementById("current_page").value == 0 && document.getElementById("current_page").value != ""){
		alert('First page already');
		HideLoading();
		return;
	}
	record_count= parseInt(document.getElementById("current_page").value) - 10;
	var fields = document.getElementById("fields").value;
	var where = document.getElementById("where").value;
	var orderby = document.getElementById("orderby").value;
	$.ajax({
		url: baseURL()+'libraries/navigation.php',
		data: {functionName: 'get_page_record', strTable:table, strValue:record_count, fields:fields, table:table, where:where, orderby:orderby},
		type: 'GET',
		success: function(response) {
			var rows = response.split('+');
			var strRecords = "";
			for (var i=0; i < rows.length; i++){
				var data = rows[i].split('~');
				strRecords = strRecords+"<tr>";
				for (var x=1; x < data.length; x++){
					strRecords = strRecords+"<td>"+data[x]+"</td>";
				}
				if(table == 'wasi_cs_product_category'){
					strRecords = strRecords+'<td style="text-align:right"><a href="#" class="action" onclick="AjaxPHPFunction(\'EditProductCategory\',\''+data[0]+'\', \'\');")><span class="typcn typcn-pencil" title="Edit"></span>Edit</a>&nbsp;&nbsp;&nbsp;<a href="#" class="action" onclick="Delete_JS(\'DeleteList\',\''+data[0]+'\')" title="Delete"><span class="typcn typcn-trash"></span>Delete</a></td>';
					strRecords = strRecords+"</tr>";
				} else {
					strRecords = strRecords+'<td style="text-align:right"><a href="'+strUrl+'.php?action=edit&p_id='+data[0]+'" class="action" id="edit" ><span class="typcn typcn-pencil" title="Edit Category"></span>Edit</a>&nbsp;&nbsp;&nbsp;<a href="#" class="action" onclick="DeleteRecord(\''+data[1]+'\')" title="Delete"><span class="typcn typcn-trash"></span>Delete</a></td>';
					strRecords = strRecords+"</tr>";
				}
			}
			document.getElementById("displaylist").innerHTML = "";
			document.getElementById("displaylist").innerHTML = strRecords;
			document.getElementById("current_page").value = record_count;
			HideLoading();
		}
	});
}

function next_page(table,strUrl){
	var record_count = "";
	var pagefromDB = "";
	var pagefromHTML = "";
	ShowLoading();
	
	var fields = document.getElementById("fields").value;
	var where = document.getElementById("where").value;
	var orderby = document.getElementById("orderby").value;
	$.ajax({
		url: baseURL()+'libraries/navigation.php',
		data: {functionName: 'get_total_record', strTable:table, where:where},
		type: 'GET',
		success: function(response) {
			pagefromDB = parseInt(response/10);
			pagefromHTML = parseInt(document.getElementById("current_page").value/10);
			if(pagefromHTML >= pagefromDB || response == 10){
				alert('Last page already');
				HideLoading();
				return;
			} else {
				record_count= parseInt(document.getElementById("current_page").value) + 10;
				
				$.ajax({
					url: baseURL()+'libraries/navigation.php',
					data: {functionName: 'get_page_record', strTable:table, strValue:record_count, fields:fields, table:table, where:where, orderby:orderby},
					type: 'GET',
					success: function(response) {
						var rows = response.split('+');
						var strRecords = "";
						for (var i=0; i < rows.length; i++){
							var data = rows[i].split('~');
							strRecords = strRecords+"<tr>";
							for (var x=1; x < data.length; x++){
								strRecords = strRecords+"<td>"+data[x]+"</td>";
							}
							if(table == 'wasi_cs_product_category'){
								strRecords = strRecords+'<td style="text-align:right"><a href="#" class="action" onclick="AjaxPHPFunction(\'EditProductCategory\',\''+data[0]+'\', \'\');")><span class="typcn typcn-pencil" title="Edit"></span>Edit</a>&nbsp;&nbsp;&nbsp;<a href="#" class="action" onclick="Delete_JS(\'DeleteList\',\''+data[0]+'\')" title="Delete"><span class="typcn typcn-trash"></span>Delete</a></td>';
								strRecords = strRecords+"</tr>";
							} else {
								strRecords = strRecords+'<td style="text-align:right"><a href="'+strUrl+'.php?action=edit&p_id='+data[0]+'" class="action" id="edit" ><span class="typcn typcn-pencil" title="Edit Category"></span>Edit</a>&nbsp;&nbsp;&nbsp;<a href="#" class="action" onclick="DeleteRecord(\''+data[1]+'\')" title="Delete"><span class="typcn typcn-trash"></span>Delete</a></td>';
								strRecords = strRecords+"</tr>";
							}
						}
						document.getElementById("displaylist").innerHTML = "";
						document.getElementById("displaylist").innerHTML = strRecords;
						document.getElementById("current_page").value = record_count
						HideLoading();
					}
				});
			}
		}
	});
}

function last_page(table,strUrl){
	var record_count = "";
	var pagefromDB = "";
	var pagefromHTML = "";
	ShowLoading();
	var fields = document.getElementById("fields").value;
	var where = document.getElementById("where").value;
	var orderby = document.getElementById("orderby").value;
	$.ajax({
		url: baseURL()+'libraries/navigation.php',
		data: {functionName: 'get_total_record', strTable:table, where:where},
		type: 'GET',
		success: function(response) {
			pagefromDB = parseInt(response/10);
			pagefromHTML = parseInt(document.getElementById("current_page").value/10);
			
			if(pagefromHTML >= pagefromDB || response == 10){
				alert('Last page already');
				HideLoading();
				return;
			} else {
				record_count= pagefromDB * 10;
				
				$.ajax({
					url: baseURL()+'libraries/navigation.php',
					data: {functionName: 'get_page_record', strTable:table, strValue:record_count, fields:fields, table:table, where:where, orderby:orderby},
					type: 'GET',
					success: function(response) {
						var rows = response.split('+');
						var strRecords = "";
						for (var i=0; i < rows.length; i++){
							var data = rows[i].split('~');
							strRecords = strRecords+"<tr>";
							for (var x=1; x < data.length; x++){
								strRecords = strRecords+"<td>"+data[x]+"</td>";
							}
							if(table == 'wasi_cs_product_category'){
								strRecords = strRecords+'<td style="text-align:right"><a href="#" class="action" onclick="AjaxPHPFunction(\'EditProductCategory\',\''+data[0]+'\', \'\');")><span class="typcn typcn-pencil" title="Edit"></span>Edit</a>&nbsp;&nbsp;&nbsp;<a href="#" class="action" onclick="Delete_JS(\'DeleteList\',\''+data[0]+'\')" title="Delete"><span class="typcn typcn-trash"></span>Delete</a></td>';
								strRecords = strRecords+"</tr>";
							} else {
								strRecords = strRecords+'<td style="text-align:right"><a href="'+strUrl+'.php?action=edit&p_id='+data[0]+'" class="action" id="edit" ><span class="typcn typcn-pencil" title="Edit Category"></span>Edit</a>&nbsp;&nbsp;&nbsp;<a href="#" class="action" onclick="DeleteRecord(\''+data[1]+'\')" title="Delete"><span class="typcn typcn-trash"></span>Delete</a></td>';
								strRecords = strRecords+"</tr>";
							}
						}
						document.getElementById("displaylist").innerHTML = "";
						document.getElementById("displaylist").innerHTML = strRecords;
						document.getElementById("current_page").value = record_count
						HideLoading();
					}
				});
			}
		}
	});
}