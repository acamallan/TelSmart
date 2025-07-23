<script>

function ProcessReport(){
    var strFilter = "";
   
    if(GetValue("record_date") == ""){
        alert("Please input the record date.");
        return;
    }
        strFilter = " where record_date ='"+GetValue("record_date")+"'";
    var strSQL = "select * from view_daily_products_purchase "+ strFilter;
    var ReportName = "prod_daily_purch";
    GenerateReport(ReportName, strSQL);
    
}
</script>