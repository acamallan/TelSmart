<%@include file="../header.jsp"%>

<fieldset style="width:700px; height: 300px; margin:auto; margin-top: 30px; border: 1px solid #ddd; background-color: #f6f6f6; padding:10px;"  >
    <legend style="font-size: 12px; font-weight: bold; padding:0 10px">Reload</legend>
    <div style="position: relative;">
        <div class="block" style="margin-left: 20px; top: 0px;">
            <label id="lb_transaction_id" style="width:130px;">Transaction ID</label>
            <input type="text" tabindex="-1" name="transaction_id" id="transaction_id" style="width: 100px;">
        </div>
        <div class="block" style="margin-left: 50px; top: 30px;">
            <label id="lb_card_number">Card Number</label>
            <input type="text" tabindex="1" name="card_number" id="card_number" style="width: 150px;" maxlength="16" onkeypress='validate(event);' onblur="LostFocus('LF_card_number()')">
        </div>
        <div class="block" style="margin-left: 50px; top: 60px;">
            <label id="lb_customer_id">Customer ID</label>
            <input type="text" tabindex="-1" name="customer_id" id="customer_id" style="width: 150px;">
        </div>
        <div class="block" style="margin-left: 50px; top: 90px;">
            <label id="lb_link_number">Link number</label>
            <input type="text" tabindex="-1" name="link_number" id="link_number" style="width: 150px;">
        </div>
        <div class="block" style="margin-left: 50px; top: 120px;">
            <label id="lb_customer_name">Customer name</label>
            <input type="text" tabindex="-1" name="customer_name" id="customer_name">
        </div>
        <div class="block" style="margin-left: 50px; top: 150px;">
            <label id="lb_transaction_typee">Transaction type</label>
            <select tabindex="-1" name="transaction_type" id="transaction_type">
            </select>
        </div>
        <div class="block" style="margin-left: 50px; top: 180px;">
            <label id="lb_currency_type">Currency type</label>
            <select tabindex="-1" name="currency_type" id="currency_type">
            </select>
        </div>
        <div class="block" style="margin-left: 50px; top: 210px;">
            <label id="lb_transaction_amount">Enter amount</label>
            <input type="text" tabindex="2" name="transaction_amount" id="transaction_amount" style="font-size: 14px; width: 80px;" onkeypress='validate(event);' onblur="LostFocus('LF_transaction_amount()')">
        </div>
        <div class="block" style="margin-left: 420px; top: 0px;">
            <label id="lb_transaction_date">Transaction Date</label>
            <input type="text" tabindex="-1" name="transaction_date" id="transaction_date" style="width: 80px;">
        </div>
        <div class="block" style="margin-left: 420px; top: 30px;">
            <label id="lb_transaction_time">Transaction Time</label>
            <input type="text" tabindex="-1" name="transaction_time" id="transaction_time" style="width: 80px;">
        </div>
        <div class="block" style="margin-left: 420px; top: 60px;">
            <label id="lb_userid">User ID</label>
            <input type="text" tabindex="-1" name="userid" id="userid" style="width: 50px;">
            <input type="text" tabindex="-1" name="username" id="username" style="width: 80px;">
        </div>
        <div class="block" style="margin-left: 420px; top: 120px;">
            <label id="lb_balance">Balance</label>
            <input type="text" tabindex="-1" name="balance" id="balance" style="width: 80px; font-size: 16px; color: green; padding: 5px;">
        </div>
        <div class="block" style="margin-left: 200px; top: 270px;">
            <input type="button" tabindex="3" name="btnReload" id="btnReload" value="Reload" style="width:100px;" onclick="Reload()">
            <input type="button" tabindex="4" name="btnReset" id="btnReset" value="Reset" style="width:100px;" onclick="Reset()">
            <input type="button" tabindex="5" name="btnClose" id="btnClose" value="Close" style="width:100px;" onclick="window.close();">
        </div>
        
        <input type="hidden" tabindex="-1" name="account_number" id="account_number">
    </div>
</fieldset>

<%@include file="card_reload_rpt_jsfunction.jsp"%>
<%@include file="../footer.jsp"%>