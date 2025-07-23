<%@include file="header.jsp"%>
<%
Connection conn = DBConnection();
if(session.getAttribute("booking").equals("1")){
%>
<div id="tabs" style="position:relative; z-index:0; width: 98%; float: left; margin: 0px 5px 5px 5px;">
     <ul style="padding-left: 2px;">
        <li><a oncontextmenu="return false;" href="#tabs_1" id="tab1" style="padding:8px 20px; font-weight: bold; white-space: normal; vertical-align:middle;" onclick="tab1()">Rooms</a></li>
        <li><a oncontextmenu="return false;" href="#tabs_2" id="tab2" style="padding:8px 20px; font-weight: bold;" onclick=""> Book </a></li>
        <li><a oncontextmenu="return false;" href="#tabs_5" id="tab5" style="padding:8px 20px; font-weight: bold;" onclick="tab5()"> Payment </a></li>
        <li><a oncontextmenu="return false;" href="#tabs_3" id="tab3" style="padding:8px 20px; font-weight: bold;" onclick="tab3()"> Check Out </a></li>
        <li><a oncontextmenu="return false;" href="#tabs_4" id="tab4" style="padding:8px 20px; font-weight: bold;" onclick="tab4()"> Room Details </a></li>
        <li><a oncontextmenu="return false;" href="#tabs_6" id="tab6" style="padding:8px 20px; font-weight: bold;" onclick="tab6()"> Scheduler </a></li>
        <li><a oncontextmenu="return false;" href="#tabs_7" id="tab7" style="padding:8px 20px; font-weight: bold;" onclick=""> Reserved </a></li>
        <li><a oncontextmenu="return false;" href="#tabs_8" id="tab8" style="padding:8px 20px; font-weight: bold;" onclick="tab8()"> Reservation </a></li>
    </ul>
    <div id="tabs_1">
        <div class="component1" style="width:70%; height:420px; float:left; padding:0px; overflow: auto; margin-top:0px;">
        <table>
            <thead>
                <tr>
                    <th style="text-align:center; padding:5px;">Floor</th>
                    <th style="text-align:center;">Room Number</th>
                    <th style="text-align:center;">Room Type</th>
                    <th style="text-align:center;">Price</th>
                    <th style="text-align:center;">Room Status</th>
                    <th style="text-align:center; width: 30%;">Action</th>
                </tr>
            </thead>
            <tbody id="displayRooms">
            </tbody>
        </table>
        </div>
        <div style="width: 29%; float:right; margin-left: 5px; border: solid #ddd 1px;">
            <div style=" padding:5px; text-align: center; background-color: #3399cc; color: #FFF;">
                <span style="font-size: 14px; font-weight: bold;">Details</span>
            </div>
            <div style="padding:5px;">
                <label style="font-weight: bold;">Date: <span id="tab1_date"></span> </label>
                <div style="margin-top:5px; padding:5px; background-color: #0FAB50; color: #FFF;">
                    <h3 style="font-weight: bold; background-color: #04853A; padding: 5px; margin-top: -1px;">Booked:</h3>
                    <table style="background-color: transparent; margin-top: -5px; " id="tab1_booked">
                    </table>
                </div>
                <br>
                <div style="margin-top:5px; padding:5px; background-color: #EAF605; color: #000;">
                    <h3 style="font-weight: bold; background-color: #BBC505; padding: 5px; margin-top: -1px;">Reserved:</h3>
                    <table style="background-color: transparent; margin-top: -5px;" id="tab1_reserved">
                    </table>
                </div>
                <br>
                <div style="margin-top:5px; padding:5px; background-color: #F5B23F; color: #000;">
                    <h3 style="font-weight: bold; background-color: #FAA108; padding: 5px; margin-top: -1px;">Check-Out</h3>
                    <table style="background-color: transparent; margin-top: -5px;" id="tab1_checkout">
                    </table>
                </div>
            </div>
        </div>
    </div>
    <div id="tabs_2" style="height: 560px;">
        <div style="position: relative">
            <div class="block" style="margin-left: 180px; top: 10px;">
                <label id="lb_tab2_room_id">Room Number</label>
                <input type="text" tabindex="-1" name="tab2_room_id" id="tab2_room_id" style="width:50px;">
            </div>
            <div class="block" style="margin-left: 380px; top: 10px;">
                <label id="lb_tab2_price">Price</label>
                <input type="text"  tabindex="-1" name="tab2_price" id="tab2_price" style="width:50px;">
            </div>
            <div class="block" style="margin-left: 180px; top: 40px;">
                <label id="lb_tab2_in_date">Check-in Date</label>
                <input type="text" tabindex="1" name="tab2_in_date" id="tab2_in_date" style="width:80px;" >
            </div>
            <div class="block" style="margin-left: 380px; top: 40px;">
                <label id="lb_tab2_out_date">Check-out Date</label>
                <input type="text" tabindex="2" name="tab2_out_date" id="tab2_out_date" style="width:80px;">
            </div>
            <div class="block" style="margin-left: 580px; top: 40px;">
                <label id="lb_tab2_days">Days</label>
                <input type="text" tabindex="-1" name="tab2_days" id="tab2_days" style="width:40px;">
            </div>
            <div class="block" style="margin-left: 780px; top: 40px;">
                <label id="lb_tab2_amount">Amount</label>
                <input type="text" tabindex="3" name="tab2_amount" id="tab2_amount" style="width:80px;">
            </div>
        </div>
        <fieldset style="width:850px; height:330px; margin-left:200px; margin-top: 80px; border: 1px solid #ddd; background-color: #f6f6f6; padding:5px; position: absolute;">
            <legend style="font-size: 12px; font-weight: bold; padding:0 10px">Customer Information</legend>
            <div style="position: relative">
                <!--<div class="block" style="margin-left: 50px; top: 0px;">
                    <label id="lb_tab2_customer_id">Customer ID</label>
                    <input type="text" name="tab2_customer_id" id="tab2_customer_id" style="width:100px;">
                </div> -->
                <div class="block" style="margin-left: 50px; top: 0px;">
                    <label id="lb_tab2_first_name">First name</label>
                    <input type="text" tabindex="4" name="tab2_first_name" id="tab2_first_name" style="width:150px;" maxlength="30" onblur="LF_tab2_first_name()">
                </div>
                <div class="block" style="margin-left: 50px; top: 30px;">
                    <label id="lb_tab2_last_name">Last name</label>
                    <input type="text" tabindex="5" name="tab2_last_name" id="tab2_last_name" style="width:150px;" maxlength="30">
                </div>
                <div class="block" style="margin-left: 50px; top: 60px;" >
                    <label id="lb_tab2_gender">Gender</label>
                    <select tabindex="6" name="tab2_gender" id="tab2_gender" style="width: 100px;">
                    </select>
                </div>
                <div class="block" style="margin-left: 50px; top: 90px;">
                    <label id="lb_tab2_contact_number">Contact number</label>
                    <input type="text" tabindex="7" name="tab2_contact_number" id="tab2_contact_number" style="width:100px;" maxlength="15"  onkeypress='validate(event);'>
                </div>
                <div class="block" style="margin-left: 50px; top: 120px;">
                    <label id="lb_tab2_email">Email</label>
                    <input type="text" tabindex="8" name="tab2_email" id="tab2_email" style="width:150px;" maxlength="30">
                </div>
                <div class="block" style="margin-left: 50px; top: 150px;">
                    <label id="lb_tab2_id_type">ID type</label>
                    <select tabindex="9" name="tab2_id_type" id="tab2_id_type" style="width: 100px;">
                    </select>
                </div>
                <div class="block" style="margin-left: 50px; top: 180px;">
                    <label id="lb_tab2_id_number">ID number</label>
                    <input type="text" tabindex="10" name="tab2_id_number" id="tab2_id_number" style="width:150px;" maxlength="15">
                </div>
                
                <div class="block" style="margin-left: 400px; top: 0px;" >
                    <label id="lb_tab2_tariff">Tariff</label>
                    <select tabindex="11" name="tab2_tariff" id="tab2_tariff">
                    </select>
                </div>
                <div class="block" style="margin-left: 400px; top: 30px;">
                    <label id="lb_tab2_customer_type">Customer Type</label>
                    <select tabindex="12" name="tab2_customer_type" id="tab2_customer_type">
                    </select>
                </div>
                <div class="block" style="margin-left: 400px; top: 60px;">
                    <label id="lb_tab2_address">Address</label>
                    <input type="text" tabindex="13" name="tab2_address" id="tab2_address" style="width:100px;">
                </div>
                <div class="block" style="margin-left: 400px; top: 90px;">
                    <label id="lb_tab2_city">City</label>
                    <select tabindex="14" name="tab2_city" id="tab2_city">
                    </select>
                </div>
                <div class="block" style="margin-left: 400px; top: 120px;">
                    <label id="lb_tab2_country">Country</label>
                    <select tabindex="15" name="tab2_country" id="tab2_country">
                    </select>
                </div>
                <div class="block" style="margin-left: 400px; top: 150px;">
                    <label id="lb_tab2_number_of_adult">Number of adult</label>
                    <input type="text" tabindex="16" name="tab2_number_of_adult" id="tab2_number_of_adult" style="width:50px;" maxlength="2"  onkeypress='validate(event);'>
                </div>
                <div class="block" style="margin-left: 400px; top: 180px;">
                    <label id="lb_tab2_number_of_minor">Number of minor</label>
                    <input type="text" tabindex="17" name="tab2_number_of_minor" id="tab2_number_of_minor" style="width:50px;" maxlength="2"  onkeypress='validate(event);' onblur="LF_tab2_number_of_minor();">
                </div>
                <div class="block" style="margin-left: 150px; top: 220px;">
                    <label id="lb_tab2_deposit_mode">Deposit Mode</label>
                    <select tabindex="18" name="tab2_deposit_mode" id="tab2_deposit_mode" style="width: 100px;">
                    </select>
                </div>
                <div class="block" style="margin-left: 370px; top: 220px;">
                    <label id="lb_tab2_deposit_amount">Deposit Amount</label>
                    <input type="text" tabindex="19" name="tab2_deposit_amount" id="tab2_deposit_amount"  style="width:80px;" maxlength="10"  onkeypress='validate(event);' onblur="LF_tab2_deposit_amount()">
                </div>
            </div>
            <input type="hidden" name="tab2_customer_id" id="tab2_customer_id" style="width:100px;">
        </fieldset>
        <div style="position: relative">
            <div class="block" style="margin-left: 500px; top: 370px;">
                <input type="button" tabindex="20" name="tab2_Book" id="tab2_Book" value="Book" style="width:100px;" onclick="Tab2Book()">
                <input type="button" tabindex="21" name="tab2_Reset" id="tab2_Reset" value="Reset" style="width:100px;" onclick="Tab2Reset();">
            </div>
        </div>
    </div>
    <div id="tabs_3" style="height: 560px;">
        <div style="position: relative">
            <div class="block" style="margin-left: 180px; top: 10px;">
                <label id="lb_tab3_room_id" style="width: 150px;">Select Room Number</label>
                <select tabindex="1" name="tab3_room_id" id="tab3_room_id" style="width:80px;" onblur="LF_tab3_room_id()">
                </select>
            </div>
        </div>
        <fieldset style="width:850px; height:220px; margin-left:200px; margin-top: 60px; border: 1px solid #ddd; background-color: #f6f6f6; padding:5px; position: absolute;">
            <legend style="font-size: 12px; font-weight: bold; padding:0 10px">Customer Details</legend>
            <div style="position: relative">
                <div class="block" style="margin-left: 50px; top: 10px;">
                    <label>Customer ID</label>
                    <input type="text" id="tab3_customer_id" style="width:100px;">
                </div>
                <div class="block" style="margin-left: 280px; top: 10px;">
                    <input type="text" name="tab3_customer_name" id="tab3_customer_name">
                </div>
                <div class="block" style="margin-left: 500px; top: 10px;">
                    <label >Payment Status</label>
                    <select tabindex="1" id="tab3_payment_status" style="width:100px;">
                    </select>
                </div>
                <div class="block" style="margin-left: 50px; top: 40px;">
                    <label >Check-in Date</label>
                    <input type="text" id="tab3_in_date" style="width:80px;">
                </div>
                <div class="block" style="margin-left: 50px; top: 70px;">
                    <label id="lb_tab3_out_date">Check-out Date</label>
                    <input type="text" name="tab3_out_date" id="tab3_out_date" style="width:80px;">
                </div>
                <div class="block" style="margin-left: 50px; top: 100px;">
                    <label>Number of adult</label>
                    <input type="text" id="tab3_number_of_adult" style="width:50px;">
                </div>
                <div class="block" style="margin-left: 50px; top: 130px;">
                    <label>Number of minor</label>
                    <input type="text" id="tab3_number_of_minor" style="width:50px;">
                </div>
            </div>
            <div class="block" style="margin-left: 500px; top: 60px;">
                <label> </label>
                <input type="button" id="tab3_btnCheckOut" value="Check Out" style="width:100px; padding: 10px;" onclick="tab3Checkout()">
            </div>
            <input type="hidden" id="tab3_transaction_id">
            <input type="hidden" id="tab3_transaction_date">
            <input type="hidden" id="tab3_transaction_time">
            <input type="hidden" id="tab3_transaction_amount">
            <input type="hidden" id="tab3_days">
            <input type="hidden" id="tab3_deposit_mode">
            <input type="hidden" id="tab3_deposit_amount">
        </fieldset>
    </div>
    <div id="tabs_4">
        <div class="component1" style="width:100%; height:420px; float:left; padding:0px; overflow: auto; margin-top:0px;">
        <table>
            <thead>
                <tr>
                    <th style="text-align:center; width: 10%;">Transaction Date</th>
                    <th style="text-align:center; width: 10%;">Transaction Time</th>
                    <th style="text-align:center; width: 10%;">Customer ID</th>
                    <th style="text-align:center; ">Customer Name</th>
                    <th style="text-align:center; width: 10%;">In Date</th>
                    <th style="text-align:center; width: 10%;">Out Date</th>
                    <th style="text-align:center; width: 10%;">Book Status</th>
                    <th style="text-align:center; width: 10%;">Username</th>
                </tr>
            </thead>
            <tbody id="displayBookTrans">
            </tbody>
        </table>
        </div>
    </div>
    <div id="tabs_5" style="height: 560px;">
        <div style="position: relative">
            <div class="block" style="margin-left: 180px; top: 0px;">
                <label id="lb_tab5_room_id" style="width: 150px;">Select Room Number</label>
                <select tabindex="1" name="tab5_room_id" id="tab5_room_id" style="width:80px;" onblur="LF_tab5_room_id()">
                </select>
            </div>
        </div>
        <fieldset style="width:850px; height:500px; margin-left:200px; margin-top: 40px; border: 1px solid #ddd; background-color: #f6f6f6; padding:5px; position: absolute;">
            <legend style="font-size: 12px; font-weight: bold; padding:0 10px">Payment Info</legend>
            <div style="position: relative">
                <div class="block" style="margin-left: 50px; top: 10px;">
                    <label>Customer Name</label>
                    <input type="text" id="tab5_customer_name">
                </div>
                <div class="block" style="margin-left: 50px; top: 40px;">
                    <label>Check-in Date</label>
                    <input type="text" id="tab5_in_date" style="width:80px;">
                </div>
                <div class="block" style="margin-left: 50px; top: 70px;">
                    <label>Check-out Date</label>
                    <input type="text" id="tab5_out_date" style="width:80px;">
                </div>
                <div class="block" style="margin-left: 500px; top: 10px;">
                    <label>Deposit Amount</label>
                    <input type="text" id="tab5_deposit_amount" style="width:80px;">
                </div>
                <div class="block" style="margin-left: 500px; top: 40px;">
                    <label>Deposit Mode</label>
                    <select id="tab5_deposit_mode" style="width: 100px;">
                    </select>
                </div>
            </div>
            
            <div class="component1" style="width:100%; height:300px; float:left; padding:0px; overflow: auto; top:120px; position: relative;">
            <table>
                <thead>
                    <tr>
                        <th style="text-align:center; width: 15%;">Transaction Reference</th>
                        <th style="text-align:center; width: 15%;">Transaction Date</th>
                        <th style="text-align:center; ">Description</th>
                        <th style="text-align:center; width: 15%;">Amount</th>
                        <th style="text-align:center; width: 15%;">Status</th>
                    </tr>
                </thead>
                <tbody id="displayHotelTrans">
                </tbody>
            </table>
            </div>
            <div class="block" style="margin-left: 0px; top: 440px;">
                <label >Payment Mode</label>
                <select tabindex="2"id="tab5_payment_mode" style="width: 100px;" onblur="LF_tab5_payment_mode();">
                </select>
            </div>
            <div class="block" style="margin-left: 240px; top: 440px;">
                <label style="width: 120px;">Use Deposit Amount</label>
                <input type="checkbox" id="tab5_deposit_chk" style="margin-top: 5px;">
            </div>
            <div class="block" style="margin-left: 380px; top: 440px;">
                <label>Amount</label>
                <input type="text" tabindex="3" id="tab5_transaction_amount"  style="width:80px;" maxlength="10"  onkeypress='validate(event);' onblur="LF_tab5_transaction_amount();">
            </div>
            <div class="block" style="margin-left: 550px; top: 430px;">
                <label> </label>
                <input type="button" tabindex="4" id="tab5_btnPaid" value="Paid" style="width:100px; padding: 10px;" onclick="tab5Paid()">
            </div>
            <input type="hidden" id="tab5_customer_id">
            <input type="hidden" id="tab5_items">
            <input type="hidden" id="tab5_amount_paid">
            <input type="hidden" id="tab5_transaction_id">
        </fieldset>
    </div>
    <div id="tabs_6" >
        <div id="BScheduler" style="margin: auto; width:1000px; top:10px; position:relative; margin-left: 0px;"></div>
  
            <div class="block" style="margin-left: 1120px; top: 60px;">
                <input type="button" tabindex="20"id="tab6_Reserved" value="Reserved" style="width:100px;" onclick="tab6_Reserved()"><br>
                <input type="button" tabindex="20"id="tab6_Clear" value="Clear" style="width:100px;" onclick="tab6_Clear()">
            </div>
       
        <input type="hidden" id="tab6_highlighted">
        <input type="hidden" id="tab6_room_id">
    </div>
    <div id="tabs_7" style="height: 560px;">
        <div style="position: relative">
            <div class="block" style="margin-left: 180px; top: 10px;">
                <label id="lb_tab7_room_id">Room Number</label>
                <input type="text" tabindex="-1" name="tab7_room_id" id="tab7_room_id" style="width:50px;">
            </div>
            <div class="block" style="margin-left: 380px; top: 10px;">
                <label id="lb_tab7_price">Price</label>
                <input type="text"  tabindex="-1" name="tab7_price" id="tab7_price" style="width:50px;">
            </div>
            <div class="block" style="margin-left: 180px; top: 40px;">
                <label id="lb_tab7_in_date">Check-in Date</label>
                <input type="text" tabindex="1" name="tab7_in_date" id="tab7_in_date" style="width:80px;" >
            </div>
            <div class="block" style="margin-left: 380px; top: 40px;">
                <label id="lb_tab7_out_date">Check-out Date</label>
                <input type="text" tabindex="2" name="tab7_out_date" id="tab7_out_date" style="width:80px;">
            </div>
            <div class="block" style="margin-left: 580px; top: 40px;">
                <label id="lb_tab7_days">Days</label>
                <input type="text" tabindex="-1" name="tab7_days" id="tab7_days" style="width:40px;">
            </div>
            <div class="block" style="margin-left: 780px; top: 40px;">
                <label id="lb_tab7_amount">Amount</label>
                <input type="text" tabindex="3" name="tab7_amount" id="tab7_amount" style="width:80px;">
            </div>
        </div>
        <fieldset style="width:850px; height:330px; margin-left:200px; margin-top: 80px; border: 1px solid #ddd; background-color: #f6f6f6; padding:5px; position: absolute;">
            <legend style="font-size: 12px; font-weight: bold; padding:0 10px">Customer Information</legend>
            <div style="position: relative">
                <!--<div class="block" style="margin-left: 50px; top: 0px;">
                    <label id="lb_tab7_customer_id">Customer ID</label>
                    <input type="text" name="tab7_customer_id" id="tab7_customer_id" style="width:100px;">
                </div> -->
                <div class="block" style="margin-left: 50px; top: 0px;">
                    <label id="lb_tab7_first_name">First name</label>
                    <input type="text" tabindex="4" name="tab7_first_name" id="tab7_first_name" style="width:150px;" maxlength="30" onblur="LF_tab7_first_name()">
                </div>
                <div class="block" style="margin-left: 50px; top: 30px;">
                    <label id="lb_tab7_last_name">Last name</label>
                    <input type="text" tabindex="5" name="tab7_last_name" id="tab7_last_name" style="width:150px;" maxlength="30">
                </div>
                <div class="block" style="margin-left: 50px; top: 60px;" >
                    <label id="lb_tab7_gender">Gender</label>
                    <select tabindex="6" name="tab7_gender" id="tab7_gender" style="width: 100px;">
                    </select>
                </div>
                <div class="block" style="margin-left: 50px; top: 90px;">
                    <label id="lb_tab7_contact_number">Contact number</label>
                    <input type="text" tabindex="7" name="tab7_contact_number" id="tab7_contact_number" style="width:100px;" maxlength="15"  onkeypress='validate(event);'>
                </div>
                <div class="block" style="margin-left: 50px; top: 120px;">
                    <label id="lb_tab7_email">Email</label>
                    <input type="text" tabindex="8" name="tab7_email" id="tab7_email" style="width:150px;" maxlength="30">
                </div>
                <div class="block" style="margin-left: 50px; top: 150px;">
                    <label id="lb_tab7_id_type">ID type</label>
                    <select tabindex="9" name="tab7_id_type" id="tab7_id_type" style="width: 100px;">
                    </select>
                </div>
                <div class="block" style="margin-left: 50px; top: 180px;">
                    <label id="lb_tab7_id_number">ID number</label>
                    <input type="text" tabindex="10" name="tab7_id_number" id="tab7_id_number" style="width:150px;" maxlength="15">
                </div>
                
                <div class="block" style="margin-left: 400px; top: 0px;" >
                    <label id="lb_tab7_tariff">Tariff</label>
                    <select tabindex="11" name="tab7_tariff" id="tab7_tariff">
                    </select>
                </div>
                <div class="block" style="margin-left: 400px; top: 30px;">
                    <label id="lb_tab7_customer_type">Customer Type</label>
                    <select tabindex="12" name="tab7_customer_type" id="tab7_customer_type">
                    </select>
                </div>
                <div class="block" style="margin-left: 400px; top: 60px;">
                    <label id="lb_tab7_address">Address</label>
                    <input type="text" tabindex="13" name="tab7_address" id="tab7_address" style="width:100px;">
                </div>
                <div class="block" style="margin-left: 400px; top: 90px;">
                    <label id="lb_tab7_city">City</label>
                    <select tabindex="14" name="tab7_city" id="tab7_city">
                    </select>
                </div>
                <div class="block" style="margin-left: 400px; top: 120px;">
                    <label id="lb_tab7_country">Country</label>
                    <select tabindex="15" name="tab7_country" id="tab7_country">
                    </select>
                </div>
                <div class="block" style="margin-left: 400px; top: 150px;">
                    <label id="lb_tab7_number_of_adult">Number of adult</label>
                    <input type="text" tabindex="16" name="tab7_number_of_adult" id="tab7_number_of_adult" style="width:50px;" maxlength="2"  onkeypress='validate(event);'>
                </div>
                <div class="block" style="margin-left: 400px; top: 180px;">
                    <label id="lb_tab7_number_of_minor">Number of minor</label>
                    <input type="text" tabindex="17" name="tab7_number_of_minor" id="tab7_number_of_minor" style="width:50px;" maxlength="2"  onkeypress='validate(event);' onblur="LF_tab7_number_of_minor();">
                </div>
                <div class="block" style="margin-left: 150px; top: 220px;">
                    <label id="lb_tab7_deposit_mode">Deposit Mode</label>
                    <select tabindex="18" name="tab7_deposit_mode" id="tab7_deposit_mode" style="width: 100px;">
                    </select>
                </div>
                <div class="block" style="margin-left: 370px; top: 220px;">
                    <label id="lb_tab7_deposit_amount">Deposit Amount</label>
                    <input type="text" tabindex="19" name="tab7_deposit_amount" id="tab7_deposit_amount"  style="width:80px;" maxlength="10"  onkeypress='validate(event);' onblur="LF_tab7_deposit_amount()">
                </div>
            </div>
            <input type="hidden" id="tab7_customer_id" style="width:100px;">
        </fieldset>
        <div style="position: relative">
            <div class="block" style="margin-left: 500px; top: 370px;">
                <input type="button" tabindex="20" name="tab7_Reserved" id="tab7_Reserved" value="Reserved" style="width:100px;" onclick="tab7Reserved()">
                <input type="button" tabindex="21" name="tab7_Reset" id="tab7_Reset" value="Reset" style="width:100px;" onclick="tab7Reset();">
            </div>
        </div>
    </div>
    <div id="tabs_8" style="height: 560px;">
        <div style="position: relative">
            <div class="block" style="margin-left: 180px; top: 10px;">
                <label id="lb_tab8_room_id">Room Number</label>
                <input type="text" tabindex="-1" name="tab8_room_id" id="tab8_room_id" style="width:50px;">
            </div>
            <div class="block" style="margin-left: 380px; top: 10px;">
                <label id="lb_tab8_price">Price</label>
                <input type="text"  tabindex="-1" name="tab8_price" id="tab8_price" style="width:50px;">
            </div>
            <div class="block" style="margin-left: 180px; top: 40px;">
                <label id="lb_tab8_in_date">Check-in Date</label>
                <input type="text" tabindex="1" name="tab8_in_date" id="tab8_in_date" style="width:80px;" >
            </div>
            <div class="block" style="margin-left: 380px; top: 40px;">
                <label id="lb_tab8_out_date">Check-out Date</label>
                <input type="text" tabindex="2" name="tab8_out_date" id="tab8_out_date" style="width:80px;">
            </div>
            <div class="block" style="margin-left: 580px; top: 40px;">
                <label id="lb_tab8_days">Days</label>
                <input type="text" tabindex="-1" name="tab8_days" id="tab8_days" style="width:40px;">
            </div>
            <div class="block" style="margin-left: 780px; top: 40px;">
                <label id="lb_tab8_amount">Amount</label>
                <input type="text" tabindex="3" name="tab8_amount" id="tab8_amount" style="width:80px;">
            </div>
        </div>
        <fieldset style="width:850px; height:330px; margin-left:200px; margin-top: 80px; border: 1px solid #ddd; background-color: #f6f6f6; padding:5px; position: absolute;">
            <legend style="font-size: 12px; font-weight: bold; padding:0 10px">Customer Information</legend>
            <div style="position: relative">
                <!--<div class="block" style="margin-left: 50px; top: 0px;">
                    <label id="lb_tab8_customer_id">Customer ID</label>
                    <input type="text" name="tab8_customer_id" id="tab8_customer_id" style="width:100px;">
                </div> -->
                <div class="block" style="margin-left: 50px; top: 0px;">
                    <label id="lb_tab8_first_name">First name</label>
                    <input type="text" tabindex="4" name="tab8_first_name" id="tab8_first_name" style="width:150px;" maxlength="30" onblur="LF_tab8_first_name()">
                </div>
                <div class="block" style="margin-left: 50px; top: 30px;">
                    <label id="lb_tab8_last_name">Last name</label>
                    <input type="text" tabindex="5" name="tab8_last_name" id="tab8_last_name" style="width:150px;" maxlength="30">
                </div>
                <div class="block" style="margin-left: 50px; top: 60px;" >
                    <label id="lb_tab8_gender">Gender</label>
                    <select tabindex="6" name="tab8_gender" id="tab8_gender" style="width: 100px;">
                    </select>
                </div>
                <div class="block" style="margin-left: 50px; top: 90px;">
                    <label id="lb_tab8_contact_number">Contact number</label>
                    <input type="text" tabindex="7" name="tab8_contact_number" id="tab8_contact_number" style="width:100px;" maxlength="15"  onkeypress='validate(event);'>
                </div>
                <div class="block" style="margin-left: 50px; top: 120px;">
                    <label id="lb_tab8_email">Email</label>
                    <input type="text" tabindex="8" name="tab8_email" id="tab8_email" style="width:150px;" maxlength="30">
                </div>
                <div class="block" style="margin-left: 50px; top: 150px;">
                    <label id="lb_tab8_id_type">ID type</label>
                    <select tabindex="9" name="tab8_id_type" id="tab8_id_type" style="width: 100px;">
                    </select>
                </div>
                <div class="block" style="margin-left: 50px; top: 180px;">
                    <label id="lb_tab8_id_number">ID number</label>
                    <input type="text" tabindex="10" name="tab8_id_number" id="tab8_id_number" style="width:150px;" maxlength="15">
                </div>
                
                <div class="block" style="margin-left: 400px; top: 0px;" >
                    <label id="lb_tab8_tariff">Tariff</label>
                    <select tabindex="11" name="tab8_tariff" id="tab8_tariff">
                    </select>
                </div>
                <div class="block" style="margin-left: 400px; top: 30px;">
                    <label id="lb_tab8_customer_type">Customer Type</label>
                    <select tabindex="12" name="tab8_customer_type" id="tab8_customer_type">
                    </select>
                </div>
                <div class="block" style="margin-left: 400px; top: 60px;">
                    <label id="lb_tab8_address">Address</label>
                    <input type="text" tabindex="13" name="tab8_address" id="tab8_address" style="width:100px;">
                </div>
                <div class="block" style="margin-left: 400px; top: 90px;">
                    <label id="lb_tab8_city">City</label>
                    <select tabindex="14" name="tab8_city" id="tab8_city">
                    </select>
                </div>
                <div class="block" style="margin-left: 400px; top: 120px;">
                    <label id="lb_tab8_country">Country</label>
                    <select tabindex="15" name="tab8_country" id="tab8_country">
                    </select>
                </div>
                <div class="block" style="margin-left: 400px; top: 150px;">
                    <label id="lb_tab8_number_of_adult">Number of adult</label>
                    <input type="text" tabindex="16" name="tab8_number_of_adult" id="tab8_number_of_adult" style="width:50px;" maxlength="2"  onkeypress='validate(event);'>
                </div>
                <div class="block" style="margin-left: 400px; top: 180px;">
                    <label id="lb_tab8_number_of_minor">Number of minor</label>
                    <input type="text" tabindex="17" name="tab8_number_of_minor" id="tab8_number_of_minor" style="width:50px;" maxlength="2"  onkeypress='validate(event);' onblur="LF_tab8_number_of_minor();">
                </div>
                <div class="block" style="margin-left: 150px; top: 220px;">
                    <label id="lb_tab8_deposit_mode">Deposit Mode</label>
                    <select tabindex="18" name="tab8_deposit_mode" id="tab8_deposit_mode" style="width: 100px;">
                    </select>
                </div>
                <div class="block" style="margin-left: 370px; top: 220px;">
                    <label id="lb_tab8_deposit_amount">Deposit Amount</label>
                    <input type="text" tabindex="19" name="tab8_deposit_amount" id="tab8_deposit_amount"  style="width:80px;" maxlength="10"  onkeypress='validate(event);' onblur="LF_tab8_deposit_amount()">
                </div>
            </div>
            <input type="hidden" id="tab8_customer_id" style="width:100px;">
            <input type="hidden" id="tab8_transaction_id">
        </fieldset>
        <div style="position: relative">
            <div class="block" style="margin-left: 500px; top: 370px;">
                <input type="button" tabindex="20" name="tab8_Book" id="tab8_Book" value="Book" style="width:100px;" onclick="tab8Book()">
                <input type="button" tabindex="21" name="tab8_Reset" id="tab8_Reset" value="Reset" style="width:100px;" onclick="tab8Reset();">
            </div>
        </div>
    </div>
</div>

<!-- Popup -->
<div id="dialog" title="Room Type Discription" style="display: none; width: 400px;">
    
</div>
<%}%>
<%@include file="footer.jsp"%>