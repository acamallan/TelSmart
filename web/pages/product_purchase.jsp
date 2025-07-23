<%@include file="../header.jsp"%>

<%
/* No need to put String as variables already initialize */
table = "was_product_purchase_header";
fields = "purchase_id as rowid, purchase_id, supplier_id, record_date, userid, invoice_number, status, transaction_id";
where = "purchase_id";
orderby = "purchase_id desc";
/*used in Add New*/
enableFields = "invoice_number, supplier_id, status";
/*used in Amend*/
amendableFields = "invoice_number, supplier_id, status";
requiredFields = "supplier_id, status";
/*End here*/

pageMode = "N,E,D";

String title = "Purchase Order";
%>
<%@include file="../common/sidefind.jsp"%>
<div style="margin-left: 100px; top:0px;">
    <input type="button" tabindex="-1" name="hd_btnJournal" id="hd_btnJournal" value="Journal" style="width:100px;" onclick=''>
</div>
<fieldset style="width:950px; height: 87%; margin: auto; margin-top: 0px; border: 1px solid #ddd; background-color: #f6f6f6; padding:5px;"  >
    <legend style="font-size: 12px; font-weight: bold; padding:0 10px"><%= title %></legend>
    <input type="hidden" name="transaction_id" id="transaction_id">
    <div style="position: relative;">
        <div class="block" style="margin-left: 20px; top: 0px;">
            <label id="lb_purchase_id">Purchase ID</label>
            <input type="text" tabindex="1" name="purchase_id" id="purchase_id" style="width:80px;">
        </div>
        <div class="block" style="margin-left: 20px; top: 30px;">
            <label id="lb_invoice_number">Invoice Number</label>
            <input type="text" tabindex="2" name="invoice_number" id="invoice_number" style="width:80px;" maxlength="10">
        </div>
        <div class="block" style="margin-left: 20px; top: 60px;">
            <label id="lb_supplier_id">Supplier</label>
            <select tabindex="3" name="supplier_id" id="supplier_id">
            </select>
        </div>
        <div class="block" style="margin-left: 20px; top: 90px;">
            <label id="lb_status">Status</label>
            <select tabindex="3" name="status" id="status">
            </select>
        </div>
     
        <div class="block" style="margin-left: 330px; top: 57px;">
            <input type="button" tabindex="4" name="hd_addSuplierbtn" id="hd_addSuplierbtn" value="Add Supplier" style="width:100px;" onclick="">
        </div>
        <div class="block" style="margin-left: 450px; top: 00px; float:right">
            <label id="lb_record_date">Record date</label>
            <input type="text" tabindex="5" name="record_date" id="record_date" style="width:80px;">
        </div>
        <div class="block" style="margin-left: 450px; top: 30px;">
            <label id="lb_userid">Order By</label>
            <input type="text" tabindex="6" name="userid" id="userid" style="width:80px;">
        </div>
        <div class="block" style="margin-left: 650px; top: 30px;">
            <input type="text" tabindex="7" name="hd_username" id="hd_username" style="width:80px;">
        </div>
        <div class="component1" style="width:100%; height:400px; float:left; padding:0px; overflow: auto; margin-top:140px;">
        <table>
            <thead>
                <tr>
                    <th style="text-align:center; width: 10%">Product ID</th>
                    <th style="text-align:center; ">Description</th>
                    <th style="text-align:center;">Quantity</th>
                    <th style="text-align:center; width: 10%">Cost Price</th>
                    <th style="text-align:center; width: 10%">Amount</th>
                </tr>
            </thead>
            <tbody id="displayList">
            </tbody>
        </table>
        <table>
            <tr> 
                <td style="border:none; padding: 5px; width:80%" id="tdentry"></td>
                <td style="border:none; padding: 5px; width:10%; font-weight: bold;">Total Amount: </td>
                <td style="border:none; padding: 5px; width:10%;  font-weight: bold; padding-left: 8px;" id="TotalAmount"></td>
            </tr>
	</table>
            
        </div>
        <input type="hidden" name="strCounter" id="strCounter" value="1">
        <input type="hidden" name="strProdID" id="strProdID" value="">
        <input type="hidden" name="prevSupplierID" id="prevSupplierID" value="">
    </div>
</fieldset>
                
<%@include file="product_purchase_jsfunction.jsp"%>
<%@include file="../footer.jsp"%>