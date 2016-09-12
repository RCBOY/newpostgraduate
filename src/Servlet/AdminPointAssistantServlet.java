package Servlet;

import DAO.BaseDAO;
import com.model.Assistant;
import com.model.Student;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.swing.*;
import java.io.IOException;
import java.util.List;

/**
 * Created by 1234ztc on 2016/7/9.
 */
public class AdminPointAssistantServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setCharacterEncoding("UTF-8");
        request.setCharacterEncoding("UTF-8");
        String grade=request.getParameter("grade");
        String profession=request.getParameter("profess");
        BaseDAO baseDAO=new BaseDAO();
        String aname=request.getParameter("assistant");
        String getass="from Assistant a where a.aname='"+aname+"'";
         List<Assistant> assistantList =baseDAO.list(getass);
        System.out.println(assistantList.size()+"++");
        Assistant assistant1=null;
        for (Assistant assistant:assistantList){
            int aid=assistant.getAid();
            assistant1=(Assistant) baseDAO.find(Assistant.class,aid);
        }
        String hql="select s.sid from Student s,Major m where s.major=m.mid and m.grade='"+grade+"'and m.profession='"+profession+"'";
        List studentList= baseDAO.list(hql);
        if (studentList.size()>0) {
            for (Object studentid : studentList) {
                int sid = (int) studentid;
                Student student1 = (Student) baseDAO.find(Student.class, sid);
                student1.setAssistant(assistant1);
                baseDAO.update(student1);
            }
            JOptionPane.showMessageDialog(null, "辅导员设定成功", "提示", JOptionPane.PLAIN_MESSAGE);
            response.sendRedirect("/AboutAdminJsp/AdminPointAssistant.jsp");
        }else {
            JOptionPane.showMessageDialog(null, "无该专业该年级学生", "提示", JOptionPane.PLAIN_MESSAGE);
            response.sendRedirect("/AboutAdminJsp/AdminPointAssistant.jsp");
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request,response);
    }
}
