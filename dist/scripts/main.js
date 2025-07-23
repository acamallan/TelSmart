$(function() {
    $("#tab2_in_date").datepicker({
        onSelect: function (dateText, inst) {
            var date = $.datepicker.parseDate($.datepicker._defaults.dateFormat, dateText);
            $("#tab2_out_date").datepicker("option", "minDate", date);
            if(GetValue("tab2_in_date") !== "" && GetValue("tab2_out_date") !== ""){
                var start = $('#tab2_in_date').datepicker('getDate');
                var end   = $('#tab2_out_date').datepicker('getDate');
                var days   = (end - start)/1000/60/60/24;
                SetValue("tab2_days",days);
            } else {
                SetValue("tab2_days",0);
            }
            var amount = parseInt(GetValue("tab2_days")) * parseInt(GetValue("tab2_price"));
            SetValue("tab2_amount",parseInt(amount).toFixed(2));
            SetFocus("tab2_out_date");
        }   
    });
    
    $("#tab2_out_date").datepicker({
        onSelect: function (dateText, inst) {
            if(GetValue("tab2_in_date") !== "" && GetValue("tab2_out_date") !== ""){
                var start = $('#tab2_in_date').datepicker('getDate');
                var end   = $('#tab2_out_date').datepicker('getDate');
                var days   = (end - start)/1000/60/60/24;
                SetValue("tab2_days",days);
            } else {
                SetValue("tab2_days",0);
            }
            var amount = parseInt(GetValue("tab2_days")) * parseInt(GetValue("tab2_price"));
            SetValue("tab2_amount",parseInt(amount).toFixed(2));
            SetFocus("tab2_amount");
        }   
    });
    
    $("#tab2_in_date").datepicker("option", "minDate", 0 );
    $( "#tabs" ).tabs();
    $( "#tabs" ).tabs( "option", "active", 0 );
    tab1();
});

function tab1(){
    ShowLoading();
    var qrySelect = "select left(room_id, 1),room_id, type.room_type, price, status.room_status, details.room_status room_status_id, details.room_type room_type_id "
            + " from was_hotel_room_details details, was_cs_hotel_room_type type, was_cs_hotel_room_status status"
            + " where details.room_type = type.was_id and details.room_status = status.was_id";
            
    var result = SelectDB(qrySelect);
    result = result.split('~');
    var display = "";
    if(result != ""){
        for (var i=0; i < result.length; i++){
            display = display + "<tr>";
            var value = result[i].split('^');

                display = display + "<td style='padding:4px;'>" + getGetOrdinal(value[0]) + " Floor</td>";
                display = display + '<td style="padding:4px; cursor:pointer;" onclick="window.open(\'pages/hotel_room_details.jsp?link=1?room_id='+encryptJS(value[1])+'\', \'_blank\', \'height=' + screen.height + ',width=' + screen.width + ',scrollbars=yes, titlebar=no\')">' + value[1] + '</td>';
                display = display + '<td style="padding:4px; cursor:pointer;" onclick="tab1RoomTypeDesc(\''+value[6]+'\',\''+value[2]+'\')">' + value[2] + '</td>';
                display = display + "<td style='padding:4px;'>" + value[3] + "</td>";
                display = display + "<td style='padding:4px;'>" + value[4] + "</td>";
                var button = "";
                if(value[5] === "108"){
                    button = '<input type="button" name="btnBook" id="btnBook" value="Book" style="margin:0px; padding:3px; background-color:green;"  onclick="book('+value[1]+','+value[3]+')"><input type="button" name="btnViewDetails" id="btnViewDetails" value="Room Details" style="margin:0px; margin-left:10px; padding:3px;"  onclick="Details('+value[1]+')">';
                } else {
                    button = '<input type="button" name="btnNA" id="btnNA" value="Not Available" style="margin:0px; padding:3px; background-color:red; color:white;" disabled><input type="button" name="btnViewDetails" id="btnViewDetails" value="Room Details" style="margin:0px; margin-left:10px; padding:3px;"  onclick="Details('+value[1]+')">';
                }
            display = display + '<td style="text-align:center">'+button+'</td>';
            display = display + "</tr>";
        }
    }
    SetValueInner("displayRooms","");
    SetValueInner("displayRooms",display);
    SetValueInner("tab1_date", getServerSession("record_date"));
    
    //Details
    var qrySelect1 = "select  book_status, hotel.room_id, customer_name, in_date, out_date, sum(if(hotel.transaction_amount+pos.actual_amount is not null,hotel.transaction_amount+pos.actual_amount, hotel.transaction_amount)) amount "
            + " from view_hotel_book_transactions hotel left join was_product_sales_invoice_header pos on hotel.room_id = pos.room_id where to_date(hotel.transaction_date) = '"+to_date(getServerSession("record_date"))+"'";
    var result1 = SelectDB(qrySelect1);
    result1 = result1.split('~');
    var booked = "";
    var reserved = "";
    var checkout = "";
    if(result1 != ""){
        for (var i=0; i < result1.length; i++){
            var value = result1[i].split('^');
            if(value[0] === "0"){
                reserved += "<tr>";
                reserved += "<td style='padding:4px;'>" + value[1] + "</td>";
                reserved += "<td style='padding:4px;'>" + value[2] + "</td>";
                reserved += "<td style='padding:4px;'>" + value[3] + " - "+value[4]+"</td>";
                reserved += "<td style='padding:4px; font-weight: bold;'>" + parseInt(value[5]).toFixed(2)+"</td>";
                reserved += "</tr>";
            }
            if(value[0] === "1"){
                checkout += "<tr>";
                checkout += "<td style='padding:4px;'>" + value[1] + "</td>";
                checkout += "<td style='padding:4px;'>" + value[2] + "</td>";
                //checkout += "<td style='padding:4px;'>" + value[3] + " - "+value[4]+"</td>";
                checkout += "<td style='padding:4px; font-weight: bold;'>" + parseInt(value[5]).toFixed(2)+"</td>";
                checkout += "</tr>";
            }
            if(value[0] === "2"){
                booked += "<tr>";
                booked += "<td style='padding:4px;'>" + value[1] + "</td>";
                booked += "<td style='padding:4px;'>" + value[2] + "</td>";
                booked += "<td style='padding:4px;'>" + value[3] + " - "+value[4]+"</td>";
                booked += "<td style='padding:4px; font-weight: bold;'>" + parseInt(value[5]).toFixed(2)+"</td>";
                booked += "</tr>";
            }
        }    
        
    }
    if(reserved === ""){
        reserved = "<tr><td colspan='2'>No record</td></tr>"
    }
    if(checkout === ""){
        checkout = "<tr><td colspan='2'>No record</td></tr>"
    }
    if(booked === ""){
        booked = "<tr><td colspan='2'>No record</td></tr>"
    }
    SetValueInner("tab1_reserved",reserved);
    SetValueInner("tab1_checkout",checkout);
    SetValueInner("tab1_booked",booked);
    $( "#tabs" ).tabs( "disable", 1 );
    $( "#tabs" ).tabs( "disable", 4 );
    $( "#tabs" ).tabs( "disable", 6 );
    HideLoading();
}

function tab1RoomTypeDesc(id, desc){
        var display = "";
        var strSQL = "select description from was_hotel_room_type_desc where room_type = '"+id+"'" ;
        var result = SelectDB(strSQL);
        var display = "";
        if(result !== ""){
            result = result.split('~');
            for (var i=0; i < result.length; i++){
                display = display + "<tr>";
                var value = result[i].split('^');
                for (var x=0; x < value.length; x++){
                    display = display + "<td style=''>" + value[x] + "</td>";
                }
                display = display + "</tr>";
            }
        } else {
            display = display + "<tr><td colspan='6'>No Descrption found.</td></tr>";
        }
        SetValueInner("displayRoomTypeDesc","");
        SetValueInner("displayRoomTypeDesc",display);
        SetStyle("dialog","display","block");
        $( "#dialog" ).dialog({
            width: 700,
            height: 500,
            title: desc + " - Room Type Discription",
            modal: true
        });
}

//tab2
function Tab2Reset(){
    var fields = "customer_id,first_name,last_name,gender,contact_number,email,address,city,country,number_of_adult,number_of_minor,tariff,customer_type,id_type,id_number";
    fields = fields.split(',');
    for (var i=0; i < fields.length; i++){
        DisplayMode("tab2_"+fields[i],"EN");
        SetValue("tab2_"+fields[i],"");
    }
    SetValue("tab2_days",0);
    SetValue("tab2_amount","0.00");
    SetValue("tab2_deposit_amount","0.00");
    SetValue("tab2_number_of_adult","0");
    SetValue("tab2_number_of_minor","0");
    SetValue("tab2_in_date","");
    SetValue("tab2_out_date","");
    SetValue("tab2_deposit_mode","");
    DisplayMode("tab2_room_id","DI");
    DisplayMode("tab2_price","DI");
    DisplayMode("tab2_customer_id","DI");
    DisplayMode("tab2_days","DI");
    DisplayMode("tab2_days","DI");
}

function Tab2Book(){
    ShowLoading();
    if(parseInt(GetValue("tab2_days")) === 0){
        alert("Please input the Check-in and Check-out Date correctly.");
        HideLoading();
        return;
    }
    var requiredFields = "first_name,last_name,gender,contact_number,address,city,country,tariff,customer_type,id_type,id_number";
    requiredFields = requiredFields.split(',');
    var checkrequiredFields = 0;
    for(var x = 0; x < requiredFields.length; x++){
        var fieldID = "#tab2_"+requiredFields[x].trim();
        if($(fieldID).val() === ""){
            document.getElementById("lb_tab2_"+requiredFields[x].trim()).style.color ="red";
            checkrequiredFields = 1;
        } else {
            document.getElementById("lb_tab2_"+requiredFields[x].trim()).style.color ="black";
        }
    }
    if(checkrequiredFields ===1){
        alert("Please input the required fields");
        HideLoading();
        return;  
    }
    
    var in_date = (GetValue("tab2_in_date").replace("/",".")).replace("/",".");
    var out_date = (GetValue("tab2_out_date").replace("/",".")).replace("/",".");
    var room_id = GetValue("tab2_room_id");
    var qrySelectTrans = SelectDB("select count(*) from was_hotel_book_transactions where ((to_date(in_date) <= '"+to_date(in_date)+"' or to_date(out_date) >= '"+to_date(in_date)+"')"
                                + " or (to_date(in_date) <= '"+to_date(out_date)+"' and to_date(out_date) >= '"+to_date(out_date)+"')) and room_id = '"+room_id+"'");
    if(qrySelectTrans > 0){
        swal({   
            title: "<small>Date range is not available. <br> Please check the available date in scheduler.</small>",   
            text: "",   
            type: "error",
            html: true,
            showCancelButton: false,   
            confirmButtonText: "OK",   
            closeOnConfirm: true 
        });
        HideLoading();
        return;
    }
    if(GetValue("tab2_customer_id") === ""){
        SetValue("tab2_customer_id", GetCounter("006","10"));
     
        var fields = "customer_id,first_name,last_name,gender,contact_number,email,address,city,country,tariff,customer_type,id_type,id_number";
        fields = fields.split(',');
        var values = "";
        for(var x = 0; x < fields.length; x++){
            values = values + "'" + GetValue("tab2_"+fields[x]) + "',";
        }
        values = values + "'" + getServerSession("record_date") + "'";
        //Insert new customer
        var qryInsert = "insert into was_customer_info(has_multiple_address,customer_id,first_name,last_name,gender,contact_number,email,address,city,country,tariff,customer_type,id_type,id_number,record_date)"
                + " values('0',"+values+")";
        var result = InsertDB(qryInsert);
        if(result === ""){
            HideLoading();
            return;
        }
    } else {
        var fields = "first_name,last_name,gender,contact_number,email,address,city,country,tariff,customer_type,id_type,id_number";
        fields = fields.split(',');
        var set = "";
        for (var i=0; i < fields.length; i++){
            set = set + fields[i] + "= '"+GetValue("tab2_"+fields[i])+"',";
        }
        set = set.substring(0, set.length-1);
        var qryUpdate = "update was_customer_info  set " + set + " where customer_id = '"+GetValue("tab2_customer_id")+"'";
        var result1 = UpdateDB(qryUpdate);
        if(result1 === ""){
            HideLoading();
            return;
        }
    }
    
    //Update Room Status to Occupied
    var qryUpdate = "update was_hotel_room_details set room_status='101' where room_id='"+GetValue("tab2_room_id")+"'";
    var result1 = UpdateDB(qryUpdate);
    if(result1 === ""){
        HideLoading();
        return;
    }
    
    var transaction_id = GetCounter("001","10");
    var transaction_date = getServerSession("record_date");
    var transaction_time = currentTime();
    var customer_id = GetValue("tab2_customer_id");
    var in_date = (GetValue("tab2_in_date").replace("/",".")).replace("/",".");
    var out_date = (GetValue("tab2_out_date").replace("/",".")).replace("/",".");
    var days = GetValue("tab2_days");
    var transaction_amount = GetValue("tab2_amount");
    var number_of_adult = GetValue("tab2_number_of_adult");
    var number_of_minor = GetValue("tab2_number_of_minor");
    var book_status = "2";
    var userid = getServerSession("userid");
    var deposit_mode = GetValue("tab2_deposit_mode");
    var deposit_amount = GetValue("tab2_deposit_amount");
    var payment_status = "102";
    //Insert New Book Transaction
    var qryInsert2 = "insert into was_hotel_book_transactions(transaction_id,transaction_date,transaction_time,customer_id,room_id,in_date,out_date,days,transaction_amount,number_of_adult,number_of_minor,book_status,userid,deposit_mode,deposit_amount,payment_status,room_status)"
            + " values('"+transaction_id+"','"+transaction_date+"','"+transaction_time+"','"+customer_id+"','"+room_id+"','"+in_date+"','"+out_date+"','"+days+"','"+transaction_amount+"','"+number_of_adult+"','"+number_of_minor+"','"+book_status+"','"+userid+"','"+deposit_mode+"','"+deposit_amount+"','"+payment_status+"','101')";
    var result2 = InsertDB(qryInsert2);
    if(result2 === ""){
        HideLoading();
        return;
    }
    
    swal({   
        title: "<small>Book Successfully!</small>",   
        text: "",   
        type: "success",
        html: true,
        showCancelButton: false,   
        confirmButtonText: "OK",   
        closeOnConfirm: true 
    },function(){  
        $( "#tabs" ).tabs( "option", "active", 0 );
        tab1();
        Tab2Reset();
    });
    
    HideLoading();
}

function populateGender(){
    var qrySQL = "SELECT was_id, gender FROM was_cs_gender";
    var result = SelectDB(qrySQL);
    if(result !== ""){
        result = result.split('~');
        $("#tab2_gender").empty();
        $("#tab2_gender").append($("<option></option>").val("").html(""));
        for (var i=0; i < result.length; i++){
            var value = result[i].split('^');
            $("#tab2_gender").append($("<option></option>").val(value[0]).html(value[1]));
        }
    }
}

function populateCountry(){
    var qrySQL = "select was_id, country from was_cs_country";
    var result = SelectDB(qrySQL);
    if(result !== ""){
        result = result.split('~');
        $("#tab2_country").empty();
        $("#tab2_country").append($("<option></option>").val("").html(""));
        for (var i=0; i < result.length; i++){
            var value = result[i].split('^');
            $("#tab2_country").append($("<option></option>").val(value[0]).html(value[1]));
        }
    }
}

function populateCity(){
    var qrySQL = "select was_id, city from was_cs_city";
    var result = SelectDB(qrySQL);
    if(result !== ""){
        result = result.split('~');
        $("#tab2_city").empty();
        $("#tab2_city").append($("<option></option>").val("").html(""));
        for (var i=0; i < result.length; i++){
            var value = result[i].split('^');
            $("#tab2_city").append($("<option></option>").val(value[0]).html(value[1]));
        }
    }
}

function populateTariff(){
    var qrySQL = "SELECT was_id, tariff FROM was_cs_tariff";
    var result = SelectDB(qrySQL);
    if(result !== ""){
        result = result.split('~');
        $("#tab2_tariff").empty();
        $("#tab2_tariff").append($("<option></option>").val("").html(""));
        for (var i=0; i < result.length; i++){
            var value = result[i].split('^');
            $("#tab2_tariff").append($("<option></option>").val(value[0]).html(value[1]));
        }
    }
}

function populateCustomerType(){
    var qrySQL = "SELECT was_id, customer_type FROM was_cs_customer_type";
    var result = SelectDB(qrySQL);
    if(result !== ""){
        result = result.split('~');
        $("#tab2_customer_type").empty();
        $("#tab2_customer_type").append($("<option></option>").val("").html(""));
        for (var i=0; i < result.length; i++){
            var value = result[i].split('^');
            $("#tab2_customer_type").append($("<option></option>").val(value[0]).html(value[1]));
        }
    }
}

function populateDepositMode(){
    var qrySQL = "SELECT was_id, payment_mode FROM was_cs_payment_mode";
    var result = SelectDB(qrySQL);
    if(result !== ""){
        result = result.split('~');
        $("#tab2_deposit_mode").empty();
        for (var i=0; i < result.length; i++){
            var value = result[i].split('^');
            $("#tab2_deposit_mode").append($("<option></option>").val(value[0]).html(value[1]));
        }
    }
}

function populateIDType(){
    var qrySQL = "SELECT was_id, id_type FROM was_cs_id_type";
    var result = SelectDB(qrySQL);
    if(result !== ""){
        result = result.split('~');
        $("#tab2_id_type").empty();
        $("#tab2_id_type").append($("<option></option>").val("").html(""));
        for (var i=0; i < result.length; i++){
            var value = result[i].split('^');
            $("#tab2_id_type").append($("<option></option>").val(value[0]).html(value[1]));
        }
    }
}

function book(id,price){
    ShowLoading();
    $( "#tabs" ).tabs( "enable", 1 );
    $( "#tabs" ).tabs( "option", "active", 1 );
    Tab2Reset();
    SetValue("tab2_room_id",id);
    SetValue("tab2_price",price);
    SetFocus("tab2_in_date");
    populateGender();
    populateCountry();
    populateCity();
    populateTariff();
    populateCustomerType();
    autocompleteCustomer("tab2");
    populateDepositMode();
    populateIDType();
    HideLoading();
}

function LF_tab2_number_of_minor(){
    if(GetValue("tab2_number_of_minor") === ""){
        SetValue("tab2_number_of_minor","0");
    }
}

function autocompleteCustomer(tab){
    var qrySQL = "select customer_id, concat(first_name , ' ', last_name) as name, first_name , last_name from was_customer_info where has_multiple_address = '0'";
    var result = SelectDB(qrySQL);
    if(result !== ""){
        result = result.split('~');
        var tags = "[\n";
        for (var i=0; i < result.length; i++){
            var value = result[i].split('^');
            tags = tags + '{ "value": "'+value[0]+'", "label": "'+ value[0] +'    '+ value[2] +'    '+ value[3] +'"},\n';
        }

        tags = tags.slice(',',-2);
        tags = tags + "\n]";
        var yerler = eval(tags);
        if(GetValue(tab+"_first_name") === ""){
            $("#"+tab+"_first_name").autocomplete({
                source: yerler,
                minLength: 0,
                minChars: 0,
                focus: function (event, ui) {
                    event.preventDefault();
                    SetValue(tab+"_customer_id",ui.item.value);
                },
                select: function (event, ui) {
                    event.preventDefault();
                    SetValue(tab+"_customer_id",ui.item.value);
                    var name = ui.item.label.split("    ");
                    SetValue(tab+"_first_name",name[1]);
                    SetValue(tab+"_last_name",name[2]);
                }
            }).on('focus', function(event) {
                var self = this;
                $(self).autocomplete( "search", "");;
            });
        }
    }
}

function LF_tab2_first_name(){
    if(GetValue("tab2_first_name") === ""){
        SetValue("tab2_customer_id","");
        var fields = "last_name,gender,contact_number,email,address,city,country,tariff,customer_type,id_type,id_number";
        fields = fields.split(",");
        for (var i=0; i < fields.length; i++){
            SetValue("tab2_"+fields[i],"");
            DisplayMode("tab2_"+fields[i],"EN");
        }
    } else {
        if(GetValue("tab2_customer_id") !== ""){
            var fields = "gender,contact_number,email,address,city,country,tariff,customer_type,id_type,id_number";
            fields = fields.split(",");
            var qrySelect = "select gender,contact_number,email,address,city,country,tariff,customer_type,id_type,id_number from was_customer_info where customer_id ='"+GetValue("tab2_customer_id")+"'";
            var result = SelectDB(qrySelect);
            var value = result.split('^');
            for (var i=0; i < value.length; i++){
                SetValue("tab2_"+fields[i],value[i]);
                DisplayMode("tab2_"+fields[i],"EN");
            }
            SetValue("tab2_number_of_adult","0");
            SetValue("tab2_number_of_minor","0");
        }
    }
}

function LF_tab2_deposit_amount(){
    if(GetValue("tab2_deposit_amount") === ""){
        SetValue("tab2_deposit_amount","0.00")
    }
    formatDecimal(document.getElementById("tab2_deposit_amount"));
}
//tab2 end

//tab3
function tab3(){
    ShowLoading();
    DisplayMode("tab3_customer_id","DI");
    DisplayMode("tab3_customer_name","DI");
    DisplayMode("tab3_in_date","DI");
    DisplayMode("tab3_out_date","DI");
    DisplayMode("tab3_btnCheckOut","DI");
    DisplayMode("tab3_number_of_adult","DI");
    DisplayMode("tab3_number_of_minor","DI");
    DisplayMode("tab3_payment_status","DI");
    SetValue("tab3_customer_id","");
    SetValue("tab3_customer_name","");
    SetValue("tab3_in_date","");
    SetValue("tab3_out_date","");
    SetValue("tab3_room_id","");
    SetValue("tab3_payment_status","");
    SetValue("tab3_number_of_adult","");
    SetValue("tab3_number_of_minor","");
    populateRoomID();
    populatePaymentStatus();
    HideLoading();
}

function populateRoomID(){
    var qrySQL = "SELECT room_id FROM was_hotel_book_transactions where room_status='101'";
    var result = SelectDB(qrySQL);
    $("#tab3_room_id").empty();
    if(result !== ""){
        result = result.split('~');
        $("#tab3_room_id").append($("<option></option>").val("").html(""));
        for (var i=0; i < result.length; i++){
            $("#tab3_room_id").append($("<option></option>").val(result[i]).html(result[i]));
        }
    }
}

function populatePaymentStatus(){
    var qrySQL = "SELECT was_id, payment_status FROM was_cs_payment_status";
    var result = SelectDB(qrySQL);
    $("#tab3_payment_status").empty();
    if(result !== ""){
        result = result.split('~');
        $("#tab3_payment_status").append($("<option></option>").val("").html(""));
        for (var i=0; i < result.length; i++){
            var value = result[i].split('^');
            $("#tab3_payment_status").append($("<option></option>").val(value[0]).html(value[1]));
        }
    }
}

function LF_tab3_room_id(){
    ShowLoading();
    var room_id = GetValue("tab3_room_id");
    if(room_id !== ""){
        var qrySelect = "select trans.customer_id, concat(cust.first_name, ' ', cust.last_name) name, trans.in_date, trans.out_date, trans.transaction_id, trans.transaction_date,trans.transaction_time, trans.days, trans.payment_status, trans.number_of_adult, trans.number_of_minor,trans.transaction_amount,trans.deposit_mode,deposit_amount"
                + " from was_hotel_book_transactions trans, was_customer_info cust"
                + " where trans.customer_id = cust.customer_id and trans.book_status ='2' and trans.room_status='101' and trans.room_id = '"+room_id+"'";
        var result = SelectDB(qrySelect);
        if(result !== ""){
        var value = result.split('^');
            var customer_id = value[0];
            var customer_name = value[1];
            var in_date = value[2];
            var out_date = value[3];
            var transaction_id = value[4];
            var transaction_date = value[5];
            var transaction_time = value[6];
            var days = value[7];
            var payment_status = value[8];
            var number_of_adult = value[9];
            var number_of_minor = value[10];
            var transaction_amount = value[11];
            var deposit_mode = value[12];
            var deposit_amount = value[13];
            SetValue("tab3_customer_id",customer_id);
            SetValue("tab3_customer_name",customer_name);
            SetValue("tab3_in_date",in_date);
            SetValue("tab3_out_date",out_date);
            SetValue("tab3_payment_status",payment_status);
            SetValue("tab3_number_of_adult",number_of_adult);
            SetValue("tab3_number_of_minor",number_of_minor);
            SetValue("tab3_transaction_id",transaction_id);
            SetValue("tab3_transaction_date",transaction_date);
            SetValue("tab3_transaction_time",transaction_time);
            SetValue("tab3_transaction_amount",transaction_amount);
            SetValue("tab3_deposit_mode",deposit_mode);
            SetValue("tab3_deposit_amount",deposit_amount);
            SetValue("tab3_days",days);
            SetFocus("tab3_btnCheckOut");
            DisplayMode("tab3_btnCheckOut","DI");
            if(payment_status === "101"){
                DisplayMode("tab3_btnCheckOut","EN");
            }
        }
    } else {
        SetValue("tab3_customer_id","");
        SetValue("tab3_customer_name","");
        SetValue("tab3_in_date","");
        SetValue("tab3_out_date","");
        SetValue("tab3_transaction_amount","");
        SetValue("tab3_number_of_adult","");
        SetValue("tab3_number_of_minor","");
        SetValue("tab3_transaction_id","");
        SetValue("tab3_transaction_date","");
        SetValue("tab3_transaction_time","");
        SetValue("tab3_days","");
        DisplayMode("tab3_btnCheckOut","DI");
    }
    HideLoading();
}

function tab3Checkout(){
    ShowLoading();
    //Update Room Status to Vacant and ready
    var qryUpdate = "update was_hotel_room_details set room_status='108' where room_id='"+GetValue("tab3_room_id")+"'";
    var result1 = UpdateDB(qryUpdate);
    if(result1 === ""){
        HideLoading();
        return;
    }
    
    var transaction_id = GetCounter("001","10");
    var transaction_date = getServerSession("record_date");
    var transaction_time = currentTime();
    var customer_id = GetValue("tab3_customer_id");
    var room_id = GetValue("tab3_room_id");
    var in_date = "00.00.0000";
    var out_date = "00.00.0000";
    var days = "0";
    var transaction_amount = "0.00";
    var number_of_adult = GetValue("tab3_number_of_adult");
    var number_of_minor = GetValue("tab3_number_of_minor");
    var deposit_mode = GetValue("tab3_deposit_mode");
    var deposit_amount  = GetValue("tab3_deposit_amount");
    var payment_status = GetValue("tab3_payment_status");
    DeleteDB("delete from was_hotel_book_transactions where room_id='"+room_id+"'");
    //Insert History Transaction from was_hotel_book_transactions
    var qryInsert2 = "insert into was_hotel_book_transactions_history(transaction_id,transaction_date,transaction_time,customer_id,room_id,in_date,out_date,days,transaction_amount,number_of_adult,number_of_minor,book_status,userid,deposit_mode,deposit_amount,payment_status,room_status)"
            + " values('"+GetValue("tab3_transaction_id")+"','"+GetValue("tab3_transaction_date")+"','"+GetValue("tab3_transaction_time")+"','"+customer_id+"','"+room_id+"','"+GetValue("tab3_in_date")+"','"+GetValue("tab3_out_date")+"','"+GetValue("tab3_days")+"','"+GetValue("tab3_transaction_amount")+"','"+number_of_adult+"','"+number_of_minor+"','2','"+getServerSession("userid")+"','"+deposit_mode+"','"+deposit_amount+"','"+payment_status+"','101')";
    var result2 = InsertDB(qryInsert2);
    if(result2 === ""){
        HideLoading();
        return;
    }
    
    //Insert CheckOut Transaction
    var qryInsert3 = "insert into was_hotel_book_transactions_history(transaction_id,transaction_date,transaction_time,customer_id,room_id,in_date,out_date,days,transaction_amount,number_of_adult,number_of_minor,book_status,userid,deposit_mode,deposit_amount,payment_status,room_status)"
            + " values('"+transaction_id+"','"+transaction_date+"','"+transaction_time+"','"+customer_id+"','"+room_id+"','"+in_date+"','"+out_date+"','"+days+"','"+transaction_amount+"','"+number_of_adult+"','"+number_of_minor+"','1','"+getServerSession("userid")+"','"+deposit_mode+"','"+deposit_amount+"','"+payment_status+"','101')";
    var result3 = InsertDB(qryInsert3);
    if(result3 === ""){
        HideLoading();
        return;
    }
    swal({   
        title: "<small>Check Out Successfully.!</small>",
        type: "success",
        html: true,
        showCancelButton: false,   
        confirmButtonText: "OK",   
        closeOnConfirm: true 
    },function(){  
        tab1();
        $( "#tabs" ).tabs( "option", "active", 0 );
    });
    HideLoading();
}
//tab3 end

//tab4
function Details(id){
    ShowLoading();
    var qrySelect = "select transaction_date, transaction_time, customer_id, customer_name, in_date, out_date, CASE WHEN book_status = 2 THEN 'In' WHEN book_status = 1 THEN 'Out' WHEN book_status = 0 THEN 'Reserved' END as book_status, username"
            + " from view_hotel_book_transactions "
            + " where room_id = '"+id+"' order by transaction_id desc";
            
    var result = SelectDB(qrySelect);
    result = result.split('~');
    var display = "";
    if(result != ""){
        for (var i=0; i < result.length; i++){
            display = display + "<tr>";
            var value = result[i].split('^');

                display = display + "<td style='padding:4px; text-align:center;'>" + value[0] + "</td>";
                display = display + "<td style='padding:4px; text-align:center;'>" + value[1] + "</td>";
                display = display + "<td style='padding:4px; text-align:center;'>" + value[2] + "</td>";
                display = display + "<td style='padding:4px;'>" + value[3] + "</td>";
                display = display + "<td style='padding:4px; text-align:center;'>" + value[4] + "</td>";
                display = display + "<td style='padding:4px; text-align:center;'>" + value[5] + "</td>";
                display = display + "<td style='padding:4px;'>" + value[6] + "</td>";
                display = display + "<td style='padding:4px;'>" + value[7] + "</td>";
            display = display + "</tr>";
        }
    }
    SetValueInner("displayBookTrans","");
    SetValueInner("displayBookTrans",display);
    $( "#tabs" ).tabs( "enable", 4 );
    $( "#tabs" ).tabs( "option", "active", 4 );
    HideLoading();
}
//tab4 end

//tab5

function tab5(){
    ShowLoading();
    populateTab5RoomID();
    populateTab5PaymentMode();
    tab5Reset();
    HideLoading();
}

function tab5Reset(){
    ShowLoading();
    SetValue("tab5_customer_name","");
    SetValue("tab5_in_date","");
    SetValue("tab5_out_date","");
    SetValue("tab5_payment_mode","");
    SetValue("tab5_transaction_amount","");
    DisplayMode("tab5_customer_name","DI");
    DisplayMode("tab5_in_date","DI");
    DisplayMode("tab5_out_date","DI");
    DisplayMode("tab5_deposit_amount","DI");
    DisplayMode("tab5_deposit_mode","DI");
    DisplayMode("tab5_btnPaid","DI");
    SetValueInner("displayHotelTrans","");
    document.getElementById('tab5_deposit_chk').checked = false;
    populateTab5PaymentMode();
    HideLoading();
}

function populateTab5RoomID(){
    var qrySQL = "SELECT room_id FROM was_hotel_book_transactions where payment_status <> '101' and room_status='101'";
    var result = SelectDB(qrySQL);
    $("#tab5_room_id").empty();
    if(result !== ""){
        result = result.split('~');
        $("#tab5_room_id").empty();
        $("#tab5_room_id").append($("<option></option>").val("").html(""));
        for (var i=0; i < result.length; i++){
            $("#tab5_room_id").append($("<option></option>").val(result[i]).html(result[i]));
        }
    }
}

function populateTab5PaymentMode(){
    var qrySQL = "SELECT was_id, payment_mode FROM was_cs_payment_mode";
    var result = SelectDB(qrySQL);
    $("#tab5_payment_mode").empty();
    if(result !== ""){
        result = result.split('~');
        $("#tab5_payment_mode").append($("<option></option>").val("").html(""));
        for (var i=0; i < result.length; i++){
            var value = result[i].split('^');
            $("#tab5_payment_mode").append($("<option></option>").val(value[0]).html(value[1]));
        }
    }
}

function LF_tab5_room_id(){
    ShowLoading();
    var room_id = GetValue("tab5_room_id");
    if(room_id !== ""){
        var qrySelect = "select trans.customer_id, concat(cust.first_name, ' ', cust.last_name) name, trans.in_date, trans.out_date, trans.deposit_mode, trans.deposit_amount"
                + " from was_hotel_book_transactions trans, was_customer_info cust"
                + " where trans.customer_id = cust.customer_id and trans.room_id = '"+room_id+"'";
        var result = SelectDB(qrySelect);
        if(result !== ""){
        var value = result.split('^');
            var customer_id = value[0];
            var customer_name = value[1];
            var in_date = value[2];
            var out_date = value[3];
            var deposit_mode = value[4];
            var deposit_amount = value[5];
            SetValue("tab5_customer_id",customer_id);
            SetValue("tab5_customer_name",customer_name);
            SetValue("tab5_in_date",in_date);
            SetValue("tab5_out_date",out_date);
            SetValue("tab5_deposit_mode",deposit_mode);
            SetValue("tab5_deposit_amount",deposit_amount);
            
            var trans = SelectDB("select transaction_id, transaction_date, description, transaction_amount, payment_status_txt, payment_status_id from view_hotel_transactions_status where room_id = '"+room_id+"' and payment_status_id='102'");
            trans = trans.split('~');
            var display = "";
            var balance = 0;
            var items = "";
            var transaction_id = "";
            for (var i=0; i < trans.length; i++){
                display = display + "<tr>";
                var value = trans[i].split('^');
                if(value[5] === "102"){
                    balance = parseInt(balance) + parseInt(value[3]);
                }
                    display = display + "<td style='padding:4px; text-align:center;'>" + value[0] + "</td>";
                    display = display + "<td style='padding:4px; text-align:center;'>" + value[1] + "</td>";
                    display = display + "<td style='padding:4px;'>" + value[2] + "</td>";
                    display = display + "<td style='padding:4px; text-align:right;'>" + value[3] + "</td>";
                    display = display + "<td style='padding:4px; text-align:right;'>" + value[4] + "</td>";
                display = display + "</tr>";
                transaction_id = transaction_id + value[0] + ",";
                items = items + '<tr><td style="text-align:left;">'+value[2]+'</td>'
                    + '<td>'+value[1]+'</td>'
                    + '<td style="text-align:right;">'+value[3]+'</td></tr>';
            }
            SetValue("tab5_transaction_id",transaction_id.substring(0, transaction_id.length - 1));
            SetValue("tab5_items",items);
            //balance = balance - parseInt(deposit_amount);
            display = display + "<tr>";
            display = display + "<td style='padding:4px;' colspan='3'><b>Total</b></td>";
            display = display + "<td style='padding:4px; text-align:right; font-weight:bold;' id='balance'>" + balance.toFixed(2) + "</td>";
            if(parseInt(balance) > 0){
                display = display + "<td style='padding:4px; text-align:right;'><b>Unpaid</b></td>";
            } else {
                display = display + "<td style='padding:4px; text-align:right;'><b>Clear</b></td>";
            }
            
            SetValueInner("displayHotelTrans","");
            SetValueInner("displayHotelTrans",display);
            
            SetFocus("tab5_btnPaid");
        }
    } else {
        SetValue("tab5_customer_id","");
        SetValue("tab5_customer_name","");
        SetValue("tab5_in_date","");
        SetValue("tab5_out_date","");
        SetValue("tab5_deposit_mode","");
        SetValue("tab5_deposit_amount","");
        DisplayMode("tab5_btnPaid","DI");
    }
    HideLoading();
}

function LF_tab5_payment_mode(){
    if(GetValue("tab5_payment_mode") !== "" && GetValue("tab5_transaction_amount") !== "" && parseInt(GetValueInner("balance")) !== "" && parseInt(GetValue("tab5_transaction_amount")) >= parseInt(GetValueInner("balance"))){
        DisplayMode("tab5_btnPaid","EN");
    } else {
        DisplayMode("tab5_btnPaid","DI");
    }
}

function LF_tab5_transaction_amount(){
    if(document.getElementById('tab5_deposit_chk').checked){
        var amountPaid = parseInt(GetValue("tab5_transaction_amount")) +  parseInt(GetValue("tab5_deposit_amount"));
    } else {
        var amountPaid = parseInt(GetValue("tab5_transaction_amount"));
    }
    SetValue("tab5_amount_paid", amountPaid);
    if(GetValue("tab5_payment_mode") !== "" && GetValue("tab5_transaction_amount") !== "" && parseInt(GetValueInner("balance")) !== "" && parseInt(amountPaid) >= parseInt(GetValueInner("balance"))){
        DisplayMode("tab5_btnPaid","EN");
    } else {
        DisplayMode("tab5_btnPaid","DI");
    }
    
    if(GetValue("tab5_transaction_amount") !== ""){
        formatDecimal(document.getElementById("tab5_transaction_amount"));
    } else {
        SetValue("tab5_transaction_amount","0.00")
    }
}

function populateTab5PaymentMode(){
    var qrySQL = "SELECT was_id, payment_mode FROM was_cs_payment_mode";
    var result = SelectDB(qrySQL);
    $("#tab5_payment_mode").empty();
    $("#tab5_deposit_mode").empty();
    if(result !== ""){
        result = result.split('~');
        $("#tab5_payment_mode").append($("<option></option>").val("").html(""));
        $("#tab5_deposit_mode").append($("<option></option>").val("").html(""));
        for (var i=0; i < result.length; i++){
            var value = result[i].split('^');
            $("#tab5_payment_mode").append($("<option></option>").val(value[0]).html(value[1]));
            $("#tab5_deposit_mode").append($("<option></option>").val(value[0]).html(value[1]));
        }
    }
}

function tab5Paid(){
    ShowLoading();
    if(GetValue("tab5_amount_paid") !== "" && parseInt(GetValue("tab5_amount_paid")) >= parseInt(GetValueInner("balance"))){
        var invoice_number = GetCounter("009","10");
        var transaction_date = getServerSession("record_date");
        var transaction_time = currentTime();
        var customer_id = GetValue("tab5_customer_id");
        var room_id = GetValue("tab5_room_id");
        var payment_mode = GetValue("tab5_payment_mode");
        var transaction_amount = GetValue("tab5_transaction_amount");
        var userid = getServerSession("userid");
        var qryInsert = "insert into was_hotel_payment(invoice_number,transaction_date,transaction_time,customer_id,room_id,payment_mode,transaction_amount,userid)"
                + "values('"+invoice_number+"','"+transaction_date+"','"+transaction_time+"','"+customer_id+"','"+room_id+"','"+payment_mode+"','"+transaction_amount+"','"+userid+"')";
        var result = InsertDB(qryInsert);
        alert(result)
        if(result === ""){
            HideLoading();
            return;
        }
        
        var update = UpdateDB("update was_hotel_book_transactions set payment_status='101' where room_id='"+room_id+"' and customer_id='"+customer_id+"'");
        if(update === ""){
            HideLoading();
            return;
        }
        
        var transaction_id = GetValue("tab5_transaction_id");
        var value = transaction_id.split(",");
        for (var i=0; i < value.length; i++){
            UpdateDB("update was_product_sales_invoice_header set payment_status='101' where sales_id='"+value[i]+"'");
        }
        
        var change = parseInt(GetValue("tab5_amount_paid")) - parseInt(GetValueInner("balance"));
        
        window.open(baseURL()+'common/print_receipt.jsp?paid=2&items='+encryptJS(GetValue("tab5_items"))+'&sales_invoice='+encryptJS(transaction_id)+'&total='+encryptJS(parseInt(GetValueInner("balance")).toFixed(2))+'&amount='+encryptJS(parseInt(GetValue("tab5_amount_paid")).toFixed(2))+'&change='+encryptJS(change.toFixed(2)), '_blank', 'resizable=no, scrollbars=yes, titlebar=no, width=300, height=600, top=10, left=10,menubar=no, toolbar=no, location=no, scrollbars=no');
        swal({   
            title: "<small>Update payment succesfully!</small>",   
            text: "Change: <span style='font-weight: bold;'>"+change.toFixed(2)+"</span>",   
            type: "success",
            html: true,
            showCancelButton: false,   

            confirmButtonText: "OK",   
            closeOnConfirm: true 
        },function(){  
            $( "#tabs" ).tabs( "option", "active", 3 );
            tab3();
        });
    }
    HideLoading();
}
//tab5 end

//tab6
function tab6(){
    ShowLoading();
    var now = new Date();
    var year = now.getYear();
    if (year < 1000){
	year+=1900;
    }
    var month = now.getMonth();
    var filter = year.toString()+addZero(month+1);
    
    var qrySelectRoom ="select room_id, type.room_type from was_hotel_room_details room, was_cs_hotel_room_type type where room.room_type = type.was_id order by room_id";
    var resultRoom = SelectDB(qrySelectRoom);
    var rooms = "";
    if(resultRoom !== ""){
        resultRoom = resultRoom.split('~');
        for (var i=0; i < resultRoom.length; i++){
            var value = resultRoom[i].split("^");
            rooms += '{ room_no:"'+value[0]+'",room_details:"'+value[1]+'"},';
        }
    }
    rooms = rooms.substring(0, rooms.length - 1);
    rooms = eval("["+rooms+"]");
    
    var qrySelectSched ="select  room_id, concat(left(to_date(in_date),4),'-',mid(to_date(in_date),5,2),'-', right(to_date(in_date),2)) start_date, concat(left(to_date(out_date),4),'-',mid(to_date(out_date),5,2),'-', right(to_date(out_date),2)) end_date, room_status_txt, customer_name"
            + " from view_hotel_book_transactions  where left(to_date(in_date),6) = '"+filter+"' or left(to_date(out_date),6) = '"+filter+"' order by room_id";
    var resultSched = SelectDB(qrySelectSched);
    var sched = "";
    if(resultSched !== ""){
        resultSched = resultSched.split('~');
        for (var i=0; i < resultSched.length; i++){
            var value = resultSched[i].split("^");
            sched += '{ room_no:"'+value[0]+'",start_date:"'+value[1]+'",end_date:"'+value[2]+'",status:"'+value[3]+'",customer_name:"'+value[4]+'"},';
        }
    }
    sched = sched.substring(0, sched.length - 1);
    sched = eval("["+sched+"]");
    
    
    $('#BScheduler').BScheduler({
	year: year,
	month: month,
	rooms: rooms,
        sched: sched
    });
    $( "#tabs" ).tabs( "disable", 6 );
    SetValue("tab6_highlighted","");
    HideLoading();
}

function prevMonth(){
    ShowLoading();   
    //get the higlighted field from next month
    var highlighted = $(".highlighted");
    var arrHightlighted = [];
    for(var i = 0; i < highlighted.length; i++){
        var value = GetValue("tab6_highlighted").split(",");
        if (value.indexOf($(highlighted[i]).attr('id')) === -1){// escape the id on adding when id already found in tab6_highlighted
            arrHightlighted.push($(highlighted[i]).attr('id'));
        }
    }
    if(arrHightlighted != ""){
        if(GetValue("tab6_highlighted") === ""){
            SetValue("tab6_highlighted",arrHightlighted);
        } else {
            SetValue("tab6_highlighted",GetValue("tab6_highlighted")+","+arrHightlighted);
        }
    }
    //end here
    
    var now = new Date($("#ac_date").val());
    now.setMonth(now.getMonth()-1);
    var year = now.getYear();
    if (year < 1000){
	year+=1900;
    }
    var month = now.getMonth();
    var filter = year.toString()+addZero(month+1);
    
    var qrySelectRoom ="select room_id, type.room_type from was_hotel_room_details room, was_cs_hotel_room_type type where room.room_type = type.was_id order by room_id";
    var resultRoom = SelectDB(qrySelectRoom);
    var rooms = "";
    if(resultRoom !== ""){
        resultRoom = resultRoom.split('~');
        for (var i=0; i < resultRoom.length; i++){
            var value = resultRoom[i].split("^");
            rooms += '{ room_no:"'+value[0]+'",room_details:"'+value[1]+'"},';
        }
    }
    rooms = rooms.substring(0, rooms.length - 1);
    rooms = eval("["+rooms+"]");
    
    var qrySelectSched ="select  room_id, concat(left(to_date(in_date),4),'-',mid(to_date(in_date),5,2),'-', right(to_date(in_date),2)) start_date, concat(left(to_date(out_date),4),'-',mid(to_date(out_date),5,2),'-', right(to_date(out_date),2)) end_date, room_status_txt, customer_name"
            + " from view_hotel_book_transactions  where left(to_date(in_date),6) = '"+filter+"' or left(to_date(out_date),6) = '"+filter+"' order by room_id";
    var resultSched = SelectDB(qrySelectSched);
    var sched = "";
    if(resultSched !== ""){
        resultSched = resultSched.split('~');
        for (var i=0; i < resultSched.length; i++){
            var value = resultSched[i].split("^");
            sched += '{ room_no:"'+value[0]+'",start_date:"'+value[1]+'",end_date:"'+value[2]+'",status:"'+value[3]+'",customer_name:"'+value[4]+'"},';
        }
    }
    sched = sched.substring(0, sched.length - 1);
    sched = eval("["+sched+"]");
    
    
    $('#BScheduler').BScheduler({
	year: year,
	month: month,
	rooms: rooms,
        sched: sched
    });
    
    if(GetValue("tab6_highlighted") !== ""){
        var value = GetValue("tab6_highlighted").split(",");
        for(var i = 0; i < value.length; i++){
            if($("#"+value[i]).val() !== undefined){
                $("#"+value[i]).addClass("highlighted");
            }
        }
    }
    
    
    //reset the value of tab6_highlighted to exclude the value of highlighted date in calendar
    var arr = GetValue("tab6_highlighted").split(",");
    var highlighted = $(".highlighted");
    var arrHightlighted = [];
    for(var i = 0; i < highlighted.length; i++){
       var index = arr.indexOf($(highlighted[i]).attr('id'));
       if (index > -1) {
            arr.splice(index, 1);
        }
    }
    SetValue("tab6_highlighted",arr);
    //end here 
    
    HideLoading();
}
	
function nextMonth(){
    ShowLoading();    
    //get the higlighted field from previous month
    var highlighted = $(".highlighted");
    var arrHightlighted = [];
    for(var i = 0; i < highlighted.length; i++){
        var value = GetValue("tab6_highlighted").split(",");
        if (value.indexOf($(highlighted[i]).attr('id')) === -1){
            arrHightlighted.push($(highlighted[i]).attr('id'));
        }
    }
    if(arrHightlighted != ""){
        if(GetValue("tab6_highlighted") === ""){
            SetValue("tab6_highlighted",arrHightlighted);
        } else {
            SetValue("tab6_highlighted",GetValue("tab6_highlighted")+","+arrHightlighted);
        }
    }
    //end here 
    
    var now = new Date($("#ac_date").val());
    now.setMonth(now.getMonth()+1);
    var year = now.getYear();
    if (year < 1000){
	year+=1900;
    }
    var month = now.getMonth();
    var filter = year.toString()+addZero(month+1);
    
    var qrySelectRoom ="select  room_id, type.room_type from was_hotel_room_details room, was_cs_hotel_room_type type where room.room_type = type.was_id order by room_id";
    var resultRoom = SelectDB(qrySelectRoom);
    var rooms = "";
    if(resultRoom !== ""){
        resultRoom = resultRoom.split('~');
        for (var i=0; i < resultRoom.length; i++){
            var value = resultRoom[i].split("^");
            rooms += '{ room_no:"'+value[0]+'",room_details:"'+value[1]+'"},';
        }
    }
    rooms = rooms.substring(0, rooms.length - 1);
    rooms = eval("["+rooms+"]");
    
    var qrySelectSched ="select  room_id, concat(left(to_date(in_date),4),'-',mid(to_date(in_date),5,2),'-', right(to_date(in_date),2)) start_date, concat(left(to_date(out_date),4),'-',mid(to_date(out_date),5,2),'-', right(to_date(out_date),2)) end_date, room_status_txt, customer_name"
            + " from view_hotel_book_transactions  where left(to_date(in_date),6) = '"+filter+"' or left(to_date(out_date),6) = '"+filter+"' order by room_id";
    var resultSched = SelectDB(qrySelectSched);
    var sched = "";
    if(resultSched !== ""){
        resultSched = resultSched.split('~');
        for (var i=0; i < resultSched.length; i++){
            var value = resultSched[i].split("^");
            sched += '{ room_no:"'+value[0]+'",start_date:"'+value[1]+'",end_date:"'+value[2]+'",status:"'+value[3]+'",customer_name:"'+value[4]+'"},';
        }
    }
    sched = sched.substring(0, sched.length - 1);
    sched = eval("["+sched+"]");
    
    
    $('#BScheduler').BScheduler({
	year: year,
	month: month,
	rooms: rooms,
        sched: sched
    });
    if(GetValue("tab6_highlighted") !== ""){
        var value = GetValue("tab6_highlighted").split(",");
        for(var i = 0; i < value.length; i++){
            if($("#"+value[i]).val() !== undefined){
                $("#"+value[i]).addClass("highlighted");
            }
        }
    }
    
    //reset the value of tab6_highlighted to exclude the value of highlighted date in calendar
    var arr = GetValue("tab6_highlighted").split(",");
    var highlighted = $(".highlighted");
    var arrHightlighted = [];
    for(var i = 0; i < highlighted.length; i++){
       var index = arr.indexOf($(highlighted[i]).attr('id'));
       if (index > -1) {
            arr.splice(index, 1);
        }
    }
    SetValue("tab6_highlighted",arr);
    //end here 
    
    HideLoading();
}

function tab6_Clear(){
    $("td").removeClass("highlighted");
    SetValue("tab6_highlighted","");
}

function tab6_Reserved(){
    var now = new Date($("#ac_date").val());
    var year = now.getYear();
    if (year < 1000){
	year+=1900;
    }
    if($(".highlighted").attr("title") === undefined){
        alert("Please select the date.");
        return;
    }
    var month = now.getMonth()+1;
    var room_id = $(".highlighted").attr("title");
    
    var highlighted = $(".highlighted");
    var days = [];
    for(var i = 0; i < highlighted.length; i++){
        days.push(($(highlighted[i]).attr('id').split("_"))[1]);
    }

    var date = [];
    if(GetValue("tab6_highlighted") !== ""){
        var arr = GetValue("tab6_highlighted").split(",");
        for(var x = 0; x < arr.length; x++){
            date.push((arr[x].split("_"))[1]); //get the date from tab6_highlighted
        }
        date.push(days);
    } else {
        date.push(days);
    }
    date.sort();//sort the date array
    if((date.toString().split(",")).length === 1){
        alert("Please select the Out date.");
        return;
    }
    tab7Open(room_id,date);
    
}
//tab6 end

//tab7
function tab7Open(room_id,date){
    ShowLoading();
    tab7Reset();
    $( "#tabs" ).tabs( "enable", 6 );
    $( "#tabs" ).tabs( "option", "active", 6 );
    var checkin_date = "";
    var checkout_date = "";
    date = date.toString().split(",");
    var count = date.length;
    for (var i=0; i < count; i++){
        if(i === 0){
            var val = date[0].split("-");
            checkin_date = addZero(parseInt(val[1])+1)+"."+val[2]+"."+val[0];
        }
        if(i === count-1){
            var val = date[i].split("-");
            checkout_date = addZero(parseInt(val[1])+1)+"."+val[2]+"."+val[0];
        }
    }
    var price =SelectDB("select price from was_hotel_room_details where room_id ='"+room_id+"'");
    var totalAmount = price*count;
    SetValue("tab7_room_id",room_id);
    SetValue("tab7_days",count-1);
    SetValue("tab7_in_date",checkin_date);
    SetValue("tab7_out_date",checkout_date);
    SetValue("tab7_price",price);
    SetValue("tab7_amount",totalAmount.toFixed(2));
    autocompleteCustomer("tab7");
    populateTab7Gender();
    populateTab7Country();
    populateTab7City();
    populateTab7Tariff();
    populateTab7CustomerType();
    populateTab7DepositMode();
    populateTab7IDType();
    HideLoading();
}

function tab7Reset(){
    var fields = "customer_id,first_name,last_name,gender,contact_number,email,address,city,country,number_of_adult,number_of_minor,tariff,customer_type,id_type,id_number";
    fields = fields.split(',');
    for (var i=0; i < fields.length; i++){
        DisplayMode("tab7_"+fields[i],"EN");
        SetValue("tab7_"+fields[i],"");
    }
    
    SetValue("tab7_deposit_amount","0.00");
    SetValue("tab7_number_of_adult","0");
    SetValue("tab7_number_of_minor","0");
    SetValue("tab7_deposit_mode","");
    DisplayMode("tab7_room_id","DI");
    DisplayMode("tab7_price","DI");
    DisplayMode("tab7_customer_id","DI");
    DisplayMode("tab7_days","DI");
    DisplayMode("tab7_in_date","DI");
    DisplayMode("tab7_out_date","DI");
}

function LF_tab7_first_name(){
    if(GetValue("tab7_first_name") === ""){
        SetValue("tab7_customer_id","");
        var fields = "last_name,gender,contact_number,email,address,city,country,tariff,customer_type,id_type,id_number";
        fields = fields.split(",");
        for (var i=0; i < fields.length; i++){
            SetValue("tab7_"+fields[i],"");
            DisplayMode("tab7_"+fields[i],"EN");
        }
    } else {
        if(GetValue("tab7_customer_id") !== ""){
            var fields = "gender,contact_number,email,address,city,country,tariff,customer_type,id_type,id_number";
            fields = fields.split(",");
            var qrySelect = "select gender,contact_number,email,address,city,country,tariff,customer_type,id_type,id_number from was_customer_info where customer_id ='"+GetValue("tab7_customer_id")+"'";
            var result = SelectDB(qrySelect);
            var value = result.split('^');
            for (var i=0; i < value.length; i++){
                SetValue("tab7_"+fields[i],value[i]);
                DisplayMode("tab7_"+fields[i],"EN");
            }
            SetValue("tab7_number_of_adult","0");
            SetValue("tab7_number_of_minor","0");
        }
    }
}

function populateTab7Gender(){
    var qrySQL = "SELECT was_id, gender FROM was_cs_gender";
    var result = SelectDB(qrySQL);
    if(result !== ""){
        result = result.split('~');
        $("#tab7_gender").empty();
        $("#tab7_gender").append($("<option></option>").val("").html(""));
        for (var i=0; i < result.length; i++){
            var value = result[i].split('^');
            $("#tab7_gender").append($("<option></option>").val(value[0]).html(value[1]));
        }
    }
}

function populateTab7Country(){
    var qrySQL = "select was_id, country from was_cs_country";
    var result = SelectDB(qrySQL);
    if(result !== ""){
        result = result.split('~');
        $("#tab7_country").empty();
        $("#tab7_country").append($("<option></option>").val("").html(""));
        for (var i=0; i < result.length; i++){
            var value = result[i].split('^');
            $("#tab7_country").append($("<option></option>").val(value[0]).html(value[1]));
        }
    }
}

function populateTab7City(){
    var qrySQL = "select was_id, city from was_cs_city";
    var result = SelectDB(qrySQL);
    if(result !== ""){
        result = result.split('~');
        $("#tab7_city").empty();
        $("#tab7_city").append($("<option></option>").val("").html(""));
        for (var i=0; i < result.length; i++){
            var value = result[i].split('^');
            $("#tab7_city").append($("<option></option>").val(value[0]).html(value[1]));
        }
    }
}

function populateTab7Tariff(){
    var qrySQL = "SELECT was_id, tariff FROM was_cs_tariff";
    var result = SelectDB(qrySQL);
    if(result !== ""){
        result = result.split('~');
        $("#tab7_tariff").empty();
        $("#tab7_tariff").append($("<option></option>").val("").html(""));
        for (var i=0; i < result.length; i++){
            var value = result[i].split('^');
            $("#tab7_tariff").append($("<option></option>").val(value[0]).html(value[1]));
        }
    }
}

function populateTab7CustomerType(){
    var qrySQL = "SELECT was_id, customer_type FROM was_cs_customer_type";
    var result = SelectDB(qrySQL);
    if(result !== ""){
        result = result.split('~');
        $("#tab7_customer_type").empty();
        $("#tab7_customer_type").append($("<option></option>").val("").html(""));
        for (var i=0; i < result.length; i++){
            var value = result[i].split('^');
            $("#tab7_customer_type").append($("<option></option>").val(value[0]).html(value[1]));
        }
    }
}

function populateTab7DepositMode(){
    var qrySQL = "SELECT was_id, payment_mode FROM was_cs_payment_mode";
    var result = SelectDB(qrySQL);
    if(result !== ""){
        result = result.split('~');
        $("#tab7_deposit_mode").empty();
        for (var i=0; i < result.length; i++){
            var value = result[i].split('^');
            $("#tab7_deposit_mode").append($("<option></option>").val(value[0]).html(value[1]));
        }
    }
}

function populateTab7IDType(){
    var qrySQL = "SELECT was_id, id_type FROM was_cs_id_type";
    var result = SelectDB(qrySQL);
    if(result !== ""){
        result = result.split('~');
        $("#tab7_id_type").empty();
        $("#tab7_id_type").append($("<option></option>").val("").html(""));
        for (var i=0; i < result.length; i++){
            var value = result[i].split('^');
            $("#tab7_id_type").append($("<option></option>").val(value[0]).html(value[1]));
        }
    }
}

function tab7Reserved(){
    ShowLoading();
    if(parseInt(GetValue("tab7_days")) === 0){
        alert("Please input the Check-in and Check-out Date correctly.");
        HideLoading();
        return;
    }
    var requiredFields = "first_name,last_name,gender,contact_number,address,city,country,tariff,customer_type,id_type,id_number";
    requiredFields = requiredFields.split(',');
    var checkrequiredFields = 0;
    for(var x = 0; x < requiredFields.length; x++){
        var fieldID = "#tab7_"+requiredFields[x].trim();
        if($(fieldID).val() === ""){
            document.getElementById("lb_tab7_"+requiredFields[x].trim()).style.color ="red";
            checkrequiredFields = 1;
        } else {
            document.getElementById("lb_tab7_"+requiredFields[x].trim()).style.color ="black";
        }
    }
    if(checkrequiredFields ===1){
        alert("Please input the required fields");
        HideLoading();
        return;  
    }
    if(GetValue("tab7_customer_id") === ""){
        SetValue("tab7_customer_id", GetCounter("006","10"));
     
        var fields = "customer_id,first_name,last_name,gender,contact_number,email,address,city,country,tariff,customer_type,id_type,id_number";
        fields = fields.split(',');
        var values = "";
        for(var x = 0; x < fields.length; x++){
            values = values + "'" + GetValue("tab7_"+fields[x]) + "',";
        }
        values = values + "'" + getServerSession("record_date") + "'";
        //Insert new customer
        var qryInsert = "insert into was_customer_info(has_multiple_address,customer_id,first_name,last_name,gender,contact_number,email,address,city,country,tariff,customer_type,id_type,id_number,record_date)"
                + " values('0',"+values+")";
        var result = InsertDB(qryInsert);
        if(result === ""){
            HideLoading();
            return;
        }
    } else {
        var fields = "first_name,last_name,gender,contact_number,email,address,city,country,tariff,customer_type,id_type,id_number";
        fields = fields.split(',');
        var set = "";
        for (var i=0; i < fields.length; i++){
            set = set + fields[i] + "= '"+GetValue("tab7_"+fields[i])+"',";
        }
        set = set.substring(0, set.length-1);
        var qryUpdate = "update was_customer_info  set " + set + " where customer_id = '"+GetValue("tab7_customer_id")+"'";
        var result1 = UpdateDB(qryUpdate);
        if(result1 === ""){
            HideLoading();
            return;
        }
    }
    
    var transaction_id = GetCounter("001","10");
    var transaction_date = getServerSession("record_date");
    var transaction_time = currentTime();
    var customer_id = GetValue("tab7_customer_id");
    var room_id = GetValue("tab7_room_id");
    var in_date = (GetValue("tab7_in_date").replace("/",".")).replace("/",".");
    var out_date = (GetValue("tab7_out_date").replace("/",".")).replace("/",".");
    var days = GetValue("tab7_days");
    var transaction_amount = GetValue("tab7_amount");
    var number_of_adult = GetValue("tab7_number_of_adult");
    var number_of_minor = GetValue("tab7_number_of_minor");
    var book_status = "0";
    var userid = getServerSession("userid");
    var deposit_mode = GetValue("tab7_deposit_mode");
    var deposit_amount = GetValue("tab7_deposit_amount");
    var payment_status = "102";
    //Insert New Book Transaction
    var qryInsert2 = "insert into was_hotel_book_transactions(transaction_id,transaction_date,transaction_time,customer_id,room_id,in_date,out_date,days,transaction_amount,number_of_adult,number_of_minor,book_status,userid,deposit_mode,deposit_amount,payment_status,room_status)"
            + " values('"+transaction_id+"','"+transaction_date+"','"+transaction_time+"','"+customer_id+"','"+room_id+"','"+in_date+"','"+out_date+"','"+days+"','"+transaction_amount+"','"+number_of_adult+"','"+number_of_minor+"','"+book_status+"','"+userid+"','"+deposit_mode+"','"+deposit_amount+"','"+payment_status+"','110')";
    var result2 = InsertDB(qryInsert2);
    if(result2 === ""){
        HideLoading();
        return;
    }
    swal({   
        title: "<small>Reserved succesfully!</small>",   
        text: "",   
        type: "success",
        html: true,
        showCancelButton: false,   
        confirmButtonText: "OK",   
        closeOnConfirm: true 
    },function(){  
        $( "#tabs" ).tabs( "option", "active", 0 );
        tab1();
        tab7Reset();
    });
    
    HideLoading();
}
//tab7 end

//tab8
function tab8(){
    ShowLoading();
    tab8Reset();
    populatetab8Gender();
    populatetab8Country();
    populatetab8City();
    populatetab8Tariff();
    populatetab8CustomerType();
    populatetab8DepositMode();
    populatetab8IDType();
    autocompletetab8Customer();
    HideLoading();
}

function tab8Reset(){
    var fields = "customer_id,last_name,gender,contact_number,email,address,city,country,number_of_adult,number_of_minor,tariff,customer_type,id_type,id_number";
    fields = fields.split(',');
    for (var i=0; i < fields.length; i++){
        DisplayMode("tab8_"+fields[i],"DI");
        SetValue("tab8_"+fields[i],"");
    }
    SetValue("tab8_days",0);
    SetValue("tab8_amount","0.00");
    SetValue("tab8_deposit_amount","0.00");
    SetValue("tab8_number_of_adult","0");
    SetValue("tab8_number_of_minor","0");
    SetValue("tab8_in_date","");
    SetValue("tab8_out_date","");
    SetValue("tab8_deposit_mode","");
    SetValue("tab8_first_name","");
    SetValue("tab8_room_id","");
    SetValue("tab8_price","");
    DisplayMode("tab8_room_id","DI");
    DisplayMode("tab8_price","DI");
    DisplayMode("tab8_customer_id","DI");
    DisplayMode("tab8_days","DI");
    DisplayMode("tab8_in_date","DI");
    DisplayMode("tab8_out_date","DI");
    DisplayMode("tab8_amount","DI");
    DisplayMode("tab8_deposit_mode","DI");
    DisplayMode("tab8_deposit_amount","DI");
}

function LF_tab8_first_name(){
    if(GetValue("tab8_first_name") === ""){
        SetValue("tab8_customer_id","");
        var fields = "last_name,gender,contact_number,email,address,city,country,tariff,customer_type,id_type,id_number";
        fields = fields.split(",");
        for (var i=0; i < fields.length; i++){
            SetValue("tab8_"+fields[i],"");
            DisplayMode("tab8_"+fields[i],"EN");
        }
    } else {
        if(GetValue("tab8_customer_id") !== ""){
            var fields = "gender,contact_number,email,address,city,country,tariff,customer_type,id_type,id_number,room_id,in_date,out_date,days,amount,number_of_adult,number_of_minor,deposit_mode,deposit_amount,transaction_id";
            fields = fields.split(",");
            var qrySelect = "select gender,contact_number,email,address,city,country,tariff,customer_type,id_type,id_number, res.room_id, res.in_date, res.out_date, res.days, res.transaction_amount, res.number_of_adult, res.number_of_minor, res.deposit_mode, res.deposit_amount, res.transaction_id from was_customer_info cust, was_hotel_book_transactions res"
                    + " where has_multiple_address = '0' and res.customer_id = cust.customer_id and room_status='110'"
                    + " and res.customer_id ='"+GetValue("tab8_customer_id")+"'";
            var result = SelectDB(qrySelect);
            var value = result.split('^');
            for (var i=0; i < value.length; i++){
                SetValue("tab8_"+fields[i],value[i]);
                DisplayMode("tab8_"+fields[i],"EN");
            }
            DisplayMode("tab8_last_name","EN");
            DisplayMode("tab8_room_id","DI");
            DisplayMode("tab8_in_date","DI");
            DisplayMode("tab8_out_date","DI");
            DisplayMode("tab8_days","DI");
            var roomPrice = SelectDB("select price from was_hotel_room_details where room_id = '"+GetValue("tab8_room_id")+"'");
            SetValue("tab8_price",roomPrice);
        }
    }
}

function populatetab8Gender(){
    var qrySQL = "SELECT was_id, gender FROM was_cs_gender";
    var result = SelectDB(qrySQL);
    if(result !== ""){
        result = result.split('~');
        $("#tab8_gender").empty();
        $("#tab8_gender").append($("<option></option>").val("").html(""));
        for (var i=0; i < result.length; i++){
            var value = result[i].split('^');
            $("#tab8_gender").append($("<option></option>").val(value[0]).html(value[1]));
        }
    }
}

function populatetab8Country(){
    var qrySQL = "select was_id, country from was_cs_country";
    var result = SelectDB(qrySQL);
    if(result !== ""){
        result = result.split('~');
        $("#tab8_country").empty();
        $("#tab8_country").append($("<option></option>").val("").html(""));
        for (var i=0; i < result.length; i++){
            var value = result[i].split('^');
            $("#tab8_country").append($("<option></option>").val(value[0]).html(value[1]));
        }
    }
}

function populatetab8City(){
    var qrySQL = "select was_id, city from was_cs_city";
    var result = SelectDB(qrySQL);
    if(result !== ""){
        result = result.split('~');
        $("#tab8_city").empty();
        $("#tab8_city").append($("<option></option>").val("").html(""));
        for (var i=0; i < result.length; i++){
            var value = result[i].split('^');
            $("#tab8_city").append($("<option></option>").val(value[0]).html(value[1]));
        }
    }
}

function populatetab8Tariff(){
    var qrySQL = "SELECT was_id, tariff FROM was_cs_tariff";
    var result = SelectDB(qrySQL);
    if(result !== ""){
        result = result.split('~');
        $("#tab8_tariff").empty();
        $("#tab8_tariff").append($("<option></option>").val("").html(""));
        for (var i=0; i < result.length; i++){
            var value = result[i].split('^');
            $("#tab8_tariff").append($("<option></option>").val(value[0]).html(value[1]));
        }
    }
}

function populatetab8CustomerType(){
    var qrySQL = "SELECT was_id, customer_type FROM was_cs_customer_type";
    var result = SelectDB(qrySQL);
    if(result !== ""){
        result = result.split('~');
        $("#tab8_customer_type").empty();
        $("#tab8_customer_type").append($("<option></option>").val("").html(""));
        for (var i=0; i < result.length; i++){
            var value = result[i].split('^');
            $("#tab8_customer_type").append($("<option></option>").val(value[0]).html(value[1]));
        }
    }
}

function populatetab8DepositMode(){
    var qrySQL = "SELECT was_id, payment_mode FROM was_cs_payment_mode";
    var result = SelectDB(qrySQL);
    if(result !== ""){
        result = result.split('~');
        $("#tab8_deposit_mode").empty();
        for (var i=0; i < result.length; i++){
            var value = result[i].split('^');
            $("#tab8_deposit_mode").append($("<option></option>").val(value[0]).html(value[1]));
        }
    }
}

function populatetab8IDType(){
    var qrySQL = "SELECT was_id, id_type FROM was_cs_id_type";
    var result = SelectDB(qrySQL);
    if(result !== ""){
        result = result.split('~');
        $("#tab8_id_type").empty();
        $("#tab8_id_type").append($("<option></option>").val("").html(""));
        for (var i=0; i < result.length; i++){
            var value = result[i].split('^');
            $("#tab8_id_type").append($("<option></option>").val(value[0]).html(value[1]));
        }
    }
}

function tab8Book(){
    ShowLoading();
    var requiredFields = "first_name,last_name,gender,contact_number,address,city,country,tariff,customer_type,id_type,id_number";
    requiredFields = requiredFields.split(',');
    var checkrequiredFields = 0;
    for(var x = 0; x < requiredFields.length; x++){
        var fieldID = "#tab8_"+requiredFields[x].trim();
        if($(fieldID).val() === ""){
            document.getElementById("lb_tab8_"+requiredFields[x].trim()).style.color ="red";
            checkrequiredFields = 1;
        } else {
            document.getElementById("lb_tab8_"+requiredFields[x].trim()).style.color ="black";
        }
    }
    if(checkrequiredFields ===1){
        alert("Please input the required fields");
        HideLoading();
        return;  
    }
    if(GetValue("tab8_customer_id") === ""){
        SetValue("tab8_customer_id", GetCounter("006","10"));
     
        var fields = "customer_id,first_name,last_name,gender,contact_number,email,address,city,country,tariff,customer_type,id_type,id_number";
        fields = fields.split(',');
        var values = "";
        for(var x = 0; x < fields.length; x++){
            values = values + "'" + GetValue("tab8_"+fields[x]) + "',";
        }
        values = values + "'" + getServerSession("record_date") + "'";
        //Insert new customer
        var qryInsert = "insert into was_customer_info(has_multiple_address,customer_id,first_name,last_name,gender,contact_number,email,address,city,country,tariff,customer_type,id_type,id_number,record_date)"
                + " values('0',"+values+")";
        var result = InsertDB(qryInsert);
        if(result === ""){
            HideLoading();
            return;
        }
    } else {
        var fields = "first_name,last_name,gender,contact_number,email,address,city,country,tariff,customer_type,id_type,id_number";
        fields = fields.split(',');
        var set = "";
        for (var i=0; i < fields.length; i++){
            set = set + fields[i] + "= '"+GetValue("tab8_"+fields[i])+"',";
        }
        set = set.substring(0, set.length-1);
        var qryUpdate = "update was_customer_info  set " + set + " where customer_id = '"+GetValue("tab8_customer_id")+"'";
        var result1 = UpdateDB(qryUpdate);
        if(result1 === ""){
            HideLoading();
            return;
        }
    }
    
    
    
    var transaction_id = GetCounter("001","10");
    var transaction_date = getServerSession("record_date");
    var transaction_time = currentTime();
    var customer_id = GetValue("tab8_customer_id");
    var room_id = GetValue("tab8_room_id");
    var in_date = GetValue("tab8_in_date").replace("/",".");
    var out_date = GetValue("tab8_out_date").replace("/",".");
    var days = GetValue("tab8_days");
    var transaction_amount = GetValue("tab8_amount");
    var number_of_adult = GetValue("tab8_number_of_adult");
    var number_of_minor = GetValue("tab8_number_of_minor");
    var book_status = "2";
    var userid = getServerSession("userid");
    var deposit_mode = GetValue("tab8_deposit_mode");
    var deposit_amount = GetValue("tab8_deposit_amount");
    var payment_status = "102";
    //Insert New Book Transaction
    var qryInsert2 = "insert into was_hotel_book_transactions(transaction_id,transaction_date,transaction_time,customer_id,room_id,in_date,out_date,days,transaction_amount,number_of_adult,number_of_minor,book_status,userid,deposit_mode,deposit_amount,payment_status,room_status)"
            + " values('"+transaction_id+"','"+transaction_date+"','"+transaction_time+"','"+customer_id+"','"+room_id+"','"+in_date+"','"+out_date+"','"+days+"','"+transaction_amount+"','"+number_of_adult+"','"+number_of_minor+"','"+book_status+"','"+userid+"','"+deposit_mode+"','"+deposit_amount+"','"+payment_status+"','101')";
    var result2 = InsertDB(qryInsert2);
    if(result2 === ""){
        HideLoading();
        return;
    }
    var qrySelect = "select transaction_id,transaction_date,transaction_time,customer_id,room_id,in_date,out_date,days,transaction_amount,book_status,number_of_adult,number_of_minor,userid,deposit_mode,deposit_amount,payment_status,room_status from was_hotel_book_transactions where transaction_id = '"+GetValue("tab8_transaction_id")+"'";
    var prevRecord = SelectDB(qrySelect);
    var value = prevRecord.split("^");
    var insertVal = "";
    for (var i=0; i < value.length; i++){
        insertVal += "'" +value[i] + "',";
    }
    insertVal = insertVal.substring(0, insertVal.length-1);
    InsertDB("insert into was_hotel_book_transactions_history(transaction_id,transaction_date,transaction_time,customer_id,room_id,in_date,out_date,days,transaction_amount,book_status,number_of_adult,number_of_minor,userid,deposit_mode,deposit_amount,payment_status,room_status) values("+insertVal+")");
    DeleteDB("delete from was_hotel_book_transactions where transaction_id = '"+GetValue("tab8_transaction_id")+"'");
    
    //Update Room Status to Occupied
    var qryUpdate = "update was_hotel_room_details set room_status='101' where room_id='"+GetValue("tab8_room_id")+"'";
    var result1 = UpdateDB(qryUpdate);
    if(result1 === ""){
        HideLoading();
        return;
    }
    
    swal({   
        title: "<small>Book succesfully!</small>",   
        text: "",   
        type: "success",
        html: true,
        showCancelButton: false,   
        confirmButtonText: "OK",   
        closeOnConfirm: true 
    },function(){  
        $( "#tabs" ).tabs( "option", "active", 0 );
        tab1();
        tab8Reset();
    });
    
    HideLoading();
}

function autocompletetab8Customer(){
    var qrySQL = "select res.customer_id, concat(first_name , ' ', last_name) as name, first_name , last_name from was_customer_info cust, was_hotel_book_transactions res"
            + " where has_multiple_address = '0' and res.customer_id = cust.customer_id and room_status='110'";
    var result = SelectDB(qrySQL);
    if(result !== ""){
        result = result.split('~');
        var tags = "[\n";
        for (var i=0; i < result.length; i++){
            var value = result[i].split('^');
            tags = tags + '{ "value": "'+value[0]+'", "label": "'+ value[0] +'    '+ value[2] +'    '+ value[3] +'"},\n';
        }

        tags = tags.slice(',',-2);
        tags = tags + "\n]";
        var yerler = eval(tags);
        if(GetValue("tab8_first_name") === ""){
            $("#tab8_first_name").autocomplete({
                source: yerler,
                minLength: 0,
                minChars: 0,
                focus: function (event, ui) {
                    event.preventDefault();
                    SetValue("tab8_customer_id",ui.item.value);
                },
                select: function (event, ui) {
                    event.preventDefault();
                    SetValue("tab8_customer_id",ui.item.value);
                    var name = ui.item.label.split("    ");
                    SetValue("tab8_first_name",name[1]);
                    SetValue("tab8_last_name",name[2]);
                }
            }).on('focus', function(event) {
                var self = this;
                $(self).autocomplete( "search", "");;
            });
        }
    }
}
//tab8 end