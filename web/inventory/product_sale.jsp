<%@include file="../header.jsp"%>
<%@include file="../functions/record_function.jsp"%>

<%
/* No need to put String as variables already initialize */
table = "was_sale_info";
fields = "sale_id as rowid, sale_id,customer_name,total_items,grand_total,record_date";
where = "sale_id";
/*used in Add New*/
enableFields = "customer_name";
/*used in Amend*/
amendableFields = "customer_name";
requiredFields = "customer_name,total_items,grand_total,record_date";
/*End here*/

String title = "Product Sales";

%>
<%@include file="../common/sidefind.jsp"%>
<fieldset style="width:850px; margin: auto; margin-top: 12px; border: 1px solid #ddd; background-color: #f6f6f6; padding:20px;"  >
    <legend style="font-size: 14px; font-weight: bold; padding:0 10px"><%= title %></legend>
	<form action="" method="post" name="WASForm" id="WASForm" autocomplete="off">
            <div class="input-w" style="position: relative; margin-left:100px;">
                <label id="lb_sale_id">Sales ID</label>
                <input type="text" name="sale_id" id="sale_id" required style="width:80px; align:left;" disabled>
            </div><br>
            <div class="input-w" style="position: relative; margin-left:48px; top:-10px">
                <label id="lb_customer_name">Customer Name</label>
                <input type="text" name="customer_name" id="customer_name">
            </div>
            <div class="input-w" style="position: relative;  margin-left: 58px; top: -10px;">
                <label id="lb_avail_stocks">Available Stock</label>
                <input type="text" name="hd_avail_stocks" id="hd_avail_stocks" style="width:80px;" disabled>
            </div>
            
            <div class="input-w" style="position: relative; margin-left: 545px; top: -120px;">
                <label id="lb_record_date">Record date</label>
                <input type="text" name="record_date" id="record_date" style="width:80px;" value="" disabled>
            </div>
            <div class="input-w" style="position: relative; margin-left: 550px; top: -120px;">
                <label id="lb_total_items">Total Items</label>
                <input type="text" name="total_items" id="total_items" style="width:80px; align:left;" disabled>
            </div>
            
            <div class="input-w" style="position: relative; margin-left: 502px; top: -120px;">
                <label id="lb_grand_total">Grand Total Amount</label>
                <input type="text" name="grand_total" id="grand_total" style="width:80px;" disabled>
            </div> 
            <div class="input-w" style="position: relative; margin-left: 780px; top: -100px;">
                <input type="button" name="hd_amend" id="hd_amend" value="Amend" style="width:80px;" disabled onclick="AmendBody()">
            </div>
	<div class="component1" style="width:850px; margin-top: -100px;">
            <table>
                <thead>
                    <tr>
                        <th >Product Name</th>
			<th style=" text-align:center;" >Price</th>
			<th style="text-align:center;">Quantity</th>
			<th style=" text-align:center;">Total</th>
			<th style="">Discount</th>
			<th style=" text-align:center;" >Discount Aount</th>
			<th style="text-align:center; width: 100px;">Total Amount</th>
                    </tr>
		</thead>
                <%
                    Connection conn = DBConnection();
                    PreparedStatement qrySelectProductHd = conn.prepareStatement("SELECT item.product_id, item.product_name FROM wasi_product item, wasi_product_purchase purch where item.product_id = purch.product_id order by item.product_name");
                    ResultSet strQueryProductHd = qrySelectProductHd.executeQuery();
                    String strOptionHd = "";
                    while(strQueryProductHd.next()){
                        strOptionHd = strOptionHd +"<option value="+strQueryProductHd.getString("product_id")+">"+strQueryProductHd.getString("product_name")+"</option>";
                    }
                    String strJournalEntry = "<select name='dynfields' id='product_id[counter]' onblur='LF_product_id(counter)' required><option value=''> </option> "+ strOptionHd + "</select>";
                    %>
		<tbody id="prodSale">
                    
                    <tr id="trSale[1]">
                        <td style="padding:3px">
                            
                            <select name='dynfields' id='product_id[1]' onblur='LostFocus("LF_product_id(1)")'>
                                <option value=""></option>
                                <%
                                PreparedStatement qrySelectProduct = conn.prepareStatement("SELECT item.product_id, item.product_name FROM wasi_product item, wasi_product_purchase purch where item.product_id = purch.product_id order by item.product_name");
                                ResultSet strQueryProduct = qrySelectProduct.executeQuery();
                                while(strQueryProduct.next()){%>
                                    <option value="<%= strQueryProduct.getString("product_id") %>"><%= strQueryProduct.getString("product_name") %></option>
                                <%}%>
                            </select>
			</td>
			<td>
                            <input type="text" name="dynfields" value="" id="price[1]" style="width:80px; ;text-align: right;" disabled>
			</td>
			<td>
                            <input type="text" name="dynfields" value="" id="quantity[1]" style="width:80px;" onkeypress="validate(event)" required onblur="totalItems(1)"  >
			</td>
			<td>
                            <input type="text" name="dynfields" value="" id="total[1]" style="width:80px;" required disabled>
			</td>
			<td>
                            <input type="text" name="dynfields" value="0" id="discount[1]" style="width:80px;" onkeypress="validate(event)" required onblur="totalAmount(1); empAvailStock();"  >
			</td>
			<td>
                            <input type="text" name="dynfields" value="" id="discount_amount[1]" style="width:80px;text-align: right;" disabled>
			</td>
			<td>
                            <input type="text" name="dynfields" value="" id="total_amount[1]" style="width:80px;text-align: right;" disabled>
			</td>
                    </tr>
		</tbody>
            </table>
	<table>
            <tr id="trentry">
                
            </tr>
	</table> 
    </div>
    <input type="hidden" name="strSelectOpt" id="strSelectOpt" value="<%= strJournalEntry %>">
	<input type="hidden" name="strCounter" id="strCounter" value="1">
    </form>
</fieldset>
 
<%@include file="product_sale_jsfunction.jsp"%>
<%@include file="../footer.jsp"%>