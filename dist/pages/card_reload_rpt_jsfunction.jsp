<script>
$(function() {
    ShowLoading();
    Reset();
    populateTransactionType();
    populateCurrrencyType();
    HideLoading();
});

function populateTransactionType(){
    var strSQL = "select was_id, transaction_type from was_cs_transaction_type";
    var result = SelectDB(strSQL);
    if(result != ""){
        result = result.split('~');
        $("#transaction_type").empty();
        $("#transaction_type").append($("<option></option>").val("").html(""));
        for (var i=0; i < result.length; i++){
            var value = result[i].split('^');
            $("#transaction_type").append($("<option></option>").val(value[0]).html(value[1]));
        }
    }
}

function populateCurrrencyType(){
    var strSQL = "select was_id, currency_type from was_cs_currency_type";
    var result = SelectDB(strSQL);
    if(result != ""){
        result = result.split('~');
        $("#currency_type").empty();
        $("#currency_type").append($("<option></option>").val("").html(""));
        for (var i=0; i < result.length; i++){
            var value = result[i].split('^');
            $("#currency_type").append($("<option></option>").val(value[0]).html(value[1]));
        }
    }
}

function LF_card_number(){
    if(GetValue("card_number") !== ""){
        var strSQL = "select acct.customer_id, concat(cust.first_name , ' ', cust.last_name ) as name, acct.account_number,card.link_number "
                    + " from was_customer_account acct, was_card_details card, was_customer_info cust"
                    + " where acct.link_number = card.link_number "
                    + " and acct.customer_id = cust.customer_id"
                    + " and card.card_number = '"+GetValue("card_number")+"'";
        var result = SelectDB(strSQL);
        if(result !== ""){
            var value = result.split('^');
            SetValue("customer_id",value[0]);
            SetValue("customer_name",value[1]);
            SetValue("account_number",value[2]);
            SetValue("link_number",value[3]);
            SetValue("transaction_type","104");
            SetValue("currency_type","101");
            SetValue("userid", getServerSession("userid"));
            SetValue("username", getServerSession("username"));
            var strSQL = "select bal.account_balance "
                    + " from was_customer_account acct, was_account_balance_details bal"
                    + " where acct.account_number = bal.account_number"
                    + " and acct.customer_id = '"+GetValue("customer_id")+"'";
            var result = SelectDB(strSQL);
            if(result !== ""){
                SetValue("balance",result);
            } else {
                SetValue("balance","0.00");
            }
        } else {
            alert('Card Number not found.');
            SetFocus("card_number")
            Reset();
            return;
        }
    } else {
        Reset();
        return;
    }
    
    if(GetValue("card_number") !== "" && GetValue("transaction_amount") !== ""){
        DisplayMode("btnReload","EN");
    } else {
        DisplayMode("btnReload","DI");
    }
}
function LF_transaction_amount(){
    if(GetValue("transaction_amount") !== ""){
        SetValue("transaction_amount", parseInt(GetValue("transaction_amount")).toFixed(2));
    }
    
    if(GetValue("card_number") !== "" && GetValue("transaction_amount") !== ""){
        DisplayMode("btnReload","EN");
    } else {
        DisplayMode("btnReload","DI");
        return;
    }
    SetFocus("btnReload");
}

function Reset(){
    DisplayMode("transaction_id","DI");
    DisplayMode("transaction_date","DI");
    DisplayMode("transaction_time","DI");
    DisplayMode("transaction_type","DI");
    DisplayMode("currency_type","DI");
    DisplayMode("customer_id","DI");
    DisplayMode("link_number","DI");
    DisplayMode("customer_name","DI");
    DisplayMode("balance","DI");
    DisplayMode("userid","DI");
    DisplayMode("username","DI");
    DisplayMode("btnReload","DI");
    SetValue("transaction_id", "");
    SetValue("transaction_date", getServerSession("record_date"));
    SetValue("transaction_time", "");
    SetValue("card_number", "");
    SetValue("transaction_type", "");
    SetValue("currency_type", "");
    SetValue("customer_id", "");
    SetValue("link_number", "");
    SetValue("customer_name", "");
    SetValue("transaction_amount", "");
    SetValue("balance", "");
    SetValue("userid", "");
    SetValue("username", "");
    SetValue("account_number", "");
    SetFocus("card_number");
}

function Reload(){
    SetValue("transaction_time",currentTime());
    SetValue("transaction_id",GetCounter("001","10"));
    var qryInsert = "insert into was_card_transaction_details(transaction_id,transaction_date,transaction_time,card_number,customer_id,transaction_type,currency_type,transaction_amount,userid)"
            + " values('"+GetValue("transaction_id")+"','"+GetValue("transaction_date")+"','"+GetValue("transaction_time")+"','"+GetValue("card_number")+"','"+GetValue("customer_id")+"','"+GetValue("transaction_type")+"','"+GetValue("currency_type")+"','"+GetValue("transaction_amount")+"','"+GetValue("userid")+"')";
    var result = InsertDB(qryInsert);
    if(result === ""){
        return;
    }
    var total = parseFloat(GetValue("transaction_amount")) + parseFloat(GetValue("balance"));
    var qrySelect = "select count(*) from was_account_balance_details where account_number = '"+GetValue("account_number")+"'";
    var count = SelectDB(qrySelect);
    if(count === "0"){
        var qryInsert1 = "insert into was_account_balance_details (account_number, record_date, account_balance,customer_id,link_number)"
                    + "values('"+GetValue("account_number")+"','"+GetValue("transaction_date")+"','"+total.toFixed(2)+"','"+GetValue("customer_id")+"','"+GetValue("link_number")+"')";
        InsertDB(qryInsert1);
    } else {
        var qryUpdate = "update was_account_balance_details set account_balance= '"+total.toFixed(2)+"' where account_number = '"+GetValue("account_number")+"'";
        var result1 = UpdateDB(qryUpdate);
        if(result1 === ""){
            return;
        }
    }
    alert("Reload card successfully.\nNew Balance: "+ total.toFixed(2));
    Reset();
}
</script>
