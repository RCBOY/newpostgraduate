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
public class AdminFeedBackServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request,response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        BaseDAO baseDAO = new BaseDAO();
        String hqlcheck = "from Harvest h where h.comment='待审核'";
        List<Harvest> listhar = baseDAO.list(hqlcheck);
        if (listhar.size() >= 1) {
            JOptionPane.showMessageDialog(null, "无法反馈报表，还有待审核项目！", "提示", JOptionPane.ERROR_MESSAGE);
            response.sendRedirect("/AboutAdminJsp/Scorefeedback.jsp");
        } else {
            String hql = "from Harvest h where h.comment='禁止反馈'";
            List<Harvest> list = baseDAO.list(hql);
            Harvest harvest = null;
            for (Harvest har : list) {
                harvest = har;
            }
            baseDAO.delete(harvest);
            JOptionPane.showMessageDialog(null, "已经成功允许反馈报表", "提示", JOptionPane.PLAIN_MESSAGE);
            response.sendRedirect("/AboutAdminJsp/Scorefeedback.jsp");
        }
    }
}
