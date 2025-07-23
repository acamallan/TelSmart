<script>
/*Required functions. onPageLoad, onAddNewUpdate, onAmendUpdate, onAddNew, onAmend, OnDelete, onCancelAddNew, onCancelAmend*/
function  onPageLoad(){
    var strSQL = "select product_id, description, quantity, price, total_amount from was_product_sales_invoice where sales_id='"+GetValue("sales_id")+"'";
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
                ' <tr id="trPurchase_'+counter+'"> '
                    + '<td style="padding:1px"><input  type="text" name="dynfields" value="'+data[0]+'" id="product_id_'+counter+'" style="width:80px;" onblur="LF_product_id('+counter+')" disabled></td>'
                    + '<td style="padding:1px"><input type="text" name="dynfields" value="'+data[1]+'" id="description_'+counter+'" style="width:450px;" disabled></td>'
                    + '<td style="padding:1px"><input type="text" name="dynfields" value="'+data[2]+'" id="quantity_'+counter+'" style="width:80px;" disabled></td>'
                    + '<td style="padding:1px"><input type="text" name="dynfields" value="'+data[3]+'" id="price_'+counter+'" style="width:80px;" disabled></td>'
                    + '<td style="padding:1px"><input type="text" name="dynfields" value="'+addCommas(data[4])+'" id="total_amount_'+counter+'" style="width:80px; text-align:right;" onkeypress="validate(event)" disabled>'
                    + '<div style="float:right; margin-right:-2px; margin-top:-30px"><a oncontextmenu="return false;" href="#" class="action" id="RemoveEntry" onclick="RemoveEntryPurch('+counter+')" title="Remove Entry" tabindex="-1"></a></div></td>'
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
    var sales_id = GetValue("sales_id");
    
    SetValue("sales_id", sales_id);
    DisplayMode("hd_btnJournal","EN");
    document.getElementById("hd_btnJournal").onclick = function() { window.open(baseURL()+"common/journalEntry.jsp?sales_id="+encrypt(GetValue("sales_id")), "_blank", "resizable=yes, scrollbars=yes, titlebar=no, width=600, height=500, top=30, left=400,menubar=no, toolbar=no, location=no, scrollbars=no"); };
    DisplayMode("hd_btnPrint","EN");
    document.getElementById("hd_btnPrint").onclick = function() { window.open(baseURL()+"common/sales_order.jsp?sales_id="+encrypt(GetValue("sales_id")), "_blank", "height=" + screen.height + ",width=" + screen.width + ",scrollbars=yes, titlebar=no"); };
    $('#tdentry').empty();
}   

function preLoad(){
    var qrySQL = "select sales_id from was_product_sales_invoice_header";
    var result = SelectDB(qrySQL);
    $("#sales_id").empty();
    $("#sales_id").append($("<option></option>").val("").html(""));
    if(result !== ""){
        result = result.split('~');
        for (var i=0; i < result.length; i++){
            $("#sales_id").append($("<option></option>").val(result[i]).html(result[i]));
        }
    }
}

function loadComboSelect(){
    populateSalesID();
    populatePaymentStatus();
}

/* onAddNewUpdate */
function onAddNewUpdate(){
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
    
    var i = 0;
    for (var x = 0; x < vrows.length/5; x++) {
        var product_id = vrows[i].getAttribute( 'id' );
        var description = vrows[i+1].getAttribute( 'id' );
        var quantity = vrows[i+2].getAttribute( 'id' );
        var price = vrows[i+3].getAttribute( 'id' );
        var total_amount = vrows[i+4].getAttribute( 'id' );
        var strInsert = "insert into was_product_sales_invoice (sales_id,product_id,description,quantity,price,total_amount,record_date,location)"+
                            " values('"+GetValue("sales_id")+"','"+GetValue(product_id)+"','"+GetValue(description)+"','"+GetValue(quantity)+"','"+GetValue(price)+"','"+removeCommas(GetValue(total_amount))+"','"+GetValue("record_date")+"','101')";
        InsertDB(strInsert);
        var i = i+5;
    }
    
    var qryUpdate = "update was_product_sales_order_header set status = '2' where sales_id = '"+GetValue("sales_id")+"'";
    UpdateDB(qryUpdate);
    SetValue("due_amount",GetValueInner("TotalAmount"));
    SetValue("actual_amount",GetValueInner("TotalAmount"));
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
        alert('Please complete all Product Purchase fields.');
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
        
    }
    populateSalesID();
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
    SetValue("due_date",addDate(getServerSession("DueDate"),"D"));
    SetValue("invoice_number", GetCounter("009","10"));
    SetValue("payment_status","102");
    SetValue("userid", getServerSession("userid"));
    SetValueInner("TotalAmount","0.00");
    autocomplete();
    autocompleteCustomer();
    DisplayMode("hd_btnJournal","DI");
    DisplayMode("hd_btnPrint","DI");
    $('#displayList').empty();
    $("#sales_id").empty();
    DisplayMode("hd_name","DI");
    DisplayMode("hd_username","DI");
    SetValue("hd_name","");
    SetValue("hd_username", getServerSession("username"));
    SetFocus("customer_id");
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
                    + '<div style="float:right; margin-right:-2px; margin-top:5px"><a oncontextmenu="return false;" href="#" class="action" id="RemoveEntry" onclick="RemoveEntry('+counter+')" title="Remove Entry" tabindex="-1"><span class="typcn typcn-minus"></span></a></div></td>'
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
    var strDelete = "delete from was_product_sales_invoice where sales_id = '"+GetValue("sales_id")+"'";
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
    if(GetValue("customer_id") !== ""){
        var qrySQL = "select sales_id from was_product_sales_invoice_header where customer_id ='"+GetValue("customer_id")+"'";
    } else {
        var qrySQL = "select sales_id from was_product_sales_invoice_header";
    }
    
    var result = SelectDB(qrySQL);
    $("#sales_id").empty();
    $("#sales_id").append($("<option></option>").val("").html(""));
    if(result !== ""){
        result = result.split('~');
        for (var i=0; i < result.length; i++){
            $("#sales_id").append($("<option></option>").val(result[i]).html(result[i]));
        }
    }
}

function populatePaymentStatus(){
    var qrySQL = "select was_id, payment_status from was_cs_payment_status";
    var result = SelectDB(qrySQL);
    $("#payment_status").empty();
    $("#payment_status").append($("<option></option>").val("").html(""));
    if(result !== ""){
        result = result.split('~');
        for (var i=0; i < result.length; i++){
            var value = result[i].split('^');
            $("#payment_status").append($("<option></option>").val(value[0]).html(value[1]));
        }
    }
}

function AddEntry(){
    var counter = parseInt(GetValue('strCounter')) + 1;
    $('#displayList').append(
                   ' <tr id="trPurchase['+counter+']"> '
                        + '<td style="padding:1px"><input type="text" class="tags" name="dynfields" value="" id="product_id_'+counter+'" style="width:80px;" onblur="LF_product_id('+counter+')" onfocus="GetFldID(this.id)"></td>'
                        + '<td style="padding:1px"><input type="text" name="dynfields" value="" id="description_'+counter+'" style="width:450px;"></td>'
                        + '<td style="padding:1px"><input type="text" name="dynfields" value="" id="quantity_'+counter+'" style="width:80px;" onblur="getTotal('+counter+')"></td>'
                        + '<td style="padding:1px"><input type="text" name="dynfields" value="" id="price_'+counter+'" style="width:80px;" onblur="getTotal('+counter+')" disabled></td>'
                        + '<td style="padding:1px"><input type="text" name="dynfields" value="" id="total_amount_'+counter+'" style="width:60px;" disabled>'
                        + '<div style="float:right; margin-right:-2px; margin-top:5px"><a oncontextmenu="return false;" href="#" class="action" id="RemoveEntry" onclick="RemoveEntry('+counter+')" title="Remove Entry" tabindex="-1"><span class="typcn typcn-minus"></span></a></div></td>'
                        + '</td>'
                    + '</tr>'
                );
    SetValue('strCounter', counter);
    SetFocus("product_id_"+counter);
    autocomplete();
    var rowpos = $('#displayList tr:last').position();
    $('.component1').scrollTop(rowpos.top); 
}

function RemoveEntry(counter){
    var d = document.getElementById('displayList');
    var olddiv = document.getElementById('trPurchase['+counter+']');
    d.removeChild(olddiv);
    getTotalAmount();
}

function getTotal(counter){
    var strQuantity = GetValue("quantity_"+counter);
    var strCostPrice = GetValue("price_"+counter);
    if(strCostPrice !== "" && strQuantity !== ""){
        var total = parseInt(strQuantity) * parseInt(strCostPrice);
	SetValue("total_amount_"+counter,addCommas(total.toFixed(2)));
        getTotalAmount();
    }
}

function getTotalAmount(){
    var totalAmount = 0;
    var strCounter = GetValue('strCounter');
    for(var x = 1; x <= strCounter; x++){
        var strTotalPrice = 'total_amount_'+x;
	if (document.getElementById(strTotalPrice) != null){
            totalAmount = parseInt(totalAmount) + parseInt(removeCommas(GetValue(strTotalPrice)));
	}			
    }
    if(totalAmount > 0){
        SetValueInner("TotalAmount",addCommas(totalAmount.toFixed(2)));
    } else {
        SetValueInner("TotalAmount","0.00");
    }
}

function autocomplete(){
    var qrySQL = "select product_id, product_name, available from view_product_available where available > 0";
    var result = SelectDB(qrySQL);
    if(result !== ""){
        result = result.split('~');
        var tags = "[\n";
        for (var i=0; i < result.length; i++){
            var value = result[i].split('^');
            tags = tags + '{ "value": "'+value[0]+'", "label": "'+ value[0] +'    '+ value[1] +'    '+ value[2] +'"},\n';
        }
    
        tags = tags.slice(',',-2);
        tags = tags + "\n]";
        var fldProdID = GetValue("strProdID");
        var yerler = eval(tags);
        $(".tags").autocomplete({
            source: yerler,
            minLength: 0,
            minChars: 0,
            focus: function (event, ui) {
                event.preventDefault();

                SetValue(fldProdID,ui.item.value);
            },
            select: function (event, ui) {
                event.preventDefault();
                SetValue(fldProdID,ui.item.value);

            }
        });
    }
}

$.ui.autocomplete.prototype._renderItem = function (ul, item) {
    return $("<li></li>")
      .data("item.autocomplete", item)
      .append($("<span></span>").html(item.label))
      .appendTo(ul);
  };
  
  
function autocompleteCustomer(){
    var qrySQL = "select distinct cust.customer_id, concat(first_name , ' ', last_name) as name from was_product_sales_order_header sales, was_customer_info cust "
            + " where sales.customer_id = cust.customer_id and status = '1' ";
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

function GetFldID(id){
    SetValue("strProdID",id);
    autocomplete();
}

function LF_product_id(counter){
    var value = GetValue("product_id_"+counter);
    if(value !== ""){
        var qrySQL = "select selling_description, srp from was_product_price_info where product_id = '"+value+"' and record_date = (select max(record_date) from was_product_price_info where product_id = '"+value+"')";
        var result = SelectDB(qrySQL);
        var value = result.split("^");
        SetValue("description_"+counter,value[0]);
        SetValue("price_"+counter,value[1]);
    }
}

function LF_customer_id(){
    ShowLoading();
    if(GetValue("customer_id") !== ""){
        var qrySelect = "select sales_id from was_product_sales_order_header where customer_id ='"+GetValue("customer_id")+"' and sales_id not in (select sales_id from was_product_sales_invoice_header)";
        var result = SelectDB(qrySelect);
        if(result !== ""){
            result = result.split('~');
            $("#sales_id").empty();
            for (var i=0; i < result.length; i++){
                $("#sales_id").append($("<option></option>").val(result[i]).html(result[i]));
            }
            DisplayMode("sales_id","EN");
            SetFocus("sales_id");
        } else {
            $("#sales_id").empty();
            DisplayMode("sales_id","DI");
        }
    }
    HideLoading();
}

function LF_sales_id(){
    ShowLoading();
    if(GetValue("sales_id") !== ""){
        var strSQL = "select product_id, description, quantity,price, total_amount from was_product_sales_order where sales_id='"+GetValue("sales_id")+"'";
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
                        + '<td style="padding:1px"><input type="text" class="tags" name="dynfields" value="'+data[0]+'" id="product_id_'+counter+'" style="width:80px;" disabled></td>'
                        + '<td style="padding:1px"><input type="text" name="dynfields" value="'+data[1]+'" id="description_'+counter+'" style="width:450px;"></td>'
                        + '<td style="padding:1px"><input type="text" name="dynfields" value="'+data[2]+'" id="quantity_'+counter+'" style="width:80px;" onblur="getTotal('+counter+')" onkeypress="validate(event)"></td>'
                        + '<td style="padding:1px"><input type="text" name="dynfields" value="'+data[3]+'" id="price_'+counter+'" style="width:80px;" onblur="getTotal('+counter+')" onkeypress="validate(event)" disabled></td>'
                        + '<td style="padding:1px"><input type="text" name="dynfields" value="'+data[4]+'" id="total_amount_'+counter+'" style="width:60px;" disabled>'
                        + '<div style="float:right; margin-right:-2px; margin-top:5px"><a oncontextmenu="return false;" href="#" class="action" id="RemoveEntry" onclick="RemoveEntry('+counter+')" title="Remove Entry" tabindex="-1"><span class="typcn typcn-minus"></span></a></div></td>'
                        + '</td>'
                    + '</tr>'
                );
                SetValue("strCounter",counter);
            }
            getTotalAmount();
        }
    }
    HideLoading();
}

function GetChildValue(customer_id){
    autocompleteCustomer();
    SetValue("customer_id", customer_id);
    SetFocus("customer_id");
    LF_customer_id();
}
</script>