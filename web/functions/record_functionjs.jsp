<%@page import="java.net.URLEncoder"%>
<%@page import="java.nio.file.*"%>
<%@page import="java.sql.*"%>
<%@include file="was_function.jsp"%>
<%@include file="classes.jsp"%>

<%!
public String AddNewRecord(String table, String fields, String values, String lstFields, String qryStmt){
    try{
	table = table;
	String[] field = fields.split(",");
	String[] value = values.split(",");
	Integer strCountFields = lstFields.split(",").length;
	Integer strLen = field.length;
	
	Integer diff = (strLen - strCountFields) + 2;
	String strFields = "";
	String strValues = "";
        String username = "";
	for (Integer x = 0; x <= strLen-diff; x++) {
            String CheckValue = "";
            if(field[x].equals("username")){/*restricted column. Used only in was_user_info*/
                username = value[x];
            }
            strFields = strFields + field[x] + ",";
            
            if(field[x].equals("password")){ /*restricted column. Used only in was_user_info*/
                strValues = strValues + "'" + generateHash(username+value[x]) + "',";
            } else { 
                CheckValue = value[x].replace("'","''");
                strValues = strValues + "'" + CheckValue + "',";
            }
	}
	strFields = strFields.substring(0, strFields.length() - 1);
        strValues = strValues.substring(0, strValues.length() - 1);
	Integer returnValue = DB_Insert(table,strFields,strValues,qryStmt);
        String strReturn = (String) returnValue.toString();
        return encryptJS(strReturn);
    }  catch ( Exception err ) {
        Logger("error", "AddNewRecord Function: " + err.getMessage());
    }
return  encryptJS("null");
}

public String UpdateRecord(String table, String fields, String values, String where, String rowid, String lstFields, String qryStmt){
    try{
	String[] field = fields.split(",");
	String[] value = values.split(",");
	Integer strCountFields = lstFields.split(",").length;
	Integer strLen = field.length;
	
	Integer diff = (strLen - strCountFields) + 2;
	String strSet = "";
	String set = "";
	for (Integer x = 0; x <= strLen-diff; x++) {
            String CheckValue = "";
            CheckValue = value[x].replace("'","''");
            set = field[x] + "='" + CheckValue + "'"; 
            strSet = strSet + set + ",";
            	
	}
	strSet = strSet.substring(0, strSet.length() - 1);
        String strWhere = " " + where + "='" + rowid + "'";
        Integer returnValue = DB_Update(table,strSet,strWhere,qryStmt);
        String strReturn = (String) returnValue.toString();
        return encryptJS(strReturn);
    }  catch ( Exception err ) {
        Logger("error", "UpdateRecord Function: " + err.getMessage());
    }
return  encryptJS("null");
}

public String DeleteRecord(String table, String where, String rowid){
        try {
	String whereFilter = "where "+where+"="+rowid;
	Integer returnValue = DB_Delete(table,whereFilter);
        String strReturn = (String) returnValue.toString();
        return encryptJS(strReturn);
    }  catch ( Exception err ) {
        Logger("error", "DeleteRecord Function: " + err.getMessage());
    }
    return  encryptJS("null");
}

public String UpdateDB(String updateStmt){
    try{
        Integer returnValue = Update_DB(updateStmt);
        String strReturn = (String) returnValue.toString();
        return encryptJS(strReturn);
    } catch(Exception err){
        Logger("error", "UpdateDB Function: " + err.getMessage());
    }
    return  encryptJS("null");
}

public String InsertDB(String insertStmt){
    try{
	Integer returnValue = Insert_DB(insertStmt);
        String strReturn = (String) returnValue.toString();
        return encryptJS(strReturn);
    } catch(Exception err){
    }
    return  encryptJS("null");
}

public String DeleteDB(String deleteStmt){
    try {
        Integer returnValue = Delete_DB(deleteStmt);
        String strReturn = (String) returnValue.toString();
        return encryptJS(strReturn);
    } catch(Exception err){
        Logger("error", "DeleteDB Function: " + err.getMessage());
    }
    return  encryptJS("null");
}

public String SelectDB(String selectStmt){
    try {
        String strReturn = Select_DB(selectStmt);
        return encryptJS(strReturn.replace("'","\'"));
    }  catch (Exception err ) {
        Logger("error", "SelectDB Function: " + err.getMessage());
    }
    return  encryptJS("null");
}

public String displayFilter(String fields, String table, String where, String orderby, String limit){
     try {
        ResultSet strSelect = DB_Select(fields, table, where, orderby, limit);
        String strReturn = "";
        if(strSelect.isBeforeFirst()){
            while (strSelect.next()) {
                int total_rows = strSelect.getMetaData().getColumnCount();
                for (int i = 0; i < total_rows; i++) {
                    strReturn = strReturn + strSelect.getString(strSelect.getMetaData().getColumnLabel(i+1))+"^";

                }
                strReturn = strReturn.substring(0, strReturn.length() - 1);
                strReturn = strReturn + "~";
            }
            strReturn = strReturn.substring(0, strReturn.length() - 1);
        }
        return encryptJS(strReturn);
    }  catch ( Exception err ) {
        Logger("error", "displayFilter Function: " + err.getMessage());
    }
    return  encryptJS("null");
}

public Integer getTotalRecord(String table, String where){
    try {
        ResultSet strSelect = DB_Select("count(*) as count", table, where, "", "");
        strSelect.next();
         return strSelect.getInt("count");
    }  catch ( Exception err ) {
        Logger("error", "getTotalRecord Function: " + err.getMessage());
    }
    return null;
}

public String GetCounter(String counter_id){
    try {
    Integer counter = 0;
    ResultSet strCounter = DB_Select(" counter_value", "was_counter","counter_id = '"+counter_id+"'","","");
    while(strCounter.next()){
        counter  = strCounter.getInt("counter_value")+1 ;
        DB_Update("was_counter"," counter_value ='"+counter+"'"," counter_id = '"+counter_id+"'","");
    }
 
    String strReturn = (String) counter.toString();
        return encryptJS(strReturn);
    
    }  catch ( Exception err ) {
        Logger("error", "GetCounter Function: " + err.getMessage());
    }
    return  encryptJS("null");
}

public String toEncrypt(String toEncrypt) {
    return URLEncoder.encode(encrypt(toEncrypt));
}

public String toDecrypt(String toDecrypt) {
    return URLEncoder.encode(decrypt(toDecrypt));
}

%>


<%
if(decryptJS(request.getParameter("functionname")).equals("AddNewRecord")){
    out.println(AddNewRecord(decryptJS(request.getParameter("table")),decryptJS(request.getParameter("strField")),decryptJS(request.getParameter("strValue")),decryptJS(request.getParameter("lstFields")),decryptJS(request.getParameter("qryStmt"))));
} else if(decryptJS(request.getParameter("functionname")).equals("UpdateRecord")){
    out.println(UpdateRecord(decryptJS(request.getParameter("table")),decryptJS(request.getParameter("strField")),decryptJS(request.getParameter("strValue")),decryptJS(request.getParameter("where")),decryptJS(request.getParameter("rowid")),decryptJS(request.getParameter("lstFields")),decryptJS(request.getParameter("qryStmt"))));
} else if(decryptJS(request.getParameter("functionname")).equals("DeleteRecord")){
    out.println(DeleteRecord(decryptJS(request.getParameter("table")),decryptJS(request.getParameter("where")),decryptJS(request.getParameter("rowid"))));
}

if(decryptJS(request.getParameter("functionname")).equals("displayFilter")){
    out.println(displayFilter(decryptJS(request.getParameter("lstFields")),decryptJS(request.getParameter("table")),decryptJS(request.getParameter("where")),decryptJS(request.getParameter("orderby")),decryptJS(request.getParameter("limit"))));
}

if(decryptJS(request.getParameter("functionname")).equals("getTotalRecord")){
    out.println(getTotalRecord(decryptJS(request.getParameter("table")),decryptJS(request.getParameter("where"))));
}

if(decryptJS(request.getParameter("functionname")).equals("InsertDB")){
    out.println(InsertDB(decryptJS(request.getParameter("strSQL"))));
}

if(decryptJS(request.getParameter("functionname")).equals("UpdateDB")){
    out.println(UpdateDB(decryptJS(request.getParameter("strSQL"))));
}

if(decryptJS(request.getParameter("functionname")).equals("DeleteDB")){
    out.println(DeleteDB(decryptJS(request.getParameter("strSQL"))));
}

if(decryptJS(request.getParameter("functionname")).equals("SelectDB")){
    out.println(SelectDB(decryptJS(request.getParameter("strSQL"))));
}

if(decryptJS(request.getParameter("functionname")).equals("GetCounter")){
    out.println(GetCounter(decryptJS(request.getParameter("counter_id"))));
}

if(decryptJS(request.getParameter("functionname")).equals("DeleteReport")){
    Path path = FileSystems.getDefault().getPath(getServletContext().getInitParameter("ReportPathGenerated"), request.getParameter("ReportNameOutput")+".pdf");
    Files.delete(path);
}

if(decryptJS(request.getParameter("functionname")).equals("toEncrypt")){
    out.println(toEncrypt(request.getParameter("toEncrypt")));
}

if(decryptJS(request.getParameter("functionname")).equals("toDecrypt")){
    out.println(toDecrypt(request.getParameter("toDecrypt")));
}

if(decryptJS(request.getParameter("functionname")).equals("getServerSession")){
    String field = (String) session.getAttribute(decryptJS(request.getParameter("field"))).toString();
    out.println(encryptJS(field));
}
%>