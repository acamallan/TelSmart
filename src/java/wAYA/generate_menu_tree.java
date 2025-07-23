package wAYA;
import java.sql.*;

/**
 *
 * @author acamallan
 */
public class generate_menu_tree {
    String strResult = null;
    Logs WAS = new Logs();
    UserAuthorization auth = new UserAuthorization();
    public String generate_user_menu(String usergroups, String baseURL, Connection conn){
        try{
        Integer strParentID = 0;
        Integer c = 0; 
        String where = "";
        if(!usergroups.equals("")){
            where = usergroups.replace('^', ',');
        } else {
            where = "-1";
        }
        PreparedStatement query = conn.prepareStatement("SELECT distinct b.node_number, a.menu_id, a.menu_name, b.parent_id, a.module_name from was_gui_user_menu_tree a, was_gui_menu_tree b  where group_id in ("+where+") and a.menu_id = b.menu_id and a.menu_name = b.menu_name order by 1");
        ResultSet strQuery = query.executeQuery();

        strResult = "<script type='text/javascript'>var menu=new jktreeview('tree2');";
        while(strQuery.next()){
            if(!strQuery.getString("menu_id").equals("parent_menu")){
                if(strParentID == strQuery.getInt("parent_id")){
                    strResult = strResult + "menu.addItem('"+strQuery.getString("menu_name")+"',menu_"+strParentID+",'"+baseURL+"pages/"+strQuery.getString("menu_id")+".jsp');";
                } else {
                    Integer xParent = strParentID-1;
                    strResult = strResult + "menu.addItem('"+strQuery.getString("menu_name")+"',menu_"+xParent+",'"+baseURL+"pages/"+strQuery.getString("menu_id")+".jsp');";
                }
            } else {
                if(c != 0){
                    if(strQuery.getInt("parent_id") == 0){
                        strResult = strResult + "var menu_"+strQuery.getInt("node_number")+"=menu.addItem('"+strQuery.getString("menu_name")+"');";
                    } else {
                        strResult = strResult + "var menu_"+strQuery.getInt("node_number")+"=menu.addItem('"+strQuery.getString("menu_name")+"',menu_"+strQuery.getInt("parent_id")+");";
                    }
                } else{			
                    strResult = strResult + "var menu_"+strQuery.getInt("node_number")+"=menu.addItem('"+strQuery.getString("menu_name")+"');";
                }
                strParentID = strQuery.getInt("node_number");
            }
            c = 1;
        }
        strResult = strResult + "menu.treetop.draw(); </script>"; //REQUIRED LINE: Initialize tree
        } catch(SQLException e){
            WAS.Logger("error", "generate_user_menu Function: " + e.getMessage());
        }

        return strResult;
    }

    public String generate_config_menu(Integer group_id, Connection conn){
        try {
        Integer strPrevParentID = 0;
        Integer strPrevParent = 0;
        Integer c = 0;
        Integer x = 0;
        String select = "";
        String path = " ";

        PreparedStatement query = conn.prepareStatement("SELECT distinct gui.node_number, gui.menu_id, gui.menu_name, gui.parent_id, gui.parent_path, IFNULL(user.node_number, 0) user_node_number, gui.module_name FROM was_gui_menu_tree gui left join  was_gui_user_menu_tree user on gui.menu_id = user.menu_id and  gui.menu_name = user.menu_name and user.group_id = "+group_id+" order by gui.node_number");
        ResultSet strQuery = query.executeQuery();

        strResult =  "<script type='text/javascript'> var treeData = [";
        while(strQuery.next()){
            if(!strQuery.getString("menu_id").equals("parent_menu")){
                if(!strQuery.getString("user_node_number").equals("0")){
                    select = ", select: true";
                    path = path + strQuery.getString("parent_path")+","+strQuery.getString("node_number")+",";
                }
                if(strPrevParentID <= strQuery.getInt("parent_id")){
                    strResult = strResult + "{title: '"+strQuery.getString("menu_name")+"', key: '"+strQuery.getString("parent_path")+","+strQuery.getString("node_number")+"' "+select+" }, ";
                } else {
                    strResult = strResult.substring(0, strResult.length() - 2);
                    strResult = strResult +  "]}, {title: '"+strQuery.getString("menu_name")+"', key: '"+strQuery.getString("parent_path")+","+strQuery.getString("node_number")+"' "+select+" }, ";
                }
                select = "";
                strPrevParentID = strQuery.getInt("parent_id");
            } else {
                if( c != 0){
                    if(strPrevParent < strQuery.getInt("parent_id") ){
                        x++;
                    } else {
                        if(isNumeric(strQuery.getString("module_name"))){
                            for (Integer i = 1; i <= strQuery.getInt("module_name"); i++) {
                                strResult = strResult.substring(0, strResult.length() - 2);
                                strResult = strResult + "]}, ";
                            }
                        } else  {
                            for (Integer i = 1; i <= x; i++) {
                                strResult = strResult.substring(0, strResult.length() - 2);
                                strResult = strResult + "]}, ";
                            } 
                        }
                        x = 0;
                    }
                    if(strQuery.getInt("parent_id") == 0){
                        strResult = strResult.substring(0, strResult.length() - 2);
                        strResult = strResult + "]}, {title: '"+strQuery.getString("menu_name")+"', isFolder: true,hideCheckbox: false, unselectable: false, key: '"+strQuery.getString("parent_path")+","+strQuery.getString("node_number")+"', children: [ ";
                    } else {
                        strResult = strResult + " {title: '"+strQuery.getString("menu_name")+"', isFolder: true,hideCheckbox: false, unselectable: false, key: '"+strQuery.getString("parent_path")+","+strQuery.getString("node_number")+"', children: [ ";
                    }   
                } else{			
                    strResult = strResult + "{title: '"+strQuery.getString("menu_name")+"', isFolder: true,hideCheckbox: false, unselectable: false, key: '"+strQuery.getString("parent_path")+","+strQuery.getString("node_number")+"', children: [ ";
                }
                strPrevParent = strQuery.getInt("parent_id");  
                select = "";
            }
            c = 1;
        }
        strResult = strResult.substring(0, strResult.length() - 2);
        path = path.substring(0, path.length() - 1);
        for (Integer i = 1; i <= x; i++) {
            strResult = strResult + "]}";
        }
        strResult = strResult + "]}]; $(function(){  document.getElementById(\"strNode\").value='"+path+"' });</script>";
        } catch(SQLException e){
            WAS.Logger("error", "generate_config_menu Function: " + e.getMessage());
        }
        return strResult;
    }
    
    public String generate_main_menu(String userRole, String uri, String baseURL){
        try{   
            String role = auth.DecryptRole(userRole);
            String strResult = "";
            if(role.equals("1") && uri.contains("main.jsp")){
                strResult = strResult + "<div style='margin-left:50px; position: relative; display: inline-block;'>";
                    strResult = strResult + "<div id='cssmenu'>";
                        strResult = strResult + "<ul>";
                            strResult = strResult + "<li class='has-sub'><a oncontextmenu='return false;' tabindex='-1' href='#' >Administrator</a>";
                                strResult = strResult + "<ul>";
                                    strResult = strResult + "<li class='has-sub'><a oncontextmenu='return false;' tabindex='-1' href='#'>Authorization</a>";
                                        strResult = strResult + "<ul>";
                                            strResult = strResult + "<li><a oncontextmenu='return false;' tabindex='-1' href='"+baseURL+"administrator/groups_authorization.jsp'>Groups Authorization</a></li>";
                                            strResult = strResult + "<li><a oncontextmenu='return false;' tabindex='-1' href='"+baseURL+"administrator/users_authorization.jsp'>Users Authorization</a></li>";
                                            strResult = strResult + "<li><a oncontextmenu='return false;' tabindex='-1' href='"+baseURL+"administrator/reset_password.jsp'>Reset Password</a></li>";
                                        strResult = strResult + "</ul>";
                                    strResult = strResult + "</li>";
                                    strResult = strResult + "<li class='has-sub'><a oncontextmenu='return false;' tabindex='-1' href='#'>Security</a>";
                                        strResult = strResult + "<ul>";
                                            strResult = strResult + "<li><a oncontextmenu='return false;' tabindex='-1' href='"+baseURL+"administrator/configuration.jsp'>Configuration</a></li>";
                                            strResult = strResult + "<li><a oncontextmenu='return false;' tabindex='-1' href='"+baseURL+"administrator/password_policy.jsp'>Password Policy</a></li>";
                                            strResult = strResult + "<li><a oncontextmenu='return false;' tabindex='-1' href='"+baseURL+"administrator/table_maintenance.jsp'>Maintenance</a></li>";
                                        strResult = strResult + "</ul>";
                                    strResult = strResult + "</li>";
                                strResult = strResult + "</ul>";
                            strResult = strResult + "</li>";
                        strResult = strResult + "</ul>";
                    strResult = strResult + "</div>";
                strResult = strResult + "</div>";
            }
        return strResult;
        } catch(Exception e){
            WAS.Logger("error", "generate_main_menu Function: " + e.getMessage());
        }
        return null;
    }

    public static boolean isNumeric(String str)  {  
        try {  
            double d = Double.parseDouble(str);  
        }  
        catch(NumberFormatException nfe){  
            return false;  
        }  
    return true;  
    } 
}
