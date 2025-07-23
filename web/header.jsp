<%
if(session.getAttribute("userid") == null) {  
    response.sendRedirect(baseURL()+"index.jsp");
    return;
}
%>

<%@page import="java.net.URLEncoder"%>
<%@page import="java.sql.*"%>
<%@include file="functions/was_function.jsp"%>
<%@include file="functions/classes.jsp"%>


<% 
String uri = request.getRequestURI();
String userRole = (String)session.getAttribute("role");
if(!CheckPage(uri,userRole,(String)session.getAttribute("username"))){
    response.sendRedirect(baseURL()+"unauthorized_access.jsp");
    return;
}
String pageName = uri.substring(uri.lastIndexOf("/")+1);
Integer userid1 = (Integer)session.getAttribute("userid");

/*Initialize variables*/
String table = "";
String fields = "";
String mainWhere = "";
String where = "";
String orderby = "";
String amendableFields = "";
String requiredFields = "";
String enableFields = "";
String pageMode = "";
Logs WAS = new Logs();

DateFormat formatter = new SimpleDateFormat("MM.dd.yyyy hh:mm aa");
String current_login = formatter.format(session.getAttribute("current_login"));
String last_login = formatter.format(session.getAttribute("last_login"));
%>

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    <meta http-equiv="content-type" content="application/pdf">
    <meta http-equiv="content-type" content="application/download">
    <meta http-equiv="Cache-control" content="no-cache">
    <meta http-equiv="Expires" content="-1">
    <title>TelSMART - <% out.println(session.getAttribute("institution_name")); %></title>
    <script type="text/javascript" src="<%= baseURL()%>scripts/jquery_1.9.1.js"></script>
    <script type="text/javascript" src="<%= baseURL()%>scripts/jquery-ui.js"></script>
    <script type="text/javascript" src="<%= baseURL()%>scripts/jquery.notifyBar.js"></script>
    <script type="text/javascript" src="<%= baseURL()%>scripts/jquery.touchSwipe.min.js"></script>
    <script type="text/javascript" src="<%= baseURL()%>scripts/sidebar.js"></script>
    <script type="text/javascript" src="<%= baseURL()%>scripts/scripts.js"></script>
    <script type="text/javascript" src="<%= baseURL()%>scripts/jquery.mask.min.js"></script>
    <script type="text/javascript" src="<%= baseURL()%>scripts/sweetalert-dev.js"></script>
    <script type="text/javascript" src="<%= baseURL()%>scripts/Chart.js"></script>
    <script type="text/javascript" src="<%= baseURL()%>scripts/jquery-idleTimeout.js"></script>
    <script type="text/javascript" src="<%= baseURL()%>scripts/store.min.js"></script>
    <script type="text/javascript" src="<%= baseURL()%>scripts/menu.js"></script>
    <!-- Encryption -->
    <script type="text/javascript" src="<%= baseURL()%>scripts/security.js"></script>
    
    <% if(uri.contains("/pages/") && (!uri.contains("rpt.jsp"))){%>
        <script type="text/javascript" src="<%= baseURL()%>scripts/form.js"></script>
        <script type="text/javascript" src="<%= baseURL()%>scripts/filterNav.js"></script>
        <script type="text/javascript" src="<%= baseURL()%>scripts/record.js"></script>
    <%}%>
    
    <% if(uri.contains("rpt.jsp")){%>
        <script type="text/javascript" src="<%= baseURL()%>scripts/record.js"></script>
        <script type="text/javascript" src="<%= baseURL()%>scripts/cardnumber.js"></script>
        <script type="text/javascript" src="<%= baseURL()%>scripts/reports.js"></script>
        <script type="text/javascript" src="<%= baseURL()%>scripts/jspdf.js"></script>
        <link href="<%= baseURL()%>styles/keypad.css" rel="stylesheet" type="text/css" media="all">
    <%}%>
    
    <% if(pageName.equals("main.jsp") && session.getAttribute("booking").equals("1")){%>  
        <script type="text/javascript" src="<%= baseURL()%>scripts/record.js"></script>
        <script type="text/javascript" src="<%= baseURL()%>scripts/main.js"></script>
        <script type="text/javascript" src="<%= baseURL()%>scripts/BScheduler.js"></script>
        <link href="<%= baseURL()%>styles/BScheduler.css" rel="stylesheet" type="text/css" media="all">
    <% } %>
    
    <link href="<%= baseURL()%>styles/icons.css" rel="stylesheet" type="text/css" media="all">
    <link href="<%= baseURL()%>styles/sidebar.css" rel="stylesheet" type="text/css" media="all">
    <link href="<%= baseURL()%>styles/style.css" rel="stylesheet" type="text/css" media="all">
    <link href="<%= baseURL()%>styles/jquery.notifyBar.css" rel="stylesheet" type="text/css" media="all">	
    <link href="<%= baseURL()%>styles/jquery-ui.css" rel="stylesheet" type="text/css" media="all">
    <link href="<%= baseURL()%>styles/sweetalert.css" rel="stylesheet" type="text/css" media="all">
    <link href="<%= baseURL()%>styles/menu.css" rel="stylesheet" type="text/css" media="all">
    
    <!--Menu tree -->
    <link rel="stylesheet" type="text/css" href="<%= baseURL()%>plugin/menutree/css/multi/tree.css">
    <script type="text/javascript" src="<%= baseURL()%>plugin/menutree/build/yahoo.js" ></script>
    <script type="text/javascript" src="<%= baseURL()%>plugin/menutree/build/event.js"></script>
    <script type="text/javascript" src="<%= baseURL()%>plugin/menutree/build/treeview.js" ></script>
    <script type="text/javascript" src="<%= baseURL()%>plugin/menutree/build/jktreeview.js" ></script>
    <script>
        sessionStorage.setItem('logout', false);
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
        
        function logout(){
            sessionStorage.setItem('logout', true);
        }
        function baseURL(){
            return '<%= getServletContext().getInitParameter("baseURL") %>';
        }
        
    </script>
    
    <style type="text/css">
    </style>
  
</head>

<body class="modal" <% if(uri.contains("pos_sales_rpt.jsp")){%> onload="RealTime()" <%}%> >
    <div class="header">
	<div style="float:left;"><p style="font-size:20px; padding:10px; margin:0px; font-weight: bold; letter-spacing: 1px; ">Fin<span style="color:#000000;">SMART</span></p></div>
        <!-- Generate Main Menu -->
        <%= generate_main_menu((String) session.getAttribute("role"), uri, baseURL()) %>
        
        <% if(uri.contains("pos_sales_rpt.jsp")){%>
            <div style="float:left; font-size: 16px; font-weight: bold; padding: 10px; margin-left: 400px;  display: inline-block; ">
                Station: <span style="color:#000000;">BAR</span> &nbsp;&nbsp;&nbsp; <div id="realTime" style="display: inline-block;"></div>
            </div>
        <%}%>
        
	<div style="float:right; padding:10px;"> 
            <div class="dropdown">
                <a oncontextmenu="return false;" class="account" > <img src="<%= baseURL()%>images/profile_24.png"><%= session.getAttribute("firstname")%> <%= session.getAttribute("lastname")%></a>
                <div class="submenu">
                    <ul class="root">
                    <!--<li ><a oncontextmenu="return false;" href="#Dashboard" >Profile</a></li> -->
                    <li><a oncontextmenu="return false;" href='<%= baseURL()%>administrator/change_password.jsp?action=edit&p_id=<%= URLEncoder.encode(encrypt(Integer.toString(userid1))) %>'>Change Password</a></li>
                    <li><a oncontextmenu="return false;" href="#" onclick="$.fn.idleTimeout().logout();" tabindex="-1" title="Signout">Signout</a></li>
                    </ul>
                </div>
                
            </div>
                    <div class="signout"><a oncontextmenu="return false;" href="<%= baseURL()%>logout.jsp?logout=1" onclick="logout();" tabindex="-1" title="Signout"> <img src="<%= baseURL()%>images/signout_32.png" ></a></div>
        </div>
        <div style="float:right; padding:8px; font-size: 11px;">
            <span> <b>Current Login:</b> <%= current_login %> </span> <br>
            <span> <b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Last Login:</b> <%= last_login %></span>
        </div>
    </div>
    <% if(session.getAttribute("userid") != null){%>
    <div class="container <% //if(pageName.equals("main.jsp")){ open-sidebar%>  <% //} %>">
	<div id="sidebar">
            <ul>
		<li ><a oncontextmenu="return false;" href='<%= baseURL()%>main.jsp' tabindex="-1">Dashboard</a></li>
                <% if(session.getAttribute("pos").equals("1")){%><li ><a oncontextmenu="return false;" href='<%= baseURL()%>pages/pos_sales_rpt.jsp' tabindex="-1">POS</a></li><%}%>
                <% if(session.getAttribute("role").equals("1")){%>
                <!--<li class='has-sub'><a oncontextmenu="return false;" href='#' tabindex="-1">Administration</a>
                    <ul>
                        <li><a oncontextmenu="return false;" href='<%= baseURL()%>administrator/groups_authorization.jsp'>&nbsp;&nbsp;&nbsp;&nbsp; Groups Authorization</a></li>
                        <li><a oncontextmenu="return false;" href='<%= baseURL()%>administrator/users_authorization.jsp'>&nbsp;&nbsp;&nbsp;&nbsp; Users Authorization</a></li>
                        <li><a oncontextmenu="return false;" href='<%= baseURL()%>administrator/change_user_password.jsp'>&nbsp;&nbsp;&nbsp;&nbsp; Change Password</a></li>  
                        <li><a oncontextmenu="return false;" href='<%= baseURL()%>administrator/configuration.jsp'>&nbsp;&nbsp;&nbsp;&nbsp; Configuration</a></li>
                        <li><a oncontextmenu="return false;" href='<%= baseURL()%>administrator/security.jsp'>&nbsp;&nbsp;&nbsp;&nbsp; Security</a></li>  
                        <li><a oncontextmenu="return false;" href='<%= baseURL()%>administrator/table_maintenance.jsp'>&nbsp;&nbsp;&nbsp;&nbsp; Maintenance</a></li>  
                    </ul>
		</li> -->
                <%}%>
            </ul>
            <div id="tree2" style="padding: 10px; height:500px; width:220px; overflow: auto;"></div>
            <%= generate_user_menu((String)session.getAttribute("groups")) %>
	</div>
        <div class="main-content" id="main-content">
            <div class="swipe-area"></div>
            <a oncontextmenu="return false;" href="#" data-toggle=".container" id="sidebar-toggle" onclick="AdjustWidth()" tabindex="-1" title="Dashboard">
                <span class="bar"></span>
                <span class="bar"></span>
                <span class="bar"></span>
            </a>
            <a oncontextmenu="return false;" href="<%= baseURL()%>main.jsp" id="home" tabindex="-1" <% if(pageName.equals("main.jsp")){%> style="display:none;" <%}%> >
                <img src="<%= baseURL()%>images/Home-32.png">
                <input type="hidden" name="hd_home" id="hd_home" value="<% if(pageName.equals("main.jsp")){%> 0 <% } else {%> 1 <%}%>">
            </a>
            
        </div>
    </div> 
    <%}%>
    
    <div class="content" id="content" style="<% if(uri.contains("rpt.jsp") || uri.contains("main.jsp")){%> height:93%;<% } else {%>height:90%;<% } %>">
        