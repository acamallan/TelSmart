<script>
/*Required functions. onPageLoad, onAddNewUpdate, onAmendUpdate, onAddNew, onAmend, OnDelete, onCancelAddNew, onCancelAmend*/
function  onPageLoad(){
    ShowLoading();
    $( "#tabs" ).tabs();
    $( "#tabs" ).tabs( "option", "active", 0 );
    HideLoading();
}   

/*populate the ComboSelect*/
function loadComboSelect(){
    populateGender();
    populateCountry();
    populateCity();
}    

/* onAddNewUpdate */
function onAddNewUpdate(){
    if(GetValue("customer_id") === ""){
        SetValue("customer_id", GetCounter("006","10"));
    }
}

/* onAmendUpdate */
function onAmendUpdate(){
    
}

function postAddNewUpdate(){
   
}

/* onAddNew */
function onAddNew(){
    $( "#tabs" ).tabs();
    $( "#tabs" ).tabs( "option", "active", 0 );
    SetValue("record_date",getServerSession("record_date"));
    
}

/* onAmend */
function onAmend(){
   
}

/* OnDelete */
function OnDelete(){
    var qryDelete = "delete from was_customer_contact where customer_id='"+GetValue("customer_id")+"'";
    DeleteDB(qryDelete);
}

/* onCancelAddNew */
function onCancelAddNew(){
 
}

/* onCancelAmend */
function onCancelAmend(){
   
}

function populateGender(){
    var qrySQL = "SELECT was_id, gender FROM was_cs_gender";
    var result = SelectDB(qrySQL);
    if(result !== ""){
        result = result.split('~');
        $("#gender").empty();
        $("#gender").append($("<option></option>").val("").html(""));
        for (var i=0; i < result.length; i++){
            var value = result[i].split('^');
            $("#gender").append($("<option></option>").val(value[0]).html(value[1]));
        }
    }
}

function populateCountry(){
    var qrySQL = "select was_id, country from was_cs_country";
    var result = SelectDB(qrySQL);
    if(result !== ""){
        result = result.split('~');
        $("#country").empty();
        $("#country").append($("<option></option>").val("").html(""));
        for (var i=0; i < result.length; i++){
            var value = result[i].split('^');
            $("#country").append($("<option></option>").val(value[0]).html(value[1]));
        }
    }
}

function populateCity(){
    var qrySQL = "select was_id, country from was_cs_country";
    var result = SelectDB(qrySQL);
    if(result !== ""){
        result = result.split('~');
        $("#city").empty();
        $("#city").append($("<option></option>").val("").html(""));
        for (var i=0; i < result.length; i++){
            var value = result[i].split('^');
            $("#city").append($("<option></option>").val(value[0]).html(value[1]));
        }
    }
}


function tab1(){
    SetStyle("footer_navigation","display","block");
}

function tab2(){
    ShowLoading();
    SetStyle("footer_navigation","display","none");
    TransHistory();
    HideLoading();
}

function tab3(){
    ShowLoading();
    SetStyle("footer_navigation","display","none");
    HideLoading();
}

function tab4(){
    ShowLoading();
    SetStyle("footer_navigation","display","none");
    HideLoading();
}

function LF_number_of_minor(){
    if(GetValue("number_of_minor") === ""){
        SetValue("number_of_minor","0");
    }
}

function TransHistory(){
    ShowLoading();
    var qrySelect = "select room_id, in_date, out_date, days, transaction_amount from was_hotel_book_transactions "
            + " where book_status = 2 and customer_id ='"+GetValue("customer_id")+"'";
            
    var result = SelectDB(qrySelect);
    result = result.split('~');
    var display = "";
    if(result != ""){
        for (var i=0; i < result.length; i++){
            display = display + "<tr>";
            var value = result[i].split('^');
            display = display + "<td style='padding:4px;'>" + value[0] + "</td>";
            display = display + "<td style='padding:4px;'>" + value[1] + "</td>";
            display = display + "<td style='padding:4px;'>" + value[2] + "</td>";
            display = display + "<td style='padding:4px;'>" + value[3] + "</td>";
            display = display + "<td style='padding:4px;'>" + value[4] + "</td>";
            display = display + "</tr>";
        }
    } else {
        display = display + "<td style='padding:4px;' colspan='5'>No History found.</td>";
    }
    SetValueInner("displayHistory","");
    SetValueInner("displayHistory",display);
    HideLoading();
}
</script>