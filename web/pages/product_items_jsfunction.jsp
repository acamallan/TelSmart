<script>
/*Required functions. onPageLoad, onAddNewUpdate, onAmendUpdate, onAddNew, onAmend, OnDelete, onCancelAddNew, onCancelAmend*/
function  onPageLoad(){
    $( "#tabs" ).tabs();
    $( "#tabs" ).tabs( "option", "active", 0 );
    $( "#tabs" ).tabs( "enable", 1 );
    $( "#tabs" ).tabs( "enable", 2 );
    document.getElementById("tab2").onclick = function() { tab2(); };
    document.getElementById("tab3").onclick = function() { tab3(); };
    loadPriceInfo();
    DisplayLocInfo();
    //SetValue("hd_location","");
    //SetValue("hd_quantity","");
    //SetValue("hd_location_id","");
    //SetValue("hd_location_name","");
    SetValue("strLocTxtValue","");
    //DisplayMode("hd_location","DI");
    //DisplayMode("hd_locationbtn","DI");
    //DisplayMode("hd_quantity","DI");
    //DisplayMode("hd_action","DI");
    DisplayMode("hd_actionPrice","DI");
    SetStyle("footer_navigation","display","block");
    SetStyle("hd_actionPrice","display","none");
    SetValue("hd_actionPrice","Add");
    document.getElementById("hd_actionPrice").onclick = function() { AddPriceInfo(); };
    
}   
/*populate the ComboSelect*/
function loadComboSelect(){
    populateCategory();
    populateSupplier();
    populateCOAType();
    populateProductType();
    populateMethod();
    populateProdLoc();
    populateIncomeAcct();
    populateCOGSAcct();
    populateCostUnitMeasure();
    populateSellingUnitMeasure();
}

/* onAddNewUpdate */
function onAddNewUpdate(){
    //SetValue('product_id',pad(GetCounter("001","6"),"6"));
    
    var vrows = document.getElementsByName("dynfields");
    if(vrows.length !== 0){
        var i = 0;
        for (var x = 0; x < vrows.length/2; x++) {
            var location = vrows[i].getAttribute( 'id' );
            var quantity = vrows[i+1].getAttribute( 'id' );
            var qryInsert = "insert into was_product_location_info (product_id,location,quantity)"+
                            " values('"+GetValue("product_id")+"','"+location+"','"+quantity+"')";
            InsertDB(qryInsert);
            var i = i+2;
        }
    }
}

/* onAmendUpdate */
function onAmendUpdate(){
    if(GetValue("hd_actionPrice") === "Cancel"){
        var qrySQL = "insert into was_product_price_info(product_id,method,normal_price,last_purch_price,discount,cost_unit_measure,cogs_account,average_cost,srp,discounted,wholesale,selling_unit_measure,cost_description,selling_description,income_account,tax_code)"
                    + "values('"+GetValue("product_id")+"','"+GetValue("hd_method")+"','"+GetValue("hd_normal_price")+"','"+GetValue("hd_last_purch_price")+"','"+GetValue("hd_discount")+"','"+GetValue("hd_cost_unit_measure")+"','"+GetValue("hd_cogs_account")+"','"+GetValue("hd_average_cost")+"','"+GetValue("hd_srp")+"','"+GetValue("hd_discounted")+"','"+GetValue("hd_wholesale")+"','"+GetValue("hd_selling_unit_measure")+"','"+GetValue("hd_cost_description")+"','"+GetValue("hd_selling_description")+"','"+GetValue("hd_income_account")+"','"+GetValue("hd_tax_code")+"')";
        InsertDB(qrySQL);    
    }
    
    var qryDelete = "delete from was_product_location_info where product_id = '"+GetValue("product_id")+"'";
    DeleteDB(qryDelete);
    var vrows = document.getElementsByName("dynfields");
    var i = 0;
    for (var x = 0; x < vrows.length/2; x++) {
        var location = vrows[i].getAttribute( 'id' );
        var quantity = vrows[i+1].getAttribute( 'id' );
        var qryInsert = "insert into was_product_location_info (product_id,location,quantity)"+
                        " values('"+GetValue("product_id")+"','"+GetValue(location)+"','"+GetValue(quantity)+"')";
        InsertDB(qryInsert);
        var i = i+2;
    }
}

/* onAddNew */
function onAddNew(){
    //DisplayMode("hd_location","EN");
    //DisplayMode("hd_quantity","EN");
    //DisplayMode("hd_action","EN");
    DisplayMode("hd_actionPrice","EN");
    SetValue("product_type","101");
    var fields = "method,normal_price,last_purch_price,discount,cost_unit_measure,cost_description,cogs_account,average_cost,srp,discounted,wholesale,selling_unit_measure,selling_description,income_account,tax_code";
    fields = fields.split(',');
    for (var i=0; i < fields.length; i++){
        SetValue("hd_"+fields[i],"");
    }
    
    $('#prodLoc').empty();
    $( "#tabs" ).tabs( "disable", 1 );
    $( "#tabs" ).tabs( "disable", 2 );
    document.getElementById("tab2").onclick = function() {  };
    document.getElementById("tab3").onclick = function() {  };
    AddPriceInfo();
}

/* onAmend */
function onAmend(){
    //DisplayMode("hd_location","EN");
    //DisplayMode("hd_quantity","EN");
    //DisplayMode("hd_action","EN");
    DisplayMode("hd_actionPrice","EN");
    //DisplayMode("hd_locationbtn","EN");
    
    /*var vrows = document.getElementsByName("dynfields");
    var i = 0;
    for (var x = 0; x < vrows.length/2; x++) {
        SetStyle("locAction["+i+"]","display","block");
        var i = i+1;
    } */
    $( "#tabs" ).tabs( "disable", 1 );
    $( "#tabs" ).tabs( "disable", 2 );
    document.getElementById("tab2").onclick = function() { };
    document.getElementById("tab3").onclick = function() {  };
    SetStyle("hd_actionPrice","display","block");
}

/* OnDelete */
function OnDelete(){
    
}

/* onCancelAddNew */
function onCancelAddNew(){

}

/* onCancelAmend */
function onCancelAmend(){

}

function populateCategory(){
    var qrySQL = "select was_id, category_name from was_category";
    var result = SelectDB(qrySQL);
    $("#category").empty();
    if(result !== ""){
        result = result.split('~');
        $("#category").append($("<option></option>").val("").html(""));
        for (var i=0; i < result.length; i++){
            var value = result[i].split('^');
            var len = value[0].length - 3;
            var space ="";
            for(var x=0; x < len; x++){
                space = space+"\xa0";
            }
            $("#category").append($("<option></option>").val(value[0]).html(space+value[1]));
        }
    }
}

function populateSupplier(){
    var qrySQL = "SELECT supplier_id, company_name FROM was_supplier order by company_name";
    var result = SelectDB(qrySQL);
    $("#supplier").empty();
    if(result !== ""){
        result = result.split('~');
        $("#supplier").append($("<option></option>").val("").html(""));
        for (var i=0; i < result.length; i++){
            var value = result[i].split('^');
            $("#supplier").append($("<option></option>").val(value[0]).html(value[1]));
        }
    }
}

function populateCOAType(){
    var qrySQL = "select was_id, account_type from was_chart_of_account order by was_id";
    var result = SelectDB(qrySQL);
    $("#coa_type").empty();
    if(result !== ""){
        result = result.split('~');
        $("#coa_type").append($("<option></option>").val("").html(""));
        for (var i=0; i < result.length; i++){
            var value = result[i].split('^');
            $("#coa_type").append($("<option></option>").val(value[0]).html(value[0]+" - "+value[1]));
        }
    }
}

function populateIncomeAcct(){
    var qrySQL = "select was_id, account_type from was_chart_of_account order by was_id";
    var result = SelectDB(qrySQL);
    $("#hd_income_account").empty();
    if(result !== ""){
        result = result.split('~');
        $("#hd_income_account").append($("<option></option>").val("").html(""));
        for (var i=0; i < result.length; i++){
            var value = result[i].split('^');
            $("#hd_income_account").append($("<option></option>").val(value[0]).html(value[0]+" - "+value[1]));
        }
    }
}

function populateCOGSAcct(){
    var qrySQL = "select was_id, account_type from was_chart_of_account order by was_id";
    var result = SelectDB(qrySQL);
    $("#hd_cogs_account").empty();
    if(result !== ""){
        result = result.split('~');
        $("#hd_cogs_account").append($("<option></option>").val("").html(""));
        for (var i=0; i < result.length; i++){
            var value = result[i].split('^');
            $("#hd_cogs_account").append($("<option></option>").val(value[0]).html(value[0]+" - "+value[1]));
        }
    }
}

function populateProductType(){
    var qrySQL = "SELECT was_id, product_type FROM was_cs_product_type order by product_type";
    var result = SelectDB(qrySQL);
    result = result.split('~');
    if(result !== ""){
        $("#product_type").empty();
        $("#product_type").append($("<option></option>").val("").html(""));
        for (var i=0; i < result.length; i++){
            var value = result[i].split('^');
            $("#product_type").append($("<option></option>").val(value[0]).html(value[1]));
        }
    }
}

function populateMethod(){
    var qrySQL = "SELECT was_id, method FROM was_cs_product_method order by method";
    var result = SelectDB(qrySQL);
    $("#hd_method").empty();
    if(result !== ""){
        result = result.split('~');
        $("#hd_method").append($("<option></option>").val("").html(""));
        for (var i=0; i < result.length; i++){
            var value = result[i].split('^');
            $("#hd_method").append($("<option></option>").val(value[0]).html(value[1]));
        }
    }
}

function populateProdLoc(){
    var qrySQL = "SELECT was_id, location FROM was_cs_product_location order by location";
    var result = SelectDB(qrySQL);
    $("#hd_location").empty();
    if(result !== ""){
        result = result.split('~');
        $("#hd_location").append($("<option></option>").val("").html(""));
        for (var i=0; i < result.length; i++){
            var value = result[i].split('^');
            $("#hd_location").append($("<option></option>").val(value[0]).html(value[1]));
        }
    }
}

function populateCostUnitMeasure(){
    var qrySQL = "SELECT was_id, unit_measure FROM was_cs_unit_measure order by unit_measure";
    var result = SelectDB(qrySQL);
    $("#hd_cost_unit_measure").empty();
    if(result !== ""){
        result = result.split('~');
        $("#hd_cost_unit_measure").append($("<option></option>").val("").html(""));
        for (var i=0; i < result.length; i++){
            var value = result[i].split('^');
            $("#hd_cost_unit_measure").append($("<option></option>").val(value[0]).html(value[1]));
        }
    }
}

function populateSellingUnitMeasure(){
    var qrySQL = "SELECT was_id, unit_measure FROM was_cs_unit_measure order by unit_measure";
    var result = SelectDB(qrySQL);
    $("#hd_selling_unit_measure").empty();
    if(result !== ""){
        result = result.split('~');
        $("#hd_selling_unit_measure").append($("<option></option>").val("").html(""));
        for (var i=0; i < result.length; i++){
            var value = result[i].split('^');
            $("#hd_selling_unit_measure").append($("<option></option>").val(value[0]).html(value[1]));
        }
    }
}

/*Product Details Tab*/

function tab1(){
    SetStyle("footer_navigation","display","block");
}

function LF_product_id(){
    var qrySQL = "select product_name from was_product where product_id = '"+GetValue("product_id")+"'";
    var productname = SelectDB(qrySQL);
    SetValue("product_name",productname);
}

function loadPriceInfo(){
    var qrySQL = "select method,normal_price,last_purch_price,discount,cost_unit_measure,cost_description,cogs_account,average_cost,srp,discounted,wholesale,selling_unit_measure,selling_description,income_account,tax_code from was_product_price_info where product_id = '"+GetValue("product_id")+"' and record_date = (select max(record_date) from was_product_price_info where product_id = '"+GetValue("product_id")+"')";
    var result = SelectDB(qrySQL);
    var fields = "method,normal_price,last_purch_price,discount,cost_unit_measure,cost_description,cogs_account,average_cost,srp,discounted,wholesale,selling_unit_measure,selling_description,income_account,tax_code";
    fields = fields.split(',');
    if(result !== ""){
        result = result.split('^');
        for (var i=0; i < fields.length; i++){
            SetValue("hd_"+fields[i],result[i]);
            DisplayMode("hd_"+fields[i],"DI");
        }
    } else {
        for (var i=0; i < fields.length; i++){
            SetValue("hd_"+fields[i],"");
            DisplayMode("hd_"+fields[i],"DI");
        }
    }
}

function AddPriceInfo(){
    var fields = "method,normal_price,last_purch_price,discount,cost_unit_measure,cost_description,cogs_account,average_cost,srp,discounted,wholesale,selling_unit_measure,selling_description,income_account,tax_code";
    fields = fields.split(',');
    for (var i=0; i < fields.length; i++){
        SetValue("hd_"+fields[i],"");
        DisplayMode("hd_"+fields[i],"EN");
    }
    SetValue("hd_method","101");
    SetValue("hd_normal_price","0.00");
    SetValue("hd_cost_description", GetValue("product_name"));
    SetValue("hd_selling_description", GetValue("product_name"));
    SetValue("hd_srp","0.00");
    SetValue("hd_discounted","0.00");
    SetValue("hd_wholesale","0.00");
    SetValue("hd_actionPrice","Cancel");
    document.getElementById("hd_actionPrice").onclick = function() { CancelPriceInfo(); };
}

function CancelPriceInfo(){
    loadPriceInfo();
    SetValue("hd_actionPrice","Add");
    document.getElementById("hd_actionPrice").onclick = function() { AddPriceInfo(); };
}

function AddLocation(){
    var strLocation = GetValue('hd_location');
    var strQuantity = GetValue('hd_quantity');
    if(strLocation === "" || strQuantity === ""){
        alert('Please input the Location and Quantity fields.');
        SetFocus("hd_location");
        return;
    }
    if(GetValue("strLocID").search(strLocation) !== -1){
        alert("Product already exist on the location");
        SetValue("hd_quantity","");
        SetFocus("hd_location");
        return;
    }
    if(GetValue("strCounter") === "0"){
        $("#prodLoc").empty();
    }
    
    var counter = parseInt(GetValue('strCounter')) + 1;
    var txtLocation = GetValue('strLocTxtValue');
    $('#prodLoc').append(
       ' <tr id="trprodLoc['+counter+']"> '
            + '<td style="padding:3px"><input type="hidden" name="dynfields" id="hd_location[' + counter + ']" value="'+strLocation+'">'+txtLocation+'</td>'
            + '<td style="text-align:center;"><input type="hidden" name="dynfields" id="hd_quantity[' + counter + ']" value="'+strQuantity+'">'+strQuantity+'</td>'
            + '<td style="text-align:center; padding:5px; width:50%;"><span style="display:block;" id="locAction[' + counter + ']"><a oncontextmenu="return false;" oncontextmenu="return false;" href="#" class="action" id="view" onclick="EditLoc('+counter+')" ><span class="typcn typcn-pencil" title="Edit"></span>Edit</a>&nbsp;&nbsp;&nbsp;<a oncontextmenu="return false;" oncontextmenu="return false;" href="#" class="action" id="deleteLoc" onclick="DeleteLoc('+counter+')" title="Delete"><span class="typcn typcn-trash"></span>Delete</a></span></td>'
            + '</tr>'
    );
    SetValue("strLocID", GetValue("strLocID")+ "," + strLocation);
    SetValue("hd_location","");
    SetValue("hd_quantity","");
    SetValue("strCounter",counter);
    totalQuantity();
}

function GetLocTxtValue(sel){
    SetValue("strLocTxtValue",sel.options[sel.selectedIndex].text);
}

function DisplayLocInfo(){
    //select prod.product_name, loc.location, sum(rec.quantity) from was_product prod, was_product_receive rec, was_cs_product_location loc
    //where prod.product_id = rec.product_id and rec.location = loc.was_id
    //group by prod.product_id, rec.location
    
    //select prod.product_name, sale.location,  loc.location, sum(sale.quantity) from was_product prod, was_product_sale sale, was_cs_product_location loc
    //where prod.product_id = sale.product_id and sale.location = loc.was_id
    //group by prod.product_id, sale.location
    
    var qrySQL = "select location_text, sum(product_in)-sum(product_out) total from view_product_info where product_id = '"+GetValue("product_id")+"' group by location ";
    var result = SelectDB(qrySQL);
    var display = "";
    var total = 0;
    var counter = 0;
    if(result !== ""){
        result = result.split('~');
        for (var i=0; i < result.length; i++){
            counter++;
            display = display + "<tr id='trprodLoc[" + i + "]'>";
                var value = result[i].split('^');
                display = display + '<td style="padding:3px">'+value[0]+'</td>'
                display = display + '<td style="text-align:center;">'+value[1]+'</td>'
            display = display + "</tr>";
            total = total + parseInt(value[1]);
        } 
    } else {
        display = display + "<tr>";
        display = display + '<td style="padding:3px" colspan="3">No Location/s found under this product.</td>';
        display = display + "</tr>";
    }
    SetValueInner("prodLoc","");
    SetValueInner("prodLoc",display);
    SetValueInner("countQuantity", total);
    //SetValue("strLocID", strLocID);
    //SetValue("strCounter",counter);
}

function EditLoc(counter){
    SetValue("hd_location",GetValue("hd_location["+counter+"]"));
    SetValue("hd_quantity",GetValue("hd_quantity["+counter+"]"));
    SetValue("hd_action","Edit");
    SetFocus("hd_location");
    document.getElementById("hd_action").onclick = function() { EditLocFunc(counter); };
}

function EditLocFunc(counter){
    var strLocation = GetValue('hd_location');
    if(GetValue("hd_location[" + counter + "]") !== strLocation){
        if(GetValue("strLocID").search(strLocation) !== -1 ){
            alert("Product already exist on the location");
            return;
        }
    }
    var display = '<td style="padding:3px"><input type="hidden" name="dynfields" id="hd_location[' + counter + ']" value="'+GetValue("hd_location")+'">'+GetValue('strLocTxtValue')+'</td>'
    display = display + '<td style="text-align:center;"><input type="hidden" name="dynfields" id="hd_quantity[' + counter + ']" value="'+GetValue("hd_quantity")+'">'+GetValue("hd_quantity")+'</td>'
    //display = display + '<td style="text-align:center; padding:5px; width:50%;"><span style="display:block;" id="locAction[' + counter + ']"><a oncontextmenu="return false;" oncontextmenu="return false;" href="#" class="action" id="view" onclick="EditLoc('+counter+')" ><span class="typcn typcn-pencil" title="Edit"></span>Edit</a>&nbsp;&nbsp;&nbsp;<a oncontextmenu="return false;" oncontextmenu="return false;" href="#" class="action" id="deleteLoc" onclick="DeleteLoc('+counter+')" title="Delete"><span class="typcn typcn-trash"></span>Delete</a></span></td>';
    SetValueInner("trprodLoc[" + counter + "]","");
    SetValueInner("trprodLoc[" + counter + "]",display);
    SetValue("hd_location","");
    SetValue("hd_quantity","");
    SetValue("hd_action","Add");
    document.getElementById("hd_action").onclick = function() { AddLocation(); };
    totalQuantity();
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
            //display = display + '<td style="text-align:center;"><a oncontextmenu="return false;" oncontextmenu="return false;" href="#" class="action" id="view" onclick="PopUpSelectLocation(\''+value[0]+'\')"><span class="typcn typcn-document-text" title="View"></span>Select</a>&nbsp;&nbsp;&nbsp;<a oncontextmenu="return false;" oncontextmenu="return false;" href="#" class="action" id="view" onclick="PopUpEditLocation(\''+i+'\')" ><span class="typcn typcn-pencil" title="Edit"></span>Edit</a>&nbsp;&nbsp;&nbsp;<a oncontextmenu="return false;" oncontextmenu="return false;" href="#" class="action" id="delete" onclick="PopUpDeleteLocation(\''+value[0]+'\')" title="Delete"><span class="typcn typcn-trash"></span>Delete</a></td>';
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

function PopUpEditLocation(counter){
    SetValue("hd_location_id",GetValue("hd_location_id["+counter+"]"));
    SetValue("hd_location_name",GetValue("hd_location_name["+counter+"]"));
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
            //display = display + '<td style="text-align:center;"><a oncontextmenu="return false;" oncontextmenu="return false;" href="#" class="action" id="view" onclick="PopUpSelectLocation(\''+value[0]+'\')"><span class="typcn typcn-document-text" title="View"></span>Select</a>&nbsp;&nbsp;&nbsp;<a oncontextmenu="return false;" oncontextmenu="return false;" href="#" class="action" id="view" onclick="PopUpEditLocation(\''+i+'\')" ><span class="typcn typcn-pencil" title="Edit"></span>Edit</a>&nbsp;&nbsp;&nbsp;<a oncontextmenu="return false;" oncontextmenu="return false;" href="#" class="action" id="delete" onclick="PopUpDeleteLocation(\''+value[0]+'\')" title="Delete"><span class="typcn typcn-trash"></span>Delete</a></td>';
            display = display + "</tr>";
        }
    }
    SetValueInner("displayLocation","");
    SetValueInner("displayLocation",display);
    SetValue("strCounterLoc",i);
    SetValue("hd_location_id","");
    SetValue("hd_location_name","");
    populateProdLoc();
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
            display = display + '<td style="text-align:center;"><a oncontextmenu="return false;" oncontextmenu="return false;" href="#" class="action" id="view" onclick="PopUpSelectLocation(\''+value[0]+'\')"><span class="typcn typcn-document-text" title="View"></span>Select</a>&nbsp;&nbsp;&nbsp;<a oncontextmenu="return false;" oncontextmenu="return false;" href="#" class="action" id="view" onclick="PopUpEditLocation(\''+i+'\')" ><span class="typcn typcn-pencil" title="Edit"></span>Edit</a>&nbsp;&nbsp;&nbsp;<a oncontextmenu="return false;" oncontextmenu="return false;" href="#" class="action" id="delete" onclick="PopUpDeleteLocation(\''+value[0]+'\')" title="Delete"><span class="typcn typcn-trash"></span>Delete</a></td>';
            display = display + "</tr>";
        }
    }
    SetValueInner("displayLocation","");
    SetValueInner("displayLocation",display);
    populateProdLoc();
    HideLoading();
}

function PopUpSelectLocation(value){
    populateProdLoc();
    SetValue("hd_location",value);
    $('#dialog').dialog('close');
    SetValueInner("displayLocation","");
}

function DeleteLoc(counter){
    var result = GetValue("strLocID").replace(GetValue("hd_location["+counter+"]"), "");
    SetValue("strLocID", result);
    var d = document.getElementById('prodLoc');
    var olddiv = document.getElementById('trprodLoc['+counter+']');
    d.removeChild(olddiv);
    totalQuantity();
}
/*Product Details Tab*/

function totalQuantity(){
    var strCounter = document.getElementById('strCounter').value;
    var total = 0;
    for(var x = 0; x <= strCounter; x++){
	var strQuantityField = 'hd_quantity['+x+']';
	if (document.getElementById(strQuantityField) != null){
           total = total + parseInt(GetValue(strQuantityField)) ;
	}			
    }
    SetValueInner("countQuantity", total);
}

/*Other Info*/
function tab2(){
    ShowLoading();
    SetStyle("footer_navigation","display","none");
    PurchaseOrderInfo();
    VendorInfo();
    HideLoading();
}

function PurchaseOrderInfo(){
    var strSQL = "select purch.purchase_id, purch.record_date, supplier.company_name, purch.quantity, purch.partial, purch.quantity-purch.partial "
                    + " from was_product_purchase purch, was_product_purchase_header head, was_supplier supplier"
                    + " where purch.purchase_id = head.purchase_id and head.supplier_id = supplier.supplier_id \n"
                    + " and product_id ='"+GetValue("product_id")+"' and purch.quantity-purch.partial > 0 order by purch.purchase_id desc";
    var result = SelectDB(strSQL);
    var display = "";
    if(result !== ""){
        result = result.split('~');
        for (var i=0; i < result.length; i++){
            display = display + "<tr>";
            var value = result[i].split('^');
            display = display + "<td style='padding:4px; text-align:center;'>" + value[0] + "</td>";
            display = display + "<td style='padding:4px; text-align:center;'>" + value[1] + "</td>";
            display = display + "<td style='padding:4px;'>" + value[2] + "</td>";
            display = display + "<td style='padding:4px; text-align:center;'>" + value[3] + "</td>";
            display = display + "<td style='padding:4px; text-align:center;'>" + value[4] + "</td>";
            display = display + "<td style='padding:4px; text-align:center; color:red;'>" + value[5] + "</td>";
            display = display + "</tr>";
        }
    } else {
        display = display + "<td style='padding:4px;' colspan='6'>No Pending for delivery.</td>";
    }
    SetValueInner("PODisplay","");
    SetValueInner("PODisplay",display);
}

function VendorInfo(){
    var strSQL = "select supplier.supplier_id, company_name, contact_person , purch.total_price, 'waay pa include'"
                + " from was_supplier supplier, was_product_purchase_header head, was_product_purchase purch"
                + " where supplier.supplier_id = head.supplier_id and head.purchase_id = purch.purchase_id"
                + " and purch.product_id ='"+GetValue("product_id")+"'";
    var result = SelectDB(strSQL);
    var display = "";
    if(result !== ""){
        result = result.split('~');
        for (var i=0; i < result.length; i++){
            display = display + "<tr>";
            var value = result[i].split('^');
            display = display + "<td style='padding:4px; text-align:center;'>" + value[0] + "</td>";
            display = display + "<td style='padding:4px; text-align:center;'>" + value[1] + "</td>";
            display = display + "<td style='padding:4px; text-align:center;'>" + value[2] + "</td>";
            display = display + "<td style='padding:4px; text-align:center;'>" + value[3] + "</td>";
            display = display + "<td style='padding:4px; text-align:center;'>" + value[4] + "</td>";
            display = display + "</tr>";
        }
    }
    SetValueInner("VendorDisplay","");
    SetValueInner("VendorDisplay",display);
}
/*Other Info*/

/* Transaction Details*/
function tab3(){
    ShowLoading();
    SetStyle("footer_navigation","display","none");
    TransDetails();
    HideLoading();
}

function TransDetails(){
    var strSQL = "select type, reference_number, record_date, location_text, product_in, product_out, cost_price, selling_price "
                + " from view_product_info"
                + " where product_id ='"+GetValue("product_id")+"' order by TO_DATE(record_date)";
    var result = SelectDB(strSQL);
    var display = "";
    var balance = 0;
    var totalIN = 0;
    var totalOUT = 0;
    if(result !== ""){
        result = result.split('~');
        for (var i=0; i < result.length; i++){
            var totalPrice = "";
            display = display + "<tr>";
            var value = result[i].split('^');
            display = display + "<td style='padding:4px; text-align:center;'>" + value[1] + "</td>";
            display = display + "<td style='padding:4px; text-align:center;'>" + value[2] + "</td>";
            display = display + "<td style='padding:4px; text-align:left;'>" + value[3] + "</td>";
            if(value[0] === "1"){
                display = display + "<td style='padding:4px; text-align:center;'>" + value[4] + "</td>";
                display = display + "<td style='padding:4px; text-align:center;'></td>";
                balance = balance + parseInt(value[4]); 
            } else {
                display = display + "<td style='padding:4px; text-align:center;'></td>";
                display = display + "<td style='padding:4px; text-align:center;'>" + value[5] + "</td>";
                balance = balance - parseInt(value[5]);
            }
            display = display + "<td style='padding:4px; text-align:center;'>" + balance + "</td>";
            if(value[0] === "1"){
                
                display = display + "<td style='padding:4px; text-align:center;'>" + value[6] + "</td>";
                totalPrice = value[4] * value[6];
                totalIN = totalIN + parseInt(value[4]);
                
            } else {
               
                display = display + "<td style='padding:4px; text-align:center;'>" + value[7] + "</td>";
                totalPrice = value[5] * value[7];
                totalOUT = totalOUT + parseInt(value[5]);
                
            }
            display = display + "<td style='padding:4px; text-align:center;'>" + totalPrice.toFixed(2); + "</td>";
            
            display = display + "</tr>";
        }
    }
    SetValueInner("TransDetailsDisplay","");
    SetValueInner("TransDetailsDisplay",display);
    SetValueInner("totalIN",totalIN);
    SetValueInner("totalOUT",totalOUT);
}
/* Transaction Details*/

function Select(){
    parent.window.opener.GetChildValue(GetValue("product_id"));
    window.close();
    return false;
}
</script>