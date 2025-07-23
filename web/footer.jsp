
	<% if(uri.contains("/pages/") && (!uri.contains("rpt.jsp"))){%>
            <div id="footer_navigation" class="footer_navigation">
                <input type="button" value="Select" name="select" id="select" onclick="Select()" style="display:none;">
                <input type="button" value="New" name="addnew" id="addnew" onclick="AddNew()" disabled>
                <input type="button" value="Edit" name="amend" id="amend" onclick="Amend()" disabled>
                <input type="button" value="Save" name="update" id="update" onclick="Update();">
                <input type="button" value="Delete" name="delete" id="delete" onclick="Delete()" disabled>
                <input type="button" value="Close" name="done" id="done" onclick="window.close();">
            </div> 

            <input type="hidden" name="strField" id="strField" value="">
            <input type="hidden" name="strValue" id="strValue" value="">
            <input type="hidden" name="mode" id="mode" value="">
            <input type="hidden" name="rowid" id="rowid" value="">
            <input type="hidden" name="current_page" id="current_page" value="0">
            <input type="hidden" name="lastPage" id="lastPage" value="">
            <input type="hidden" name="mainWhere" id="mainWhere" value="<%= mainWhere %>">
            <input type="hidden" name="lstFields" id="lstFields" value="<%= fields %>">
            <input type="hidden" name="table" id="table" value="<%= table %>">
            <input type="hidden" name="where" id="where" value="<%= where %>">
            <input type="hidden" name="orderby" id="orderby" value="<%= orderby %>">
            <input type="hidden" name="amendableFields" id="amendableFields" value="<%= amendableFields %>">
            <input type="hidden" name="count" id="count" value="">
            <input type="hidden" name="requiredFields" id="requiredFields" value="<%= requiredFields %>">
            <input type="hidden" name="enableFields" id="enableFields" value="<%= enableFields %>">
            <input type="hidden" name="pageMode" id="pageMode" value="<%= pageMode %>">
        <%}%>
    </div>
    <div id="loading">
    </div>
    
</body>
</html>