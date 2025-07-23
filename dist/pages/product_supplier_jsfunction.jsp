<script>
/*Required functions. onPageLoad, onAddNewUpdate, onAmendUpdate, onAddNew, onAmend, OnDelete, onCancelAddNew, onCancelAmend*/
function  onPageLoad(){
    $( "#tabs" ).tabs();
    $( "#tabs" ).tabs( "option", "active", 0 );
    SetStyle("footer_navigation","display","block");
}   

function loadComboSelect(){
    populateVendorType();
}

/* onAddNewUpdate */
function onAddNewUpdate(){
    SetValue('supplier_id',pad(GetCounter("005","6"),"6"));
}

/* onAmendUpdate */
function onAmendUpdate(){
    
}

/* postAddNewUpdate */
function postAddNewUpdate(){
    $( "#tabs" ).tabs( "enable", 1 );
    $( "#tabs" ).tabs( "enable", 2 );
    $( "#tabs" ).tabs( "enable", 3 );
    $( "#tabs" ).tabs( "enable", 4 );
    $( "#tabs" ).tabs( "option", "active", 1 );
    tab2();
}

/* onAddNew */
function onAddNew(){
    $( "#tabs" ).tabs();
    $( "#tabs" ).tabs( "option", "active", 0 );
    SetValue("record_date",getServerSession("record_date"));
    $( "#tabs" ).tabs({
        disabled: [ 1,2,3,4 ]
    });
}

/* onAmend */
function onAmend(){
    $( "#tabs" ).tabs({
        disabled: [ 1,2,3,4 ]
    });
}

/* OnDelete */
function OnDelete(){
    var qryDelete = "delete from was_supplier_address where supplier_id='"+GetValue("supplier_id")+"'";
    DeleteDB(qryDelete);
    var qryDelete = "delete from was_supplier_purchase where supplier_id='"+GetValue("supplier_id")+"'";
    DeleteDB(qryDelete);
}

/* onCancelAddNew */
function onCancelAddNew(){
    $( "#tabs" ).tabs( "enable", 1 );
    $( "#tabs" ).tabs( "enable", 2 );
    $( "#tabs" ).tabs( "enable", 3 );
    $( "#tabs" ).tabs( "enable", 4 );
}

/* onCancelAmend */
function onCancelAmend(){
    $( "#tabs" ).tabs( "enable", 1 );
    $( "#tabs" ).tabs( "enable", 2 );
    $( "#tabs" ).tabs( "enable", 3 );
    $( "#tabs" ).tabs( "enable", 4 );
}

function populateVendorType(){
    var qrySQL = "SELECT was_id, vendor_type FROM was_cs_vendor_type order by vendor_type";
    var result = SelectDB(qrySQL);
    if(result !== ""){
        result = result.split('~');
        $("#vendor_type").empty();
        $("#vendor_type").append($("<option></option>").val("").html(""));
        for (var i=0; i < result.length; i++){
            var value = result[i].split('^');
            $("#vendor_type").append($("<option></option>").val(value[0]).html(value[1]));
        }
    }
}

function populateCountry(){
    var qrySQL = "select was_id, country from was_cs_country";
    var result = SelectDB(qrySQL);
    $("#hd_country").empty();
    if(result !== ""){
        result = result.split('~');
        $("#hd_country").append($("<option></option>").val("").html(""));
        for (var i=0; i < result.length; i++){
            var value = result[i].split('^');
            var len = value[0].length - 3;
            var space ="";
            for(var x=0; x < len; x++){
                space = space+"\xa0";
            }
            $("#hd_country").append($("<option></option>").val(value[0]).html(space+value[1]));
        }
    }
}

function populateCity(){
    var qrySQL = "select was_id, country from was_cs_country";
    var result = SelectDB(qrySQL);
    $("#hd_city").empty();
    if(result !== ""){
        result = result.split('~');
        $("#hd_city").append($("<option></option>").val("").html(""));
        for (var i=0; i < result.length; i++){
            var value = result[i].split('^');
            var len = value[0].length - 3;
            var space ="";
            for(var x=0; x < len; x++){
                space = space+"\xa0";
            }
            $("#hd_city").append($("<option></option>").val(value[0]).html(space+value[1]));
        }
    }
}

function populateAddressCategory(){
    var qrySQL = "select was_id, address_category from was_cs_address_category";
    var result = SelectDB(qrySQL);
    $("#hd_address_category").empty();
    if(result !== ""){
        result = result.split('~');
        $("#hd_address_category").append($("<option></option>").val("").html(""));
        for (var i=0; i < result.length; i++){
            var value = result[i].split('^');
            var len = value[0].length - 3;
            var space ="";
            for(var x=0; x < len; x++){
                space = space+"\xa0";
            }
            $("#hd_address_category").append($("<option></option>").val(value[0]).html(space+value[1]));
        }
    }
}

function populatePaymentMethod(){
    var qrySQL = "select was_id, payment_method from was_cs_payment_method";
    var result = SelectDB(qrySQL);
    $("#hd_payment_method").empty();
    if(result !== ""){
        result = result.split('~');
        $("#hd_payment_method").append($("<option></option>").val("").html(""));
        for (var i=0; i < result.length; i++){
            var value = result[i].split('^');
            var len = value[0].length - 3;
            var space ="";
            for(var x=0; x < len; x++){
                space = space+"\xa0";
            }
            $("#hd_payment_method").append($("<option></option>").val(value[0]).html(space+value[1]));
        }
    }
}

function populateShippingMethod(){
    var qrySQL = "select was_id, shipping_method from was_cs_shipping_method";
    var result = SelectDB(qrySQL);
    $("#hd_shipping_method").empty();
    if(result !== ""){
        result = result.split('~');
        $("#hd_shipping_method").append($("<option></option>").val("").html(""));
        for (var i=0; i < result.length; i++){
            var value = result[i].split('^');
            var len = value[0].length - 3;
            var space ="";
            for(var x=0; x < len; x++){
                space = space+"\xa0";
            }
            $("#hd_shipping_method").append($("<option></option>").val(value[0]).html(space+value[1]));
        }
    }
}

function populateGLPurchase(){
    var qrySQL = "select was_id, account_type from was_chart_of_account";
    var result = SelectDB(qrySQL);
    $("#hd_payable_gl").empty();
    if(result !== ""){
        var result1 = result.split('~');
        $("#hd_payable_gl").append($("<option></option>").val("").html(""));
        for (var i=0; i < result1.length; i++){
            var value = result1[i].split('^');
            var len = value[0].length - 3;
            var space ="";
            for(var x=0; x < len; x++){
                space = space+"\xa0";
            }
            $("#hd_payable_gl").append($("<option></option>").val(value[0]).html(space+value[1]));
        }
    }
    
    $("#hd_discount_gl").empty();
    if(result !== ""){
        var result1 = result.split('~');
        $("#hd_discount_gl").append($("<option></option>").val("").html(""));
        for (var i=0; i < result1.length; i++){
            var value = result1[i].split('^');
            var len = value[0].length - 3;
            var space ="";
            for(var x=0; x < len; x++){
                space = space+"\xa0";
            }
            $("#hd_discount_gl").append($("<option></option>").val(value[0]).html(space+value[1]));
        }
    }
    
    $("#hd_tax_gl").empty();
    if(result !== ""){
        var result1 = result.split('~');
        $("#hd_tax_gl").append($("<option></option>").val("").html(""));
        for (var i=0; i < result1.length; i++){
            var value = result1[i].split('^');
            var len = value[0].length - 3;
            var space ="";
            for(var x=0; x < len; x++){
                space = space+"\xa0";
            }
            $("#hd_tax_gl").append($("<option></option>").val(value[0]).html(space+value[1]));
        }
    }
    
    $("#hd_surcharge_gl").empty();
    if(result !== ""){
        var result1 = result.split('~');
        $("#hd_surcharge_gl").append($("<option></option>").val("").html(""));
        for (var i=0; i < result1.length; i++){
            var value = result1[i].split('^');
            var len = value[0].length - 3;
            var space ="";
            for(var x=0; x < len; x++){
                space = space+"\xa0";
            }
            $("#hd_surcharge_gl").append($("<option></option>").val(value[0]).html(space+value[1]));
        }
    }
}

function tab1(){
    SetStyle("footer_navigation","display","block");
}

function tab2(){
    ShowLoading();
    CancelAddress();
    SetStyle("footer_navigation","display","none");
    DisplayMode("hd_clear","DI");
    DisplayMode("hd_cancel","DI");
    populateCountry();
    populateAddressCategory();
    populateCity();
    DisplayAddressList();
    HideLoading();
}

function tab3(){
    ShowLoading();
    CancelPurchase();
    SetStyle("footer_navigation","display","none");
    populateGLPurchase();
    populateShippingMethod();
    populatePaymentMethod();
    DisplayPurchaseList();
    HideLoading();
}

function tab4(){
    SetStyle("footer_navigation","display","none");
    var strSelect = "select body.record_date, header.invoice_number, body.purchase_id, body.receive_id,  body.product_id, body.description, body.quantity from was_product_receive_header header, was_product_receive body"
                    + " where header.receive_id = body.receive_id and supplier_id='"+GetValue("supplier_id")+"' order by to_date(body.receive_id )";
    var result = SelectDB(strSelect);
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
        display = display + "<td style='padding:4px;' colspan='7'>No Records Found.</td>";
    }   
    SetValueInner("displayList","");
    SetValueInner("displayList",display);
}

//tab2
function NewAddress(){
    var fields = "address_category,contact_person,address_line_1,address_line_2,address_line_3,address_line_4,city,country,zip_code,email,telephone,mobile";
    fields = fields.split(',');
    for (var i=0; i < fields.length; i++){
        DisplayMode("hd_"+fields[i],"EN");
    }
    
    SetValue("hd_save","Save");
    SetValue("hd_AddressMode","new");
    document.getElementById("hd_save").onclick = function() { SaveAddress(); };
    DisplayMode("hd_clear","EN");
    DisplayMode("hd_cancel","EN");
}

function SaveAddress(){
   var requiredFields = "address_category,contact_person,address_line_1,city,country,zip_code,email,telephone,mobile";
    requiredFields = requiredFields.split(',');
    var checkrequiredFields = 0;
    for(x = 0; x < requiredFields.length; x++){
        var fieldID = "#hd_"+requiredFields[x].trim();
        if($(fieldID).val() === ""){
            document.getElementById("lb_hd_"+requiredFields[x].trim()).style.color ="red";
            checkrequiredFields = 1;
        } else {
            document.getElementById("lb_hd_"+requiredFields[x].trim()).style.color ="black";
        }
    }

    if(checkrequiredFields ===1){
        alert("Please input the required fields");
        return;  
    }
    
    if(GetValue("hd_AddressMode") === "new"){
        var qryInsert = "insert into was_supplier_address (supplier_id,address_category,contact_person,address_line_1,address_line_2,address_line_3,address_line_4,city,country,zip_code,email,telephone,mobile,record_date)"+
                                " values('"+GetValue("supplier_id")+"','"+GetValue("hd_address_category")+"','"+GetValue("hd_contact_person")+"','"+GetValue("hd_address_line_1")+"','"+GetValue("hd_address_line_2")+"','"+GetValue("hd_address_line_3")+"','"+GetValue("hd_address_line_4")+"','"+GetValue("hd_city")+"','"+GetValue("hd_country")+"','"+GetValue("hd_zip_code")+"','"+GetValue("hd_email")+"','"+GetValue("hd_telephone")+"','"+GetValue("hd_mobile")+"','"+getServerSession("record_date")+"')";
        var result = InsertDB(qryInsert);
    } else if(GetValue("hd_AddressMode") === "edit"){
        var qryUpdate = "update was_supplier_address set address_category = '"+GetValue("hd_address_category")+"', contact_person = '"+GetValue("hd_contact_person")+"', address_line_1 = '"+GetValue("hd_address_line_1")+"', address_line_2 = '"+GetValue("hd_address_line_2")+"', address_line_3 = '"+GetValue("hd_address_line_3")+"', address_line_4 = '"+GetValue("hd_address_line_4")+"',\n\
                        city = '"+GetValue("hd_city")+"', country = '"+GetValue("hd_country")+"', zip_code = '"+GetValue("hd_zip_code")+"', email = '"+GetValue("hd_email")+"', telephone = '"+GetValue("hd_telephone")+"', mobile = '"+GetValue("hd_mobile")+"'\n\
                        where supplier_address_id = '"+GetValue("hd_AddressID")+"'"; 
        var result = UpdateDB(qryUpdate);
    }
    
    if(result !== ""){
        alert("Record update successfully.");
        CancelAddress();
        DisplayAddressList();
    } else {
        alert("Error occur while updating record.");
    }
}

function ClearAddress(){
    var fields = "address_category,contact_person,address_line_1,address_line_2,address_line_3,address_line_4,city,country,zip_code,email,telephone,mobile";
    fields = fields.split(',');
    for (var i=0; i < fields.length; i++){
        SetValue("hd_"+fields[i],"");
    }
}

function CancelAddress(){
    var fields = "address_category,contact_person,address_line_1,address_line_2,address_line_3,address_line_4,city,country,zip_code,email,telephone,mobile";
    fields = fields.split(',');
    for (var i=0; i < fields.length; i++){
        DisplayMode("hd_"+fields[i],"DI");
        SetStyle("lb_hd_"+fields[i],"color","black");
    }
    
    ClearAddress();
    DisplayMode("hd_clear","DI");
    DisplayMode("hd_cancel","DI");
    SetValue("hd_save","New");
    document.getElementById("hd_save").onclick = function() { NewAddress(); };
    SetValue("hd_AddressMode","");
}

function EditSupplierAddress(id){
    if(GetValue("hd_AddressMode") === "new"){
        alert("Edit is not allowed.");
        return;
    } else {
        var qrySelect ="select address_category,contact_person,address_line_1,address_line_2,address_line_3,address_line_4,city,country,zip_code,email,telephone,mobile from was_supplier_address"
            + " where supplier_address_id = '"+id+"'";
        var result = SelectDB(qrySelect);
        var value = result.split('^');
        SetValue("hd_address_category", value[0]);
        SetValue("hd_contact_person", value[1]);
        SetValue("hd_address_line_1", value[2]);
        SetValue("hd_address_line_2", value[3]);
        SetValue("hd_address_line_3", value[4]);
        SetValue("hd_address_line_4", value[5]);
        SetValue("hd_city", value[6]);
        SetValue("hd_country", value[7]);
        SetValue("hd_zip_code", value[8]);
        SetValue("hd_email", value[9]);
        SetValue("hd_telephone", value[10]);
        SetValue("hd_mobile", value[11]);
        
        SetValue("hd_AddressID",id);
        SetValue("hd_save","Save");
        document.getElementById("hd_save").onclick = function() { SaveAddress(); };
        DisplayMode("hd_clear","EN");
        DisplayMode("hd_cancel","EN");
        SetValue("hd_AddressMode","edit");
        var fields = "address_category,contact_person,address_line_1,address_line_2,address_line_3,address_line_4,city,country,zip_code,email,telephone,mobile";
        fields = fields.split(',');
        for (var i=0; i < fields.length; i++){
            DisplayMode("hd_"+fields[i],"EN");
        }
    }
}

function ViewSupplierAddress(id){
    if(GetValue("hd_AddressMode") === "new" || GetValue("hd_AddressMode") === "edit"){
        alert("View is not allowed.");
        return;
    } else {
        ShowLoading();
        var qrySelect ="select address_category,contact_person,address_line_1,address_line_2,address_line_3,address_line_4,city,country,zip_code,email,telephone,mobile from was_supplier_address"
            + " where supplier_address_id = '"+id+"'";
        var result = SelectDB(qrySelect);
        var value = result.split('^');
        SetValue("hd_address_category", value[0]);
        SetValue("hd_contact_person", value[1]);
        SetValue("hd_address_line_1", value[2]);
        SetValue("hd_address_line_2", value[3]);
        SetValue("hd_address_line_3", value[4]);
        SetValue("hd_address_line_4", value[5]);
        SetValue("hd_city", value[6]);
        SetValue("hd_country", value[7]);
        SetValue("hd_zip_code", value[8]);
        SetValue("hd_email", value[9]);
        SetValue("hd_telephone", value[10]);
        SetValue("hd_mobile", value[11]);
        HideLoading();
    }
}

function DeleteSupplierAddress(id){
    var qryDelete = "delete from was_supplier_address where supplier_address_id = '"+id+"'";
    var result = UpdateDB(qryDelete);
    
    if(result == 1){
        alert("Delete record successfully.");
        DisplayAddressList();
    } else {
        alert("Error occur while deleting record.");
    }
}

function DisplayAddressList(){
    var qrySelect = "select supplier_address_id, cat.address_category, contact_person, email, telephone, mobile from was_supplier_address addr, was_cs_address_category cat"
                    + " where addr.address_category = cat.was_id and supplier_id ='"+GetValue("supplier_id")+"'";
    var result = SelectDB(qrySelect);
    result = result.split('~');
    var display = "";
    if(result != ""){
        for (var i=0; i < result.length; i++){
            display = display + "<tr>";
            var value = result[i].split('^');

                display = display + "<td style='padding:4px;'>" + value[1] + "</td>";
                display = display + "<td style='padding:4px;'>" + value[2] + "</td>";
                display = display + "<td style='padding:4px;'>" + value[3] + "</td>";
                display = display + "<td style='padding:4px;'>" + value[4] + "/" + value[5] +"</td>";
            display = display + '<td style="text-align:center"><a oncontextmenu="return false;" href="#" class="action" id="view" onclick="EditSupplierAddress(\''+value[0]+'\')" >Edit</a> &nbsp;&nbsp;&nbsp;<a oncontextmenu="return false;" href="#" class="action" id="view" onclick="ViewSupplierAddress(\''+value[0]+'\')" >View</a> &nbsp;&nbsp;&nbsp; <a oncontextmenu="return false;" href="#" class="action" id="view" onclick="DeleteSupplierAddress(\''+value[0]+'\')" >Delete</a> </td>';
            display = display + "</tr>";
        }
    }
    SetValueInner("displayListAddress","");
    SetValueInner("displayListAddress",display);
}

//tab3
function NewPurchase(){
    var fields = "shipping_method,payment_method,net_due,discount,percentage,credit_limit,payable_gl,discount_gl,tax_gl,surcharge_gl";
    fields = fields.split(',');
    for (var i=0; i < fields.length; i++){
        DisplayMode("hd_"+fields[i],"EN");
    }
    
    SetValue("hd_savePurchase","Save");
    SetValue("hd_PurchaseMode","new");
    document.getElementById("hd_savePurchase").onclick = function() { SavePurchase(); };
    DisplayMode("hd_clearPurchase","EN");
    DisplayMode("hd_cancelPurchase","EN");
}

function ClearPurchase(){
    var fields = "shipping_method,payment_method,net_due,discount,percentage,credit_limit,payable_gl,discount_gl,tax_gl,surcharge_gl";
    fields = fields.split(',');
    for (var i=0; i < fields.length; i++){
        SetValue("hd_"+fields[i],"");
    }
}

function CancelPurchase(){
    var fields = "shipping_method,payment_method,net_due,discount,percentage,credit_limit,payable_gl,discount_gl,tax_gl,surcharge_gl";
    fields = fields.split(',');
    for (var i=0; i < fields.length; i++){
        DisplayMode("hd_"+fields[i],"DI");
        SetStyle("lb_hd_"+fields[i],"color","black");
    }
    
    ClearPurchase();
    DisplayMode("hd_clearPurchase","DI");
    DisplayMode("hd_cancelPurchase","DI");
    SetValue("hd_savePurchase","New");
    document.getElementById("hd_savePurchase").onclick = function() { NewPurchase(); };
    SetValue("hd_PurchaseMode","");
}

function SavePurchase(){
   var requiredFields = "shipping_method,payment_method,net_due,discount,percentage,credit_limit,payable_gl,discount_gl,tax_gl,surcharge_gl";
    requiredFields = requiredFields.split(',');
    var checkrequiredFields = 0;
    for(x = 0; x < requiredFields.length; x++){
        var fieldID = "#hd_"+requiredFields[x].trim();
        if($(fieldID).val() === ""){
            document.getElementById("lb_hd_"+requiredFields[x].trim()).style.color ="red";
            checkrequiredFields = 1;
        } else {
            document.getElementById("lb_hd_"+requiredFields[x].trim()).style.color ="black";
        }
    }

    if(checkrequiredFields ===1){
        alert("Please input the required fields");
        return;  
    }
    ShowLoading();
    if(GetValue("hd_PurchaseMode") === "new"){
        var qryInsert = "insert into was_supplier_purchase (supplier_id,shipping_method,payment_method,net_due,discount,percentage,credit_limit,payable_gl,discount_gl,tax_gl,surcharge_gl,record_date)"+
                                " values('"+GetValue("supplier_id")+"','"+GetValue("hd_shipping_method")+"','"+GetValue("hd_payment_method")+"','"+GetValue("hd_net_due")+"','"+GetValue("hd_discount")+"','"+GetValue("hd_percentage")+"','"+GetValue("hd_credit_limit")+"','"+GetValue("hd_payable_gl")+"','"+GetValue("hd_discount_gl")+"','"+GetValue("hd_tax_gl")+"','"+GetValue("hd_surcharge_gl")+"','"+getServerSession("record_date")+"')";
        var result = InsertDB(qryInsert);
    } else if(GetValue("hd_PurchaseMode") === "edit"){
        var qryUpdate = "update was_supplier_purchase set shipping_method = '"+GetValue("hd_shipping_method")+"', payment_method = '"+GetValue("hd_payment_method")+"', net_due = '"+GetValue("hd_net_due")+"', discount = '"+GetValue("hd_discount")+"', percentage = '"+GetValue("hd_percentage")+"', credit_limit = '"+GetValue("hd_credit_limit")+"',\n\
                        payable_gl = '"+GetValue("hd_payable_gl")+"', discount_gl = '"+GetValue("hd_discount_gl")+"', tax_gl = '"+GetValue("hd_tax_gl")+"', surcharge_gl = '"+GetValue("hd_surcharge_gl")+"'\n\
                        where supplier_purchase_id = '"+GetValue("hd_PurchaseID")+"'"; 
        var result = UpdateDB(qryUpdate);
    }
    
    if(result !== ""){
        alert("Record update successfully.");
        CancelPurchase();
        DisplayPurchaseList();
    } else {
        alert("Error occur while updating record.");
    }
    HideLoading();
}

function DisplayPurchaseList(){
    var qrySelect = "select purch.supplier_purchase_id, ship.shipping_method, pay.payment_method from was_supplier_purchase purch, was_cs_shipping_method ship, was_cs_payment_method pay"
                    + " where purch.shipping_method = ship.was_id and purch.payment_method = pay.was_id and supplier_id ='"+GetValue("supplier_id")+"'";
    var result = SelectDB(qrySelect);
    result = result.split('~');
    var display = "";
    if(result != ""){
        for (var i=0; i < result.length; i++){
            display = display + "<tr>";
            var value = result[i].split('^');
                display = display + "<td style='padding:4px;'>" + value[1] + "</td>";
                display = display + "<td style='padding:4px;'>" + value[2] + "</td>";
            display = display + '<td style="text-align:center"><a oncontextmenu="return false;" href="#" class="action" id="view" onclick="EditSupplierPurchase(\''+value[0]+'\')" >Edit</a> &nbsp;&nbsp;&nbsp;<a oncontextmenu="return false;" href="#" class="action" id="view" onclick="ViewSupplierPurchase(\''+value[0]+'\')" >View</a> &nbsp;&nbsp;&nbsp; <a oncontextmenu="return false;" href="#" class="action" id="view" onclick="DeleteSupplierPurchase(\''+value[0]+'\')" >Delete</a> </td>';
            display = display + "</tr>";
        }
    }
    SetValueInner("displayListPurchase","");
    SetValueInner("displayListPurchase",display);
}

function EditSupplierPurchase(id){
    if(GetValue("hd_PurchaseMode") === "new"){
        alert("Edit is not allowed.");
        return;
    } else {
        var qrySelect ="select shipping_method,payment_method,net_due,discount,percentage,credit_limit,payable_gl,discount_gl,tax_gl,surcharge_gl from was_supplier_purchase"
            + " where supplier_purchase_id = '"+id+"'";
        var result = SelectDB(qrySelect);
        var value = result.split('^');
        SetValue("hd_shipping_method", value[0]);
        SetValue("hd_payment_method", value[1]);
        SetValue("hd_net_due", value[2]);
        SetValue("hd_discount", value[3]);
        SetValue("hd_percentage", value[4]);
        SetValue("hd_credit_limit", value[5]);
        SetValue("hd_payable_gl", value[6]);
        SetValue("hd_discount_gl", value[7]);
        SetValue("hd_tax_gl", value[8]);
        SetValue("hd_surcharge_gl", value[9]);
        
        SetValue("hd_PurchaseID",id);
        SetValue("hd_savePurchase","Save");
        document.getElementById("hd_savePurchase").onclick = function() { SavePurchase(); };
        DisplayMode("hd_clearPurchase","EN");
        DisplayMode("hd_cancelPurchase","EN");
        SetValue("hd_PurchaseMode","edit");
        var fields = "shipping_method,payment_method,net_due,discount,percentage,credit_limit,payable_gl,discount_gl,tax_gl,surcharge_gl";
        fields = fields.split(',');
        for (var i=0; i < fields.length; i++){
            DisplayMode("hd_"+fields[i],"EN");
        }
    }
}

function ViewSupplierPurchase(id){
    if(GetValue("hd_PurchaseMode") === "new" || GetValue("hd_PurchaseMode") === "edit"){
        alert("View is not allowed.");
        return;
    } else {
        ShowLoading();
        var qrySelect ="select shipping_method,payment_method,net_due,discount,percentage,credit_limit,payable_gl,discount_gl,tax_gl,surcharge_gl from was_supplier_purchase"
            + " where supplier_purchase_id = '"+id+"'";
        var result = SelectDB(qrySelect);
        var value = result.split('^');
        SetValue("hd_shipping_method", value[0]);
        SetValue("hd_payment_method", value[1]);
        SetValue("hd_net_due", value[2]);
        SetValue("hd_discount", value[3]);
        SetValue("hd_percentage", value[4]);
        SetValue("hd_credit_limit", value[5]);
        SetValue("hd_payable_gl", value[6]);
        SetValue("hd_discount_gl", value[7]);
        SetValue("hd_tax_gl", value[8]);
        SetValue("hd_surcharge_gl", value[9]);
        HideLoading();
    }
}

function DeleteSupplierPurchase(id){
    var qryDelete = "delete from was_supplier_purchase where supplier_purchase_id = '"+id+"'";
    var result = UpdateDB(qryDelete);
    
    if(result == 1){
        alert("Delete record successfully.");
        DisplayPurchaseList();
    } else {
        alert("Error occur while deleting record.");
    }
}

function Select(){
    parent.window.opener.GetChildValueSuppier(GetValue("supplier_id"));
    window.close();
    return false;
}
</script>