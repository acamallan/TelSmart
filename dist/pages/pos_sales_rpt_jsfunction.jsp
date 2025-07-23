<script>
$(function() {
    ShowLoading();
    $( "#tabs" ).tabs();
    $( "#tabs" ).tabs( "option", "active",0 );
    
    $( "#popup_tabs" ).tabs();
    $( "#popup_tabs" ).tabs( "option", "active",0 );
    LoadItems();
    tab1();
    $( "#categoryTabs" ).tabs();
    //DisplayItems("101101","101");
    SetValue("strCounter", "0");
    if(getParameterByName("trans_id") !==""){
        GetTransactionID(decryptJS(getParameterByName("trans_id")));
    }
    
    //SetValue("customer_id","");
    //SetValue("card_number","");
    //SetValue("hd_card_amount","");
    //SetValue("btnFind","");
    SetStyle("displayItems_101101","display","block");
    sessionStorage.setItem('DisplayDIV','101101');
    sessionStorage.setItem('product_id','');
    HideLoading();
});

function tab1(){
    ShowLoading();
    $( "#tabs" ).tabs( "disable",2 );
    ResetSales();
    HideLoading();
}

function minus(counter){
    if(GetValue("quantity["+counter+"]")> 1){
        SetValue("quantity["+counter+"]", parseInt(GetValue("quantity["+counter+"]")) - 1);
        var total = parseInt(GetValue("quantity["+counter+"]")) * parseInt(GetValue("price["+counter+"]"));
        var fieldID = "pay_total_display["+counter+"]";
        var total_amount = "total_amount["+counter+"]";
        SetValueInner(fieldID, total.toFixed(2));
        SetValue(total_amount, total.toFixed(2));
        
    }
}

function add(counter){
    SetValue("quantity["+counter+"]", parseInt(GetValue("quantity["+counter+"]")) + 1);
    var total = parseInt(GetValue("quantity["+counter+"]")) * parseInt(GetValue("price["+counter+"]"));
    var fieldID = "pay_total_display["+counter+"]";
    var total_amount = "total_amount["+counter+"]";
    SetValueInner(fieldID, total.toFixed(2));
    SetValue(total_amount, total.toFixed(2));
}

function getSubTotal(counter){
    if(GetValue("quantity["+counter+"]") != ""){
        var total = parseInt(GetValue("quantity["+counter+"]")) * parseInt(GetValue("price["+counter+"]"));
        var fieldID = "pay_total_display["+counter+"]";
        var total_amount = "total_amount["+counter+"]";
        SetValueInner(fieldID, total.toFixed(2));
        SetValue(total_amount, total.toFixed(2));
    }
}

function LoadItems(){
    var strSQL = "select was_id, category_name, parent_category from was_category order by parent_category, was_id";
    var result = SelectDB(strSQL);
    result = result.split('~');
    var display = "<ul>";
    var count = 0;
    var main = "";
    for (var i=0; i < result.length; i++){
        var value = result[i].split('^');
        if(value[2].length == "1"){
            main = main + value[0] + ",";
            display = display + "<li style='font-weight: bold;'><a oncontextmenu='return false;' href='#categoryTabs_"+value[0]+"' onclick='DisplayItems("+value[0]+"101)' style='padding:8px 20px;'> "+value[1]+" </a></li>";
            count++;
        } 
    }
    main1 = main.slice(',',-1);
    display = display + "</ul>";
    main = main1.split(',');
    
    for (var x=0; x < main.length; x++){
        display = display + "<div id='categoryTabs_"+main[x]+"' style='padding:10px; padding-top:5px;'><br>";
        
        for (var i=count; i < result.length; i++){
            var value = result[i].split('^');
            if(value[2].length == "3"){
                if(main[x] == value[2]){
                    /* Display the subcategories button */
                    display = display + ' <input type="button" name="a" id="a" value="'+value[1]+'" onclick="DisplayItems('+value[0]+')" style="height:50px; width:117.6px; font-size:14px; background-color:#20AA73">';
                } 
            }
        }
        
        /* Start here - Display Items button */
        for (var i=count; i < result.length; i++){
            var value = result[i].split('^');
            if(value[2].length == "3"){
                if(main[x] == value[2]){
                    var strSQLItems = "select product_id, product_name, selling_price from view_product_available where category ='"+value[0]+"' and available > 0";
                    var resultItems = SelectDB(strSQLItems);
                    
                    if(resultItems != ""){
                        resultItems = resultItems.split('~');
                        var itemsDisplay = "";
                        for (var y=0; y < resultItems.length; y++){
                            var valueItems = resultItems[y].split('^');
                            itemsDisplay = itemsDisplay + ' <input type="button" value="'+valueItems[1]+'" onclick="DisplaySaleItems(\''+resultItems[y]+'\')" style="height:50px; width:117.6px; font-size:14px; white-space: normal; vertical-align:middle;">';
                        }
                        display = display + "<div id='displayItems_"+value[0]+"' style='padding:0px; display:none;'><hr>"+itemsDisplay+"</div>";
                    } else {
                        itemsDisplay = "No Items found";
                        display = display + "<div id='displayItems_"+value[0]+"' style='padding:0px; display:none;'><hr>"+itemsDisplay+"</div>";
                    }
                } 
            }
        }
        /* End here */
        display = display + "</div>";
    }
    
    $("#categoryTabs").empty();
    $("#categoryTabs").html(display);
}

function DisplayItems(itemID){
    SetStyle("displayItems_"+sessionStorage.getItem('DisplayDIV'),"display","none");
    SetStyle("displayItems_"+itemID,"display","block");
    sessionStorage.setItem('DisplayDIV',itemID);
}

function DisplaySaleItems(value){
    var value = value.split('^');
    if(GetValueInner("displaySaleItems").trim() === ""){
        sessionStorage.setItem('product_id',"");
    }
    
    if(sessionStorage.getItem('product_id') == value[0]){
        /* Start - Get the maximum value of same ID */
        var lols = document.getElementsByName(value[0]);
        var vals=[];
        for (var i=0, n=lols.length;i<n;i++) {
          vals.push(lols[i].value);
        }
        var lastID = vals.join(",");
        lastID = lastID.split(",");
        var length = lastID.length;
        add(lastID[length-1]);
        /* End */
    } else {
        var counter = parseInt(GetValue('strCounter')) + 1;
        $('#displaySaleItems').append(
            ' <tr id="trSaleItems['+counter+']">'
                + ' <td width="42%"><input type="hidden" name="'+value[0]+'" id="'+value[0]+'" value="'+counter+'"> <input type="hidden" name="dynfields" id="product_id['+counter+']" value="'+value[0]+'"><input type="hidden" name="dynfields" id="product_desc['+counter+']" value="'+value[1]+'">'+value[1]+'</td> '
                + ' <td style="text-align: right; width: 15%;">'+value[2]+'</td>'
                + ' <td width="23%" style="text-align: center">'
                    + ' <input type="hidden" name="dynfields" id="price['+counter+']" value="'+value[2]+'">'
                    + ' <input type="button" value="-" name="minus['+counter+']" id="minus['+counter+']" style="width:20px; height: 18px; padding: 0px; margin: 0px;" onclick="minus('+counter+'); totalSales();">'
                    + ' <input type="text" value="1" name="dynfields" id="quantity['+counter+']" style="width: 40px; text-align: center; padding: 0px; margin: 0px;" onchange="getSubTotal('+counter+'); totalSales();">'
                    + ' <input type="button" value="+" name="add['+counter+']" id="add['+counter+']" style="width:20px; height: 18px; padding: 0px; margin: 0px;" onclick="add('+counter+'); totalSales();">'
                + ' </td>'
                + ' <td style="text-align: right; width: 15%;" ><input type="hidden" name="dynfields" id="total_amount['+counter+']" value="'+value[2]+'"><div id="pay_total_display['+counter+']">'+value[2]+'</div></td>'
                + ' <td style="text-align: right; width: 5%;" ><a oncontextmenu="return false;" href="#" class="action" id="delete" onclick="DeleteSaleItems('+counter+')"  title="Delete" style="font-size: 16px;"><span class="typcn typcn-trash"></span></td>'
            + ' </tr>'
        );
        SetValue("strCounter", counter);
    }
    sessionStorage.setItem('product_id',value[0]);
    totalSales();
    
    var rowpos = $('#displaySaleItems tr:last').position();
    $('.component1').scrollTop(rowpos.top); 
}

function DeleteSaleItems(counter){
    var d = document.getElementById('displaySaleItems');
    var olddiv = document.getElementById('trSaleItems['+counter+']');
    d.removeChild(olddiv);
    totalSales();
}

function totalSales(){
    var strCounter = GetValue('strCounter');
    var total = 0;
    for(var x = 1; x <= strCounter; x++){
        var field = "pay_total_display["+x+"]";
        if (document.getElementById(field) != null){
            total = total + parseInt(GetValueInner(field));
        }
    }
    SetValueInner("totalSales", total.toFixed(2));
}

function Pay(){
    ShowLoading();
    if(GetValueInner("totalSales") !== "0.00"){
        SetStyle("payment","display","block");
        $( "#payment" ).dialog({
            width: 700,
            height: 500,
            modal: true
        });
        populatePaymentMode();
        SetValue("total_amount1", GetValueInner("totalSales"));
        DisplayMode("total_amount1","DI");
        SetValue("total_amount2", GetValueInner("totalSales"));
        DisplayMode("total_amount2","DI");
        DisplayMode("table_id1","DI");
        DisplayMode("table_id2","DI");
        if(GetValue("table_id_hold") !== ""){
            SetValue("table_id1", GetValue("table_id_hold"));
            SetValue("table_id2", GetValue("table_id_hold"));
        } else {
            SetValue("table_id1", GetValue("table_id"));
            SetValue("table_id2", GetValue("table_id"));
        }
        SetValue("table_status1","108");
        SetValue("table_status2","108");
        
        $( "#popup_tabs" ).tabs( "option", "active",0 );
    }
    HideLoading();
}

function HoldPayment(){
    var vrows = document.getElementsByName("dynfields");
    var record_time = currentTime();
    var room_id = GetValue("room_id");
    if(GetValue("sales_id") !== ""){
        DeleteDB("delete from was_product_sales_invoice_header where sales_id='"+GetValue("sales_id")+"'");
        DeleteDB("delete from was_product_sales_invoice where sales_id='"+GetValue("sales_id")+"'");
    } else {
        SetValue("sales_id", GetCounter("009","10"));
        SetValueInner("invoice_number",GetCounter("001","10"));
        InsertDB("insert into was_rest_hold_transaction(sales_id,transaction_date,transaction_time,table_id) values('"+GetValue("sales_id")+"','"+getServerSession("record_date")+"','"+record_time+"','"+GetValue("table_id")+"')" );
    }
    
    var strInsert = "insert into was_product_sales_invoice_header (invoice_number,sales_id,customer_id,record_date,userid,payment_status,due_amount,actual_amount,room_id,record_time)"+
                " values('"+GetValueInner("invoice_number")+"','"+GetValue("sales_id")+"','"+GetValue("customer_id")+"','"+getServerSession("record_date")+"','"+getServerSession("userid")+"','103','"+GetValueInner("totalSales")+"','"+GetValueInner("totalSales")+"','"+room_id+"','"+record_time+"')";
    InsertDB(strInsert);
    var i = 0;
    for (var x = 0; x < vrows.length/5; x++) {
        var product_id = vrows[i].getAttribute( 'id' );
        var product_desc = vrows[i+1].getAttribute( 'id' );
        var price = vrows[i+2].getAttribute( 'id' );
        var quantity = vrows[i+3].getAttribute( 'id' );
        var total_amount = vrows[i+4].getAttribute( 'id' );
        var strInsert = "insert into was_product_sales_invoice (sales_id,product_id,description,quantity,price,total_amount,record_date,record_time,location)"+
                                " values('"+GetValue("sales_id")+"','"+GetValue(product_id)+"','"+GetValue(product_desc)+"','"+GetValue(quantity)+"','"+GetValue(price)+"','"+GetValue(total_amount)+"','"+getServerSession("record_date")+"','"+record_time+"','104')";
        var result1 = InsertDB(strInsert);
        var i = i+5;
    }
    if (result1 == ""){
        alert("Error while processing payment.");
        HideLoading();
        return;
    }
    if (result1 === ""){
        alert("Error while processing payment.");
        return;
    }
    //update table status
    UpdateDB("update was_rest_table_details set table_status='101' where table_id = '"+GetValue("table_id")+"'");         
    
  
    swal({   
        title: "<small>Hold payment succesfully!</small>",   
        text: "",   
        type: "success",
        html: true,
        showCancelButton: false,   
        confirmButtonText: "OK",   
        closeOnConfirm: true 
    },function(){  
        ResetSales();
    });
    
}

function CancelTrans(){
    if(GetValueInner("sales_id") !== ""){
        qryUpdate = "update was_product_sales_order set payment_status = '103' where sales_id ='"+GetValueInner("sales_id")+"'";
        var result = UpdateDB(qryUpdate);
        if(result !== ""){
           swal({   
            title: "<small>Cancel transaction succesfully!</small>",   
            text: "",   
            type: "success",
            html: true,
            showCancelButton: false,   
            confirmButtonText: "OK",   
            closeOnConfirm: true 
            },function(){  
                $("#displaySaleItems").empty();
                SetValueInner("totalSales", "0.00");
                SetValueInner("amount", "");
                SetValueInner("sales_id", "");
                SetValueInner("customer_name", "");
            }); 
        } else {
            swal({   
            title: "<small>Error occur while cancelling transaction!</small>",   
            text: "",   
            type: "error",
            html: true,
            showCancelButton: false,   
            confirmButtonText: "OK",   
            closeOnConfirm: true 
            },function(){  
                $("#displaySaleItems").empty();
                SetValueInner("totalSales", "0.00");
                SetValueInner("amount", "");
                SetValueInner("sales_id", "");
                SetValueInner("customer_name", "");
            }); 
        }
    }
}

function clearSales(){
    $("#displaySaleItems").empty();
    SetValueInner("totalSales", "0.00");
    SetValue("record_date","");
    SetValue("customer_id","");
    SetValue("card_number","");
    SetValue("hd_card_amount","");
    sessionStorage.setItem('product_id','');
}

function populateRoomID(){
    var qrySQL = "SELECT room_id FROM was_hotel_book_transactions where book_status='2'";
    var result = SelectDB(qrySQL);
    $("#room_id").empty();
    if(result !== ""){
        result = result.split('~');
        $("#room_id").append($("<option></option>").val("").html(""));
        for (var i=0; i < result.length; i++){
            $("#room_id").append($("<option></option>").val(result[i]).html(result[i]));
        }
    }
}

function LF_room_id(){
    ShowLoading();
    var room_id = GetValue("room_id");
    if(room_id !== ""){
        var qrySelect = "select trans.customer_id, concat(cust.first_name, ' ', cust.last_name) name"
                + " from was_hotel_book_transactions trans, was_customer_info cust"
                + " where trans.customer_id = cust.customer_id and trans.room_id = '"+room_id+"'";
        var result = SelectDB(qrySelect);
        if(result !== ""){
        var value = result.split('^');
            var customer_id = value[0];
            var customer_name = value[1];
            SetValue("customer_id",customer_id);
            SetValue("customer_name", customer_name);
        }
    }
    HideLoading();
}

function tab2(){
    var display = "";
        var strSQL = "select table_id, table_status from was_rest_table_details order by cast(table_id as decimal)" ;
        var result = SelectDB(strSQL);
        var display = "";
        if(result !== ""){
            result = result.split('~');
            for (var i=0; i < result.length; i++){
                var value = result[i].split('^');
                if(value[1] === "108"){
                    display = display + '<div class="circle_AB">'+value[0]+'</div>';
                } else if (value[1] === "101"){
                    display = display + '<div class="circle_NAB">'+value[0]+'</div>';
                } else if(value[1] === "110") {
                    display = display + '<div class="circle_RB">'+value[0]+'</div>';
                }
                
                
            }
        }
        SetValueInner("displayTables","");
        SetValueInner("displayTables",display);
}

//popup
function ChargetoRoom(){
    ShowLoading();
    var vrows = document.getElementsByName("dynfields");
    var record_time = currentTime();
    var room_id = GetValue("room_id");
    if(GetValue("sales_id") !== ""){
        DeleteDB("delete from was_product_sales_invoice_header where sales_id='"+GetValue("sales_id")+"'");
        DeleteDB("delete from was_product_sales_invoice where sales_id='"+GetValue("sales_id")+"'");
    } else {
        SetValue("sales_id", GetCounter("009","10"));
        SetValueInner("invoice_number",GetCounter("001","10"));
        InsertDB("insert into was_rest_hold_transaction(sales_id,transaction_date,transaction_time,table_id) values('"+GetValue("sales_id")+"','"+getServerSession("record_date")+"','"+record_time+"','"+GetValue("table_id")+"')" );
    }
    
    var strInsert = "insert into was_product_sales_invoice_header (invoice_number,sales_id,customer_id,record_date,userid,payment_status,due_amount,actual_amount,room_id,record_time)"+
                " values('"+GetValueInner("invoice_number")+"','"+GetValue("sales_id")+"','"+GetValue("customer_id")+"','"+getServerSession("record_date")+"','"+getServerSession("userid")+"','102','"+GetValueInner("totalSales")+"','"+GetValueInner("totalSales")+"','"+room_id+"','"+record_time+"')";
    InsertDB(strInsert);

    var items = "";
    var i = 0;
    for (var x = 0; x < vrows.length/5; x++) {
        var product_id = vrows[i].getAttribute( 'id' );
        var product_desc = vrows[i+1].getAttribute( 'id' );
        var price = vrows[i+2].getAttribute( 'id' );
        var quantity = vrows[i+3].getAttribute( 'id' );
        var total_amount = vrows[i+4].getAttribute( 'id' );
        var strInsert = "insert into was_product_sales_invoice (sales_id,product_id,description,quantity,price,total_amount,record_date,record_time,location)"+
                    " values('"+GetValue("sales_id")+"','"+GetValue(product_id)+"','"+GetValue(product_desc)+"','"+GetValue(quantity)+"','"+GetValue(price)+"','"+GetValue(total_amount)+"','"+getServerSession("record_date")+"','"+record_time+"','104')";
        var result1 = InsertDB(strInsert);
        var i = i+5;
        items = items + '<tr><td style="text-align:left;">'+GetValue(product_desc)+'</td>'
                    + '<td>'+GetValue(quantity)+'</td>'
                    + '<td style="text-align:right;">'+GetValue(total_amount)+'</td></tr>';
    }
    if (result1 == ""){
        alert("Error while processing payment.");
        HideLoading();
        return;
    }
    window.open(baseURL()+'common/print_receipt.jsp?paid=0&items='+encryptJS(items)+'&table_number='+encryptJS(GetValue("table_id"))+'&sales_invoice='+encryptJS(GetValueInner("invoice_number"))+'&total='+encryptJS(GetValueInner("totalSales"))+'&room_id='+encryptJS(room_id)+'&customer_name='+encryptJS(GetValue("customer_name")), '_blank', 'resizable=no, scrollbars=yes, titlebar=no, width=300, height=600, top=10, left=10,menubar=no, toolbar=no, location=no, scrollbars=no');    
    //update table status
    UpdateDB("update was_rest_table_details set table_status='"+GetValue("table_status2")+"' where table_id = '"+GetValue("table_id2")+"'");
    //delete table id in was_rest_hold_transaction
    DeleteDB("delete from was_rest_hold_transaction where table_id = '"+GetValue("table_id2")+"'");
    swal({   
        title: "<small>Charge Payment to Room succesfully!</small>",   
        type: "success",
        html: true,
        showCancelButton: false,   
        confirmButtonText: "OK",   
        closeOnConfirm: true 
    },function(){  
        ResetSales();
        $('#payment').dialog('close');
    });
    
    HideLoading();
}

function Paid(){
    ShowLoading();
    if(GetValueInner("amount") !== ""){
        var vrows = document.getElementsByName("dynfields");
        var record_time = currentTime();
        var room_id = "";
        var customer_id = "0000000000";
        var payment_mode = GetValue("payment_mode");
        if(GetValue("sales_id") !== ""){
            DeleteDB("delete from was_product_sales_invoice_header where sales_id='"+GetValue("sales_id")+"'");
            DeleteDB("delete from was_product_sales_invoice where sales_id='"+GetValue("sales_id")+"'");
        } else {
            SetValue("sales_id", GetCounter("001","10"));
            SetValueInner("invoice_number",GetCounter("009","10"));
            InsertDB("insert into was_rest_hold_transaction(sales_id,transaction_date,transaction_time,table_id) values('"+GetValue("sales_id")+"','"+getServerSession("record_date")+"','"+record_time+"','"+GetValue("table_id")+"')" );
        }

        var strInsert = "insert into was_product_sales_invoice_header (invoice_number,sales_id,customer_id,record_date,userid,payment_status,due_amount,actual_amount,room_id,record_time,payment_mode)"+
                    " values('"+GetValueInner("invoice_number")+"','"+GetValue("sales_id")+"','"+customer_id+"','"+getServerSession("record_date")+"','"+getServerSession("userid")+"','101','"+GetValueInner("totalSales")+"','"+GetValueInner("totalSales")+"','"+room_id+"','"+record_time+"','"+payment_mode+"')";
        InsertDB(strInsert);

        var items = "";//use for receipt
        var i = 0;
        for (var x = 0; x < vrows.length/5; x++) {
            var product_id = vrows[i].getAttribute( 'id' );
            var product_desc = vrows[i+1].getAttribute( 'id' );
            var price = vrows[i+2].getAttribute( 'id' );
            var quantity = vrows[i+3].getAttribute( 'id' );
            var total_amount = vrows[i+4].getAttribute( 'id' );
            var strInsert = "insert into was_product_sales_invoice (sales_id,product_id,description,quantity,price,total_amount,record_date,record_time,location)"+
                        " values('"+GetValue("sales_id")+"','"+GetValue(product_id)+"','"+GetValue(product_desc)+"','"+GetValue(quantity)+"','"+GetValue(price)+"','"+GetValue(total_amount)+"','"+getServerSession("record_date")+"','"+record_time+"','104')";
            var result1 = InsertDB(strInsert);
            var i = i+5;

            items = items + '<tr><td style="text-align:left;">'+GetValue(product_desc)+'</td>'
                    + '<td>'+GetValue(quantity)+'</td>'
                    + '<td style="text-align:right;">'+GetValue(total_amount)+'</td></tr>';
        }
        if (result1 == ""){
            alert("Error while processing payment.");
            HideLoading();
            return;
        }

        //update table status
        UpdateDB("update was_rest_table_details set table_status='"+GetValue("table_status1")+"' where table_id = '"+GetValue("table_id1")+"'");
        //delete table id in was_rest_hold_transaction
        DeleteDB("delete from was_rest_hold_transaction where table_id = '"+GetValue("table_id1")+"'");

        var change = parseInt(GetValueInner("amount")) - parseInt(GetValueInner("totalSales"));
        window.open(baseURL()+'common/print_receipt.jsp?paid=1&items='+encryptJS(items)+'&table_number='+encryptJS(GetValue("table_id"))+'&sales_invoice='+encryptJS(GetValueInner("invoice_number"))+'&total='+encryptJS(GetValueInner("totalSales"))+'&amount='+encryptJS(parseInt(GetValueInner("amount")).toFixed(2))+'&change='+encryptJS(change.toFixed(2)), '_blank', 'resizable=no, scrollbars=yes, titlebar=no, width=300, height=600, top=10, left=10,menubar=no, toolbar=no, location=no, scrollbars=no');
        swal({   
            title: "<small>Save payment succesfully!</small>",   
            text: "Change: <span style='font-weight: bold;'>"+change.toFixed(2)+"</span>",   
            type: "success",
            html: true,
            showCancelButton: false,   
            confirmButtonText: "OK",   
            closeOnConfirm: true 
        },function(){  
            ResetSales();
            $('#payment').dialog('close');
        });
    }
    HideLoading();
}

function populatePaymentMode(){
    var qrySQL = "SELECT was_id, payment_mode FROM was_cs_payment_mode";
    var result = SelectDB(qrySQL);
    $("#payment_mode").empty();
    if(result !== ""){
        result = result.split('~');
        for (var i=0; i < result.length; i++){
            var value = result[i].split('^');
            $("#payment_mode").append($("<option></option>").val(value[0]).html(value[1]));
        }
    }
}

function populateTablesAvailable(){
    var qrySQL = "SELECT table_id, table_id FROM was_rest_table_details where table_status ='108' order by cast(table_id as decimal)";
    var result = SelectDB(qrySQL);
    $("#table_id").empty();
    if(result !== ""){
        result = result.split('~');
        $("#table_id").append($("<option></option>").val("").html(""));
        for (var i=0; i < result.length; i++){
            var value = result[i].split('^');
            $("#table_id").append($("<option></option>").val(value[0]).html(value[1]));
        }
    }
}

function populateTables(){
    var qrySQL = "SELECT table_id, table_id FROM was_rest_table_details order by cast(table_id as decimal)";
    var result = SelectDB(qrySQL);
    $("#table_id1").empty();
    $("#table_id2").empty();
    if(result !== ""){
        result = result.split('~');
        for (var i=0; i < result.length; i++){
            var value = result[i].split('^');
            $("#table_id1").append($("<option></option>").val(value[0]).html(value[1]));
            $("#table_id2").append($("<option></option>").val(value[0]).html(value[1]));
        }
    }
}

function populateHoldTables(){
    var qrySQL = "SELECT table_id, table_id FROM was_rest_hold_transaction order by cast(table_id as decimal)";
    var result = SelectDB(qrySQL);
    $("#table_id_hold").empty();
    if(result !== ""){
        result = result.split('~');
        $("#table_id_hold").append($("<option></option>").val("").html(""));
        for (var i=0; i < result.length; i++){
            var value = result[i].split('^');
            $("#table_id_hold").append($("<option></option>").val(value[0]).html(value[1]));
            
        }
    }
}

function populateTableStatus(){
    var qrySQL = "SELECT was_id, room_status FROM was_cs_hotel_room_status";
    var result = SelectDB(qrySQL);
    $("#table_status1").empty();
    $("#table_status2").empty();
    if(result !== ""){
        result = result.split('~');
        for (var i=0; i < result.length; i++){
            var value = result[i].split('^');
            $("#table_status1").append($("<option></option>").val(value[0]).html(value[1]));
            $("#table_status2").append($("<option></option>").val(value[0]).html(value[1]));
        }
    }
}

function LF_table_id_hold(){
    ShowLoading();
    if(GetValue("table_id_hold") !== ""){
        var sales_id = SelectDB("select sales_id from was_rest_hold_transaction where table_id ='"+GetValue("table_id_hold")+"'");
        SetValue("sales_id",sales_id);
        var invoice_number = SelectDB("select invoice_number from was_product_sales_invoice_header where sales_id= '"+sales_id+"'");
        SetValueInner("invoice_number",invoice_number);

        var qrySQL = "select sale.product_id, product_name, price, quantity, total_amount from was_product_sales_invoice sale, was_product prod where sales_id = '"+sales_id+"' and sale.product_id = prod.product_id";
        var result = SelectDB(qrySQL);
        result = result.split('~');
        var counter = 1;
        $('#displaySaleItems').empty();
        for (var i=0; i < result.length; i++){
            var value = result[i].split('^');
            $('#displaySaleItems').append(
                ' <tr id="trSaleItems['+counter+']">'
                    + ' <td width="40%"><input type="hidden" name="'+value[0]+'" id="'+value[0]+'" value="'+counter+'"> <input type="hidden" name="dynfields" id="product_id['+counter+']" value="'+value[0]+'"><input type="hidden" name="dynfields" id="product_desc['+counter+']" value="'+value[1]+'">'+value[1]+'</td> '
                    + ' <td style="text-align: right; width: 15%;">'+value[2]+'</td>'
                    + ' <td width="23%" style="text-align: center">'
                        + ' <input type="hidden" name="dynfields" id="price['+counter+']" value="'+value[2]+'">'
                        + ' <input type="button" value="-" name="minus['+counter+']" id="minus['+counter+']" style="width:20px; height: 18px; padding: 0px; margin: 0px;" onclick="minus('+counter+'); totalSales();">'
                        + ' <input type="text" value="'+value[3]+'" name="dynfields" id="quantity['+counter+']" style="width: 40px; text-align: center; padding: 0px; margin: 0px;" onchange="getSubTotal('+counter+'); totalSales();">'
                        + ' <input type="button" value="+" name="add['+counter+']" id="add['+counter+']" style="width:20px; height: 18px; padding: 0px; margin: 0px;" onclick="add('+counter+'); totalSales();">'
                    + ' </td>'
                    + ' <td style="text-align: right; width: 15%;" ><input type="hidden" name="dynfields" id="total_amount['+counter+']" value="'+value[4]+'"><div id="pay_total_display['+counter+']">'+value[4]+'</div></td>'
                    + ' <td style="text-align: right; width: 5%;" ><a oncontextmenu="return false;" href="#" class="action" id="delete" onclick="DeleteSaleItems('+counter+')"  title="Delete" style="font-size: 16px;"><span class="typcn typcn-trash"></span></td>'
                + ' </tr>'
            );
            counter++;
        }
        SetValue("strCounter", counter);
        SetSession('product_id',value[0]);
        totalSales();
        SetValue("table_id","");
        DisplayMode("table_id","DI");
    } else {
        DisplayMode("table_id","EN");
        ResetSales();
    }
    HideLoading();

}

function ResetSales(){
    $("#displaySaleItems").empty();
    SetValueInner("totalSales", "0.00");
    SetValueInner("invoice_number", "");
    SetValueInner("amount", "");
    SetValue("room_id", "");
    SetValue("customer_name", "");
    SetValue("sales_id", "");
    SetValue("customer_id", "");
    SetValue("record_time", "");
    DisplayMode("table_id","EN");
    populateTables();
    populateHoldTables();
    populateTablesAvailable();
    populateRoomID();
    populateTableStatus();
}
</script>