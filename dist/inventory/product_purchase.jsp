<%@include file="../header.jsp"%>
<%@include file="../functions/record_function.jsp"%>

<%
/* No need to put String as variables already initialize */
table = "wasi_product_purchase";
fields = "product_in_id as rowid, product_id,record_date,supplier,quantity,note,cost_price,total_price";
where = "product_in_id";
/*used in Add New*/
enableFields = "product_id,record_date,supplier,quantity,note,cost_price";
/*used in Amend*/
amendableFields = "supplier,quantity,note,cost_price";
requiredFields = "product_id,record_date,supplier,quantity,note,cost_price,total_price";
/*End here*/

String title = "Product Purchase";
%>
<%@include file="../common/sidefind.jsp"%>
<fieldset style="width:700px; margin: auto; margin-top: 50px; border: 1px solid #ddd; background-color: #f6f6f6; padding:20px;"  >
    <legend style="font-size: 14px; font-weight: bold; padding:0 10px"><%= title %></legend>
	<form action="" method="post" name="WASForm" id="WASForm" autocomplete="off">
            <div class="input-w" style="margin-left: 130px; margin-top: 0px;">
                <label for="#your-input" id="lb_product_id">Product ID</label>
                <input type="text" name="product_id" id="product_id" required style="width:80px;" onkeypress='validate(event);' onblur="leadingzero(this.id,this.value,'6'); LostFocus('LF_product_id()');">
            </div>
            <div class="input-w" style="margin-left: 120px; margin-top:-35px; float:right">
                <label for="#your-input" id="lb_record_date">Record date</label>
                <input type="text" name="record_date" id="record_date" required style="width:100px;">
            </div>
            <div class="input-w" style="margin-left: 105px; margin-top: 0px; border-width: 2px; border-style: solid; border-color: #f6f6f6; ">
                <label for="#your-input" id="lb_hd_product_name">Product Name</label>
                <input type="text" name="hd_product_name" id="hd_product_name" required style="width:200px;" disabled>
            </div>
            <div class="input-w" style="margin-left: 138px;">
                <label for="#your-input" id="lb_hd_category">Category</label>
                <select name="hd_category" id="hd_category" disabled>
                    <option></option>
                    <%
                    Connection conn = DBConnection();
                    PreparedStatement qrySelectCategory = conn.prepareStatement("SELECT product_category_id, product_category_name FROM wasi_cs_product_category order by product_category_name");
                    ResultSet strQueryCategory = qrySelectCategory.executeQuery();
                    while(strQueryCategory.next()){
                    %>
                    <option value="<%= strQueryCategory.getString("product_category_id") %>" ><%= strQueryCategory.getString("product_category_name") %></option>
                     <%}%>
		</select>
            </div>
            <div class="input-w" style="margin-left: 140px;">
                <label for="#your-input" id="lb_supplier">Supplier</label>
                <select name="supplier" id="supplier" >
                    <option></option>
                    <%
                    PreparedStatement qrySelectSupplier = conn.prepareStatement("SELECT supplier_id, company_name FROM was_supplier order by company_name");
                    ResultSet qryQuerySupplier = qrySelectSupplier.executeQuery();
                    while(qryQuerySupplier.next()){
                    %>
                    <option value="<%= qryQuerySupplier.getString("supplier_id") %>" ><%= qryQuerySupplier.getString("company_name") %></option>
                    <%}%>
		</select>
            </div>   
            <div class="input-w" style="margin-left: 128px; margin-top: 0px;">
                <label for="#your-input" id="lb_cost_price">Cost Price</label>
                <input type="text" name="cost_price" id="cost_price" style="width:100px;" onkeypress='validate(event);' onblur="formatDecimal(this);LostFocus('getTotal()');">
            </div>
            <div class="input-w" style="margin-left: 135px; margin-top: 0px;">
                <label for="#your-input" id="lb_quantity">Stocks In</label>
                <input type="text" name="quantity" id="quantity" style="width:100px;" onkeypress='validate(event);' onblur="LostFocus('getTotal()');">
            </div>
            <div class="input-w" style="margin-left: 128px; margin-top: 0px;">
                <label for="#your-input" id="lb_total_price">Total Price</label>
                <input type="text" name="total_price" id="total_price" style="width:100px;" disabled>
            </div>
            <div class="input-w" style="margin-left: 150px; margin-top: 0px;">
                <label for="#your-input" id="lb_note">Notes</label>
                <input type="text" name="note" id="note" required style="width:100px;" value="">
            </div>
	</form>
</fieldset>
                
<%@include file="product_purchase_jsfunction.jsp"%>
<%@include file="../footer.jsp"%>