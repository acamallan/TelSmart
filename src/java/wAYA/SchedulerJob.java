/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package wAYA;
import java.sql.*;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import org.quartz.Job;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;
import org.quartz.SchedulerContext;
import org.quartz.SchedulerException;

public class SchedulerJob implements Job {
    Logs WAS = new Logs();
    Connection conn = null;
    
    public void execute(JobExecutionContext context) throws JobExecutionException {
        try {
            SchedulerContext schedulerContext = context.getScheduler().getContext();
            String url = (String) schedulerContext.get("url");
            String username = (String) schedulerContext.get("username");
            String password = (String) schedulerContext.get("password");
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection(url,username,password);
            String timeStamp = new SimpleDateFormat("yyyyMMdd_HHmmss").format(Calendar.getInstance().getTime());
            WAS.Logger("error", "SchedulerJob class: "+ timeStamp  );
            //PreparedStatement qryInsert = conn.prepareStatement(query);
            //qryInsert.executeUpdate();
        } catch (ClassNotFoundException | SchedulerException | SQLException err) {
            WAS.Logger("error", "SchedulerJob class: " + err.getMessage());
        }
    }
}