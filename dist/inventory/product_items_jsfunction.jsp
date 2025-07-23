<script>
/*Required functions. onPageLoad, onAddNewUpdate, onAmendUpdate, onAddNew, onAmend, OnDelete, onCancelAddNew, onCancelAmend*/
function  onPageLoad(){
    LF_product_id();
}   

/* onAddNewUpdate */
function onAddNewUpdate(){
    SetValue('product_id',pad(GetCounter("001","6"),"6"));
}

/* onAmendUpdate */
function onAmendUpdate(){
    
}

/* onAddNew */
function onAddNew(){
    $("#hd_product_name").val(""); 
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
    var strSQL = "select product_name from wasi_product where product_id = '"+GetValue("product_id")+"'";
    var productname = SelectDB(strSQL);
    SetValue("product_name",productname);
}
</script>