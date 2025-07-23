<script>
/*Required functions. onPageLoad, onAddNewUpdate, onAmendUpdate, onAddNew, onAmend, OnDelete, onCancelAddNew, onCancelAmend*/
function  onPageLoad(){
    
}   

function loadComboSelect(){
    populateCOAGroup();
}
/* onAddNewUpdate */
function onAddNewUpdate(){
    
}

/* onAmendUpdate */
function onAmendUpdate(){
    
}

/* onAddNew */
function onAddNew(){
    
}

/* onAmend */
function onAmend(){
    
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

function  LF_was_id(){
    var strSQL = "select * from was_chart_of_account where was_id = '"+GetValue('was_id').toString()+"'";
    var result = SelectDB(strSQL);
    if(result != ""){
        alert("ID already exist");
        SetFocus("was_id");
        return;
    }
}

function populateCOAGroup(){
    var strSQL = "SELECT was_id, coa_type FROM was_cs_coa_type order by coa_type";
    var result = SelectDB(strSQL);
    if(result != ""){
        result = result.split('~');
        $("#group_id").empty();
        $("#group_id").append($("<option></option>").val("").html(""));
        for (var i=0; i < result.length; i++){
            var value = result[i].split('^');
            $("#group_id").append($("<option></option>").val(value[0]).html(value[1]));
        }
    }
}
</script>