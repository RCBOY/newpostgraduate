package Servlet;

import DAO.BaseDAO;
import com.jspsmart.upload.Request;
import com.model.Assistant;
import com.model.Student;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.swing.*;
import java.io.IOException;
import java.util.Iterator;
import java.util.List;

/**
 * Created by 1234ztc on 2016/7/4.
 */
public class AssistantInfoChangeServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");
        response.setCharacterEncoding("utf-8");
        HttpSession session=request.getSession();
        String name=request.getParameter("name");
        String tel=request.getParameter("tel");
        String anum=session.getAttribute("username").toString();
        String hql="from Assistant a where a.acc_num="+anum;
        BaseDAO baseDAO=new BaseDAO();
        List list= baseDAO.list(hql);
        Iterator iterator=list.iterator();
        while (iterator.hasNext()){
            Assistant assistant=(Assistant) iterator.next();
            int id=assistant.getAid();
            Assistant ass=(Assistant) baseDAO.find(Assistant.class,id);
            ass.setAname(name);
            ass.setAtel(tel);
            baseDAO.update(ass);
            JOptionPane.showMessageDialog(null,"信息修改成功","提示",JOptionPane.PLAIN_MESSAGE);
            response.sendRedirect("/AboutAssisantJsp/AssistantInfoShow.jsp");
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request,response);
    }
}
