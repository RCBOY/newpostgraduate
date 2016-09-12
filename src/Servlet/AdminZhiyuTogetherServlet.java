package Servlet;

import DAO.BaseDAO;
import com.model.Harvest;
import com.model.Iterm;
import com.model.Student;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.swing.*;
import java.io.IOException;
import java.util.Date;
import java.util.List;

/**
 * Created by 1234ztc on 2016/7/9.
 */
public class AdminZhiyuTogetherServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request,response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        BaseDAO baseDAO=new BaseDAO();
        String getsidhql="select s.sid from Student s";
        List sidlist = baseDAO.list(getsidhql);
        int num=0;
        for (Object sid:sidlist){
            int studentid=(int)sid;
            Student student=(Student) baseDAO.find(Student.class,studentid);
            String grade=student.getMajor().getGrade();
            if (grade.equals("研究生二年级")) {
                String getIterm = "from Iterm i where i.type='智育基本分'";
                List<Iterm> itermList = baseDAO.list(getIterm);
                int iid = 0;
                Iterm iterm2 = null;
                for (Iterm iterm : itermList) {
                    iid = iterm.getIid();
                    iterm2 = (Iterm) baseDAO.find(Iterm.class, iid);
                }
                String check = "from Harvest h where h.iterms=" + iid + "and h.student=" + sid;
                List list = baseDAO.list(check);
                num=list.size();
                if (list.size()==0) {
                    Harvest harvest = new Harvest();
                    harvest.setComment("基本分");
                    harvest.setIterms(iterm2);
                    harvest.setStudent(student);
                    Date time = new Date();
                    harvest.setTime(time);
                    baseDAO.add(harvest);
                }
            }
        }
        if (num==0) {
            JOptionPane.showMessageDialog(null, "智育分基本分添加成功", "提示", JOptionPane.PLAIN_MESSAGE);
            response.sendRedirect("/AboutAdminJsp/Scorefeedback.jsp");
        }else {
            JOptionPane.showMessageDialog(null, "您已添加，无须重复添加", "提示", JOptionPane.PLAIN_MESSAGE);
            response.sendRedirect("/AboutAdminJsp/Scorefeedback.jsp");
        }
    }
}
