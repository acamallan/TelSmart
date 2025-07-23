<script>
$(function() {
    ShowLoading();
    populateRoomType();
    DisplayMode("btnSave","DI");
    DisplayMode("btnNew","DI");
    SetValue("counter",0);
    HideLoading();
});

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

function OC_room_type(){
    ShowLoading();
    if(GetValue("room_type") !== ""){
        var strSQL = "SELECT inc_id, description FROM was_hotel_room_type_desc where room_type = '"+GetValue("room_type")+"'";
        var result = SelectDB(strSQL);
        var counter = 0;
        SetValue("counter",counter);
        if(result !== ""){
            $('#displayList').empty();
            result = result.split('~');
            for (var i=0; i < result.length; i++){
                var counter = parseInt(GetValue("counter")) + 1;
                var value = result[i].split('^');
                $('#displayList').append(
                    '<tr id="tr_'+counter+'">'
                        + ' <td style="background-color: #f6f6f6; padding: 2px; width: 22%; text-align: right;">Description '+counter+'</td>'
                        + ' <td style="background-color: #f6f6f6; padding: 2px; "><input type="text" name="dynfields" id="description_'+counter+'" value="'+value[1]+'" style="width:390px;" maxlenght="50">'
                        + ' <div style="float:right; margin-right:-2px; margin-top:5px"><a oncontextmenu="return false;" href="#" class="action" id="RemoveEntry" onclick="RemoveEntry('+counter+')" title="Remove Entry" tabindex="-1"><span class="typcn typcn-minus"></span></a></div></td>'
                   + ' </tr>'
                );
                SetValue("counter",counter);
            }
        } else {
            counter = 0;
            $('#displayList').empty();
            $('#displayList').append('<tr><td style="background-color: #f6f6f6; padding:2px; width:22%; text-align: right;">No description found.</td><td style="background-color: #f6f6f6;"></td></tr>');
        }
        SetValue("counter",counter);
        DisplayMode("btnNew","EN");
        DisplayMode("btnSave","EN");
    } else {
        DisplayMode("btnNew","DI");
        DisplayMode("btnSave","DI");
        $('#displayList').empty();
    } 
    HideLoading();
}

function New(){
    ShowLoading();
    var vrows = document.getElementsByName("dynfields");
    var data = false;
    if(vrows.length > 0){
        data = true;
    }
    if(!data){
        $('#displayList').empty();
    }
    var counter = parseInt(GetValue("counter")) + 1;
        $('#displayList').append(
            '<tr id="tr_'+counter+'">'
                + ' <td style="background-color: #f6f6f6; padding: 2px; width: 22%; text-align: right;">Description '+counter+'</td>'
                + ' <td style="background-color: #f6f6f6; padding: 2px; "><input type="text" name="dynfields" id="description_'+counter+'" value="" style="width:390px;" maxlenght="50">'
                + ' <div style="float:right; margin-right:-2px; margin-top:5px"><a oncontextmenu="return false;" href="#" class="action" id="RemoveEntry" onclick="RemoveEntry('+counter+')" title="Remove Entry" tabindex="-1"><span class="typcn typcn-minus"></span></a></div></td></td>'
           + ' </tr>'
        );
    SetValue("counter",counter);
    DisplayMode("btnSave","EN");
    HideLoading();
}

function Save(){
    ShowLoading();
    var vrows = document.getElementsByName("dynfields");
    DeleteDB("delete from was_hotel_room_type_desc where room_type ='"+GetValue("room_type")+"'");
    for (var x = 0; x < vrows.length; x++) {
        var description = vrows[x].getAttribute( 'id' );
        if(GetValue(description) !== ""){
            var result = InsertDB("insert into was_hotel_room_type_desc(room_type, description) values('"+GetValue("room_type")+"','"+GetValue(description)+"')");
            if(result === ""){
                alert("Error occur while saving records");
                HideLoading();
                return;
            }
        }   
    }
    OC_room_type()
    alert("Save record successfully");
    HideLoading();
}

function RemoveEntry(counter){
    var d = document.getElementById('displayList');
    var olddiv = document.getElementById('tr_'+counter);
    d.removeChild(olddiv);
}
</script>