package wAYA;


import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 *
 * @author acamallan
 */
public class Chart {
    Logs WAS = new Logs();
    public String BarChart(Connection conn){
    try{
        Calendar cal = Calendar.getInstance();
        DateFormat formatter = new SimpleDateFormat("yyyyMM");
        DateFormat labelDate = new SimpleDateFormat("MMM yy");
        String strBar = "";
        String resultlabelDate = "";
        String strlabelDate = "'";
        String strDate ="";
        String countZero = "";
        for(Integer x = 1; x <= 12; x++){
            Integer y = -1;
            cal.add(Calendar.MONTH, y);

            Date result = cal.getTime();
            String today = formatter.format(result);
            resultlabelDate = labelDate.format(result);
            strDate = strDate +  today + ",";
            strlabelDate = resultlabelDate + "','" + strlabelDate;
        }

        strDate = strDate.substring(0, strDate.length() - 1);
        strlabelDate = strlabelDate.substring(0, strlabelDate.length() - 3);

        String[] date = strDate.split(",");

        PreparedStatement queryProdSales = conn.prepareStatement("select sum(total_amount) as total_amount, concat(left(record_date,2),'/',1,'/',right(record_date,4)) as whole_date, concat(right(record_date,4),left(record_date,2)) trim_date" 
                    + " FROM view_daily_products_sale "
                    + " where concat(right(record_date,4),left(record_date,2)) in ("+strDate+")"
                    + " group by concat(right(record_date,4),left(record_date,2))"
                    + " order by concat(right(record_date,4),left(record_date,2))");
        ResultSet strProdSales = queryProdSales.executeQuery();
        Integer countDate = 0;
        while(strProdSales.next()) {
            for (Integer x = 0; x <= 11; x++) {
                if(date[x].equals(strProdSales.getString("trim_date"))){
                    countDate++;
                    strBar = strBar + strProdSales.getString("total_amount")+",";
                }
            }
        }
        for (Integer x = 0; x <= 11-countDate; x++) {
            countZero = countZero + "0,";
        }
        
        String strBar1 = countZero + strBar;
        strBar1 = strBar1.substring(0, strBar1.length() - 1);
        String strReturn = "<script>\n";       
	strReturn = strReturn + " var barChartData = {"
		+ " labels : ['"+strlabelDate+"],"
		+ " datasets : ["	
		+ " {"
		+ " fillColor : '#20AA73',"
		+ " strokeColor : '#20AA73',"
		+ " highlightFill : '#20AA73',"
		+ " highlightStroke : '#20AA73',"
		+ " data : ["+strBar1+"]"
		+ " }"
		+ " ]"
	+ "}; ";
	strReturn = strReturn + " window.onload = function(){"
		+ " var ctx = document.getElementById('canvas').getContext('2d');"
		+ " window.myBar = new Chart(ctx).Bar(barChartData, {"
                    + " responsive : true"
		+ " });"
	+ " };";

	strReturn = strReturn + "</script>";
        return strReturn;
        } catch(Exception e){
            WAS.Logger("error", "BarChart Function: " + e.getMessage());
        }
        return null;
    }
}
