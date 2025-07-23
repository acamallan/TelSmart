<%@include file="../header.jsp"%>
<%@include file="../functions/record_function.jsp"%>

<%
/* No need to put String as variables already initialize */
table = "was_supplier";
fields = "supplier_id as rowid, supplier_id, company_name, contact_first_name, contact_last_name, address, phone, fax, email";
where = "supplier_id";
/*used in Add New*/
enableFields = "company_name, contact_first_name, contact_last_name, address, phone, fax, email";
/*used in Amend*/
amendableFields = "company_name, contact_first_name, contact_last_name, address, phone, fax, email";
requiredFields = "company_name, contact_first_name, contact_last_name, address, phone, fax, email";

/*End here*/

String title = "Reload Card";
%>
<%@include file="../common/sidefind.jsp"%>
    <fieldset style="width:850px; height:220px; margin: auto; margin-top: 50px; border: 1px solid #ddd; background-color: #f6f6f6; padding:20px;"  >
    <legend style="font-size: 14px; font-weight: bold; padding:0 10px"><%= title %></legend>
	<form action="" method="post" name="WASForm" id="WASForm" autocomplete="off">
            <div class="input-w" style="margin-left: 84px; margin-top: 0px;">
                <label id="lb_card_number">Card Number</label>
                <input type="text" name="card_number" id="card_number" value="1234567890" style="width:100px;" disabled>
            </div>
             <div class="input-w" style="margin-left: 500px; margin-top: -37px;">
                <label id="lb_email">Enter Amount</label>
                <input type="text" name="email" id="email" value="500" style="width:100px;">
            </div>
            <div class="input-w" style="margin-left: 90px; margin-top: 0px;">
                <label id="lb_company_name">Customer ID</label>
                <input type="text" name="company_name" id="company_name" value="CD1234567" disabled style="width:150px;" onblur="LF_company_name()">
            </div>
            <div class="input-w" style="margin-left: 100px; margin-top: 0px;">
                <label id="lb_company_name">First name</label>
                <input type="text" name="company_name" id="company_name" value="Juan" disabled style="width:150px;" onblur="LF_company_name()">
            </div>
            <div class="input-w" style="margin-left: 100px; margin-top: 0px;">
                <label id="lb_contact_first_name">Last name</label>
                <input type="text" name="contact_first_name" id="contact_first_name" disabled value="Dela Cruz" style="width:150px;">
            </div>
            
            <div class="input-w" style="margin-left: 510px; margin-top: -100px;">
                
                <label id="lb_email" style="font-size: 16px; font-weight: bold;">Amount</label>
                <input type="text" name="email" id="email" disabled value="1500.00" style="width:100px; font-size: 16px; font-weight: bold;">
            </div>
           <div class="input-w" style="position: relative; margin-left:300px; margin-top: 80px;">
                <input type="button" name="process" id="process" value="Reload" onclick="ProcessReport()">
            </div>
        <div class="input-w" style="position: relative; margin-left:450px; margin-top: -38px;">
           <input type="button" name="cancel" id="cancel" value="Cancel">
        </div>
        </form>
    </fieldset>

<%@include file="customer_info_jsfunction.jsp"%>
<%@include file="../footer.jsp"%>