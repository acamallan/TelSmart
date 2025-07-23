<script>
/*Required functions. onPageLoad, onAddNewUpdate, onAmendUpdate, onAddNew, onAmend, OnDelete, onCancelAddNew, onCancelAmend*/
function  onPageLoad(){
    var strSQL = "select product_id, description, quantity, price, total_amount from was_product_sales_order where sales_id='"+GetValue("sales_id")+"'";
    
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
    DisplayMode("hd_btnJournal","EN");
    document.getElementById("hd_btnJournal").onclick = function() { window.open(baseURL()+"common/journalEntry.jsp?sales_id="+encrypt(GetValue("sales_id")), "_blank", "resizable=yes, scrollbars=yes, titlebar=no, width=600, height=500, top=30, left=400,menubar=no, toolbar=no, location=no, scrollbars=no"); };
    DisplayMode("hd_btnPrint","EN");
    document.getElementById("hd_btnPrint").onclick = function() { window.open(baseURL()+"common/sales_order.jsp?sales_id="+encrypt(GetValue("sales_id")), "_blank", "height=" + screen.height + ",width=" + screen.width + ",scrollbars=yes, titlebar=no"); };
    DisplayMode("hd_addCust","DI");
    $('#tdentry').empty();
}   

/* onAddNewUpdate */
function onAddNewUpdate(){
    if(GetValue("sales_id") === ""){
        SetValue("sales_id", GetCounter("001","10"));
    }
    
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
        var strInsert = "insert into was_product_sales_order (sales_id,product_id,description,quantity,price,total_amount,record_date)"+
                            " values('"+GetValue("sales_id")+"','"+GetValue(product_id)+"','"+GetValue(description)+"','"+GetValue(quantity)+"','"+GetValue(price)+"','"+removeCommas(GetValue(total_amount))+"','"+GetValue("record_date")+"')";
        InsertDB(strInsert);
        var i = i+5;
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
    
    var strDelete = "delete from was_product_sales_order where sales_id = '"+GetValue("sales_id")+"'";
    DeleteDB(strDelete);
    
    var i = 0;
    for (var x = 0; x < vrows.length/5; x++) {
        var product_id = vrows[i].getAttribute( 'id' );
        var description = vrows[i+1].getAttribute( 'id' );
        var quantity = vrows[i+2].getAttribute( 'id' );
        var price = vrows[i+3].getAttribute( 'id' );
        var total_amount = vrows[i+4].getAttribute( 'id' );
        var strInsert = "insert into was_product_sales_order (sales_id,product_id,description,quantity,price,total_amount,record_date)"+
                            " values('"+GetValue("sales_id")+"','"+GetValue(product_id)+"','"+GetValue(description)+"','"+GetValue(quantity)+"','"+GetValue(price)+"','"+removeCommas(GetValue(total_amount))+"','"+GetValue("record_date")+"')";
        InsertDB(strInsert);
        var i = i+5;
    }
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
    $('#tdentry').append('<input type="button" name="hd_addEntry" id="hd_addEntry" onclick="AddEntry()" value="Add Entry" style="width:100px;" onclick="">');
    SetValue("strCounter", 1);
    
    $('#displayList').empty();
    $('#displayList').append(
       ' <tr id="trPurchase[1]"> '
            + '<td style="padding:1px"><input type="text" name="dynfields"  class="tags" value="" id="product_id_1" style="width:80px;" onblur="LF_product_id(1)" onfocus="GetFldID(this.id)"></td>'
            + '<td style="padding:1px"><input type="text" name="dynfields" value="" id="description_1" style="width:450px;"></td>'
            + '<td style="padding:1px"><input type="text" name="dynfields" value="" id="quantity_1" style="width:80px;" onblur="getTotal(1)" onkeypress="validate(event)"></td>'
            + '<td style="padding:1px"><input type="text" name="dynfields" value="" id="price_1" style="width:80px;" onblur="getTotal(1)" onkeypress="validate(event)" disabled></td>'
            + '<td style="padding:1px"><input type="text" name="dynfields" value="" id="total_amount_1" style="width:60px;" onkeypress="validate(event)" disabled>'
            + '<div style="float:right; margin-right:-2px; margin-top:5px"><a oncontextmenu="return false;" href="#" class="action" id="RemoveEntry" onclick="RemoveEntry(1)" title="Remove Entry" tabindex="-1"><span class="typcn typcn-minus"></span></a></div></td>'
        + '</tr>'
    );
    
    DisplayMode("hd_name","DI");
    DisplayMode("hd_username","DI");
    SetValue("hd_name","");
    SetValue("hd_username", getServerSession("username"));
    SetValue("status","1");
    SetValue("userid", getServerSession("userid"));
    SetValueInner("TotalAmount","0.00");
    autocomplete();
    autocompleteCustomer(); 
    DisplayMode("hd_btnJournal","DI");
    DisplayMode("hd_btnPrint","DI");
    
    DisplayMode("hd_addCust","EN");
    document.getElementById("hd_addCust").onclick = function() { window.open(baseURL()+"pages/customer_info.jsp?addnew=1", "_blank", "height=" + screen.height + ",width=" + screen.width + ",scrollbars=yes, titlebar=no"); };
}

/* onAmend */
function onAmend(){
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
    var strDelete = "delete from was_product_sales_order where sales_id = '"+GetValue("sales_id")+"'";
    DeleteDB(strDelete);
}

/* onCancelAddNew */
function onCancelAddNew(){
    $('#tdentry').empty();
    SetValue("hd_username","");
    SetValue("hd_name","");
    DisplayMode("product_id_1","DI");
    DisplayMode("description_1","DI");
    DisplayMode("quantity_1","DI");
}

/* onCancelAmend */
function onCancelAmend(){
    $('#tdentry').empty();
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
    var qrySQL = "select customer_id, concat(first_name , '    ', last_name) as name from was_customer_info ";
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
            SetValue("hd_name",name[1]);
        }
    }).on('focus', function(event) {
        var self = this;
        $(self).autocomplete( "search", "");;
    });
}

function GetFldID(id){
    SetValue("strProdID",id);
    autocomplete();
}

function LF_product_id(counter){
    var value = GetValue("product_id_"+counter);
    if(value !== ""){
        var qrySQL = "select selling_description, srp from was_product_price_info where product_id = '"+value+"' and record_date = (select max(record_date) from was_product_price_info where product_id = '"+value+"')"
        var result = SelectDB(qrySQL);
        var value = result.split("^");
        SetValue("description_"+counter,value[0]);
        SetValue("price_"+counter,value[1]);
    }
}

function LF_customer_id(){
    ShowLoading();
    if(GetValue("customer_id") === ""){
        SetValue("hd_name","");
    } else {
        SetValue("customer_id",pad(GetValue("customer_id"),'10'));
        var qrySelect = "select first_name, last_name from was_customer_info where customer_id ='"+GetValue("customer_id")+"'";
        var result = SelectDB(qrySelect);
        if(result === ""){
            alert("Customer ID not found.");
            SetFocus("customer_id");
            HideLoading();
            return;
        }

        result = result.split("^");
        SetValue("hd_name", result[0] +" "+ result[1]);
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