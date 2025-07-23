<script>
/*Required functions. onPageLoad, onAddNewUpdate, onAmendUpdate, onAddNew, onAmend, OnDelete, onCancelAddNew, onCancelAmend*/
function  onPageLoad(){
    ShowLoading();
    $( "#tabs" ).tabs();
    $( "#tabs" ).tabs( "option", "active", 0 );
    SetStyle("footer_navigation","display","block");
    $( "#tabs" ).tabs( "disable", 3 );
    var qrySelect = "select count(*) count from was_customer_account where customer_id ='"+GetValue("customer_id")+"'";
    var result = SelectDB(qrySelect);
    if(parseInt(result) > 0){
        $( "#tabs" ).tabs( "enable", 3 );
    }
    HideLoading();
}   

/*populate the ComboSelect*/
function loadComboSelect(){
    populateGender();
    populateTariff();
    populateCustomerType();
}

/* onAddNewUpdate */
function onAddNewUpdate(){
    if(GetValue("customer_id") === ""){
        SetValue("customer_id", GetCounter("006","10"));
    }
}

/* onAmendUpdate */
function onAmendUpdate(){
    
}

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
    var qryDelete = "delete from was_customer_contact where customer_id='"+GetValue("customer_id")+"'";
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

function populateGender(){
    var qrySQL = "SELECT was_id, gender FROM was_cs_gender";
    var result = SelectDB(qrySQL);
    if(result !== ""){
        result = result.split('~');
        $("#gender").empty();
        $("#gender").append($("<option></option>").val("").html(""));
        for (var i=0; i < result.length; i++){
            var value = result[i].split('^');
            $("#gender").append($("<option></option>").val(value[0]).html(value[1]));
        }
    }
}

function populateTariff(){
    var qrySQL = "SELECT was_id, tariff FROM was_cs_tariff";
    var result = SelectDB(qrySQL);
    if(result !== ""){
        result = result.split('~');
        $("#tariff").empty();
        $("#tariff").append($("<option></option>").val("").html(""));
        for (var i=0; i < result.length; i++){
            var value = result[i].split('^');
            $("#tariff").append($("<option></option>").val(value[0]).html(value[1]));
        }
    }
}

function populateCustomerType(){
    var qrySQL = "SELECT was_id, customer_type FROM was_cs_customer_type";
    var result = SelectDB(qrySQL);
    if(result !== ""){
        result = result.split('~');
        $("#customer_type").empty();
        $("#customer_type").append($("<option></option>").val("").html(""));
        for (var i=0; i < result.length; i++){
            var value = result[i].split('^');
            $("#customer_type").append($("<option></option>").val(value[0]).html(value[1]));
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

function populateGLSale(){
    var qrySQL = "select was_id, account_type from was_chart_of_account";
    var result = SelectDB(qrySQL);
    $("#hd_receivable_gl").empty();
    if(result !== ""){
        var result1 = result.split('~');
        $("#hd_receivable_gl").append($("<option></option>").val("").html(""));
        for (var i=0; i < result1.length; i++){
            var value = result1[i].split('^');
            var len = value[0].length - 3;
            var space ="";
            for(var x=0; x < len; x++){
                space = space+"\xa0";
            }
            $("#hd_receivable_gl").append($("<option></option>").val(value[0]).html(space+value[1]));
        }
    }
    
    $("#hd_revenue_gl").empty();
    if(result !== ""){
        var result1 = result.split('~');
        $("#hd_revenue_gl").append($("<option></option>").val("").html(""));
        for (var i=0; i < result1.length; i++){
            var value = result1[i].split('^');
            var len = value[0].length - 3;
            var space ="";
            for(var x=0; x < len; x++){
                space = space+"\xa0";
            }
            $("#hd_revenue_gl").append($("<option></option>").val(value[0]).html(space+value[1]));
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
    
    $("#hd_payment_gl").empty();
    if(result !== ""){
        var result1 = result.split('~');
        $("#hd_payment_gl").append($("<option></option>").val("").html(""));
        for (var i=0; i < result1.length; i++){
            var value = result1[i].split('^');
            var len = value[0].length - 3;
            var space ="";
            for(var x=0; x < len; x++){
                space = space+"\xa0";
            }
            $("#hd_payment_gl").append($("<option></option>").val(value[0]).html(space+value[1]));
        }
    }
}

function tab1(){
    SetStyle("footer_navigation","display","block");
}

function tab2(){
    ShowLoading();
    CancelContact();
    SetStyle("footer_navigation","display","none");
    DisplayMode("hd_clear","DI");
    DisplayMode("hd_cancel","DI");
    populateCountry();
    populateAddressCategory();
    populateCity();
    DisplayContactList();
    HideLoading();
}

function tab3(){
    ShowLoading();
    CancelSaleTab();
    populateGLSale();
    populateShippingMethod();
    populatePaymentMethod();
    DisplaySaleTabList();
    SetStyle("footer_navigation","display","none");
    HideLoading();
}

function tab4(){
    ShowLoading();
    SetStyle("footer_navigation","display","none");
    LoadTransactionDetails();
    HideLoading();
}

//tab2
function NewContact(){
    var fields = "address_category,contact_person,address_line_1,address_line_2,address_line_3,address_line_4,city,country,zip_code,email,telephone,fax,mobile";
    fields = fields.split(',');
    for (var i=0; i < fields.length; i++){
        DisplayMode("hd_"+fields[i],"EN");
        SetValue("hd_"+fields[i],"");
    }
    
    SetValue("hd_save","Save");
    SetValue("hd_ContactMode","new");
    document.getElementById("hd_save").onclick = function() { SaveContact(); };
    DisplayMode("hd_clear","EN");
    DisplayMode("hd_cancel","EN");
}

function SaveContact(){
   var requiredFields = "address_category,contact_person,address_line_1,city,country,zip_code,email,telephone,mobile,fax";
    requiredFields = requiredFields.split(',');
    var checkrequiredFields = 0;
    for(x = 0; x < requiredFields.length; x++){
        var fieldID = "#hd_"+requiredFields[x].trim();
        if($(fieldID).val() === ""){
            document.getElementById("lb_hd_"+requiredFields[x].trim()).style.color ="red";
            checkrequiredFields = 1;
        } else {
            document.getElementById("lb_hd_"+requiredFields[x].trim()).style.color ="#black";
        }
    }

    if(checkrequiredFields ===1){
        alert("Please input the required fields");
        return;  
    }
    
    if(GetValue("hd_ContactMode") === "new"){
        var qryInsert = "insert into was_customer_contact (customer_id,address_category,contact_person,address_line_1,address_line_2,address_line_3,address_line_4,city,country,zip_code,email,telephone,mobile,fax,record_date)"+
                                " values('"+GetValue("customer_id")+"','"+GetValue("hd_address_category")+"','"+GetValue("hd_contact_person")+"','"+GetValue("hd_address_line_1")+"','"+GetValue("hd_address_line_2")+"','"+GetValue("hd_address_line_3")+"','"+GetValue("hd_address_line_4")+"','"+GetValue("hd_city")+"','"+GetValue("hd_country")+"','"+GetValue("hd_zip_code")+"','"+GetValue("hd_email")+"','"+GetValue("hd_telephone")+"','"+GetValue("hd_mobile")+"','"+GetValue("hd_fax")+"','"+getServerSession("record_date")+"')";
        var result = InsertDB(qryInsert);
    } else if(GetValue("hd_ContactMode") === "edit"){
        var qryUpdate = "update was_customer_contact set address_category = '"+GetValue("hd_address_category")+"', contact_person = '"+GetValue("hd_contact_person")+"', address_line_1 = '"+GetValue("hd_address_line_1")+"', address_line_2 = '"+GetValue("hd_address_line_2")+"', address_line_3 = '"+GetValue("hd_address_line_3")+"', address_line_4 = '"+GetValue("hd_address_line_4")+"',\n\
                        city = '"+GetValue("hd_city")+"', country = '"+GetValue("hd_country")+"', zip_code = '"+GetValue("hd_zip_code")+"', email = '"+GetValue("hd_email")+"', telephone = '"+GetValue("hd_telephone")+"', mobile = '"+GetValue("hd_mobile")+"', fax = '"+GetValue("hd_fax")+"'\n\
                        where customer_contact_id = '"+GetValue("hd_ContactID")+"'"; 
        var result = UpdateDB(qryUpdate);
    }
    if(result !== ""){
        alert("Record update successfully.");
        CancelContact();
        DisplayContactList();
    } else {
        alert("Error occur while updating record.");
    }
}

function ClearContact(){
    var fields = "address_category,contact_person,address_line_1,address_line_2,address_line_3,address_line_4,city,country,zip_code,email,telephone,fax,mobile";
    fields = fields.split(',');
    for (var i=0; i < fields.length; i++){
        SetValue("hd_"+fields[i],"");
    }
}

function CancelContact(){
    var fields = "address_category,contact_person,address_line_1,address_line_2,address_line_3,address_line_4,city,country,zip_code,email,telephone,fax,mobile";
    fields = fields.split(',');
    for (var i=0; i < fields.length; i++){
        DisplayMode("hd_"+fields[i],"DI");
        SetStyle("lb_hd_"+fields[i],"color","#black");
    }
    
    ClearContact();
    DisplayMode("hd_clear","DI");
    DisplayMode("hd_cancel","DI");
    SetValue("hd_save","New");
    document.getElementById("hd_save").onclick = function() { NewContact(); };
    SetValue("hd_ContactMode","");
}

function DisplayContactList(){
    var qrySelect = "select customer_contact_id, cat.address_category, contact_person, email, telephone, mobile from was_customer_contact contact, was_cs_address_category cat"
                    + " where contact.address_category = cat.was_id and customer_id ='"+GetValue("customer_id")+"'";
            
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
            display = display + '<td style="text-align:center"><a oncontextmenu="return false;" href="#" class="action" id="view" onclick="EditCustomerContact(\''+value[0]+'\')" >Edit</a> &nbsp;&nbsp;&nbsp;<a oncontextmenu="return false;" href="#" class="action" id="view" onclick="ViewCustomerContact(\''+value[0]+'\')" >View</a> &nbsp;&nbsp;&nbsp; <a oncontextmenu="return false;" href="#" class="action" id="view" onclick="DeleteCustomerContact(\''+value[0]+'\')" >Delete</a> </td>';
            display = display + "</tr>";
        }
    }
    SetValueInner("displayListContact","");
    SetValueInner("displayListContact",display);
}

function EditCustomerContact(id){
    if(GetValue("hd_ContactMode") === "new"){
        alert("Edit is not allowed.");
        return;
    } else {
        var qrySelect ="select address_category,contact_person,address_line_1,address_line_2,address_line_3,address_line_4,city,country,zip_code,email,telephone,mobile,fax from was_customer_contact"
            + " where customer_contact_id = '"+id+"'";
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
        SetValue("hd_fax", value[12]);
        
        SetValue("hd_ContactID",id);
        SetValue("hd_save","Save");
        document.getElementById("hd_save").onclick = function() { SaveContact(); };
        DisplayMode("hd_clear","EN");
        DisplayMode("hd_cancel","EN");
        SetValue("hd_ContactMode","edit");
        var fields = "address_category,contact_person,address_line_1,address_line_2,address_line_3,address_line_4,city,country,zip_code,email,telephone,mobile,fax";
        fields = fields.split(',');
        for (var i=0; i < fields.length; i++){
            DisplayMode("hd_"+fields[i],"EN");
        }
    }
}

function ViewCustomerContact(id){
    if(GetValue("hd_ContactMode") === "new" || GetValue("hd_ContactMode") === "edit"){
        alert("View is not allowed.");
        return;
    } else {
        ShowLoading();
        var qrySelect ="select address_category,contact_person,address_line_1,address_line_2,address_line_3,address_line_4,city,country,zip_code,email,telephone,mobile,fax from was_customer_contact"
            + " where customer_contact_id = '"+id+"'";
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
        SetValue("hd_fax", value[12]);
        HideLoading();
    }
}

function DeleteCustomerContact(id){
    var qryDelete = "delete from was_customer_contact where customer_contact_id = '"+id+"'";
    var result = UpdateDB(qryDelete);
    
    if(result == 1){
        alert("Delete record successfully.");
        DisplayContactList();
    } else {
        alert("Error occur while deleting record.");
    }
}

//tab3
function NewSaleTab(){
    var fields = "shipping_method,payment_method,sales_representative,payment_terms,card_number,cardholder_name,expiry_date,billing_address,net_due,discount,percentage,credit_limit,credit_status,receivable_gl,revenue_gl,discount_gl,tax_gl,surcharge_gl,payment_gl";
    fields = fields.split(',');
    for (var i=0; i < fields.length; i++){
        DisplayMode("hd_"+fields[i],"EN");
        SetValue("hd_"+fields[i],"");
    }
    
    SetValue("hd_saveSaleTab","Save");
    SetValue("hd_SaleTabMode","new");
    document.getElementById("hd_saveSaleTab").onclick = function() { SaveSaleTab(); };
    DisplayMode("hd_clearSaleTab","EN");
    DisplayMode("hd_cancelSaleTab","EN");
}

function SaveSaleTab(){
   var requiredFields = "shipping_method,payment_method,sales_representative,payment_terms,card_number,cardholder_name,expiry_date,billing_address,net_due,discount,percentage,credit_limit,credit_status,receivable_gl,revenue_gl,discount_gl,tax_gl,surcharge_gl,payment_gl";
    requiredFields = requiredFields.split(',');
    var checkrequiredFields = 0;
    for(x = 0; x < requiredFields.length; x++){
        var fieldID = "#hd_"+requiredFields[x].trim();
        if($(fieldID).val() === ""){
            document.getElementById("lb_hd_"+requiredFields[x].trim()).style.color ="red";
            checkrequiredFields = 1;
        } else {
            document.getElementById("lb_hd_"+requiredFields[x].trim()).style.color ="#black";
        }
    }

    if(checkrequiredFields ===1){
        alert("Please input the required fields");
        return;  
    }
    ShowLoading();
    if(GetValue("hd_SaleTabMode") === "new"){
        var qryInsert = "insert into was_customer_sale (customer_id,shipping_method,payment_method,sales_representative,payment_terms,card_number,cardholder_name,expiry_date,billing_address,net_due,discount,percentage,credit_limit,credit_status,receivable_gl,revenue_gl,discount_gl,tax_gl,surcharge_gl,payment_gl,record_date)"+
                                " values('"+GetValue("customer_id")+"','"+GetValue("hd_shipping_method")+"','"+GetValue("hd_payment_method")+"','"+GetValue("hd_sales_representative")+"','"+GetValue("hd_payment_terms")+"','"+GetValue("hd_card_number")+"','"+GetValue("hd_cardholder_name")+"','"+GetValue("hd_expiry_date")+"','"+GetValue("hd_billing_address")+"','"+GetValue("hd_net_due")+"','"+GetValue("hd_discount")+"','"+GetValue("hd_percentage")+"','"+GetValue("hd_credit_limit")+"','"+GetValue("hd_credit_status")+"','"+GetValue("hd_receivable_gl")+"','"+GetValue("hd_revenue_gl")+"','"+GetValue("hd_discount_gl")+"','"+GetValue("hd_tax_gl")+"','"+GetValue("hd_surcharge_gl")+"','"+GetValue("hd_payment_gl")+"','"+getServerSession("record_date")+"')";
        var result = InsertDB(qryInsert);
    } else if(GetValue("hd_SaleTabMode") === "edit"){
        var qryUpdate = "update was_customer_sale set shipping_method = '"+GetValue("hd_shipping_method")+"', payment_method = '"+GetValue("hd_payment_method")+"', sales_representative = '"+GetValue("hd_sales_representative")+"', payment_terms = '"+GetValue("hd_payment_terms")+"', card_number = '"+GetValue("hd_card_number")+"', cardholder_name = '"+GetValue("hd_cardholder_name")+"',\n\
                        expiry_date = '"+GetValue("hd_expiry_date")+"', billing_address = '"+GetValue("hd_billing_address")+"', net_due = '"+GetValue("hd_net_due")+"', discount = '"+GetValue("hd_discount")+"', percentage = '"+GetValue("hd_percentage")+"', credit_limit = '"+GetValue("hd_credit_limit")+"', credit_status = '"+GetValue("hd_credit_status")+"',\n\
                        receivable_gl = '"+GetValue("hd_receivable_gl")+"', revenue_gl = '"+GetValue("hd_revenue_gl")+"', discount_gl = '"+GetValue("hd_discount_gl")+"', tax_gl = '"+GetValue("hd_tax_gl")+"', surcharge_gl = '"+GetValue("hd_surcharge_gl")+"', payment_gl = '"+GetValue("hd_payment_gl")+"'\n\
                        where customer_sale_id = '"+GetValue("hd_SaleTabID")+"'"; 
        var result = UpdateDB(qryUpdate);
    }
    
    if(result !== ""){
        alert("Record update successfully.");
        CancelSaleTab();
        DisplaySaleTabList();
    } else {
        alert("Error occur while updating record.");
    }
    HideLoading();
}

function ClearSaleTab(){
    var fields = "shipping_method,payment_method,sales_representative,payment_terms,card_number,cardholder_name,expiry_date,billing_address,net_due,discount,percentage,credit_limit,credit_status,receivable_gl,revenue_gl,discount_gl,tax_gl,surcharge_gl,payment_gl";
    fields = fields.split(',');
    for (var i=0; i < fields.length; i++){
        SetValue("hd_"+fields[i],"");
    }
}

function CancelSaleTab(){
    var fields = "shipping_method,payment_method,sales_representative,payment_terms,card_number,cardholder_name,expiry_date,billing_address,net_due,discount,percentage,credit_limit,credit_status,receivable_gl,revenue_gl,discount_gl,tax_gl,surcharge_gl,payment_gl";
    fields = fields.split(',');
    for (var i=0; i < fields.length; i++){
        DisplayMode("hd_"+fields[i],"DI");
        SetStyle("lb_hd_"+fields[i],"color","#black");
    }
    
    ClearSaleTab();
    DisplayMode("hd_clearSaleTab","DI");
    DisplayMode("hd_cancelSaleTab","DI");
    SetValue("hd_saveSaleTab","New");
    document.getElementById("hd_saveSaleTab").onclick = function() { NewSaleTab(); };
    SetValue("hd_SaleTabMode","");
}

function DisplaySaleTabList(){
    var qrySelect = "select sale.customer_sale_id, ship.shipping_method, pay.payment_method, sales_representative from was_customer_sale sale, was_cs_shipping_method ship, was_cs_payment_method pay"
                    + " where sale.shipping_method = ship.was_id and sale.payment_method = pay.was_id and customer_id ='"+GetValue("customer_id")+"'";
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
            display = display + '<td style="text-align:center"><a oncontextmenu="return false;" href="#" class="action" id="view" onclick="EditCustomerSaleTab(\''+value[0]+'\')" >Edit</a> &nbsp;&nbsp;&nbsp;<a oncontextmenu="return false;" href="#" class="action" id="view" onclick="ViewCustomerSaleTab(\''+value[0]+'\')" >View</a> &nbsp;&nbsp;&nbsp; <a oncontextmenu="return false;" href="#" class="action" id="view" onclick="DeleteCustomerSaleTab(\''+value[0]+'\')" >Delete</a> </td>';
            display = display + "</tr>";
        }
    }
    SetValueInner("displayListSale","");
    SetValueInner("displayListSale",display);
}

function EditCustomerSaleTab(id){
    if(GetValue("hd_SaleTabMode") === "new"){
        alert("Edit is not allowed.");
        return;
    } else {
        ShowLoading();
        var qrySelect ="select shipping_method,payment_method,sales_representative,payment_terms,card_number,cardholder_name,expiry_date,billing_address,net_due,discount,percentage,credit_limit,credit_status,receivable_gl,revenue_gl,discount_gl,tax_gl,surcharge_gl,payment_gl from was_customer_sale"
            + " where customer_sale_id = '"+id+"'";
        var result = SelectDB(qrySelect);
        var value = result.split('^');
        var fields = "shipping_method,payment_method,sales_representative,payment_terms,card_number,cardholder_name,expiry_date,billing_address,net_due,discount,percentage,credit_limit,credit_status,receivable_gl,revenue_gl,discount_gl,tax_gl,surcharge_gl,payment_gl";
        fields = fields.split(',');
        for (var i=0; i < fields.length; i++){
            DisplayMode("hd_"+fields[i],"EN");
            SetValue("hd_"+fields[i],value[i]);
        }
        
        SetValue("hd_SaleTabID",id);
        SetValue("hd_saveSaleTab","Save");
        document.getElementById("hd_saveSaleTab").onclick = function() { SaveSaleTab(); };
        DisplayMode("hd_clearSaleTab","EN");
        DisplayMode("hd_cancelSaleTab","EN");
        SetValue("hd_SaleTabMode","edit");
        HideLoading();
    }
}

function ViewCustomerSaleTab(id){
    if(GetValue("hd_SaleTabMode") === "new" || GetValue("hd_SaleTabMode") === "edit"){
        alert("View is not allowed.");
        return;
    } else {
        ShowLoading();
        var qrySelect ="select shipping_method,payment_method,sales_representative,payment_terms,card_number,cardholder_name,expiry_date,billing_address,net_due,discount,percentage,credit_limit,credit_status,receivable_gl,revenue_gl,discount_gl,tax_gl,surcharge_gl,payment_gl from was_customer_sale"
            + " where customer_sale_id = '"+id+"'";
        var result = SelectDB(qrySelect);
        var value = result.split('^');
        var fields = "shipping_method,payment_method,sales_representative,payment_terms,card_number,cardholder_name,expiry_date,billing_address,net_due,discount,percentage,credit_limit,credit_status,receivable_gl,revenue_gl,discount_gl,tax_gl,surcharge_gl,payment_gl";
        fields = fields.split(',');
        for (var i=0; i < fields.length; i++){
            SetValue("hd_"+fields[i],value[i]);
        }
        HideLoading();
    }
}

function DeleteCustomerSaleTab(id){
    ShowLoading();
    var qryDelete = "delete from was_customer_sale where customer_sale_id = '"+id+"'";
    var result = UpdateDB(qryDelete);
    
    if(result == 1){
        alert("Delete record successfully.");
        DisplaySaleTabList();
    } else {
        alert("Error occur while deleting record.");
    }
    HideLoading();
}

function Select(){
    parent.window.opener.GetChildValue(GetValue("customer_id"));
    window.close();
    return false;
}

function LoadTransactionDetails(){
    var card_number = SelectDB("select card_number from was_card_details card, was_customer_account acc where acc.link_number = card.link_number and acc.customer_id = '"+GetValue("customer_id")+"'");
    SetValue("hd_tab3_card_number",card_number);
    DisplayMode("hd_tab3_card_number","DI");
    var qrySelect = "select transaction_id, transaction_date, transaction_time, transaction_type_txt, credit_amount,debit_amount "
                    + " from view_card_transaction_history where card_number='"+card_number+"'";
    var result = SelectDB(qrySelect);
    result = result.split('~');
    var display = "";
    var total = 0;
    if(result != ""){
        for (var i=0; i < result.length; i++){
            display = display + "<tr>";
            var value = result[i].split('^');
            if(value[4] !== ""){
                total = parseFloat(total) + parseFloat(value[4]);
            } else if(value[5] !== ""){
                total = parseFloat(total) - parseFloat(value[5]);
            }
            
            display = display + "<td style='padding:4px;'>" + value[0] + "</td>";
            display = display + "<td style='padding:4px;'>" + value[1] + "</td>";
            display = display + "<td style='padding:4px;'>" + value[2] + "</td>";
            display = display + "<td style='padding:4px;'>" + value[3] + "</td>";
            display = display + "<td style='padding:4px; text-align:right;'>" + value[4] + "</td>";
            display = display + "<td style='padding:4px; text-align:right;'>" + value[5] + "</td>";
            display = display + "<td style='padding:4px; text-align:right;'><b>" + total.toFixed(2) + "</b></td>";
            display = display + "</tr>";
        }
    }
    SetValueInner("displayTransDetails","");
    SetValueInner("displayTransDetails",display);
}
</script>