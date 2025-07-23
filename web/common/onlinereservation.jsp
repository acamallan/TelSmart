<%@include file="../functions/was_function.jsp"%>
<%@include file="../functions/classes.jsp"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Online Reservation</title>
    <link href="<%= baseURL()%>styles/style.css" rel="stylesheet" type="text/css" media="all">
    <link href="<%= baseURL()%>styles/jquery-ui.css" rel="stylesheet" type="text/css" media="all">
    <script type="text/javascript" src="<%= baseURL()%>scripts/jquery_1.9.1.js"></script>
    <script type="text/javascript" src="<%= baseURL()%>scripts/jquery-ui.js"></script>
    <script>
    $(function() {
        $("#tab2_in_date").datepicker({
            onSelect: function (dateText, inst) {
                var date = $.datepicker.parseDate($.datepicker._defaults.dateFormat, dateText);
                $("#tab2_out_date").datepicker("option", "minDate", date);
            }   
        });

        $("#tab2_out_date").datepicker({
            onSelect: function (dateText, inst) {

            }   
        });
        $("#tab2_in_date").val("");
        $("#tab2_out_date").val("");
        $("#tab2_in_date").datepicker("option", "minDate", 1 );
        
    });
    </script>
</head>
<body>
    <div style="position: relative">
        <div class="block" style="margin-left: 10px; top: 10px;">
            <h3>Select Date</h3>
            
        </div>
        <div class="block" style="margin-left: 10px; top: 40px;">
            <label>Check-in Date</label>
            <input type="text" tabindex="1" name="tab2_in_date" id="tab2_in_date" style="width:80px;" >
        </div>
        <div class="block" style="margin-left: 10px; top: 70px;">
            <label>Check-out Date</label>
            <input type="text" tabindex="2" name="tab2_out_date" id="tab2_out_date" style="width:80px;">
        </div>
        <div class="block" style="margin-left: 10px; top: 100px;">
            <label> </label>
            <input type="button" tabindex="20" name="tab2_Book" id="tab2_Book" value="Find Room" style="width:80px;" onclick="Tab2Book()">
        </div>
    </div>
</body>
</html>
