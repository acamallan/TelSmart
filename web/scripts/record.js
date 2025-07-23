$(function() {
   var path = window.location.pathname;
    var page = path.split("/").pop(); 
    SetSession("pageName",page);
});

function SelectDB(strSQL){
    var result="";
    $.ajax({
        url: baseURL()+'functions/record_functionjs.jsp',
        data: {functionname:encryptJS("SelectDB"), strSQL:encryptJS(strSQL)},
        type: 'POST',
        async: false,
        success: function(response) {
            result = decryptJS(response.trim());
            if(result == "null"){
                alert("Error occur while executing the query");
                result = "";
                HideLoading();
            }
        }
    });
    return result;
}

function InsertDB(strSQL){
    var result="";
    if(GetSession("pageName").substr(GetSession("pageName").length - 7) !== "rpt.jsp" && GetSession("isUpdatePage") === "true"){
        SetSession("qryStmt",GetSession("qryStmt") + strSQL +"^_^");
    } else {
        $.ajax({
            url: baseURL()+'functions/record_functionjs.jsp',
            data: {functionname:encryptJS("InsertDB"), strSQL:encryptJS(strSQL)},
            type: 'POST',
            async: false,
            success: function(response) {
                result = decryptJS(response.trim());
                if(result == "null"){
                    alert("Error occur while executing the query.");
                    result = "";
                    HideLoading();
                }
            }
        });
    }
    return result;
}

function UpdateDB(strSQL){
    var result="";
    if(GetSession("pageName").substr(GetSession("pageName").length - 7) !== "rpt.jsp" && GetSession("isUpdatePage") === "true"){
        SetSession("qryStmt",GetSession("qryStmt") + strSQL +"^_^");
    } else {
        $.ajax({
            url: baseURL()+'functions/record_functionjs.jsp',
            data: {functionname:encryptJS("UpdateDB"), strSQL:encryptJS(strSQL)},
            type: 'POST',
            async: false,
            success: function(response) {
                result = decryptJS(response.trim());
                if(result == "null"){
                    alert("Error occur while executing the query.");
                    result = "";
                    HideLoading();
                }
            }
        });
    }
    return result;
}

function DeleteDB(strSQL){
    var result="";
    $.ajax({
        url: baseURL()+'functions/record_functionjs.jsp',
        data: {functionname:encryptJS("DeleteDB"), strSQL:encryptJS(strSQL)},
        type: 'POST',
        async: false,
        success: function(response) {
            result = decryptJS(response.trim());
            if(result == "null"){
                alert("Error occur while executing the query.");
                result = "";
                HideLoading();
            }
        }
    });
    return result;
}

function encrypt(value){
    var result = "";
    $.ajax({
        url: baseURL()+'functions/record_functionjs.jsp',
        data: {functionname:encryptJS("toEncrypt"), toEncrypt:encryptJS(value)},
        type: 'POST',
        async: false,
        success: function(response) {
            result =  decryptJS(response.trim());
        }
    });
    return result;
}

function decrypt(value){
    var result = "";
    $.ajax({
        url: baseURL()+'functions/record_functionjs.jsp',
        data: {functionname:encryptJS("toDecrypt"), toDecrypt:encryptJS(value)},
        type: 'POST',
        async: false,
        success: function(response) {
            result =  decryptJS(response.trim());
        }
    });
    return result;
}

function GetCounter(counter_id,length){
    var result="";
    $.ajax({
        url: baseURL()+'functions/record_functionjs.jsp',
        data: {functionname:encryptJS("GetCounter"), counter_id:encryptJS(counter_id)},
        type: 'POST',
        async: false,
        success: function(response) {
            result = decryptJS(response.trim());
            if(result == "null"){
                result = "";
            }
        }
    });
    return pad(result,length);
}

function getServerSession(field){
    var result="";
    $.ajax({
        url: baseURL()+'functions/record_functionjs.jsp',
        data: {functionname:encryptJS("getServerSession"), field:encryptJS(field)},
        type: 'POST',
        async: false,
        success: function(response) {
            result = decryptJS(response.trim());
            if(result == "null"){
                result = "";
            }
        }
    });
    return result;
}
function GenerateReport(ReportName, strSQL){
    var result="";
    ShowLoading();
    var today = new Date();
    var dd = today.getDate();
    var mm = today.getMonth()+1; //January is 0!
    var yyyy = today.getFullYear();
    var hours = today.getHours();
    var minutes = today.getMinutes();
    var seconds = today.getSeconds();

    if(dd<10) {
        dd='0'+dd;
    } 

    if(mm<10) {
        mm='0'+mm;
    } 

    var today = yyyy+""+mm+""+dd+""+hours+""+minutes+""+seconds;
    ReportNameOutput = ReportName+"_"+today;
    $.ajax({
        url: baseURL()+'functions/record_functionjs.jsp',
        data: {functionname:"GenerateReport", ReportName:ReportName, ReportNameOutput:ReportNameOutput, strSQL:strSQL},
        type: 'POST',
        async: false,
        success: function(response) {
            result = response.trim();
            if(result == 1){
                sessionStorage.setItem('ReportName', ReportNameOutput);
                setTimeout(function(){ 
                    window.open(baseURL()+"ReportViewer.jsp", "_blank", "resizable=yes, scrollbars=yes, titlebar=no, width=2000, height=900, top=10, left=10,menubar=no, toolbar=no, location=no, scrollbars=no");
                }, 1000);
                setTimeout(function(){ 
                    $.ajax({
                        url: baseURL()+'functions/record_functionjs.jsp',
                        data: {functionname:"DeleteReport", ReportNameOutput:ReportNameOutput},
                        type: 'GET',
                        async: false,
                        success: function(response) {
                            //nothing to do. just deleting only the report from server side
                        }});
                }, 5000);
                
            } else {
                alert("Error while generating report.");
            }
            HideLoading();
        }
    });
}


function SetValue(fieldname, value){
    document.getElementById(fieldname).value = value;
}

function GetValue(fieldname){
    return document.getElementById(fieldname).value;
}

function SetValueInner(fieldname, value){
    document.getElementById(fieldname).innerHTML = value;
}

function GetValueInner(fieldname){
    return document.getElementById(fieldname).innerHTML;
}

function DisplayMode(fieldname, mode){
    var type = $("#"+fieldname).attr('type');
    if(type === "button"){
        if(mode == "DI"){
            document.getElementById(fieldname).disabled = true;
        } else {
            document.getElementById(fieldname).disabled = false;
        }
    } else {
        if(mode == "DI"){
            document.getElementById(fieldname).readOnly = true;
            document.getElementById(fieldname).className = "disabled"; 
            document.getElementById(fieldname).onfocus = function() { this.setAttribute('data-value', this.value);};
            document.getElementById(fieldname).onchange = function() { this.value = this.getAttribute('data-value'); };
        } else {
            document.getElementById(fieldname).readOnly = false;
            document.getElementById(fieldname).className = ""; 
            document.getElementById(fieldname).onfocus = function() { };
            document.getElementById(fieldname).onchange = function() { };
        }
    }
}

function SetFocus(fieldname){
    setTimeout(function(){ 
    document.getElementById(fieldname).focus();
    }, 100);
}

function LostFocus(functionname){
    ShowLoading();
    var field = (functionname.split("(")[0]).split("LF_")[1];//get the field from functionname
    if(GetSession("pageName").substr(GetSession("pageName").length - 7) === "rpt.jsp"){
        eval(functionname);
    } else if(document.getElementById(field).readOnly === false){
        setTimeout(function(){
            if(document.getElementById("done").value !== "Close"){
                eval(functionname);
            }
        }, 180);
    }
    
    HideLoading();
}

function Success(flag){
    sessionStorage.setItem('success', flag);
}

function SetStyle(fieldname, tag, value){
    document.getElementById(fieldname).style[tag] = value;
}

function SetSession(id, bln){
    sessionStorage.setItem(id, bln);
}

function GetSession(id){
    return sessionStorage.getItem(id);
}