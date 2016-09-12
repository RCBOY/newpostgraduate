package Servlet;

import DAO.BaseDAO;
import com.model.Assistant;
import com.model.Teacher;

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
 * Created by 1234ztc on 2016/7/7.
 */
public class TeacherPassWordServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");
        response.setCharacterEncoding("utf-8");
        HttpSession session = request.getSession();
        String username = session.getAttribute("username").toString();
        BaseDAO baseDAO = new BaseDAO();
        String hql = "from Teacher a where a.acc_tnum=" + username;
        String oldpassword = request.getParameter("oldpassword").trim();
        String newpassword = request.getParameter("newpassword").trim();
        String password = request.getParameter("password").trim();
        List list = baseDAO.list(hql);
        Teacher tt = null;
        Iterator iterator = list.iterator();
        while (iterator.hasNext()) {
            tt = (Teacher) iterator.next();
            int i = tt.getTid();
            Teacher teacher = (Teacher) baseDAO.find(Teacher.class, i);
            String p = teacher.getPassword();
            if (newpassword.equals(null) || password.equals(null) || oldpassword.equals(null)) {
                JOptionPane.showMessageDialog(null, "密码不能为空", "提示", JOptionPane.ERROR_MESSAGE);
                response.sendRedirect("/AboutTeacherJsp/TeacherChangePassword.jsp");
            } else {
                if (password.equals(newpassword)) {
                    if (p.equals(oldpassword)) {
                        teacher.setPassword(newpassword);
                        baseDAO.update(teacher);
                        JOptionPane.showMessageDialog(null, "密码修改成功", "提示", JOptionPane.PLAIN_MESSAGE);
                        response.sendRedirect("/AboutTeacherJsp/TeacherChangePassword.jsp");
                    } else {
                        JOptionPane.showMessageDialog(null, "原始密码错误", "提示", JOptionPane.ERROR_MESSAGE);
                        response.sendRedirect("/AboutTeacherJsp/TeacherChangePassword.jsp");
                    }
                }
            }
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
