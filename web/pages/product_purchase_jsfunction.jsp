<script>
/*Required functions. onPageLoad, onAddNewUpdate, onAmendUpdate, onAddNew, onAmend, OnDelete, onCancelAddNew, onCancelAmend*/
function  onPageLoad(){
    var strSQL = "select product_id, description, quantity, cost_price, total_price from was_product_purchase where purchase_id='"+GetValue("purchase_id")+"'";
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
                    + '<td style="padding:1px"><input type="text" name="dynfields" value="'+data[0]+'" id="product_id['+counter+']" style="width:80px; ;" disabled></td>'
                    + '<td style="padding:1px"><input type="text" name="dynfields" value="'+data[1]+'" id="description['+counter+']" style="width:450px;" disabled></td>'
                    + '<td style="padding:1px"><input type="text" name="dynfields" value="'+data[2]+'" id="quantity['+counter+']" style="width:80px;" disabled></td>'
                    + '<td style="padding:1px"><input type="text" name="dynfields" value="'+data[3]+'" id="cost_price['+counter+']" style="width:80px;" disabled></td>'
                    + '<td style="padding:1px"><input type="text" name="dynfields" value="'+data[4]+'" id="total_price['+counter+']" style="width:60px;" onkeypress="validate(event)" disabled>'
                    + '<div style="float:right; margin-right:-2px; margin-top:-30px"><a oncontextmenu="return false;" href="#" class="action" id="RemoveEntry" onclick="RemoveEntryPurch('+counter+')" title="Remove Entry" tabindex="-1"></a></div></td>'
                    + '</td>'
                + '</tr>'
            );
            SetValue("strCounter",counter);
        } 
    }
    $('#tdentry').empty();
    DisplayMode("hd_username","DI");
    var qrySQL = "select username from was_user_info where userid = '"+GetValue("userid")+"'";
    var result = SelectDB(qrySQL);
    if(result !== ""){
        SetValue("hd_username", result);
    } else {
        SetValue("hd_username", "");
    }
    
    DisplayMode("hd_addSuplierbtn","DI");
    getTotalAmount();
    
    document.getElementById("hd_btnJournal").onclick = function() { window.open(baseURL()+"common/journalEntry.jsp?purchase_id="+encrypt(GetValue("purchase_id")), "_blank", "resizable=yes, scrollbars=yes, titlebar=no, width=600, height=500, top=30, left=400,menubar=no, toolbar=no, location=no, scrollbars=no"); };
    SetValue("strProdID","");
}   

function loadComboSelect(){
   populateStatus();
    populateSupplier();
}
/* onAddNewUpdate */
function onAddNewUpdate(){
    if(GetValueInner("TotalAmount") === "0.00"){
        alert("Please input the order products");
        Success(false);
        return;
    }
    
    if(GetValue("purchase_id") === ""){
        var trans_id = GetCounter("001","10");
        SetValue("transaction_id", trans_id);
        SetValue("purchase_id", trans_id);
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
        var cost_price = vrows[i+3].getAttribute( 'id' );
        var total_price = vrows[i+4].getAttribute( 'id' );
        var qryInsert = "insert into was_product_purchase (purchase_id,record_date,product_id,description,quantity,cost_price,total_price,purchase_status)"+
                            " values('"+GetValue("purchase_id")+"','"+GetValue("record_date")+"','"+GetValue(product_id)+"','"+GetValue(description)+"','"+GetValue(quantity)+"','"+GetValue(cost_price)+"','"+GetValue(total_price)+"','102')";
        InsertDB(qryInsert);
        var i = i+5;
    }
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
    
    var qryDelete = "delete from was_product_purchase where purchase_id='"+GetValue("purchase_id")+"'";
    DeleteDB(qryDelete);
    var i = 0;
    for (var x = 0; x < vrows.length/5; x++) {
        var product_id = vrows[i].getAttribute( 'id' );
        var description = vrows[i+1].getAttribute( 'id' );
        var quantity = vrows[i+2].getAttribute( 'id' );
        var cost_price = vrows[i+3].getAttribute( 'id' );
        var total_price = vrows[i+4].getAttribute( 'id' );
        var qryInsert = "insert into was_product_purchase (purchase_id,record_date,product_id,description,quantity,cost_price,total_price,purchase_status)"+
                            " values('"+GetValue("purchase_id")+"','"+GetValue("record_date")+"','"+GetValue(product_id)+"','"+GetValue(description)+"','"+GetValue(quantity)+"','"+GetValue(cost_price)+"','"+GetValue(total_price)+"','102')";
        InsertDB(qryInsert);
        var i = i+5;
    }
}

/* onAddNew */
function onAddNew(){
   SetValue("record_date",getServerSession("record_date"));
   $('#tdentry').append('<input type="button" name="hd_addEntry" id="hd_addEntry" onclick="AddEntryPurch()" value="Add Entry" style="width:100px;" onclick="">');
   
    SetValue("strCounter", 1);
    
    $('#displayList').empty();
    $('#displayList').append(
       ' <tr id="trPurchase[1]"> '
            + '<td style="padding:1px"><input  type="text" name="dynfields" value="" class="tags" id="product_id[1]" style="width:80px;" onblur="LF_product_id(1)" onfocus="GetFldID(this.id)"></td>'
            + '<td style="padding:1px"><input type="text" name="dynfields" value="" id="description[1]" style="width:450px;"></td>'
            + '<td style="padding:1px"><input type="text" name="dynfields" value="" id="quantity[1]" style="width:80px;" onblur="getTotal(1)"></td>'
            + '<td style="padding:1px"><input type="text" name="dynfields" value="" id="cost_price[1]" style="width:80px;" onblur="getTotal(1)"></td>'
            + '<td style="padding:1px"><input type="text" name="dynfields" value="" id="total_price[1]" style="width:60px;" onkeypress="validate(event)" disabled>'
            + '<div style="float:right; margin-right:-2px; margin-top:5px"><a oncontextmenu="return false;" href="#" class="action" id="RemoveEntry" onclick="RemoveEntryPurch(1)" title="Remove Entry" tabindex="-1"><span class="typcn typcn-minus"></span></a></div></td>'
        + '</tr>'
    );
    autocomplete();
    DisplayMode("hd_addSuplierbtn","EN");
    SetValue("userid", getServerSession("userid"));
    SetValue("hd_username", getServerSession("username"));
    DisplayMode("hd_username","DI");
    SetValueInner("TotalAmount","0.00");
    
    document.getElementById("hd_addSuplierbtn").onclick = function() { window.open(baseURL()+"pages/product_supplier.jsp?addnew=1", "_blank", "height=" + screen.height + ",width=" + screen.width + ",scrollbars=yes, titlebar=no"); };
}

/* onAmend */
function onAmend(){
    var strSQL = "select product_id, description, quantity, cost_price, total_price from was_product_purchase where purchase_id='"+GetValue("purchase_id")+"'";
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
                        + '<td style="padding:1px"><input type="text" class="tags" name="dynfields" value="'+data[0]+'" id="product_id['+counter+']" style="width:80px;" onblur="LF_product_id('+counter+')" onfocus="GetFldID(this.id)"></td>'
                        + '<td style="padding:1px"><input type="text" name="dynfields" value="'+data[1]+'" id="description['+counter+']" style="width:450px;"></td>'
                        + '<td style="padding:1px"><input type="text" name="dynfields" value="'+data[2]+'" id="quantity['+counter+']" style="width:80px;"></td>'
                        + '<td style="padding:1px"><input type="text" name="dynfields" value="'+data[3]+'" id="cost_price['+counter+']" style="width:80px;"></td>'
                        + '<td style="padding:1px"><input type="text" name="dynfields" value="'+data[4]+'" id="total_price['+counter+']" style="width:60px;" disabled>'
                        + '<div style="float:right; margin-right:-2px; margin-top:5px"><a oncontextmenu="return false;" href="#" class="action" id="RemoveEntry" onclick="RemoveEntryPurch('+counter+')" title="Remove Entry" tabindex="-1"><span class="typcn typcn-minus"></span></a></div></td>'
                        + '</td>'
                    + '</tr>'
                );
                SetValue("strCounter",counter);
            }
         
    }
    $('#tdentry').append('<td width="60%" style="border:none; " id="entry"><input type="button" name="hd_addEntry" id="hd_addEntry" onclick="AddEntryPurch()" value="Add Entry" style="width:100px;" onclick=""></td>');
    autocomplete();
    document.getElementById("hd_btnJournal").onclick = function() {};
    DisplayMode("status","EN");
    if(GetValue("status") !== "101"){
        DisplayMode("status","DI");
    }
}

/* OnDelete */
function OnDelete(){
    var qryDelete = "delete from was_product_purchase where purchase_id = '"+GetValue("purchase_id")+"'";
    DeleteDB(qryDelete);
}

/* onCancelAddNew */
function onCancelAddNew(){
    $('#tdentry').empty();
    $('#RemoveEntry').empty();
    DisplayMode("product_id[1]","DI");
    DisplayMode("description[1]","DI");
    DisplayMode("quantity[1]","DI");
    DisplayMode("cost_price[1]","DI");
}

/* onCancelAmend */
function onCancelAmend(){
    $('#tdentry').empty();
    $('#RemoveEntry').empty();   
}

function AddEntryPurch(){
    var counter = parseInt(GetValue('strCounter')) + 1;
    $('#displayList').append(
        ' <tr id="trPurchase['+counter+']"> '
            + '<td style="padding:1px"><input type="text" class="tags" name="dynfields" value="" id="product_id['+counter+']" style="width:80px;" onblur="LF_product_id('+counter+')" onfocus="GetFldID(this.id)"></td>'
            + '<td style="padding:1px"><input type="text" name="dynfields" value="" id="description['+counter+']" style="width:450px;"></td>'
            + '<td style="padding:1px"><input type="text" name="dynfields" value="" id="quantity['+counter+']" style="width:80px;" onblur="getTotal('+counter+')"></td>'
            + '<td style="padding:1px"><input type="text" name="dynfields" value="" id="cost_price['+counter+']" style="width:80px;" onblur="getTotal('+counter+')"></td>'
            + '<td style="padding:1px"><input type="text" name="dynfields" value="" id="total_price['+counter+']" style="width:60px;" onkeypress="validate(event)" disabled>'
            + '<div style="float:right; margin-right:-2px; margin-top:5px"><a oncontextmenu="return false;" href="#" class="action" id="RemoveEntry" onclick="RemoveEntryPurch('+counter+')" title="Remove Entry" tabindex="-1"><span class="typcn typcn-minus"></span></a></div></td>'
        + '</tr>'
    );
    SetValue('strCounter', counter);
    SetFocus("product_id["+counter+"]");
    autocomplete();
}

function RemoveEntryPurch(counter){
    var d = document.getElementById('displayList');
    var olddiv = document.getElementById('trPurchase['+counter+']');
    d.removeChild(olddiv);
    getTotalAmount();
}

function getTotal(counter){
    var strQuantity = GetValue("quantity["+counter+"]");
    var strCostPrice = GetValue("cost_price["+counter+"]");
    if(strCostPrice !== "" && strQuantity !== ""){
        var total = parseInt(strQuantity) * parseInt(strCostPrice);
	SetValue("total_price["+counter+"]",total.toFixed(2));
    }
    getTotalAmount();
}

function getTotalAmount(){
    var totalAmount = 0;
    var strCounter = GetValue('strCounter');
    for(var x = 1; x <= strCounter; x++){
        var strTotalPrice = 'total_price['+x+']';
        var strQuantity = 'quantity['+x+']';
	if (document.getElementById(strTotalPrice) != null){
            if(GetValue(strQuantity) !== ""){
                totalAmount = parseInt(totalAmount) + parseInt(GetValue(strTotalPrice));
            }
	}			
    }
    SetValueInner("TotalAmount",totalAmount.toFixed(2));
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

function populateSupplier(){
    var qrySQL = "SELECT supplier_id, company_name FROM was_supplier order by company_name";
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

function populateStatus(){
    var qrySQL = "SELECT was_id, purchase_status FROM was_cs_purchase_status";
    var result = SelectDB(qrySQL);
    if(result !== ""){
        result = result.split('~');
        $("#status").empty();
        $("#status").append($("<option></option>").val("").html(""));
        for (var i=0; i < result.length; i++){
            var value = result[i].split('^');
            $("#status").append($("<option></option>").val(value[0]).html(value[1]));
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
    
    var qrySQL = "select product_id, product_name from was_product";
    var result = SelectDB(qrySQL);
    if(result !== ""){
        result = result.split('~');
        var tags = "[\n";
        for (var i=0; i < result.length; i++){
            var value = result[i].split('^');
            tags = tags + '{ "value": "'+value[0]+'", "label": "'+ value[0] +' - '+ value[1] +'"},\n';
        }
    }
    tags = tags.slice(',',-2);
    tags = tags + "\n]";
    var fldProdID = GetValue("strProdID");
    var yerler = eval(tags);
    $(".tags").autocomplete({
        source: yerler,
        minLength: 0,
        minChars: 0,
        response: function (event, ui) {
            ui.content.push({
              label: '<input type="button" name="hd_addProduct" id="hd_addProduct" value="Add Product" style="width:100px;" onclick="window.open(\'product_items.jsp?addnew=1\', \'_blank\', \'height=' + screen.height + ',width=' + screen.width + ',scrollbars=yes, titlebar=no\');">',
              button: true
            });
          },
        /*focus: function (event, ui) {
            event.preventDefault();
            
            SetValue(fldProdID,ui.item.value);
        },*/
        select: function (event, ui) {
            event.preventDefault();
            SetValue(fldProdID,ui.item.value);
            
        }
    }).on('focus', function(event) {
        var self = this;
        $(self).autocomplete( "search", "");;
    });
}

function LF_product_id(counter){
    var product_id = GetValue("product_id["+counter+"]");
    var qrySQL = "select cost_description, normal_price from was_product_price_info where product_id = '"+product_id+"' and record_date = (select max(record_date) from was_product_price_info where product_id = '"+product_id+"')";
    var result = SelectDB(qrySQL);
    if(result !== ""){
        var value = result.split("^");
        SetValue("description["+counter+"]",value[0]);
        SetValue("cost_price["+counter+"]",value[1]);
    }
    
    var qrySQL1 = "select reorder_quantity from was_product where product_id = '"+product_id+"'";
    var result1 = SelectDB(qrySQL1);
    if(result1 !== ""){
        SetValue("quantity["+counter+"]",result1);
        getTotal(counter);
    }
}

function GetFldID(id){
    SetValue("strProdID",id);
    autocomplete();
}

function AddSupplierBtn(){
}

function GetChildValue(product_id){
    autocomplete();
    var num = GetValue("strProdID").charAt(GetValue("strProdID").length-2);
    SetValue("product_id["+num+"]", product_id);
    LF_product_id(num);
    SetFocus("description["+num+"]");
}

function GetChildValueSuppier(supplier_id){
    populateSupplier();
    SetValue("supplier_id", supplier_id);
}
</script>