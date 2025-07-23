<script>
/*Required functions. onPageLoad, onAddNewUpdate, onAmendUpdate, onAddNew, onAmend, OnDelete, onCancelAddNew, onCancelAmend*/
function  onPageLoad(){
    ShowLoading();
    $( "#tabs" ).tabs();
    $( "#tabs" ).tabs( "option", "active", 0 );
    SetStyle("footer_navigation","display","block");
    HideLoading();
}   

/*populate the ComboSelect*/
function loadComboSelect(){
    populateGender();
    populateTariff();
    populateCustomerType();
    populateCountry();
    populateCity();
    populateIDType();
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


/* onAddNew */
function onAddNew(){
    $( "#tabs" ).tabs();
    $( "#tabs" ).tabs( "option", "active", 0 );
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

function populateTariff(){
    var qrySQL = "SELECT was_id, tariff FROM was_cs_tariff";
    var result = SelectDB(qrySQL);
    if(result !== ""){
        result = result.split('~');
        $("#tariff").empty();
        $("#tariff").append($("<option></option>").val("").html(""));
        for (var i=0; i < result.length; i++){
            var value = result[i].split('^');
            $("#tariff").append($("<option></option>").val(value[0]).html(value[1]));
        }
    }
}

function populateCustomerType(){
    var qrySQL = "SELECT was_id, customer_type FROM was_cs_customer_type";
    var result = SelectDB(qrySQL);
    if(result !== ""){
        result = result.split('~');
        $("#customer_type").empty();
        $("#customer_type").append($("<option></option>").val("").html(""));
        for (var i=0; i < result.length; i++){
            var value = result[i].split('^');
            $("#customer_type").append($("<option></option>").val(value[0]).html(value[1]));
        }
    }
}

function populateCountry(){
    var qrySQL = "select was_id, country from was_cs_country";
    var result = SelectDB(qrySQL);
    $("#country").empty();
    if(result !== ""){
        result = result.split('~');
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
    $("#city").empty();
    if(result !== ""){
        result = result.split('~');
        $("#city").append($("<option></option>").val("").html(""));
        for (var i=0; i < result.length; i++){
            var value = result[i].split('^');
            $("#city").append($("<option></option>").val(value[0]).html(value[1]));
        }
    }
}

function populateIDType(){
    var qrySQL = "SELECT was_id, id_type FROM was_cs_id_type";
    var result = SelectDB(qrySQL);
    if(result !== ""){
        result = result.split('~');
        $("#id_type").empty();
        $("#id_type").append($("<option></option>").val("").html(""));
        for (var i=0; i < result.length; i++){
            var value = result[i].split('^');
            $("#id_type").append($("<option></option>").val(value[0]).html(value[1]));
        }
    }
}

function tab1(){
    SetStyle("footer_navigation","display","block");
}

function tab2(){
    ShowLoading();
    SetStyle("footer_navigation","display","none");
    HideLoading();
}

</script>