package Servlet;

import DAO.BaseDAO;
import com.model.Harvest;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.swing.*;
import java.io.IOException;
import java.util.List;

/**
 * Created by 1234ztc on 2016/7/8.
 */
public class TeacheCheckServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession();
        int hid = (int) session.getAttribute("hid");
        int sid = (int) session.getAttribute("sid");
        String state = request.getParameter("select");
//        String hid = request.getParameter("hid");
        System.out.print("+++" + hid + state);
//        int id = Integer.parseInt(hid);
        BaseDAO baseDAO = new BaseDAO();
        String hqlclose = "from Harvest h where h.comment='禁止申请'";
        List listclose = baseDAO.list(hqlclose);

        if (listclose.size() ==0) {
            Harvest harvest = (Harvest) baseDAO.find(Harvest.class, hid);
            if (state .equals("已通过") ) {
                harvest.setComment("已通过");
            } else if (state .equals("不通过") ) {
                harvest.setComment("不通过");
            }
            baseDAO.update(harvest);
            JOptionPane.showMessageDialog(null, "提交成功", "提示", JOptionPane.PLAIN_MESSAGE);
            response.sendRedirect("/AboutTeacherJsp/TeacherCheckStudentSubmit.jsp?sid=" + session.getAttribute("sid"));
        }else {
            JOptionPane.showMessageDialog(null, "管理员未开启项目修改", "提示", JOptionPane.PLAIN_MESSAGE);
            response.sendRedirect("/AboutTeacherJsp/TeacherCheckStudentSubmit.jsp?sid=" + session.getAttribute("sid"));
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
