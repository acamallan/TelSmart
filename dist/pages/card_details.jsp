<%@include file="../header.jsp"%>
<%@include file="../functions/record_function.jsp"%>

<%
/* No need to put String as variables already initialize */
table = "was_card_details";
fields = "card_number as rowid,card_number,link_number,card_type,card_status,record_date,record_time,expiry_date";
where = "card_number";
/*used in Add New*/
enableFields = "card_type,card_status,expiry_date";
/*used in Amend*/
amendableFields = "card_type,card_status,expiry_date";
requiredFields = "card_type,card_status,expiry_date";

pageMode = "E";
/*End here*/

%>
<%@include file="../common/sidefind.jsp"%>
<div id="tabs" style="position:relative; height: 93%; z-index:0; width: 950px; float: left; margin: 0px 5px 5px 5px;">
     <ul style="padding-left: 2px;">
        <li><a oncontextmenu="return false;" href="#tabs_1" style="padding:8px 20px; font-weight: bold; white-space: normal; vertical-align:middle;" onclick="tab1()"> Details </a></li>
        <li><a oncontextmenu="return false;" href="#tabs_2" id="tab2" style="padding:8px 20px; font-weight: bold;" onclick="tab2()"> History </a></li>
        <li><a oncontextmenu="return false;" href="#tabs_3" id="tab3" style="padding:8px 20px; font-weight: bold;" onclick="tab3()"> Customer Info </a></li>
        <li><a oncontextmenu="return false;" href="#tabs_4" id="tab4" style="padding:8px 20px; font-weight: bold;" onclick="tab4()"> Transaction History </a></li>
    </ul>
    <div id="tabs_1">
        <fieldset style="width:850px; height:150px; margin: auto; margin-top: 14px; border: 1px solid #ddd; background-color: #f6f6f6; padding:20px;"  >
            <legend style="font-size: 12px; font-weight: bold; padding:0 10px">Card Details</legend>
            <div style="position: relative;">
                <div class="block" style="margin-left: 100px; top: 0px;">
                    <label id="lb_card_number">Card number</label>
                    <input type="text" name="card_number" id="card_number" style="width:120px;">
                </div>
                <div class="block" style="margin-left: 100px; top: 30px;">
                    <label id="lb_link_number">Link number</label>
                    <input type="text" name="link_number" id="link_number" style="width:120px;">
                </div>
                <div class="block" style="margin-left: 100px; top: 60px;">
                    <label id="lb_card_type">Card type</label>
                    <select name='card_type' id='card_type'>
                    </select>
                </div>
                <div class="block" style="margin-left: 100px; top: 90px;">
                    <label id="lb_card_status">Card status</label>
                    <select name='card_status' id='card_status'>
                    </select>
                </div>
                <div class="block" style="margin-left: 500px; top: 0px;">
                    <label id="lb_record_date">Record date</label>
                    <input type="text" name="record_date" id="record_date" style="width:80px;">
                </div>
                <div class="block" style="margin-left: 500px; top: 30px;">
                    <label id="lb_record_time">Record time</label>
                    <input type="text" name="record_time" id="record_time" style="width:80px;"  maxlength="10" onblur="checkDate(this)">
                </div>
                <div class="block" style="margin-left: 500px; top: 60px;">
                    <label id="lb_expiry_date">Expiry date</label>
                    <input type="text" name="expiry_date" id="expiry_date" style="width:80px;" maxlength="10" onblur="checkDate(this)">
                </div>
            </div>
        </fieldset>
    </div>
    <div id="tabs_2">
        <div class="component1" style="width:100%; height:400px; float:left; padding:0px; overflow: auto; margin-top:10px;">
            <table>
                <thead>
                    <tr>
                        <th style="text-align:center; width: 10%">Card number</th>
                        <th style="text-align:center; width: 10%">Link number</th>
                        <th style="text-align:center; width: 10%">Card type</th>
                        <th style="text-align:center; width: 10%">Card status</th>
                        <th style="text-align:center; width: 10%">Record date</th>
                        <th style="text-align:center; width: 10%">Record time</th>
                        <th style="text-align:center; width: 10%">Expiry date</th>
                    </tr>
                </thead>
                <tbody id="displayList">
                </tbody>
            </table>
        </div>
    </div>
    <div id="tabs_3">
        <fieldset style="width:850px; height:150px; margin: auto; margin-top: 14px; border: 1px solid #ddd; background-color: #f6f6f6; padding:20px; position:relative;">
            <div class="block" style="margin-left: 100px; top: 20px;">
                <label id="lb_tab3_customer_id">Customer ID</label>
                <input type="text" name="hd_tab3_customer_id" id="hd_tab3_customer_id" style="width:120px;">
            </div>
            <div class="block" style="margin-left: 100px; top: 50px;">
                <label id="lb_hd_tab3_customer_name">Customer name</label>
                <input type="text" name="hd_tab3_customer_name" id="hd_tab3_customer_name" style="width:120px;">
            </div>
            <div class="block" style="margin-left: 100px; top: 80px;">
                <label id="lb_hd_tab3_gender">Gender</label>
                <input type="text" name="hd_tab3_gender" id="hd_tab3_gender" style="width:120px;">
            </div>
            <div class="block" style="margin-left: 400px; top: 20px;">
                <label id="lb_hd_tab3_account_number">Account number</label>
                <input type="text" name="hd_tab3_account_number" id="hd_tab3_account_number" style="width:120px;">
            </div>
            <div class="block" style="margin-left: 400px; top: 50px;">
                <label id="lb_hd_tab3_contact_number">Contact number</label>
                <input type="text" name="hd_tab3_contact_number" id="hd_tab3_contact_number" style="width:120px;">
            </div>
            <div class="block" style="margin-left: 400px; top: 80px;">
                <label id="lb_hd_tab3_email">Email</label>
                <input type="text" name="hd_tab3_email" id="hd_tab3_email" style="width:120px;">
            </div>
            <div class="block" style="margin-left: 200px; top: 130px;">
                <label id="lb_hd_tab3_email">Account Balance</label>
                <input type="text" name="balance" id="balance" style="width: 80px; font-size: 16px; color: green; padding: 5px;">
            </div>
        </fieldset>
    </div>
    <div id="tabs_4">
        <fieldset style="width:850px; height:400px; margin: auto; margin-top: 14px; border: 1px solid #ddd; background-color: #f6f6f6; padding:20px; position:relative;">
            <div style="position: relative; height: 100%; overflow: auto;" class="component1">
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
        </fieldset>
    </div>
</div>
<%@include file="card_details_jsfunction.jsp"%>
<%@include file="../footer.jsp"%>