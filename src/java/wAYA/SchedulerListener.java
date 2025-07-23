/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package wAYA;

import static org.quartz.JobBuilder.newJob;
import static org.quartz.TriggerBuilder.newTrigger;
import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

import org.quartz.CronScheduleBuilder;
import org.quartz.JobDetail;
import org.quartz.Scheduler;
import org.quartz.SchedulerException;
import org.quartz.Trigger;
import org.quartz.impl.StdSchedulerFactory;
import static org.quartz.JobBuilder.newJob;
import javax.servlet.ServletContextEvent;

public class SchedulerListener implements ServletContextListener {
    Scheduler scheduler = null;
    @Override
    public void contextInitialized(ServletContextEvent servletContext) {
        try {
            ServletContext context = servletContext.getServletContext();
            // Setup the Job class and the Job group
            JobDetail job = newJob(SchedulerJob.class).withIdentity(
                            "CronQuartzJob", "Group").build();

            Trigger trigger = newTrigger()
                            .withIdentity("TriggerName", "Group")
                            .withSchedule(CronScheduleBuilder.cronSchedule(context.getInitParameter("CronScheduler")))
                            .build();

           //DB Connection
            String hostname= context.getInitParameter("hostname");
            String port= context.getInitParameter("port");
            String dbname= context.getInitParameter("dbname");
            String username= context.getInitParameter("username");
            String password= context.getInitParameter("password");
            String url = "jdbc:mysql://"+hostname+":"+port+"/"+dbname;
    
            scheduler = new StdSchedulerFactory().getScheduler();
            
            //DBConnection
            scheduler.getContext().put("url", url);
            scheduler.getContext().put("username", username);
            scheduler.getContext().put("password", password);
            
            scheduler.start();
            scheduler.scheduleJob(job, trigger);
        }
        catch (SchedulerException e) {
            e.printStackTrace();
        }
    }

    @Override
    public void contextDestroyed(ServletContextEvent servletContext) {
        try {
            scheduler.shutdown();
        } 
        catch (SchedulerException e) {
            e.printStackTrace();
        }
    }
}