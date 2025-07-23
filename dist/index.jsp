<%@page import="java.sql.ResultSet"%>

<%@include file="functions/was_function.jsp"%>
<%@include file="functions/classes.jsp"%>
<%@ page import="wAYA.Login"%>
<%@ page import="wAYA.Configuration"%>

<%
Connection conn = DBConnection();
Configuration Config = new Configuration();
ResultSet getConfig = Config.getConfig(conn);
while (getConfig.next()){
    session.setAttribute(getConfig.getString("config_name"), getConfig.getString("config_value"));
}

%>

<!DOCTYPE html>
<html>
<head>
<title>TelSMART</title>
<meta charset="utf-8">
<link href="styles/login.css" rel="stylesheet" type="text/css" media="all">

<script>
    $(document).ready(function () {
        <%
        Integer secondsBeforeExpire = new Integer(session.getMaxInactiveInterval());
        %>
        var secondsBeforeExpire = <%= secondsBeforeExpire %>;
        var secondsBeforeExpire = secondsBeforeExpire - 30;
        $(document).idleTimeout({
            redirectUrl: '<%= baseURL()%>logout.jsp',       // redirect to this url
            idleTimeLimit: secondsBeforeExpire,            // 15 seconds 'No activity' time limit in seconds.
            activityEvents: 'click keypress scroll wheel mousewheel',    // separate each event with a space
            dialogDisplayLimit: 30,       // Time to display the warning dialog before logout (and optional callback) in seconds
            sessionKeepAliveTimer: false  // Set to false to disable pings.
        });
    });
        
</script>
</head>
<body  onload="document.getElementById('username').focus();" >

<%
Boolean isGood = false;
String username = request.getParameter("username");
String password = request.getParameter("password");
String errMsg = "";
if( username!= null){
    Login login = new Login();
    String checkStatus = login.CheckStatus(username, conn);
    if(!checkStatus.equals("")){
        String[] check = checkStatus.split(",");
        Integer PasswordStatus = Integer.parseInt(check[0]);
        Integer PasswordFailed = Integer.parseInt(check[1]);
        if(PasswordStatus.equals(1)){
            ResultSet getUserInfo = login.CheckPassword(username, password, conn);
            while (getUserInfo.next()){
                session.setAttribute("userid", getUserInfo.getInt("userid"));
                session.setAttribute("username", getUserInfo.getString("username"));
                session.setAttribute("lastname", getUserInfo.getString("lastname"));
                session.setAttribute("firstname", getUserInfo.getString("firstname"));
                session.setAttribute("role", getUserInfo.getString("role"));
                session.setAttribute("groups", getUserInfo.getString("groups"));
                session.setAttribute("current_login", getUserInfo.getTimestamp("current_login"));
                session.setAttribute("last_login", getUserInfo.getTimestamp("last_login"));
                session.setAttribute("record_date", CurrentDate());
                String[] modules = getUserInfo.getString("modules").split("");
                session.setAttribute("booking", modules[0]);
                session.setAttribute("pos", modules[1]);
                ResultSet getClientInfo = Config.getClientInfo(getUserInfo.getInt("institution_id"), conn);
                while (getClientInfo.next()){
                    session.setAttribute("institution_id", getClientInfo.getString("institution_id"));
                    session.setAttribute("institution_name", getClientInfo.getString("institution_name"));
                }
                isGood = true;
                errMsg = "";
            }
            if (!isGood){
                Integer failed = PasswordFailed + 1;
                Integer PasswordFailedConfig = Integer.parseInt((String)session.getAttribute("PasswordFailed")); 
                if(PasswordFailedConfig.equals(failed)){
                    login.UpdatePasswordStatus(username,conn);
                } else {
                    login.UpdatePasswordFailed(username,failed,conn);
                }
                errMsg = "Invalid Username or Password";
            }
        } else if(PasswordStatus.equals(2)){
            errMsg = "Username is lock. Please contact your administrator.";
        }
    } else {
        errMsg = "Invalid Username or Password";
    }
}

if(conn != null) {
    conn.close();
}
if (isGood || session.getAttribute("userid") != null){
%>
    <script>
    window.open("main.jsp", "_blank", "height=" + screen.height + ",width=" + screen.width + ",scrollbars=yes, titlebar=no");
    window.close();
    </script> 
<%
} 
%>

<div id="login">
    <h1 style="font-weight: bold;">Tel<span style="color:#000000;">SMART</span></h1>
    <form action="index.jsp" method="post" autocomplete="off">
	<%
	if (!isGood){
	%>
            <div id="errLog"><%= errMsg%></div>
	<%
	}
	%>
    <input type="text" name="username" id="username" placeholder="Username" required/>
    <input type="password" name="password" placeholder="Password" autocomplete="off" required/>
    <input type="submit" value="Log in" />
  </form>
</div>

</body>
</html>