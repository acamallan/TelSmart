$(function() {
    ShowLoading();
    document.getElementById("addnew").disabled = true;
    document.getElementById("amend").disabled = true;
    document.getElementById("delete").disabled = true;
    
    var pageMode = document.getElementById('pageMode').value;
    if (pageMode !== "") {
        pageMode = pageMode.split(',');
        for(x = 0; x < pageMode.length; x++){
            if(pageMode[x] === "N"){
                document.getElementById("addnew").disabled = false;
            }
            if(pageMode[x] === "E"){
                document.getElementById("amend").disabled = false;
            }
            if(pageMode[x] === "D"){
                document.getElementById("delete").disabled = false;
            }
        }
    }
    
    document.getElementById("update").disabled = true;
    document.getElementById("done").value = "Close";
    document.getElementById("mode").value = "";
    document.getElementById("hd_flrValue").value = "";
    filterField();
    if(typeof loadComboSelect === 'function'){
        loadComboSelect();
    }
    displayFilter("false");
    if(document.getElementById("mode").value === ""){
        onPageLoad();
        SetStyle("select","display","none");
        if(getParameterByName("addnew") == 1){
            SetStyle("select","display","inline");
            document.getElementById("select").disabled = false;
        }
    } else if(document.getElementById("mode").value === "add"){
        SetStyle("select","display","none");
        if(getParameterByName("addnew") == 1){
            SetStyle("select","display","inline");
            document.getElementById("select").disabled = true;
        }
    } 
        
    SetSession("qryStmt","");
    SetSession("isUpdatePage",false);
    HideLoading();
});
  
function AddNew(){
    /*clear the fields*/
    ShowLoading();
    var fields = document.getElementById("lstFields").value;
    if(fields !== ""){
        fields = fields.split(',');
        for(x = 1; x < fields.length; x++){
            var fieldID = "#"+fields[x].trim();
            $(fieldID).val("");
            document.getElementById(fields[x].trim()).readOnly = true;
            document.getElementById(fields[x].trim()).className = "disabled";
        }
    }
    
    
    var fields = document.getElementById("enableFields").value;
    if(fields !== ""){
        fields = fields.split(',');
        for(x = 0; x < fields.length; x++){
            document.getElementById(fields[x].trim()).readOnly = false;
            document.getElementById(fields[x].trim()).className = "";
            
            var select = document.getElementsByTagName("select");
            for (var i = 0 ; i < select.length ; i++){
                var field = select[i].getAttribute("name");
                if(field == fields[x].trim()){
                    document.getElementById(field).onfocus = function() { };
                    document.getElementById(field).onchange = function() { };
                }
            }
            if(x === 0){
                document.getElementById(fields[x].trim()).focus();
            }
        }
    }
    
    document.getElementById("addnew").disabled = true;
    document.getElementById("amend").disabled = true;
    document.getElementById("delete").disabled = true;
    document.getElementById("update").disabled = false;
    document.getElementById("done").value = "Cancel";
    document.getElementById("mode").value = "add";
    document.getElementById("done").onclick = function() { Cancel(); };
    document.getElementById("select").disabled = true;
    onAddNew();
    HideLoading();
}

function Amend(){
    ShowLoading();
    var fields = document.getElementById("amendableFields").value;
    fields = fields.split(',');
    for(x = 0; x < fields.length; x++){
        document.getElementById(fields[x].trim()).readOnly = false;
        document.getElementById(fields[x].trim()).className = "";
        
        var select = document.getElementsByTagName("select");
        for (var i = 0 ; i < select.length ; i++){
            var field = select[i].getAttribute("name");
            if(field == fields[x].trim()){
                document.getElementById(field).onfocus = function() { };
                document.getElementById(field).onchange = function() { };
            }
        }
            
        if(x ==0){
            document.getElementById(fields[x].trim()).focus();
        }
    }
    document.getElementById("addnew").disabled = true;
    document.getElementById("amend").disabled = true;
    document.getElementById("delete").disabled = true;
    document.getElementById("update").disabled = false;
    document.getElementById("done").value = "Cancel";
    document.getElementById("mode").value = "amend";
    document.getElementById("done").onclick = function() { Cancel(); };
    document.getElementById("select").disabled = true;
    onAmend();
    HideLoading();
}

function Update(){
    ShowLoading();
    var requiredFields = document.getElementById("requiredFields").value;
    if(requiredFields !== ""){
        requiredFields = requiredFields.split(',');
        var checkrequiredFields = 0;
        for(x = 0; x < requiredFields.length; x++){
            var fieldID = "#"+requiredFields[x].trim();
            if($(fieldID).val() === ""){
                document.getElementById("lb_"+requiredFields[x].trim()).style.color ="red";
                checkrequiredFields = 1;
            } else {
                document.getElementById("lb_"+requiredFields[x].trim()).style.color ="black";
            }
        }

        if(checkrequiredFields ===1){
            alert("Please input the required fields");
            HideLoading();
            return;  
        }
    }
     var error = false;
    if(document.getElementById("mode").value == "add"){
        sessionStorage.setItem('success', true);
        SetSession("isUpdatePage",true);
        onAddNewUpdate();
        var qryStmt = GetSession("qryStmt");
        if(sessionStorage.getItem('success') == "true"){
            GetInputName('strField'); 
            GetRecord('strValue');
            var table = document.getElementById("table").value;
            var strField = document.getElementById("strField").value;
            var strValue = document.getElementById("strValue").value;
            var lstFields = document.getElementById("lstFields").value;

            $.ajax({
                url: baseURL()+'functions/record_functionjs.jsp',
                data: {functionname:encryptJS("AddNewRecord"), table:encryptJS(table), strField:encryptJS(strField), strValue:encryptJS(strValue), lstFields:encryptJS(lstFields), qryStmt:encryptJS(qryStmt)},
                type: 'POST',
                async: false,
                success: function(response) {
                    ShowLoading();
                    if (decryptJS(response.trim()) != "null"){
                        alert("Record Update Successfully");
                        SetSession("qryStmt","");
                        SetSession("isUpdatePage",false);
                        displayFilter("true");
                        var fields = document.getElementById("lstFields").value;
                        fields = fields.split(',');
                        for(x = 1; x < fields.length; x++){
                            document.getElementById(fields[x].trim()).readOnly = true;
                            document.getElementById(fields[x].trim()).className = "disabled";
                            
                            var select = document.getElementsByTagName("select");
                            for (var i = 0 ; i < select.length ; i++){
                                var field = select[i].getAttribute("name");
                                if(field == fields[x].trim()){
                                    document.getElementById(field).onfocus = function() { this.setAttribute('data-value', this.value);};
                                    document.getElementById(field).onchange = function() { this.value = this.getAttribute('data-value'); };
                                }
                            }
                        }
                       
                        if(decryptJS(response.trim()) == "-1"){ // get the unique value
                            document.getElementById("rowid").value = document.getElementById(fields[1].trim()).value;
                        } else { // get the auto increment value
                            document.getElementById("rowid").value = decryptJS(response.trim());
                        }
                        onPageLoad();
                        document.getElementById("addnew").disabled = true;
                        document.getElementById("amend").disabled = true;
                        document.getElementById("update").disabled = true;
                        document.getElementById("delete").disabled = true;
                        document.getElementById("mode").value = "";
                        document.getElementById("done").value = "Close";
                        document.getElementById("done").onclick = function() { window.close(); };
                        document.getElementById("select").disabled = false;
                        if(typeof postAddNewUpdate === 'function'){
                            postAddNewUpdate();
                        }
                    } else {
                        alert("Error occur while updating record");
                        SetSession("qryStmt","");
                        SetSession("isUpdatePage",false);
                        if(typeof onAddNewUpdateError === 'function'){
                            onAddNewUpdateError();
                        }
                        error = true;
                    }
                    HideLoading();
                }
            });
        }
    } else if(document.getElementById("mode").value == "amend") {
        if(document.getElementById("mode").value == ""){
            return;
        }
        sessionStorage.setItem('success', true);
        SetSession("isUpdatePage",true);
        onAmendUpdate();
        var qryStmt = GetSession("qryStmt");
        if(sessionStorage.getItem('success') == "true"){
            GetInputName('strField'); 
            GetRecord('strValue');
            var table = document.getElementById("table").value;
            var strField = document.getElementById("strField").value;
            var strValue = document.getElementById("strValue").value;
            var lstFields = document.getElementById("lstFields").value;
            var where = document.getElementById("where").value;
            var rowid = document.getElementById("rowid").value;
            $.ajax({
                url: baseURL()+'functions/record_functionjs.jsp',
                data: {functionname:encryptJS("UpdateRecord"), table:encryptJS(table), strField:encryptJS(strField), strValue:encryptJS(strValue), where:encryptJS(where), rowid:encryptJS(rowid), lstFields:encryptJS(lstFields), qryStmt:encryptJS(qryStmt)},
                type: 'POST',
                async: false,
                success: function(response) {
                    ShowLoading();
                    if (decryptJS(response.trim()) == 1){
                        SetSession("qryStmt","");
                        SetSession("isUpdatePage",false);
                        alert("Record Update Successfully");
                        displayFilter("true");
                        var fields = document.getElementById("lstFields").value;
                        fields = fields.split(',');
                        for(x = 1; x < fields.length; x++){
                            document.getElementById(fields[x].trim()).readOnly = true;
                            document.getElementById(fields[x].trim()).className = "disabled";
                            
                            var select = document.getElementsByTagName("select");
                            for (var i = 0 ; i < select.length ; i++){
                                var field = select[i].getAttribute("name");
                                if(field == fields[x].trim()){
                                    document.getElementById(field).onfocus = function() { this.setAttribute('data-value', this.value);};
                                    document.getElementById(field).onchange = function() { this.value = this.getAttribute('data-value'); };
                                }
                            }
                        }
                        
                        onPageLoad();
                        document.getElementById("addnew").disabled = true;
                        document.getElementById("amend").disabled = true;
                        document.getElementById("update").disabled = true;
                        document.getElementById("delete").disabled = true;
                        document.getElementById("done").value = "Close";
                        document.getElementById("mode").value = "";
                        document.getElementById("done").onclick = function() { window.close(); };
                        document.getElementById("select").disabled = false;
                        if(typeof postAmendUpdate === 'function'){
                            postAmendUpdate();
                        }
                    } else {
                        SetSession("qryStmt","");
                        SetSession("isUpdatePage",false);
                        alert("Error occur while updating record");
                        if(typeof onAmendUpdateError === 'function'){
                            onAmendUpdateError();
                        }
                        error = true;
                    }
                    HideLoading();
                }
            });
        }
    }
    if(sessionStorage.getItem('success') == "true"){
        if(!error){
            var pageMode = document.getElementById('pageMode').value;
            if (pageMode !== "") {
                pageMode = pageMode.split(',');
                for(x = 0; x < pageMode.length; x++){
                    if(pageMode[x] === "N"){
                        document.getElementById("addnew").disabled = false;
                    }
                    if(pageMode[x] === "E"){
                        document.getElementById("amend").disabled = false;
                    }
                    if(pageMode[x] === "D"){
                        document.getElementById("delete").disabled = false;
                    }
                }
            }
        }
    }
    HideLoading();
}

function Delete(){
    if (confirm('Are you sure delete this record?')){
        ShowLoading();
        OnDelete();
        var table = document.getElementById("table").value;
        var where = document.getElementById("where").value;
        var rowid = document.getElementById("rowid").value;
        $.ajax({
            url: baseURL()+'functions/record_functionjs.jsp',
            data: {functionname:encryptJS("DeleteRecord"), table:encryptJS(table), where:encryptJS(where), rowid:encryptJS(rowid)},
            type: 'POST',
            async: false,
            success: function(response) {
                if (decryptJS(response.trim()) == 1){
                    alert("Delete record successfully");
                    document.getElementById("current_page").value = 0;
                    displayFilter("false");
                    var strRecord = sessionStorage.getItem('response');
                    if(strRecord !== "null"){
                       DisplayRecord(0);
                    }
               } else {
                    alert("Error occur while deleting record");
               }
            }
        });
        HideLoading();
    }
    if(document.getElementById('mode').value === ""){
    var pageMode = document.getElementById('pageMode').value;
    if (pageMode !== "") {
        pageMode = pageMode.split(',');
        for(x = 0; x < pageMode.length; x++){
            if(pageMode[x] === "N"){
                document.getElementById("addnew").disabled = false;
            }
            if(pageMode[x] === "E"){
                document.getElementById("amend").disabled = false;
            }
            if(pageMode[x] === "D"){
                document.getElementById("delete").disabled = false;
            }
        }
    }
    }
}
function Cancel(){
    if (confirm('Are you sure to cancel this operation?')){
        if(document.getElementById("mode").value == "amend"){
            DisplayRecordAmend(document.getElementById("count").value);
        } else {
            if(document.getElementById("count").value == ""){
                var fields = document.getElementById("lstFields").value;
                fields = fields.split(',');
                for(x = 1; x < fields.length; x++){
                    document.getElementById(fields[x].trim()).readOnly = true;
                    document.getElementById(fields[x].trim()).className = "disabled";
                    
                    var select = document.getElementsByTagName("select");
                    for (var i = 0 ; i < select.length ; i++){
                        var field = select[i].getAttribute("name");
                        if(field == fields[x].trim()){
                            document.getElementById(field).onfocus = function() { this.setAttribute('data-value', this.value);};
                            document.getElementById(field).onchange = function() { this.value = this.getAttribute('data-value'); };
                        }
                    }
                }
            } else {
                DisplayRecordAmend(document.getElementById("count").value);
                document.getElementById("amend").disabled = true;
                 document.getElementById("delete").disabled = true;
            }
        }
        if(document.getElementById("mode").value == "add"){
            if(typeof onCancelAddNew === 'function'){
                onCancelAddNew();
            }
        } else if (document.getElementById("mode").value == "amend"){
            if(typeof onCancelAmend === 'function'){
                onCancelAmend();
            }
        }
        document.getElementById("update").disabled = true;
        document.getElementById("done").value = "Close";
        document.getElementById("mode").value = "";
        document.getElementById("done").onclick = function() { window.close(); };
        var count = document.getElementById("count").value;
        DisplayRecord(count);
        
        /*Reset the label text color to black*/
        var requiredFields = document.getElementById("requiredFields").value;
        requiredFields = requiredFields.split(',');
        for(x = 0; x < requiredFields.length; x++){
            document.getElementById("lb_"+requiredFields[x].trim()).style.color ="black";
        }
        document.getElementById("addnew").disabled = true;
        document.getElementById("amend").disabled = true;
        document.getElementById("delete").disabled = true;
        document.getElementById("select").disabled = false;
        var pageMode = document.getElementById('pageMode').value;
        if (pageMode !== "") {
            pageMode = pageMode.split(',');
            for(x = 0; x < pageMode.length; x++){
                if(pageMode[x] === "N"){
                    document.getElementById("addnew").disabled = false;
                }
                if(pageMode[x] === "E"){
                    document.getElementById("amend").disabled = false;
                }
                if(pageMode[x] === "D"){
                    document.getElementById("delete").disabled = false;
                }
            }
        }
        return;
    }
}

function Find(value){
    if((document.getElementById("mode").value == "add") || (document.getElementById("mode").value == "amend")){
        alert("Not allowed. Add New or Amend is enabled.");
        document.getElementById("hd_flrField").value = "";
        return;
    }
    setTimeout(function(){ 
        var table = document.getElementById("table").value;
        var lstFields = document.getElementById("lstFields").value;
        var current_page = document.getElementById("current_page").value;
        var mainWhere = document.getElementById("mainWhere").value;
        var whereField = document.getElementById("hd_flrField").value;
        if(value == ""){
            var where = "";
        } else {
            var where = "lower("+whereField +") like lower('%"+value+"%')";
        }

        if(mainWhere != "" && where != ""){
           where = where + " and " +  mainWhere;
        } else if (mainWhere != ""){
            where = mainWhere;
        }

        var orderby = document.getElementById("orderby").value;
        var limit = "0,15";
        $.ajax({
            url: baseURL()+'functions/record_functionjs.jsp',
            data: {functionname:encryptJS("displayFilter"), table:encryptJS(table), lstFields:encryptJS(lstFields), where: encryptJS(where), orderby:encryptJS(orderby), limit:encryptJS(limit)},
            type: 'POST',
            async: false,
            success: function(response) {
                response = decryptJS(response.trim());
                sessionStorage.setItem('response', response);
                response = response.split('~');
                var display = "<div class='pageRecordFilter'><table><thead><tr >";    
                var fields = document.getElementById("lstFields").value;
                var field = fields.split(',');
                for (var x=1; x < 3; x++){
                    display = display + " <th style='padding: 0.5em 1.5em;'>"+capitalizeEachWord(field[x].replace(/_/g," "))+"</th>";
                }
                display = display + " </tr></thead>";  
                for (var i=0; i < response.length; i++){
                    var display = display + "<tr>";
                    var value = response[i].split('^');
                    if (response == "null"){
                        display = display + "<td colspan='2' style='padding: 0.5em 1.5em;'>No records found</td>";
                        var fields = document.getElementById("lstFields").value;
                        fields = fields.split(',');
                        for(x = 1; x < fields.length; x++){
                            document.getElementById(fields[x].trim()).value = "";
                        }
                        onPageLoad();
                    } else {
                        for (var x=1; x < 3; x++){
                            display = display + "<td style='padding: 0.5em 1.5em;'><div onclick=\'DisplayRecord(\""+i+"\")\' style='cursor:pointer;'>" + value[x] + "</div></td>";
                        }
                        DisplayRecord(-1);
                    }
                    var display = display + "</tr>";
                }
                var display = display + "</table></div>";
                document.getElementById("displayFilter").innerHTML = display;
                document.getElementById("current_page").value = 0;

            }
        }); 
    }, 1000);
}
function filterField(){
    var flrField = document.getElementById("hd_flrField");
    var fields = document.getElementById("lstFields").value;
    fields = fields.split(',');
    for(x = 1; x < fields.length; x++){
        var opt = document.createElement('option');
        opt.value = fields[x].trim();
        opt.innerHTML = fields[x];
        flrField.appendChild(opt);
    }
}

function checkFilterField(){
    var fields = document.getElementById("lstFields").value;
    fields = fields.split(',');
    for(x = 1; x < 3; x++){
        if(fields[x].trim() == $('#hd_flrField').val()){
            return;
        }
    }
    
    var newlstFields ="";
    for(x = 0; x < fields.length; x++){
        if(x == 2){
            newlstFields = newlstFields + $('#hd_flrField').val()+"," ;
        } else {
            if(fields[x].trim() == $('#hd_flrField').val()){
                newlstFields = newlstFields + fields[2]+"," ;
            } else {
                newlstFields = newlstFields + fields[x]+"," ;
            }
        }
    }

    newlstFields = newlstFields.substring(0, newlstFields.length - 1);
    document.getElementById("lstFields").value = newlstFields;
}

function displayFilter(isupdate){
    var table = document.getElementById("table").value;
    var lstFields = document.getElementById("lstFields").value;
    var current_page = document.getElementById("current_page").value;
    var mainWhere = document.getElementById("mainWhere").value;
    var whereField = document.getElementById("hd_flrField").value;
    var whereValue = document.getElementById("hd_flrValue").value;
    if(whereValue == ""){
        var where = "";
    } else {
        var where = "lower("+whereField +") like lower('%"+whereValue+"%')";
    }
    
    if(mainWhere != "" && where != ""){
       where = where + " and " +  mainWhere;
    } else if (mainWhere != ""){
        where = mainWhere;
    }
    var orderby = document.getElementById("orderby").value;
    var limit = current_page+",15";
    $.ajax({
        url: baseURL()+'functions/record_functionjs.jsp',
        data: {functionname:encryptJS("displayFilter"), table:encryptJS(table), lstFields:encryptJS(lstFields), where: encryptJS(where), orderby:encryptJS(orderby), limit:encryptJS(limit)},
        type: 'POST',
        async: false,
        success: function(response) {
            response = decryptJS(response.trim());
            var display = "<div class='pageRecordFilter'><table><thead><tr>";
            var fields = document.getElementById("lstFields").value;
            var field = fields.split(',');
            for (var x=1; x < 3; x++){
                display = display + " <th style='padding: 0.5em 1.5em;'>"+capitalizeEachWord(field[x].replace(/_/g," "))+"</th>";
            }
            display = display + " </tr></thead>"; 
            sessionStorage.setItem('response', response);
            if (response == "null" || response == ""){
                display = display + "<td colspan='2' style='padding: 0.5em 1.5em;'>No records found</td>";
                var fields = document.getElementById("lstFields").value;
                fields = fields.split(',');
                for(x = 1; x < fields.length; x++){
                    document.getElementById(fields[x].trim()).value = "";
                }
                if(response == "null"){
                    alert("Error occur while executing the query.");
                } else {
                    alert("No records found");
                }
                var pageMode = document.getElementById('pageMode').value;
                var addnew = "";
                addnew = pageMode.search("N");
                if(addnew < 0){
                    alert("Not Allowed to input records");
                    window.location.href = baseURL()+"main.jsp";
                }
                document.getElementById("addnew").disabled = true;
                document.getElementById("update").disabled = false;
                document.getElementById("mode").value = "add";
                AddNew();
            } else {
                response = response.split('~');
                for (var i=0; i < response.length; i++){
                    var display = display + "<tr>";
                    var value = response[i].split('^');
                    for (var x=1; x < 3; x++){
                        display = display + "<td style='padding: 0.5em 1.5em;'><div onclick=\'DisplayRecord(\""+i+"\")\' style='cursor:pointer;'>" + value[x] + "</div></td>";
                    }
                    var display = display + "</tr>";
                }
                if(isupdate == "false"){
                    for (var i=0; i < response.length; i++){
                        if(i == 0){
                            var fields = document.getElementById("lstFields").value;
                            var fields = fields.split(',');
                            var value = response[i].split('^');
                            for (var x=1; x < value.length; x++){
                                document.getElementById(fields[x].trim()).readOnly = true;
                                document.getElementById(fields[x].trim()).className = "disabled";
                                
                                var select = document.getElementsByTagName("select");
                                for (i = 0 ; i < select.length ; i++){
                                   var field = select[i].getAttribute("name");
                                   if(field == fields[x].trim()){
                                       document.getElementById(field).onfocus = function() { this.setAttribute('data-value', this.value);};
                                       document.getElementById(field).onchange = function() { this.value = this.getAttribute('data-value'); };
                                   }
                                }
                                if($('#'+fields[x].trim()).is(':checkbox')){
                                    document.getElementById(fields[x].trim()).checked = false;
                                    if(value[x] !== ""){
                                        document.getElementById(fields[x].trim()).checked = true;
                                    }
                                } else {
                                    document.getElementById(fields[x].trim()).value = value[x].toString();
                                }
                             }
                             document.getElementById("rowid").value = value[0];
                         }
                    }
                }
                document.getElementById("amend").disabled = true;
                document.getElementById("delete").disabled = true;
                var pageMode = document.getElementById('pageMode').value;
                if (pageMode !== "") {
                    pageMode = pageMode.split(',');
                    for(x = 0; x < pageMode.length; x++){
                        if(pageMode[x] === "N"){
                            document.getElementById("addnew").disabled = false;
                        }
                        if(pageMode[x] === "E"){
                            document.getElementById("amend").disabled = false;
                        }
                        if(pageMode[x] === "D"){
                            document.getElementById("delete").disabled = false;
                        }
                    }
                }
            }
            var display = display + "</table></div>";
            document.getElementById("displayFilter").innerHTML = display;
        }
    });      
}

function DisplayRecord(count){
    if(count == -1){
        count = 0;
    } else {
        ShowLoading();
    }
    
    var strRecord = sessionStorage.getItem('response');
    if(strRecord === "null"){
        document.getElementById("displayFilter").innerHTML = "";
        document.getElementById("addnew").disabled = true;
        document.getElementById("amend").disabled = true;
        document.getElementById("delete").disabled = true;
        
        var fields = document.getElementById("lstFields").value;
                var fields = fields.split(',');
                
                for (var x=1; x < fields.length; x++){
                    document.getElementById(fields[x].trim()).readOnly = true;
                    document.getElementById(fields[x].trim()).className = "disabled";
                    document.getElementById(fields[x].trim()).value = "";
                    if($('#'+fields[x].trim()).is(':checkbox')){
                        document.getElementById(fields[x].trim()).checked = false;
                    } 
                }
                
        var pageMode = document.getElementById('pageMode').value;
        if (pageMode !== "") {
            pageMode = pageMode.split(',');
            for(x = 0; x < pageMode.length; x++){
                if(pageMode[x] === "N"){
                    document.getElementById("addnew").disabled = false;
                }
                if(pageMode[x] === "E"){
                    document.getElementById("amend").disabled = false;
                }
                if(pageMode[x] === "D"){
                    document.getElementById("delete").disabled = false;
                }
            }
        }
        HideLoading();
        return;
    }
    strRecord = strRecord.split('~');
    if((document.getElementById("mode").value == "add") || (document.getElementById("mode").value == "amend")){
        alert("Not allowed. Add New or Amend is enabled.");
        HideLoading();
        return;
    } else {
        for (var i=0; i < strRecord.length; i++){
           if(i == count){
                if(typeof preLoad === 'function'){
                    preLoad();
                }
                var fields = document.getElementById("lstFields").value;
                var fields = fields.split(',');
                var value = strRecord[i].split('^');
                for (var x=1; x < value.length; x++){
                    document.getElementById(fields[x].trim()).readOnly = true;
                    document.getElementById(fields[x].trim()).className = "disabled";
                    document.getElementById(fields[x].trim()).value = "";
                    $("#record_date").datepicker("disable");
                    if($('#'+fields[x].trim()).is(':checkbox')){
                        document.getElementById(fields[x].trim()).checked = false;
                        if(value[x] !== ""){
                            document.getElementById(fields[x].trim()).checked = true;
                        }
                    } else {
                        document.getElementById(fields[x].trim()).value = value[x].toString();
                    }
                }
                document.getElementById("rowid").value = value[0];
                onPageLoad();
            }
        }
        document.getElementById("amend").disabled = true;
        document.getElementById("count").value = count;
        document.getElementById("delete").disabled = true;
    }
    var pageMode = document.getElementById('pageMode').value;
    if (pageMode !== "") {
        pageMode = pageMode.split(',');
        for(x = 0; x < pageMode.length; x++){
            if(pageMode[x] === "N"){
                document.getElementById("addnew").disabled = false;
            }
            if(pageMode[x] === "E"){
                document.getElementById("amend").disabled = false;
            }
            if(pageMode[x] === "D"){
                document.getElementById("delete").disabled = false;
            }
        }
    }
    if(count !== "-1"){
        HideLoading();
    }
}

function DisplayRecordAmend(count){
   var strRecord = sessionStorage.getItem('response');
    strRecord = strRecord.split('~');
   
        for (var i=0; i < strRecord.length; i++){
           if(i === count){
                var fields = document.getElementById("lstFields").value;
                var fields = fields.split(',');
                var value = strRecord[i].split('^');
                for (var x=1; x < value.length; x++){
                    document.getElementById(fields[x].trim()).readOnly = true;
                    document.getElementById(fields[x].trim()).className = "disabled";
                    
                    var select = document.getElementsByTagName("select");
                    for (var i = 0 ; i < select.length ; i++){
                        var field = select[i].getAttribute("name");
                        if(field === fields[x].trim()){
                            document.getElementById(field).onfocus = function() { this.setAttribute('data-value', this.value);};
                            document.getElementById(field).onchange = function() { this.value = this.getAttribute('data-value'); };
                        }
                    }
                    if($('#'+fields[x].trim()).is(':checkbox')){
                        document.getElementById(fields[x].trim()).checked = false;
                        if(value[x] !== ""){
                            document.getElementById(fields[x].trim()).checked = true;
                        }
                    } else {
                        document.getElementById(fields[x].trim()).value = value[x].toString();
                    }
                }
                document.getElementById("rowid").value = value[0];
            }
        }
        document.getElementById("amend").disabled = true;
        document.getElementById("count").value = count;
        document.getElementById("delete").disabled = true;
    
    var pageMode = document.getElementById('pageMode').value;
    if (pageMode !== "") {
        pageMode = pageMode.split(',');
        for(x = 0; x < pageMode.length; x++){
            if(pageMode[x] === "N"){
                document.getElementById("addnew").disabled = false;
            }
            if(pageMode[x] === "E"){
                document.getElementById("amend").disabled = false;
            }
            if(pageMode[x] === "D"){
                document.getElementById("delete").disabled = false;
            }
        }
    }
    
}