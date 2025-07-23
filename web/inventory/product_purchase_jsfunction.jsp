<script>
/*Required functions. onPageLoad, onAddNewUpdate, onAmendUpdate, onAddNew, onAmend, OnDelete, onCancelAddNew, onCancelAmend*/
function  onPageLoad(){
    LF_product_id()
}   

/* onAddNewUpdate */
function onAddNewUpdate(){
    
}

/* onAmendUpdate */
function onAmendUpdate(){
    
}

/* onAddNew */
function onAddNew(){
    SetValue("hd_product_name","");
    SetValue("hd_category","");
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

function LF_product_id(){
    var strSQL = "select product_name, category from wasi_product where product_id = '"+GetValue("product_id")+"'";
    var strReturn = SelectDB(strSQL);
    strReturn = strReturn.split("^");
    SetValue("hd_product_name",strReturn[0]);
    SetValue("hd_category",strReturn[1]);
}
	
	
	
function getTotal(){
    var strQuantity = document.getElementById("quantity").value;
    var strCostPrice = document.getElementById("cost_price").value;
    if(strCostPrice != "" && strQuantity != ""){
        var total = parseInt(strQuantity) * parseInt(strCostPrice);
	document.getElementById("total_price").value = total.toFixed(2);
    }
		
	}
</script>