package Servlet;

import DAO.BaseDAO;
import com.model.Harvest;
import com.model.Iterm;
import com.model.Student;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.swing.*;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

/**
 * Created by 1234ztc on 2016/7/2.
 */
public class StudentSubmitServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        String username = (String) session.getAttribute("username");
        String i = request.getParameter("iid");
        System.out.print(i);
        int id = Integer.parseInt(i);
        BaseDAO baseDAO = new BaseDAO();
        String hqlclose = "from Harvest h where h.comment='禁止申请'";
        List listclose = baseDAO.list(hqlclose);

        if (listclose.size() > 0) {
            JOptionPane.showMessageDialog(null, "管理员未开启项目申请", "提示", JOptionPane.PLAIN_MESSAGE);
            RequestDispatcher requestDispatcher = request.getRequestDispatcher("/AboutStudentJsp/StudentSubmit.jsp");
            requestDispatcher.forward(request, response);
        } else {
            String hql = "from Student s where s.snum=" + username;
            List<Student> liststu = baseDAO.list(hql);
            Student stu = null;
            for (Student student : liststu) {
                stu = student;
            }
            int sid = stu.getSid();
            String grade = stu.getMajor().getGrade();
            Iterm iterm2 = (Iterm) baseDAO.find(Iterm.class, id);
            String type = iterm2.getType();
            if (grade.equals("研究生二年级") && type.equals("绩点")) {
                JOptionPane.showMessageDialog(null, "二年级研究生不能申请绩点", "提示", JOptionPane.PLAIN_MESSAGE);
                RequestDispatcher requestDispatcher = request.getRequestDispatcher("/AboutStudentJsp/StudentSubmit.jsp");
                requestDispatcher.forward(request, response);
            } else {
                String hqlselect = "from Harvest h where h.student=" + sid + "and h.iterms=" + id;
                List list3 = baseDAO.list(hqlselect);
                if (list3.size() >= 1) {
                    JOptionPane.showMessageDialog(null, "您已申请", "提示", JOptionPane.ERROR_MESSAGE);
                    RequestDispatcher requestDispatcher = request.getRequestDispatcher("/AboutStudentJsp/StudentSubmit.jsp");
                    requestDispatcher.forward(request, response);
                } else {
                    Date date = new Date();
                    String hql2 = "from Iterm i where i.iid=" + id;
                    List list2 = baseDAO.list(hql2);
                    Iterm iterm = null;
                    for (Object iter : list2) {
                        iterm = (Iterm) iter;
                    }
                    String hql3 = "from Student s where s.snum=" + username;
                    List list4 = baseDAO.list(hql3);
                    System.out.print(list4.size());
                    Student student2 = null;
                    for (Object student : list4) {
                        student2 = (Student) student;
                    }
                    String sname = student2.getSname();

                    Harvest harvest = new Harvest();
                    harvest.setStudent(stu);
                    harvest.setIterms(iterm);
                    harvest.setTime(date);
                    harvest.setComment("待审核");
                    baseDAO.add(harvest);
                    JOptionPane.showMessageDialog(null, "申请成功", "提示", JOptionPane.PLAIN_MESSAGE);
                    RequestDispatcher requestDispatcher = request.getRequestDispatcher("/AboutStudentJsp/StudentSubmit.jsp");
                    requestDispatcher.forward(request, response);
                }
            }
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
       doPost(request,response);
    }
}
