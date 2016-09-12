package Servlet;

import DAO.BaseDAO;

import com.model.Admin;
import com.model.Assistant;
import com.model.Teacher;
import org.hibernate.Session;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.swing.*;
import java.io.IOException;
import java.util.List;

/**
 * Created by 1234ztc on 2016/6/3.
 */
public class UserLoginServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");
        String username=request.getParameter("username").trim();
        String password=request.getParameter("password").trim();
        String aut=username.substring(0,3);
        System.out.print(aut);
        BaseDAO baseDAO=new BaseDAO();

        HttpSession session=request.getSession();
        if (aut.equals("200")){
            String sql="from  Teacher t where t.acc_tnum= "+username+"and t.password = "+password;
            List<Teacher> list= baseDAO.list(sql);
            if (list.size()>0){
                session.setAttribute("username",username);
                session.setAttribute("password",password);
                response.sendRedirect("/Teacher.jsp");
            }else {
                JOptionPane.showMessageDialog(null,"账号或密码错误","提示",JOptionPane.ERROR_MESSAGE);
                response.sendRedirect("/index.jsp");
            }
        }
        else if (aut.equals("300")){
            String sql="from Assistant a where a.acc_num="+username+"and a.password="+password;
            List<Assistant>list=baseDAO.list(sql);
            if (list.size()>0){
                session.setAttribute("username",username);
                session.setAttribute("password",password);
                response.sendRedirect("/Assistant.jsp");
            }else {
                JOptionPane.showMessageDialog(null,"账号或密码错误","提示",JOptionPane.ERROR_MESSAGE);
               response.sendRedirect("/index.jsp");
            }
        }
        else if (aut.equals("100")){
            String sql="from Admin a where a.acc_anum="+username+"and a.apassword="+password;
            List<Admin>list= baseDAO.list(sql);
            if (list.size()>0){
                session.setAttribute("username",username);
                session.setAttribute("password",password);
                response.sendRedirect("/Admin.jsp");
            }else {
                JOptionPane.showMessageDialog(null,"账号或密码错误","提示",JOptionPane.ERROR_MESSAGE);
                response.sendRedirect("/index.jsp");
            }
        }
        else if (aut.equals("400")){
            String sql="from  Student t where t.snum= "+username+"and t.password = "+password;
            List<Teacher>list= baseDAO.list(sql);
            if (list.size()>0){
                session.setAttribute("username",username);
                session.setAttribute("password",password);
               response.sendRedirect("/Student.jsp");
            }else {
                JOptionPane.showMessageDialog(null,"账号或密码错误","提示",JOptionPane.ERROR_MESSAGE);
                response.sendRedirect("/index.jsp");
            }
        }
    }
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request,response);
    }
}
