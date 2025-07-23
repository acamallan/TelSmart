<%@page import="java.util.Calendar"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>

<%!
public String baseURL(){
   String baseURL = getServletContext().getInitParameter("baseURL");
    return baseURL;
}

public String CurrentDate(){
    Date date = Calendar.getInstance().getTime();
    DateFormat formatter = new SimpleDateFormat("MM.dd.yyyy");
    String today = formatter.format(date);
    return today;
}
/*
public String MessageInfo(String strClass, String msg){
	System.out.println( "<script>");
	System.out.println( "$(function() {");		
	System.out.println( "$.notifyBar({ cssClass: '"+strClass+"', html: '"+msg+"' });");
	System.out.println( "});");
	System.out.println( "</script>");
}*/

%>
