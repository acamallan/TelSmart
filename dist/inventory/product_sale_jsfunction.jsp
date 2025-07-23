<script>
/*Required functions. onPageLoad, onAddNewUpdate, onAmendUpdate, onAddNew, onAmend, OnDelete, onCancelAddNew, onCancelAmend*/
function  onPageLoad(){
    var strSQL = "select product_id, price, quantity, total, discount, discount_amount, total_amount from wasi_product_sale where sale_id='"+GetValue("sale_id")+"'";
    var strReturn = SelectDB(strSQL);
    SetValue("strCounter",1);
    if(strReturn != ""){
        var record = strReturn.split('~');
        $("#prodSale").find("tr:gt(0)").remove();
        for(x = 1; x <= record.length; x++){
            var data = record[x-1].split('^');
            if(x == 1){
                SetValue("product_id[1]",data[0]);
                SetValue("price[1]",data[1]);
                SetValue("quantity[1]",data[2]);
                SetValue("total[1]",data[3]);
                SetValue("discount[1]",data[4]);
                SetValue("discount_amount[1]",data[5]);
                SetValue("total_amount[1]",data[6]);
                DisplayMode('product_id[1]','DI');
                DisplayMode('quantity[1]','DI');
                DisplayMode('discount[1]','DI');
                SetValue("strCounter",1);
            } else {
                var counter = parseInt(document.getElementById('strCounter').value) + 1;
                var strSelectOpt = document.getElementById('strSelectOpt').value;
                var strSelectOpt = strSelectOpt.replace(/counter/g, counter);

                $('#prodSale').append(
                   ' <tr id="trSale['+counter+']"> '
                        + '<td style="padding:3px">'+strSelectOpt+'</td>'
                        + '<td><input type="text" name="dynfields[' + counter + '][price]" id="price[' + counter + ']" value="'+data[1]+'" style="width:80px;text-align: right;"disabled></td>'
                        + '<td><input type="text" name="dynfields[' + counter + '][quantity]" id="quantity[' + counter + ']" value="'+data[2]+'" style="width:80px;" required onkeypress="validate(event)" onblur="totalItems('+ counter +')" disabled></td>'
                        + '<td><input type="text" name="dynfields[' + counter + '][total]" id="total[' + counter + ']" value="'+data[3]+'" style="width:80px;" required disabled></td>'
                        + '<td><input type="text" name="dynfields[' + counter + '][discount]" id="discount[' + counter + ']" value="'+data[4]+'" style="width:80px;" onkeypress="validate(event)" required onblur="totalAmount('+ counter +'); empAvailStock();" disabled></td>'
                        + '<td><input type="text" name="dynfields[' + counter + '][discount_amount]" id="discount_amount[' + counter + ']" value="'+data[5]+'" style="width:80px;text-align: right;" onkeypress="validate(event)" disabled required></td>'
                        + '<td ><input type="text" name="dynfields[' + counter + '][total_amount]" id="total_amount[' + counter + ']"  value="'+data[6]+'" style="width:80px;text-align: right;" disabled>'
                        + '</td>'
                        + '</tr>'
                );
                SetValue("product_id[" + counter + "]",data[0]);
                SetValue("strCounter",counter);
                DisplayMode('product_id['+counter+']','DI');
            }
        } 
    } else {
        $("#prodSale").find("tr:gt(0)").remove();
        SetValue("product_id[1]","");
        SetValue("price[1]","");
        SetValue("quantity[1]","");
        SetValue("total[1]","");
        SetValue("discount[1]","");
        SetValue("discount_amount[1]","");
        SetValue("total_amount[1]","");
        SetValue("strCounter",1);
    }
}   

/* onAddNewUpdate */
function onAddNewUpdate(){
    SetValue("sale_id", pad(GetCounter("002","10"),"10"));
    var vrows = document.getElementsByName("dynfields");
    var i = 0;
    for (var x = 0; x < vrows.length/7; x++) {
        var product_id = vrows[i].getAttribute( 'id' );
        var price = vrows[i+1].getAttribute( 'id' );
        var quantity = vrows[i+2].getAttribute( 'id' );
        var total = vrows[i+3].getAttribute( 'id' );
        var discount = vrows[i+4].getAttribute( 'id' );
        var discount_amount = vrows[i+5].getAttribute( 'id' );
        var total_amount = vrows[i+6].getAttribute( 'id' );
        var strInsert = "insert into wasi_product_sale (sale_id,product_id,price,quantity,total,discount,discount_amount,total_amount,record_date)"+
                            " values('"+GetValue("sale_id")+"','"+GetValue(product_id)+"','"+GetValue(price)+"','"+GetValue(quantity)+"','"+GetValue(total)+"','"+GetValue(discount)+"','"+GetValue(discount_amount)+"','"+GetValue(total_amount)+"','"+GetValue("record_date")+"')";
        InsertDB(strInsert);
        var i = i+7;
        DisplayMode(product_id, "DI");
        DisplayMode(quantity, "DI");
        DisplayMode(discount, "DI");
        $('#RemoveEntry').remove();
    }
    $('#entry').remove();
}

/* onAmendUpdate */
function onAmendUpdate(){
    var strDelete = "delete from wasi_product_sale where sale_id = '"+GetValue("sale_id")+"'";
    DeleteDB(strDelete);
    var vrows = document.getElementsByName("dynfields");
    var i = 0;
    for (var x = 0; x < vrows.length/7; x++) {
        var product_id = vrows[i].getAttribute( 'id' );
        var price = vrows[i+1].getAttribute( 'id' );
        var quantity = vrows[i+2].getAttribute( 'id' );
        var total = vrows[i+3].getAttribute( 'id' );
        var discount = vrows[i+4].getAttribute( 'id' );
        var discount_amount = vrows[i+5].getAttribute( 'id' );
        var total_amount = vrows[i+6].getAttribute( 'id' );
        var strInsert = "insert into wasi_product_sale (sale_id,product_id,price,quantity,total,discount,discount_amount,total_amount,record_date)"+
                            " values('"+GetValue("sale_id")+"','"+GetValue(product_id)+"','"+GetValue(price)+"','"+GetValue(quantity)+"','"+GetValue(total)+"','"+GetValue(discount)+"','"+GetValue(discount_amount)+"','"+GetValue(total_amount)+"','"+GetValue("record_date")+"')";
        InsertDB(strInsert);
        var i = i+7;
        DisplayMode(product_id, "DI");
        DisplayMode(quantity, "DI");
        DisplayMode(discount, "DI");
        $('#RemoveEntry').remove();
    }

    DisplayMode("hd_amend", "DI");
    $('#entry').remove();
    
}

/* onAddNew */
function onAddNew(){
    <%
    Date date = Calendar.getInstance().getTime();
    DateFormat formatter = new SimpleDateFormat("MM.dd.yyyy");
    String today = formatter.format(date);
    %>
    SetValue("record_date", "<%= today %>");
    $("#prodSale").find("tr:gt(0)").remove();
    SetValue("product_id[1]","");
    SetValue("price[1]","");
    SetValue("quantity[1]","");
    SetValue("total[1]","");
    SetValue("discount[1]","");
    SetValue("discount_amount[1]","");
    SetValue("total_amount[1]","");
    DisplayMode('product_id[1]','EN');
    DisplayMode('quantity[1]','EN');
    DisplayMode('discount[1]','EN');
    $('#trentry').append('<td width="60%" style="border:none; " id="entry"><a href="#" class="action" id="AddEntry" onclick="AddEntry()" title="Add Entry"><span class="typcn typcn-plus"></span>Add Entry</a></td>');
    SetValue("strCounter", 1);
}

/* onAmend */
function onAmend(){
    var strSQL = "select product_id, price, quantity, total, discount, discount_amount, total_amount from wasi_product_sale where sale_id='"+GetValue("sale_id")+"'";
    var strReturn = SelectDB(strSQL);
    var record = strReturn.split('~');
    SetValue("strCounter",1);
    $("#prodSale").find("tr:gt(0)").remove();
    for(x = 1; x <= record.length; x++){
        var data = record[x-1].split('^');
        if(x == 1){
            SetValue("product_id[1]",data[0]);
            SetValue("price[1]",data[1]);
            SetValue("quantity[1]",data[2]);
            SetValue("total[1]",data[3]);
            SetValue("discount[1]",data[4]);
            SetValue("discount_amount[1]",data[5]);
            SetValue("total_amount[1]",data[6]);
        } else {
           
            var counter = parseInt(document.getElementById('strCounter').value) + 1;
            var strSelectOpt = document.getElementById('strSelectOpt').value;
            var strSelectOpt = strSelectOpt.replace(/counter/g, counter);
            $('#prodSale').append(
               ' <tr id="trSale['+counter+']"> '
                    + '<td style="padding:3px">'+strSelectOpt+'</td>'
                    + '<td><input type="text" name="dynfields" id="price[' + counter + ']" value="'+data[1]+'" style="width:80px;text-align: right;"disabled></td>'
                    + '<td><input type="text" name="dynfields" id="quantity[' + counter + ']" value="'+data[2]+'" style="width:80px;" required onkeypress="validate(event)" onblur="totalItems('+ counter +')" disabled></td>'
                    + '<td><input type="text" name="dynfields" id="total[' + counter + ']" value="'+data[3]+'" style="width:80px;" required disabled></td>'
                    + '<td><input type="text" name="dynfields" id="discount[' + counter + ']" value="'+data[4]+'" style="width:80px;" onkeypress="validate(event)" required onblur="totalAmount('+ counter +'); empAvailStock();" disabled></td>'
                    + '<td><input type="text" name="dynfields" id="discount_amount[' + counter + ']" value="'+data[5]+'" style="width:80px;text-align: right;" onkeypress="validate(event)" disabled required></td>'
                    + '<td ><input type="text" name="dynfields" id="total_amount[' + counter + ']"  value="'+data[6]+'" style="width:80px;text-align: right;" disabled>'
                    + '</td>'
                    + '</tr>'
            );
            DisplayMode('product_id['+counter+']','DI');
            SetValue("product_id[" + counter + "]",data[0]);
            SetValue("strCounter",counter);
        }
    }
    DisplayMode("hd_amend", "EN");
}

/* OnDelete */
function OnDelete(){
    var strDelete = "delete from wasi_product_sale where sale_id = '"+GetValue("sale_id")+"'";
    DeleteDB(strDelete);
}

/* onCancelAddNew */
function onCancelAddNew(){
    DisplayMode("hd_amend", "DI");
    $('#entry').remove();
}

/* onCancelAmend */
function onCancelAmend(){
    DisplayMode("hd_amend", "DI");
    $('#entry').remove();
}

function AmendBody(){
    $('#trentry').append('<td width="60%" style="border:none; " id="entry"><a href="#" class="action" id="AddEntry" onclick="AddEntry()" title="Add Entry"><span class="typcn typcn-plus"></span>Add Entry</a></td>');
    var strSQL = "select product_id, price, quantity, total, discount, discount_amount, total_amount from wasi_product_sale where sale_id='"+GetValue("sale_id")+"'";
    var strReturn = SelectDB(strSQL);
    var record = strReturn.split('~');
     $("#prodSale").find("tr:gt(0)").remove();
    for(x = 0; x < record.length; x++){
        var data = record[x].split('^');
        if(x == 0){
            SetValue("product_id[1]",data[0]);
            SetValue("price[1]",data[1]);
            SetValue("quantity[1]",data[2]);
            SetValue("total[1]",data[3]);
            SetValue("discount[1]",data[4]);
            SetValue("discount_amount[1]",data[5]);
            SetValue("total_amount[1]",data[6]);
            DisplayMode('product_id[1]','EN');
            DisplayMode('quantity[1]','EN');
            DisplayMode('discount[1]','EN');
        } else {
           
            var counter = parseInt(document.getElementById('strCounter').value) + 1;
            var strSelectOpt = document.getElementById('strSelectOpt').value;
            var strSelectOpt = strSelectOpt.replace(/counter/g, counter);

            $('#prodSale').append(
               ' <tr id="trSale['+counter+']"> '
                    + '<td style="padding:3px">'+strSelectOpt+'</td>'
                    + '<td><input type="text" name="dynfields" id="price[' + counter + ']" value="'+data[1]+'" style="width:80px;text-align: right;"disabled><input type="hidden" name="dynfields[' + counter + '][price]" value="" id="price[' + counter + ']" style="width:80px; ;text-align: right;"></td>'
                    + '<td><input type="text" name="dynfields" id="quantity[' + counter + ']" value="'+data[2]+'" style="width:80px;" required onkeypress="validate(event)" onblur="totalItems('+ counter +')" disabled></td>'
                    + '<td><input type="text" name="dynfields" id="total[' + counter + ']" value="'+data[3]+'" style="width:80px;" required disabled><input type="hidden" name="dynfields[' + counter + '][total]" value="" id="total[' + counter + ']" style="width:80px;" required></td>'
                    + '<td><input type="text" name="dynfields" id="discount[' + counter + ']" value="'+data[4]+'" style="width:80px;" onkeypress="validate(event)" required onblur="totalAmount('+ counter +'); empAvailStock();" disabled></td>'
                    + '<td><input type="text" name="dynfields" id="discount_amount[' + counter + ']" value="'+data[5]+'" style="width:80px;text-align: right;" onkeypress="validate(event)" disabled required><input type="hidden" name="dynfields[' + counter + '][discount_amount]" value="" id="discount_amount[' + counter + ']" style="width:80px;text-align: right;" ></td>'
                    + '<td ><input type="text" name="dynfields" id="total_amount[' + counter + ']"  value="'+data[6]+'" style="width:80px;text-align: right;" disabled><input type="hidden" name="dynfields[' + counter + '][total_amount]" value="" id="total_amount[' + counter + ']" style="width:80px;text-align: right;" >'
                    + '<div style="float:right; margin-right:-2px; margin-top:-30px"><a href="#" class="action" id="RemoveEntry" onclick="RemoveEntry('+counter+')" title="Remove Entry" tabindex="-1"><span class="typcn typcn-minus"></a></span></div></td>'
                    + '</tr>'
            );
            SetValue("product_id[" + counter + "]",data[0]);
            SetValue("strCounter",counter);
            DisplayMode('product_id['+counter+']','EN');
            DisplayMode('quantity['+counter+']','EN');
            DisplayMode('discount['+counter+']','EN');
        }
    }
}
function LF_product_id(counter){
    var product_id = 'product_id['+counter+']';
    if(GetValue(product_id) != ""){
        var strSQL = "select stock_in - IFNULL(stock_out,0) as available_stock, selling_price from view_products where product_id = '"+GetValue(product_id)+"'";
        var strReturn = SelectDB(strSQL);
        var data = strReturn.split('^');
        var price = 'price['+counter+']';
        var priceShow = 'priceShow['+counter+']';
        document.getElementById('hd_avail_stocks').value = data[0];
        document.getElementById(price).value = data[1];
	var quantity = 'quantity['+counter+']';
	var discount = 'discount['+counter+']';
	document.getElementById(quantity).disabled = false;
	document.getElementById(discount).disabled = false;
	document.getElementById(quantity).focus();
    } 
}
	
function totalItems(counter){
    var strQuantityField = 'quantity['+counter+']';
    var strCountVal = parseInt(document.getElementById(strQuantityField).value);
    var strAvailStocks = parseInt(document.getElementById('hd_avail_stocks').value);
    if(strAvailStocks < strCountVal){
        alert('Quantites already exceed. Available stocks: '+strAvailStocks);
	document.getElementById(strQuantityField).focus();
        return;
    }
    var strCounter = document.getElementById('strCounter').value;
    var strTotalItems = 0;
    for(var x = 1; x <= strCounter; x++){
        var strQuantityField = 'quantity['+x+']';
	var strPriceField = 'price['+x+']';
	var strTotalField = 'total['+x+']';
	if (document.getElementById(strQuantityField) != null){
            var strCountVal = document.getElementById(strQuantityField).value;
            var strPriceVal = document.getElementById(strPriceField).value;
            if (strCountVal != ""){
                var strTotalItems = strTotalItems + parseFloat(strCountVal);
                var strTotal = parseFloat(strPriceVal) * parseFloat(strCountVal);
            } 
        }			
    }
    
    document.getElementById('total_items').value = strTotalItems;
    if (document.getElementById(strTotalField) != null){
        var strQuantityField = 'quantity['+counter+']';
	var strPriceField = 'price['+counter+']';
	var strTotalField = 'total['+counter+']';
	var strCountVal = document.getElementById(strQuantityField).value;
	var strPriceVal = document.getElementById(strPriceField).value;
	if (strCountVal != ""){
            var strTotal = parseFloat(strPriceVal) * parseFloat(strCountVal);
        } else {
            alert('Please input the Quantity.');
            document.getElementById(strQuantityField).focus();
            return;
	}
	document.getElementById(strTotalField).value = strTotal.toFixed(2);
    }
    totalAmount(counter);
}
	
function totalAmount(counter){
    var strCounter = document.getElementById('strCounter').value;
    for(var x = 1; x <= strCounter; x++){
        var strPriceField = 'price['+x+']';
	var strQuantityField = 'quantity['+x+']';
	var strTotalField = 'total['+x+']';
	var strDiscountField = 'discount['+x+']';
	var strDiscountAmmountField = 'discount_amount['+x+']';
	var strTotalAmountField = 'total_amount['+x+']';
	if (document.getElementById(strDiscountField) != null){
            var strPriceVal = document.getElementById(strPriceField).value;
            var strQuantityVal = document.getElementById(strQuantityField).value;
            var strDiscountVal = document.getElementById(strDiscountField).value;
            if (strDiscountVal != ""){
                var strTotal = parseFloat(strPriceVal) * parseFloat(strQuantityVal);
		var strDiscount =strTotal*(parseFloat(strDiscountVal)/100);
		var strDiscountedAmount = parseFloat(strTotal) - strDiscount;
            } else {
                document.getElementById(strDiscountField).value = 0;
		totalAmount();
            }
	}			
    }

    if (document.getElementById(strDiscountAmmountField) != null){
        var strPriceField = 'price['+counter+']';
	var strQuantityField = 'quantity['+counter+']';
	var strTotalField = 'total['+counter+']';
	var strDiscountField = 'discount['+counter+']';
	var strDiscountAmmountField = 'discount_amount['+counter+']';
	var strTotalAmountField = 'total_amount['+counter+']';
	var strPriceVal = document.getElementById(strPriceField).value;
	var strQuantityVal = document.getElementById(strQuantityField).value;
	var strDiscountVal = document.getElementById(strDiscountField).value;
	if (strDiscountVal != ""){
            var strTotal = parseFloat(strPriceVal) * parseFloat(strQuantityVal);
            var strDiscount =strTotal*(parseFloat(strDiscountVal)/100);
            var strDiscountedAmount = parseFloat(strTotal) - strDiscount;
	}
	document.getElementById(strDiscountAmmountField).value = strDiscount.toFixed(2);
	document.getElementById(strTotalAmountField).value = strDiscountedAmount.toFixed(2);
    }

    var strTotal = 0;
    for(var x = 1; x <= strCounter; x++){
        var strTotalAmountField = 'total_amount['+x+']';
        if (document.getElementById(strTotalAmountField) != null){
            var strTotalAmountVal = document.getElementById(strTotalAmountField).value;
            if (strTotalAmountVal != ""){
                var strTotal = strTotal + parseFloat(strTotalAmountVal);
            }
        }			
    }

    document.getElementById('grand_total').value = strTotal.toFixed(2);
}
	
function empAvailStock(){
    document.getElementById('hd_avail_stocks').value ="";
}
	
</script>