<%@include file="../header.jsp"%>
<%@include file="../functions/record_function.jsp"%>

<%
/* No need to put String as variables already initialize */
table = "was_product_sales_invoice_header";
fields = "invoice_number as rowid, invoice_number,customer_id,sales_id,record_date,userid,due_date,payment_status,due_amount,actual_amount";
//mainWhere = "customer_id <> '0000000000'";
where = "invoice_number";
orderby = "to_date(record_date) desc, sales_id desc";
/*used in Add New*/
enableFields = "invoice_number, customer_id,due_date";
/*used in Amend*/
amendableFields = "invoice_number, customer_id,due_date";
requiredFields = "invoice_number, customer_id,sales_id,due_date";

pageMode = "N,E,D";
/*End here*/

String title = "Sales Order";

%>
<%@include file="../common/sidefind.jsp"%>
<div style="margin-left: 100px; top:0px; display:none;">
    <input type="button" name="hd_btnJournal" id="hd_btnJournal" value="Journal" style="width:100px;" onclick=''>
    <input type="button" name="hd_btnPrint" id="hd_btnPrint" value="Print" style="width:100px; margin-left: -8px;" onclick="">
</div>
<fieldset style="width:940px; height: 505px; margin: auto; margin-top: 0px; border: 1px solid #ddd; background-color: #f6f6f6; padding:10px;"  >
    <legend style="font-size: 12px; font-weight: bold; padding:0 10px"><%= title %></legend>
    <div style="position: relative;">
        <input type="hidden" name="due_amount" id="due_amount">
        <input type="hidden" name="actual_amount" id="actual_amount">
        <div class="block" style="margin-left: 20px; top: 0px;">
            <label id="lb_invoice_number">Invoice Number</label>
            <input type="text" name="invoice_number" id="invoice_number" style="width:80px;" maxlength="10">
        </div>
        <div class="block" style="margin-left: 20px; top: 30px;">
            <label id="lb_customer_id">Customer ID</label>
            <input type="text" name="customer_id" id="customer_id" style="width:80px;" maxlength="10" onblur="LostFocus('LF_customer_id()');">
        </div>
        <div class="block" style="margin-left: 220px; top: 30px;">
            <input type="text" name="hd_name" id="hd_name" style="width:120px;">
        </div>
        <div class="block" style="margin-left: 20px; top: 60px;">
            <label id="lb_sales_id">Sales Order</label>
            <select name="sales_id" id="sales_id" onblur="LostFocus('LF_sales_id()');">
            </select>
        </div>
        <div class="block" style="margin-left: 20px; top: 90px;">
            <label id="lb_payment_status">Payment Status</label>
            <select name="payment_status" id="payment_status">
            </select>
        </div>
        <div class="block" style="margin-left: 450px; top: 0px; float:right">
            <label id="lb_record_date">Record date</label>
            <input type="text" name="record_date" id="record_date" style="width:80px;">
        </div>
        <div class="block" style="margin-left: 450px; top: 30px;">
            <label id="lb_userid">Order By</label>
            <input type="text" name="userid" id="userid" style="width:80px;">
        </div>
        <div class="block" style="margin-left: 450px; top: 60px; float:right">
            <label id="lb_due_date">Due date</label>
            <input type="text" name="due_date" id="due_date" style="width:80px;">
        </div>
        <div class="block" style="margin-left: 650px; top: 30px;">
            <input type="text" name="hd_username" id="hd_username" style="width:80px;">
        </div>
        <div class="component1" style="width:100%; height:390px; float:left; padding:0px; overflow: auto; margin-top:140px;">
        <table>
            <thead>
                <tr>
                    <th style="text-align:center; width: 10%">Product ID</th>
                    <th style="text-align:center;">Description</th>
                    <th style="text-align:center;">Quantity</th>
                    <th style="text-align:center; width: 12%">Selling Price</th>
                    <th style="text-align:center; width: 10%">Amount</th>
                </tr>
            </thead>
            <tbody id="displayList">
            </tbody>
        </table>
        <table>
            <tr> 
                <td style="border:none; padding: 5px; width:78%" id="tdentry"></td>
                <td style="border:none; padding: 5px; width:12%; font-weight: bold;">Total Amount:</td>
                <td style="border:none; padding: 5px; width:10%;  font-weight: bold; text-align: right; padding-right: 9px; " id="TotalAmount"></td>
            </tr>
	</table>
            
        </div>
        <input type="hidden" name="strCounter" id="strCounter" value="1">
        <input type="hidden" name="strProdID" id="strProdID" value="">
        <input type="hidden" name="prevSupplierID" id="prevSupplierID" value="">
    </div>
</fieldset>
 
<%@include file="product_sales_invoice_jsfunction.jsp"%>
<%@include file="../footer.jsp"%>