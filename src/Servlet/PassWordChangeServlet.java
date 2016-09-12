package Servlet;

import DAO.BaseDAO;
import com.model.Student;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.swing.*;
import java.awt.*;
import java.io.IOException;
import java.util.Iterator;
import java.util.List;

/**
 * Created by 1234ztc on 2016/7/1.
 */
public class PassWordChangeServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");
        response.setCharacterEncoding("utf-8");
        HttpSession session = request.getSession();
        String username = session.getAttribute("username").toString();
        BaseDAO baseDAO = new BaseDAO();
        String hql = "from Student s where s.snum=" + username;
        String oldpassword = request.getParameter("oldpassword").trim();
        String newpassword = request.getParameter("newpassword").trim();
        String password = request.getParameter("password").trim();
        System.out.print(oldpassword + oldpassword + newpassword+password);
        List list = baseDAO.list(hql);
        Student stu = null;
        Iterator iterator = list.iterator();
        while (iterator.hasNext()) {
            stu =(Student) iterator.next();
            int i = stu.getSid();
            Student student = (Student) baseDAO.find(Student.class, i);
            String p=student.getPassword();
            if (newpassword.equals(null)||password.equals(null)||oldpassword.equals(null)){
                JOptionPane.showMessageDialog(null,"密码不能为空","提示",JOptionPane.ERROR_MESSAGE);
                response.sendRedirect("/AboutStudentJsp/ChangePassword.jsp");
            }
           else {
                if (password.equals(newpassword))
                {
                    if (p.equals(oldpassword))
                    {
                        student.setPassword(newpassword);
                        baseDAO.update(student);
                        JOptionPane.showMessageDialog(null,"密码修改成功","提示",JOptionPane.PLAIN_MESSAGE);
                        response.sendRedirect("/AboutStudentJsp/ChangePassword.jsp");
                    }else
                    {
                        JOptionPane.showMessageDialog(null,"原始密码错误","提示",JOptionPane.ERROR_MESSAGE);
                        response.sendRedirect("/AboutStudentJsp/ChangePassword.jsp");
                    }

                }
                else{
                    JOptionPane.showMessageDialog(null,"两次密码不一致","提示",JOptionPane.ERROR_MESSAGE);
                    response.sendRedirect("/AboutStudentJsp/ChangePassword.jsp");
                }
            }

        }

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
