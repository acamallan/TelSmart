<script>
/*Required functions. onPageLoad, onAddNewUpdate, onAmendUpdate, onAddNew, onAmend, OnDelete, onCancelAddNew, onCancelAmend*/
function  onPageLoad(){
    
}   

function loadComboSelect(){
    populateTableStatus();
    populateTableType();
}
/* onAddNewUpdate */
function onAddNewUpdate(){
    
}

/* onAmendUpdate */
function onAmendUpdate(){
    
}

/* onAddNew */
function onAddNew(){
    SetValue("table_status","108");
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

function populateTableType(){
    var strSQL = "SELECT was_id, table_type FROM was_cs_rest_table_type";
    var result = SelectDB(strSQL);
    if(result != ""){
        result = result.split('~');
        $("#table_type").empty();
        $("#table_type").append($("<option></option>").val("").html(""));
        for (var i=0; i < result.length; i++){
            var value = result[i].split('^');
            $("#table_type").append($("<option></option>").val(value[0]).html(value[1]));
        }
    }
}

function populateTableStatus(){
    var strSQL = "SELECT was_id, room_status FROM was_cs_hotel_room_status";
    var result = SelectDB(strSQL);
    if(result != ""){
        result = result.split('~');
        $("#table_status").empty();
        $("#table_status").append($("<option></option>").val("").html(""));
        for (var i=0; i < result.length; i++){
            var value = result[i].split('^');
            $("#table_status").append($("<option></option>").val(value[0]).html(value[1]));
        }
    }
}

function  LF_table_id(){
    var strSQL = "select * from was_rest_table_details where table_id = '"+GetValue('table_id').toString()+"'";
    var result = SelectDB(strSQL);
    if(result != ""){
        alert("ID already exist");
        SetFocus("table_id");
        return;
    }
}

</script>