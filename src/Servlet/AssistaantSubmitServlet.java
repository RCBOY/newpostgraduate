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
import java.util.Date;
import java.util.List;

/**
 * Created by 1234ztc on 2016/7/5.
 */
public class AssistaantSubmitServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        int sid = Integer.parseInt(request.getParameter("sid"));
        String i = request.getParameter("iid");
        int id = Integer.parseInt(i);
        BaseDAO baseDAO = new BaseDAO();

        String hqlclose = "from Harvest h where h.comment='禁止申请'";
        List listclose = baseDAO.list(hqlclose);

        if (listclose.size() == 0) {
            Student studentgetnum = (Student) baseDAO.find(Student.class, sid);
            String snum = studentgetnum.getSnum();
            String hqlselect = "from Harvest h where h.student=" + sid + "and h.iterms=" + id;
            List list3 = baseDAO.list(hqlselect);
            if (list3.size() >= 1) {
                JOptionPane.showMessageDialog(null, "此项目您已添加", "提示", JOptionPane.ERROR_MESSAGE);
                RequestDispatcher requestDispatcher = request.getRequestDispatcher("/AboutAssisantJsp/AssistantChangeMark.jsp");
                requestDispatcher.forward(request, response);
            } else {
                Date date = new Date();
                String hql2 = "from Iterm i where i.iid=" + id;
                List list2 = baseDAO.list(hql2);
                Iterm iterm = null;
                for (Object iter : list2) {
                    iterm = (Iterm) iter;
                }
                String hql = "from Student s where s.snum=" + snum;
                List list = baseDAO.list(hql);
                System.out.print(list.size());
                Student stu = null;
                for (Object student : list) {
                    stu = (Student) student;
                }
                String sname = stu.getSname();

                Harvest harvest = new Harvest();
                harvest.setStudent(stu);
                harvest.setIterms(iterm);
                harvest.setTime(date);
                harvest.setComment("辅导员加减分");
                baseDAO.add(harvest);
                JOptionPane.showMessageDialog(null, "项目添加成功", "提示", JOptionPane.PLAIN_MESSAGE);
                RequestDispatcher requestDispatcher = request.getRequestDispatcher("/AboutAssisantJsp/AssistantChangeMark.jsp");
                requestDispatcher.forward(request, response);
            }
        }else {
            JOptionPane.showMessageDialog(null, "管理员未开启项目申请", "提示", JOptionPane.PLAIN_MESSAGE);
            RequestDispatcher requestDispatcher = request.getRequestDispatcher("/AboutAssisantJsp/AssistantChangeMark.jsp");
            requestDispatcher.forward(request, response);
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request,response);
    }
}
