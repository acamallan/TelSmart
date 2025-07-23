<%@include file="../functions/record_function.jsp"%>
<%@include file="../header.jsp"%>
<% 
Connection conn = DBConnection();
if(request.getParameter("save") != null){
    PreparedStatement qrySelect = conn.prepareStatement("select config_name, config_value from was_configuration where config_id='SECURITY'");
    ResultSet strResult = qrySelect.executeQuery();
    String set = "";
    Integer strReturn = 0;
    while(strResult.next()){
        set =  "config_value = '"+request.getParameter(strResult.getString("config_name"))+"' where config_name = '"+strResult.getString("config_name")+"' and config_id='SECURITY'";
        PreparedStatement qryUpdate = conn.prepareStatement("update was_configuration set " + set);
        strReturn = qryUpdate.executeUpdate();
    }
    if(strReturn.equals(1)){
        PreparedStatement qryConfig = conn.prepareStatement("select config_name, config_value, config_desc from was_configuration where config_id='SECURITY'");
        ResultSet getConfig = qryConfig.executeQuery();
        while (getConfig.next()){
            session.setAttribute(getConfig.getString("config_name"), getConfig.getString("config_value"));
        }
    %>
        <script>
            alert("Records Update Successfully.");
            window.location.assign("<%= baseURL() %>main.jsp");
        </script>
    <%
    }
}

PreparedStatement qrySelect = conn.prepareStatement("select config_name, config_value, config_desc from was_configuration where config_id='SECURITY'");
ResultSet strResult = qrySelect.executeQuery();
%>
<fieldset style="width:700px; height: 150px; margin: 0 auto; margin-top: 30px; border: 1px solid #ddd; background-color: #f6f6f6; padding:5px;"  >
    <legend style="font-size: 12px; font-weight: bold; padding:0 10px">Security</legend>
    <form action="security.jsp" method="post" autocomplete="off">
    <div style="position: relative;">
        <%
        Integer top = 10;
        while(strResult.next()){
        %>
        <div class="block" style="margin-left: 50px; top: <%= top %>px;">
            <label style="width:250px"><%= strResult.getString("config_desc") %></label>
            <input type="text" name="<%= strResult.getString("config_name") %>" id="<%= strResult.getString("config_name") %>" value="<%= strResult.getString("config_value") %>" style="width:80px;">
        </div>      	
        <%
            top = top + 30;
        }
        top = top + 20;
        %>
        <div class="block" style="margin-left: 200px; top: <%= top %>px;">
            <input type="submit" value="Save" name="save" id="save" onclick="window.location.assign('<%= baseURL() %>main.jsp')">
            <input type="button" value="Cancel" name="cancel" id="cancel" onclick="window.location.assign('<%= baseURL() %>main.jsp')">
        </div>
        </form>
    </div>
    
</fieldset>
   
<%@include file="../footer.jsp"%>