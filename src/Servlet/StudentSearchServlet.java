package Servlet;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * Created by 1234ztc on 2016/7/2.
 */
public class StudentSearchServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");
        response.setCharacterEncoding("utf-8");
        String search =request.getParameter("search").trim();
        String search2 =request.getParameter("search2").trim();
        String hql=null;
        if (search!=null&&search2.equals(null)){
            hql="from Iterm i where i.mark>=0 and i.type="+search;
        }
        else if (search.equals(null)&&search2!=null){
            hql="from Iterm i where i.mark>=0 and i.iname like '%"+search2+"%'";
        }
        else if (search!=null&&search2!=null){

            hql="from Iterm i where i.mark>=0 and i.type='"+search+"'and i.iname like '%"+search2+"%'";
        }
        request.setAttribute("hql",hql);

        RequestDispatcher requestDispatcher=request.getRequestDispatcher("/AboutStudentJsp/StudentSubmit.jsp");
        requestDispatcher.forward(request,response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request,response);
    }
}
