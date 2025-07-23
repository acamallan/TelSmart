<script>
/*Required functions. onPageLoad, onAddNewUpdate, onAmendUpdate, onAddNew, onAmend, OnDelete, onCancelAddNew, onCancelAmend*/
function  onPageLoad(){
    var strSQL = "select invoice_number,due_date,due_amount,description,discount,amount,record_date from was_product_payment where payment_id='"+GetValue("payment_id")+"'";
    var strReturn = SelectDB(strSQL);
    SetValue("strCounter",0);
    $('#displayList').empty();
    if(strReturn !== ""){
        var record = strReturn.split('~');
        $("#displayList").find("tr:gt(0)").remove();
        for(var x = 1; x <= record.length; x++){
            var data = record[x-1].split('^');
            var counter = parseInt(document.getElementById('strCounter').value) + 1;
            $('#displayList').append(
                    ' <tr id="trPurchase['+counter+']"> '
                        + '<td style="padding:1px"><input type="text" name="dynfields" value="'+data[0]+'" id="product_id_'+counter+'" style="width:80px;" onblur="LF_product_id('+counter+')" onfocus="GetFldID(this.id)" disabled></td>'
                        + '<td style="padding:1px"><input type="text" name="dynfields" value="'+data[1]+'" id="due_date_'+counter+'" style="width:80px;" disabled></td>'
                        + '<td style="padding:1px"><input type="text" name="dynfields" value="'+data[2]+'" id="due_amount_'+counter+'" style="width:80px; text-align:right;"disabled></td>'
                        + '<td style="padding:1px"><input type="text" name="dynfields" value="'+data[3]+'" id="description_'+counter+'" style="width:350px;" disabled></td>'
                        + '<td style="padding:1px"><input type="text" name="dynfields" value="'+data[4]+'" id="discount_'+counter+'" style="width:75px;" onkeypress="validate(event)" onblur="LF_discount('+counter+');" disabled></td>'
                        + '<td style="padding:1px"><input type="text" name="dynfields" value="'+data[5]+'" id="amount_'+counter+'" style="width:90px;" onkeypress="validate(event)" onblur="getTotalAmount()" disabled></td>'
                        + '</td>'
                    + '</tr>'
                );
            SetValue("strCounter",counter); 
        } 
    }
    
    DisplayMode("hd_name","DI");
    DisplayMode("hd_username","DI");
    SetValue("hd_name","");
    SetValue("hd_username","");
    var qrySelect = "select first_name, last_name from was_customer_info where customer_id ='"+GetValue("customer_id")+"'";
    var result = SelectDB(qrySelect);
    if(result !== ""){
        result = result.split("^");
        SetValue("hd_name", result[0] +" "+ result[1]);
    }
    
    var qrySelect = "select username from was_user_info where userid ='"+GetValue("userid")+"'";
    var result = SelectDB(qrySelect);
    SetValue("hd_username", result);
    getTotalAmount();
    DisplayMode("hd_btnJournal","EN");
    document.getElementById("hd_btnJournal").onclick = function() { window.open(baseURL()+"common/journalEntry.jsp?sales_id="+encrypt(GetValue("sales_id")), "_blank", "resizable=yes, scrollbars=yes, titlebar=no, width=600, height=500, top=30, left=400,menubar=no, toolbar=no, location=no, scrollbars=no"); };
    DisplayMode("hd_btnPrint","EN");
    document.getElementById("hd_btnPrint").onclick = function() { window.open(baseURL()+"common/sales_order.jsp?sales_id="+encrypt(GetValue("sales_id")), "_blank", "height=" + screen.height + ",width=" + screen.width + ",scrollbars=yes, titlebar=no"); };
}   

function loadComboSelect(){
    populateSalesID();
}

/* onAddNewUpdate */
function onAddNewUpdate(){
    if(GetValue("payment_id") === ""){
        SetValue("payment_id", GetCounter("001","10"));
    }
    
    var vrows = document.getElementsByName("dynfields");
    var a = 0;
    var update = true;
    for (var x = 0; x < vrows.length/6; x++) {
        var product_id = vrows[a].getAttribute( 'id' );
        var amount = vrows[a+5].getAttribute( 'id' );
        if(GetValue(amount) === ""){
            update = false;
        }
        
        var a = a+6;
    }
    if(update == false){
        alert('Please complete all Amount Paid fields.')
        Success(false);
        return;
    }
    
    var i = 0;
    for (var x = 0; x < vrows.length/6; x++) {
        var invoice_number = vrows[i].getAttribute( 'id' );
        var due_date = vrows[i+1].getAttribute( 'id' );
        var due_amount = vrows[i+2].getAttribute( 'id' );
        var description = vrows[i+3].getAttribute( 'id' );
        var discount = vrows[i+4].getAttribute( 'id' );
        var amount = vrows[i+5].getAttribute( 'id' );
        var strInsert = "insert into was_product_payment (payment_id,invoice_number,due_date,due_amount,description,discount,amount,record_date)"+
                            " values('"+GetValue("payment_id")+"','"+GetValue(invoice_number)+"','"+GetValue(due_date)+"','"+GetValue(due_amount)+"','"+GetValue(description)+"','"+GetValue(discount)+"','"+parseInt(GetValue(amount)).toFixed(2)+"','"+GetValue("record_date")+"')";
        InsertDB(strInsert);
        var i = i+6;
        if(GetValue(amount) === GetValue(due_amount)){
            var qryUpdate = "update was_product_sales_invoice_header set payment_status = '101', actual_amount='0.00' where invoice_number = '"+GetValue(invoice_number)+"'";
            UpdateDB(qryUpdate);
        } else {
            if(GetValue(discount) !== ""){
                var percent = parseInt(GetValue(discount))/100;
                var discounted = parseInt(GetValue(due_amount)) - (parseInt(GetValue(due_amount)) * percent);
                if(parseFloat(discounted) === parseFloat(GetValue(amount))){
                    var qryUpdate = "update was_product_sales_invoice_header set payment_status = '101', actual_amount='0.00'  where invoice_number = '"+GetValue(invoice_number)+"'";
                    UpdateDB(qryUpdate); 
                } else {
                    var actual_amount = parseFloat(GetValue(due_amount)) - parseFloat(discounted);
                    var qryUpdate = "update was_product_sales_invoice_header set payment_status = '104', actual_amount='"+actual_amount.toFixed(2)+"' where invoice_number = '"+GetValue(invoice_number)+"'";
                    UpdateDB(qryUpdate);
                }
            } else {
                var actual_amount = parseFloat(GetValue(due_amount)) - parseFloat(GetValue(amount));
               var qryUpdate = "update was_product_sales_invoice_header set payment_status = '104', actual_amount='"+actual_amount.toFixed(2)+"' where invoice_number = '"+GetValue(invoice_number)+"'";
                UpdateDB(qryUpdate); 
            }
        }
    }
    $( "#customer_id" ).autocomplete( "disable" );
}

/* onAmendUpdate */
function onAmendUpdate(){
    var vrows = document.getElementsByName("dynfields");
    var a = 0;
    var update = true;
    for (var x = 0; x < vrows.length/5; x++) {
        var product_id = vrows[a].getAttribute( 'id' );
        var quantity = vrows[a+2].getAttribute( 'id' );
        if(GetValue(product_id) === "" || GetValue(quantity) === ""){
            update = false;
        }
        
        var a = a+5;
    }
    if(update == false){
        alert('Please complete all Product Purchase fields.')
        Success(false);
        return;
    }
    
    var strDelete = "delete from was_product_sales_invoice where sales_id = '"+GetValue("sales_id")+"'";
    DeleteDB(strDelete);
    
    var i = 0;
    for (var x = 0; x < vrows.length/5; x++) {
        var product_id = vrows[i].getAttribute( 'id' );
        var description = vrows[i+1].getAttribute( 'id' );
        var quantity = vrows[i+2].getAttribute( 'id' );
        var price = vrows[i+3].getAttribute( 'id' );
        var total_amount = vrows[i+4].getAttribute( 'id' );
        var strInsert = "insert into was_product_sales_invoice (sales_id,product_id,description,quantity,price,total_amount,record_date)"+
                            " values('"+GetValue("sales_id")+"','"+GetValue(product_id)+"','"+GetValue(description)+"','"+GetValue(quantity)+"','"+GetValue(price)+"','"+removeCommas(GetValue(total_amount))+"','"+GetValue("record_date")+"')";
        InsertDB(strInsert);
        var i = i+5;
        DisplayMode(product_id, "DI");
        DisplayMode(description, "DI");
        DisplayMode(quantity, "DI");
        DisplayMode(price, "DI");
        $('#RemoveEntry').empty();
    }
    $('#tdentry').empty();
    $( "#customer_id" ).autocomplete( "disable" );
    
}

function onAddNewUpdateError(){
    $( "#customer_id" ).autocomplete( "enable" );
}

function onAmendUpdateError(){
    $( "#customer_id" ).autocomplete( "enable" );
}

/* onAddNew */
function onAddNew(){
    SetValue("record_date",getServerSession("record_date"));
    SetValue("userid", getServerSession("userid"));
    SetValueInner("TotalAmount","0.00");
    DisplayMode("hd_name","DI");
    DisplayMode("hd_username","DI");
    SetValue("hd_name","");
    SetValue("hd_username", getServerSession("username"));
    autocompleteCustomer();
    DisplayMode("hd_btnJournal","DI");
    DisplayMode("hd_btnPrint","DI");
    $("#displayList").empty();
}

/* onAmend */
function onAmend(){
    var strSQL = "select product_id, description, quantity,price, total_amount from was_product_sales_invoice where sales_id='"+GetValue("sales_id")+"'";
    var strReturn = SelectDB(strSQL);
    SetValue("strCounter",0);
    if(strReturn !== ""){
        var record = strReturn.split('~');
        $("#displayList").empty();
        for(x = 1; x <= record.length; x++){
            var data = record[x-1].split('^');
            var counter = parseInt(GetValue('strCounter')) + 1;       
            $('#displayList').append(
                ' <tr id="trPurchase['+counter+']"> '
                    + '<td style="padding:1px"><input type="text" class="tags" name="dynfields" value="'+data[0]+'" id="product_id_'+counter+'" style="width:80px;" onblur="LF_product_id('+counter+')" onfocus="GetFldID(this.id)"></td>'
                    + '<td style="padding:1px"><input type="text" name="dynfields" value="'+data[1]+'" id="description_'+counter+'" style="width:450px;"></td>'
                    + '<td style="padding:1px"><input type="text" name="dynfields" value="'+data[2]+'" id="quantity_'+counter+'" style="width:80px;" onblur="getTotal('+counter+')" onkeypress="validate(event)"></td>'
                    + '<td style="padding:1px"><input type="text" name="dynfields" value="'+data[3]+'" id="price_'+counter+'" style="width:80px;" onblur="getTotal('+counter+')" onkeypress="validate(event)" disabled></td>'
                    + '<td style="padding:1px"><input type="text" name="dynfields" value="'+data[4]+'" id="total_amount_'+counter+'" style="width:60px;" disabled>'
                    + '<div style="float:right; margin-right:-2px; margin-top:5px"><a href="#" class="action" id="RemoveEntry" onclick="RemoveEntry('+counter+')" title="Remove Entry" tabindex="-1"><span class="typcn typcn-minus"></span></a></div></td>'
                    + '</td>'
                + '</tr>'
            );
            SetValue("strCounter",counter);
        }
        getTotalAmount();
    }
    $('#tdentry').append('<input type="button" name="hd_addEntry" id="hd_addEntry" onclick="AddEntry()" value="Add Entry" style="width:100px;" onclick="">');
    autocomplete();
    DisplayMode("hd_btnJournal","DI");
    DisplayMode("hd_btnPrint","DI");
    autocompleteCustomer();
}

/* OnDelete */
function OnDelete(){
    var strDelete = "delete from was_product_payment where payment_id = '"+GetValue("payment_id")+"'";
    DeleteDB(strDelete);
}

/* onCancelAddNew */
function onCancelAddNew(){
    $('#tdentry').empty();
    populateSalesID();
    SetValue("hd_username","");
}

/* onCancelAmend */
function onCancelAmend(){
    $('#tdentry').empty();
    populateSalesID();
}

function populateSalesID(){
    var qrySQL = "select sales_id from was_product_sales_invoice_header";
    var result = SelectDB(qrySQL);
    $("#sales_id").empty();
    if(result !== ""){
        result = result.split('~');
        for (var i=0; i < result.length; i++){
            $("#sales_id").append($("<option></option>").val(result[i]).html(result[i]));
        }
    }
}

function getTotalAmount(){
    var totalAmount = 0;
    var strCounter = GetValue('strCounter');
    for(var x = 1; x <= strCounter; x++){
        var strTotalAmount = 'amount_'+x;
	if (document.getElementById(strTotalAmount) != null){
            totalAmount = parseFloat(totalAmount) + parseFloat(removeCommas(GetValue(strTotalAmount)));
	}			
    }
    if(totalAmount > 0){
        SetValueInner("TotalAmount",addCommas(totalAmount.toFixed(2)));
    } else {
        SetValueInner("TotalAmount","0.00");
    }
}

  
function autocompleteCustomer(){
    var qrySQL = "select distinct cust.customer_id, concat(first_name , ' ', last_name) as name from was_product_sales_invoice_header invoice, was_customer_info cust "
            + " where invoice.customer_id = cust.customer_id and invoice.payment_status in ('102','104') ";
    var result = SelectDB(qrySQL);
    if(result !== ""){
        result = result.split('~');
        var tags = "[\n";
        for (var i=0; i < result.length; i++){
            var value = result[i].split('^');
            tags = tags + '{ "value": "'+value[0]+'", "label": "'+ value[0] +'    '+ value[1] +'"},\n';
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
                SetValue("hd_name",name[1]);

            }
        }).on('focus', function(event) {
            var self = this;
            $(self).autocomplete( "search", "");;
        });
    }
}

function LF_customer_id(){
    ShowLoading();
    if(GetValue("customer_id") !== ""){
        var strSQL = "select invoice_number, due_date, actual_amount  from was_product_sales_invoice_header where customer_id ='"+GetValue("customer_id")+"' and payment_status in ('102', '104')";
        var strReturn = SelectDB(strSQL);
        SetValue("strCounter",0);
        if(strReturn !== ""){
            var record = strReturn.split('~');
            $("#displayList").empty();
            for(x = 1; x <= record.length; x++){
                var data = record[x-1].split('^');
                var counter = parseInt(GetValue('strCounter')) + 1;       
                $('#displayList').append(
                    ' <tr id="trPurchase['+counter+']"> '
                        + '<td style="padding:1px"><input type="text" name="dynfields" value="'+data[0]+'" id="product_id_'+counter+'" style="width:80px;" onblur="LF_product_id('+counter+')" onfocus="GetFldID(this.id)" disabled></td>'
                        + '<td style="padding:1px"><input type="text" name="dynfields" value="'+data[1]+'" id="due_date_'+counter+'" style="width:80px;" disabled></td>'
                        + '<td style="padding:1px"><input type="text" name="dynfields" value="'+data[2]+'" id="due_amount_'+counter+'" style="width:80px; text-align:right;"disabled></td>'
                        + '<td style="padding:1px"><input type="text" name="dynfields" value="" id="description_'+counter+'" style="width:350px;"></td>'
                        + '<td style="padding:1px"><input type="text" name="dynfields" value="" id="discount_'+counter+'" style="width:75px;" onkeypress="validate(event)" onblur="LF_discount('+counter+');"></td>'
                        + '<td style="padding:1px"><input type="text" name="dynfields" value="'+data[2]+'" id="amount_'+counter+'" style="width:90px;" onkeypress="validate(event)" onblur="LF_amount('+counter+'); getTotalAmount();"></td>'
                        + '</td>'
                    + '</tr>'
                );
                SetValue("strCounter",counter);
            }
            getTotalAmount();
        }
        SetFocus("description_1");
    }
    
    HideLoading();
}

function LF_discount(counter){
    var discount = GetValue("discount_"+counter);
    if(discount !== ""){
        var percent = parseInt(discount)/100;
        var discounted = parseInt(GetValue("due_amount_"+counter)) - (parseInt(GetValue("due_amount_"+counter)) * percent);
        SetValue("amount_"+counter, discounted.toFixed(2));
        getTotalAmount();
    } else {
        SetValue("amount_"+counter, GetValue("due_amount_"+counter));
        getTotalAmount();
    }
}

function LF_amount(counter){
    var amount = GetValue("amount_"+counter);
    SetValue("amount_"+counter,parseInt(amount).toFixed(2));
}

function GetChildValue(customer_id){
    autocompleteCustomer();
    SetValue("customer_id", customer_id);
    SetFocus("customer_id");
    LF_customer_id();
}
</script>