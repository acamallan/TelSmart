<%@include file="../header.jsp"%>
<%@include file="../functions/record_function.jsp"%>

<%
Boolean update = false;
if(request.getParameter("Update") != null && (session.getAttribute("isSubmit") == null || (!session.getAttribute("isSubmit").equals(request.getParameter("strValue"))))){
    session.setAttribute("isSubmit",request.getParameter("strValue"));
    if(request.getParameter("strAction").equals("edit")){
        Integer strValue = UpdateRecord(encrypt(request.getParameter("table")),encrypt(request.getParameter("strField")),encrypt(request.getParameter("strValue")),encrypt(request.getParameter("where")),encrypt(request.getParameter("strID")),encrypt(request.getParameter("lstFields")));
        if(strValue == 1){
            update = true;		
        }
    } else {
        out.println(request.getParameter("strAction"));
        Integer strValue = AddNewRecord(encrypt(request.getParameter("table")),encrypt(request.getParameter("strField")),encrypt(request.getParameter("strValue")),encrypt(request.getParameter("lstFields")));
        if(strValue == -1){
            update = true;		
        }
    }
}

/* ----- Delete ----- */
if(request.getParameter("UniqueVal") != null){
    Integer strValue =DeleteRecord(encrypt(request.getParameter("table")),encrypt(request.getParameter("whereField")),encrypt(request.getParameter("UniqueVal")));
    if(strValue == 1){
            out.println("<script>alert('Delete Record Successfully!')</script>");
    }
}

if(request.getParameter("action") != null){ 
    String username = "";
    String firstname = "";
    String lastname = "";
    String userid = "";
    String role = "";
    String groups = "";
    String booking = "";
    String pos = "0";
    String password_status = "";
    String strAction = "";
    table = "was_user_info";
    fields = "";
    where = "userid";
    if(request.getParameter("action").equals("edit")){
        Connection conn = DBConnection();
        PreparedStatement query = conn.prepareStatement("SELECT * from was_user_info  where userid = '"+decrypt(request.getParameter("p_id"))+"'");
        ResultSet strQuery = query.executeQuery();
        strQuery.next();
        userid = decrypt(request.getParameter("p_id"));
        username = strQuery.getString("username");
        firstname = strQuery.getString("firstname");
        lastname = strQuery.getString("lastname");
        role = DecryptRole(strQuery.getString("role"));
        groups = strQuery.getString("groups");
        password_status = strQuery.getString("password_status");
        String[] modules = strQuery.getString("modules").split("");
        booking = modules[0];
        pos = modules[1];
        strAction = "edit";
        fields = "userid, username, first_name, last_name, role, groups, password_status, password_failed, institution_id, current_login, modules";
    } else {
        //userid = "";
        userid = GetCounter("004","6");
        strAction = "add";
        fields = "userid, username, first_name, last_name, password, role, groups, password_status, password_failed, institution_id, current_login, modules";
    }
    java.util.Date date= new java.util.Date();
%>
    <fieldset style="width:700px; margin: auto; margin-top: 50px; border: 1px solid #ddd;
    background-color: #f6f6f6;"  >
        <legend style="font-size: 14px; font-weight: bold">Add User</legend>
        <form action="users_authorization.jsp" method="post" name="WASForm" id="WASForm" autocomplete="off" style="padding:10px; position: relative;">
            <input type="hidden" name="password_failed" id="password_failed" value="0">
            <input type="hidden" name="institution_id" id="institution_id" value="1001">
            <input type="hidden" name="modules" id="modules" value="">
            <input type="hidden" name="current_login" id="current_login" value="<%= new Timestamp(date.getTime())%>">
            <div class="block" style="margin-left: 30px; top: 10px; text-align: left;">
                <label style="text-align: right;">User ID</label>
                <input type="text" name="userid" id="userid" value="<%= userid%>" style="width:80px;" disabled onblur="checkUsername(this.value)">
            </div>
            <div class="block" style="margin-left: 30px; top: 40px; text-align: left;">
                <label style="text-align: right;">User Name</label>
               <input type="text" name="username" id="username" value="<%= username%>" style="width:80px;" <% if(request.getParameter("action").equals("edit")){ %>disabled<% } %> onblur="checkUsername(this.value)">
                    <span id="userinfo" style="color:red; font-size:12px;"></span>
            </div>
            <div class="block" style="margin-left: 30px; top: 70px; text-align: left;">
                <label style="text-align: right;">Last Name</label>
                <input type="text" name="lastname" id="lastname" value="<%= lastname%>" required>
            </div>
            <div class="block" style="margin-left: 30px; top: 100px; text-align: left;">
                <label style="text-align: right;">First Name</label>
               <input type="text" name="firstname" id="firstname" value="<%= firstname%>" required>
            </div>
            <% if(request.getParameter("action").equals("add")){%>
            <div class="block" style="margin-left: 30px; top: 130px; text-align: left;">
                <label style="text-align: right;">Password</label>
                <input type="password" name="password" id="password" value="" required>
            </div>
            <div class="block" style="margin-left: 10px; top: 160px; text-align: left;">
                <label style="text-align: right; width: 120px;">Confirm Password</label>
                <input type="password" name="hd_password" id="hd_password" value="" required onblur="checkPassword();">
            </div>
            <%}%>
            <div class="block" style="margin-left: 320px; top: 10px;">
                <label>Status</label>
                <select name="password_status" id="password_status" style="width: 100px;">
                    <% if(password_status.equals("1")){%>
                        <option value="1" selected>Active</option>
                        <option value="2">Lock</option>
                    <%} else if(password_status.equals("2")){%>
                        <option value="1" >Active</option>
                        <option value="2" selected>Lock</option>
                    <%} else {%>
                        <option value="1" >Active</option>
                        <option value="2" >Lock</option>
                    <%}%>
                </select>
            </div>
            <div class="block" style="margin-left: 320px; top: 40px; text-align: left;">
                <label style="text-align: right;">Role</label>
                <input type="checkbox" name="role" id="role" value="1" <% if(groups == null){%>checked <%} else if(role.equals("1")){%>checked<%}%>><label>Administrator</label>
            </div><br>
        <table style="width:100%;  padding:5px; background-color: transparent; margin-top: 170px;" border="0">
            <tr>
                <td><br>
                    <fieldset style="width:500px; margin:auto;">
                        <legend>Modules</legend>
                        <table style="background-color: transparent;"  border="0">
                            <tr>
                                <td style="padding: 5px; width: 100px;"> <input type="checkbox" name="hd_module" id="hd_module" value="1" <%if(booking.equals("1")){%>checked<%}%>><label>Booking</label> </td>
                                <td style="padding: 5px;"> <input type="checkbox" name="hd_module" id="hd_module" value="1" <%if(pos.equals("1")){%>checked<%}%>><label>POS</label> </td>
                            </tr>
                        </table>
                    </fieldset>    
                </td>
            </tr>
            <tr>
                <td colspan="2"><br><br>
                    <fieldset style="width:500px; margin:auto;">
                        <legend>Groups</legend>
                        <%
                        
                        String query = "";
                        if(groups == null){
                            query = "SELECT group_name, group_id, null checked FROM was_gui_groups order by group_name";
                        }else if(groups.equals("")){
                            query = "SELECT group_name, group_id, null checked FROM was_gui_groups order by group_name";
                        } else {
                            query = "SELECT groups.group_name, groups.group_id, groups1.group_name checked FROM was_gui_groups groups left join (select group_id, group_name from was_gui_groups where group_id in ("+groups.replace('^', ',')+") ) groups1 on groups.group_id = groups1.group_id order by groups.group_name";
                        }
                        Connection conn = DBConnection();
                        PreparedStatement qrySelect = conn.prepareStatement(query);
                        ResultSet strQuery = qrySelect.executeQuery();
                        Integer x = 0;
                        Integer y = 0;
                        %>
                        <table  style="width:100%;  padding:5px; background-color: transparent;" border="0">
                            <% while(strQuery.next()){
                                ++x;
                                String iVal = strQuery.getString("checked");
                                if ( (x & 1) == 0 ) { y = 0; } else { y = 1; }

                                if(y > 0){
                                %>
                                <tr>
                                <% } %>
                                <td style="font-size:14px; padding-left: 10px;">
                                    <input type="checkbox" name="groups" id="groups" value="<%= strQuery.getString("group_id") %>" 
                                    <%if(iVal != null){%>checked<%}%>>
                                    <label><%= strQuery.getString("group_name") %></label>
                                </td>
                                
                                <% if(y == 0){%>
                                </tr>
                                <% } 
                            } %>
                        </table>
                    </fieldset>
                </td>
            </tr>
            <tr>
		<td colspan="2" style="text-align: center"><br>
                    <input type="submit" name="Update" id="Update" value="Update" onclick="CheckModules(); GetInputName('strField'); GetRecord('strValue')"  <%if(request.getParameter("action").equals("edit")){ if(session.getAttribute("userid").equals(Integer.parseInt(decrypt(request.getParameter("p_id"))))){%>disabled<%} }%>>
                    <input type="button" value="Back" name="back" id="back" onclick="window.location.assign('<%= baseURL()%>administrator/users_authorization.jsp')">
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
        
<% } else {%>
<div style="width:700px; margin: auto; margin-top: 50px; ">
<h2>Users List</h2>
    <div class="component" >
	<table>
            <thead>
		<tr>
                    <th style="width: 25%; padding:10px;">User ID</th>
                    <th style="width: 25%; padding:10px;">User Name</th>
                    <th style="width: 30%; padding:10px;">Full Name</th>
                    <th style="text-align:right; margin-left:8px; padding:10px"><a oncontextmenu="return false;" href="<%= baseURL()%>administrator/users_authorization.jsp?action=add" class="add_emp" title="Add Category"><span class="typcn typcn-plus-outline" >Add</span></th>
		</tr>
            </thead>
            <tbody id="displaylist">
                <%
                Connection conn = DBConnection();
                PreparedStatement qrySelect = conn.prepareStatement("SELECT userid, username, firstname, lastname FROM was_user_info order by userid");
                ResultSet strQuery = qrySelect.executeQuery();
                while(strQuery.next()){
                %>
                <tr>
                    <td><%= strQuery.getString("userid") %></td>
                    <td><%= strQuery.getString("username") %></td>
                    <td><%= strQuery.getString("firstname") %> <%= strQuery.getString("lastname") %></td>
                   <td style="text-align:right; width: 30%"><a oncontextmenu="return false;" href="<%= baseURL()%>administrator/users_authorization.jsp?action=edit&p_id=<%= URLEncoder.encode(encrypt(strQuery.getString("userid")),"UTF-8") %>" class="action" id="edit" ><span class="typcn typcn-pencil" title="Edit"></span>Edit</a>&nbsp;&nbsp;&nbsp;<a oncontextmenu="return false;" href="#" class="action" id="delete" <%if(!session.getAttribute("userid").equals(Integer.parseInt(strQuery.getString("userid")))){%> onclick="DeleteRecord('<%= strQuery.getString("userid") %>')" <%}%> title="Delete"><span class="typcn typcn-trash"></span>Delete</a></td>
                </tr>	
                <%}%>
            </tbody>
        </table>
        <form action="users_authorization.jsp" method="post" name="WASForm" id="WASForm" autocomplete="off" style="padding:10px;">
            <input type="submit" name="UniqueVal" id="UniqueVal" value="" style="display:none;">
            <input type="hidden" name="table" id="table" value="was_user_info">
            <input type="hidden" name="whereField" id="whereField" value="userid">
        </form>

    </div>
    <input type="button" value="Done" name="back" id="back" onclick="window.location.assign('<%= baseURL() %>main.jsp')">
</div>
<% } 
 if (update){
%>
<script>alert('Update Successfully!')</script>
<%
 }
%>
<script>
function DeleteRecord(value){
    if (confirm('Are you sure you want to delete?')){
        document.getElementById("UniqueVal").value = value;
        document.getElementById("UniqueVal").click();
    }
}
        
function checkPassword(){
    if(document.getElementById("password").value != "" && document.getElementById("hd_password").value != ""){
        if(document.getElementById("password").value != document.getElementById("hd_password").value){
            alert('Password not match!');
            document.getElementById("password").focus();
        }
   }
}

function checkUsername(value){
    document.getElementById("userinfo").innerHTML = "<img src='../images/ajax-loader.gif'>";
    setTimeout(function(){ 
        $.ajax({
            url: 'user_function.jsp',
            data: {username_add:value},
            type: 'GET',
            success: function(response) {
                ShowLoading();
                if (response.trim() != "null"){
                    document.getElementById("userinfo").innerHTML = "Username already exist!";
                    document.getElementById("username").focus();
                } else {
                    document.getElementById("userinfo").innerHTML = "";
                }
                HideLoading();
            }
        });
    }, 200);
}

function CheckModules() {
    var strValue = "";
    var checkboxes = document.getElementsByName("hd_module");
    var vals = "";
    for (var i=0, n=checkboxes.length;i<n;i++) {
        if (checkboxes[i].checked) {
            vals += ""+checkboxes[i].value;
        } else {
            vals += "0";
        }
    }
    strValue = vals;
    document.getElementById('modules').value = strValue;
}
</script>    
<%@include file="../footer.jsp"%>