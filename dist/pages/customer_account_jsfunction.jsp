<script>
/*Required functions. onPageLoad, onAddNewUpdate, onAmendUpdate, onAddNew, onAmend, OnDelete, onCancelAddNew, onCancelAmend*/
function  onPageLoad(){
    ShowLoading();
    var qrySelect = "select concat(first_name , ' ', last_name) as name from was_customer_info where customer_id = '"+GetValue("customer_id")+"'";
    var result = SelectDB(qrySelect);
    if(result !== ""){
        SetValue("customer_name",result);
    }
    
    var qrySelect1 = "select account_balance from was_account_balance_details where account_number = '"+GetValue("account_number")+"'";
    var result1 = SelectDB(qrySelect1);
    if(result1 !== ""){
        SetValue("account_balance",result1);
    }
    DisplayMode("customer_name","DI");
    DisplayMode("account_balance","DI");
    HideLoading();
    
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
</script>