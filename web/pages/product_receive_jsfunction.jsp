<script>
/*Required functions. onPageLoad, onAddNewUpdate, onAmendUpdate, onAddNew, onAmend, OnDelete, onCancelAddNew, onCancelAmend*/
function  onPageLoad(){
    $( "#tabs" ).tabs();
    $( "#tabs" ).tabs( "option", "active", 0 );
    var strSQL = "select purchase_id, product_id, description, quantity, cost_price, total_price, location, gl_code, tab from was_product_receive where receive_id='"+GetValue("receive_id")+"'";
    var strReturn = SelectDB(strSQL);
    var qrySelect = "SELECT was_id, location FROM was_cs_product_location order by location";
    var result = SelectDB(qrySelect);
    SetValue("strCounter",0);
    SetValue("strCounter_2",0);
    SetValue("strCounter_3",0);
    $('#displayList').empty();
    $('#displayList_2').empty();
    $('#displayList_3').empty();
    if(strReturn !== ""){
        var record = strReturn.split('~');
        $("#displayList").find("tr:gt(0)").remove();
        for(x = 1; x <= record.length; x++){
            var data = record[x-1].split('^');
            if(data[8] == 1){
                var counter = parseInt(document.getElementById('strCounter').value) + 1;
                $('#displayList').append(
                    ' <tr id="trPurchase_'+counter+'"> '
                        + '<td style="padding:1px"><input  type="text" name="dynfields" value="'+data[0]+'" class="tags" id="purchase_id_'+counter+'" style="width:80px;" onfocus="GetFldID('+counter+')" disabled></td>'
                        + '<td style="padding:1px"><input  type="text" name="dynfields" value="'+data[1]+'" class="tags" id="product_id_'+counter+'" style="width:60px;" onblur="LF_product_id('+counter+')" disabled></td>'
                        + '<td style="padding:1px"><input type="text" name="dynfields" value="'+data[2]+'" id="description_'+counter+'" style="width:170px;" disabled></td>'
                        + '<td style="padding:1px"><select name="dynfields" id="location_'+counter+'" style="width:100px;" disabled></select></td>'
                        + '<td style="padding:1px"><input type="text" name="dynfields" value="'+data[3]+'" id="quantity_'+counter+'" style="width:80px;" disabled></td>'
                        + '<td style="padding:1px"><select name="dynfields" id="gl_code_'+counter+'" style="width:150px;" disabled></select></td>'
                        + '<td style="padding:1px"><input type="text" name="dynfields" value="'+data[4]+'" id="cost_price_'+counter+'" style="width:80px;" disabled></td>'
                        + '<td style="padding:1px"><input type="text" name="dynfields" value="'+data[5]+'" id="total_price_'+counter+'" style="width:60px;" onkeypress="validate(event)" disabled>'
                        + '<div style="float:right; margin-right:-2px; margin-top:-30px"><a oncontextmenu="return false;" href="#" class="action" id="RemoveEntry" onclick="RemoveEntryPurch('+counter+')" title="Remove Entry" tabindex="-1"></a></div></td>'
                        + '</td>'
                    + '</tr>'
                );
                
                var location = "#location_"+counter;
                $(location).empty();
                if(result !== ""){
                    var result1 = result.split('~');
                    $(location).append($("<option></option>").val("").html(""));
                    for (var i=0; i < result1.length; i++){
                        var value = result1[i].split('^');
                        $(location).append($("<option></option>").val(value[0]).html(value[1]));
                    }
                }
                
                var qrySelect = "SELECT was_id, account_type FROM was_chart_of_account order by account_type";
                var resultcoa = SelectDB(qrySelect);
                var gl_code = "#gl_code_"+counter;
                $(gl_code).empty();
                if(result !== ""){
                    var result1 = resultcoa.split('~');
                    $(gl_code).append($("<option></option>").val("").html(""));
                    for (var i=0; i < result1.length; i++){
                        var value = result1[i].split('^');
                        $(gl_code).append($("<option></option>").val(value[0]).html(value[1]));
                    }
                }
                
                SetValue("location_"+counter,data[6]);
                SetValue("gl_code_"+counter,data[7]);
                SetValue("strCounter",counter); 
                $( "#tabs" ).tabs( "disable", 1 );
                $( "#tabs" ).tabs( "enable", 0 );
                $( "#tabs" ).tabs( "option", "active", 0 );
                getTotalAmount();
            }
            if(data[8] == 2){
                var counter = parseInt(document.getElementById('strCounter_2').value) + 1;
                $('#displayList_2').append(
                    ' <tr id="trPurchase_2_'+counter+'"> '
                        + '<td style="padding:1px"><input  type="text" name="dynfields" value="'+data[0]+'" class="tags" id="purchase_id_2_'+counter+'" style="width:80px;" onfocus="GetFldID('+counter+')" disabled></td>'
                        + '<td style="padding:1px"><input  type="text" name="dynfields" value="'+data[1]+'" class="tags" id="product_id_2_'+counter+'" style="width:60px;" onblur="LF_product_id('+counter+')" disabled></td>'
                        + '<td style="padding:1px"><input type="text" name="dynfields" value="'+data[2]+'" id="description_2_'+counter+'" style="width:170px;" disabled></td>'
                        + '<td style="padding:1px"><select name="dynfields" id="location_2_'+counter+'" style="width:100px;" disabled></select></td>'
                        + '<td style="padding:1px"><input type="text" name="dynfields" value="'+data[3]+'" id="quantity_2_'+counter+'" style="width:80px;" disabled></td>'
                        + '<td style="padding:1px"><select name="dynfields" id="gl_code_2_'+counter+'" style="width:150px;" disabled></select></td>'
                        + '<td style="padding:1px"><input type="text" name="dynfields" value="'+data[4]+'" id="cost_price_2_'+counter+'" style="width:80px;" disabled></td>'
                        + '<td style="padding:1px"><input type="text" name="dynfields" value="'+data[5]+'" id="total_price_2_'+counter+'" style="width:60px;" onkeypress="validate(event)" disabled>'
                        + '<div style="float:right; margin-right:-2px; margin-top:-30px"><a oncontextmenu="return false;" href="#" class="action" id="RemoveEntry" onclick="RemoveEntryPurch('+counter+')" title="Remove Entry" tabindex="-1"></a></div></td>'
                        + '</td>'
                    + '</tr>'
                );
                var location = "#location_2_"+counter;
                $(location).empty();
                if(result !== ""){
                    var result1 = result.split('~');
                    $(location).append($("<option></option>").val("").html(""));
                    for (var i=0; i < result1.length; i++){
                        var value = result1[i].split('^');
                        $(location).append($("<option></option>").val(value[0]).html(value[1]));
                    }
                }
                SetValue("location_2_"+counter,data[6]);
                var qrySelect = "SELECT was_id, account_type FROM was_chart_of_account order by account_type";
                var resultcoa = SelectDB(qrySelect);
                var gl_code = "#gl_code_2_"+counter;
                $(gl_code).empty();
                if(result !== ""){
                    var result1 = resultcoa.split('~');
                    $(gl_code).append($("<option></option>").val("").html(""));
                    for (var i=0; i < result1.length; i++){
                        var value = result1[i].split('^');
                        $(gl_code).append($("<option></option>").val(value[0]).html(value[1]));
                    }
                }
                SetValue("gl_code_2_"+counter,data[7]);
                
                SetValue("strCounter_2",counter); 
                $( "#tabs" ).tabs( "disable", 0 );
                $( "#tabs" ).tabs( "enable", 1 );
                $( "#tabs" ).tabs( "option", "active", 1 );
                getTotalAmount_2();
            }
            
            if(data[8] == 3){
                var counter = parseInt(document.getElementById('strCounter_3').value) + 1;
                $('#displayList_3').append(
                    ' <tr id="trPurchase_3_'+counter+'"> '
                        + '<td style="padding:1px"><input  type="text" name="dynfields" value="'+data[0]+'" class="tags" id="purchase_id_3_'+counter+'" style="width:80px;" onfocus="GetFldID('+counter+')" disabled></td>'
                        + '<td style="padding:1px"><input  type="text" name="dynfields" value="'+data[1]+'" class="tags" id="product_id_3_'+counter+'" style="width:60px;" onblur="LF_product_id('+counter+')" disabled></td>'
                        + '<td style="padding:1px"><input type="text" name="dynfields" value="'+data[2]+'" id="description_3_'+counter+'" style="width:170px;" disabled></td>'
                        + '<td style="padding:1px"><select name="dynfields" id="location_3_'+counter+'" style="width:100px;" disabled></select></td>'
                        + '<td style="padding:1px"><input type="text" name="dynfields" value="'+data[3]+'" id="quantity_3_'+counter+'" style="width:80px;" disabled></td>'
                        + '<td style="padding:1px"><select name="dynfields" id="gl_code_3_'+counter+'" style="width:150px;" disabled></select></td>'
                        + '<td style="padding:1px"><input type="text" name="dynfields" value="'+data[4]+'" id="cost_price_3_'+counter+'" style="width:80px;" disabled></td>'
                        + '<td style="padding:1px"><input type="text" name="dynfields" value="'+data[5]+'" id="total_price_3_'+counter+'" style="width:60px;" onkeypress="validate(event)" disabled>'
                        + '<div style="float:right; margin-right:-2px; margin-top:-30px"><a oncontextmenu="return false;" href="#" class="action" id="RemoveEntry" onclick="RemoveEntryPurch('+counter+')" title="Remove Entry" tabindex="-1"></a></div></td>'
                        + '</td>'
                    + '</tr>'
                );
                var location = "#location_3_"+counter;
                $(location).empty();
                if(result !== ""){
                    var result1 = result.split('~');
                    $(location).append($("<option></option>").val("").html(""));
                    for (var i=0; i < result1.length; i++){
                        var value = result1[i].split('^');
                        $(location).append($("<option></option>").val(value[0]).html(value[1]));
                    }
                }
                SetValue("location_3_"+counter,data[6]);
                
                var qrySelect = "SELECT was_id, account_type FROM was_chart_of_account order by account_type";
                var resultcoa = SelectDB(qrySelect);
                var gl_code = "#gl_code_3_"+counter;
                $(gl_code).empty();
                if(result !== ""){
                    var result1 = resultcoa.split('~');
                    $(gl_code).append($("<option></option>").val("").html(""));
                    for (var i=0; i < result1.length; i++){
                        var value = result1[i].split('^');
                        $(gl_code).append($("<option></option>").val(value[0]).html(value[1]));
                    }
                }
                SetValue("gl_code_3_"+counter,data[7]);
                
                SetValue("strCounter_3",counter); 
                $( "#tabs" ).tabs( "enable", 2 );
                getTotalAmount_3();
            } else {
                $( "#tabs" ).tabs( "disable", 2 );
            }
        } 
    } 

    DisplayMode("hd_username","DI");
    DisplayMode("hd_locationbtn","DI");
    var qrySQL = "select username from was_user_info where userid = '"+GetValue("userid")+"'";
    var result = SelectDB(qrySQL);
    if(result !== ""){
        SetValue("hd_username", result);
    } else {
        SetValue("hd_username", "");
    }
    getTotalAmount();
    $('#tdentry').empty();
    $('#tdentry_2').empty();
    $('#tdentry_3').empty();
    document.getElementById("hd_btnJournal").onclick = function() { window.open(baseURL()+"common/journalEntry.jsp?receive_id="+encrypt(GetValue("receive_id")), "_blank", "resizable=yes, scrollbars=yes, titlebar=no, width=600, height=500, top=30, left=400,menubar=no, toolbar=no, location=no, scrollbars=no"); };
}   

function loadComboSelect(){
    populateSupplier();
}
/* onAddNewUpdate */
function onAddNewUpdate(){
    if(GetValue("receive_id") === ""){
        var trans_id = GetCounter("001","10");
        SetValue("transaction_id", trans_id);
        SetValue("receive_id", trans_id);
    }
    
    //tab1
    if(GetValueInner("TotalAmount") !== "0.00"){
        var vrows = document.getElementsByName("dynfields");
        var a = 0;
        var update = true;
        for (var x = 0; x < vrows.length/8; x++) {
            var purchase_id = vrows[a].getAttribute( 'id' );
            var product_id = vrows[a+1].getAttribute( 'id' );
            var description = vrows[a+2].getAttribute( 'id' );
            var location = vrows[a+3].getAttribute( 'id' );
            var quantity = vrows[a+4].getAttribute( 'id' );
            var gl_code = vrows[a+5].getAttribute( 'id' );
            var cost_price = vrows[a+6].getAttribute( 'id' );
            var total_price = vrows[a+7].getAttribute( 'id' );
            if(GetValue(purchase_id) === "" || GetValue(product_id) === "" ||GetValue(location) === "" || GetValue(quantity) === "" || GetValue(gl_code) === ""){
                update = false;
            }

            var a = a+8;
        }
        if(update == false){
            alert('Please complete all Product Receive fields.')
            Success(false);
            return;
        }
        var i = 0;
        for (var x = 0; x < vrows.length/8; x++) {
            var purchase_id = vrows[i].getAttribute( 'id' );
            var product_id = vrows[i+1].getAttribute( 'id' );
            var description = vrows[i+2].getAttribute( 'id' );
            var location = vrows[i+3].getAttribute( 'id' );
            var quantity = vrows[i+4].getAttribute( 'id' );
            var gl_code = vrows[i+5].getAttribute( 'id' );
            var cost_price = vrows[i+6].getAttribute( 'id' );
            var total_price = vrows[i+7].getAttribute( 'id' );

            var qrySelect = "select partial from was_product_purchase where purchase_id ='"+GetValue(purchase_id)+"' and product_id = '"+GetValue(product_id)+"'";
            var result = SelectDB(qrySelect);
            var totalPatrial = parseInt(result) + parseInt(GetValue(quantity));
            var qryUpdate = "update was_product_purchase set partial='"+totalPatrial+"' where purchase_id ='"+GetValue(purchase_id)+"' and product_id = '"+GetValue(product_id)+"'";
            UpdateDB(qryUpdate);

            var strInsert = "insert into was_product_receive (purchase_id,record_date,product_id,description,quantity,cost_price,total_price,receive_id,purchase_status,location,tab,gl_code)"+
                            " values('"+GetValue(purchase_id)+"','"+GetValue("record_date")+"','"+GetValue(product_id)+"','"+GetValue(description)+"','"+GetValue(quantity)+"','"+GetValue(cost_price)+"','"+GetValue(total_price)+"','"+GetValue("receive_id")+"','101','"+GetValue(location)+"','1','"+GetValue(gl_code)+"')";
            InsertDB(strInsert);
            var i = i+8;
        }
    }
    //tab1 end
    
    //tab2
    if(GetValueInner("TotalAmount_2") !== "0.00"){
        var vrows = document.getElementsByName("dynfields_2");
        var a = 0;
        var update = true;
        for (var x = 0; x < vrows.length/8; x++) {
            var purchase_id = vrows[a].getAttribute( 'id' );
            var product_id = vrows[a+1].getAttribute( 'id' );
            var description = vrows[a+2].getAttribute( 'id' );
            var location = vrows[a+3].getAttribute( 'id' );
            var quantity = vrows[a+4].getAttribute( 'id' );
            var gl_code = vrows[a+5].getAttribute( 'id' );
            var cost_price = vrows[a+6].getAttribute( 'id' );
            var total_price = vrows[a+7].getAttribute( 'id' );
            if(GetValue(purchase_id) === "" || GetValue(product_id) === "" ||GetValue(location) === "" || GetValue(quantity) === "" || GetValue(gl_code) === ""){
                update = false;
            }

            var a = a+8;
        }
        if(update == false){
            alert('Please complete all Product Receive fields.')
            Success(false);
            return;
        }
        var i = 0;
        for (var x = 0; x < vrows.length/8; x++) {
            var purchase_id = vrows[i].getAttribute( 'id' );
            var product_id = vrows[i+1].getAttribute( 'id' );
            var description = vrows[i+2].getAttribute( 'id' );
            var location = vrows[i+3].getAttribute( 'id' );
            var quantity = vrows[i+4].getAttribute( 'id' );
            var gl_code = vrows[i+5].getAttribute( 'id' );
            var cost_price = vrows[i+6].getAttribute( 'id' );
            var total_price = vrows[i+7].getAttribute( 'id' );

            var qrySelect = "select partial from was_product_purchase where purchase_id ='"+GetValue(purchase_id)+"' and product_id = '"+GetValue(product_id)+"'";
            var result = SelectDB(qrySelect);
            var totalPatrial = parseInt(result) + parseInt(GetValue(quantity));
            var qryUpdate = "update was_product_purchase set partial='"+totalPatrial+"' where purchase_id ='"+GetValue(purchase_id)+"' and product_id = '"+GetValue(product_id)+"'";
            UpdateDB(qryUpdate);

            var strInsert = "insert into was_product_receive (purchase_id,record_date,product_id,description,quantity,cost_price,total_price,receive_id,purchase_status,location,tab,gl_code)"+
                            " values('"+GetValue(purchase_id)+"','"+GetValue("record_date")+"','"+GetValue(product_id)+"','"+GetValue(description)+"','"+GetValue(quantity)+"','"+GetValue(cost_price)+"','"+GetValue(total_price)+"','"+GetValue("receive_id")+"','101','"+GetValue(location)+"','2','"+GetValue(gl_code)+"')";
            InsertDB(strInsert);
            var i = i+8;
        }
    }
    //tab2 end
    
    //tab3
    if(GetValueInner("TotalAmount_3") !== "0.00"){
        var vrows = document.getElementsByName("dynfields_3");
        var a = 0;
        var update = true;
        for (var x = 0; x < vrows.length/8; x++) {
            var purchase_id = vrows[a].getAttribute( 'id' );
            var product_id = vrows[a+1].getAttribute( 'id' );
            var description = vrows[a+2].getAttribute( 'id' );
            var location = vrows[a+3].getAttribute( 'id' );
            var quantity = vrows[a+4].getAttribute( 'id' );
            var gl_code = vrows[a+5].getAttribute( 'id' );
            var cost_price = vrows[a+6].getAttribute( 'id' );
            var total_price = vrows[a+7].getAttribute( 'id' );
            if(GetValue(purchase_id) === "" || GetValue(product_id) === "" ||GetValue(location) === "" || GetValue(quantity) === "" || GetValue(gl_code) === ""){
                update = false;
            }

            var a = a+8;
        }
        if(update == false){
            alert('Please complete all Product Receive fields.')
            Success(false);
            return;
        }
        var i = 0;
        for (var x = 0; x < vrows.length/7; x++) {
            var purchase_id = vrows[i].getAttribute( 'id' );
            var product_id = vrows[i+1].getAttribute( 'id' );
            var description = vrows[i+2].getAttribute( 'id' );
            var location = vrows[i+3].getAttribute( 'id' );
            var quantity = vrows[i+4].getAttribute( 'id' );
            var gl_code = vrows[i+5].getAttribute( 'id' );
            var cost_price = vrows[i+6].getAttribute( 'id' );
            var total_price = vrows[i+7].getAttribute( 'id' );

            var qrySelect = "select partial from was_product_purchase where purchase_id ='"+GetValue(purchase_id)+"' and product_id = '"+GetValue(product_id)+"'";
            var result = SelectDB(qrySelect);
            var totalPatrial = parseInt(result) + parseInt(GetValue(quantity));
            var qryUpdate = "update was_product_purchase set partial='"+totalPatrial+"' where purchase_id ='"+GetValue(purchase_id)+"' and product_id = '"+GetValue(product_id)+"'";
            UpdateDB(qryUpdate);

            var strInsert = "insert into was_product_receive (purchase_id,record_date,product_id,description,quantity,cost_price,total_price,receive_id,purchase_status,location,tab,gl_code)"+
                            " values('"+GetValue(purchase_id)+"','"+GetValue("record_date")+"','"+GetValue(product_id)+"','"+GetValue(description)+"','"+GetValue(quantity)+"','"+GetValue(cost_price)+"','"+GetValue(total_price)+"','"+GetValue("receive_id")+"','101','"+GetValue(location)+"','3','"+GetValue(gl_code)+"')";
            InsertDB(strInsert);
            var i = i+7;
        }
    }
    
    var totalAmount = parseInt(GetValueInner("TotalAmount")) + parseInt(GetValueInner("TotalAmount_2")) + parseInt(GetValueInner("TotalAmount_3"));
    var qryInsert1 = "insert into was_accounting_details(accounting_id,transaction_id,record_date,transaction_type,gl_code,credit_amount,debit_amount)"
                    + " values('"+GetCounter("002","10")+"','P"+GetValue("receive_id")+"','"+GetValue("record_date")+"','101','1001','"+totalAmount.toFixed(2)+"','')";
    InsertDB(qryInsert1);
    
    var qryInsert2 = "insert into was_accounting_details(accounting_id,transaction_id,record_date,transaction_type,gl_code,credit_amount,debit_amount)"
                    + " values('"+GetCounter("002","10")+"','P"+GetValue("receive_id")+"','"+GetValue("record_date")+"','101','1002','','"+totalAmount.toFixed(2)+"')";
    InsertDB(qryInsert2);
    //tab3 end
    populateSupplier();
}

/* onAmendUpdate */
function onAmendUpdate(){/*
    var qryDelete = "delete from was_product_purchase where purchase_id='"+GetValue("purchase_id")+"'";
    DeleteDB(qryDelete);
    var vrows = document.getElementsByName("dynfields");
    var i = 0;
    for (var x = 0; x < vrows.length/5; x++) {
        var product_id = vrows[i].getAttribute( 'id' );
        var description = vrows[i+1].getAttribute( 'id' );
        var quantity = vrows[i+2].getAttribute( 'id' );
        var cost_price = vrows[i+3].getAttribute( 'id' );
        var total_price = vrows[i+4].getAttribute( 'id' );
        var strInsert = "insert into was_product_purchase (purchase_id,record_date,product_id,description,quantity,cost_price,total_price)"+
                            " values('"+GetValue("purchase_id")+"','"+GetValue("record_date")+"','"+GetValue(product_id)+"','"+GetValue(description)+"','"+GetValue(quantity)+"','"+GetValue(cost_price)+"','"+GetValue(total_price)+"')";
        InsertDB(strInsert);
        var i = i+5;
        DisplayMode(product_id, "DI");
        DisplayMode(description, "DI");
        DisplayMode(quantity, "DI");
        DisplayMode(cost_price, "DI");
        DisplayMode(total_price, "DI");
        $('#RemoveEntry').remove();
    }
    $('#trentry').empty(); */
}

/* onAddNew */
function onAddNew(){
   SetValue("record_date",getServerSession("record_date"));
   $('#tdentry').append('<td width="60%" style="border:none; " id="entry"><input type="button" name="hd_addEntry" id="hd_addEntry" onclick="AddEntryRec()" value="Add Entry" style="width:100px;" onclick=""></td>');
    SetValue("strCounter", 1);
    
    $('#displayList').empty();
    $('#displayList_2').empty();
    $('#displayList_3').empty();
    $('#displayList').append(
       ' <tr id="trPurchase_1"> '
            + '<td style="padding:1px"><input  type="text" name="dynfields" value="" class="tags" id="purchase_id_1" style="width:80px;" onfocus="GetFldID(1)" onblur="LF_product_id(1)"></td>'
            + '<td style="padding:1px"><input  type="text" name="dynfields" value="" class="tags" id="product_id_1" style="width:60px;" onblur="LF_product_id(1)"></td>'
            + '<td style="padding:1px"><input type="text" name="dynfields" value="" id="description_1" style="width:170px;"></td>'
            + '<td style="padding:1px"><select name="dynfields" id="location_1" style="width:100px;"></select></td>'
            + '<td style="padding:1px"><input type="text" name="dynfields" value="" id="quantity_1" style="width:80px;" onblur="getTotal(1)"></td>'
            + '<td style="padding:1px"><select name="dynfields" id="gl_code_1" style="width:150px;"></select></td>'
            + '<td style="padding:1px"><input type="text" name="dynfields" value="" id="cost_price_1" style="width:80px;" onblur="getTotal(1)"></td>'
            + '<td style="padding:1px"><input type="text" name="dynfields" value="" id="total_price_1" style="width:60px;" onkeypress="validate(event)" disabled>'
            + '<div style="float:right; margin-right:-2px; margin-top:0px"><a oncontextmenu="return false;" href="#" class="action" id="RemoveEntry" onclick="RemoveEntryPurch(1)" title="Remove Entry" tabindex="-1"><span class="typcn typcn-minus"></span></a></div></td>'
        + '</tr>'
    );
    
    var qrySQL = "SELECT was_id, location FROM was_cs_product_location order by location";
    var result = SelectDB(qrySQL);
    var field = "#location_1";
    $(field).empty();
    if(result !== ""){
        result = result.split('~');
        $(field).append($("<option></option>").val("").html(""));
        for (var i=0; i < result.length; i++){
            var value = result[i].split('^');
            $(field).append($("<option></option>").val(value[0]).html(value[1]));
        }
    }
    
    var qrySelect = "SELECT was_id, account_type FROM was_chart_of_account order by account_type";
    var result = SelectDB(qrySelect);
    var gl_code = "#gl_code_1";
    $(gl_code).empty();
    if(result !== ""){
        var result1 = result.split('~');
        $(gl_code).append($("<option></option>").val("").html(""));
        for (var i=0; i < result1.length; i++){
            var value = result1[i].split('^');
            $(gl_code).append($("<option></option>").val(value[0]).html(value[1]));
        }
    }
                
    autocomplete();
    populateSupplierNew();
   // DisplayMode("hd_addSuplierbtn","EN");
    SetValue("userid", getServerSession("userid"));
    DisplayMode("hd_username","DI");
    SetValue("hd_username", getServerSession("username"));
    SetValue("not_invoiced",1);
    SetValueInner("TotalAmount","0.00");
    SetValueInner("TotalAmount_2","0.00");
    SetValueInner("TotalAmount_3","0.00");
    $( "#tabs" ).tabs();
    $( "#tabs" ).tabs( "enable", 0 );
    $( "#tabs" ).tabs( "enable", 1 );
    $( "#tabs" ).tabs( "enable", 2 );
    $( "#tabs" ).tabs( "option", "active", 0 );
}

/* onAmend */
function onAmend(){
    var strSQL = "select purchase_id, product_id, description, quantity, cost_price, total_price from was_product_receive where receive_id='"+GetValue("receive_id")+"'";
    var strReturn = SelectDB(strSQL);
    SetValue("strCounter",0);
    if(strReturn !== ""){
        var record = strReturn.split('~');
        $("#displayList").empty();
        for(x = 1; x <= record.length; x++){
            var data = record[x-1].split('^');
            var counter = parseInt(GetValue('strCounter')) + 1;
            $('#displayList').append(
                ' <tr id="trPurchase_'+counter+'"> '
                    + '<td style="padding:1px"><input  type="text" name="dynfields" value="'+data[0]+'" class="tags" id="purchase_id_'+counter+'" style="width:80px;" onfocus="GetFldID('+counter+')"></td>'
                    + '<td style="padding:1px"><input  type="text" name="dynfields" value="'+data[1]+'" class="tags" id="product_id_'+counter+'" style="width:80px;" onblur="LF_product_id('+counter+')"></td>'
                    + '<td style="padding:1px"><input type="text" name="dynfields" value="'+data[2]+'" id="description_'+counter+'" style="width:200px;"></td>'
                    + '<td style="padding:1px"><input type="text" name="dynfields" value="'+data[3]+'" id="quantity_'+counter+'" style="width:80px;"></td>'
                    + '<td style="padding:1px"><input type="text" name="dynfields" value="'+data[4]+'" id="cost_price_'+counter+'" style="width:80px;"></td>'
                    + '<td style="padding:1px"><input type="text" name="dynfields" value="'+data[5]+'" id="total_price_'+counter+'" style="width:60px;" disabled>'
                    + '<div style="float:right; margin-right:-2px; margin-top:0px"><a oncontextmenu="return false;" href="#" class="action" id="RemoveEntry" onclick="RemoveEntryPurch('+counter+')" title="Remove Entry" tabindex="-1"><span class="typcn typcn-minus"></span></a></div></td>'
                    + '</td>'
                + '</tr>'
            );
            SetValue("strCounter",counter);
        }
    }
    $('#tdentry').append('<a oncontextmenu="return false;" href="#" class="action" id="AddEntry" onclick="AddEntryRec()" title="Add Entry"><span class="typcn typcn-plus"></span>Add Entry</a>');
    autocomplete();
    
}

/* OnDelete */
function OnDelete(){
    var qryDelete = "delete from was_product_receive where receive_id = '"+GetValue("receive_id")+"'";
    DeleteDB(qryDelete);
}

/* onCancelAddNew */
function onCancelAddNew(){
    $('#tdentry').empty();
    $('#RemoveEntry').empty();
    $('#displayList').empty();
    $('#displayList_2').empty();
    $('#displayList_3').empty();
    $( "#tabs" ).tabs( "disable", 0 );
    $( "#tabs" ).tabs( "disable", 1 );
    $( "#tabs" ).tabs( "disable", 2 );
}

/* onCancelAmend */
function onCancelAmend(){
    $('#tdentry').empty();
    $('#RemoveEntry').empty();   
}

function populateSupplier(){
    var qrySQL = "SELECT supplier_id, company_name FROM was_supplier order by company_name";
    var result = SelectDB(qrySQL);
    if(result !== ""){
        result = result.split('~');
        var selectobject=document.getElementById("supplier_id")
        for (var i=0; i<selectobject.length; i++){
           selectobject.remove(i);
        }
        $("#supplier_id").append($("<option></option>").val("").html(""));
        for (var i=0; i < result.length; i++){
            var value = result[i].split('^');
            $("#supplier_id").append($("<option></option>").val(value[0]).html(value[1]));
        }
    }
}

function AddEntryRec(){
    var counter = parseInt(GetValue('strCounter')) + 1;
    $('#displayList').append(
       ' <tr id="trPurchase_'+counter+'"> '
            + '<td style="padding:1px"><input  type="text" name="dynfields" value="" class="tags" id="purchase_id_'+counter+'" style="width:80px;" onfocus="GetFldID('+counter+')" onblur="LF_product_id(1)"></td>'
            + '<td style="padding:1px"><input  type="text" name="dynfields" value="" class="tags" id="product_id_'+counter+'" style="width:60px;" onblur="LF_product_id('+counter+')"></td>'
            + '<td style="padding:1px"><input type="text" name="dynfields" value="" id="description_'+counter+'" style="width:170px;"></td>'
            + '<td style="padding:1px"><select name="dynfields" id="location_'+counter+'" style="width:100px;"></select></td>'
            + '<td style="padding:1px"><input type="text" name="dynfields" value="" id="quantity_'+counter+'" style="width:80px;" onblur="getTotal('+counter+')"></td>'
            + '<td style="padding:1px"><select name="dynfields" id="gl_code_'+counter+'" style="width:150px;"></select></td>'
            + '<td style="padding:1px"><input type="text" name="dynfields" value="" id="cost_price_'+counter+'" style="width:80px;" onblur="getTotal('+counter+')"></td>'
            + '<td style="padding:1px"><input type="text" name="dynfields" value="" id="total_price_'+counter+'" style="width:60px;" onkeypress="validate(event)" disabled>'
            + '<div style="float:right; margin-right:-2px; margin-top:0px"><a oncontextmenu="return false;" href="#" class="action" id="RemoveEntry" onclick="RemoveEntryPurch('+counter+')" title="Remove Entry" tabindex="-1"><span class="typcn typcn-minus"></span></a></div></td>'
        + '</tr>'
    );
        
    var qrySQL = "SELECT was_id, location FROM was_cs_product_location order by location";
    var result = SelectDB(qrySQL);
    var field = "#location_"+counter;
    $(field).empty();
    if(result !== ""){
    result = result.split('~');
    $(field).append($("<option></option>").val("").html(""));
    for (var i=0; i < result.length; i++){
        var value = result[i].split('^');
        $(field).append($("<option></option>").val(value[0]).html(value[1]));
        }
    }
    
    var qrySelect = "SELECT was_id, account_type FROM was_chart_of_account order by account_type";
    var result = SelectDB(qrySelect);
    var gl_code = "#gl_code_"+counter;
    $(gl_code).empty();
    if(result !== ""){
        var result1 = result.split('~');
        $(gl_code).append($("<option></option>").val("").html(""));
        for (var i=0; i < result1.length; i++){
            var value = result1[i].split('^');
            $(gl_code).append($("<option></option>").val(value[0]).html(value[1]));
        }
    }
    
    SetValue('strCounter', counter);
    autocomplete();
    SetFocus("purchase_id_"+counter);
}

function RemoveEntryPurch(counter){
    var d = document.getElementById('displayList');
    var olddiv = document.getElementById('trPurchase_'+counter);
    d.removeChild(olddiv);
    getTotalAmount();
}

function getTotal(counter){
    var strQuantity = GetValue("quantity_"+counter);
    var strCostPrice = GetValue("cost_price_"+counter);
    if(strCostPrice !== "" && strQuantity !== ""){
        var total = parseInt(strQuantity) * parseInt(strCostPrice);
	SetValue("total_price_"+counter,total.toFixed(2));
    }
    getTotalAmount();
}

function getTotalAmount(){
    var totalAmount = 0;
    var strCounter = GetValue('strCounter');
    for(var x = 1; x <= strCounter; x++){
        var strTotalPrice = 'total_price_'+x;
        var strQuantity = 'quantity_'+x;
	if (document.getElementById(strTotalPrice) != null){
            if(GetValue(strQuantity) !== ""){
                totalAmount = parseInt(totalAmount) + parseInt(GetValue(strTotalPrice));
            }
	}			
    }
    SetValueInner("TotalAmount","");
    SetValueInner("TotalAmount",totalAmount.toFixed(2));
    if(totalAmount.toFixed(2) === "0.00"){
        $( "#tabs" ).tabs( "enable", 1 );
    } else {
        $( "#tabs" ).tabs( "disable", 1 );
    }
}

function populateCategory(){
    var qrySQL = "select was_id, category_name from was_category";
    var result = SelectDB(qrySQL);
    if(result !== ""){
        result = result.split('~');
        $("#hd_category").empty();
        $("#hd_category").append($("<option></option>").val("").html(""));
        for (var i=0; i < result.length; i++){
            var value = result[i].split('^');
            var len = value[0].length - 3;
            var space ="";
            for(var x=0; x < len; x++){
                space = space+"\xa0";
            }
            $("#hd_category").append($("<option></option>").val(value[0]).html(space+value[1]));
        }
    }
}

function populateSupplierNew(){
    var qrySQL = "select distinct  head.supplier_id, supplier.company_name from was_product_purchase body, was_product_purchase_header head, was_supplier supplier "
            + " where purchase_status in ('102','103') and quantity-partial > 0 and body.purchase_id = head.purchase_id and head.supplier_id = supplier.supplier_id";
    var result = SelectDB(qrySQL);
    if(result !== ""){
        result = result.split('~');
        $("#supplier_id").empty();
        $("#supplier_id").append($("<option></option>").val("").html(""));
        for (var i=0; i < result.length; i++){
            var value = result[i].split('^');
            $("#supplier_id").append($("<option></option>").val(value[0]).html(value[1]));
        }
    }
}

$.ui.autocomplete.prototype._renderItem = function (ul, item) {
    return $("<li></li>")
      .data("item.autocomplete", item)
      .append($("<span></span>").html(item.label))
      .appendTo(ul);
  };
  
function autocomplete(){
    var qrySQL = "select distinct purchase_id, product_id, description from was_product_purchase where purchase_status in ('102','103') and quantity-partial > 0";
    var result = SelectDB(qrySQL);
    var tags = "";
    if(result !== ""){
        result = result.split('~');
        tags = "[\n";
        for (var i=0; i < result.length; i++){
            var value = result[i].split('^');
            tags = tags + '{ "value": "'+value[0]+'", "label": "'+ value[0] +'    '+ value[1] +'    '+ value[2] +'"},\n';
        }
        tags = tags.slice(',',-2);
        tags = tags + "\n]";
    
    
        var count = GetValue("strCompleteCount");
        var yerler = eval(tags);
        $(".tags").autocomplete({
            source: yerler,
            minLength: 0,
            minChars: 0,
            focus: function (event, ui) {
                event.preventDefault();

                SetValue("purchase_id_"+count,ui.item.value);
            },
            select: function (event, ui) {
                event.preventDefault();
                SetValue("purchase_id_"+count,ui.item.value);
                var value = ui.item.label.split("    ");
                SetValue("product_id_"+count,value[1]);
                SetValue("description_"+count,value[2]);

            }
        }).on('focus', function(event) {
            var self = this;
            $(self).autocomplete( "search", "");;
        });
    }   
}

function LF_product_id(counter){
    var value = GetValue("product_id_"+counter);
    if(value !== ""){
        var qrySQL = "select quantity-partial as count, cost_price, total_price from was_product_purchase where product_id = '"+value+"' and purchase_id = '"+GetValue("purchase_id_"+counter)+"'";
        var result = SelectDB(qrySQL);
        var value = result.split("^");
        SetValue("quantity_"+counter,value[0]);
        SetValue("cost_price_"+counter,value[1]);
        var total = value[0]*value[1];
        SetValue("total_price_"+counter,total.toFixed(2));
        getTotalAmount();
    }
}

function GetFldID(count){
    SetValue("strCompleteCount",count);
    autocomplete();
}

function AddSupplierBtn(){
    SetStyle("dialog","display","block");
    $( "#dialog" ).dialog({
        width: 600,
        height: 400,
        modal: true
    });
    SetValue("hd_supplier_id","");
    SetValue("hd_company_name","");
    SetValue("hd_contact_first_name","");
    SetValue("hd_contact_last_name","");
    SetValue("hd_address","");
    SetValue("hd_phone","");
    SetValue("hd_fax","");
    SetValue("hd_email","");
}

function AddSupplier(){
    SetValue('hd_supplier_id',pad(GetCounter("005","6"),"6"));
    var qryInsert = "insert into was_supplier (supplier_id, company_name, contact_first_name, contact_last_name, address, phone, fax, email)"
        + "values('"+GetValue("hd_supplier_id")+"', '"+GetValue("hd_company_name")+"', '"+GetValue("hd_contact_first_name")+"', '"+GetValue("hd_contact_last_name")+"', '"+GetValue("hd_address")+"', '"+GetValue("hd_phone")+"', '"+GetValue("hd_fax")+"', '"+GetValue("hd_email")+"')";
    InsertDB(qryInsert);
    $('#dialog').dialog('close');
    populateSupplier();
    SetValue("supplier_id", GetValue("hd_supplier_id"));
    SetFocus("supplier_id");
}

function PopUpLocation(){
    ShowLoading();
    var qrySelect = "select was_id, location from was_cs_product_location order by was_id" ;
    var result = SelectDB(qrySelect);
    var display = "";
    if(result !== ""){
        result = result.split('~');
        for (var i=0; i < result.length; i++){
            var value = result[i].split('^');
            display = display + "<tr>";
            display = display + '<td style="text-align:center;"><input type="hidden" name="dynfields" id="hd_location_id[' + i + ']" value="'+value[0]+'">'+value[0]+'</td>'
            display = display + '<td style="text-align:center;"><input type="hidden" name="dynfields" id="hd_location_name[' + i + ']" value="'+value[1]+'">'+value[1]+'</td>'
            display = display + '<td style="text-align:center;"><a oncontextmenu="return false;" href="#" class="action" id="view" onclick="PopUpEditLocation(\''+i+'\')" ><span class="typcn typcn-pencil" title="Edit"></span>Edit</a>&nbsp;&nbsp;&nbsp;<a oncontextmenu="return false;" href="#" class="action" id="delete" onclick="PopUpDeleteLocation(\''+value[0]+'\')" title="Delete"><span class="typcn typcn-trash"></span>Delete</a></td>';
            display = display + "</tr>";
        }
    }
    SetValueInner("displayLocation","");
    SetValueInner("displayLocation",display);
    SetValue("strCounterLoc",i);
    SetStyle("dialog","display","block");
    $( "#dialog" ).dialog({
        width: 700,
        height: 500,
        modal: true,
        close: function(event, ui){ SetValueInner("displayLocation",""); }}).dialog("open");
    HideLoading();
}

function PopUpSaveLocation(){
    var qryDelete = "delete from was_cs_product_location where was_id ='"+GetValue("hd_location_id")+"'";
    DeleteDB(qryDelete);
    var was_id = GetValue("hd_location_id");
    var GetMaxID = SelectDB("select max(was_id) from was_cs_product_location");
    if(was_id === ""){
        if(GetMaxID  !== ""){
            was_id = parseInt(GetMaxID) + 1;
            SetValue("hd_location_id",was_id);
        } else {
            was_id = "101";
            SetValue("hd_location_id",was_id);
        }
    }
    
    var qryInsert = "insert into was_cs_product_location(was_id, location) values('"+GetValue("hd_location_id")+"','"+GetValue("hd_location_name")+"')";
    InsertDB(qryInsert);
    
    var qrySelect = "select was_id, location from was_cs_product_location order by was_id" ;
    var result = SelectDB(qrySelect);
    var display = "";
    if(result !== ""){
        result = result.split('~');
        for (var i=0; i < result.length; i++){
            var value = result[i].split('^');
            display = display + "<tr>";
            display = display + '<td style="padding:3px"><input type="hidden" name="dynfields" id="hd_location_id[' + i + ']" value="'+value[0]+'">'+value[0]+'</td>'
            display = display + '<td style="text-align:center;"><input type="hidden" name="dynfields" id="hd_location_name[' + i + ']" value="'+value[1]+'">'+value[1]+'</td>'
            display = display + '<td style="text-align:center;"><a oncontextmenu="return false;" href="#" class="action" id="view" onclick="PopUpEditLocation(\''+i+'\')" ><span class="typcn typcn-pencil" title="Edit"></span>Edit</a>&nbsp;&nbsp;&nbsp;<a oncontextmenu="return false;" href="#" class="action" id="delete" onclick="PopUpDeleteLocation(\''+value[0]+'\')" title="Delete"><span class="typcn typcn-trash"></span>Delete</a></td>';
            display = display + "</tr>";
        }
    }
    SetValueInner("displayLocation","");
    SetValueInner("displayLocation",display);
    SetValue("strCounterLoc",i);
    SetValue("hd_location_id","");
    SetValue("hd_location_name","");
}

function PopUpEditLocation(counter){
    SetValue("hd_location_id",GetValue("hd_location_id["+counter+"]"));
    SetValue("hd_location_name",GetValue("hd_location_name["+counter+"]"));
}

function PopUpDeleteLocation(value){
    var qryDelete = "delete from was_cs_product_location where was_id ='"+value+"'";
    DeleteDB(qryDelete);
    
    var qrySelect = "select was_id, location from was_cs_product_location order by was_id" ;
    var result = SelectDB(qrySelect);
    var display = "";
    if(result !== ""){
        result = result.split('~');
        for (var i=0; i < result.length; i++){
            var value = result[i].split('^');
            display = display + "<tr>";
            display = display + '<td style="padding:3px"><input type="hidden" name="dynfields" id="hd_location_id[' + i + ']" value="'+value[0]+'">'+value[0]+'</td>'
            display = display + '<td style="text-align:center;"><input type="hidden" name="dynfields" id="hd_location_name[' + i + ']" value="'+value[1]+'">'+value[1]+'</td>'
            display = display + '<td style="text-align:center;"><a oncontextmenu="return false;" href="#" class="action" id="view" onclick="PopUpEditLocation(\''+i+'\')" ><span class="typcn typcn-pencil" title="Edit"></span>Edit</a>&nbsp;&nbsp;&nbsp;<a oncontextmenu="return false;" href="#" class="action" id="delete" onclick="PopUpDeleteLocation(\''+value[0]+'\')" title="Delete"><span class="typcn typcn-trash"></span>Delete</a></td>';
            display = display + "</tr>";
        }
    }
    SetValueInner("displayLocation","");
    SetValueInner("displayLocation",display);
    HideLoading();
}

function LF_supplier_id(){
    ShowLoading();
    if(GetValue("supplier_id") !== ""){
        if(GetValueInner("TotalAmount") === "0.00"){
            $('#displayList').empty();
            $('#displayList_2').empty();
            $('#displayList_3').empty();
            var qrySelect = "select distinct  body.purchase_id, body.product_id from was_product_purchase body, was_product_purchase_header head, was_supplier supplier "
                + " where purchase_status in ('102','103') and quantity-partial > 0 and body.purchase_id = head.purchase_id and head.supplier_id = supplier.supplier_id"
                + " and head.supplier_id = '"+GetValue("supplier_id")+"'";
            var result = SelectDB(qrySelect);
            result = result.split('~');
            var counter = 1;
            for (var i=0; i < result.length; i++){
                var value = result[i].split('^');
                counter = counter + i;
                $('#displayList_2').append(
                    ' <tr id="trPurchase_2_'+counter+'"> '
                        + '<td style="padding:1px"><input  type="text" name="dynfields_2" value="'+value[0]+'" class="tags" id="purchase_id_2_'+counter+'" style="width:80px;" onfocus="GetFldID_2('+counter+')" onblur="LF_product_id_2('+counter+')"></td>'
                        + '<td style="padding:1px"><input  type="text" name="dynfields_2" value="'+value[1]+'" class="tags" id="product_id_2_'+counter+'" style="width:60px;" onblur="LF_product_id_2('+counter+')"></td>'
                        + '<td style="padding:1px"><input type="text" name="dynfields_2" value="" id="description_2_'+counter+'" style="width:170px;"></td>'
                        + '<td style="padding:1px"><select name="dynfields_2" id="location_2_'+counter+'" style="width:100px;"></select></td>'
                        + '<td style="padding:1px"><input type="text" name="dynfields_2" value="" id="quantity_2_'+counter+'" style="width:80px;" onblur="getTotal_2('+counter+')"></td>'
                        + '<td style="padding:1px"><select name="dynfields_2" id="gl_code_2_'+counter+'" style="width:150px;"></select></td>'
                        + '<td style="padding:1px"><input type="text" name="dynfields_2" value="" id="cost_price_2_'+counter+'" style="width:80px;" onblur="getTotal_2('+counter+')"></td>'
                        + '<td style="padding:1px"><input type="text" name="dynfields_2" value="" id="total_price_2_'+counter+'" style="width:60px;" onkeypress="validate(event)" disabled>'
                        + '<div style="float:right; margin-right:-2px; margin-top:0px"><a oncontextmenu="return false;" href="#" class="action" id="RemoveEntry_2" onclick="RemoveEntryPurch_2('+counter+')" title="Remove Entry" tabindex="-1"><span class="typcn typcn-minus"></span></a></div></td>'
                    + '</tr>'
                );

                $( "#tabs" ).tabs( "disable", 0 );
                $( "#tabs" ).tabs( "option", "active", 1 );
                autocomplete();
                GetFldID_2(counter);
                LF_product_id_2(counter);

                var qrySQL1 = "SELECT was_id, location FROM was_cs_product_location order by location";
                var result1 = SelectDB(qrySQL1);
                var field = "#location_2_"+counter;
                $(field).empty();
                if(result1 !== ""){
                    result1 = result1.split('~');
                    $(field).append($("<option></option>").val("").html(""));
                    for (var x=0; x < result1.length; x++){
                        var value1 = result1[x].split('^');
                        $(field).append($("<option></option>").val(value1[0]).html(value1[1]));
                    }
                }

                var qrySelect = "SELECT was_id, account_type FROM was_chart_of_account order by account_type";
                var result1 = SelectDB(qrySelect);
                var gl_code = "#gl_code_2_"+counter;
                $(gl_code).empty();
                if(result1 !== ""){
                    result1 = result1.split('~');
                    $(gl_code).append($("<option></option>").val("").html(""));
                    for (var x=0;  x < result1.length; x++){
                        var value1 = result1[x].split('^');
                        $(gl_code).append($("<option></option>").val(value1[0]).html(value1[1]));
                    }
                }
            }
            SetValue('strCounter_2', counter);
            SetFocus("purchase_id_2_1");
        }
    }
    HideLoading();
}

function tab1(){
    if(GetValueInner("TotalAmount") === "0.00"){
        $('#tdentry').empty();
        $('#tdentry').append('<td width="60%" style="border:none; " id="entry"><input type="button" name="hd_addEntry" id="hd_addEntry" onclick="AddEntryRec()" value="Add Entry" style="width:100px;" onclick=""></td>');
         SetValue("strCounter", 1);

         $('#displayList').empty();
         $('#displayList').append(
            ' <tr id="trPurchase_1"> '
                + '<td style="padding:1px"><input  type="text" name="dynfields" value="" class="tags" id="purchase_id_1" style="width:80px;" onfocus="GetFldID(1)" onblur="LF_product_id(1)"></td>'
                + '<td style="padding:1px"><input  type="text" name="dynfields" value="" class="tags" id="product_id_1" style="width:60px;" onblur="LF_product_id(1)"></td>'
                + '<td style="padding:1px"><input type="text" name="dynfields" value="" id="description_1" style="width:170px;"></td>'
                + '<td style="padding:1px"><select name="dynfields" id="location_1" style="width:100px;"></select></td>'
                + '<td style="padding:1px"><input type="text" name="dynfields" value="" id="quantity_1" style="width:80px;" onblur="getTotal(1)"></td>'
                + '<td style="padding:1px"><select name="dynfields" id="gl_code_1" style="width:150px;"></select></td>'
                + '<td style="padding:1px"><input type="text" name="dynfields" value="" id="cost_price_1" style="width:80px;" onblur="getTotal(1)" disabled></td>'
                + '<td style="padding:1px"><input type="text" name="dynfields" value="" id="total_price_1" style="width:60px;" onkeypress="validate(event)" disabled>'
                + '<div style="float:right; margin-right:-2px; margin-top:0px"><a oncontextmenu="return false;" href="#" class="action" id="RemoveEntry" onclick="RemoveEntryPurch(1)" title="Remove Entry" tabindex="-1"><span class="typcn typcn-minus"></span></a></div></td>'
             + '</tr>'
         );

         var qrySQL = "SELECT was_id, location FROM was_cs_product_location order by location";
         var result = SelectDB(qrySQL);
         var field = "#location_1";
         $(field).empty();
         if(result !== ""){
         result = result.split('~');
         $(field).append($("<option></option>").val("").html(""));
         for (var i=0; i < result.length; i++){
             var value = result[i].split('^');
             $(field).append($("<option></option>").val(value[0]).html(value[1]));
             }
         }
         
        var qrySelect = "SELECT was_id, account_type FROM was_chart_of_account order by account_type";
        var result = SelectDB(qrySelect);
        var gl_code = "#gl_code_1";
        $(gl_code).empty();
        if(result !== ""){
            var result1 = result.split('~');
            $(gl_code).append($("<option></option>").val("").html(""));
            for (var i=0; i < result1.length; i++){
                var value = result1[i].split('^');
                $(gl_code).append($("<option></option>").val(value[0]).html(value[1]));
            }
        }
         SetValueInner("TotalAmount","0.00");
    }
}

//tab2
function tab2(){
    if(GetValueInner("TotalAmount_2") === "0.00"){
        $('#tdentry_2').empty();
        //$('#tdentry_2').append('<td width="60%" style="border:none; " id="entry"><input type="button" name="hd_addEntry" id="hd_addEntry" onclick="AddEntryRec_2()" value="Add Entry" style="width:100px;" onclick=""></td>');
        SetValue("strCounter_2", 1);
        $('#displayList_2').empty();
        $('#displayList_2').append(
           ' <tr id="trPurchase_2_1"> '
                + '<td style="padding:1px"><input  type="text" name="dynfields_2" value="" class="tags" id="purchase_id_2_1" style="width:80px;" onfocus="GetFldID_2(1)" onblur="LF_product_id_2(1)"></td>'
                + '<td style="padding:1px"><input  type="text" name="dynfields_2" value="" class="tags" id="product_id_2_1" style="width:60px;" onblur="LF_product_id_2(1)"></td>'
                + '<td style="padding:1px"><input type="text" name="dynfields_2" value="" id="description_2_1" style="width:170px;"></td>'
                + '<td style="padding:1px"><select name="dynfields_2" id="location_2_1" style="width:100px;"></select></td>'
                + '<td style="padding:1px"><input type="text" name="dynfields_2" value="" id="quantity_2_1" style="width:80px;" onblur="getTotal_2(1)"></td>'
                + '<td style="padding:1px"><select name="dynfields_2" id="gl_code_2_1" style="width:150px;"></select></td>'
                + '<td style="padding:1px"><input type="text" name="dynfields_2" value="" id="cost_price_2_1" style="width:80px;" onblur="getTotal_2(1)"></td>'
                + '<td style="padding:1px"><input type="text" name="dynfields_2" value="" id="total_price_2_1" style="width:60px;" onkeypress="validate(event)" disabled>'
                + '<div style="float:right; margin-right:-2px; margin-top:0px"><a oncontextmenu="return false;" href="#" class="action" id="RemoveEntry_2" onclick="RemoveEntryPurch_2(1)" title="Remove Entry" tabindex="-1"><span class="typcn typcn-minus"></span></a></div></td>'
            + '</tr>'
        );

        var qrySQL = "SELECT was_id, location FROM was_cs_product_location order by location";
        var result = SelectDB(qrySQL);
        var field = "#location_2_1";
        $(field).empty();
        if(result !== ""){
        result = result.split('~');
        $(field).append($("<option></option>").val("").html(""));
        for (var i=0; i < result.length; i++){
            var value = result[i].split('^');
            $(field).append($("<option></option>").val(value[0]).html(value[1]));
            }
        }
        SetValueInner("TotalAmount_2","0.00");
        
        var qrySelect = "SELECT was_id, account_type FROM was_chart_of_account order by account_type";
        var result = SelectDB(qrySelect);
        var gl_code = "#gl_code_2_1";
        $(gl_code).empty();
        if(result !== ""){
            var result1 = result.split('~');
            $(gl_code).append($("<option></option>").val("").html(""));
            for (var i=0; i < result1.length; i++){
                var value = result1[i].split('^');
                $(gl_code).append($("<option></option>").val(value[0]).html(value[1]));
            }
        }
    }
}

function AddEntryRec_2(){
    var counter = parseInt(GetValue('strCounter_2')) + 1;
    $('#displayList_2').append(
       ' <tr id="trPurchase_2_'+counter+'"> '
            + '<td style="padding:1px"><input  type="text" name="dynfields_2" value="" class="tags" id="purchase_id_2_'+counter+'" style="width:80px;" onfocus="GetFldID_2('+counter+')" onblur="LF_product_id_2('+counter+')"></td>'
            + '<td style="padding:1px"><input  type="text" name="dynfields_2" value="" class="tags" id="product_id_2_'+counter+'" style="width:60px;" onblur="LF_product_id_2('+counter+')"></td>'
            + '<td style="padding:1px"><input type="text" name="dynfields_2" value="" id="description_2_'+counter+'" style="width:170px;"></td>'
            + '<td style="padding:1px"><select name="dynfields_2" id="location_2_'+counter+'" style="width:100px;"></select></td>'
            + '<td style="padding:1px"><input type="text" name="dynfields_2" value="" id="quantity_2_'+counter+'" style="width:80px;" onblur="getTotal_2('+counter+')"></td>'
            + '<td style="padding:1px"><select name="dynfields_2" id="gl_code_2_'+counter+'" style="width:150px;"></select></td>'
            + '<td style="padding:1px"><input type="text" name="dynfields_2" value="" id="cost_price_2_'+counter+'" style="width:80px;" onblur="getTotal_2('+counter+')"></td>'
            + '<td style="padding:1px"><input type="text" name="dynfields_2" value="" id="total_price_2_1" style="width:60px;" onkeypress="validate(event)" disabled>'
            + '<div style="float:right; margin-right:-2px; margin-top:0px"><a oncontextmenu="return false;" href="#" class="action" id="RemoveEntry_2" onclick="RemoveEntryPurch_2('+counter+')" title="Remove Entry" tabindex="-1"><span class="typcn typcn-minus"></span></a></div></td>'
        + '</tr>'
    );
    SetValue('strCounter_2', counter);
    SetFocus("purchase_id_2_"+counter);
    autocomplete();
    var qrySQL = "SELECT was_id, location FROM was_cs_product_location order by location";
    var result = SelectDB(qrySQL);
    var field = "#location_2_"+counter;
    $(field).empty();
    if(result !== ""){
    result = result.split('~');
    $(field).append($("<option></option>").val("").html(""));
    for (var i=0; i < result.length; i++){
        var value = result[i].split('^');
        $(field).append($("<option></option>").val(value[0]).html(value[1]));
        }
    }
    
    var qrySelect = "SELECT was_id, account_type FROM was_chart_of_account order by account_type";
    var result = SelectDB(qrySelect);
    var gl_code = "#gl_code_2_"+counter;
    $(gl_code).empty();
    if(result !== ""){
        var result1 = result.split('~');
        $(gl_code).append($("<option></option>").val("").html(""));
        for (var i=0; i < result1.length; i++){
            var value = result1[i].split('^');
            $(gl_code).append($("<option></option>").val(value[0]).html(value[1]));
        }
    }
    
    autocomplete_2();
}

function LF_product_id_2(counter){
    var value = GetValue("product_id_2_"+counter);
    if(value !== ""){
        var qrySQL = "select quantity-partial as count, cost_price, description from was_product_purchase where product_id = '"+value+"' and purchase_id = '"+GetValue("purchase_id_2_"+counter)+"'";
        var result = SelectDB(qrySQL);
        var value = result.split("^");
        SetValue("quantity_2_"+counter,value[0]);
        SetValue("cost_price_2_"+counter,value[1]);
        SetValue("description_2_"+counter,value[2]);
        var total = value[0]*value[1];
        SetValue("total_price_2_"+counter,total.toFixed(2));
        getTotalAmount_2();
    }
}

function getTotalAmount_2(){
    var totalAmount = 0;
    var strCounter = GetValue('strCounter_2');
    for(var x = 1; x <= strCounter; x++){
        var strTotalPrice = 'total_price_2_'+x;
        var strQuantity = 'quantity_2_'+x;
	if (document.getElementById(strTotalPrice) != null){
            if(GetValue(strQuantity) !== ""){
                totalAmount = parseInt(totalAmount) + parseInt(GetValue(strTotalPrice));
            }
	}			
    }
    SetValueInner("TotalAmount_2","");
    SetValueInner("TotalAmount_2",totalAmount.toFixed(2));
    if(totalAmount.toFixed(2) === "0.00"){
        $( "#tabs" ).tabs( "enable", 0 );
    } else {
        $( "#tabs" ).tabs( "disable", 0 );
    }
}

function RemoveEntryPurch_2(counter){
    var d = document.getElementById('displayList_2');
    var olddiv = document.getElementById('trPurchase_2_'+counter);
    d.removeChild(olddiv);
    getTotalAmount_2();
}

function getTotal_2(counter){
    var strQuantity = GetValue("quantity_2_"+counter);
    var strCostPrice = GetValue("cost_price_2_"+counter);
    if(strCostPrice !== "" && strQuantity !== ""){
        var total = parseInt(strQuantity) * parseInt(strCostPrice);
	SetValue("total_price_2_"+counter,total.toFixed(2));
    }
    getTotalAmount_2();
}

function GetFldID_2(count){
    SetValue("strCompleteCount_2",count);
    autocomplete_2();
}

function autocomplete_2(){
    var qrySQL = "select distinct purchase_id, product_id, description from was_product_purchase where purchase_status in ('102','103') and quantity-partial > 0";
    var result = SelectDB(qrySQL);
    var tags = "";
    if(result !== ""){
        result = result.split('~');
        tags = "[\n";
        for (var i=0; i < result.length; i++){
            var value = result[i].split('^');
            tags = tags + '{ "value": "'+value[0]+'", "label": "'+ value[0] +'    '+ value[1] +'    '+ value[2] +'"},\n';
        }
        tags = tags.slice(',',-2);
        tags = tags + "\n]";
    }
    
    var count = GetValue("strCompleteCount_2");
    var yerler = eval(tags);
    $(".tags").autocomplete({
        source: yerler,
        focus: function (event, ui) {
            event.preventDefault();
            
            SetValue("purchase_id_2_"+count,ui.item.value);
        },
        select: function (event, ui) {
            event.preventDefault();
            SetValue("purchase_id_2_"+count,ui.item.value);
            var value = ui.item.label.split("    ");
            SetValue("product_id_2_"+count,value[1]);
            SetValue("description_2_"+count,value[2]);
            
        }
    });
}

//tab3
function tab3(){
    if(GetValueInner("TotalAmount_3") === "0.00"){
        SetValue("strCounter_3", 1);
        $('#tdentry_3').empty();
        $('#tdentry_3').append('<td width="60%" style="border:none; " id="entry"><input type="button" name="hd_addEntry" id="hd_addEntry" onclick="AddEntryRec_3()" value="Add Entry" style="width:100px;" onclick=""></td>');
        SetValue("strCounter", 1);
        $('#displayList_3').empty();
        $('#displayList_3').append(
           ' <tr id="trPurchase_3_1"> '
                + '<td style="padding:1px"><input  type="text" name="dynfields_3" value="" class="tags" id="purchase_id_3_1" style="width:80px;" onfocus="GetFldID_3(1)" onblur="LF_product_id_3(1)"></td>'
                + '<td style="padding:1px"><input  type="text" name="dynfields_3" value="" class="tags" id="product_id_3_1" style="width:60px;" onblur="LF_product_id_3(1)"></td>'
                + '<td style="padding:1px"><input type="text" name="dynfields_3" value="" id="description_3_1" style="width:170px;"></td>'
                + '<td style="padding:1px"><select name="dynfields_3" id="location_3_1" style="width:100px;"></select></td>'
                + '<td style="padding:1px"><input type="text" name="dynfields_3" value="" id="quantity_3_1" style="width:80px;" onblur="getTotal_3(1)"></td>'
                + '<td style="padding:1px"><select name="dynfields_3" id="gl_code_3_1" style="width:150px;"></select></td>'
                + '<td style="padding:1px"><input type="text" name="dynfields_3" value="" id="cost_price_3_1" style="width:80px;" onblur="getTotal_3(1)"></td>'
                + '<td style="padding:1px"><input type="text" name="dynfields_3" value="" id="total_price_3_1" style="width:60px;" onkeypress="validate(event)" disabled>'
                + '<div style="float:right; margin-right:-2px; margin-top:0px"><a oncontextmenu="return false;" href="#" class="action" id="RemoveEntry_3" onclick="RemoveEntryPurch_3(1)" title="Remove Entry" tabindex="-1"><span class="typcn typcn-minus"></span></a></div></td>'
            + '</tr>'
        );
        
        var qrySQL = "SELECT was_id, location FROM was_cs_product_location order by location";
        var result = SelectDB(qrySQL);
        var field = "#location_3_1";
        $(field).empty();
        if(result !== ""){
        result = result.split('~');
        $(field).append($("<option></option>").val("").html(""));
        for (var i=0; i < result.length; i++){
            var value = result[i].split('^');
            $(field).append($("<option></option>").val(value[0]).html(value[1]));
            }
        }
        
        var qrySelect = "SELECT was_id, account_type FROM was_chart_of_account order by account_type";
        var result = SelectDB(qrySelect);
        var gl_code = "#gl_code_3_1";
        $(gl_code).empty();
        if(result !== ""){
            var result1 = result.split('~');
            $(gl_code).append($("<option></option>").val("").html(""));
            for (var i=0; i < result1.length; i++){
                var value = result1[i].split('^');
                $(gl_code).append($("<option></option>").val(value[0]).html(value[1]));
            }
        }
        SetValueInner("TotalAmount_3","0.00");
    }
    autocomplete_3();
}

function AddEntryRec_3(){
    var counter = parseInt(GetValue('strCounter_3')) + 1;
    $('#displayList_3').append(
       ' <tr id="trPurchase_3_'+counter+'"> '
            + '<td style="padding:1px"><input  type="text" name="dynfields_3" value="" class="tags" id="purchase_id_3_'+counter+'" style="width:80px;" onfocus="GetFldID_3('+counter+')" onblur="LF_product_id_3('+counter+')"></td>'
                + '<td style="padding:1px"><input  type="text" name="dynfields_3" value="" class="tags" id="product_id_3_'+counter+'" style="width:60px;" onblur="LF_product_id_3('+counter+')"></td>'
                + '<td style="padding:1px"><input type="text" name="dynfields_3" value="" id="description_3_'+counter+'" style="width:170px;"></td>'
                + '<td style="padding:1px"><select name="dynfields_3" id="location_3_'+counter+'" style="width:100px;"></select></td>'
                + '<td style="padding:1px"><input type="text" name="dynfields_3" value="" id="quantity_3_'+counter+'" style="width:80px;" onblur="getTotal_3('+counter+')"></td>'
                + '<td style="padding:1px"><select name="dynfields_3" id="gl_code_3_'+counter+'" style="width:150px;"></select></td>'
                + '<td style="padding:1px"><input type="text" name="dynfields_3" value="" id="cost_price_3_'+counter+'" style="width:80px;" onblur="getTotal_3('+counter+')"></td>'
                + '<td style="padding:1px"><input type="text" name="dynfields_3" value="" id="total_price_3_'+counter+'" style="width:60px;" onkeypress="validate(event)" disabled>'
            + '<div style="float:right; margin-right:-2px; margin-top:0px"><a oncontextmenu="return false;" href="#" class="action" id="RemoveEntry_3" onclick="RemoveEntryPurch_3('+counter+')" title="Remove Entry" tabindex="-1"><span class="typcn typcn-minus"></span></a></div></td>'
        + '</tr>'
    );
    SetValue('strCounter_3', counter);
    SetFocus("purchase_id_3_"+counter);
    autocomplete();
    var qrySQL = "SELECT was_id, location FROM was_cs_product_location order by location";
    var result = SelectDB(qrySQL);
    var field = "#location_3_"+counter;
    $(field).empty();
    if(result !== ""){
    result = result.split('~');
    $(field).append($("<option></option>").val("").html(""));
    for (var i=0; i < result.length; i++){
        var value = result[i].split('^');
        $(field).append($("<option></option>").val(value[0]).html(value[1]));
        }
    }
    
    var qrySelect = "SELECT was_id, account_type FROM was_chart_of_account order by account_type";
    var result = SelectDB(qrySelect);
    var gl_code = "#gl_code_3_"+counter;
    $(gl_code).empty();
    if(result !== ""){
        var result1 = result.split('~');
        $(gl_code).append($("<option></option>").val("").html(""));
        for (var i=0; i < result1.length; i++){
            var value = result1[i].split('^');
            $(gl_code).append($("<option></option>").val(value[0]).html(value[1]));
        }
    }
    autocomplete_3();
}

function LF_product_id_3(counter){
    var value = GetValue("product_id_3_"+counter);
    if(value !== ""){
        var qrySQL = "select quantity-partial as count, cost_price, total_price from was_product_purchase where product_id = '"+value+"' and purchase_id = '"+GetValue("purchase_id_3_"+counter)+"'";
        var result = SelectDB(qrySQL);
        var value = result.split("^");
        SetValue("quantity_3_"+counter,value[0]);
        SetValue("cost_price_3_"+counter,value[1]);
        var total = value[0]*value[1];
        SetValue("total_price_3_"+counter,total.toFixed(2));
        getTotalAmount_3();
    }
}

function getTotalAmount_3(){
    var totalAmount = 0;
    var strCounter = GetValue('strCounter_3');
    for(var x = 1; x <= strCounter; x++){
        var strTotalPrice = 'total_price_3_'+x;
        var strQuantity = 'quantity_3_'+x;
	if (document.getElementById(strTotalPrice) != null){
            if(GetValue(strQuantity) !== ""){
                totalAmount = parseInt(totalAmount) + parseInt(GetValue(strTotalPrice));
            }
	}			
    }
    SetValueInner("TotalAmount_3","");
    SetValueInner("TotalAmount_3",totalAmount.toFixed(2));
}

function RemoveEntryPurch_3(counter){
    var d = document.getElementById('displayList_3');
    var olddiv = document.getElementById('trPurchase_3_'+counter);
    d.removeChild(olddiv);
    getTotalAmount_3();
}

function getTotal_3(counter){
    var strQuantity = GetValue("quantity_3_"+counter);
    var strCostPrice = GetValue("cost_price_3_"+counter);
    if(strCostPrice !== "" && strQuantity !== ""){
        var total = parseInt(strQuantity) * parseInt(strCostPrice);
	SetValue("total_price_3_"+counter,total.toFixed(2));
    }
    getTotalAmount_3();
}

function GetFldID_3(count){
    SetValue("strCompleteCount_3",count);
    autocomplete_3();
}

function autocomplete_3(){
    var qrySQL = "select distinct purchase_id, product_id, description from was_product_purchase where purchase_status in ('102','103') and quantity-partial > 0";
    var result = SelectDB(qrySQL);
    var tags = "";
    if(result !== ""){
        result = result.split('~');
        tags = "[\n";
        for (var i=0; i < result.length; i++){
            var value = result[i].split('^');
            tags = tags + '{ "value": "'+value[0]+'", "label": "'+ value[0] +'    '+ value[1] +'    '+ value[2] +'"},\n';
        }
        tags = tags.slice(',',-2);
        tags = tags + "\n]";
    }
    
    var count = GetValue("strCompleteCount_3");
    var yerler = eval(tags);
    $(".tags").autocomplete({
        source: yerler,
        minLength: 0,
        minChars: 0,
        focus: function (event, ui) {
            event.preventDefault();
            SetValue("purchase_id_3_"+count,ui.item.value);
        },
        select: function (event, ui) {
            event.preventDefault();
            SetValue("purchase_id_3_"+count,ui.item.value);
            var value = ui.item.label.split("    ");
            SetValue("product_id_3_"+count,value[1]);
            SetValue("description_3_"+count,value[2]);
            
        }
    }).on('focus', function(event) {
        var self = this;
        $(self).autocomplete( "search", "");;
    });;
}
</script>