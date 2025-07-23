<%@include file="was_function.jsp"%>
<%@include file="classes.jsp"%>
<%@include file="record_function.jsp"%>

<%!
public String genCardNumbers(String bin, Integer len, Integer no_of_entries, String record_date, String expiry_date, String card_type){
    try{
        String strReturn = "";
        Integer count = 1;
        while(count <= no_of_entries){
            String cardnumber = GenerateCardNumber(bin,len);
            String counter = GetCounter("010","10");
            String qryInsert = "insert into was_card_details(card_number,record_date,expiry_date,card_status,link_number,card_type,record_time) "
                                + "values('"+cardnumber+"','"+record_date+"','"+expiry_date+"','103','"+counter+"','"+card_type+"','00.00.00')";
            String status = "Active";
            String display = cardnumber+'^'+record_date+'^'+expiry_date+'^'+status+'^'+counter;
            Integer result = Insert_DB(qryInsert);
            if(!result.equals(null)){
                strReturn = strReturn + display + "~";
                count++;
            }
            
        }
        strReturn = strReturn.substring(0, strReturn.length() - 1);
        return strReturn;
    }  catch ( Exception err ) {
        Logger("error", "AddNewRecord Function: " + err.getMessage());
    }
return null;
}
%>

<%
if(request.getParameter("functionname").equals("genCardNumbers")){
    out.println(genCardNumbers(request.getParameter("bin"),Integer.parseInt(request.getParameter("len")),Integer.parseInt(request.getParameter("no_of_entries")),request.getParameter("record_date"),request.getParameter("expiry_date"),request.getParameter("card_type")));
}
%>