<%@include file="../header.jsp"%>
<br><span style="padding:5px; font-size: 14px; font-weight: bold;">Sales Transactions</span><br><br>
<div style="height: 400px; border: 1px solid #F2F2F2; width: 98%; overflow: auto;  padding:5px; margin-left: 5px;" class="component1">
            <table style="padding:0px;">
                <thead>
                    <tr>
                        <th style=" text-align:center;">Transaction ID</th>
                        <th style=" text-align:center;" >Record Date</th>
                        <th style="text-align:center;">Customer ID</th>
                        <th style=" text-align:center;">Card Number</th>
                        <th style="text-align:center;">Amount</th>
                        <th style=" text-align:center;">Actions</th>
                    </tr>
                </thead>
                <tbody id="displaySaleItems">
                    
                </tbody>
            </table>
            <input type="hidden" name="strCounter" id="strCounter" value="0">
        </div>

<%@include file="view_sales_trans_rpt_jsfunction.jsp"%>
<%@include file="../footer.jsp"%>