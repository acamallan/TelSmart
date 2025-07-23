<script>
/*Required functions. onPageLoad, onAddNewUpdate, onAmendUpdate, onAddNew, onAmend, OnDelete, onCancelAddNew, onCancelAmend*/
function  onPageLoad(){

}   

/* onAddNewUpdate */
function onAddNewUpdate(){
    SetValue('supplier_id',pad(GetCounter("005","6"),"6"));
}

/* onAmendUpdate */
function onAmendUpdate(){
    
}

/* onAddNew */
function onAddNew(){
    
}

/* onAmend */
function onAmend(){
    
}

/* OnDelete */
function OnDelete(){
    
}

/* onCancelAddNew */
function onCancelAddNew(){

}

/* onCancelAmend */
function onCancelAmend(){

}

function LF_company_name(){
    var value = document.getElementById("company_name").value;
		if(value != ""){
			var where = "lower(company_name) = lower('"+value+"')";
			var fields = "company_name";
			var table = "was_supplier";
			ShowLoading();
			$.ajax({
				url: 'libraries/record_function.php',
				data: {functionName: 'CheckRecord', table:table, where:where, fields:fields},
				type: 'GET',
				success: function(response) {
					if(response != ""){
						alert('Company Name already exist!');
						document.getElementById("company_name").focus();
					}
				}
			});
			HideLoading();
		}
	}
</script>