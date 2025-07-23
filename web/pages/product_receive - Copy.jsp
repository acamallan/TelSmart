<%@include file="../header.jsp"%>

<%
/* No need to put String as variables already initialize */
table = "was_product_receive_header";
fields = "receive_id as rowid, receive_id, invoice_number, record_date, userid, not_invoiced, supplier_id";
where = "receive_id";
orderby = "receive_id desc";
/*used in Add New*/
enableFields = "invoice_number, not_invoiced, supplier_id";
/*used in Amend*/
amendableFields = "invoice_number, not_invoiced, supplier_id";
requiredFields = "invoice_number,supplier_id";
/*End here*/

pageMode = "N,D";

String title = "Receive Order";
%>
<%@include file="../common/sidefind.jsp"%>
<div style="margin-left: 100px; top:0px;">
    <input type="button" name="hd_btnJournal" id="hd_btnJournal" value="Journal" style="width:100px;" onclick=''>
    <input type="button" name="hd_actionPrice" id="hd_actionPrice" value="Add" style="width:100px; margin-left: -8px;" onclick="">
    <input type="button" name="hd_actionPrice" id="hd_actionPrice" value="Add" style="width:100px;" onclick="">
</div>
<fieldset style="width:950px; height: 520px; margin: auto; margin-top: 0px; border: 1px solid #ddd; background-color: #f6f6f6; padding:5px;"  >
    <legend style="font-size: 12px; font-weight: bold; padding:0 10px"><%= title %></legend>
    <div style="position: relative;">
        <div class="block" style="margin-left: 20px; top: 0px;">
            <label id="lb_receive_id">Receive ID</label>
            <input type="text" name="receive_id" id="receive_id" style="width:80px;">
        </div>
        <div class="block" style="margin-left: 20px; top: 30px;">
            <label id="lb_invoice_number">Invoice Number</label>
            <input type="text" name="invoice_number" id="invoice_number" style="width:80px;" maxlength="10">
        </div>
        <div class="block" style="margin-left: 20px; top: 60px;">
            <label id="lb_supplier_id">Supplier</label>
            <select name="supplier_id" id="supplier_id" onblur="LostFocus('LF_supplier_id()')">
            </select>
        </div>
        <div class="block" style="margin-left: 20px; top: 90px;">
            <label id="lb_invoice_number"></label>
            <input type="button" name="hd_locationbtn" id="hd_locationbtn" value="Add Location" style="width:100px;" onclick="PopUpLocation()">
        </div>
       <!-- <div class="block" style="margin-left: 20px; top: 60px;">
            <label id="lb_supplier_id">Supplier</label>
            <select name="supplier_id" id="supplier_id" >
            </select>
        </div>
        <div class="block" style="margin-left: 330px; top: 57px;">
            <input type="button" name="hd_addSuplierbtn" id="hd_addSuplierbtn" value="Add Supplier" style="width:100px;" onclick="AddSupplierBtn()">
        </div> -->
        <div class="block" style="margin-left: 450px; top: 00px; float:right">
            <label id="lb_record_date">Record date</label>
            <input type="text" name="record_date" id="record_date" style="width:80px;">
        </div>  
        <div class="block" style="margin-left: 450px; top: 30px;">
            <label id="lb_userid">Receive By</label>
            <input type="text" name="userid" id="userid" style="width:80px;">
        </div>
        <div class="block" style="margin-left: 650px; top: 30px;">
            <input type="text" name="hd_username" id="hd_username" style="width:80px;">
        </div>
        <div class="block" style="margin-left: 550px; top: 60px;">
            <input type="checkbox" name="not_invoiced" id="not_invoiced" value="1">Not Invoiced
        </div>
        
        <div id="tabs" style="position:relative; height: 90%; z-index:0; top:130px; width: 99%; float: left; margin: 0px">
            <ul style="padding-left: 2px;">
               <li><a oncontextmenu="return false;" href="#tabs_1" id="tab1" style="padding:5px; font-weight: bold;" onclick="tab1()">Against PO</a></li>
               <li><a oncontextmenu="return false;" href="#tabs_2" id="tab2" style="padding:5px; font-weight: bold;" onclick="tab2()">Batch Invoice</a></li>
               <li><a oncontextmenu="return false;" href="#tabs_3" id="tab3" style="padding:5px; font-weight: bold;" onclick="tab3()">Against Expense</a></li>
            </ul>
            <div id="tabs_1" style="height:100%; padding: 2px;">
                <div class="component1" style="width:100%; height:340px; float:left; padding:0px; overflow: auto; ">
                    <table>
                        <thead>
                            <tr>
                                <th style="text-align:center;">Purchase ID</th>
                                <th style="text-align:center;">Product ID</th>
                                <th style="text-align:center;">Description</th>
                                <th style="text-align:center;">Location</th>
                                <th style="text-align:center;">Quantity</th>
                                <th style="text-align:center;">GL Code</th>
                                <th style="text-align:center;">Cost Price</th>
                                <th style="text-align:center;">Amount</th>
                            </tr>
                        </thead>
                        <tbody id="displayList">
                        </tbody>
                    </table><br>
                    <table>
                        <tr style="background: none;">
                            <td style="border:none; padding: 5px; width:80%" id="tdentry" colspan="4"></td>
                            <td style="border:none; padding: 5px; width:10%; font-weight: bold;">Total Amount: </td>
                            <td style="border:none; padding: 5px; width:10%;  font-weight: bold; padding-left: 8px;" id="TotalAmount"></td>
                        </tr>
                    </table>
                </div>
                <input type="hidden" name="strCounter" id="strCounter" value="1">
                <input type="hidden" name="strCompleteCount" id="strCompleteCount" value="">
            </div>
            <div id="tabs_2" style="height:100%; padding: 2px;">
                <div class="component1" style="width:100%; height:340px; float:left; padding:0px; overflow: auto; ">
                    <table>
                        <thead>
                            <tr>
                                <th style="text-align:center;">Purchase ID</th>
                                <th style="text-align:center;">Product ID</th>
                                <th style="text-align:center;">Description</th>
                                <th style="text-align:center;">Location</th>
                                <th style="text-align:center;">Quantity</th>
                                <th style="text-align:center;">GL Code</th>
                                <th style="text-align:center;">Cost Price</th>
                                <th style="text-align:center;">Amount</th>
                            </tr>
                        </thead>
                        <tbody id="displayList_2">
                        </tbody>
                    </table><br>
                    <table>
                        <tr style="background: none;"> 
                            <td style="border:none; padding: 5px; width:80%" id="tdentry_2" colspan="4"></td>
                            <td style="border:none; padding: 5px; width:10%; font-weight: bold;">Total Amount: </td>
                            <td style="border:none; padding: 5px; width:10%;  font-weight: bold; padding-left: 8px;" id="TotalAmount_2"></td>
                        </tr>
                    </table>
                </div>
                <input type="hidden" name="strCounter_2" id="strCounter_2" value="1">
                <input type="hidden" name="strCompleteCount_2" id="strCompleteCount_2" value="">
            </div>
            <div id="tabs_3" style="height:100%; padding: 2px;">
                <div class="component1" style="width:100%; height:340px; float:left; padding:0px; overflow: auto; ">
                    <table>
                        <thead>
                            <tr>
                                <th style="text-align:center;">Purchase ID</th>
                                <th style="text-align:center;">Product ID</th>
                                <th style="text-align:center;">Description</th>
                                <th style="text-align:center;">Location</th>
                                <th style="text-align:center;">Quantity</th>
                                <th style="text-align:center;">GL Code</th>
                                <th style="text-align:center;">Cost Price</th>
                                <th style="text-align:center;">Amount</th>
                            </tr>
                        </thead>
                        <tbody id="displayList_3">
                        </tbody>
                    </table><br>
                    <table>
                        <tr style="background: none;"> 
                            <td style="border:none; padding: 5px; width:80%" id="tdentry_3" colspan="4"></td>
                            <td style="border:none; padding: 5px; width:10%; font-weight: bold;">Total Amount: </td>
                            <td style="border:none; padding: 5px; width:10%;  font-weight: bold; padding-left: 8px;" id="TotalAmount_3"></td>
                        </tr>
                    </table>
                </div>
                <input type="hidden" name="strCounter_3" id="strCounter_3" value="1">
                <input type="hidden" name="strCompleteCount_3" id="strCompleteCount_3" value="">
            </div>
        </div>
</fieldset>
 
<!-- Popup Location -->
<div id="dialog" title="Location" style="display: none; width: 400px;">
  <div class="block" style="margin-left: -20px; top: 30px;">
        <label id="lb_hd_supplier_id">Location ID</label>
        <input type="text" name="hd_location_id" id="hd_location_id" style="width:100px;" disabled>
    </div>
    <div class="block" style="margin-left: 200px; top: 30px;">
        <label id="lb_hd_company_name">Location Name</label>
        <input type="text" name="hd_location_name" id="hd_location_name" style="width:150px;">
    </div>
    <div class="block" style="margin-left: 500px; top: 25px;">
        <input type="button" name="hd_addLocInfo" id="hd_addLocInfo" value="Save" style="width:100px;" onclick="PopUpSaveLocation()">
    </div>
    <div style="height: 380px; border: 1px solid #F2F2F2; width: 98%; overflow: auto;  padding:5px; margin-left: 5px; top: 60px; position: relative;" class="component1">
        <table style="padding:0px;">
            <thead>
                <tr>
                    <th style=" text-align:center; width: 10%">ID</th>
                    <th style=" text-align:center; width: 60%">Location</th>
                    <th style=" text-align:center; width: 35%">Action</th>
                </tr>
            </thead>
            <tbody id="displayLocation">
            </tbody>
        </table>
        <input type="hidden" name="strCounterLoc" id="strCounterLoc" value="0">
    </div>
</div>
<%@include file="product_receive_jsfunction.jsp"%>
<%@include file="../footer.jsp"%>