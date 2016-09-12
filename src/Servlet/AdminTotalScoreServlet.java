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
import java.util.List;

/**
 * Created by 1234ztc on 2016/7/7.
 */
public class AdminTotalScoreServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request,response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        BaseDAO baseDAO = new BaseDAO();
        String hqlcheck = "from Harvest h where h.comment='待审核'";
        List<Harvest> listhar = baseDAO.list(hqlcheck);
        if (listhar.size() >= 1) {
            JOptionPane.showMessageDialog(null, "无法计算总分，还有待审核项目！", "提示", JOptionPane.ERROR_MESSAGE);
            response.sendRedirect("/AboutAdminJsp/Scorefeedback.jsp");
        } else {
            int total = 0;
            String hql = " from Student s";
            List<Student> list = baseDAO.list(hql);
            Student stu = null;
            for (Student student : list) {
                total = 0;
                stu = student;
                int sid = stu.getSid();
//                计算德育分总分
                int deyuTotal=0;
                int zhiyuTotal = 0;
                int tiyuTotal = 0;
                int deyucha=0;
                int tiyucha=0;
                int zhiyucha=0;
                String hqlharvest = "select new Harvest(i.mark) from Harvest h,Iterm i where h.iterms=i.iid and h.comment!='不通过' and i.type!='体育分' and i.type!='智育分' and i.type!='体育基本分' and i.type!='智育基本分' and i.type!='辅体' and i.type!='辅智' and i.type!='绩点'and h.student=" + sid;
                List<Harvest> harvestList = baseDAO.list(hqlharvest);
                int deyumark = 0;
                for (Harvest har : harvestList) {
                    deyumark = har.getMark();
                    deyuTotal = deyuTotal + deyumark;
                }
                if (deyuTotal>30){
                    deyuTotal=30;
                }
//                计算智育总分
                Student student2=(Student) baseDAO.find(Student.class,sid);
                String grade=student2.getMajor().getGrade();
                if (grade.equals("研究生二年级")){
                    String hqlgetharvest2 = "select new Harvest(i.mark) from Harvest h,Iterm i where h.iterms=i.iid and h.comment!='不通过' and i.type!='体育分' and i.type!='德育分' and i.type!='体育基本分' and i.type!='德育基本分' and i.type!='辅体' and i.type!='辅德' and i.type!='绩点' and h.student=" + sid;
                    List<Harvest> harvestList2 = baseDAO.list(hqlgetharvest2);
                    int zhiyuMark = 0;
                    for (Harvest har : harvestList2) {
                        zhiyuMark = har.getMark();
                        zhiyuTotal = zhiyuTotal + zhiyuMark;
                    }
                }else {
                    String hqlharvest2grade="select new Iterm(i.mark) from Harvest h,Iterm i where h.iterms=i.iid and h.comment='已通过' and i.type='绩点' and h.student="+sid;
                    List<Iterm> itermList=baseDAO.list(hqlharvest2grade);
                    int itermmark=0;
                    for (Iterm i:itermList){
                        itermmark =i.getMark()*10;
                    }
                    String hqlgetharvest2 = "select new Harvest(i.mark) from Harvest h,Iterm i where h.iterms=i.iid and h.comment='已通过' and i.type!='体育分' and i.type!='德育分' and i.type!='体育基本分' and i.type!='德育基本分' and i.type!='智育基本分' and i.type!='辅体' and i.type!='辅德'  and i.type!='绩点' and h.student=" + sid;
                    List<Harvest> harvestList2 = baseDAO.list(hqlgetharvest2);
                    int zhiyuMark = 0;
                    for (Harvest har : harvestList2) {
                        zhiyuMark = har.getMark();
                        zhiyuTotal = zhiyuTotal + zhiyuMark;
                    }
                    zhiyuTotal=zhiyuTotal+itermmark;
                }
                if (zhiyuTotal<0){
                    zhiyuTotal=0;
                }
//                计算体育总分
                String hqlgetharvest3 = "select new Harvest(i.mark) from Harvest h,Iterm i where h.iterms=i.iid and i.type!='智育分' and i.type!='德育分' and i.type!='智育基本分' and i.type!='德育基本分' and i.type!='辅智' and i.type!='辅德'  and i.type!='绩点' and h.student=" + sid;
                List<Harvest> harvestList3 = baseDAO.list(hqlgetharvest3);
                int tiyuMark = 0;
                for (Harvest har : harvestList3) {
                    tiyuMark = har.getMark();
                    tiyuTotal = tiyuTotal + tiyuMark;
                }
                if (tiyuTotal>10){
                    tiyuTotal=10;
                }
//                计算每个学生总分
//                String hqlgetharvest = "select h.iterms from Harvest h where h.student=" + sid;
//                List<Iterm> list1 = baseDAO.list(hqlgetharvest);
//                for (Object i : list1) {
//                    Iterm iid = (Iterm) i;
//                    int id = iid.getIid();
//                    String hql3 = "from Iterm i where i.iid=" + id;
//                    List list2 = baseDAO.list(hql3);
//                    Iterm ii = null;
//                    for (Object iterm : list2) {
//                        ii = (Iterm) iterm;
//                        int mark = ii.getMark();
//                        total = total + mark-deyucha;
                        total=deyuTotal+zhiyuTotal+tiyuTotal;
                        double a = total;
                        Student student1 = (Student) baseDAO.find(Student.class, sid);
                        student1.setTotal(a);
                        baseDAO.update(student1);

                    }
                     JOptionPane.showMessageDialog(null, "计算各个学生总分成功", "提示", JOptionPane.PLAIN_MESSAGE);
                     response.sendRedirect("/AboutAdminJsp/Scorefeedback.jsp");
                }
            }
        }

