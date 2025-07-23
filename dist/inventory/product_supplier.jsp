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

String title = "Supplier";
%>
<%@include file="../common/sidefind.jsp"%>
<fieldset style="width:700px; margin: auto; margin-top: 50px; border: 1px solid #ddd; background-color: #f6f6f6; padding:20px;"  >
    <legend style="font-size: 14px; font-weight: bold; padding:0 10px"><%= title %></legend>
	<form action="" method="post" name="WASForm" id="WASForm" autocomplete="off">
            <div class="input-w" style="margin-left: 130px; margin-top: 0px;">
                <label id="lb_supplier_id">Supplier ID</label>
                <input type="text" name="supplier_id" id="supplier_id" style="width:100px;" disabled>
            </div>
            <div class="input-w" style="margin-left: 100px; margin-top: 0px;">
                <label id="lb_company_name">Company Name</label>
                <input type="text" name="company_name" id="company_name" style="width:250px;" onblur="LF_company_name()">
            </div>
            <div class="input-w" style="margin-left: 130px; margin-top: 0px;">
                <label id="lb_contact_first_name">First Name</label>
                <input type="text" name="contact_first_name" id="contact_first_name">
            </div>
            <div class="input-w" style="margin-left: 130px; margin-top: 0px;">
                <label id="lb_contact_last_name">Last Name</label>
                <input type="text" name="contact_last_name" id="contact_last_name"> 
            </div>
            <div class="input-w" style="margin-left: 145px; margin-top: 0px;">
                <label id="lb_address">Address</label>
                <input type="text" name="address" id="address">
            </div>
            <div class="input-w" style="margin-left: 155px; margin-top: 0px;">
                <label id="lb_phone">Phone</label>
                <input type="text" name="phone" id="phone" >
            </div>
            <div class="input-w" style="margin-left: 170px; margin-top: 0px;">
                <label id="lb_fax">Fax</label>
                <input type="text" name="fax" id="fax" >
            </div>
            <div class="input-w" style="margin-left: 155px; margin-top: 0px;">
                <label id="lb_email">Email</label>
                <input type="text" name="email" id="email" >
            </div>
	</form>
</fieldset>

<%@include file="product_supplier_jsfunction.jsp"%>
<%@include file="../footer.jsp"%>