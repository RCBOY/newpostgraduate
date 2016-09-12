package Util;

import DAO.BaseDAO;
import com.model.*;
import org.hibernate.Session;
import org.hibernate.boot.registry.StandardServiceRegistryBuilder;
import org.hibernate.cfg.Configuration;
import org.hibernate.service.ServiceRegistry;
import org.hibernate.tool.hbm2ddl.SchemaExport;


import javax.servlet.http.HttpSession;
import javax.swing.plaf.synth.SynthEditorPaneUI;
import java.util.*;
import java.util.Date;

/**
 * Created by 1234ztc on 2016/5/24.
 */



public class test {
    public static void main(String[] args) {


//        BaseDAO baseDAO=new BaseDAO();
//        String username="30003";
//        String password="123456";
//        String sql="from Assistant a where a.acc_num="+username+"and a.password="+password;
//        List<Assistant>list=baseDAO.list(sql);
//        System.out.println(list.size()+sql);
//        Iterm iterm=new Iterm();
//        iterm.setType("德育分");
//        iterm.setIname("国家级嘉奖");
//        iterm.setMark(5);
//
//        Iterm iterm2=new Iterm();
//        iterm2.setType("德育分");
//        iterm2.setIname("院级嘉奖");
//        iterm2.setMark(3);
//
//         Date date=new Date();
//        Harvest harvest=new Harvest();
//        harvest.setComment("嘉奖加分");
//        harvest.setTime(date);
//        harvest.setIterms(iterm);
//
//        Date date1=new Date();
//        Harvest harvest1=new Harvest();
//        harvest1.setComment("嘉奖加分");
//        harvest1.setTime(date1);
//        harvest1.setIterms(iterm2);
//
//        Set<Harvest> harvestSet=new HashSet();
//        harvestSet.add(harvest);
//        harvestSet.add(harvest1);
//
//        Major major=new Major();
//        major.setGrade("研二");
//        major.setProfession("艺术学院");
//
//        Teacher teacher=new Teacher();
//        teacher.setAcc_tnum("20004");
//        teacher.setTname("海涛");
//        teacher.setPassword("123456");
//        teacher.setTtel("15699985566");
//
//        Assistant assistant=new Assistant();
//        assistant.setAcc_num("30004");
//        assistant.setPassword("123456");
//        assistant.setAname("孙红雷");
//        assistant.setAtel("13655894567");
//
//        Student student=new Student();
//        student.setPassword("123456");
//        student.setAcc_snum("40006");
//        student.setHarvest(harvestSet);
//        student.setSname("张学友");
//        student.setMajor(major);
//        student.setSsex("男");
//        student.setAssistant(assistant);
//        student.setTeacher(teacher);
//        student.setHarvest(harvestSet);
//        Session session= HibernateUtil.getSessionFactory().openSession();
//        org.hibernate.Transaction transaction=session.beginTransaction();
//
//        session.save(iterm);
//        session.save(iterm2);
//        session.save(harvest);
//        session.save(harvest1);
//        session.save(major);
//        session.save(teacher);
//        session.save(assistant);
//        session.save(student);
//
//       transaction.commit();
//        session.flush();
//        session.close();
//test.createTable();
//        BaseDAO baseDAO=new BaseDAO();
//        int total=0;
//        String hql=" from Student s";
//        List<Student> list= baseDAO.list(hql);
//        Student stu=null;
//        for (Student student:list){
//            total=0;
//            stu=student;
//            int sid=stu.getSid();
//            String hqlgetharvest="select h.iterms from Harvest h where h.student="+sid;
//            List<Iterm> list1=baseDAO.list(hqlgetharvest);
//            for (Object i:list1){
//                Iterm iid=(Iterm) i;
//                int id= iid.getIid();
//                String hql3="from Iterm i where i.iid="+id;
//               List list2= baseDAO.list(hql3);
//                Iterm ii=null;
//                for (Object iterm:list2){
//                    ii=(Iterm) iterm;
//                    int mark=ii.getMark();
//                    total=total+mark;
//                    double a=total;
//                    Student student1= (Student) baseDAO.find(Student.class,sid);
//                    student1.setTotal(a);
//                    baseDAO.update(student1);
//                }
//            }
//        }
  BaseDAO baseDAO= new BaseDAO();
        int zhiyuTotal=0;
        String hqlharvest2grade="select new Iterm(i.mark) from Harvest h,Iterm i where h.iterms=i.iid and h.comment='已通过' and i.type='绩点' and h.student=1";
        List<Iterm> itermList=baseDAO.list(hqlharvest2grade);
        int itermmark=0;
        for (Iterm i:itermList){
            itermmark =i.getMark()*10;
        }
        String hqlgetharvest2 = "select new Harvest(i.mark) from Harvest h,Iterm i where h.iterms=i.iid and h.comment='已通过' and i.type!='体育分' and i.type!='德育分' and i.type!='体育基本分' and i.type!='德育基本分' and i.type!='智育基本分' and i.type!='辅体' and i.type!='辅德' and i.type!='绩点' and h.student=1" ;
        List<Harvest> harvestList2 = baseDAO.list(hqlgetharvest2);
        int zhiyuMark = 0;
        for (Harvest har : harvestList2) {
            zhiyuMark = har.getMark();
            zhiyuTotal = zhiyuTotal+zhiyuMark;
        }
        zhiyuTotal=zhiyuTotal+itermmark;
        System.out.print(zhiyuTotal);

    }

    public static void createTable(){
        Configuration cfg=new Configuration().configure();
        SchemaExport se=new SchemaExport(cfg);
        se.create(true,true);
    }

}
