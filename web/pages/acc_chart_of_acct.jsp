<%@include file="../header.jsp"%>
<%@include file="../functions/record_function.jsp"%>

<%
/* No need to put String as variables already initialize */
table = "was_chart_of_account";
fields = "was_id as rowid, was_id, account_type, group_id";
where = "was_id";
/*used in Add New*/
enableFields = "was_id, account_type, group_id";
/*used in Amend*/
amendableFields = "account_type, group_id";
requiredFields = "was_id, account_type, group_id";
/*End here*/

pageMode = "N,E,D";

%>
<%@include file="../common/sidefind.jsp"%>

<fieldset style="width:700px;  height: 100px; margin: auto; margin-top: 100px; border: 1px solid #ddd; background-color: #f6f6f6; padding:20px;"  >
    <legend style="font-size: 12px; font-weight: bold; padding:0 10px">Chart of Account Setup</legend>
    <div style="position:relative; z-index:0;">
        <div class="block" style="margin-left: 100px; top: 0px;">
            <label id="lb_was_id">Chart ID</label>
            <input type="text" name="was_id" id="was_id" required onkeypress='validate(event);' maxlength="8" style="width:80px;" onblur="leadingzero(this.id,this.value,'4'); LostFocus('LF_was_id()') ">
        </div>
        <div class="block" style="margin-left: 100px; top: 30px;">
            <label id="lb_account_type">Account type</label>
            <input type="text" name="account_type" id="account_type"  required >
        </div>
        <div class="block" style="margin-left: 100px; top: 60px;">
            <label id="lb_group_id">Group</label>
            <select name="group_id" id="group_id">
            </select>
        </div>	
    </div>
</fieldset>
<%@include file="acc_chart_of_acct_jsfunction.jsp"%>
<%@include file="../footer.jsp"%>