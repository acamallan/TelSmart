<%@include file="../header.jsp"%>
<%@include file="../functions/record_function.jsp"%>

<%
/* No need to put String as variables already initialize */
table = "was_supplier";
fields = "supplier_id as rowid, supplier_id, company_name, vendor_type, website, account_number, account_name, bank_name, branch, contact_person, position, contact_number, fax, email, record_date";
where = "supplier_id";
/*used in Add New*/
enableFields = "company_name, vendor_type, website, account_number, account_name, bank_name, branch, contact_person, position, contact_number, fax, email";
/*used in Amend*/
amendableFields = "company_name, vendor_type, website, account_number, account_name, bank_name, branch, contact_person, position, contact_number, fax, email";
requiredFields = "company_name, vendor_type, website, account_number, account_name, bank_name, branch, contact_person, position, contact_number, fax, email";

pageMode = "N,E,D";
/*End here*/
%>
<%@include file="../common/sidefind.jsp"%>
<div id="tabs" style="position:relative; height: 93%; z-index:0; width: 950px; float: left; margin: 0px 5px 5px 5px;">
     <ul style="padding-left: 2px;">
        <li><a oncontextmenu="return false;" href="#tabs_1" style="padding:8px 20px; font-weight: bold; white-space: normal; vertical-align:middle;" onclick="tab1()">Details</a></li>
        <li><a oncontextmenu="return false;" href="#tabs_2" id="tab2" style="padding:8px 20px; font-weight: bold;" onclick="tab2()"> Address </a></li>
        <li><a oncontextmenu="return false;" href="#tabs_3" id="tab2" style="padding:8px 20px; font-weight: bold;" onclick="tab3()"> Purchase Default </a></li>
        <li><a oncontextmenu="return false;" href="#tabs_4" id="tab2" style="padding:8px 20px; font-weight: bold;" onclick="tab4()"> History(Summary) </a></li>
        <li><a oncontextmenu="return false;" href="#tabs_5" id="tab2" style="padding:8px 20px; font-weight: bold;" onclick="tab5()"> History(Detailed) </a></li>
    </ul>
    <div id="tabs_1">
        <input type="hidden" name="record_date" id="record_date" style="width:80px;">
        <fieldset style="width:400px; height: 150px; margin-left:30px; margin-top: 10px; border: 1px solid #ddd; background-color: #f6f6f6; padding:5px; position: absolute;"  >
            <legend style="font-size: 12px; font-weight: bold; padding:0 10px">General Information</legend>
            <div style="position: relative;">
                <div class="block" style="margin-left: 20px; top: 0px;">
                    <label id="lb_supplier_id">Supplier ID</label>
                    <input type="text" name="supplier_id" id="supplier_id" style="width:80px;">
                </div>
                <div class="block" style="margin-left: 20px; top: 30px;">
                    <label id="lb_company_name">Company Name</label>
                    <input type="text" name="company_name" id="company_name" maxlength="30">
                </div>
                <div class="block" style="margin-left: 20px; top: 60px;">
                    <label id="lb_vendor_type">Vendor type</label>
                    <select name="vendor_type" id="vendor_type">
                    </select>
                </div>
                <div class="block" style="margin-left: 20px; top: 90px;">
                    <label id="lb_website">Website</label>
                    <input type="text" name="website" id="website" maxlength="30">
                </div>
            </div>
        </fieldset>
        <fieldset style="width:400px; height: 150px; margin-left:450px; margin-top: 10px; border: 1px solid #ddd; background-color: #f6f6f6; padding:5px; float: right;  position: absolute;">
            <legend style="font-size: 12px; font-weight: bold; padding:0 10px">Bank Account Details</legend>
            <div style="position: relative;">
                <div class="block" style="margin-left: 20px; top: 0px;">
                    <label id="lb_account_number">Account Number</label>
                    <input type="text" name="account_number" id="account_number" style="width:120px;" maxlength="19">
                </div>
                <div class="block" style="margin-left: 20px; top: 30px;">
                    <label id="lb_account_name">Account Name</label>
                    <input type="text" name="account_name" id="account_name" style="width:250px;" maxlength="40">
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
        <fieldset style="width:400px; height: 170px; margin-left: 250px; margin-top: 180px; border: 1px solid #ddd; background-color: #f6f6f6; padding:5px; position: relative;">
            <legend style="font-size: 12px; font-weight: bold; padding:0 10px">Main Contact Details</legend>
            <div style="position: relative;">
                <div class="block" style="margin-left: 20px; top: 0px;">
                    <label id="lb_contact_person">Name</label>
                    <input type="text" name="contact_person" id="contact_person" style="width:150px;" maxlength="40" >
                </div>
                <div class="block" style="margin-left: 20px; top: 30px;">
                    <label id="lb_position">Position</label>
                    <input type="text" name="position" id="position" style="width:150px;" maxlength="30">
                </div>
                <div class="block" style="margin-left: 20px; top: 60px;">
                    <label id="lb_contact_number">Contact Number</label>
                    <input type="text" name="contact_number" id="contact_number" maxlength="15" style="width:100px;">
                </div>
                <div class="block" style="margin-left: 20px; top: 90px;">
                    <label id="lb_email">Email</label>
                    <input type="text" name="email" id="email" maxlength="30" style="width:150px;">
                </div>
                <div class="block" style="margin-left: 20px; top: 120px;">
                    <label id="lb_fax">Fax</label>
                    <input type="text" name="fax" id="fax" maxlength="15" style="width:100px;">
                </div>
            </div>
        </fieldset>
    </div>
    <div id="tabs_2">
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
                    <label id="lb_hd_mobile">Mobile</label>
                    <input type="text" name="hd_mobile" id="hd_mobile" maxlength="15" style="width: 120px;">
                </div>
            </div>
        </fieldset>
        <div style="text-align: center; position: relative; margin-top: 250px;">
            <input type="button" name="hd_save" id="hd_save" value="New" style="width:100px;" onclick="NewAddress()">
            <input type="button" name="hd_clear" id="hd_clear" value="Clear" style="width:100px;" onclick="ClearAddress()">
            <input type="button" name="hd_cancel" id="hd_cancel" value="Cancel" style="width:100px;" onclick="CancelAddress()">
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
                    <tbody id="displayListAddress">
                    </tbody>
                </table>
            </div>
            <input type="hidden" name="hd_AddressID" id="hd_AddressID" value="">
            <input type="hidden" name="hd_AddressMode" id="hd_AddressMode" value="">
        </fieldset>
    </div>
    <div id="tabs_3">
        <fieldset style="width:800px; height: 60px; margin-left:30px; margin-top: 0px; border: 1px solid #ddd; background-color: #f6f6f6; padding:5px;"  >
            <legend style="font-size: 12px; font-weight: bold; padding:0 10px">Method</legend>
            <div style="position: relative;">
                <div class="block" style="margin-left: 20px; top: 0px;">
                    <label id="lb_hd_shipping_method">Shipping Method</label>
                    <select name="hd_shipping_method" id="hd_shipping_method">
                    </select>
                </div>
                <div class="block" style="margin-left: 450px; top: 0px;">
                    <label id="lb_hd_payment_method">Payment Method</label>
                    <select name="hd_payment_method" id="hd_payment_method">
                    </select>
                </div>
            </div>
        </fieldset>
        <fieldset style="width:390px; height: 170px; margin-left: 30px; margin-top: 10px; border: 1px solid #ddd; background-color: #f6f6f6; padding:5px; position: absolute;">
            <legend style="font-size: 12px; font-weight: bold; padding:0 10px">Terms of Credit</legend>
            <div style="position: relative;">
                <div class="block" style="margin-left: 20px; top: 0px;">
                    <label id="lb_hd_net_due">Net Due</label>
                    <input type="text" name="hd_net_due" id="hd_net_due" style="width:100px;" maxlength="3">
                </div>
                <div class="block" style="margin-left: 20px; top: 30px;">
                    <label id="lb_hd_discount">Discount</label>
                    <input type="text" name="hd_discount" id="hd_discount" style="width:100px;" maxlength="3">
                </div>
                <div class="block" style="margin-left: 20px; top: 60px;">
                    <label id="lb_hd_percentage">Percentage</label>
                    <input type="text" name="hd_percentage" id="hd_percentage" style="width:100px;" maxlength="3">
                </div>
                <div class="block" style="margin-left: 20px; top: 90px;">
                    <label id="lb_hd_credit_limit">Credit Limit</label>
                    <input type="text" name="hd_credit_limit" id="hd_credit_limit" style="width:100px;" maxlength="10" >
                </div>
            </div>
        </fieldset>
        <fieldset style="width:390px; height: 170px; margin-left: 30px; margin-top: 10px; border: 1px solid #ddd; background-color: #f6f6f6; padding:5px; position: absolute; margin-left: 440px;">
            <legend style="font-size: 12px; font-weight: bold; padding:0 10px">General Ledger</legend>
            <div style="position: relative;">
                <div class="block" style="margin-left: 20px; top: 0px;">
                    <label id="lb_hd_payable_gl">Payable GL</label>
                    <select name="hd_payable_gl" id="hd_payable_gl">
                    </select>
                </div>
                <div class="block" style="margin-left: 20px; top: 30px;">
                    <label id="lb_hd_discount_gl">Discount GL</label>
                    <select name="hd_discount_gl" id="hd_discount_gl">
                    </select>
                </div>
                <div class="block" style="margin-left: 20px; top: 60px;">
                    <label id="lb_hd_tax_gl">Tax GL</label>
                    <select name="hd_tax_gl" id="hd_tax_gl">
                    </select>
                </div>
                <div class="block" style="margin-left: 20px; top: 90px;">
                    <label id="lb_hd_surcharge_gl">Surcharge GL</label>
                    <select name="hd_surcharge_gl" id="hd_surcharge_gl">
                    </select>
                </div>
            </div>
        </fieldset>
        <div style="text-align: center; position: relative; margin-top: 200px;">
            <input type="button" name="hd_savePurchase" id="hd_savePurchase" value="New" style="width:100px;" onclick="NewPurchase()">
            <input type="button" name="hd_clearPurchase" id="hd_clearPurchase" value="Clear" style="width:100px;" onclick="ClearPurchase()">
            <input type="button" name="hd_cancelPurchase" id="hd_cancelPurchase" value="Cancel" style="width:100px;" onclick="CancelPurchase()">
        </div>
        <fieldset style="width:840px; height: 160px; margin-left:30px; margin-top: 0px; border: 1px solid #ddd; background-color: #f6f6f6; padding:5px; position: absolute;">
            <legend style="font-size: 12px; font-weight: bold; padding:0 10px">List</legend>
            <div class="component1" style="width:100%; float:left; padding:0px; overflow: auto; height: 150px;">
                <table>
                    <thead>
                        <tr>
                            <th style="text-align:center; width: 45%">Shipping Method</th>
                            <th style="text-align:center; width: 40%">Payment Method</th>
                            <th style="text-align:center; width: 15%">Action</th>
                        </tr>
                    </thead>
                    <tbody id="displayListPurchase">
                    </tbody>
                </table>
            </div>
        </fieldset>
        <input type="hidden" name="hd_PurchaseID" id="hd_PurchaseID" value="">
        <input type="hidden" name="hd_PurchaseMode" id="hd_PurchaseMode" value="">
    </div>
    <div id="tabs_4">
        <div class="component1" style="width:100%; height:400px; float:left; padding:0px; overflow: auto;">
        <table>
            <thead>
                <tr>
                    <th style="text-align:center; width: 10%">Record Date</th>
                    <th style="text-align:center; width: 10%">Invoice Number</th>
                    <th style="text-align:center; width: 10%">Purchase ID</th>
                    <th style="text-align:center; width: 10%">Receive ID</th>
                    <th style="text-align:center; width: 10%">Product ID</th>
                    <th style="text-align:center; ">Description</th>
                    <th style="text-align:center; width: 10%">Quantity</th>
                </tr>
            </thead>
            <tbody id="displayList">
            </tbody>
        </table><br>
        </div>
    </div>
</div>
<%@include file="product_supplier_jsfunction.jsp"%>
<%@include file="../footer.jsp"%>