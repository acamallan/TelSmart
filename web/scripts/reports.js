function DisplayReport(div,reportname){
   var result="";
   var div = div.replace(/component1/g, 'component');
   ShowLoading();
    $.ajax({
        url: baseURL()+'functions/report_classes.jsp',
        data: {functionname:"GenerateHTMLtoPDF", div:div, reportname:reportname},
        type: 'POST',
        async: false,
        success: function(response) {
            result = response.trim();
            if(result == "null"){
                result = "";
                HideLoading();
            }
        }
    });
    HideLoading();
}

function ExportToPDF(){
    var result="";
    var reportname = GetValue("reportname");
    var div = GetValueInner("reportContent");
    var div = div.replace(/component1/g, 'component');
    ShowLoading();
    $.ajax({
        url: baseURL()+'functions/report_classes.jsp',
        data: {functionname:"ExportToPDF", div:div, reportname:reportname},
        type: 'POST',
        async: false,
        success: function(response) {
            result = response.trim();
        }
    });
    var path = baseURL()+"ReportsGenerated/"+reportname+".pdf";
    document.getElementById('download').href = path;
    setTimeout(function(){ 
        document.getElementById('download').click();
        HideLoading();
    }, 3000);
}

function CancelReport(){
    window.close();
}

function EnabledExportBtn(){
    DisplayMode("ExportToPDF","EN");
}

function DisabledExportBtn(){
    DisplayMode("ExportToPDF","DI");
}