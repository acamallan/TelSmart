<%@include file="../header.jsp"%>
<%@include file="../functions/record_function.jsp"%>

<%
/* No need to put String as variables already initialize */
table = "was_customer_info";
fields = "customer_id as rowid,customer_id,first_name,last_name,gender,contact_number,email,address,city,country,tariff,customer_type,id_type,id_number";
where = "customer_id";
mainWhere = "has_multiple_address= '0'";
/*used in Add New*/
enableFields = "customer_id,first_name,last_name,gender,contact_number,email,address,city,country,tariff,customer_type,id_type,id_number";
/*used in Amend*/
amendableFields = "first_name,last_name,gender,contact_number,email,address,city,country,tariff,customer_type,id_type,id_number";
requiredFields = "first_name,last_name,gender,contact_number,email,address,city,country,tariff,customer_type,id_type,id_number";

pageMode = "E,D";
/*End here*/
%>
<%@include file="../common/sidefind.jsp"%>
<div id="tabs" style="position:relative; z-index:0; width: 950px; float: left; margin: 0px 5px 5px 5px;">
     <ul style="padding-left: 2px;">
        <li><a oncontextmenu="return false;" href="#tabs_1" id="tab1" style="padding:8px 20px; font-weight: bold; white-space: normal; vertical-align:middle;" onclick="tab1()">Details</a></li>
        <li><a oncontextmenu="return false;" href="#tabs_2" id="tab2" style="padding:8px 20px; font-weight: bold;" onclick="tab2()"> Contact </a></li>
    </ul>
    <div id="tabs_1" style="height: 495px;">
        <input type="hidden" name="record_date" id="record_date" style="width:80px;">
        <fieldset style="width:850px; height:270px; margin-left:30px; margin-top: 20px; border: 1px solid #ddd; background-color: #f6f6f6; padding:5px;">
            <legend style="font-size: 12px; font-weight: bold; padding:0 10px">Customer Information</legend>
            <div style="position: relative">
                <div class="block" style="margin-left: 50px; top: 0px;">
                    <label id="lb_customer_id">Customer ID</label>
                    <input type="text" name="customer_id" id="customer_id" style="width:100px;">
                </div>
                <div class="block" style="margin-left: 50px; top: 30px;">
                    <label id="lb_first_name">First name</label>
                    <input type="text" name="first_name" id="first_name" style="width:150px;" maxlength="30">
                </div>
                <div class="block" style="margin-left: 50px; top: 60px;">
                    <label id="lb_last_name">Last name</label>
                    <input type="text" name="last_name" id="last_name" style="width:150px;" maxlength="30">
                </div>
                <div class="block" style="margin-left: 50px; top: 90px;" >
                    <label id="lb_gender">Gender</label>
                    <select name="gender" id="gender" style="width: 100px;">
                    </select>
                </div>
                <div class="block" style="margin-left: 50px; top: 120px;">
                    <label id="lb_contact_number">Contact number</label>
                    <input type="text" name="contact_number" id="contact_number" style="width:100px;" maxlength="15"  onkeypress='validate(event);'>
                </div>
                <div class="block" style="margin-left: 50px; top: 150px;">
                    <label id="lb_email">Email</label>
                    <input type="text" name="email" id="email" style="width:150px;" maxlength="30">
                </div>
                <div class="block" style="margin-left: 50px; top: 180px;">
                    <label id="lb_id_type">ID type</label>
                    <select name="id_type" id="id_type" style="width: 100px;">
                    </select>
                </div>
                <div class="block" style="margin-left: 50px; top: 210px;">
                    <label id="lb_id_number">ID number</label>
                    <input type="text" name="id_number" id="id_number" style="width:150px;" maxlength="15">
                </div>
                
                <div class="block" style="margin-left: 400px; top: 0px;" >
                    <label id="lb_tariff">Tariff</label>
                    <select name="tariff" id="tariff">
                    </select>
                </div>
                <div class="block" style="margin-left: 400px; top: 30px;">
                    <label id="lb_customer_type">Customer Type</label>
                    <select name="customer_type" id="customer_type">
                    </select>
                </div>
                <div class="block" style="margin-left: 400px; top: 60px;">
                    <label id="lb_address">Address</label>
                    <input type="text" name="address" id="address" style="width:100px;">
                </div>
                <div class="block" style="margin-left: 400px; top: 90px;">
                    <label id="lb_city">City</label>
                    <select name="city" id="city">
                    </select>
                </div>
                <div class="block" style="margin-left: 400px; top: 120px;">
                    <label id="lb_country">Country</label>
                    <select name="country" id="country">
                    </select>
                </div>
            </div>
        </fieldset>
    </div>
    <div id="tabs_2" style="height: 495px;">
        
    </div>
    
</div>
<%@include file="hotel_customer_info_jsfunction.jsp"%>
<%@include file="../footer.jsp"%>