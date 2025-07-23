<%@include file="../header.jsp"%>
<%@include file="../functions/record_function.jsp"%>

<%
table = "was_journal_entry";
fields = "distinct journal_id as rowid, journal_id, notes, record_date";
where = "journal_id";
/*used in Add New*/
enableFields = "notes";
/*used in Amend*/
amendableFields = "notes";
requiredFields = "notes";

pageMode = "N,E,D";

%>

<%@include file="../common/sidefind.jsp"%>
<div style="position:relative; z-index:0;">
<fieldset style="width:850px; margin: auto; margin-top: 20px; border: 1px solid #ddd; background-color: #f6f6f6; padding:20px;"  >
    <div class="block" style="margin-left:0px; margin-top:0px;">
        <label id="lb_journal_id">Journal ID</label>
        <input type="text" name="journal_id" id="journal_id" required style="width:80px; align:left;" disabled>
    </div>
    <div class="block" style="margin-left: 0px; margin-top: 30px;">
        <label id="lb_notes">Notes</label>
        <input type="text" name="notes" id="notes" disabled>
    </div>
    <div class="block" style="margin-left:650px; margin-top:0px">
        <label id="lb_record_date">Record Date</label>
        <input type="text" name="record_date" id="record_date" style="width:80px;">
    </div>
    <br>
    <div class="component1" style="width:850px; margin-top: 80px;">
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
                PreparedStatement qrySelectCRDRHd = conn.prepareStatement("SELECT was_id, account_type FROM was_chart_of_account order by was_id");
                ResultSet strQueryCRDRHd = qrySelectCRDRHd.executeQuery();
                String strOption = "";
                while(strQueryCRDRHd.next()){
                    strOption = strOption +"<option value="+strQueryCRDRHd.getString("was_id")+">"+strQueryCRDRHd.getString("was_id")+" - "+strQueryCRDRHd.getString("account_type")+"</option>";
                }
                String strAcctType = "<select style='width:200px' name='dynfields' id='account_type[counter]' onblur='LF_account_type(counter)'><option value=''> </option> "+ strOption + "</select>";
                            
                PreparedStatement qrySelect = conn.prepareStatement("SELECT was_id, cr_dr FROM was_cr_dr");
                ResultSet strQuery = qrySelect.executeQuery();
                String strOption1 = "";
                while(strQuery.next()){
                    strOption1 = strOption1 +"<option value="+strQuery.getString("was_id")+">"+strQuery.getString("cr_dr")+"</option>";
                }
                String strCrDr = "<select  style='width:80px' name='dynfields' id='crdr[counter]' onblur='checkCrDr(this.id)' ><option value=''> </option> "+ strOption1 + "</select>";
                %>
                <tr id="trJournal[1]">
                    <td style="padding:3px">
                    <% 
                    PreparedStatement qrySelectChart = conn.prepareStatement("SELECT was_id, account_type FROM was_chart_of_account order by was_id");
                    ResultSet strQueryChart = qrySelectChart.executeQuery();
                    %>
                        <select style='width:200px' name='dynfields' id='account_type[1]' onblur="LostFocus('LF_account_type(1)')">
                            <option value=''> </option>
                            <%
                            while(strQueryChart.next()){
                            %>
                               <option value="<%= strQueryChart.getString("was_id") %>"><%= strQueryChart.getString("was_id") %> - <%= strQueryChart.getString("account_type") %></option>
                            <%
                            }
                            %>
                        </select>
                    </td>
                    <td style="padding:3px">
                        <input type="text" name="dynfields" id="narrative[1]" onblur="LostFocus('LF_narrative(1)')">
                    </td>
                    <td style="text-align:center;"><input type="text" name="dynfields" value="" id='debit[1]' style="width:100px;text-align: right;" onkeypress="validate(event)" onblur="formatDecimal(this); totalCrDr('debit')" disabled></td>
                    <td style="text-align:center;"><input type="text" name="dynfields" value="" id='credit[1]' style="width:100px;text-align: right;" onkeypress="validate(event)" onblur="formatDecimal(this); totalCrDr('credit')" required disabled></td>
                </tr>
            </tbody>
        </table>
    </div>
    <table border="0" style="background-color: transparent;">
        <tr > 
            <td width="50%" id="tdAddEntry"><!--<a href="#" class="action" id="AddEntry" onclick="AddEntryJournal()" title="Add Entry"><span class="typcn typcn-plus"></span>Add Entry </a>--><div style="float:right; font-weight: bold;color:#39C">Total</div></td>
            <td style="width:25%;text-align:right; padding-right:5px;"><span id="totalDebit" style="font-weight: bold;color:#39C;  font-size:14px;">0.00</span></td>
            <td style="width:25%;text-align:right; padding-right:35px;"><span id="totalCredit" style="font-weight: bold;color:#39C; font-size:14px;">0.00</span></td>
        </tr>
    </table>
    <input type="hidden" name="strSelectOptAcctType" id="strSelectOptAcctType" value="<%= strAcctType %>">
    <input type="hidden" name="strSelectOptCrDr" id="strSelectOptCrDr" value="<%= strCrDr %>">
    <input type="hidden" name="strCounter" id="strCounter" value="1">
    <input type="hidden" name="strTotalDebit" id="strTotalDebit" value="">
    <input type="hidden" name="strTotalCredit" id="strTotalCredit" value="">
    <input type="hidden" name="strNarrCount" id="strNarrCount" value="0">
    <input type="hidden" name="strNarrative" id="strNarrative" value="">


</fieldset>
</div>
<%@include file="acc_journal_entry_jsfunction.jsp"%>
<%@include file="../footer.jsp"%>