<%@include file="../header.jsp"%>

<fieldset style="width:350px; height: 530px; margin-left: 20px; margin-top: 0px; border: 1px solid #ddd; background-color: #f6f6f6; padding:10px; position: absolute;"  >
    <legend style="font-size: 12px; font-weight: bold; padding:0 10px">Card Numbers</legend>
    <div class="component1" style="width:100%; height:520px; float:left; padding:0px; overflow: auto; margin-top:0px;">
        <table>
            <thead>
                <tr>
                    <th style="text-align:center;">Card Number</th>
                    <th style="text-align:center;">Link Number</th>
                    <th style="text-align:center;">Action</th>
                </tr>
            </thead>
            <tbody id="displayList">
            </tbody>
        </table>
    </div>
</fieldset>
<fieldset style="width:700px; height: 260px; margin-left: 410px; margin-top: 0px; border: 1px solid #ddd; background-color: #f6f6f6; padding:10px; position: absolute;"  >
    <legend style="font-size: 12px; font-weight: bold; padding:0 10px">Link to Customer</legend>
    <div class="block" style="margin-left: 50px; top: 30px;">
        <label id="lb_card_number">Card Number</label>
        <input type="text" tabindex="1" name="card_number" id="card_number" style="width: 120px;">
    </div>
    <div class="block" style="margin-left: 50px; top: 60px;">
        <label id="lb_card_number">Link Number</label>
        <input type="text" tabindex="2" name="link_number" id="link_number" style="width: 120px;">
    </div>
    <div class="block" style="margin-left: 50px; top: 90px;">
        <label id="lb_card_status">Status</label>
        <select tabindex="3" name="card_status" id="card_status" style="width: 150px;">
        </select>
    </div>
    <div class="block" style="margin-left: 50px; top: 120px;">
        <label id="lb_expiry_date">Expiry Date</label>
        <input type="text" tabindex="4" name="expiry_date" id="expiry_date" style="width: 80px;">
    </div>
    <div class="block" style="margin-left: 50px; top: 150px;">
        <label id="lb_customer_id">Customer ID</label>
        <input type="text" tabindex="5" name="customer_id" id="customer_id" style="width: 120px;" onkeypress='validate(event);'>
        <input type="text" tabindex="-1" name="customer_name" id="customer_name">
    </div>
    <div class="block" style="margin-left: 400px; top: 30px;">
        <label id="lb_record_date">Record Date</label>
        <input type="text" tabindex="-1" name="record_date" id="record_date" style="width: 80px;">
    </div>
    <div class="block" style="margin-left: 400px; top: 60px;">
        <label id="lb_account_number">Account Number</label>
        <input type="text" tabindex="-1" name="account_number" id="account_number" style="width: 80px;">
    </div>
    <!-- <div class="block" style="margin-left: 400px; top: 90px;">
        <label id="lb_account_balance">Account Balance</label>
        <input type="text" tabindex="6" name="account_balance" id="account_balance" style="width: 80px;" onkeypress='validate(event);' onblur="LostFocus('LF_account_balance();')">
    </div> -->
    <div class="block" style="margin-left: 200px; top: 210px;">
        <input type="button" tabindex="7" name="btnSave" id="btnSave" value="Save" style="width:100px;" onclick="Save()">
        <input type="button" tabindex="8" name="btnCancel" id="btnCancel" value="Reset" style="width:100px;" onclick="Reset()">
        <input type="button" tabindex="9" name="btnClose" id="btnClose" value="Close" style="width:100px;" onclick="window.close();">
    </div>
</fieldset>
<%@include file="card_link_to_customer_rpt_jsfunction.jsp"%>
<%@include file="../footer.jsp"%>