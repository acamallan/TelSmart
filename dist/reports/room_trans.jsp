<%
if(session.getAttribute("userid") == null) {  
    response.sendRedirect(baseURL()+"index.jsp");
    return;
}
%>
<%@ page import="wAYA.GenerateReport"%>
<%@include file="../functions/was_function.jsp"%>
<%@include file="../functions/classes.jsp"%>
<%
GenerateReport report = new GenerateReport();
report.GenerateHTMLtoPDF("test");
%>
<html>
<head>
    <link href="<%= baseURL()%>styles/reports.css" rel="stylesheet" type="text/css" media="all">
    <script type="text/javascript" src="<%= baseURL()%>scripts/jquery_1.9.1.js"></script>
    <script type="text/javascript" src="<%= baseURL()%>scripts/jspdf.js"></script>
    
                    
<script>
   
    function exportToPDF() {
        var pdf = new jsPDF('p', 'pt', 'letter');
        // source can be HTML-formatted string, or a reference
        // to an actual DOM element from which the text will be scraped.
        source = $('#content')[0];

        // we support special element handlers. Register them with jQuery-style 
        // ID selector for either ID or node name. ("#iAmID", "div", "span" etc.)
        // There is no support for any other type of selectors 
        // (class, of compound) at this time.
        specialElementHandlers = {
            // element with id of "bypass" - jQuery style selector
            '#bypassme': function (element, renderer) {
                // true = "handled elsewhere, bypass text extraction"
                return true
            }
        };
        margins = {
            top: 10,
            bottom: 60,
            left: 40,
            width: 900
        };
        // all coords and widths are in jsPDF instance's declared units
        // 'inches' in this case
        pdf.fromHTML(
        source, // HTML string or DOM elem ref.
        margins.left, // x coord
        margins.top, { // y coord
            'width': margins.width, // max width of content on PDF
            'elementHandlers': specialElementHandlers
        },

        function (dispose) {
            // dispose: object with X, Y of the last line add to the PDF 
            //          this allow the insertion of new lines after html
            pdf.save('Test.pdf');
        }, margins);
    }
    
    
</script>
</head>
<body>
<div style="float: left; position: relative;"><br>
    <div class="block" style="top: 160px; margin-left: 50px; width: 0px;">
       <input tabindex="4" type="button" id="exportToPDF" value="Export to PDF" onclick="exportToPDF()"><br>
       <input tabindex="4" type="button" value="Export to CSV">
       <input tabindex="4" type="button" value="Close" onclick="window.close();">
    </div>
</div>
    
<%
    String[] strings = decrypt(request.getParameter("strings")).split("\\^");
    String strWhere = strings[0];
    String checkType = strings[1];
    String dateFrom = strings[2];
    String dateTo = strings[3];
    Connection conn = DBConnection();
    PreparedStatement query = conn.prepareStatement("select transaction_date, transaction_time, room_id, customer_name from view_hotel_book_transactions " + strWhere + "  order by transaction_id desc");
    ResultSet strQuery = query.executeQuery();
%>
<div id="content" style="width: 920px; margin: auto; border: 1px solid #C0C0C0; margin-top: 10px; height: 97%; overflow: auto;"><!--Content -->
    <div>
    
                <span style="font-size: 16px; font-weight: bold;">Room Transactions</span><br>
                <span style="font-size: 12px; font-weight: bold;"><%= checkType%></span><br><br>
  </div>
                Date From: <%= dateFrom %><br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Date To: <%= dateTo%><br>
    
    <hr style="background-color:gray;">
    <div class="component" style="width:100%; height:83%; float:left; padding:0px; overflow: auto; margin-top:0px;">
        <table>
            <thead>
                <tr>
                    <th style="text-align:center;">Transaction Date</th>
                    <th style="text-align:center;">Transaction Time</th>
                    <th style="text-align:center;">Room Number</th>
                    <th style="text-align:center;">Customer Name</th>
                </tr>
            </thead>
            <tbody>
            <% while(strQuery.next()){
            %>
                <tr>
                    <td><%= strQuery.getString("transaction_date") %></td>
                    <td><%= strQuery.getString("transaction_time") %></td>
                    <td><%= strQuery.getString("room_id") %></td>
                    <td><%= strQuery.getString("customer_name") %></td>
                </tr>
            <%}%>  
             </tbody>
        </table>
    </div>       
</div>         
</body>    
</html>