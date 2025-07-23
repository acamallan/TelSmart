<%@include file="../header.jsp"%>
<%@include file="../functions/record_function.jsp"%>

 <div id="tabs" style="position:relative; z-index:0;">
    <ul>
        <li><a oncontextmenu="return false;" href="#tabs_1">Add Customer</a></li>
        <li><a oncontextmenu="return false;" href="#tabs_2">Add Card</a></li>
        <li><a oncontextmenu="return false;" href="#tabs_3">Customer List</a></li>
        <li><a oncontextmenu="return false;" href="#tabs_4">Customer Info</a></li>
        <li><a oncontextmenu="return false;" href="#tabs_5">Top Up</a></li>
        <li><a oncontextmenu="return false;" href="#tabs_6">Supplier Information</a></li>
    </ul>
     <div id="tabs_1">
        <fieldset style="width:850px; height:250px; margin: auto; margin-top: 10px; border: 1px solid #ddd; background-color: #f6f6f6; padding:20px;"  >
        <legend style="font-size: 12px; font-weight: bold; padding:0 10px">Customer Information</legend>
                <div class="block" style="margin-left: 50px; top: 90px;">
                    <label id="lb_add_customer_id">Customer ID</label>
                    <input type="text" name="add_customer_id" id="add_customer_id" value="" style="width:100px;" disabled>
                </div>
                <div class="block" style="margin-left: 400px; top: 90px;">
                    <label id="lb_add_customer_id">Record date</label>
                    <input type="text" name="add_record_date" id="add_record_date" value="" style="width:100px;" disabled>
                </div>
                <div class="block" style="margin-left: 50px; top: 120px;">
                    <label id="lb_add_first_name">First name</label>
                    <input type="text" name="add_first_name" id="add_first_name" value=""  style="width:150px;" maxlength="30">
                </div>
                <div class="block" style="margin-left: 50px; top: 150px;">
                    <label id="lb_add_last_name">Last name</label>
                    <input type="text" name="add_last_name" id="add_last_name"  value="" style="width:150px;" maxlength="30">
                </div>
                <div class="block" style="margin-left: 50px; top: 180px;" >
                    <label id="lb_add_address">Address</label>
                    <input type="text" name="add_address" id="add_address"  value="" maxlength="30">
                </div>
                <div class="block" style="margin-left: 50px; top: 210px;">
                    <label id="lb_add_phone_number">Phone</label>
                    <input type="text" name="add_phone_number" id="add_phone_number" value="" maxlength="15">
                </div>
                <div class="block" style="margin-left: 50px; top: 240px;">
                    <label id="lb_add_email">Email</label>
                    <input type="text" name="add_email" id="add_email" value="" maxlength="30">
                </div> 
                <div class="block" style="margin-left:300px; top: 290px;">
                    <input type="button" name="update" id="update" value="Update" onclick="AddCustomer()">
                </div>
                <div class="block" style="margin-left:450px; top: 290px;">
                   <input type="button" name="clear" id="clear" value="Clear" onclick="clearFields()">
                </div>
           
        </fieldset>
    </div>
    <div id="tabs_2">
        <fieldset style="width:850px; height:240px; margin: auto; margin-top: 10px; border: 1px solid #ddd; background-color: #f6f6f6; padding:20px;"  >
        <legend style="font-size: 12px; font-weight: bold; padding:0 10px">Card Information</legend>
                <div class="block" style="margin-left: 50px; top: 90px;">
                    <label id="lb_crd_card_number">Card Number</label>
                    <input type="text" name="crd_card_number" id="crd_card_number" value="" style="width:120px;" maxlength="15" onkeypress='validate(event);' onblur="LostFocus('LF_crd_card_number()');">
                </div>
                 <div class="block" style="margin-left: 500px; top: 90px;">
                    <label id="lb_crd_effective_date">Effective date</label>
                    <input type="text" name="crd_effective_date" id="crd_effective_date" disabled value="<%= CurrentDate() %>" style="width:100px;">
                </div>
                <div class="block" style="margin-left: 50px; top: 120px;">
                    <label id="lb_crd_customer_id">Customer ID</label>
                    <input type="text" name="crd_customer_id" id="crd_customer_id" value="" disabled style="width:150px;" onblur="LF_company_name()">
                </div>
                <div class="block" style="margin-left: 50px; top: 150px;">
                    <label id="lb_cdr_first_name">First name</label>
                    <input type="text" name="crd_first_name" id="crd_first_name" value="" disabled style="width:150px;" onblur="LF_company_name()">
                </div>
                <div class="block" style="margin-left: 50px; top: 180px;">
                    <label id="lb_crd_last_name">Last name</label>
                    <input type="text" name="crd_last_name" id="crd_last_name" disabled value="" style="width:150px;">
                </div>
                <div class="block" style="margin-left: 300px; top: 220px;">
                    <label id="lb_crd_amount" style="font-size: 16px; font-weight: bold;">Amount</label>
                    <input type="text" name="crd_amount" id="crd_amount" value="1000.00" maxlength="10" style="width:100px; font-size: 16px; font-weight: bold; color:#006621;" onkeypress='validate(event);' onblur="formatDecimal(this);">
                </div>
                <div class="block" style="margin-left:380px; top: 280px;">
                    <input type="button" name="load" id="load" value="Load" onclick="Load()">
                </div>
        </fieldset>
    </div>
    <div id="tabs_3">
        <fieldset style="width:850px; margin: auto; margin-top: 10px; border: 1px solid #ddd; background-color: #f6f6f6; padding:20px;"  >
        <legend style="font-size: 12px; font-weight: bold; padding:0 10px">Customer List</legend>
        &nbsp;&nbsp;Find: <input type="text" name="btnFind" id="btnFind" style="width:150px;" onkeyup="load_customer_list(this.value)">
            <div class="component">
		<table>
                    <thead>
			<tr>
                            <th>Customer ID</th>
                            <th>First name</th>
                            <th>Last name</th>
                            <th style="width:10%">Action</th>
                        </tr>
                    </thead>
                    <tbody id="displaylist">
                    <%
                    Connection conn = DBConnection();
                    PreparedStatement qrySelectCategory = conn.prepareStatement("SELECT * FROM was_customer_info order by customer_id");
                    ResultSet strQueryCategory = qrySelectCategory.executeQuery();
                    while(strQueryCategory.next()){
                    %>
                        <tr>
                            <td><%= strQueryCategory.getString("customer_id") %></td>
                            <td><%= strQueryCategory.getString("first_name") %></td>
                            <td><%= strQueryCategory.getString("last_name") %></td>
                            <td style="text-align:right"><a oncontextmenu="return false;" href="#" class="action" id="view" onclick="view_customer_info('<%= strQueryCategory.getString("customer_id") %>')" ><span class="typcn typcn-pencil" title="Edit"></span>View</a></td>
                        </tr>
                     <%}%>
                    </tbody>
		</table>
            </div>
        </fieldset>
    </div>
    <div id="tabs_4">
        <fieldset style="width:850px; height:200px; margin: auto; margin-top: 10px; border: 1px solid #ddd; background-color: #f6f6f6; padding:20px;"  >
        <legend style="font-size: 12px; font-weight: bold; padding:0 10px">Customer Information</legend>
                <div class="block" style="margin-left: 50px; top: 90px;">
                    <label id="lb_info_card_number">Card Number</label>
                    <input type="text" name="info_card_number" id="info_card_number" value="" style="width:100px;" disabled>
                </div>
                <div class="block" style="margin-left: 50px; top: 120px;">
                    <label id="lb_info_customer_id">Customer ID</label>
                    <input type="text" name="info_customer_id" id="info_customer_id" value="" disabled style="width:150px;" onblur="LF_company_name()">
                </div>
                <div class="block" style="margin-left: 50px; top: 150px;">
                    <label id="lb_info_first_name">First name</label>
                    <input type="text" name="info_first_name" id="info_first_name" value="" disabled style="width:150px;" onblur="LF_company_name()">
                </div>
                <div class="block" style="margin-left: 50px; top: 180px;">
                    <label id="lb_info_last_name">Last name</label>
                    <input type="text" name="info_last_name" id="info_last_name" disabled value="" style="width:150px;">
                </div>
                <div class="block" style="margin-left: 50px; top: 210px;" >
                    <label id="lb_info_address">Address</label>
                    <input type="text" name="info_address" id="info_address" disabled value="">
                </div>
                <div class="block" style="margin-left: 50px; top: 240px;">
                    <label id="lb_info_phone_number">Phone</label>
                    <input type="text" name="info_phone_number" id="info_phone_number" disabled value="">
                </div>
                <div class="block" style="margin-left: 50px; top: 2700px;">
                    <label id="lb_info_email">Email</label>
                    <input type="text" name="info_email" id="info_email" disabled value="">
                </div> 
                 <div class="block" style="margin-left: 480px; top: 150px;">
                    <label id="lb_info_balance" style="font-size: 16px; font-weight: bold; width:150px;">Balance Amount</label>
                    <input type="text" name="info_balance" id="info_balance" disabled value="" style="width:100px; font-size: 16px; font-weight: bold; color:#006621;"><br>
                    <input type="button" name="info_topup" id="info_topup" value="TopUp" onclick="TopUpLink()" style="margin-left: 160px;" disabled>
                </div>
        </fieldset>
        
        <fieldset style="width:400px; height:200px; margin-left:170px; top: 10px; border: 1px solid #ddd; background-color: #f6f6f6; padding:20px;position: relative;"  >
        <legend style="font-size: 12px; font-weight: bold; padding:0 10px">Financial Information</legend>
            <div class="block" style="margin-left: 50px; top: 20px;">
                <label id="lb_info_email">Bank Account</label>
                <input type="text" name="info_email" id="info_email" disabled value="1234567890" style="width:100px;">
            </div>
            <div class="block" style="margin-left: 50px; top: 50px;">
                <label id="lb_info_email">Bank Name</label>
                <input type="text" name="info_email" id="info_email" disabled value="BDO" style="width:100px;">
            </div>
            <div class="block" style="margin-left: 50px; top: 80px;">
                <label id="lb_info_email">Location</label>
                <input type="text" name="info_email" id="info_email" disabled value="50000" style="width:100px;">
            </div>
            <div class="block" style="margin-left: 50px; top: 110px;">
                <label id="lb_info_email">Credit Limit</label>
                <input type="text" name="info_email" id="info_email" disabled value="10000" style="width:100px;">
            </div>
            <div class="block" style="margin-left: 50px; top: 140px;">
                <label id="lb_info_email">Guaranty</label>
                <input type="text" name="info_email" id="info_email" disabled value="Cash" style="width:100px;">
            </div>
            <div class="block" style="margin-left: 0px; top: 170px;">
                <label id="lb_info_email" style="width:150px;">Default Payment Method</label>
                <input type="text" name="info_email" id="info_email" disabled value="Cash" style="width:100px;">
            </div>
        </fieldset>
        <fieldset style="width:390px; height:200px; margin-left:630px; margin-top: -233px; border: 1px solid #ddd; background-color: #f6f6f6; padding:20px; position: relative;"  >
        <legend style="font-size: 12px; font-weight: bold; padding:0 10px">Ledger Information</legend>
            <div class="block" style="margin-left: 50px; top: 20px;">
                <label id="lb_info_email">Default Debit</label>
                <input type="text" name="info_email" id="info_email" disabled value="5000" style="width:80px;">
            </div>
            <div class="block" style="margin-left: 0px; top: 50px;">
                <label id="lb_info_email" style="width:150px;">Default Revenue code</label>
                <input type="text" name="info_email" id="info_email" disabled value="101" style="width:80px;">
            </div>
            <div class="block" style="margin-left: 50px; top: 80px;">
                <label id="lb_info_email">Discount Code</label>
                <input type="text" name="info_email" id="info_email" disabled value="CD101" style="width:80px;">
            </div>
            <div class="block" style="margin-left: 50px; top: 110px;">
                <label id="lb_info_email">Discount Rate</label>
                <input type="text" name="info_email" id="info_email" disabled value="10" style="width:80px;">
            </div>
            <div class="block" style="margin-left: 50px; top: 140px;">
                <label id="lb_info_email">Tax Code</label>
                <input type="text" name="info_email" id="info_email" disabled value="120" style="width:80px;">
            </div>
        </fieldset><br>
        <div class="component" style="width:80%; margin: auto; height: 100%;">
            <table>
                <thead>
                    <tr>
                        <th>Record Date</th>
                        <th>Transaction ID</th>
                        <th>Card Number</th>
                        <th>Transaction Type</th>
                        <th>Amount</th>
                        <th style="width:10%">Action</th>
                    </tr>
                </thead>
                <tbody id="transInfo">
                </tbody>
            </table>
        </div>
    </div>
    <div id="tabs_5">
        <fieldset style="width:850px; height:200px; margin: auto; margin-top: 10px; border: 1px solid #ddd; background-color: #f6f6f6; padding:20px;"  >
        <legend style="font-size: 12px; font-weight: bold; padding:0 10px">Top Up</legend>
            <div class="block" style="margin-left: 0px; top: 90px;">
                <label id="lb_tp_card_number">Card Number</label>
                <input type="text" name="tp_card_number" id="tp_card_number" value="" style="width:100px;" disabled>
            </div>
            <div class="block" style="margin-left: 500px; top: 90px;">
                <label id="lb_tp_amount">Enter Amount</label>
                <input type="text" name="tp_amount" id="tp_amount" value="" style="width:100px;" onkeypress='validate(event);' onblur="formatDecimal(this); addAmount();">
            </div>
            <div class="block" style="margin-left: 0px; top: 120px;">
                <label id="lb_tp_customer_id">Customer ID</label>
                <input type="text" name="tp_customer_id" id="tp_customer_id" value="" disabled style="width:150px;" onblur="LF_company_name()">
            </div>
            <div class="block" style="margin-left: 0px; top: 150px;">
                <label id="lb_tp_first_name">First name</label>
                <input type="text" name="tp_first_name" id="tp_first_name" value="" disabled style="width:150px;" onblur="LF_company_name()">
            </div>
            <div class="block" style="margin-left: 0px; top: 180px;">
                <label id="lb_tp_last_name">Last name</label>
                <input type="text" name="tp_last_name" id="tp_last_name" disabled value="" style="width:150px;">
            </div>
            <span class="block" style="margin-left: 500px; top: 120px; ">
                <label id="lb_tp_balance" style="font-size: 16px; font-weight: bold;">Balance</label>
                <input type="text" name="tp_balance" id="tp_balance" disabled value="" style="width:100px; font-size: 16px; font-weight: bold; color:#006621;">
            </span>
            <div class="block" style="margin-left:300px; top: 230px;">
                <input type="button" name="tp_topup" id="tp_topup" value="Top Up" onclick="TopUp()">
            </div>
            <div class="block" style="margin-left:450px; top: 230px;">
                <input type="button" name="tp_cancel" id="tp_cancel" value="Cancel" onclick="cancelTopup()">
            </div>
        </fieldset>
    </div>
    <div id="tabs_6">
        <fieldset style="width:400px; height:240px; margin-left:170px; margin-top: 10px; border: 1px solid #ddd; background-color: #f6f6f6; padding:20px;position: relative;"  >
        <legend style="font-size: 12px; font-weight: bold; padding:0 10px">Financial Information</legend>
            <div class="block" style="margin-left: 0px; top: 20px;">
                <label id="lb_info_email" style="width:150px;">Bank Account</label>
                <input type="text" name="info_email" id="info_email" disabled value="1234567890" style="width:100px;">
            </div>
            <div class="block" style="margin-left: 0px; top: 50px;">
                <label id="lb_info_email" style="width:150px;">Bank Name</label>
                <input type="text" name="info_email" id="info_email" disabled value="BDO" style="width:100px;">
            </div>
            <div class="block" style="margin-left: 0px; top: 80px;">
                <label id="lb_info_email" style="width:150px;">Location</label>
                <input type="text" name="info_email" id="info_email" disabled value="50000" style="width:100px;">
            </div>
            <div class="block" style="margin-left: 0px; top: 110px;">
                <label id="lb_info_email" style="width:150px;">Credit Limit</label>
                <input type="text" name="info_email" id="info_email" disabled value="10000" style="width:100px;">
            </div>
            <div class="block" style="margin-left: 0px; top: 140px;">
                <label id="lb_info_email" style="width:150px;">Default Payment Method</label>
                <input type="text" name="info_email" id="info_email" disabled value="Cash" style="width:100px;">
            </div>
        </fieldset>
        <fieldset style="width:390px; height:240px; margin-left:630px; margin-top: -282px; border: 1px solid #ddd; background-color: #f6f6f6; padding:20px; position: relative;"  >
        <legend style="font-size: 12px; font-weight: bold; padding:0 10px">Ledger Information</legend>
            <div class="block" style="margin-left: 0px; top: 20px;">
                <label id="lb_info_email" style="width:150px;">Default Purchase code</label>
                <input type="text" name="info_email" id="info_email" disabled value="1200" style="width:80px;">
            </div>
            <div class="block" style="margin-left: 0px; top: 50px;">
                <label id="lb_info_email" style="width:150px;">Default Credit</label>
                <input type="text" name="info_email" id="info_email" disabled value="1000" style="width:80px;">
            </div>
            <div class="block" style="margin-left: 0px; top: 80px;">
                <label id="lb_info_email" style="width:150px;">Discount Code</label>
                <input type="text" name="info_email" id="info_email" disabled value="CD101" style="width:80px;">
            </div>
            <div class="block" style="margin-left: 0px; top: 110px;">
                <label id="lb_info_email" style="width:150px;">Discount Rate</label>
                <input type="text" name="info_email" id="info_email" disabled value="10" style="width:80px;">
            </div>
            <div class="block" style="margin-left: 0px; top: 140px;">
                <label id="lb_info_email" style="width:150px;">Commission Code</label>
                <input type="text" name="info_email" id="info_email" disabled value="120" style="width:80px;">
            </div>
            <div class="block" style="margin-left: 0px; top: 170px;">
                <label id="lb_info_email" style="width:150px;">Commission Rate</label>
                <input type="text" name="info_email" id="info_email" disabled value="10" style="width:80px;">
            </div>
            <div class="block" style="margin-left: 0px; top: 200px;">
                <label id="lb_info_email" style="width:150px;">Tax Code</label>
                <input type="text" name="info_email" id="info_email" disabled value="120" style="width:80px;">
            </div>
        </fieldset>
    </div>
</div>
<%@include file="point_of_sales_rpt_jsfunction.jsp"%>
<%@include file="../footer.jsp"%>



