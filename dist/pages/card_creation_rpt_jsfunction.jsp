<script>
$(function() {
    ShowLoading();
    Reset();
    SetValue("record_date",getServerSession("record_date"));
    populateBranch();
    populateCardType();
    HideLoading();
});


function populateBranch(){
    var strSQL = "select was_id, branch from was_cs_branch";
    var result = SelectDB(strSQL);
    if(result != ""){
        result = result.split('~');
        $("#branch").empty();
        $("#branch").append($("<option></option>").val("").html(""));
        for (var i=0; i < result.length; i++){
            var value = result[i].split('^');
            $("#branch").append($("<option></option>").val(value[0]).html(value[1]));
        }
    }
}

function populateCardType(){
    var strSQL = "select was_id, card_type from was_cs_card_type";
    var result = SelectDB(strSQL);
    if(result != ""){
        result = result.split('~');
        $("#card_type").empty();
        $("#card_type").append($("<option></option>").val("").html(""));
        for (var i=0; i < result.length; i++){
            var value = result[i].split('^');
            $("#card_type").append($("<option></option>").val(value[0]).html(value[1]));
        }
    }
}

function LF_branch(){
    if(GetValue("branch") !== ""){
        SetValue("branch_id", GetValue("branch"));
    } else {
        SetValue("branch_id", "");
    }
    
    if(GetValue("branch") !== "" && GetValue("card_type") !== "" && GetValue("no_of_entries") !== "" && GetValue("record_date") !== "" && GetValue("expiry_threshold") !== ""){
        DisplayMode("btnGenerate","EN");
    } else {
        DisplayMode("btnGenerate","DI");
    }
}

function LF_card_type(){
    if(GetValue("card_type") !== ""){
        SetValue("card_type_id", GetValue("card_type"));
    } else {
        SetValue("card_type_id", "");
    }
    
    if(GetValue("branch") !== "" && GetValue("card_type") !== "" && GetValue("no_of_entries") !== "" && GetValue("record_date") !== "" && GetValue("expiry_threshold") !== ""){
        DisplayMode("btnGenerate","EN");
    } else {
        DisplayMode("btnGenerate","DI");
    }
}

function LF_no_of_entries(){
    if(GetValue("branch") !== "" && GetValue("card_type") !== "" && GetValue("no_of_entries") !== "" && GetValue("record_date") !== "" && GetValue("expiry_threshold") !== ""){
        DisplayMode("btnGenerate","EN");
    } else {
        DisplayMode("btnGenerate","DI");
    }
}

function LF_record_date(){
    if(GetValue("record_date") !== "00.00.0000"){
    checkDate(document.getElementById('record_date'));
    }
}

function LF_expiry_threshold(){
    var expiry_threshold = GetValue("expiry_threshold");
    if(expiry_threshold !== ""){
        var expiry_date = addDate(expiry_threshold, "M");
        SetValue("expiry_date",expiry_date);
    } else {
        SetValue("expiry_date","");
    }
    
    if(GetValue("branch") !== "" && GetValue("card_type") !== "" && GetValue("no_of_entries") !== "" && GetValue("record_date") !== "" && GetValue("expiry_threshold") !== ""){
        DisplayMode("btnGenerate","EN");
    } else {
        DisplayMode("btnGenerate","DI");
    }
}

function Generate(){
    ShowLoading();
    var branch = GetValue("branch");
    var card_type = GetValue("card_type");
    var no_of_entries = GetValue("no_of_entries");
    var record_date = GetValue("record_date");
    var expiry_date = GetValue("expiry_date");
    var bin = branch + card_type;
    var cardnumber = GenerateCardNumber(bin,16,no_of_entries,record_date,expiry_date,card_type);
    var result = cardnumber.split('~');
    $('#displayList').empty();
    for (var i=0; i < result.length; i++){
        var value = result[i].split('^');
        $('#displayList').append(
                ' <tr> '
                    + '<td style="padding:10px; border:none; text-align:center;">'+value[0]+'</td>'
                    + '<td style="padding:10px; border:none; text-align:center;">'+value[1]+'</td>'
                    + '<td style="padding:10px; border:none; text-align:center;">'+value[2]+'</td>'
                    + '<td style="padding:10px; border:none; text-align:center;">'+value[3]+'</td>'
                    + '<td style="padding:10px; border:none; text-align:center;">'+value[4]+'</td>'
                + '</tr>'
        );
    }
    SetValueInner("total",result.length);
    Reset();
    HideLoading();
}

function Reset(){
    DisplayMode("branch_id","DI");
    DisplayMode("card_type_id","DI");
    DisplayMode("expiry_date","DI");
    DisplayMode("btnGenerate","DI");
    SetValue("branch_id", "");
    SetValue("card_type_id", "");
    SetValue("branch", "");
    SetValue("card_type", "");
    SetValue("no_of_entries","");
    SetValue("expiry_threshold","");
    SetValue("expiry_date","");
}
</script>
