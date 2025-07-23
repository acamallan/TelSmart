<script>
$(function() {
    ShowLoading();
    $( "#tabs" ).tabs();
    $( "#tabs" ).tabs( "option", "active", 0 );
    SetValue("btnFind","");
    var strSQL = "select product_id, product_name, cat.category_name, cost_price, selling_price, sum(product_in) - sum(product_out) total, reorder_threshold from view_product_info info, was_category cat"
                    + " where info.category = cat.was_id group by product_id";
    var result = SelectDB(strSQL);
    result = result.split('~');
    var display = "";
    for (var i=0; i < result.length; i++){
        display = display + "<tr>";
        var value = result[i].split('^');
        //for (var x=0; x < value.length; x++){
            display = display + "<td style='padding:4px; cursor:pointer;' onclick='OpenItems(\"" + value[0] + "\")'>" + value[0] + "</td>";
            display = display + "<td style='padding:4px; cursor:pointer;' onclick='OpenItems(\"" + value[0] + "\")'>" + value[1] + "</td>";
            display = display + "<td style='padding:4px;'>" + value[2] + "</td>";
            display = display + "<td style='padding:4px;'>" + value[3] + "</td>";
            display = display + "<td style='padding:4px;'>" + value[4] + "</td>";
            display = display + "<td style='padding:4px;'>" + value[5] + "</td>";
        //}
        display = display + '<td style="text-align:center"><a oncontextmenu="return false;" href="#" class="action" id="view" onclick="view_product_info(\''+value[0]+'\',\''+value[1]+'\')" >View</a></td>';
        display = display + "</tr>";
    }
    SetValueInner("displayList","");
    SetValueInner("displayList",display);
    
    //Reorder Notification
    var reorder = false;
    var displayReorder = "";
    SetStyle("hd_PO","display","none");
    for (var i=0; i < result.length; i++){
        var value = result[i].split('^');
        displayReorder = displayReorder + "<tr>";
        if(parseInt(value[5]) < parseInt(value[6])){
            displayReorder = displayReorder + "<td style='padding:4px;'>" + value[1] + "</td>";
            displayReorder = displayReorder + "<td style='padding:4px; color:red; text-align:center;'>" + value[5] + "</td>";
            reorder = true;
            SetStyle("hd_PO","display","block");
        }
        displayReorder = displayReorder + "</tr>";
    }
    if(!reorder){
        displayReorder = "<tr><td style='padding:4px;' colspan='2'> No Reorder Item.</td></tr>";  
    }
    SetValueInner("reorder","");
    SetValueInner("reorder",displayReorder);
    
    //No Movement Notication
    var noMovement = false;
    var strSQL = "select product_id, product_name, max(to_date(record_date)), datediff(current_date(), max(to_date(record_date))) diif from view_product_info"
                    + " where type = 2 group by product_id";
    var result = SelectDB(strSQL);
    result = result.split('~');
    var displayNoMovement = "";
    for (var i=0; i < result.length; i++){
        var value = result[i].split('^');
        displayNoMovement = displayNoMovement + "<tr>";
        if(parseInt(value[3]) > getServerSession("NoMovementOut")){
            displayNoMovement = displayNoMovement + "<td style='padding:4px;'>" + value[1] + "</td>";
            displayNoMovement = displayNoMovement + "<td style='padding:4px; color:red; text-align:center;'>" + value[3] + "</td>";
            noMovement = true;
        }
        displayNoMovement = displayNoMovement + "</tr>";
    }
    if(!noMovement){
        displayNoMovement = "<tr><td style='padding:4px;' colspan='2'> All Items move in a given days.</td></tr>";  
    }
    SetValueInner("noMovement","");
    SetValueInner("noMovement",displayNoMovement);
    
    HideLoading();
});

function find_products(filter){
    setTimeout(function(){
        var display = "";
        var strWhere = "";
        if(filter == ""){
            strWhere = "";
        } else {
            strWhere = "and (product_id like ('%"+filter+"%') or product_name like ('%"+filter+"%') or cat.category_name like ('%"+filter+"%'))";
        }
       var strSQL = "select product_id, product_name, cat.category_name, cost_price, selling_price, sum(product_in) - sum(product_out) total from view_product_info info, was_category cat"
                        + " where info.category = cat.was_id "+strWhere+" group by product_id";

        var result = SelectDB(strSQL);
        if(result != ""){
        result = result.split('~');
            for (var i=0; i < result.length; i++){
                display = display + "<tr>";
                var value = result[i].split('^');
                for (var x=0; x < value.length; x++){
                    display = display + "<td style='padding:2px;'>" + value[x] + "</td>";
                }
                display = display + '<td style="text-align:center"><a oncontextmenu="return false;" href="#" class="action" id="view" onclick="view_product_info(\''+value[0]+'\',\''+value[1]+'\')" >View</a></td>';
                display = display + "</tr>";
            }
        } else {
            display = display + "<td style='padding:2px;' colspan='6'>No records found.</td>";
        }
        SetValueInner("displayList","");
        SetValueInner("displayList",display);
    }, 1000);
}

function view_product_info(product_id, product_name){
    ShowLoading();
    SetStyle("dialog","display","block");
    SetValueInner("ProdView","");
    $( "#dialog" ).dialog({
        width: 600,
        height: 400,
        modal: true,
        title:product_id + ' - '+ product_name
    });
    var qrySQL = "select location_text, sum(product_in)-sum(product_out) total from view_product_info where product_id = '"+product_id+"' group by location ";
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
    SetValueInner("ProdView","");
    SetValueInner("ProdView",display);
    HideLoading();
}


function OpenItems(product_id){
    window.open(baseURL()+"pages/product_items.jsp?link=1&product_id="+encrypt(product_id), "_blank", "height=" + screen.height + ",width=" + screen.width + ",scrollbars=yes, titlebar=no");
}

function PurchaseOrder(){
    window.open(baseURL()+"pages/product_purchase.jsp", "_blank", "height=" + screen.height + ",width=" + screen.width + ",scrollbars=yes, titlebar=no");
}

function tab2(){
    ShowLoading();
    var strSQL = "select distinct prod.product_id, prod.product_name, cat.category_name from was_product prod, was_category cat"
                    + " where prod.product_id not in (select distinct product_id from was_product_receive)"
                    + " and prod.category = cat.was_id order by prod.product_id";
    var result = SelectDB(strSQL);
    result = result.split('~');
    var display = "";
    for (var i=0; i < result.length; i++){
        display = display + "<tr>";
        var value = result[i].split('^');
        for (var x=0; x < value.length; x++){
            display = display + "<td style='padding:4px;'>" + value[x] + "</td>";
        }
        display = display + "</tr>";
    }
    SetValueInner("displayListWO","");
    SetValueInner("displayListWO",display);
    HideLoading();
}

function tab3(){
    ShowLoading();
    var strSQL = "select record_date, reference_number, product_id, product_name, if(sum(product_in) = 0, '',sum(product_in)), if(sum(product_out) = 0, '',sum(product_out)) from view_product_info"
                    + " group by record_date, product_id order by to_date(record_date)";
    var result = SelectDB(strSQL);
    result = result.split('~');
    var display = "";
    for (var i=0; i < result.length; i++){
        display = display + "<tr>";
        var value = result[i].split('^');
        for (var x=0; x < value.length; x++){
            display = display + "<td style='padding:4px;'>" + value[x] + "</td>";
        }
        display = display + "</tr>";
    }
    SetValueInner("displayListIO","");
    SetValueInner("displayListIO",display);
    HideLoading();
}
</script>