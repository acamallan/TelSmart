<%@include file="../functions/was_function.jsp"%>
<%@include file="../functions/classes.jsp"%>
<%
String total = "";
String amount = "";
String change = "";
String room_id = "";
String customer_name = "";
String table_number = "";
String sales_invoice = "";
String vatPercentLabel = "12";
Double vatPercent = .12;
Double taxAmount = 0.00;
Double vatableAmount = 0.00;
String paid = request.getParameter("paid");
String items = decryptJS(request.getParameter("items"));
if(paid.equals("0")){//charge to room(pos)
    sales_invoice = decryptJS(request.getParameter("sales_invoice"));
    total = decryptJS(request.getParameter("total"));
    table_number = decryptJS(request.getParameter("table_number"));
    room_id = decryptJS(request.getParameter("room_id"));
    customer_name = decryptJS(request.getParameter("customer_name"));
} else if(paid.equals("1")){ // pos
    sales_invoice = decryptJS(request.getParameter("sales_invoice"));
    total = decryptJS(request.getParameter("total"));
    table_number = decryptJS(request.getParameter("table_number"));
    amount = decryptJS(request.getParameter("amount"));
    change = decryptJS(request.getParameter("change"));
    
    Double intTotal = Double.parseDouble(total.toString());
    taxAmount = intTotal * (vatPercent);
    vatableAmount = intTotal - taxAmount;
} else if(paid.equals("2")){ //booking
    sales_invoice = decryptJS(request.getParameter("sales_invoice"));
    total = decryptJS(request.getParameter("total"));
    amount = decryptJS(request.getParameter("amount"));
    change = decryptJS(request.getParameter("change"));
    
    Double intTotal = Double.parseDouble(total.toString());
    taxAmount = intTotal * (vatPercent);
    vatableAmount = intTotal - taxAmount;
} 


DecimalFormat df = new DecimalFormat("#.00"); 
String cashier = (String) session.getAttribute("firstname") +" "+ (String) session.getAttribute("lastname");
%>

<div style="width:270px; text-align: center; font-size: 12px; font-family: 'Open Sans',sans-serif">
    <div style="float: right;">Sales Invoice Number: <%= sales_invoice %></div><br><br>
    <span style="font-size:20px; font-weight: bold;">TelSmart</span><br>
    My Store Name<br>
    My Address<br><br>
    <div id="datetime" style="float: right;"></div>
    <div style="float: left;">Cashier: <%=  cashier %> </div><br>
    <% if(decryptJS(request.getParameter("table_number")) != null) {%>
        <div style="float: left;">Table Number: <%= table_number %> </div>
    <%}%>
    <br><br>
    
    <table style="width:100%; text-align: center; font-size: 12px; font-family: 'Open Sans',sans-serif">
        <thead>
            <tr>
                <td style="text-align: left;">Product Name</td>
                <td><%if(paid.equals("2")){%>Transaction Date<%} else {%>Quantity<%}%></td>
                <td style="text-align: right;">Total</td>
            </tr>
            <tr>
                <td colspan="3" style="text-align: right; font-weight: bold;"><hr></td>
            </tr>
        </thead>
        <tbody>
            <%= items %>
            <tr>
            <td colspan="3" style="text-align: right; font-weight: bold;"><hr></td>
        </tr>
        <tr>
            <td colspan="2" style="text-align: right; font-weight: bold;">Subtotal</td>
            <td style="text-align: right; font-weight: bold;"><%= total %></td>
        </tr>
        <%if(paid.equals("1") || paid.equals("2")){%>
            <tr>
                <td colspan="2" style="text-align: right; font-weight: bold;"><%= vatPercentLabel %>% Tax:</td>
                <td style="text-align: right; font-weight: bold;"><%= df.format(taxAmount) %></td>
            </tr>
            <tr>
                <td colspan="2" style="text-align: right; font-weight: bold;">Vatable Amount:</td>
                <td style="text-align: right; font-weight: bold;"><%= df.format(vatableAmount) %></td>
            </tr>
            <tr>
                <td colspan="2" style="text-align: right; font-weight: bold;">Amount</td>
                <td style="text-align: right; font-weight: bold;"><%= amount %></td>
            </tr>
            <tr>
                <td colspan="2" style="text-align: right; font-weight: bold;">Changed</td>
                <td style="text-align: right; font-weight: bold;"><%= change %></td>
            </tr>
        <%} else if(paid.equals("0")){%>
            <tr>
                <td style="text-align: left; font-weight: bold;"><br>Room Number:</td>
                <td style="text-align: left; font-weight: bold;" colspan="2"><br><%= room_id %></td>
            </tr>
            <tr>
                <td style="text-align: left; font-weight: bold;">Signature:
                    <br><br><br><br>
                    <hr>
                    <%= customer_name %>
                </td>
                <td style="text-align: left; font-weight: bold;" colspan="2"></td>
            </tr>
        <%}%>
        </tbody>
        
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