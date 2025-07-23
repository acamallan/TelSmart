<script>
/*functions required. onPageLoad, onAddNewUpdate, onAmendUpdate, onAddNew, onAmend, OnDelete*/
function  onPageLoad(){
    SetValue("strNarrCount", "0");
    SetValue("strNarrative", "");
    SetValue("account_type[1]", "");
    SetValue("narrative[1]", "");
    var strSQL = "select narrative, account_type, debit, credit from was_journal_entry where journal_id = '"+GetValue("journal_id")+"'";
    var strReturn = SelectDB(strSQL);
    SetValue("strCounter",1);
    if(strReturn != ""){
        var record = strReturn.split('~');
        $("#journalEntry").find("tr:gt(0)").remove();
        for(x = 1; x <= record.length; x++){
            var data = record[x-1].split('^');
            if(x == 1){
                var debit = "";
                if (data[2] != "null"){
                    debit = data[2];
                }
                
                var credit = "";
                if (data[3] != "null"){
                    credit = data[3];
                }
                SetValue("narrative[1]",data[0]);
                SetValue("account_type[1]",data[1]);
                SetValue("debit[1]",debit);
                SetValue("credit[1]",credit);
                DisplayMode('narrative[1]','DI');
                DisplayMode('account_type[1]','DI');
                DisplayMode('debit[1]','DI');
                DisplayMode('credit[1]','DI');
                SetValue("strCounter",1);
            } else {
                var counter = parseInt(document.getElementById('strCounter').value) + 1;
                var strSelectOptAcctType = document.getElementById('strSelectOptAcctType').value;
                var strSelectOptAcctType = strSelectOptAcctType.replace(/counter/g, counter);
                var strDR = "totalCrDr('debit')";
                var strCR = "totalCrDr('credit')";
                
                var debit = "";
                if (data[2] != "null"){
                    debit = data[2];
                }
                
                var credit = "";
                if (data[3] != "null"){
                    credit = data[3];
                }
                
                $('#journalEntry').append(
                    '<tr id="trJournal[' + counter + ']"><td style="padding:3px">'+strSelectOptAcctType+'</td>'
                        + '<td style="padding:3px"><input type="text" name="dynfields" id="narrative[' + counter + ']" onblur="LostFocus(\'LF_narrative(' + counter + ')\')"></td>' 
                        + '<td style="text-align:center;"><input type="text" name="dynfields" id="debit[' + counter + ']" value="'+debit+'" style="width:100px;text-align: right;" onkeypress="validate(event)" onblur="formatDecimal(this);'+strDR+'" disabled ></td>'
                        + ' <td style="text-align:center;"><input type="text" name="dynfields" id="credit[' + counter + ']" value="'+credit+'" style="width:100px;text-align: right;" onkeypress="validate(event)" onblur="formatDecimal(this);'+strCR+'" disabled ></td>'
                    + '</tr>'
                );
                SetValue("narrative[" + counter + "]",data[0]);
                SetValue("account_type[" + counter + "]",data[1]);
                DisplayMode("narrative[" + counter + "]","DI");
                DisplayMode("account_type[" + counter + "]","DI");
                DisplayMode("debit[" + counter + "]","DI");
                DisplayMode("credit[" + counter + "]","DI");
                SetValue("strCounter",counter);
            }
        } 
        totalCrDr('debit');
        totalCrDr('credit')
    } else {
        $("#journalEntry").find("tr:gt(0)").remove();
        SetValue("narrative[1]","");
        SetValue("account_type[1]","");
        SetValue("debit[1]","");
        SetValue("credit[1]","");
        SetValue("strCounter",1);
    }
}   

/* onAddNewUpdate */
function onAddNewUpdate(){
    if(GetValue("strTotalDebit") != GetValue("strTotalCredit")){
        alert("Incorrect Total!");
        return;
    }
    SetValue('journal_id',pad(GetCounter("003","10"),"10"));
    var vrows = document.getElementsByName("dynfields");
    var i = 0;
    var isUpdate = true;
    for (var x = 0; x < vrows.length/4; x++) {
        var narrative = vrows[i].getAttribute( 'id' );
        var account_type = vrows[i+1].getAttribute( 'id' );
        var debit = vrows[i+2].getAttribute( 'id' );
        var credit = vrows[i+3].getAttribute( 'id' );
        var strInsert = "insert into was_journal_entry (journal_id,notes, record_date,narrative,account_type,debit,credit)"+
                            " values('"+GetValue("journal_id")+"','"+GetValue("notes")+"','"+GetValue("record_date")+"','"+GetValue(narrative)+"','"+GetValue(account_type)+"','"+GetValue(debit)+"','"+GetValue(credit)+"')";
        var strReturn = InsertDB(strInsert);
        if (strReturn == ""){
            var isUpdate = false;
        }
        var i = i+4;
        DisplayMode("notes", "DI");
        DisplayMode(narrative, "DI");
        DisplayMode(account_type, "DI");
        DisplayMode(debit, "DI");
        DisplayMode(credit, "DI");
    }

    $('#AddEntry').remove();
    if(isUpdate){
        alert("Record Update Successfully");
    } else {
        alert("Error occur while updating record");
    }
    document.getElementById("rowid").value = GetValue("journal_id");
    document.getElementById("addnew").disabled = false;
    document.getElementById("amend").disabled = false;
    document.getElementById("update").disabled = true;
    document.getElementById("delete").disabled = false;
    document.getElementById("mode").value = "";
    document.getElementById("done").value = "Done";
    document.getElementById("done").onclick = function() { window.location.assign(mainURL()); };
    displayFilter("true");
}

/* onAmendUpdate */
function onAmendUpdate(){
    var strDelete = "delete from was_journal_entry where journal_id = '"+GetValue("journal_id")+"'";
    DeleteDB(strDelete);
    var vrows = document.getElementsByName("dynfields");
    var i = 0;
    var isUpdate = true;
    for (var x = 0; x < vrows.length/4; x++) {
        var narrative = vrows[i].getAttribute( 'id' );
        var account_type = vrows[i+1].getAttribute( 'id' );
        var debit = vrows[i+2].getAttribute( 'id' );
        var credit = vrows[i+3].getAttribute( 'id' );
        var strInsert = "insert into was_journal_entry (journal_id,notes, record_date,narrative,account_type,debit,credit)"+
                            " values('"+GetValue("journal_id")+"','"+GetValue("notes")+"','"+GetValue("record_date")+"','"+GetValue(narrative)+"','"+GetValue(account_type)+"','"+GetValue(debit)+"','"+GetValue(credit)+"')";
        var strReturn = InsertDB(strInsert);
        if (strReturn == ""){
            var isUpdate = false;
        }
        var i = i+4;
        DisplayMode("notes", "DI");
        DisplayMode(narrative, "DI");
        DisplayMode(account_type, "DI");
        DisplayMode(debit, "DI");
        DisplayMode(credit, "DI");
    }

    $('#AddEntry').remove();
    if(isUpdate){
        alert("Record Update Successfully");
    } else {
        alert("Error occur while updating record");
    }
    document.getElementById("rowid").value = GetValue("journal_id");
    document.getElementById("addnew").disabled = false;
    document.getElementById("amend").disabled = false;
    document.getElementById("update").disabled = true;
    document.getElementById("delete").disabled = false;
    document.getElementById("mode").value = "";
    document.getElementById("done").value = "Done";
    document.getElementById("done").onclick = function() { window.location.assign(mainURL()); };
    displayFilter("true");
    
}

/* onAddNew */
function onAddNew(){
    <%
    
    %>
    SetValue("record_date", "<%= CurrentDate() %>");
    $("#journalEntry").find("tr:gt(0)").remove();
    SetValue("narrative[1]","");
    SetValue("account_type[1]","");
    SetValue("debit[1]","");
    SetValue("credit[1]","");
    SetValue("strTotalDebit","0.00");
    SetValue("strTotalCredit","0.00");
    document.getElementById("totalDebit").innerHTML = "0.00";
    document.getElementById("totalCredit").innerHTML = "0.00";
    DisplayMode('narrative[1]','EN');
    DisplayMode('account_type[1]','EN');
    DisplayMode('debit[1]','EN');
    DisplayMode('credit[1]','EN');
    $('#tdAddEntry').append('<a oncontextmenu="return false;" href="#" class="action" id="AddEntry" onclick="AddEntryJournal()" title="Add Entry"><span class="typcn typcn-plus"></span>Add Entry </a>');
}

/* onAmend */
function onAmend(){
    var strSQL = "select narrative, account_type, debit, credit from was_journal_entry where journal_id = '"+GetValue("journal_id")+"'";
    var strReturn = SelectDB(strSQL);
    SetValue("strCounter",1);
    if(strReturn != ""){
        var record = strReturn.split('~');
        $("#journalEntry").find("tr:gt(0)").remove();
        for(x = 1; x <= record.length; x++){
            var data = record[x-1].split('^');
            if(x == 1){
                var debit = "";
                if (data[2] != "null"){
                    debit = data[2];
                }
                
                var credit = "";
                if (data[3] != "null"){
                    credit = data[3];
                }
                SetValue("narrative[1]",data[0]);
                SetValue("account_type[1]",data[1]);
                SetValue("debit[1]",debit);
                SetValue("credit[1]",credit);
                DisplayMode('narrative[1]','DI');
                DisplayMode('account_type[1]','DI');
                DisplayMode('debit[1]','DI');
                DisplayMode('credit[1]','DI');
                SetValue("strCounter",1);
            } else {
                var counter = parseInt(document.getElementById('strCounter').value) + 1;
                var strSelectOptAcctType = document.getElementById('strSelectOptAcctType').value;
                var strSelectOptAcctType = strSelectOptAcctType.replace(/counter/g, counter);
                var strDR = "totalCrDr('debit')";
                var strCR = "totalCrDr('credit')";
                
                var debit = "";
                if (data[2] != "null"){
                    debit = data[2];
                }
                
                var credit = "";
                if (data[3] != "null"){
                    credit = data[3];
                }
                
                $('#journalEntry').append(
                    '<tr id="trJournal[' + counter + ']"><td style="padding:3px">'+strSelectOptAcctType+'</td>'
                        //+ '<td style="padding:3px">'+strSelectOptAcctType+'</td>'
                        + '<td style="padding:3px"><input type="text" name="dynfields" id="narrative[' + counter + ']" onblur="LostFocus(\'LF_narrative(' + counter + ')\')"></td>' 
                        + '<td style="text-align:center;"><input type="text" name="dynfields" id="debit[' + counter + ']" value="'+debit+'" style="width:100px;text-align: right;" onkeypress="validate(event)" onblur="formatDecimal(this);'+strDR+'" disabled ></td>'
                        + ' <td style="text-align:center;"><input type="text" name="dynfields" id="credit[' + counter + ']" value="'+credit+'" style="width:100px;text-align: right;" onkeypress="validate(event)" onblur="formatDecimal(this);'+strCR+'" disabled >'
                        + ' </td>'
                    + '</tr>'
                );
                SetValue("narrative[" + counter + "]",data[0]);
                SetValue("account_type[" + counter + "]",data[1]);
                DisplayMode("narrative[" + counter + "]","DI");
                DisplayMode("account_type[" + counter + "]","DI");
                DisplayMode("debit[" + counter + "]","DI");
                DisplayMode("credit[" + counter + "]","DI");
                SetValue("strCounter",counter);
            }
        } 
        totalCrDr('debit');
        totalCrDr('credit');
    }
}

/* OnDelete */
function OnDelete(){
    
}

/* onCancelAddNew */
function onCancelAddNew(){
    $('#AddEntry').remove();
}

/* onCancelAmend */
function onCancelAmend(){
    $('#AddEntry').remove();
}

function totalCrDr(id){
    var strCounter = document.getElementById('strCounter').value;
    var strTotalDr = 0;
    var strTotalCr = 0;
    var usertext ="";
    for(var x = 1; x <= strCounter; x++){
        var strDr = 'debit['+x+']';
        if (document.getElementById(strDr) != null){
            var strAmount = document.getElementById(strDr).value;
            if (strAmount != ""){
                strTotalDr = strTotalDr + parseFloat(strAmount);
            }
	}
	
        var strCr = 'credit['+x+']';
	if (document.getElementById(strCr) != null){
            var strAmount = document.getElementById(strCr).value;
            if (strAmount != ""){
                strTotalCr = strTotalCr + parseFloat(strAmount);
            }
	}
    }

    document.getElementById("totalDebit").innerHTML = strTotalDr.toFixed(2);
    document.getElementById("strTotalDebit").value = strTotalDr.toFixed(2);
    document.getElementById("totalCredit").innerHTML = strTotalCr.toFixed(2);
    document.getElementById("strTotalCredit").value = strTotalCr.toFixed(2);

    if (document.getElementById("totalDebit").textContent == document.getElementById("totalCredit").textContent){
        document.getElementById("totalDebit").style.color='#39C';
	document.getElementById("totalCredit").style.color='#39C';
    } else {
        document.getElementById("totalDebit").style.color='red';
	document.getElementById("totalCredit").style.color='red';
    }
}

function LF_narrative(counter){
   if(GetValue("strNarrCount") < counter){
       SetValue("strNarrative",GetValue("narrative["+counter+"]"));
       SetValue("strNarrCount", counter);
   }
}

function LF_account_type(counter){
    var fldNarrative = "narrative["+counter+"]";
  //  alert(strNar)
    SetValue(fldNarrative,GetValue("strNarrative"));
}
</script>