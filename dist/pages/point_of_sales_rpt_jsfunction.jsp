<script>
$(function() {
    $( "#tabs" ).tabs();
    $( "#tabs" ).tabs({
        disabled: [ 3,4,5 ]
    });
   // $( "#tabs" ).tabs( "option", "active", 5 );
   //$( "#tabs" ).tabs( "enable", 1 );
   SetValue("add_record_date", "<%= CurrentDate() %>");
   SetValue("btnFind", "");
});
  
function AddCustomer(){
    ShowLoading();
    SetValue("add_customer_id", pad(GetCounter("006","10"),"10"));
    var requiredFields = "add_first_name,add_last_name,add_address";
    var fields = "add_customer_id,add_first_name,add_last_name,add_address,add_phone_number,add_email";
    requiredFields = requiredFields.split(',');
    var checkrequiredFields = 0;
    for(x = 0; x < requiredFields.length; x++){
        var fieldID = "#"+requiredFields[x].trim();
        if($(fieldID).val() == ""){
            document.getElementById("lb_"+requiredFields[x].trim()).style.color ="red";
            checkrequiredFields = 1;
        } else {
            document.getElementById("lb_"+requiredFields[x].trim()).style.color ="black";
        }
    }
    if(checkrequiredFields == 1){
        alert("Please input the required fields");
        HideLoading();
        return;  
    }
    
    var strInsert = "insert into was_customer_info (customer_id,first_name,last_name,address,phone_number,email,record_date)"+
                    " values('"+GetValue("add_customer_id")+"','"+GetValue("add_first_name")+"','"+GetValue("add_last_name")+"','"+GetValue("add_address")+"','"+GetValue("add_phone_number")+"','"+GetValue("add_email")+"','"+GetValue("add_record_date")+"')";
    
    var result = InsertDB(strInsert);
    if(result == 1){
        alert("Update record successfully");
        //Add Card Tab
        SetValue("crd_customer_id",GetValue("add_customer_id").toString());
        SetValue("crd_first_name",GetValue("add_first_name"));
        SetValue("crd_last_name",GetValue("add_last_name"));
        
        //Customer Info tab
        SetValue("info_customer_id",GetValue("add_customer_id").toString());
        SetValue("info_first_name",GetValue("add_first_name"));
        SetValue("info_last_name",GetValue("add_last_name"));
        SetValue("info_address",GetValue("add_address"));
        SetValue("info_phone_number",GetValue("add_phone_number"));
        SetValue("info_email",GetValue("add_email"));
        fields = fields.split(',');
        for(x = 0; x < fields.length; x++){
            SetValue(fields[x],"");
        }
        $("#tabs_3").focus();
        $( "#tabs" ).tabs( "enable", 1 );
        //$( "#tabs" ).tabs( "enable", 3 );
        //$( "#tabs" ).tabs( "enable", 4 );
       $( "#tabs" ).tabs( "option", "active", 1 );
    } else {
        alert("Error occur while updating record");
    }
    HideLoading();
}

function load_customer_list(filter){
    var display = "";
    if(filter == ""){
        var strWhere = "";
    } else {
        var strWhere = "where customer_id like ('%"+filter+"%') or first_name like ('%"+filter+"%') or last_name like ('%"+filter+"%')";
    }
    var strSQL = "select customer_id, first_name, last_name from was_customer_info " + strWhere;
    var result = SelectDB(strSQL);
    result = result.split('~');
    for (var i=0; i < result.length; i++){
        display = display + "<tr>";
        var value = result[i].split('^');
        for (var x=0; x < value.length; x++){
            display = display + "<td>" + value[x] + "</td>";
        }
        display = display + '<td style="text-align:right"><a oncontextmenu="return false;" href="#" class="action" id="view" onclick="view_customer_info(\''+value[0]+'\')" ><span class="typcn typcn-pencil" title="Edit"></span>View</a></td>';
        display = display + "</tr>";
    }
    document.getElementById("displaylist").innerHTML = "";
    document.getElementById("displaylist").innerHTML = display;
    
}

function clearFields(){
    var fields = "add_customer_id,add_first_name,add_last_name,add_address,add_phone_number,add_email";
    fields = fields.split(',');
    for(x = 0; x < fields.length; x++){
        SetValue(fields[x],"");
    }
}

function Load(){
    if(GetValue("crd_card_number") == ""){
        alert("Please input the card number.")
        return;
    }
    ShowLoading();
    var strInsert = "insert into was_card_details (card_number,customer_id,effective_date,status,amount)"+
                    " values('"+GetValue("crd_card_number")+"','"+GetValue("crd_customer_id")+"','"+GetValue("crd_effective_date")+"','101','"+GetValue("crd_amount")+"')";
    var result = InsertDB(strInsert);
    if(result == 1){
        alert("Load amount successfully");
        $( "#tabs" ).tabs( "enable", 3 );
        $( "#tabs" ).tabs( "enable", 4 );
        $( "#tabs" ).tabs( "option", "active", 3 );
        $( "#tabs" ).tabs({
            disabled: [ 1 ]
        });
        
        //Customer Info tab
        SetValue("info_card_number",GetValue("crd_card_number").toString());
        SetValue("info_balance",GetValue("crd_amount"));
        
        SetValue("crd_card_number","");
        SetValue("crd_customer_id","");
        SetValue("crd_first_name","");
        SetValue("crd_last_name","");
        load_customer_list("");
    } else {
        alert("Error occur while loading amount");
    }
    HideLoading();
}

function view_customer_info(id){
    ShowLoading();
    var strSQL = "select cust.customer_id, cust.first_name, cust.last_name, cust.address, cust.phone_number, cust.email, card.card_number, card.amount from was_customer_info cust, was_card_details card where cust.customer_id = '"+id+"' and cust.customer_id = card.customer_id";
    var result = SelectDB(strSQL);
    var value = result.split('^');
    //Customer Info tab
    SetValue("info_customer_id",value[0]);
    SetValue("info_first_name",value[1]);
    SetValue("info_last_name",value[2]);
    SetValue("info_address",value[3]);
    SetValue("info_phone_number",value[4]);
    SetValue("info_email",value[5]);
        
    //Customer Info tab
    SetValue("info_card_number",value[6]);
    SetValue("info_balance",value[7]);
    $( "#tabs" ).tabs( "enable", 3 );
    $( "#tabs" ).tabs( "option", "active", 3 );
    DisplayMode("info_topup","EN");
    loadTransInfo(id);
    HideLoading();
}

function loadTransInfo(id){
    var display = "";
    var strSQL = "SELECT trans.record_date,trans.transaction_id,trans.card_number,trans_type.transaction_type,trans.amount FROM was_transaction_details trans, was_cs_transaction_type trans_type where trans.transaction_type = trans_type.was_id and trans.customer_id = '"+id+"' order by trans.record_date";
    var result = SelectDB(strSQL);
    if(result == ""){
        display = display + "<tr><td colspan='6'>No Transactions found.</td></tr>";
    } else {
        result = result.split('~');
        for (var i=0; i < result.length; i++){
            display = display + "<tr>";
            var value = result[i].split('^');
            for (var x=0; x < value.length; x++){
                display = display + "<td>" + value[x] + "</td>";
            }
            display = display + '<td style="text-align:right"><a oncontextmenu="return false;" href="#" class="action" id="view" onclick="window.open(\'<%= baseURL()%>common/pos_receipt.jsp?trans_id='+encrypt(value[1])+'\', \'_blank\', \'resizable=no, scrollbars=yes, titlebar=no, width=300, height=500, top=10, left=10,menubar=no, toolbar=no, location=no, scrollbars=no\')" ><span class="typcn typcn-document-text" title="View"></span>View</a></td>';
            display = display + "</tr>";
        }
    }
    document.getElementById("transInfo").innerHTML = "";
    document.getElementById("transInfo").innerHTML = display;
}

function TopUpLink(){
    var strSQL = "select card.card_number, cust.customer_id, cust.first_name, cust.last_name, card.amount from was_customer_info cust, was_card_details card where cust.customer_id = '"+GetValue("info_customer_id")+"' and cust.customer_id = card.customer_id";
    var result = SelectDB(strSQL);
    var value = result.split('^');
    SetValue("tp_card_number",value[0]);
    SetValue("tp_customer_id",value[1]);
    SetValue("tp_first_name",value[2]);
    SetValue("tp_last_name",value[3]);
    SetValue("tp_balance",value[4]);

    $( "#tabs" ).tabs( "enable", 4 );
    $( "#tabs" ).tabs( "option", "active", 4 );
}

function addAmount(){
    if(GetValue("tp_amount") != ""){
        var total = parseInt(GetValue("tp_amount")) + parseInt(GetValue("tp_balance"));
        SetValue("tp_balance",total.toFixed(2));
    }
}

function TopUp(){
    if(GetValue("tp_amount") == ""){
        alert("Please enter the amount field.");
        SetFocus("tp_amount");
        return;
    }
    alert('topup')
}
function cancelTopup(){
    $( "#tabs" ).tabs({
        disabled: [ 4,5 ]
    });
    $( "#tabs" ).tabs( "option", "active", 3 );
}

function LF_crd_card_number(){
    var strSQL = "select status from was_card_details where card_number ='"+GetValue("crd_card_number")+"'";
    var result = SelectDB(strSQL);
    if(result == "101"){
        alert("Card number is already active.");
        SetFocus("crd_card_number");
        return;
    }
}
</script>