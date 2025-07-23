<script>
/*Required functions. onPageLoad, onAddNewUpdate, onAmendUpdate, onAddNew, onAmend, OnDelete, onCancelAddNew, onCancelAmend*/
function  onPageLoad(){
    
}   

function loadComboSelect(){
    populateRoomType();
    populateRoomStatus();
}
/* onAddNewUpdate */
function onAddNewUpdate(){
    
}

/* onAmendUpdate */
function onAmendUpdate(){
    
}

/* onAddNew */
function onAddNew(){
    SetValue("room_status","108");
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

function populateRoomType(){
    var strSQL = "SELECT was_id, room_type FROM was_cs_hotel_room_type";
    var result = SelectDB(strSQL);
    if(result != ""){
        result = result.split('~');
        $("#room_type").empty();
        $("#room_type").append($("<option></option>").val("").html(""));
        for (var i=0; i < result.length; i++){
            var value = result[i].split('^');
            $("#room_type").append($("<option></option>").val(value[0]).html(value[1]));
        }
    }
}

function populateRoomStatus(){
    var strSQL = "SELECT was_id, room_status FROM was_cs_hotel_room_status";
    var result = SelectDB(strSQL);
    if(result != ""){
        result = result.split('~');
        $("#room_status").empty();
        $("#room_status").append($("<option></option>").val("").html(""));
        for (var i=0; i < result.length; i++){
            var value = result[i].split('^');
            $("#room_status").append($("<option></option>").val(value[0]).html(value[1]));
        }
    }
}

function  LF_room_id(){
    var strSQL = "select * from was_hotel_room_details where room_id = '"+GetValue('room_id').toString()+"'";
    var result = SelectDB(strSQL);
    if(result != ""){
        alert("ID already exist");
        SetFocus("room_id");
        return;
    }
}



function LF_price(){
    formatDecimal(document.getElementById("price"));
}
</script>