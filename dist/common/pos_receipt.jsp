<%@include file="../functions/was_function.jsp"%>
<%@include file="../functions/classes.jsp"%>
<%
String trans_id = decrypt(request.getParameter("trans_id"));
DecimalFormat df = new DecimalFormat("#.00"); 
%>

<div style="width:270px; text-align: center; font-size: 12px; font-family: 'Open Sans',sans-serif">
    <span style="font-size:20px; font-weight: bold;">POS SYSTEM</span><br>
    My Store Name<br>
    My Address<br><br>
    <div id="datetime" style="float: right;"></div><br><br>
    <table style="width:100%; text-align: center; font-size: 12px; font-family: 'Open Sans',sans-serif">
        <tr>
            <td style="text-align: left;">Product Name</td>
            <td>Quantity</td>
            <td style="text-align: right;">Subtotal</td>
        </tr>
        <tr>
            <td colspan="3" style="text-align: right; font-weight: bold;"><hr></td>
        </tr>
        <%
        Connection conn = DBConnection();
        PreparedStatement qrySelect = conn.prepareStatement("select product_name, quantity, total_amount from was_product_sales_order sale, was_product prod where transaction_id = "+trans_id+" and sale.product_id = prod.product_id");
        ResultSet strQuery = qrySelect.executeQuery();
        Integer total = 0;
        while(strQuery.next()){
            total = total + strQuery.getInt("total_amount");
        %>
        <tr>
            <td style="float:left;"><%= strQuery.getString("product_name") %></td>
            <td><%= strQuery.getString("quantity") %></td>
            <td style="float:right;"><%= strQuery.getString("total_amount") %></td>
        </tr>
        <%
        }
        %>
        <tr>
            <td colspan="3" style="text-align: right; font-weight: bold;"><hr></td>
        </tr>
        <tr>
            <td colspan="2" style="text-align: right; font-weight: bold;">Total</td>
            <td style="text-align: right; font-weight: bold;"><%= df.format(total) %></td>
        </tr>
        <!--<tr>
            <td  style="text-align: left;">VAT</td>
            <td colspan="2" style="text-align: left;">3%</td>
        </tr>
        <tr>
            <td colspan="3" style="text-align: right; font-weight: bold;"><hr></td>
        </tr>
        <tr>
            <td  style="text-align: left; font-weight: bold;">Grand Total</td>
            <td colspan="2" style="text-align: right; font-weight: bold;">475.30</td>
        </tr> 
        <tr>
            <td  style="text-align: left; font-weight: bold;">Paid</td>
            <td colspan="2" style="text-align: right; font-weight: bold;">500.00</td>
        </tr>
        <tr>
            <td  style="text-align: left; font-weight: bold;">Change</td>
            <td colspan="2" style="text-align: right; font-weight: bold;">10.00</td>
        </tr>-->
        <tr>
            <td colspan="3" style="text-align: right; font-weight: bold;"><hr></td>
        </tr>
        <tr>
            <td colspan="3" style="text-align: center;">Thank you and please come again!</td>
        </tr>
    </table>
</div>

<script>
    var today = new Date();
    var mm =  (today.getMonth()+1);
    var dd = today.getDate(); 
    var yy = today.getFullYear();
    var h = today.getHours();
    var m = today.getMinutes();
    var s = today.getSeconds();
    var datetime = mm + "/" + dd +"/"+ yy +" "+ h + ":" + m + ":" + s;
    document.getElementById("datetime").innerHTML = datetime;
</script>