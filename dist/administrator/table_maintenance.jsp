<%@include file="../header.jsp"%>
<%@include file="../functions/record_function.jsp"%>
<fieldset style="width:300px; height:580px; float:left; margin-top: 0px; border: 1px solid #ddd; background-color: #f6f6f6; padding:2px;" >
    <legend style="font-size: 12px; font-weight: bold; padding:0 10px">Tables</legend>
    <div class="component1" style="width:100%; height:550px; float:left; padding:0px; overflow: auto; ">
        <table>
            <thead>
                <tr>
                    <th style="text-align:center;">&nbsp;</th>
                </tr>
            </thead>
            <tbody>
                <%
            Connection conn = DBConnection();
            PreparedStatement qrySelect = conn.prepareStatement("select lower(table_name) as table_name from information_schema.tables where lower(table_schema) ='waya' and lower(left(table_name,6)) = 'was_cs'");
            ResultSet strQuery = qrySelect.executeQuery();
            while(strQuery.next()){
            %>
                <tr>
                    <td style="padding:5px; cursor: pointer;" onclick="viewTable('<%= strQuery.getString("table_name") %>')"> <%= strQuery.getString("table_name") %></td>
		</tr>				
            <% } %>
            </tbody>
        </table>
   </div>
</fieldset>
<fieldset style="width:900px; height: 570px; margin: auto; margin-top: 10px; border: 1px solid #ddd; background-color: #f6f6f6; padding:5px;"  >
    <legend style="font-size: 12px; font-weight: bold; padding:0 10px">Maintenance</legend>
    <div class="component1" style="width:100%; height:400px; float:left; padding:0px; overflow: auto; border: 1px solid; ">
        <table>
            <thead>
                <tr id="titleList">
                </tr>
            </thead>
            <tbody id="valueList">
            </tbody>
        </table>
    </div>
    <div style="position: relative; top: 420px;" id="input">
        
    </div>
    <div style="position: relative; top: 520px;">
        <div class="block" style="margin-left: 270px; top: 0px;">
            <input type="button" tabindex="7" name="btnNew" id="btnNew" value="New" style="width:100px;" onclick="New()">
            <input type="button" tabindex="8" name="btnSave" id="btnSave" value="Save" style="width:100px;" onclick="Save()">
            <input type="button" tabindex="8" name="btnClose" id="btnClose" value="Close" style="width:100px;" onclick="">
        </div>
    </div>
    <input type="hidden" name="table" id="table">
    <input type="hidden" name="field" id="field">
    <input type="hidden" name="id" id="id">
    <input type="hidden" name="mode" id="mode">
</fieldset>
<script>
    
$(function() {
    DisplayMode("btnNew","DI");
    DisplayMode("btnSave","DI");
    SetValue("btnClose","Close");
    SetValue("mode","");
    document.getElementById("btnClose").onclick = function() { window.location.assign('<%= baseURL()%>main.jsp'); };
});
function viewTable(tablename){
    ShowLoading();
    var qrySQL = "SELECT column_name, character_maximum_length FROM information_schema.columns WHERE lower(table_schema) = 'waya' and lower(table_name) = '"+tablename+"'";
    var result = SelectDB(qrySQL);
    var display = "";
    var input = "";
    var left = -20;
    var top = 0;
    var fieldname = "";
    if(result !== ""){
        display = display + "<tr>";
        var result = result.split('~');
        
        for (var i=0; i < result.length; i++){
            var value = result[i].split('^');
            fieldname = fieldname + value[0] + ',';
            display = display + "<th>"+value[0].replace("_"," ").toUpperCase()+"</th>";
            if(left > 650){
                left = -20;
                top = 30;
            }
            if(i===0){
                input = input + "<div class='block' style='margin-left: "+left+"px; top: "+top+"px; '> <label id='lb_"+value[0]+"' style='width:150px;'>"+value[0].replace("_"," ").toUpperCase()+"</label> <input type='text' name='"+value[0]+"' id='"+value[0]+"' style='width:120px;' maxlength='"+value[1]+"' onkeypress='validate(event);'> </div>";
            } else {
                input = input + "<div class='block' style='margin-left: "+left+"px; top: "+top+"px; '> <label id='lb_"+value[0]+"' style='width:150px;'>"+value[0].replace("_"," ").toUpperCase()+"</label> <input type='text' name='"+value[0]+"' id='"+value[0]+"' style='width:120px;' maxlength='"+value[1]+"'> </div>";
            }
            left = left + 280;
        }
        display = display + "<th style='width:15%;'>Action</th>";
        display = display + "</tr>";
    }
    SetValueInner("titleList","");
    SetValueInner("titleList",display);
    SetValueInner("input","");
    SetValueInner("input",input);
    var fieldname = fieldname.substring(0, fieldname.length-1);
    SetValue("table", tablename);
    SetValue("field",fieldname);
    LoadData();
    
    DisplayMode("btnNew","EN");
    DisplayMode("btnSave","DI");
    fieldname = fieldname.split(',');
    for(x = 0; x < fieldname.length; x++){
        document.getElementById(fieldname[x].trim()).readOnly = true;
        document.getElementById(fieldname[x].trim()).className = "disabled";
    }
    

   HideLoading();
}    

function New(){
    var field = GetValue("field");
    var field = field.split(',');
    for (var i=0; i < field.length; i++){
        SetValue(field[i],"");
        DisplayMode(field[i],"EN");
    } 
    
    SetValue("btnClose","Cancel");
    SetValue("mode","new");
    document.getElementById("btnClose").onclick = function() { Cancel(); };
    DisplayMode("btnSave","EN");
    DisplayMode("btnNew","DI");
}

function Edit(id){
    ShowLoading();
    var field = GetValue("field");
    var table = GetValue("table");
    var field = field.split(',');
    var qrySQL = "SELECT "+field+" FROM "+ table + "    where "+field[0] + " = '"+id+"'";
    var result = SelectDB(qrySQL);
    if(result !== ""){
        var value = result.split('^');
        for (var i=0; i < value.length; i++){
            SetValue(field[i],value[i]);
            DisplayMode(field[i],"EN");
        }    
    }
    SetValue("id",id);
    SetValue("btnClose","Cancel");
    SetValue("mode","edit");
    document.getElementById("btnClose").onclick = function() { Cancel(); };
    DisplayMode("btnSave","EN");
    DisplayMode("btnNew","DI");
    HideLoading();
}

function Save(){
    ShowLoading();
    var mode = GetValue("mode");
    var table = GetValue("table");
    var field = GetValue("field");
    var id = GetValue("id");
    if(mode === "edit"){
        field = field.split(',');
        var set = "";
        for (var i=0; i < field.length; i++){
            set = set + field[i] + "= '"+GetValue(field[i])+"',";
        }
        set = set.substring(0, set.length-1);
        var qryUpdate = "update " + table + " set " + set + " where "+field[0] + " = '"+id+"'";
        $.ajax({
            url: baseURL()+'functions/record_functionjs.jsp',
            data: {functionname:"UpdateDB", strSQL:qryUpdate},
            type: 'GET',
            async: false,
            success: function(response) {
                var result = response.trim();
                if(result === "null"){
                    alert("Error occur while executing the query.");
                    HideLoading();
                    return;
                } else {
                    alert("Record save successfully.");
                    Cancel();
                    SetValue("id","");
                    LoadData();
                }
            }
        });
    } else if(mode === "new"){
        field = field.split(',');
        var bln = false;
        var value = "";
        for (var i=0; i < field.length; i++){
            if(GetValue(field[i]) === ""){
                bln = true;
            }
            value = value + "'" + GetValue(field[i]) + "',";
        }
        if(bln){
            alert("Please input all fields.");
            HideLoading();
            return;
        }
        
        value = value.substring(0, value.length-1);
        var qryInsert = "insert into "+ table + " ("+field+") values("+value+")" ;
        $.ajax({
            url: baseURL()+'functions/record_functionjs.jsp',
            data: {functionname:"InsertDB", strSQL:qryInsert},
            type: 'GET',
            async: false,
            success: function(response) {
                var result = response.trim();
                if(result === "null"){
                    alert("Error occur while executing the query.");
                    HideLoading();
                    return;
                } else {
                    alert("Record save successfully.");
                    Cancel();
                    SetValue("id","");
                    LoadData();
                }
            }
        });
    }
    HideLoading();
    
}

function Delete(id){
    ShowLoading();
    var table = GetValue("table");
    var field = GetValue("field");
    field = field.split(',');
    var qryDelete = "delete from " + table + " where "+field[0] + " = '"+id+"'";
    $.ajax({
        url: baseURL()+'functions/record_functionjs.jsp',
        data: {functionname:"DeleteDB", strSQL:qryDelete},
        type: 'GET',
        async: false,
        success: function(response) {
            var result = response.trim();
            if(result === "null"){
                alert("Error occur while executing the query.");
                HideLoading();
                return;
            } else {
                alert("Record delete successfully.");
                Cancel();
                SetValue("id","");
                LoadData();
            }
        }
    });
    HideLoading();
}

function Cancel(){
    DisplayMode("btnNew","EN");
    DisplayMode("btnSave","DI");
    SetValue("btnClose","Close");
    SetValue("mode","");
    document.getElementById("btnClose").onclick = function() { window.location.assign('<%= baseURL()%>main.jsp'); };
    var field = GetValue("field");
    var field = field.split(',');
    for (var i=0; i < field.length; i++){
        SetValue(field[i],"");
        DisplayMode(field[i],"DI");
    }
}

function LoadData(){
    var table = GetValue("table");
    var field = GetValue("field");
    var qrySQL = "SELECT "+field+" FROM "+table;
    var result = SelectDB(qrySQL);
    var display = "";
    if(result !== ""){
        var result = result.split('~');
        for (var i=0; i < result.length; i++){
            display = display + "<tr>";
            var value = result[i].split('^');
            for (var x=0; x < value.length; x++){
                display = display + "<td style='padding:5px;'>"+value[x]+"</td>";
            }
            display = display + "<td style='text-align:center;'><a href='#' class='action' id='edit' onclick='Edit("+value[0]+");' ><span class='typcn typcn-pencil' title='Edit'></span>Edit</a>&nbsp;&nbsp;&nbsp;<a href='#' class='action' id='delete' onclick='Delete("+value[0]+")' title='Delete'><span class='typcn typcn-trash'></span>Delete</a></td>";
            display = display + "</tr>";
        }    
    }
    SetValueInner("valueList","");
    SetValueInner("valueList",display);
}
</script>
<script type="text/javascript" src="<%= baseURL()%>scripts/record.js"></script>
<%@include file="../footer.jsp"%>