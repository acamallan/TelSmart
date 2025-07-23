<%@include file="../header.jsp"%>
<%@include file="../functions/record_function.jsp"%>

<%
/* No need to put String as variables already initialize */
table = "was_hotel_customer_info";
fields = "customer_id as rowid,customer_id,first_name,last_name,gender,contact_number,email,address,city,country,id_number,number_of_adult,number_of_minor,record_date";
where = "customer_id";
/*used in Add New*/
enableFields = "first_name,last_name,gender,contact_number,email,address,city,country,id_number,number_of_adult,number_of_minor";
/*used in Amend*/
amendableFields = "first_name,last_name,gender,contact_number,email,address,city,country,id_number,number_of_adult,number_of_minor";
requiredFields = "first_name,last_name,gender,contact_number,address,city,country,number_of_adult,number_of_minor";

pageMode = "E,D";
/*End here*/

String title = "Customer Information";
%>
<%@include file="../common/sidefind.jsp"%>
<div id="tabs" style="position:relative; z-index:0; width: 950px; float: left; margin: 0px 5px 5px 5px;">
     <ul style="padding-left: 2px;">
        <li><a oncontextmenu="return false;" href="#tabs_1" id="tab1" style="padding:8px 20px; font-weight: bold; white-space: normal; vertical-align:middle;" onclick="tab1()">Details</a></li>
        <li><a oncontextmenu="return false;" href="#tabs_2" id="tab2" style="padding:8px 20px; font-weight: bold;" onclick="tab2()"> History </a></li>
    </ul>
    <div id="tabs_1" style="height: 495px;">
        <div style="position: relative">
            <div class="block" style="margin-left: 690px; top: 20px;">
                <label id="lb_record_date">Record date</label>
                <input type="text" name="record_date" id="record_date" style="width:80px;">
            </div>
        </div>
        <fieldset style="width:850px; height:220px; margin-left:25px; margin-top: 50px; border: 1px solid #ddd; background-color: #f6f6f6; padding:5px;">
            <legend style="font-size: 12px; font-weight: bold; padding:0 10px">Customer Information</legend>
            <div style="position: relative">
                <div class="block" style="margin-left: 50px; top: 0px;">
                    <label id="lb_customer_id">Customer ID</label>
                    <input type="text" name="customer_id" id="customer_id" value="" style="width:100px;">
                </div>
                <div class="block" style="margin-left: 50px; top: 30px;">
                    <label id="lb_first_name">First name</label>
                    <input type="text" name="first_name" id="first_name" value=""  style="width:150px;" maxlength="30">
                </div>
                <div class="block" style="margin-left: 50px; top: 60px;">
                    <label id="lb_last_name">Last name</label>
                    <input type="text" name="last_name" id="last_name"  value="" style="width:150px;" maxlength="30">
                </div>
                <div class="block" style="margin-left: 50px; top: 90px;" >
                    <label id="lb_gender">Gender</label>
                    <select name="gender" id="gender" style="width: 100px;">
                    </select>
                </div>
                <div class="block" style="margin-left: 50px; top: 120px;">
                    <label id="lb_contact_number">Contact number</label>
                    <input type="text" name="contact_number" id="contact_number"  value="" style="width:100px;" maxlength="15"  onkeypress='validate(event);'>
                </div>
                <div class="block" style="margin-left: 50px; top: 150px;">
                    <label id="lb_email">Email</label>
                    <input type="text" name="email" id="email"  value="" style="width:150px;" maxlength="30">
                </div>
                
                <div class="block" style="margin-left: 400px; top: 0px;">
                    <label id="lb_address">Address</label>
                    <input type="text" name="address" id="address" value="" style="width:100px;">
                </div>
                <div class="block" style="margin-left: 400px; top: 30px;">
                    <label id="lb_city">City</label>
                    <select name="city" id="city">
                    </select>
                </div>
                <div class="block" style="margin-left: 400px; top: 60px;">
                    <label id="lb_country">Country</label>
                    <select name="country" id="country">
                    </select>
                </div>
                <div class="block" style="margin-left: 400px; top: 90px;" >
                    <label id="lb_id_number">ID number</label>
                    <input type="text" name="id_number" id="id_number"  value="" style="width:100px;" maxlength="30"  onkeypress='validate(event);'>
                </div>
                <div class="block" style="margin-left: 400px; top: 120px;">
                    <label id="lb_number_of_adult">Number of adult</label>
                    <input type="text" name="number_of_adult" id="number_of_adult"  value="" style="width:50px;" maxlength="2"  onkeypress='validate(event);'>
                </div>
                <div class="block" style="margin-left: 400px; top: 150px;">
                    <label id="lb_number_of_minor">Number of minor</label>
                    <input type="text" name="number_of_minor" id="number_of_minor"  value="" style="width:50px;" maxlength="2"  onkeypress='validate(event);' onblur="LostFocus('LF_number_of_minor();')">
                </div>
            </div>
        </fieldset>
    </div>
    <div id="tabs_2" style="height: 495px;">
        <div class="component1" style="width:100%; height:420px; float:left; padding:0px; overflow: auto; margin-top:0px;">
        <table>
            <thead>
                <tr>
                    <th style="text-align:center; width: 20%;">Room Number</th>
                    <th style="text-align:center; width: 20%;">In Date</th>
                    <th style="text-align:center; width: 20%;">Out Date</th>
                    <th style="text-align:center; width: 20%;">Days</th>
                    <th style="text-align:center; width: 20%;">Amount</th>
                </tr>
            </thead>
            <tbody id="displayHistory">
            </tbody>
        </table>
        </div>
    </div>
</div>
<%@include file="hotel_customer_info_jsfunction.jsp"%>
<%@include file="../footer.jsp"%>