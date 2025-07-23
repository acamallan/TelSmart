<script>
/*Required functions. onPageLoad, onAddNewUpdate, onAmendUpdate, onAddNew, onAmend, OnDelete, onCancelAddNew, onCancelAmend*/
function  onPageLoad(){
    ShowLoading();
    $( "#tabs" ).tabs();
    $( "#tabs" ).tabs( "option", "active", 0 );
    SetStyle("footer_navigation","display","block");
    $( "#tabs" ).tabs( "enable", 1 );
    $( "#tabs" ).tabs( "disable", 2 );
    $( "#tabs" ).tabs( "disable", 3 );
    var qrySelect = "select count(*) count from was_customer_account where link_number ='"+GetValue("link_number")+"'";
    var result = SelectDB(qrySelect);
    if(parseInt(result) > 0){
        $( "#tabs" ).tabs( "enable", 2 );
        $( "#tabs" ).tabs( "enable", 3 );
    }
    HideLoading();
}   

function loadComboSelect(){
    populateStatus();
    populateCardType();
}

/* onAddNewUpdate */
function onAddNewUpdate(){
}

/* onAmendUpdate */
function onAmendUpdate(){
    SetValue("record_date",getServerSession("record_date"));
    SetValue("record_time",currentTime());
    var qrySelect = "select card_number,link_number,card_type,card_status,record_date,record_time,expiry_date from was_card_details where card_number ='"+GetValue("card_number")+"'";
    var result = SelectDB(qrySelect);
    var value = result.split('^');
    var qryInsert = "insert into was_card_details_history(card_number,link_number,card_type,card_status,record_date,record_time,expiry_date) "
            + "values('"+value[0]+"','"+value[1]+"','"+value[2]+"','"+value[3]+"','"+value[4]+"','"+value[5]+"','"+value[6]+"')";
    InsertDB(qryInsert);
}

/* onAddNew */
function onAddNew(){
}

/* onAmend */
function onAmend(){
    $( "#tabs" ).tabs( "disable", 1 );
}

/* OnDelete */
function OnDelete(){
    
}

/* onCancelAddNew */
function onCancelAddNew(){

}

/* onCancelAmend */
function onCancelAmend(){
    $( "#tabs" ).tabs( "enable", 1 );
}

function populateStatus(){
    var qrySQL = "select was_id, card_status from was_cs_card_status";
    var result = SelectDB(qrySQL);
    $("#card_status").empty();
    if(result !== ""){
        result = result.split('~');
        for (var i=0; i < result.length; i++){
            var value = result[i].split('^');
            $("#card_status").append($("<option></option>").val(value[0]).html(value[1]));
        }
    }
}

function populateCardType(){
    var qrySQL = "select was_id, card_type from was_cs_card_type";
    var result = SelectDB(qrySQL);
    $("#card_type").empty();
    if(result !== ""){
        result = result.split('~');
        for (var i=0; i < result.length; i++){
            var value = result[i].split('^');
            $("#card_type").append($("<option></option>").val(value[0]).html(value[1]));
        }
    }
}

function tab1(){
    SetStyle("footer_navigation","display","block");
    $( "#tabs" ).tabs( "enable", 1 );
}

function tab2(){
    ShowLoading();
    SetStyle("footer_navigation","display","none");
    CardDetailsHistory();
    HideLoading();
}

function tab3(){
    ShowLoading();
    SetStyle("footer_navigation","display","none");
    CustomerInfo();
    HideLoading();
}

function tab4(){
    ShowLoading();
    SetStyle("footer_navigation","display","none");
    LoadTransactionDetails();
    HideLoading();
}
function CardDetailsHistory(){
    var qrySelect = "select hist.card_number,hist.link_number,type.card_type,status.card_status,hist.record_date,hist.record_time,hist.expiry_date "
                    + " from was_card_details_history hist, was_cs_card_status status, was_cs_card_type type"
                    + " where hist.card_status = status.was_id and hist.card_type = type.was_id"
                    + " and hist.card_number = '"+GetValue("card_number")+"' order by to_date(hist.record_date) desc, hist.record_time desc";
    var result = SelectDB(qrySelect);
    var display = "";
    if(result !==""){
        result = result.split('~');
        for (var i=0; i < result.length; i++){
            display = display + "<tr>";
            var value = result[i].split('^');
            for (var x=0; x < value.length; x++){
                display = display + "<td style='padding:4px;'>" + value[x] + "</td>";
            }
            display = display + "</tr>";
        }
    } else {
        display = display + "<td style='padding:4px;' colspan='7'>No History Found.</td>";
    }   
    SetValueInner("displayList","");
    SetValueInner("displayList",display);
}

function CustomerInfo(){
    var qrySelect = "select cust.customer_id, concat(first_name, ' ', last_name) customer_name, gender.gender, contact_number, email,acc.account_number"
            + " from was_customer_info cust, was_customer_account acc, was_cs_gender gender"
            + " where cust.gender = gender.was_id and cust.customer_id = acc.customer_id and acc.link_number='"+GetValue("link_number")+"'";
    var result = SelectDB(qrySelect);
    var value = result.split('^');
    var fields = "customer_id,customer_name,gender,contact_number,email,account_number";
    fields = fields.split(',');
    for (var i=0; i < fields.length; i++){
        DisplayMode("hd_tab3_"+fields[i],"DI");
        SetValue("hd_tab3_"+fields[i],value[i]);
    }
    
    var qrySelect2 = "select account_balance from was_account_balance_details where account_number='"+GetValue("hd_tab3_account_number")+"'";
    var balance = SelectDB(qrySelect2);
    SetValue("balance", balance);
    DisplayMode("balance", "DI");
}

function LoadTransactionDetails(){
    var qrySelect = "select transaction_id, transaction_date, transaction_time, transaction_type_txt, credit_amount,debit_amount "
                    + " from view_card_transaction_history where card_number='"+GetValue("card_number")+"'";
    var result = SelectDB(qrySelect);
    result = result.split('~');
    var display = "";
    var total = 0;
    if(result != ""){
        for (var i=0; i < result.length; i++){
            display = display + "<tr>";
            var value = result[i].split('^');
            if(value[4] !== ""){
                total = parseFloat(total) + parseFloat(value[4]);
            } else if(value[5] !== ""){
                total = parseFloat(total) - parseFloat(value[5]);
            }
            
            display = display + "<td style='padding:4px;'>" + value[0] + "</td>";
            display = display + "<td style='padding:4px;'>" + value[1] + "</td>";
            display = display + "<td style='padding:4px;'>" + value[2] + "</td>";
            display = display + "<td style='padding:4px;'>" + value[3] + "</td>";
            display = display + "<td style='padding:4px; text-align:right;'>" + value[4] + "</td>";
            display = display + "<td style='padding:4px; text-align:right;'>" + value[5] + "</td>";
            display = display + "<td style='padding:4px; text-align:right;'><b>" + total.toFixed(2) + "</b></td>";
            display = display + "</tr>";
        }
    }
    SetValueInner("displayTransDetails","");
    SetValueInner("displayTransDetails",display);
}
</script>