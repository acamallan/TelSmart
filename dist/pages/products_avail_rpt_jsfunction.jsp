<script>

function ProcessReport(){
    var strFilter = "";
    if(GetValue("product_id") != "999999"){
        strFilter = " where product_id ='"+GetValue("product_id")+"'";
    }
    var strSQL = "select * from view_products "+ strFilter;
    var ReportName = "prod_avail";
    GenerateReport(ReportName, strSQL);
    
}
</script>