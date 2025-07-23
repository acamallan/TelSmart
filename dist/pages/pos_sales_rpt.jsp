<%@include file="../header.jsp"%>

 <div id="tabs" style="position:relative; z-index:0; width: 450px; float: left;">
     <ul style="padding-left: 2px;">
        <li><a oncontextmenu="return false;" href="#tabs_1" style="padding:8px 20px; font-weight: bold;" onclick="tab1()"> Sales </a></li>
        <li><a oncontextmenu="return false;" href="#tabs_2" style="padding:8px 20px; font-weight: bold;" onclick="tab2();"> Tables </a></li>
    </ul>
    <div id="tabs_1" style="padding: 2px; padding-top:5px; position:relative;">
        <div class="block" style="margin-left: 0px; top: 10px;">
            <label>Available Table</label>
            <select tabindex="1" id="table_id" style="width:80px;">
            </select>
        </div>
        <div class="block" style="margin-left: 230px; top: 10px;">
            <label>Hold Table</label>
            <select tabindex="-1" id="table_id_hold" style="width:80px;" onblur="LF_table_id_hold();">
            </select>
        </div>
        <div class="block" style="margin-left: 0px; top: 50px;">
            <label>Invoice number:</label>
            <span id="invoice_number"></span>
        </div>
        
        <!--<div class="block" style="margin-left: 0px; top: 10px;">
            <label>Table number</label>
            <select tabindex="1" id="room_id" style="width:80px;" onblur="LF_room_id()">
            </select>
        </div>
        <div class="block" style="margin-left: 0px; top: 40px;">
            <label>Customer name</label>
            <input type="text" id="customer_name" style="width:150px;">
        </div>-->
        <!--<table>
            <tr>
                <td width="25%">OS Number</td>
                <td><div id="sales_id"></div></td>
            </tr>
            <tr>
                <td>Table Number</td>
                <td></td>
            </tr>
            <tr>
                <td>Customer Name</td>
                <td>
                    <input type="hidden" id="record_date">
                    <input type="hidden" id="customer_id">
                    <input type="hidden" id="card_number">
                    <input type="hidden" id="hd_card_amount">
                    <input type="hidden" id="hd_account_number">
                    <div id="customer_name"></div>
                </td>
            </tr>
        </table> -->
        <input type="hidden" id="customer_id">
        <div style="border: 1px solid #F2F2F2; width: 100%; overflow: auto;  margin-top: 70px; position:relative;" class="component1">
            <hr>
            <table style="padding:0px;  width: 100%;">
                <thead>
                    <tr>
                        <th width="42%" style="text-align:center; padding-left: 0px; padding-right: 0px;" >Product Name</th>
                        <th style="text-align:center; width: 15%; padding-left: 0px; padding-right: 0px;" >Price</th>
                        <th width="23%" style="text-align:center; padding-left: 0px; padding-right: 0px;">Quantity</th>
                        <th style="text-align:center; width: 15%; padding-left: 0px; padding-right: 0px;">Subtotal</th>
                        <th style="text-align:center; width: 5%; padding: 5px;">&nbsp;&nbsp;&nbsp;&nbsp;</th>
                    </tr>
                </thead>
            </table>
            <input type="hidden" name="strCounter" id="strCounter" value="0">
        </div>
        <div style="height: 300px; border: 1px solid #F2F2F2; width: 100%; overflow: auto;  margin-top: 0px;" class="component1">
            <table style="padding:0px; width: 100%;">
                <tbody id="displaySaleItems">
                </tbody>
            </table>
            <input type="hidden" name="strCounter" id="strCounter" value="0">
        </div>
        <hr>
        <table border="0">
            <tr>
                <td style="width: 70%; text-align: left; font-size: 16px; font-weight: bold;">
                    
                    <input type="button" value="Hold" onclick="HoldPayment()" style="height: 50px; font-size: 16px; font-weight: bold; margin: 0px; width: 109px; background-color: #008080;">
                    <input type="button" value="Pay" onclick="Pay()" style="height: 50px; font-size: 16px; font-weight: bold; margin: 0px; width: 109px;">
                    Grand Total:
                </td>
                <td id="totalSales" style="width: 25%; text-align: right; font-size: 25px; font-weight: bold; color: #006621; padding-right: 0px; vertical-align:middle;">0.00</td>
            </tr>
        </table>
        <div style="float: left; width: 225px; margin-left: 1px;">
            <input type="button" value="Cancel" onclick="ResetSales()" style="height: 40px; font-size: 16px; font-weight: bold; margin: 1px; margin-left: 0px; width: 109px; background-color: #FF0000">
            <input type="button" value="Edit" style="height: 40px; font-size: 16px; font-weight: bold; margin: 1px; margin-left: 0px; width: 109px;" onclick='PopupSearch();'><br>
            <input type="button" value="Clear" onclick="clearSales()" style="height: 40px; font-size: 16px; font-weight: bold; margin:1px; margin-left: 0px; width: 109px;">
            <input type="button" value="Void" style="height: 40px; font-size: 16px; font-weight: bold; margin: 1px; margin-left: 0px; width: 109px;">
           <!-- <div style="float: left; margin-right: 0px;">
                <input type="button" value="Other Btn" onclick="keypad(this.value)" style="height: 30px; font-size: 16px; font-weight: bold; margin:2px; width: 109px; margin-left: 0px; display:none;"><br>
                <input type="button" value="Other Btn" onclick="keypad(this.value)" style="height: 30px; font-size: 16px; font-weight: bold; margin:2px; width: 109px; margin-left: 0px; display:none;"><br>
                <input type="button" value="Other Btn" onclick="keypad(this.value)" style="height: 30px; font-size: 16px; font-weight: bold; margin:2px; width: 109px; margin-left: 0px; display:none;"><br>
                <input type="button" value="Other Btn" onclick="keypad(this.value)" style="height: 30px; font-size: 16px; font-weight: bold; margin:2px; width: 109px; margin-left: 0px; display:none;"><br>
                <input type="button" value="Other Btn" onclick="keypad(this.value)" style="height: 30px; font-size: 16px; font-weight: bold; margin:2px; width: 109px; margin-left: 0px; display:none;">
            </div>
            <div style="float: right; margin-right: 1px;">
                <input type="button" value="50" onclick="keypad(this.value)" style="height: 30px; font-size: 16px; font-weight: bold; background-color:#20AA73; margin:2px; width: 109px;"><br>
                <input type="button" value="100" onclick="keypad(this.value)" style="height: 30px; font-size: 16px; font-weight: bold; background-color:#20AA73; margin:2px; width: 109px;"><br>
                <input type="button" value="200" onclick="keypad(this.value)" style="height: 30px; font-size: 16px; font-weight: bold; background-color:#20AA73; margin:2px; width: 109px;"><br>
                <input type="button" value="500" onclick="keypad(this.value)" style="height: 30px; font-size: 16px; font-weight: bold; background-color:#20AA73; margin:2px; width: 109px;"><br>
                <input type="button" value="1000" onclick="keypad(this.value)" style="height: 30px; font-size: 16px; font-weight: bold; background-color:#20AA73; margin:2px; width: 109px;">
            </div> -->
        </div>
        <div id="keypad" style="padding:0px; padding-top: 0px; padding-right: 0px; float: right; ">
            <!--<div class="amount" id="amount"></div> -->
            <!---<input type="text" name="numbers" id="numbers" style="font-size:18px; width: 180px; border: none;"> --><br>
           <!-- <input type="button" value="1" id="keypadbutton" onclick="keypad(this.value)">
            <input type="button" value="2" id="keypadbutton" onclick="keypad(this.value)">
            <input type="button" value="3" id="keypadbutton" onclick="keypad(this.value)"><br>
            <input type="button" value="4" id="keypadbutton" onclick="keypad(this.value)">
            <input type="button" value="5" id="keypadbutton" onclick="keypad(this.value)">
            <input type="button" value="6" id="keypadbutton" onclick="keypad(this.value)"><br>
            <input type="button" value="7" id="keypadbutton" onclick="keypad(this.value)">
            <input type="button" value="8" id="keypadbutton" onclick="keypad(this.value)">
            <input type="button" value="9" id="keypadbutton" onclick="keypad(this.value)"><br>
            <input type="button" value="0" id="keypadbutton" onclick="keypad(this.value)">
            <input type="button" value="00" id="keypadbutton" onclick="keypad(this.value)">
            <input type="button" value="." id="keypadbutton" onclick="keypad(this.value)"><br>
            <input type="button" value="Delete" id="keypadbutton" style="font-size:14px; width: 108px;" onclick="deleteKeypad()">
            <input type="button" value="Clear" id="keypadbutton" style="font-size:14px; width: 108px;" onclick="clearKeypad()"><br>
           -->
        </div>
        
    </div>
    <div id="tabs_2">
        Legend<br><br>
        <table border="0">
            <tr>
                <td style="text-align: right;"><div class="circle_A"></div> </td>
                <td style="text-align: left;">Available</td>
                <td style="text-align: right;"><div class="circle_R"></div></td>
                <td style="text-align: left;">Reserved</td>
                <td style="text-align: right;"><div class="circle_NA"></div></td>
                <td style="text-align: left;">Not Available</td>
            </tr>
        </table>
        <br>
        <hr>
        <div id="displayTables">
        </div>
    </div>
</div>
<div id="categoryTabs" style=" width: 63%; float: right; margin-top: 0px; margin-right: 5px;">
</div>
            
<!-- Popup -->
<div id="payment" title="Payment" style="display: none; width: 400px;">
    <div id="popup_tabs" style="position:relative; z-index:0; width: 100%; float: left;">
        <ul style="padding-left: 2px;">
            <li><a oncontextmenu="return false;" href="#popup_tabs_1" style="padding:8px 20px; font-weight: bold;"> Walk-In </a></li>
            <li><a oncontextmenu="return false;" href="#popup_tabs_2" style="padding:8px 20px; font-weight: bold;"> Charge to Room </a></li>
        </ul>
        <div id="popup_tabs_1" style="position: relative; height: 380px;">
            <div class="block" style="margin-left: 50px; top: 10px;">
                <label >Payment Mode</label>
                <select tabindex="16" id="payment_mode" style="width: 100px;">
                </select>
            </div>
            <div class="block" style="margin-left: 250px; top: 10px;">
                <label style="margin-top: -5px;">Total Amount</label>
                <input type="text" id="total_amount1" style="width:100px; font-size: 18px; font-weight: bold; color:green;">
            </div>
            <div class="block" style="margin-left: 50px; top: 45px;">
                <label>Table number</label>
                <select id="table_id1" style="width:80px;">
                </select>
            </div>
            <div class="block" style="margin-left: 250px; top: 45px;">
                <label>Table Status</label>
                <select id="table_status1" style="width:150px;">
                </select>
            </div>
            <div class="block" style="margin-left: 410px; top: 10px;">
                <label> </label>
                <input type="button" value="Paid" onclick="Paid()" style="height: 40px; font-size: 14px; font-weight: bold; margin: 0px; width: 109px;">
            </div>
            <div id="keypad" style="padding:0px; padding-top: 0px; padding-right: 0px; position: relative; top: 80px; margin-left: 150px;">
                <div class="amount" id="amount"></div>
                <!---<input type="text" name="numbers" id="numbers" style="font-size:18px; width: 180px; border: none;"> --><br>
                <input type="button" value="1" id="keypadbutton" onclick="keypad(this.value)">
                <input type="button" value="2" id="keypadbutton" onclick="keypad(this.value)">
                <input type="button" value="3" id="keypadbutton" onclick="keypad(this.value)"><br>
                <input type="button" value="4" id="keypadbutton" onclick="keypad(this.value)">
                <input type="button" value="5" id="keypadbutton" onclick="keypad(this.value)">
                <input type="button" value="6" id="keypadbutton" onclick="keypad(this.value)"><br>
                <input type="button" value="7" id="keypadbutton" onclick="keypad(this.value)">
                <input type="button" value="8" id="keypadbutton" onclick="keypad(this.value)">
                <input type="button" value="9" id="keypadbutton" onclick="keypad(this.value)"><br>
                <input type="button" value="0" id="keypadbutton" onclick="keypad(this.value)">
                <input type="button" value="00" id="keypadbutton" onclick="keypad(this.value)">
                <input type="button" value="." id="keypadbutton" onclick="keypad(this.value)"><br>
                <input type="button" value="Delete" id="keypadbutton" style="font-size:14px; width: 108px;" onclick="deleteKeypad()">
                <input type="button" value="Clear" id="keypadbutton" style="font-size:14px; width: 108px;" onclick="clearKeypad()"><br>
            </div>
        </div>
        <div id="popup_tabs_2"  style="position: relative; height: 380px;">
            <div class="block" style="margin-left: 0px; top: 10px;">
                <label>Select Number </label>
                <select tabindex="1" id="room_id" style="width:80px;" onblur="LF_room_id()">
                </select>
            </div>
            <div class="block" style="margin-left: 0px; top: 40px;">
                <label>Customer name</label>
                <input type="text" id="customer_name" style="width:150px;">
            </div>
            <div class="block" style="margin-left: 0px; top: 70px;">
                <label>Table number</label>
                <select id="table_id2" style="width:80px;">
                </select>
            </div>
            <div class="block" style="margin-left: 250px; top: 70px;">
                <label>Table Status</label>
                <select id="table_status2" style="width:150px;">
                </select>
            </div>
            <div class="block" style="margin-left: 250px; top: 10px;">
                <label style="margin-top: -5px;">Total Amount</label>
                <input type="text" id="total_amount2" style="width:100px; font-size: 18px; font-weight: bold; color:green;">
            </div>
            <div class="block" style="margin-left: 100px; top: 130px;">
                <label> </label>
                <input type="button" id="tab5_btnSave" value="Save" style="height: 40px; font-size: 14px; font-weight: bold; margin: 0px; width: 109px;" onclick="ChargetoRoom()">
            </div>
        </div>
    </div>
</div>

<!-- Hidden -->
<input type="hidden" id="sales_id">
<input type="hidden" id="record_date">
<input type="hidden" id="record_time">
<input type="hidden" id="customer_id">
<input type="hidden" name="tabID" id="tabID" value="tabs_2">
<%@include file="pos_sales_rpt_jsfunction.jsp"%>
<%@include file="../footer.jsp"%>
