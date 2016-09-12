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
 * Created by 1234ztc on 2016/7/8.
 */
public class AdminYesSubmitServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {


    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        BaseDAO baseDAO=new BaseDAO();
        String hql="from Harvest h where h.comment='禁止申请'";
        List<Harvest> list=baseDAO.list(hql);
        Harvest harvest=null;
        for (Harvest har:list){
            harvest=har;

        }
        baseDAO.delete(harvest);
        JOptionPane.showMessageDialog(null, "已经成功允许学生提交申请", "提示", JOptionPane.PLAIN_MESSAGE);
        response.sendRedirect("/AboutAdminJsp/Scorefeedback.jsp");
    }
}
