<%@page import="java.sql.*"%>
<%@include file="was_function.jsp"%>
<%@include file="classes.jsp"%>

<%!
public Integer CheckProductCategoryID(String strID){
    try {
    Integer counter = 0;
    ResultSet strCounter = DB_Select("*", "wasi_cs_product_category","product_category_id = '"+strID+"'","","");
    while(strCounter.next()){
        counter  = counter+1 ;
    }
    return counter;
    }  catch ( Exception err ) {
        err.getMessage() ;
    }
    return null;
}
%>

<%
if(request.getParameter("functionname").equals("CheckProductCategoryID")){
    out.println(CheckProductCategoryID(request.getParameter("strValue")));
}
%>