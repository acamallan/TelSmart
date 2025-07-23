<script>

function ProcessReport(){
    var strSQL = "select * from was_product";
    var ReportName = "report";
    GenerateReport(ReportName, strSQL);
    
}
</script>