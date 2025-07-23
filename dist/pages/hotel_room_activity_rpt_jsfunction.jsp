<script>
$(function() {
    SetValue("date_from","");
    SetValue("date_to","");
});

function LF_date_from(){
    checkDate(document.getElementById("date_from"));
}

function LF_date_to(){
    checkDate(document.getElementById("date_to"));
}

function ProcessReport(){
    if(GetValue("date_from") === "" || GetValue("date_to") === ""){
        alert("Please input the date fields");
        return;
    }
    SetValueInner("datefrom",GetValue("date_from"));
    SetValueInner("dateto",GetValue("date_to"));
    var div = GetValueInner("reportContent");
    var reportname = "room_activity";
    DisplayReport(div,reportname);
        

    
    
}
</script>