package Servlet;

import DAO.BaseDAO;
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
 * Created by 1234ztc on 2016/7/5.
 */
public class AssistantPassWordServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");
        response.setCharacterEncoding("utf-8");
        HttpSession session = request.getSession();
        String username = session.getAttribute("username").toString();
        BaseDAO baseDAO = new BaseDAO();
        String hql = "from Assistant a where a.acc_num=" + username;
        String oldpassword = request.getParameter("oldpassword").trim();
        String newpassword = request.getParameter("newpassword").trim();
        String password = request.getParameter("password").trim();
        List list = baseDAO.list(hql);
        Assistant ass = null;
        Iterator iterator = list.iterator();
        while (iterator.hasNext()) {
            ass = (Assistant) iterator.next();
            int i = ass.getAid();
            Assistant assistant = (Assistant) baseDAO.find(Assistant.class, i);
            String p = assistant.getPassword();
            if (newpassword.equals(null) || password.equals(null) || oldpassword.equals(null)) {
                JOptionPane.showMessageDialog(null, "密码不能为空", "提示", JOptionPane.ERROR_MESSAGE);
                response.sendRedirect("/AboutAssisantJsp/AssistantChangePassword.jsp");
            } else {
                if (password.equals(newpassword)) {
                    if (p.equals(oldpassword)) {
                        assistant.setPassword(newpassword);
                        baseDAO.update(assistant);
                        JOptionPane.showMessageDialog(null, "密码修改成功", "提示", JOptionPane.PLAIN_MESSAGE);
                        response.sendRedirect("/AboutAssisantJsp/AssistantChangePassword.jsp");
                    } else {
                        JOptionPane.showMessageDialog(null, "原始密码错误", "提示", JOptionPane.ERROR_MESSAGE);
                        response.sendRedirect("/AboutAssisantJsp/AssistantChangePassword.jsp");
                    }
                }
            }
        }
    }
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }
}



