<%@page import="java.sql.*"%>
<%@include file="../header.jsp"%>
<%@include file="../functions/record_function.jsp"%>

<% 
Boolean update = false;
if(request.getParameter("Update") != null && (session.getAttribute("isSubmit") == null || (!session.getAttribute("isSubmit").equals(request.getParameter("strValue"))))){
    session.setAttribute("isSubmit",request.getParameter("strValue")) ;
    Connection conn = DBConnection();
    
    PreparedStatement qrySelect = conn.prepareStatement("SELECT node_number, menu_id, menu_name, parent_id, module_name from was_gui_menu_tree where node_number in ("+request.getParameter("strNode")+")");
    ResultSet qryViewTree = qrySelect.executeQuery();
    PreparedStatement qryDelete = conn.prepareStatement("delete from was_gui_user_menu_tree where group_id = "+request.getParameter("group_id"));
    qryDelete.executeUpdate();
    
    /* Insert Group */
    PreparedStatement qryDeleteGroup = conn.prepareStatement("delete from was_gui_groups where group_id = "+request.getParameter("group_id"));
    qryDeleteGroup.executeUpdate();
    String qryInsertGroup = "insert into was_gui_groups(group_id, group_name, description) values ('"+request.getParameter("group_id")+"','"+request.getParameter("group_name")+"','"+request.getParameter("description")+"')";
    Statement stmtGroup = conn.createStatement();
    stmtGroup.executeUpdate(qryInsertGroup);
    
    /*Insert group pages*/
    while (qryViewTree.next()){
        String qryInsert = "insert into was_gui_user_menu_tree(group_id, node_number, menu_id, menu_name, parent_id, module_name) values ('"+request.getParameter("group_id")+"','"+qryViewTree.getString("node_number")+"','"+qryViewTree.getString("menu_id")+"','"+qryViewTree.getString("menu_name")+"','"+qryViewTree.getString("parent_id")+"','"+qryViewTree.getString("module_name")+"')";
        Statement stmt = conn.createStatement();
	stmt.executeUpdate(qryInsert);
        update = true;
    }
}

/* ----- Delete ----- */
if(request.getParameter("UniqueVal") != null){
    Integer strValue =DeleteRecord(encrypt(request.getParameter("table")),encrypt(request.getParameter("whereField")),encrypt(request.getParameter("UniqueVal")));
    DeleteRecord(encrypt("was_gui_user_menu_tree"),encrypt("group_id"),encrypt(request.getParameter("UniqueVal")));
    if(strValue == 1){
        out.println("<script>alert('Delete Record Successfully!')</script>");
    }
}

if(request.getParameter("action") != null){ 
     Integer group_id = 0;
     String group_name = "";
     String description = "";
    if(request.getParameter("action").equals("edit")){
        Connection conn = DBConnection();
        PreparedStatement query = conn.prepareStatement("SELECT group_id, group_name, description from was_gui_groups where group_id = '"+decrypt(request.getParameter("p_id"))+"'");
        ResultSet strQuery = query.executeQuery();
        strQuery.next();
        group_id = strQuery.getInt("group_id");
        group_name = strQuery.getString("group_name");
        description = strQuery.getString("description");
    } else {
        Connection conn = DBConnection();
        PreparedStatement query = conn.prepareStatement("SELECT max(group_id) group_id from was_gui_groups ");
        ResultSet strQuery = query.executeQuery();
        strQuery.next();
       group_id = strQuery.getInt("group_id")+1;
        group_name = "";
        description = "";
    }
    
%>  

<script src="<%= baseURL()%>plugin/dynatree/jquery/jquery.cookie.js" type="text/javascript"></script>
<script src="<%= baseURL()%>plugin/dynatree/jquery.dynatree.js" type="text/javascript"></script>
<link href="<%= baseURL()%>plugin/dynatree/skin-vista/ui.dynatree.css" rel="stylesheet" type="text/css" id="skinSheet">
<%= generate_config_menu(group_id) %>

<script>
    $(function(){
	$("#tree").dynatree({
            checkbox: true,
            selectMode: 3,
            children: treeData,
            onSelect: function(select, node) {
		// Get a list of all selected nodes, and convert to a key array:
		var selKeys = $.map(node.tree.getSelectedNodes(), function(node){
                    return node.data.key;
                });
                selKeys = selKeys.toString();
                var selTitle = $.map(node.tree.getSelectedNodes(), function(node){
                    return node.data.title;
                });
                selTitle = selTitle.toString();
                var selSelect = $.map(node.tree.getSelectedNodes(), function(node){
                    return node.data.unselectable;
                });
                selSelect = selSelect.toString();
                var selFolder = $.map(node.tree.getSelectedNodes(), function(node){
                    return node.data.isFolder;
		});
                selFolder = selFolder.toString();

                $("#echoSelection").text("");
                document.getElementById("strNode").value=selKeys;
                selTitle = selTitle.split(",");
                selFolder = selFolder.split(",");
                for (var i=0; i < selTitle.length; i++){
                    if(selFolder[i] == "false"){
                        $("#echoSelection").append(selTitle[i]+"<br>");
                    }
                }
                },
		onDblClick: function(node, event) {
                    node.toggleSelect();
		},
		onKeydown: function(node, event) {
                    if( event.which == 32 ) {
			node.toggleSelect();
			return false;
                    }
		},
		cookieId: "dynatree-Cb3",
		idPrefix: "dynatree-Cb3-"
	});

        $("#btnToggleSelect").click(function(){
            $("#tree2").dynatree("getRoot").visit(function(node){
		node.toggleSelect();
            });
            return false;
	});
	$("#btnDeselectAll").click(function(){
            $("#tree2").dynatree("getRoot").visit(function(node){
		node.select(false);
            });
            return false;
	});
	$("#btnSelectAll").click(function(){
            $("#tree2").dynatree("getRoot").visit(function(node){
		node.select(true);
            });
	return false;
	}); 
    });
</script>
<h2 style="margin-left:320px;">Add Group</h2>
<form action="groups_authorization.jsp" method="post" name="WASForm" id="WASForm" autocomplete="off">
    <table style="width:200px; padding:10px;" border="0" align="center">
        <tr>
            <td colspan="2">
                <table border="0">
                    <tr>
                        <td style="float:right; padding: 12px;" valign="center">
                            Group Name
                        </td>
                        <td >
                            <input type="text" name="group_name" id="group_name" value="<%= group_name%>" required >
                        </td>
                    </tr>
                     <tr>
                        <td style="float:right; padding: 12px;" valign="center">
                            Group Name
                        </td>
                        <td >
                            <textarea name="description" id="description" style="width: 300px; height: 50px;"><%= description%></textarea><br><br>
                        </td>
                    </tr>
                </table>
            </td>
	</tr>
        <tr>
            <td style="padding:5px; font-weight: bold;">System Pages</td>
            <td style="padding:5px; font-weight: bold;" valign="top">Group Pages</td>
	</tr>
	<tr>
            <td style="padding:5px; background:#3399CA; border:1px solid #ccc;"><div id="tree" style="width:250px; height:280px; background:#FFF;  padding:10px;overflow: auto;"></div></td>
            <td style="padding:5px; background:#3399CA; border:1px solid #ccc;" valign="top"><div style="width:250px; height:280px; background:#FFF; padding:10px;overflow: auto;"><span id="echoSelection">
                <%if(request.getParameter("action").equals("edit")){
                    Connection conn = DBConnection();
                    PreparedStatement query = conn.prepareStatement("SELECT menu_name from was_gui_user_menu_tree where group_id =  '"+decrypt(request.getParameter("p_id"))+"' and menu_id <> 'parent_menu' order by node_number");
                    ResultSet strQuery = query.executeQuery();
                    while(strQuery.next()){
                    %>
                    <%= strQuery.getString("menu_name") %><br>
                    <%
                    }
                }
                %>
                </span></div>
            </td>
	</tr>
	<tr>
            <td colspan="2" align="center"><br>
                <input type="button" name="button" id="button" value="Update" onclick="GetInputName('strField'); GetRecord('strValue'); checkPages();"  >
		<input type="button" value="Back" name="back" id="back" onclick="window.location.assign('<%= baseURL()%>administrator/groups_authorization.jsp')">
                <input type="submit" name="Update" id="Update" value="Update" style="display:none;">
            </td>
	</tr>
    </table>
    <input type="hidden" name="group_id" id="group_id" value="<%= group_id %>">
    <input type="hidden" name="strNode" id="strNode" value="">
    <input type="hidden" name="strField" id="strField" value="">
    <input type="hidden" name="strValue" id="strValue" value="">
    <input type="hidden" name="strAction" id="strAction" value="">
    <input type="hidden" name="mode" id="mode" value="">
</form>
<%
} else {
%>
<div style="width: 500px; margin:auto; margin-top: 100px;">
<h2 style="margin-top:-2px;">Groups List</h2>
    <div class="component">
        <table>
            <thead>
		<tr>
                    <th style="padding:5px;">Group Name</th>
                    <th style="text-align:right; margin-left:8px;"><a href="<%= baseURL()%>administrator/groups_authorization.jsp?action=add" onclick="Add_JS();return false;" class="add_emp" title="Add Category"><span class="typcn typcn-plus-outline" >Add</span></th>
		</tr>
            </thead>
            <tbody id="displaylist">
            <%
            Connection conn = DBConnection();
            PreparedStatement qrySelect = conn.prepareStatement("SELECT group_id, group_name from was_gui_groups");
            ResultSet strQuery = qrySelect.executeQuery();
            while(strQuery.next()){
            %>
                <tr>
                    <td style="width: 70%"> <%= strQuery.getString("group_name") %></td>
                    <td style="text-align:right; width: 30%"><a href="<%= baseURL()%>administrator/groups_authorization.jsp?action=edit&p_id=<%= encrypt(strQuery.getString("group_id")) %>" class="action" id="edit" ><span class="typcn typcn-pencil" title="Edit"></span>Edit</a>&nbsp;&nbsp;&nbsp;<a href="#" class="action" id="delete" onclick="DeleteRecord('<%= strQuery.getString("group_id") %>')" title="Delete"><span class="typcn typcn-trash"></span>Delete</a></td>
		</tr>				
            <% } %>
            </tbody>
	</table>
        <form action="groups_authorization.jsp" method="post" name="WASForm" id="WASForm" autocomplete="off" style="padding:10px;">
            <input type="submit" name="UniqueVal" id="UniqueVal" value="" style="display:none;">
            <input type="hidden" name="table" id="table" value="was_gui_groups">
            <input type="hidden" name="whereField" id="whereField" value="group_id">
        </form>
    </div>
    <input type="button" value="Done" name="back" id="back" onclick="window.location.assign('<%= baseURL() %>main.jsp')">
</div>
<%
}

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

function checkPages(){
    if(document.getElementById('strNode').value == ""){
        alert("Can't Proceed. Please assign page/s to the group.");
        return false;
    } else {
       document.getElementById("Update").click(); 
    }
}
</script>
<%@include file="../footer.jsp"%>			