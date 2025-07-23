<%@include file="../header.jsp"%>

<fieldset style="width:500px; height: 200px; margin: auto; margin-top: 100px; border: 1px solid #ddd; background-color: #f6f6f6; padding:2px;"  >
    <legend>Products Availability</legend>
    <div class="input-w" style="position: relative; margin-left:100px; margin-top: 30px;">
        <label >Product Name</label>
      
                <select name="product_id" id="product_id">
                    <option value="999999">All</option>
                    <%
                    Connection conn = DBConnection();
                    PreparedStatement qrySelectCategory = conn.prepareStatement("SELECT product_id, product_name FROM view_products order by product_name");
                    ResultSet strQueryCategory = qrySelectCategory.executeQuery();
                    while(strQueryCategory.next()){
                    %>
                    <option value="<%= strQueryCategory.getString("product_id") %>" ><%= strQueryCategory.getString("product_name") %></option>
                     <%}%>
		</select>
      
    </div>
    <div class="input-w" style="position: relative; margin-left:100px; margin-top: 50px;">
       <input type="button" name="process" id="process" value="Process" onclick="ProcessReport()">
    </div>
    <div class="input-w" style="position: relative; margin-left:250px; margin-top: -38px;">
       <input type="button" name="cancel" id="cancel" value="Cancel">
    </div>
</fieldset>
<%@include file="products_avail_rpt_jsfunction.jsp"%>
<%@include file="../footer.jsp"%>