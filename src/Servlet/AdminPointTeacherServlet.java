package Servlet;

import DAO.BaseDAO;
import com.model.Assistant;
import com.model.Student;
import com.model.Teacher;

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
public class AdminPointTeacherServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        response.setCharacterEncoding("UTF-8");
        request.setCharacterEncoding("UTF-8");
        String grade=request.getParameter("grade");
        String profession=request.getParameter("profess");
        BaseDAO baseDAO=new BaseDAO();
        String tname=request.getParameter("teacher");
        String gettea="from Teacher t where t.tname='"+tname+"'";
        List<Teacher> teacherList =baseDAO.list(gettea);
       Teacher teacher1=null;
        for (Teacher teacher:teacherList){
            int tid=teacher.getTid();
            teacher1=(Teacher) baseDAO.find(Teacher.class,tid);
        }
        String hql="select s.sid from Student s,Major m where s.major=m.mid and m.grade='"+grade+"'and m.profession='"+profession+"'";
        List studentList= baseDAO.list(hql);
        if (studentList.size()>0) {
            for (Object student : studentList) {
                int sid =(int) student;
                Student student1 = (Student) baseDAO.find(Student.class, sid);
                student1.setTeacher(teacher1);
                baseDAO.update(student1);
            }
            JOptionPane.showMessageDialog(null, "导师设定成功", "提示", JOptionPane.PLAIN_MESSAGE);
                response.sendRedirect("/AboutAdminJsp/AdminPointTeacher.jsp");
        }else {
            JOptionPane.showMessageDialog(null, "无该专业该年级学生", "提示", JOptionPane.PLAIN_MESSAGE);
            response.sendRedirect("/AboutAdminJsp/AdminPointTeacher.jsp");
        }

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
