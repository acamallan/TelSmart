<script>
$(function() {
    ShowLoading();
    populateCardNumbers();
    populateCardStatus();
    Reset();
    autocompleteCustomer();
    HideLoading();
});

function populateCardNumbers(){
    var strSQL = "select card_number, link_number, expiry_date from was_card_details where card_status ='103' and card_type='101' limit 15";
    var result = SelectDB(strSQL);
    $('#displayList').empty();
    if(result != ""){
        var result = result.split('~');
        for (var i=0; i < result.length; i++){
            var value = result[i].split('^');
            $('#displayList').append(
                ' <tr> '
                    + '<td style="padding:10px; border:none; text-align:center;">'+value[0]+'</td>'
                    + '<td style="padding:10px; border:none; text-align:center;">'+value[1]+'</td>'
                    + '<td style="padding:10px; border:none; text-align:center;"><a oncontextmenu="return false;" href="#" onclick="SelectCardNumber('+value[0]+','+value[1]+',\''+value[2]+'\');">Link</a></td>'
                + '</tr>'
            );
        }
    }
}

function populateCardStatus(){
    var strSQL = "select was_id, card_status from was_cs_card_status";
    var result = SelectDB(strSQL);
    if(result != ""){
        result = result.split('~');
        $("#card_status").empty();
        $("#card_status").append($("<option></option>").val("").html(""));
        for (var i=0; i < result.length; i++){
            var value = result[i].split('^');
            $("#card_status").append($("<option></option>").val(value[0]).html(value[1]));
        }
    }
}

function SelectCardNumber(card_number,link_number,expiry_date){
    SetValue("card_number",card_number);
    SetValue("link_number",link_number);
    SetValue("expiry_date",expiry_date);
    SetValue("card_status",103);
    SetValue("record_date",getServerSession("record_date"));
    DisplayMode("btnSave","EN");
    DisplayMode("expiry_date","EN");
    DisplayMode("customer_id","EN");
    DisplayMode("card_status","EN");
    SetFocus("card_status");
}

function Reset(){
    DisplayMode("card_number","DI");
    DisplayMode("link_number","DI");
    DisplayMode("record_date","DI");
    DisplayMode("card_status","DI");
    DisplayMode("expiry_date","DI");
    DisplayMode("customer_id","DI");
    DisplayMode("account_number","DI");
    DisplayMode("customer_name","DI");
    DisplayMode("btnSave","DI");
    SetValue("card_number","");
    SetValue("link_number","");
    SetValue("card_status","");
    SetValue("record_date","");
    SetValue("expiry_date","");
    SetValue("customer_id","");
    SetValue("account_number","");
    SetValue("customer_name","");
}

function Save(){
    ShowLoading();
    var account_number = GetCounter("010","10");
    SetValue("account_number",account_number);
    var qryInsert = "insert into was_customer_account (account_number, record_date, link_number, customer_id)"
                    + "values('"+account_number+"','"+GetValue("record_date")+"','"+GetValue("link_number")+"','"+GetValue("customer_id")+"')";
    var result = InsertDB(qryInsert);
    if(result === ""){
        return;
    }
  /*  var qryInsert1 = "insert into was_account_balance_details (account_number, record_date, account_balance)"
                    + "values('"+account_number+"','"+GetValue("record_date")+"','"+GetValue("account_balance")+"')";
    var result1 = InsertDB(qryInsert1);
    if(result1 === ""){
        return;
    }
    
    var transTime = currentTime();
    var transRef = GetCounter("009","10");
    var qryInsert2 = "insert into was_card_transaction_details(transaction_id,transaction_date,transaction_time,card_number,customer_id,transaction_type,currency_type,transaction_amount,userid)"
            + " values('"+transRef+"','"+GetValue("record_date")+"','"+transTime+"','"+GetValue("card_number")+"','"+GetValue("customer_id")+"','103','101','"+GetValue("account_balance")+"','"+getServerSession("userid")+"')";
    var result2 = InsertDB(qryInsert2);
    if(result2 === ""){
        return;
    } */
    
    var qryUpdate = "update was_card_details set card_status='101', expiry_date = '"+GetValue("expiry_date")+"' where card_number = '"+GetValue("card_number")+"'";
    var result2 = UpdateDB(qryUpdate);
    if(result2 === ""){
        return;
    }
    populateCardNumbers();
    alert("Card Number link to Customer successfully.");
    Reset();
    HideLoading();
    
}

/*
function LF_customer_id(){
    if(GetValue("customer_id") !== ""){
        SetValue("customer_id",pad(GetValue("customer_id"),10));
        var qrySelect = "select concat(first_name , ' ', last_name) as name from was_customer_info where customer_id = '"+GetValue("customer_id")+"'";
        var result = SelectDB(qrySelect);
        if(result !== ""){
            SetValue("customer_name",result);
        } else {
            alert("Customer ID not found.");
            SetValue("customer_id","");
            return;
        }
    } else {
        SetValue("customer_name","");
    }
} */

function autocompleteCustomer(){
    var qrySQL = "select customer_id, concat(first_name , ' ', last_name) as name from was_customer_info ";
    var result = SelectDB(qrySQL);
    if(result !== ""){
        result = result.split('~');
        var tags = "[\n";
        for (var i=0; i < result.length; i++){
            var value = result[i].split('^');
            tags = tags + '{ "value": "'+value[0]+'", "label": "'+ value[0] +'    '+ value[1] +'"},\n';
        }
    }
    tags = tags.slice(',',-2);
    tags = tags + "\n]";
    var yerler = eval(tags);
    $("#customer_id").autocomplete({
        source: yerler,
        minLength: 0,
        minChars: 0,
        focus: function (event, ui) {
            event.preventDefault();
            SetValue("customer_id",ui.item.value);
        },
        select: function (event, ui) {
            event.preventDefault();
            SetValue("customer_id",ui.item.value);
            var name = ui.item.label.split("    ");
            SetValue("customer_name",name[1]);
        }
    }).on('focus', function(event) {
        var self = this;
        $(self).autocomplete( "search", "");;
    });
}
</script>
