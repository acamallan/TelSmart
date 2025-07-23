<%
if(session.getAttribute("userid") == null) {  
    response.sendRedirect(baseURL()+"index.jsp");
    return;
}
%>

<%@include file="../functions/was_function.jsp"%>
<%@include file="../functions/classes.jsp"%>
<%
DecimalFormat df = new DecimalFormat("#.00"); 
%>

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    <meta http-equiv="Cache-control" content="no-cache">
    <meta http-equiv="Expires" content="-1">
    <title>FinSMART - <% out.println(session.getAttribute("institution_name")); %></title>
    <link href="<%= baseURL()%>styles/style.css" rel="stylesheet" type="text/css" media="all">
  </head>
<body>
<div class="header">
    <div style="float:left;"><p style="font-size:20px; padding:10px; margin:0px; font-weight: bold; letter-spacing: 1px; ">Fin<span style="color:#000000;">SMART</span></p></div>
</div>      
<div class="component1" style="width:100%; height: 400px;">
    <table>
        <thead>
            <tr>
                <th style="width:30%">Account Type</th>
                <th style="width:30%">Narrative</th>
                <th style="width:20%; text-align:center;" >Debit</th>
                <th style="width:20%; text-align:center;">Credit</th>
            </tr>
        </thead>
        <tbody id="journalEntry">
            <%
            Connection conn = DBConnection();
            String qryStmt = "";
            if(request.getParameter("receive_id") != null){
                String receive_id = decrypt(request.getParameter("receive_id"));
                qryStmt = "select info.cogs_account as coa_type, coa.account_type, rec.description, rec.total_price from was_product_receive rec, was_product prod, was_chart_of_account coa , was_product_price_info info "
                                        + " where rec.product_id = prod.product_id and info.cogs_account = coa.was_id "
                                        + " and info.record_date = (select max(record_date) from was_product_price_info where product_id = rec.product_id) "
                                        + " and rec.receive_id = '"+receive_id+"'";
            } 
            if (request.getParameter("purchase_id") != null) {
                String purchase_id = decrypt(request.getParameter("purchase_id"));
                qryStmt = "select info.cogs_account as coa_type, coa.account_type, purch.description, purch.total_price from was_product_purchase purch, was_product prod, was_chart_of_account coa, was_product_price_info info "
                                        + " where purch.product_id = prod.product_id and info.cogs_account = coa.was_id "
                                        + " and info.record_date = (select max(record_date) from was_product_price_info where product_id = purch.product_id) "
                                        + " and purch.purchase_id = '"+purchase_id+"'";
            }
            
            if (request.getParameter("sale_id") != null) {
                String sale_id = decrypt(request.getParameter("sale_id"));
                qryStmt = "select info.income_account as coa_type, coa.account_type, sale.description, sale.total_amount as total_price from was_product_sales_order sale, was_product prod, was_chart_of_account coa, was_product_price_info info "
                                        + "  where sale.product_id = prod.product_id and sale.product_id = info.product_id and info.income_account = coa.was_id "
                                        + " and info.record_date = (select max(record_date) from was_product_price_info where product_id = sale.product_id) "
                                        + " and sale.sale_id = '"+sale_id+"'";
            }
            
            PreparedStatement qrySelect = conn.prepareStatement(qryStmt);
            ResultSet strQuery = qrySelect.executeQuery();
            Integer total = 0;
            while(strQuery.next()){
                total = total + strQuery.getInt("total_price");
            %>
            <tr>
                <td><%= strQuery.getString("coa_type") %> - <%= strQuery.getString("account_type") %> </td>
                <td><%= strQuery.getString("description") %></td>
                <td style="text-align: right;"><%= strQuery.getString("total_price") %></td>
                <td></td>
            </tr>
            <%
            }
            %>
            <tr>
                <td>2001 - Accounts Payable</td>
                <td>Accounts Payable</td>
                <td></td>
                <td style="text-align: right;"><%= df.format(total) %></td>
            </tr>
        </tbody>
    </table>
    
</div>
<hr>
<table>
    <tr>
        <td style="width:30%; vertical-align: top;"> <input type="button" name="close" id="close" value="Close" style="width:100px;" onclick="window.close();"> </td>
        <td style="width:30%; text-align:right; font-weight: bold; vertical-align: top;">Total:</td>
        <td style="width:20%; text-align:right; font-weight: bold; vertical-align: top;"><%= df.format(total) %></td>
        <td style="width:20%; text-align:right; padding: 3px; font-weight: bold; vertical-align: top;"><%= df.format(total) %></td>
    </tr>
</table>
</body>
</html>