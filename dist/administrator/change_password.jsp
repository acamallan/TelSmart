<%@include file="../header.jsp"%>
<%@include file="../functions/record_function.jsp"%>
<%
Boolean update = false;
if(request.getParameter("Update") != null && (session.getAttribute("isSubmit") == null || (!session.getAttribute("isSubmit").equals(request.getParameter("strValue"))))){
    session.setAttribute("isSubmit",request.getParameter("strValue"));
    Integer strValue = UpdateRecord(encrypt(request.getParameter("table")),encrypt(request.getParameter("strField")),encrypt(request.getParameter("strValue")),encrypt(request.getParameter("where")),encrypt(request.getParameter("strID")),encrypt(request.getParameter("lstFields")));
    if(strValue == 1){
        update = true;		
    } 
}

    String username = "";
    String userid = decrypt(request.getParameter("p_id"));
    String strAction = "";
    table = "was_user_info";
    fields = "";
    where = "userid";
    if(request.getParameter("action").equals("edit")){
        Connection conn = DBConnection();
        PreparedStatement query = conn.prepareStatement("SELECT * from was_user_info  where userid = '"+decrypt(request.getParameter("p_id"))+"'");
        ResultSet strQuery = query.executeQuery();
        strQuery.next();
        username =strQuery.getString("username");
        strAction = "edit";
        fields = "username, password";
    } 
%>
    <fieldset style="width:700px; margin: auto; margin-top: 50px; border: 1px solid #ddd;
    background-color: #f6f6f6;"  >
        <legend style="font-size: 14px; font-weight: bold">Change Password</legend>
    <form action="change_password.jsp?action=edit&p_id=<%= URLEncoder.encode(encrypt(Integer.toString(userid1))) %>" method="post" name="WASForm" id="WASForm" autocomplete="off" style="padding:10px;">
        <table style="width:100%;  padding:5px; background-color: transparent;" border="0">
            
            <tr>
		<td class="tdfield" style="width: 30%">Password &nbsp;&nbsp;&nbsp;</td>
                <td>
                    <input type="hidden" name="username" id="username" value="<%= username %>">
                    <input type="password" name="password" id="password" value="" required pattern=".{<%= session.getAttribute("PasswordMinimumLength")%>,}" title="<%= session.getAttribute("PasswordMinimumLength")%> characters minimum">
                </td>
            </tr>
            <tr>
		<td class="tdfield">Confirm Password &nbsp;&nbsp;&nbsp;</td>
		<td><input type="password" name="hd_password" id="hd_password" value="" required onblur="checkPassword();" pattern=".{<%= session.getAttribute("PasswordMinimumLength")%>,}" title="<%= session.getAttribute("PasswordMinimumLength")%> characters minimum">
            </tr>
           
            <tr>
		<td colspan="2" style="text-align: center"><br>
                    <input type="submit" name="Update" id="Update" value="Update" onclick="GetInputName('strField'); GetRecord('strValue')" >
                    <input type="button" value="Back" name="back" id="back" onclick="window.location.assign('<%= baseURL()%>main.jsp')">
                </td>
            </tr>
        </table>
        <input type="hidden" name="strField" id="strField" value="">
	<input type="hidden" name="strValue" id="strValue" value="">
	<input type="hidden" name="strAction" id="strAction" value="<%= strAction %>">
        <input type="hidden" name="strID" id="strID" value="<%= userid %>">
	<input type="hidden" name="table" id="table" value="<%= table %>">
	<input type="hidden" name="lstFields" id="lstFields" value="<%= fields %>">
	<input type="hidden" name="where" id="where" value="<%= where %>">
        <input type="hidden" name="mode" id="mode" value="">
    </form>
</fieldset>
        

<% 
 if (update){
%>
<script>alert('Update Successfully!')</script>
<%
 }
%>

<script>
function checkPassword(){
    if(document.getElementById("password").value !== "" && document.getElementById("hd_password").value !== ""){
        if(document.getElementById("password").value !==  document.getElementById("hd_password").value){
            alert("Incorrect Password.");
            document.getElementById("password").focus();
            return;
        }
    }
}
</script>
<%@include file="../footer.jsp"%>