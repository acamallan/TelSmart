<%@include file="../header.jsp"%>
<%@include file="../functions/record_function.jsp"%>

<%
/* No need to put String as variables already initialize */
table = "was_customer_account";
fields = "account_number as rowid, account_number, customer_id, link_number, record_date";
where = "account_number";
/*used in Add New*/
enableFields = "";
/*used in Amend*/
amendableFields = "";
requiredFields = "";

pageMode = "";
/*End here*/
%>
<%@include file="../common/sidefind.jsp"%>

<fieldset style="width:700px; height: 150px; margin: auto; margin-top: 50px; border: 1px solid #ddd; background-color: #f6f6f6; padding:20px;"  >
    <legend style="font-size: 12px; font-weight: bold; padding:0 10px">Customer Account</legend>
        <div style="position: relative;">
            <div class="block" style="margin-left: 50px; top: 0px;">
                <label id="lb_account_number">Account number</label>
                <input type="text" name="account_number" id="account_number" style="width:100px;">
            </div>
            <div class="block" style="margin-left: 50px; top: 30px;">
                <label id="lb_customer_id">Customer ID</label>
                <input type="text" name="customer_id" id="customer_id" style="width:100px;">
                <input type="text" name="customer_name" id="customer_name" style="width:150px;">
            </div>
            <div class="block" style="margin-left: 50px; top: 60px;">
                <label id="lb_link_number">Link number</label>
                <input type="text" name="link_number" id="link_number" style="width:100px;">
            </div>
            <div class="block" style="margin-left: 450px; top: 0px;">
                <label id="lb_record_date">Record date</label>
                <input type="text" name="record_date" id="record_date" style="width:80px;">
            </div>
            <div class="block" style="margin-left: 200px; top: 100px;">
                <label id="lb_account_balance">Account Balance</label>
                <input type="text" name="account_balance" id="account_balance" style="width: 80px; font-size: 16px; color: green; padding: 5px;">
            </div>
	</div>
</fieldset>

<%@include file="customer_account_jsfunction.jsp"%>
<%@include file="../footer.jsp"%>