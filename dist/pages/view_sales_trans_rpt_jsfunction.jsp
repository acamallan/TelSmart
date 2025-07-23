<script>
$(function() {
    ShowLoading();
    loadSalesTrans();
    HideLoading();
});

function loadSalesTrans(){
    var strSQL = "select transaction_id, record_date, customer_id, card_number, TRUNCATE(sum(total_amount),2) from was_product_sales_order where payment_status = '102' group by transaction_id";
    var result = SelectDB(strSQL);
    result = result.split('~');
    var display = "";
    for (var i=0; i < result.length; i++){
        display = display + "<tr>";
        var value = result[i].split('^');
        for (var x=0; x < value.length; x++){
            display = display + "<td>" + value[x] + "</td>";
        }
        display = display + '<td style="text-align:center; padding:5px; width:13%;"><a oncontextmenu="return false;" href="#" class="action" id="view" onclick="window.open(\'<%= baseURL()%>common/pos_receipt.jsp?trans_id='+encrypt(value[0])+'\', \'_blank\', \'resizable=no, scrollbars=yes, titlebar=no, width=300, height=500, top=10, left=10,menubar=no, toolbar=no, location=no, scrollbars=no\')" ><span class="typcn typcn-document-text" title="View"></span>View</a>&nbsp;&nbsp;&nbsp;<a oncontextmenu="return false;" href="#" class="action" id="view" onclick="window.open(\''+baseURL()+'pages/pos_sales_rpt.jsp?trans_id='+encrypt(value[0])+'\', \'_blank\', \'resizable=yes, scrollbars=yes, titlebar=no, width=2000, height=900, top=10, left=10,menubar=no, toolbar=no, location=no, scrollbars=no\')" ><span class="typcn typcn-pencil" title="Edit"></span>Edit</a>&nbsp;&nbsp;&nbsp;<a oncontextmenu="return false;" href="#" class="action" id="delete" onclick="DeleteSalesTrans(\''+value[0]+'\')" title="Delete"><span class="typcn typcn-trash"></span>Delete</a></td>';
        display = display + "</tr>";
    }
    document.getElementById("displaySaleItems").innerHTML = "";
    document.getElementById("displaySaleItems").innerHTML = display;
}

function DeleteSalesTrans(value){
    if (confirm('Are you sure delete this record?')){
        Showloading();
        var strDelete = "delete from was_transaction_details where transaction_id ="+value;
        DeleteDB(strDelete);
        var strDelete = "delete from was_product_sales_order where transaction_id ="+value;
        DeleteDB(strDelete);
        loadSalesTrans();
        alert('Delete record successfully.');
        HideLoading();
    }
}
</script>