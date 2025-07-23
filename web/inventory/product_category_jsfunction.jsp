<script>
/*Required functions. onPageLoad, onAddNewUpdate, onAmendUpdate, onAddNew, onAmend, OnDelete, onCancelAddNew, onCancelAmend*/
function  onPageLoad(){

}   

/* onAddNewUpdate */
function onAddNewUpdate(){
    
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

function  CheckProductCategoryID(value){
    var value = pad(value,'3');
    $.ajax({
	url: baseURL()+'functions/inventoryjs.jsp',
	data: {functionname: "CheckProductCategoryID", strValue:value},
	type: 'GET',
	success: function(response) {
            ShowLoading();
            if (response.trim() == 1){
		alert("Product Category ID "+value+" already exist!");
		document.getElementById('product_category_id').focus();
            } 
            HideLoading();
	}
    });
}   
</script>