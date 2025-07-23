<%@page import="java.io.File"%>
<%@ page import="wAYA.ExportReport"%>

<%@include file="was_function.jsp"%>
<%@include file="classes.jsp"%>

<%! 
public String ExportToPDF(String div, String reportname){
    try {
    String ReportPathGenerated= getServletContext().getInitParameter("ReportPathGenerated");
    String baseURL= getServletContext().getInitParameter("baseURL");
    ExportReport report = new ExportReport();
    report.ExportToPDF(div,ReportPathGenerated,reportname,baseURL);
    return ReportPathGenerated+reportname+".pdf";
    } catch (Exception err) {
        Logger("error", err.getMessage());
    }
    return null;
}
%>


<%
if(request.getParameter("functionname").equals("ExportToPDF")){
    out.println(ExportToPDF(request.getParameter("div"),request.getParameter("reportname")));
}

if(request.getParameter("functionname").equals("DeleteFile")){
    File f=new File(request.getParameter("path"));
    f.delete();
}
%>
