$(function() {
    $("#record_date").mask('99.99.9999', {'translation': {0: {pattern: /[0-9*]/}}});
    $("#due_date").mask('99.99.9999', {'translation': {0: {pattern: /[0-9*]/}}});
    $("#effective_date").mask('99.99.9999', {'translation': {0: {pattern: /[0-9*]/}}});
    $("#expiry_date").mask('99.99.9999', {'translation': {0: {pattern: /[0-9*]/}}});
    $("#birth_date").mask('99.99.9999', {'translation': {0: {pattern: /[0-9*]/}}});
    $("#date_from").mask('99.99.9999', {'translation': {0: {pattern: /[0-9*]/}}});
    $("#date_to").mask('99.99.9999', {'translation': {0: {pattern: /[0-9*]/}}});
});

/* ----------- Sidebar ----------*/
$(window).load(function(){
    $("[data-toggle]").click(function() {
        var toggle_el = $(this).data("toggle");
        $(toggle_el).toggleClass("open-sidebar");
    });
    $(".swipe-area").swipe({
        swipeStatus:function(event, phase, direction, distance, duration, fingers){
            if (phase=="move" && direction =="right") {
                $(".container").addClass("open-sidebar");
                return false;
            }
            if (phase=="move" && direction =="left") {
                $(".container").removeClass("open-sidebar");
                return false;
            }
        }
    }); 
});

function AdjustWidth(){
    var maincontent = "";
    var content = "";
    var maincontent = document.getElementById('main-content').offsetWidth;
    var content = document.getElementById('content').offsetWidth;
    var testWidth = (maincontent/content)*100;
       
    if(document.getElementById('hd_home').value == 1){
        //document.getElementById('content').style.width = '121.5%';
	//document.getElementById('navigation1').style.width = '100%';
	//$("#content", { direction: "left" }, 1000);
        document.getElementById('home').style.display = '';
        document.getElementById('hd_home').value = 0;
    } else {
        //document.getElementById('content').style.width = '100%';
	//document.getElementById('navigation1').style.width = '83%';
        document.getElementById('home').style.display = 'none';
        document.getElementById('hd_home').value = 1;    
    }
}
/* ----------- Sidebar ----------*/

function Add_JS(){
    if(document.getElementById('strAction').value == "Edit"){
        alert("Add is not Allowed. "+document.getElementById('strAction').value+" mode is already enabled.");
    return;
    }
    EnabledForm();
    document.getElementById('strAction').value = 'Add';
}

function Delete_JS(functionName,value){
    if(document.getElementById('strAction').value == "Edit" || document.getElementById('strAction').value == "Add"){
        alert("Delete is not Allowed. "+document.getElementById('strAction').value+" mode is already enabled.");
	return;
    }
    
    var value = pad(value,'3');
    if (confirm('Are you sure you want to delete?')){
        AjaxPHPFunction(functionName,value)
    }
}

function Find_JS(field){
    var value = document.getElementById('toFind').value;
    var functionName = "Find_PHP";
    var FindFilter = ' lower('+field+') like lower(\'%'+value+'%\')';
    AjaxPHPFunction(functionName,FindFilter);
    //AjaxPHPFunction(functionName,FindFilter);//purpose of calling the second AjaxPHPFunction is to display the encrypt data in a href url
}

function EnabledForm(){
    var strID = "";
    var inputs = document.getElementsByTagName("input");
    for (var i=0; i < inputs.length; i++){
        if (inputs[i].getAttribute('type') == 'text'){
            strID = inputs[i].getAttribute('name');
            document.getElementById(strID).disabled =false;
	}
    }

    var button = document.getElementsByTagName("input");
    for (var i=0; i < inputs.length; i++){
        if (inputs[i].getAttribute('type') == 'button'){
            strID = inputs[i].getAttribute('name');
            document.getElementById(strID).disabled =false;
	}
    }

    var submit = document.getElementsByTagName("input");
    for (var i=0; i < inputs.length; i++){
        if (inputs[i].getAttribute('type') == 'submit'){
            strID = inputs[i].getAttribute('name');
            document.getElementById(strID).disabled =false;
	}
    }
}

function ResetData(){
    var inputs = document.getElementsByTagName("input");
    for (var i=0; i < inputs.length; i++){
        if (inputs[i].getAttribute('type') == 'text'){
            strID = inputs[i].getAttribute('name');
            document.getElementById(strID).disabled =true;
            document.getElementById(strID).value ="";
	}
    }

    var button = document.getElementsByTagName("input");
    for (var i=0; i < inputs.length; i++){
        if (inputs[i].getAttribute('type') == 'button'){
            strID = inputs[i].getAttribute('name');
            document.getElementById(strID).disabled =true;
	}
    }
    
    var submit = document.getElementsByTagName("input");
    for (var i=0; i < inputs.length; i++){
        if (inputs[i].getAttribute('type') == 'submit'){
            strID = inputs[i].getAttribute('name');
            document.getElementById(strID).disabled =true;
	}
    }
    document.getElementById('strAction').value = '';
}

function validate(evt){
    //backspace, tab, f5, left arrow, right arrow, ctrlKey
    if(evt.keyCode!=8 && evt.keyCode!=9 && evt.keyCode!=116 && evt.keyCode!=37 && evt.keyCode!=39 && !evt.ctrlKey){
        var theEvent = evt || window.event;
	var key = theEvent.keyCode || theEvent.which;
	key = String.fromCharCode( key );
	var regex = /[0-9]|\./;
	if( !regex.test(key) ){
            theEvent.returnValue = false;
            if(theEvent.preventDefault) theEvent.preventDefault();
	}
    }
}

function formatDecimal(input) {
    var val = input.value;
    if (val) {
        val = val.split('\.');
        var out = val[0];
        if (val[1]) {
            if (val[1].length > 2){
                val[1]= Left(val[1],2);
            }
            out = out + '.' + val[1]
            if (val[1].length < 2) {
            	out = out + '0';
            } 
        } else {
            out = out + '.00';
        }
        input.value = out;
    }
}

function leadingzero(id,num, size) {//used in html
    var s = num+"";
    if(s.length != 0){
        while (s.length < size){
            s = "0" + s;
        }
        document.getElementById(id).value =s;
    }
}

function pad(num, size) {//used in javascript
    var s = num+"";
    if(s.length != 0){
	while (s.length < size){
            s = "0" + s;
	}
    return s;
    }
}

function ShowLoading(){
    document.getElementById("loading").style.display = "block";
}

function HideLoading(){
    document.getElementById("loading").style.display = "none";
}

function GetInputName(id){
    var strFields = "";
    var check = "";
    document.getElementById(id).value = "";
    var select = document.getElementsByTagName("select");
    for (x = 0 ; x < select.length ; x++){
    	var field = select[x].getAttribute("name");
	if(field.substring(0, 3) != 'hd_' && field.substring(0, 9) != 'dynfields'){// Escape the hidden fields and dynfields
            strFields = strFields + field +",";
	}
    }
	
    var textarea = document.getElementsByTagName("textarea");
    for (x = 0 ; x < textarea.length ; x++){
	var field = textarea[x].getAttribute("name");
	if(field.substring(0, 3) != 'hd_'){// Escape the hidden fields
            strFields = strFields + field +",";
	}
    }
	
    var inputs = document.getElementsByTagName("input");
    for (x = 0 ; x < inputs.length ; x++){
        //if (inputs[x].getAttribute("type") == "text"){
	var field = inputs[x].getAttribute("name");
        if (inputs[x].getAttribute("type") == "checkbox"){
            if(field.substring(0, 3) != 'hd_'){// Escape the hidden fields
                if(field != check){
                    strFields = strFields + field +",";
                    check = field;
                }
            }
        } else {
            if(field.substring(0, 3) != 'hd_'){// Escape the hidden fields
                strFields = strFields + field +",";
            }
        }
	//}
    }
    
    var hidden = document.getElementsByTagName("hidden");
    for (x = 0 ; x < hidden.length ; x++){
	var field = inputs[x].getAttribute("name");
        if(field.substring(0, 3) != 'hd_'){// Escape the hidden fields
            strFields = strFields + field +",";
	}
    }
    
    strFields = strFields.slice(',',-1);
    document.getElementById(id).value = strFields;
}

function GetRecord(id){
    var strValue = "";
    var check = "";
    document.getElementById(id).value = "";
    var select = document.getElementsByTagName("select");
    for (x = 0 ; x < select.length ; x++){
	var field = select[x].getAttribute("name");
	if(field.substring(0, 3) != 'hd_' && field.substring(0, 9) != 'dynfields'){// Escape the hidden fields and dynfields
            var value = document.getElementsByName(field)[0].value;
            strValue = strValue + value +",";
	}
    }
	
    var textarea = document.getElementsByTagName("textarea");
    for (x = 0 ; x < textarea.length ; x++){
	var field = textarea[x].getAttribute("name");
	if(field.substring(0, 3) != 'hd_'){// Escape the hidden fields
            var value = document.getElementsByName(field)[0].value;
            strValue = strValue + value +",";
	}
    }
	
    var inputs = document.getElementsByTagName("input");
    for (x = 0 ; x < inputs.length ; x++){
	var field = inputs[x].getAttribute("name");
	if (inputs[x].getAttribute("type") == "checkbox"){
            var checkboxes = document.getElementsByName(field);
            var vals = "";
            if(field.substring(0, 3) != 'hd_'){// Escape the hidden fields
                if(field != check){
                    for (var i=0, n=checkboxes.length;i<n;i++) {
                        if (checkboxes[i].checked) {
                            vals += "^"+checkboxes[i].value;
                        }
                    }
                    check = field;
                }
                strValue = strValue + vals.substring(1) +",";
            }
	} else {
            if(field.substring(0, 3) != 'hd_'){// Escape the hidden fields
		var value = document.getElementsByName(field)[0].value;
                strValue = strValue + value +",";
            }
	}
    }
    
    var hidden = document.getElementsByTagName("hidden");
    for (x = 0 ; x < hidden.length ; x++){
	var field = inputs[x].getAttribute("name");
        if(field.substring(0, 3) != 'hd_'){// Escape the hidden fields
            var value = document.getElementsByName(field)[0].value;
            strValue = strValue + value +",";
	}
    }
    
    strValue = strValue.slice(',',-1);
    document.getElementById(id).value = strValue;
}

function RemoveEntry(counter){
    var d = document.getElementById('prodSale');
    var olddiv = document.getElementById('trSale['+counter+']');
    d.removeChild(olddiv);
    totalItems(1);
    totalAmount(1);
}

function AddEntryJournal(){
    var counter = parseInt(document.getElementById('strCounter').value) + 1;
    var strSelectOptAcctType = document.getElementById('strSelectOptAcctType').value;
    var strSelectOptCrDr = document.getElementById('strSelectOptCrDr').value;
    var strSelectOptAcctType = strSelectOptAcctType.replace(/counter/g, counter);
    var strSelectOptCrDr = strSelectOptCrDr.replace(/counter/g, counter);
    var strDR = "totalCrDr('debit')";
    var strCR = "totalCrDr('credit')";
    $('#journalEntry').append(
        '<tr id="trJournal[' + counter + ']"><td style="padding:3px">'+strSelectOptAcctType+'</td>'
            //+ '<td style="padding:3px">'+strSelectOptAcctType+'</td>'
            + '<td style="padding:3px"><input type="text" name="dynfields" id="narrative[' + counter + ']" onblur="LostFocus(\'LF_narrative(' + counter + ')\')"></td>'    
            + '<td style="text-align:center;"><input type="text" name="dynfields" id="debit[' + counter + ']" value="" style="width:100px;text-align: right;" onkeypress="validate(event)" onblur="formatDecimal(this);'+strDR+'" ></td>'
            + ' <td style="text-align:center;"><input type="text" name="dynfields" id="credit[' + counter + ']" value="" style="width:100px;text-align: right;" onkeypress="validate(event)" onblur="formatDecimal(this);'+strCR+'" ><div style="float:right; margin-right:-16px"><a href="#" class="action" id="RemoveEntry" onclick="RemoveEntryJournal('+counter+')" title="Remove Entry" tabindex="-1"><span class="typcn typcn-minus"></a></span></div></td>'
        + '</tr>'
    );
    document.getElementById('strCounter').value = counter;
    document.getElementById('account_type['+counter+']').focus();
}

function RemoveEntryJournal(counter){
    var d = document.getElementById('journalEntry');
    var olddiv = document.getElementById('trJournal['+counter+']');
    d.removeChild(olddiv);
    totalCrDr('credit');
}

function goBack() {
    window.history.back();
}

function capitalizeEachWord(str) {
    return str.replace(/\w\S*/g, function(txt) {
        return txt.charAt(0).toUpperCase() + txt.substr(1).toLowerCase();
    });
}

function isDate(txtDate)
{
    var currVal = txtDate;
    if(currVal == '')
        return false;
    
    var rxDatePattern = /^(\d{1,2})(\.|-)(\d{1,2})(\.|-)(\d{4})$/; //Declare Regex
    var dtArray = currVal.match(rxDatePattern); // is format OK?
    
    if (dtArray == null) 
        return false;
    
    //Checks for mm/dd/yyyy format.
    dtMonth = dtArray[1];
    dtDay= dtArray[3];
    dtYear = dtArray[5];        
    
    if (dtMonth < 1 || dtMonth > 12) 
        return false;
    else if (dtDay < 1 || dtDay> 31) 
        return false;
    else if ((dtMonth==4 || dtMonth==6 || dtMonth==9 || dtMonth==11) && dtDay ==31) 
        return false;
    else if (dtMonth == 2) 
    {
        var isleap = (dtYear % 4 == 0 && (dtYear % 100 != 0 || dtYear % 400 == 0));
        if (dtDay> 29 || (dtDay ==29 && !isleap)) 
                return false;
    }
    return true;
}

function checkDate(txtDate){
    if(txtDate.value != ""){
        if(!isDate(txtDate.value)){
            alert("Invalid date!");
            setTimeout(function() {
                document.getElementById(txtDate.id).focus(); 
            }, 10);
            return;
        }
    }
}

function isDecimal(string){
    var pattern=/^\d+(\.\d{2})?$/;
    return pattern.test(string);
}

/*Keypad*/
function keypad(value){
    $(".amount").append(value);
}

function clearKeypad(){
     $(".amount").empty();
}

function deleteKeypad(){
    total = $(".amount").text();
    total = total.slice(0,-1);
    $(".amount").empty().append(total);
}

function RealTime() {
    var today = new Date();
    var mm =  (today.getMonth()+1);
    var dd = today.getDate(); 
    var yy = today.getFullYear();
    var h = today.getHours();
    var m = today.getMinutes();
    var s = today.getSeconds();
    m = addZero(m);
    s = addZero(s);
    document.getElementById('realTime').innerHTML =
    mm + "." + dd +"."+ yy +" "+ h + ":" + m + ":" + s;
    var t = setTimeout(RealTime, 500);
   // return  mm + "." + dd +"."+ yy +" "+ h + ":" + m + ":" + s;
}
function addZero(i) {
    if (i < 10) {i = "0" + i;};  // add zero in front of numbers < 10
    return i;
}

function getParameterByName(name) {
    name = name.replace(/[\[]/, "\\[").replace(/[\]]/, "\\]");
    var regex = new RegExp("[\\?&]" + name + "=([^&#]*)"),
        results = regex.exec(location.search);
    return results === null ? "" : decodeURIComponent(results[1].replace(/\+/g, " "));
}

function addCommas(nStr) {
    nStr += '';
    x = nStr.split('.');
    x1 = x[0];
    x2 = x.length > 1 ? '.' + x[1] : '';
    var rgx = /(\d+)(\d{3})/;
    while (rgx.test(x1)) {
            x1 = x1.replace(rgx, '$1' + ',' + '$2');
    }
    return x1 + x2;
}

function removeCommas(value){
    return value.replace(/,/g , "");
}

function addDate(count, type){
    var someDate = new Date();
    if(type === "D"){
        someDate.setDate(someDate.getDate() + parseInt(count)); 
    } else if(type === "M"){
        someDate.setMonth(someDate.getMonth() + parseInt(count)); 
    } else if(type === "Y"){
        someDate.setFullYear(someDate.getFullYear() + parseInt(count)); 
    }
    var dd = someDate.getDate();
    var mm = someDate.getMonth() + 1;
    var y = someDate.getFullYear();
    var someFormattedDate = addZero(mm) + '.'+ addZero(dd) + '.'+ y;
    return someFormattedDate;
}

function currentTime(){
    var d = new Date(); // for now
    var hour = d.getHours(); // => 9
    var minute = d.getMinutes(); // =>  30
    var second = d.getSeconds(); // => 51
return addZero(hour) +':'+addZero(minute)+':'+ addZero(second);
}

function getGetOrdinal(n) {
   var s=["th","st","nd","rd"],
       v=n%100;
   return n+(s[(v-20)%10]||s[v]||s[0]);
}

function to_date(date){
    var year = date.substring(6, 10).toString();
    var day = date.substring(3, 5).toString();
    var month = date.substring(0, 2).toString();
    return year+month+day;
}