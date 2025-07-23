<script>
/*Required functions. onPageLoad, onAddNewUpdate, onAmendUpdate, onAddNew, onAmend, OnDelete, onCancelAddNew, onCancelAmend*/
function  onPageLoad(){
    ShowLoading();
        populateCategory();
        var strSQL = "SELECT parent_category FROM was_category where was_id = '"+GetValue("was_id")+"'";
        var result = SelectDB(strSQL);
        SetValue("parent_category",result);
    HideLoading();
    
}   

/* onAddNewUpdate */
function onAddNewUpdate(){
    if(GetValue("parent_category") == "0"){
        var strSQL = "SELECT max(was_id)+ 1 FROM was_category where length(was_id) = 3";
        var result = SelectDB(strSQL);
        if(result == ""){
            SetValue("was_id","101");
        } else {
            SetValue("was_id",result);
        }
    } else {
        var len = GetValue("parent_category").length + 3
        var strSQL = "SELECT max(was_id)+ 1 FROM was_category where  left(was_id, "+GetValue("parent_category").length+") = '"+GetValue("parent_category")+"' and length(was_id) = "+len;
        var result = SelectDB(strSQL);
        if(result == ""){
            SetValue("was_id",GetValue("parent_category")+"101");
        } else {
            SetValue("was_id",result);
        } 
    }
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

function populateCategory(){
    var select = document.getElementById("parent_category");
    var option = document.createElement("option");
    var strSQL = "select was_id, category_name from was_category where length(was_id) = 3";
    var result = SelectDB(strSQL);
    if(result != ""){
        result = result.split('~');
        $("#parent_category").empty();
        $("#parent_category").append($("<option></option>").val(0).html("Main"));
        for (var i=0; i < result.length; i++){
            var value = result[i].split('^');
            var len = value[0].length - 3;
            var space ="";
            for(var x=0; x < len; x++){
                space = space+"\xa0";
            }
            $("#parent_category").append($("<option></option>").val(value[0]).html(space+value[1]));
        }
    }
}
/*
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
} */  
</script>