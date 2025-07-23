package wAYA;
 
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
 
import org.apache.log4j.Logger;
 
@WebServlet("/test")
public class Logs extends HttpServlet {
    static final Logger LOGGER = Logger.getLogger(Logs.class);
    @Override
    protected void doGet(HttpServletRequest request,
        HttpServletResponse response) throws ServletException, IOException {
    }
    
    public void Logger(String action, String msg){
        switch (action) {
            case "error":
                LOGGER.error(msg);
                break;
            case "info":
                LOGGER.info(msg);
            case "debug":
                LOGGER.debug(msg);
                break;
        }
    }
}