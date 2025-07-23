<%@include file="../header.jsp"%>

<%
DecimalFormat df = new DecimalFormat("#.00"); 
Integer totalCredit = 0;
Integer totalDebit = 0;
%>
<fieldset style="width:700px; margin: auto; margin-top: 100px; border: 1px solid #ddd; background-color: #f6f6f6; padding:20px;"  >
<h2 style="margin-top:-2px;">Trial Balance</h2>
<div class="component">
    <table>
        <thead>
            <tr>
                <th style="width:10%; text-align:center;">Account ID</th>
                <th style="width:50%; text-align:center;">Account Type</th>
		<th style="width:20%; text-align:center;">Debit</th>
		<th style="width:20%;text-align:center;">Credit</th>
            </tr>
            <%
            Connection conn = DBConnection();
            PreparedStatement qrySelect = conn.prepareStatement("SELECT entry.account_type account_type_id, chart.account_type, sum(entry.debit) debit, sum(entry.credit) credit" +
                                " FROM was_journal_entry entry, was_chart_of_account chart" +
				" where chart.was_id = entry.account_type " +
				" group by chart.was_id");
            ResultSet strQuery = qrySelect.executeQuery();
            while(strQuery.next()){
            %>
          
            <tr>
                <td><%= strQuery.getString("account_type_id") %></td>
                <td><%= strQuery.getString("account_type") %></td>
		<td style="text-align:right;">
                <%
                Integer diff = 0;
                if (strQuery.getString("debit") != null && strQuery.getString("credit") != null){
                    if(strQuery.getInt("debit") > strQuery.getInt("credit")){
                        diff = strQuery.getInt("debit") - strQuery.getInt("credit");
			out.println(df.format(diff));
			totalDebit = totalDebit + diff;
                    }
		} else {
                    if(strQuery.getString("debit") != null){
                        out.println(df.format(strQuery.getInt("debit")));
                        totalDebit = totalDebit + strQuery.getInt("debit");
                    }
                }
                %>
		</td>
		<td style="text-align:right;">
                <%
                Integer diffCredit = 0;
		if (strQuery.getString("debit") != null && strQuery.getString("credit") != null){
                    if(strQuery.getInt("debit") < strQuery.getInt("credit")){
                        diffCredit = strQuery.getInt("credit") - strQuery.getInt("debit");
			out.println(df.format(diffCredit));
			totalCredit = totalCredit + diffCredit; 
                    }
		} else {
                    if(strQuery.getString("credit") != null){
                        out.println(df.format(strQuery.getInt("credit")));
			totalCredit = totalCredit + strQuery.getInt("credit");
                    }
		}
		%></td>
            </tr>
        <%
        }
        %>
	<tr>
            <td></td>
            <td style="text-align:right; font-weight:bold;">Total</td>
            <td style="text-align:right; font-weight:bold;"><%= df.format(totalDebit) %></td>
            <td style="text-align:right; font-weight:bold;"><%= df.format(totalCredit) %></td>
	</tr>
	</thead>
    </table>
</div>	
<input type="button" value="Done" name="done" id="done" onclick="window.close();">        
</fieldset>
<%@include file="../footer.jsp"%>