package Servlet;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * Created by 1234ztc on 2016/7/5.
 */
public class AssistantItermSearchServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");
        response.setCharacterEncoding("utf-8");
        String search =request.getParameter("search").trim();
        String hql=null;
        if (search!=null&&search.equals("加分")){
            hql="from Iterm i where i.mark>=0 and i.type='辅导员'";
        }
        else if (search!=null&&search.equals("减分")){
            hql="from Iterm i where i.mark<=0 and i.type='辅导员'";
        }
        else if (search!=null&&search.equals("减分")){

            hql="from Iterm i where i.mark<=0";
        }
        request.setAttribute("hql",hql);
        RequestDispatcher requestDispatcher=request.getRequestDispatcher("/AboutAssisantJsp/AssistantChangeMark.jsp");
        requestDispatcher.forward(request,response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request,response);
    }
}
