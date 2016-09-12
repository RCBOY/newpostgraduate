package Servlet;

import DAO.BaseDAO;
import com.model.Harvest;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.swing.*;
import java.io.IOException;
import java.util.List;

/**
 * Created by 1234ztc on 2016/7/2.
 */
public class StudentSubmitDelServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");
        request.setCharacterEncoding("utf-8");
        String i = request.getParameter("hid");
        int id = Integer.parseInt(i);
        BaseDAO baseDAO = new BaseDAO();
        String hqlclose="from Harvest h where h.comment='禁止申请'";
        List listclose=baseDAO.list(hqlclose);
        if (listclose.size() > 0) {
            JOptionPane.showMessageDialog(null, "管理员未开启项目撤销", "提示", JOptionPane.PLAIN_MESSAGE);
            RequestDispatcher requestDispatcher = request.getRequestDispatcher("/AboutStudentJsp/StudentListofSubmit.jsp");
            requestDispatcher.forward(request, response);
        } else {
            Harvest harvest = (Harvest) baseDAO.find(Harvest.class, id);
            baseDAO.delete(harvest);
            JOptionPane.showMessageDialog(null, "撤销申请成功", "提示", JOptionPane.PLAIN_MESSAGE);
            RequestDispatcher requestDispatcher = request.getRequestDispatcher("/AboutStudentJsp/StudentListofSubmit.jsp");
            requestDispatcher.forward(request, response);
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
       doPost(request,response);
    }
}
