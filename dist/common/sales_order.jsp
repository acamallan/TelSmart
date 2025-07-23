<%@include file="../functions/was_function.jsp"%>
<%@include file="../functions/classes.jsp"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
if(session.getAttribute("userid") == null) {  
    response.sendRedirect(baseURL()+"index.jsp");
    return;
}

DecimalFormat df = new DecimalFormat("#.00"); 
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>FinSMART - <% out.println(session.getAttribute("institution_name")); %></title>
        <link href="<%= baseURL()%>styles/style.css" rel="stylesheet" type="text/css" media="all">
    </head>
    <body>
        <div style="margin-left: auto; margin-right: auto; width: 800px;" id="print"><br><br>
            <span style="width: 200px; font-size: 20px; padding: 5px;"><% out.println(session.getAttribute("institution_name")); %></span>
            <span style="float:right; font-size: 20px;">Sales Order</span><br><br><br>
            <div style="width:100%; background: #39C; padding: 5px; color: #FFF;"> Shipping Information </div>
            <div style="width:100%; padding: 5px;">
                <%
                Connection conn = DBConnection();
                String qryStmt = "";
                String sale_id = decrypt(request.getParameter("sale_id"));
                qryStmt = "select cust.first_name, cust.last_name, email from was_product_sales_order_header header, was_customer_info cust "
                                            + " where header.customer_id = cust.customer_id and header.sale_id ='"+sale_id+"' ";
                PreparedStatement qrySelect = conn.prepareStatement(qryStmt);
                ResultSet strQuery = qrySelect.executeQuery();
                strQuery.next();
                %>
                <table>
                    <tr>
                        <td style="width: 15%; padding: 5px; text-align: right;">
                            Name:
                        </td>
                        <td style="padding: 5px;">
                            <%= strQuery.getString("first_name") %> <%= strQuery.getString("last_name") %>
                        </td>
                    </tr>
                </table>
            </div>
            <br>
            <div style="width:100%; background: #39C; padding: 5px; color: #FFF;"> Order Information </div><br>
            <div class="component1" id="component1" style="width:101.3%;">
                <table style="width: 100%">
                    <thead>
                        <tr>
                            <th style="width:10%">Quantity</th>
                            <th style="width:50%">Brochure</th>
                            <th style="width:20%; text-align:center;" >Price</th>
                            <th style="width:20%; text-align:center;">Total</th>
                        </tr>
                    </thead>
                    <tbody id="displaySales">
                        <%
                        String qryStmt1 = "select sale.quantity, prod.product_name, sale.price, sale.total_amount from was_product_sales_order sale, was_product prod  "
                                            + " where sale.product_id = prod.product_id and sale.sale_id ='"+sale_id+"' ";
                        PreparedStatement qrySelect1 = conn.prepareStatement(qryStmt1);
                        ResultSet strQuery1 = qrySelect1.executeQuery();
                        Integer total = 0;
                        while(strQuery1.next()){
                            total = total + strQuery1.getInt("total_amount");
                        %>
                        <tr>
                            <td style="text-align: center;"><%= strQuery1.getString("quantity") %></td>
                            <td><%= strQuery1.getString("product_name") %></td>
                            <td style="text-align: right;"><%= strQuery1.getString("price") %></td>
                            <td style="text-align: right;"><%= strQuery1.getString("total_amount") %></td>
                        </tr>
                        <%
                        }
                        %>
                    </tbody>
                </table>
            </div><br><br><hr style="width:101.3%;">
            <table style="width:101.3%;">
                <tr>
                    <td style="width:50%; vertical-align: top;"> 
                    </td>
                    <td style="width:10%; text-align:right; font-weight: bold; vertical-align: top;"></td>
                    <td style="width:20%; text-align:right; font-weight: bold; vertical-align: top;">Total:</td>
                    <td style="width:20%; text-align:right; padding: 3px; font-weight: bold; vertical-align: top;"><%= df.format(total) %></td>
                </tr>
            </table>
        </div>
                <table style="margin-left: 275px;">
                <tr>
                    <td style="width:50%; vertical-align: top;"> 
                        <input type="button" name="print" id="print" value="Print" style="width:100px;" onclick="print();">
                        <input type="button" name="close" id="close" value="Close" style="width:100px;" onclick="window.close();"> 
                    </td>
                </tr>
            </table>
    </body>
    <script>
        function baseURL(){
            return '<%= getServletContext().getInitParameter("baseURL") %>';
        }
        
        function print() {
            var divText = document.getElementById("print").outerHTML;
                var myWindow = window.open('','','fullscreen=yes, top=10, width=1000, height=700;');
                var print ="";
                var print = print +'<!DOCTYPE html> <html> <head><meta http-equiv="Content-Type" content="text/html; charset=UTF-8"><link href="'+baseURL()+'styles/style.css" rel="stylesheet" type="text/css" media="all"></head><body onload="window.print(); window.close();">';
                var print = print +divText;
                var print = print + '</body></html>';
                var doc = myWindow.document;
                doc.open();
                doc.write(print);
                doc.close();
        }
    </script>
</html>
