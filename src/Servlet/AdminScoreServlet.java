package Servlet;

import DAO.BaseDAO;
import Util.HibernateUtil;
import com.model.Student;
import org.hibernate.Query;
import org.hibernate.Session;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.swing.*;
import java.io.IOException;
import java.util.List;

/**
 * Created by 1234ztc on 2016/7/7.
 */
public class AdminScoreServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setCharacterEncoding("UTF-8");
        request.setCharacterEncoding("UTF-8");
        String grade=request.getParameter("grade");
        String profession=request.getParameter("profess");
        String percent=request.getParameter("percent");
        System.out.print(percent+"1111");
        String ship=request.getParameter("ship");
        BaseDAO baseDAO=new BaseDAO();
        String hql="from Student s,Major m where s.major=m.mid and m.grade='"+grade+"'and m.profession='"+profession+"'";
        List<Student> list= baseDAO.list(hql);
        if (list.size()!=0) {
            System.out.print(list.size() + "232");
            int studentnumber = list.size();
            int per = Integer.parseInt(percent);
            double onestudent = (double) studentnumber * per / 100;
            System.out.println(onestudent + "**o");
            int onestudent2 = (int) Math.ceil(onestudent);
            System.out.println(onestudent2 + "**o2");
            String hql2 = "select new Student(s.sid,s.total,s.state) from Student s,Major m where s.major=m.mid and m.grade='" + grade + "'and m.profession='" + profession + "'order by s.total desc";
            List<Student> list1 = baseDAO.list(hql2, onestudent2);
            System.out.println(list1.size() + "**size");
            Student stu = null;
            for (int i = 0; i < list1.size(); i++) {
                stu = list1.get(i);
                int sid = stu.getSid();
//            stu.setState(ship);
                stu = (Student) baseDAO.find(Student.class, sid);
                stu.setState(ship);
                baseDAO.update(stu);
            }
            JOptionPane.showMessageDialog(null, "已经成功设定奖学金", "提示", JOptionPane.PLAIN_MESSAGE);
            response.sendRedirect("/AboutAdminJsp/Scorefeedback.jsp");
        }else {
            JOptionPane.showMessageDialog(null, "请重新选择年级或专业", "提示", JOptionPane.PLAIN_MESSAGE);
            response.sendRedirect("/AboutAdminJsp/Scorefeedback.jsp");
        }

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
