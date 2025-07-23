
package wAYA;

/**
 *
 * @author acamallan
 */

import java.io.File;
import java.io.FileOutputStream;

import com.itextpdf.text.Document;
import com.itextpdf.text.pdf.PdfWriter;
import com.itextpdf.tool.xml.XMLWorkerHelper;
import java.io.ByteArrayInputStream;
import java.io.InputStream;
import java.io.OutputStream;

public class ExportReport {
    
    /*public void GenerateReport1(Connection conn, String ReportPath, String ReportPathGenerated, String ReportName, String ReportNameOutput, String strSQL){
        Logs WAS = new Logs();
        try {
            JasperReport jasperReport=JasperCompileManager.compileReport(ReportPath+ReportName+".jrxml");       
            Statement stmt = null;
            ResultSet rset = null;
            stmt = conn.createStatement();
            rset = stmt.executeQuery(strSQL);
            JRResultSetDataSource jasperReports = new JRResultSetDataSource(rset);
            Map parametersMap = new HashMap();  
            parametersMap.put("username","admin");
            JasperPrint jasperPrint = JasperFillManager.fillReport(jasperReport,parametersMap, jasperReports);
            String filename=ReportPathGenerated+ReportNameOutput+".pdf";
            //filename = "report2.pdf";
            //Report saved in specified path
            JasperExportManager.exportReportToPdfFile(jasperPrint,filename);

        }
        catch(Exception err){
           WAS.Logger("error", "GenerateReport Function: " + err.getMessage());
        }
    }*/

    public void ExportToPDF(String div, String Path, String reportname, String baseURL) {
        Logs WAS = new Logs();
		try
		{
               OutputStream file = new FileOutputStream(new File(Path+reportname+".pdf"));
			Document document = new Document();
			PdfWriter writer = PdfWriter.getInstance(document, file);
			StringBuilder htmlString = new StringBuilder();
			htmlString.append(new String("<html><head><link href='"+baseURL+"/styles/reports.css' rel='stylesheet' type='text/css' media='all'/></head><body> "));
			htmlString.append(new String(div));				
			htmlString.append(new String("</body></html>"));
							
			document.open();
			InputStream is = new ByteArrayInputStream(htmlString.toString().getBytes());
			XMLWorkerHelper.getInstance().parseXHtml(writer, document, is);
			document.close();
			file.close();
		}
		catch (Exception err)
		{
                    WAS.Logger("error", "GenerateHTMLtoPDF: " + err.getMessage());
		}
  }

       
}
