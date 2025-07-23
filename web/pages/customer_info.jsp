<%@include file="../header.jsp"%>
<%@include file="../functions/record_function.jsp"%>

<%
/* No need to put String as variables already initialize */
table = "was_customer_info";
fields = "customer_id as rowid,customer_id,first_name,last_name,gender,tariff,customer_type,account_number,account_name,bank_name,branch,contact_number,email,fax,record_date";
where = "customer_id";
/*used in Add New*/
enableFields = "first_name,last_name,gender,tariff,customer_type,account_number,account_name,bank_name,branch,contact_number,email,fax";
/*used in Amend*/
amendableFields = "first_name,last_name,gender,tariff,customer_type,account_number,account_name,bank_name,branch,contact_number,email,fax";
requiredFields = "first_name,last_name,gender,tariff,customer_type,contact_number,email,fax";

pageMode = "N,E,D";
/*End here*/

String title = "Customer Information";
%>
<%@include file="../common/sidefind.jsp"%>
<div id="tabs" style="position:relative; z-index:0; width: 950px; float: left; margin: 0px 5px 5px 5px;">
     <ul style="padding-left: 2px;">
        <li><a oncontextmenu="return false;" href="#tabs_1" id="tab1" style="padding:8px 20px; font-weight: bold; white-space: normal; vertical-align:middle;" onclick="tab1()">Details</a></li>
        <li><a oncontextmenu="return false;" href="#tabs_2" id="tab2" style="padding:8px 20px; font-weight: bold;" onclick="tab2()"> Contact </a></li>
        <li><a oncontextmenu="return false;" href="#tabs_3" id="tab3" style="padding:8px 20px; font-weight: bold;" onclick="tab3()"> Sales Default </a></li>
        <li><a oncontextmenu="return false;" href="#tabs_4" id="tab4" style="padding:8px 20px; font-weight: bold;" onclick="tab4()"> History(Summary) </a></li>
        <li><a oncontextmenu="return false;" href="#tabs_5" id="tab5" style="padding:8px 20px; font-weight: bold;" onclick="tab5()"> History(Detailed) </a></li>
    </ul>
    <div id="tabs_1" style="height: 495px;">
        <input type="hidden" name="record_date" id="record_date" style="width:80px;">
        <fieldset style="width:850px; height:110px; margin-left:25px; margin-top: 14px; border: 1px solid #ddd; background-color: #f6f6f6; padding:5px; position: absolute;">
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
                <div class="block" style="margin-left: 400px; top: 0px;" >
                    <label id="lb_gender">Gender</label>
                    <select name="gender" id="gender">
                    </select>
                </div>
                <div class="block" style="margin-left: 400px; top: 30px;" >
                    <label id="lb_tariff">Tariff</label>
                    <select name="tariff" id="tariff">
                    </select>
                </div>
                <div class="block" style="margin-left: 400px; top: 60px;">
                    <label id="lb_customer_type">Customer Type</label>
                    <select name="customer_type" id="customer_type">
                    </select>
                </div>
            </div>
        </fieldset>
        <fieldset style="width:415px; height: 150px; margin-left:25px; margin-top: 140px; border: 1px solid #ddd; background-color: #f6f6f6; padding:5px; float: right;  position: absolute;">
            <legend style="font-size: 12px; font-weight: bold; padding:0 10px">Bank Account Details</legend>
            <div style="position: relative;">
                <div class="block" style="margin-left: 20px; top: 0px;">
                    <label id="lb_account_number">Account Number</label>
                    <input type="text" name="account_number" id="account_number" style="width:120px;" maxlength="19">
                </div>
                <div class="block" style="margin-left: 20px; top: 30px;">
                    <label id="lb_account_name">Account Name</label>
                    <input type="text" name="account_name" id="account_name" maxlength="40">
                </div>
                <div class="block" style="margin-left: 20px; top: 60px;" >
                    <label id="lb_bank_name">Bank Name</label>
                    <input type="text" name="bank_name" id="bank_name" maxlength="40">
                </div>
                <div class="block" style="margin-left: 20px; top: 90px;">
                    <label id="lb_branch">Branch</label>
                    <input type="text" name="branch" id="branch" maxlength="40">
                </div>
            </div>
        </fieldset>
        <fieldset style="width:415px; height: 150px; margin-left:460px; margin-top: 140px; border: 1px solid #ddd; background-color: #f6f6f6; padding:5px; float: right;  position: absolute;">
            <legend style="font-size: 12px; font-weight: bold; padding:0 10px">Main Contact Details</legend>
            <div style="position: relative;">
                <div class="block" style="margin-left: 20px; top: 0px;">
                    <label id="lb_contact_number">Contact Number</label>
                    <input type="text" name="contact_number" id="contact_number" style="width:100px;" maxlength="15">
                </div>
                <div class="block" style="margin-left: 20px; top: 30px;">
                    <label id="lb_email">Email</label>
                    <input type="text" name="email" id="email" maxlength="30">
                </div>
                <div class="block" style="margin-left: 20px; top: 60px;" >
                    <label id="lb_fax">Fax</label>
                    <input type="text" name="fax" id="fax" maxlength="30">
                </div>
            </div>
        </fieldset>
    </div>
    <div id="tabs_2" style="height: 495px;">
        <fieldset style="width:840px; height: 220px; margin-left:30px; margin-top: 10px; border: 1px solid #ddd; background-color: #f6f6f6; padding:5px; position: absolute;">
            <legend style="font-size: 12px; font-weight: bold; padding:0 10px">General Information</legend>
            <div style="position: relative;">
                <div class="block" style="margin-left: 50px; top: 0px;">
                    <label id="lb_hd_address_category">Address Category</label>
                    <select name="hd_address_category" id="hd_address_category">
                    </select>
                </div>
                <div class="block" style="margin-left: 50px; top: 30px;">
                    <label id="lb_hd_contact_person">Contact Person</label>
                    <input type="text" name="hd_contact_person" id="hd_contact_person" style="width:250px;" maxlength="40">
                </div>
                <div class="block" style="margin-left: 50px; top: 60px;">
                    <label id="lb_hd_address_line_1">Address Line 1</label>
                    <input type="text" name="hd_address_line_1" id="hd_address_line_1" maxlength="40">
                </div>
                <div class="block" style="margin-left: 50px; top: 90px;">
                    <label id="lb_hd_address_line_2">Address Line 2</label>
                    <input type="text" name="hd_address_line_2" id="hd_address_line_2" maxlength="40">
                </div>
                <div class="block" style="margin-left: 50px; top: 120px;">
                    <label id="lb_hd_address_line_3">Address Line 3</label>
                    <input type="text" name="hd_address_line_3" id="hd_address_line_3" maxlength="40">
                </div>
                <div class="block" style="margin-left: 50px; top: 150px;">
                    <label id="lb_hd_address_line_4">Address Line 4</label>
                    <input type="text" name="hd_address_line_4" id="hd_address_line_4" maxlength="40">
                </div>
                <div class="block" style="margin-left: 450px; top: 0px;">
                    <label id="lb_hd_city">City</label>
                    <select name="hd_city" id="hd_city">
                    </select>
                </div>
                <div class="block" style="margin-left: 450px; top: 30px;">
                    <label id="lb_hd_country">Country</label>
                    <select name="hd_country" id="hd_country">
                    </select>
                </div>
                <div class="block" style="margin-left: 450px; top: 60px;">
                    <label id="lb_hd_zip_code">Zip Code</label>
                    <input type="text" name="hd_zip_code" id="hd_zip_code" maxlength="4" style="width: 50px;">
                </div>
                <div class="block" style="margin-left: 450px; top: 90px;">
                    <label id="lb_hd_email">Email</label>
                    <input type="text" name="hd_email" id="hd_email" maxlength="40">
                </div>
                <div class="block" style="margin-left: 450px; top: 120px;">
                    <label id="lb_hd_telephone">Telephone</label>
                    <input type="text" name="hd_telephone" id="hd_telephone" maxlength="15" style="width: 120px;">
                </div>
                <div class="block" style="margin-left: 450px; top: 150px;">
                    <label id="lb_hd_fax">Fax</label>
                    <input type="text" name="hd_fax" id="hd_fax" maxlength="15" style="width: 120px;">
                </div>
                <div class="block" style="margin-left: 450px; top: 180px;">
                    <label id="lb_hd_mobile">Mobile</label>
                    <input type="text" name="hd_mobile" id="hd_mobile" maxlength="15" style="width: 120px;">
                </div>
            </div>
        </fieldset>
        <div style="text-align: center; position: relative; margin-top: 250px;">
            <input type="button" name="hd_save" id="hd_save" value="New" style="width:100px;" onclick="NewContact()">
            <input type="button" name="hd_clear" id="hd_clear" value="Clear" style="width:100px;" onclick="ClearContact()">
            <input type="button" name="hd_cancel" id="hd_cancel" value="Cancel" style="width:100px;" onclick="CancelContact()">
        </div>
        <fieldset style="width:840px; height: 190px; margin-left:30px; margin-top: 0px; border: 1px solid #ddd; background-color: #f6f6f6; padding:5px; position: absolute;">
            <legend style="font-size: 12px; font-weight: bold; padding:0 10px">List</legend>
            <div class="component1" style="width:100%; float:left; padding:0px; overflow: auto;">
                <table>
                    <thead>
                        <tr>
                            <th style="text-align:center; width: 15%">Category</th>
                            <th style="text-align:center; width: 30%">Contact Person</th>
                            <th style="text-align:center; width: 20%">Email</th>
                            <th style="text-align:center; width: 20%">Contact number</th>
                            <th style="text-align:center; width: 15%">Action</th>
                        </tr>
                    </thead>
                    <tbody id="displayListContact">
                    </tbody>
                </table>
            </div>
            <input type="hidden" name="hd_ContactID" id="hd_ContactID" value="">
            <input type="hidden" name="hd_ContactMode" id="hd_ContactMode" value="">
        </fieldset>
    </div>
    <div id="tabs_3" style="height: 670px;">
        <fieldset style="width:850px; height:80px; margin-left:25px; margin-top: 0px; border: 1px solid #ddd; background-color: #f6f6f6; padding:5px; position: absolute;">
            <legend style="font-size: 12px; font-weight: bold; padding:0 10px">Method</legend>
            <div style="position: relative;">
                <div class="block" style="margin-left: 20px; top: 0px;">
                    <label id="lb_hd_shipping_method">Shipping Method</label>
                    <select name="hd_shipping_method" id="hd_shipping_method">
                    </select>
                </div>
                <div class="block" style="margin-left: 0px; top: 30px;">
                    <label id="lb_hd_sales_representative" style="width: 120px;">Sales Representative</label>
                    <input type="text" name="hd_sales_representative" id="hd_sales_representative" maxlength="30">
                </div>
                <div class="block" style="margin-left: 450px; top: 0px;">
                    <label id="lb_hd_payment_method">Payment Method</label>
                    <select name="hd_payment_method" id="hd_payment_method">
                    </select>
                </div>
                <div class="block" style="margin-left: 450px; top: 30px;">
                    <label id="lb_hd_payment_terms">Payment Terms</label>
                    <input type="text" name="hd_payment_terms" id="hd_payment_terms" maxlength="30" style="width: 100px;">
                </div>
            </div>
        </fieldset>
        <fieldset style="width:415px; height: 170px; margin-left:25px; margin-top: 100px; border: 1px solid #ddd; background-color: #f6f6f6; padding:5px; float: right;  position: absolute;">
            <legend style="font-size: 12px; font-weight: bold; padding:0 10px">Credit Card Information</legend>
            <div style="position: relative;">
                <div class="block" style="margin-left: 20px; top: 0px;">
                    <label id="lb_hd_card_number">Card Number</label>
                    <input type="text" name="hd_card_number" id="hd_card_number" style="width:150px;" maxlength="19">
                </div>
                <div class="block" style="margin-left: 20px; top: 30px;">
                    <label id="lb_hd_cardholder_name">Cardholder Name</label>
                    <input type="text" name="hd_cardholder_name" id="hd_cardholder_name" maxlength="40">
                </div>
                <div class="block" style="margin-left: 20px; top: 60px;" >
                    <label id="lb_hd_expiry_date">Expiry Date</label>
                    <input type="text" name="hd_expiry_date" id="hd_expiry_date" maxlength="5" style="width: 50px;">
                </div>
                <div class="block" style="margin-left: 20px; top: 90px;">
                    <label id="lb_hd_billing_address">Billing Address</label>
                    <input type="text" name="hd_billing_address" id="hd_billing_address" maxlength="40">
                </div>
            </div>
        </fieldset>
        <fieldset style="width:415px; height: 170px; margin-left:460px; margin-top: 100px; border: 1px solid #ddd; background-color: #f6f6f6; padding:5px; float: right;  position: absolute;">
            <legend style="font-size: 12px; font-weight: bold; padding:0 10px">Terms and Credit</legend>
            <div style="position: relative;">
                <div class="block" style="margin-left: 20px; top: 0px;">
                    <label id="lb_hd_net_due">Net Due</label>
                    <input type="text" name="hd_net_due" id="hd_net_due" style="width:50px;" maxlength="3">
                </div>
                <div class="block" style="margin-left: 20px; top: 30px;">
                    <label id="lb_hd_discount">Discount</label>
                    <input type="text" name="hd_discount" id="hd_discount" style="width:50px;" maxlength="3">
                </div>
                <div class="block" style="margin-left: 20px; top: 60px;" >
                    <label id="lb_hd_percentage">Percentage</label>
                    <input type="text" name="hd_percentage" id="hd_percentage" style="width:50px;" maxlength="3">
                </div>
                <div class="block" style="margin-left: 20px; top: 90px;" >
                    <label id="lb_hd_credit_limit">Credit Limit</label>
                    <input type="text" name="hd_credit_limit" id="hd_credit_limit" style="width:100px;" maxlength="10">
                </div>
                <div class="block" style="margin-left: 20px; top: 120px;" >
                    <label id="lb_hd_credit_status">Credit Status</label>
                    <input type="text" name="hd_credit_status" id="hd_credit_status" style="width:100px;" maxlength="10">
                </div>
            </div>
        </fieldset>
        <fieldset style="width:850px; height:110px; margin-left:25px; margin-top: 290px; border: 1px solid #ddd; background-color: #f6f6f6; padding:5px; position: absolute;">
            <legend style="font-size: 12px; font-weight: bold; padding:0 10px">Method</legend>
            <div style="position: relative;">
                <div class="block" style="margin-left: 20px; top: 0px;">
                    <label id="lb_hd_receivable_gl">Receivable GL</label>
                    <select name="hd_receivable_gl" id="hd_receivable_gl">
                    </select>
                </div>
                <div class="block" style="margin-left: 20px; top: 30px;">
                    <label id="lb_hd_revenue_gl">Revenue GL</label>
                    <select name="hd_revenue_gl" id="hd_revenue_gl">
                    </select>
                </div>
                <div class="block" style="margin-left: 20px; top: 60px;">
                    <label id="lb_hd_discount_gl">Discount GL</label>
                    <select name="hd_discount_gl" id="hd_discount_gl">
                    </select>
                </div>
                <div class="block" style="margin-left: 450px; top: 0px;">
                    <label id="lb_hd_tax_gl">Tax GL</label>
                    <select name="hd_tax_gl" id="hd_tax_gl">
                    </select>
                </div>
                <div class="block" style="margin-left: 450px; top: 30px;">
                    <label id="lb_hd_surcharge_gl">Surcharge GL</label>
                    <select name="hd_surcharge_gl" id="hd_surcharge_gl">
                    </select>
                </div>
                <div class="block" style="margin-left: 450px; top: 60px;">
                    <label id="lb_hd_payment_gl">Payment GL</label>
                    <select name="hd_payment_gl" id="hd_payment_gl">
                    </select>
                </div>
            </div>
        </fieldset>
        <div style="text-align: center; position: relative; margin-top: 420px;">
            <input type="button" name="hd_saveSaleTab" id="hd_saveSaleTab" value="New" style="width:100px;" onclick="NewSaleTab()">
            <input type="button" name="hd_clearSaleTab" id="hd_clearSaleTab" value="Clear" style="width:100px;" onclick="ClearSaleTab()">
            <input type="button" name="hd_cancelSaleTab" id="hd_cancelSaleTab" value="Cancel" style="width:100px;" onclick="CancelSaleTab()">
        </div>
        <fieldset style="width:840px; height: 190px; margin-left:30px; margin-top: 0px; border: 1px solid #ddd; background-color: #f6f6f6; padding:5px; position: absolute;">
            <legend style="font-size: 12px; font-weight: bold; padding:0 10px">List</legend>
            <div class="component1" style="width:100%; float:left; padding:0px; overflow: auto;">
                <table>
                    <thead>
                        <tr>
                            <th style="text-align:center; width: 25%">Shipping Method</th>
                            <th style="text-align:center; width: 25%">Payment Method</th>
                            <th style="text-align:center; width: 35%">Sales Representative</th>
                            <th style="text-align:center; width: 15%">Action</th>
                        </tr>
                    </thead>
                    <tbody id="displayListSale">
                    </tbody>
                </table>
            </div>
            <input type="hidden" name="hd_SaleTabID" id="hd_SaleTabID" value="">
            <input type="hidden" name="hd_SaleTabMode" id="hd_SaleTabMode" value="">
        </fieldset>
    </div>
    <div id="tabs_4">
        <div style="position:relative;">
            <div class="block" style="margin-left: -25px; top: 0px;">
                <label id="lb_hd_tab3_card_number">Card number</label>
                <input type="text" name="hd_tab3_card_number" id="hd_tab3_card_number" style="width:120px;">
            </div>
            <div class="component1" style="width:100%; height:400px; top:40px; float:left; padding:0px; overflow: auto; position:relative;">
                <table>
                    <thead>
                        <tr>
                            <th style="text-align:center; width: 20%">Transaction slip</th>
                            <th style="text-align:center; width: 15%">Transaction date</th>
                            <th style="text-align:center; width: 15%">Transaction time</th>
                            <th style="text-align:center; width: 20%">Transaction type</th>
                            <th style="text-align:center; width: 10%">Credit amount</th>
                            <th style="text-align:center; width: 10%">Debit amount</th>
                            <th style="text-align:center; width: 10%">Balance</th>
                        </tr>
                    </thead>
                    <tbody id="displayTransDetails">
                    </tbody>
                </table>
            </div>
        </div>
    </div>
    <div id="tabs_5"></div>
</div>
<%@include file="customer_info_jsfunction.jsp"%>
<%@include file="../footer.jsp"%>