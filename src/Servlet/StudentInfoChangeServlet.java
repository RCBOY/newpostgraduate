package Servlet;

import DAO.BaseDAO;
import Util.HibernateUtil;
import com.model.Student;
import com.sun.corba.se.spi.protocol.RequestDispatcherRegistry;
import com.sun.org.apache.xerces.internal.impl.xpath.XPath;
import org.hibernate.Session;

import javax.management.Query;
import javax.security.auth.login.Configuration;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.swing.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Iterator;
import java.util.List;

/**
 * Created by 1234ztc on 2016/6/12.
 */
public class StudentInfoChangeServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");
        response.setCharacterEncoding("utf-8");
        HttpSession session=request.getSession();
        String name=request.getParameter("name");
        String sex=request.getParameter("sex");
        String tel=request.getParameter("tel");
        String snum=session.getAttribute("username").toString();
        String hql="from Student s where s.snum="+snum;
        BaseDAO baseDAO=new BaseDAO();
        List list= baseDAO.list(hql);
        Iterator iterator=list.iterator();
        while (iterator.hasNext()){
            Student student=(Student)iterator.next();
            int id=student.getSid();
            Student stu=(Student)baseDAO.find(Student.class,id);
            stu.setSname(name);
            stu.setStel(tel);
            stu.setSsex(sex);
            baseDAO.update(stu);
            JOptionPane.showMessageDialog(null,"信息修改成功","提示",JOptionPane.PLAIN_MESSAGE);
            response.sendRedirect("/AboutStudentJsp/StudentInfoShow.jsp");
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request,response);
    }
}

