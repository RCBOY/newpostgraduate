package Servlet;

import DAO.BaseDAO;
import com.model.Harvest;

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
public class AdminNoSubmitServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
      doGet(request,response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        BaseDAO baseDAO=new BaseDAO();
        String hql="from Harvest h where h.comment='禁止申请'";
        List list=baseDAO.list(hql);
        if (list.size()>0){
            JOptionPane.showMessageDialog(null, "申请已被禁止", "提示", JOptionPane.PLAIN_MESSAGE);
            response.sendRedirect("/AboutAdminJsp/Scorefeedback.jsp");
        }
        else {
            Harvest harvest=new Harvest();
            harvest.setComment("禁止申请");
            baseDAO.add(harvest);
            JOptionPane.showMessageDialog(null, "已经成功禁止学生提交申请", "提示", JOptionPane.PLAIN_MESSAGE);
            response.sendRedirect("/AboutAdminJsp/Scorefeedback.jsp");
        }
    }
}
