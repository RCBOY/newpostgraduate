<%@ page import="DAO.BaseDAO" %>
<%@ page import="java.util.List" %>
<%@ page import="com.model.Student" %>
<%@ page import="com.model.Harvest" %>
<%@ page import="com.model.Iterm" %><%--
  Created by IntelliJ IDEA.
  User: 1234ztc
  Date: 2016/7/8
  Time: 21:57
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>导师报表</title>
    <link type="text/css" rel="stylesheet" media="all" href="../styles/global.css" />
    <link type="text/css" rel="stylesheet" media="all" href="../styles/global_color.css" />
</head>
<body>
<!--Logo区域开始-->
<div id="header">
    <img src="../images/logo.png" alt="logo" class="left"/>
    <a href="/Servlet/RemoveSessionServlet" methods="GET">[退出]</a>
</div>
<!--Logo区域结束-->
<!--导航区域开始-->
<div id="navi">
    <ul id="menu">
        <li><a href="/Teacher.jsp" class="index_on"></a></li>
        <li><a href="/AboutTeacherJsp/TeacherSmanger.jsp" class="poststudents_off"></a></li>
        <li><a href="/AboutTeacherJsp/TeacherSmanger2.jsp" class="listStudent_off"></a></li>
        <li><a href="/AboutTeacherJsp/TeacherInfoShow.jsp" class="information_off"></a></li>
        <li><a href="/AboutTeacherJsp/TeacherChangePassword.jsp" class="password_off"></a></li>
        <li><a href="/AboutTeacherJsp/TeacherReport.jsp" class="report_off"></a></li>
    </ul>
</div>
<!--导航区域结束-->
<!--主要区域开始-->
<div id="main">
    <!--保存操作后的提示信息：成功或者失败-->
    <div id="save_result_info" class="save_success">保存成功！</div><!--保存失败，数据并发错误！-->
    <form action="/Servlet/StudentInfoChangeServlet" method="post" class="main_form">
        <div id="data">
            <table id="datalist">
                <%
                    request.setCharacterEncoding("utf-8");
                    response.setCharacterEncoding("utf-8");
                    HttpSession httpsession=request.getSession();
                    String tname=(String) httpsession.getAttribute("username");
                    BaseDAO baseDao=new BaseDAO();
                    String hqlclose="from Harvest h where h.comment='禁止反馈'";
                    List listclose=baseDao.list(hqlclose);
                    int number2=listclose.size();
                    String title = "导师报表";
                    if (number2>0) {
                        title = "导师报表暂未生成";
                    }

                %>

                <tr>
                    <th colspan="10" class="title" ><b><%=title%></b></th>
                </tr>
                <tr>
                    <th>学号</th>
                    <th>姓名</th>
                    <th>总分排名</th>
                    <th>总分</th>
                    <th>智育总分</th>
                    <th>奖学金</th>
                    <th>年级</th>
                    <th>专业</th>
                </tr>
                <%
                    if (listclose.size()==0)
                    {
                        String hqlgetstu="select new com.model.Student(s.sid,s.snum,s.sname,s.major,s.state,s.total) from Student s, Major m ,Teacher t where s.major=m.mid and s.teacher=t.tid and t.acc_tnum="+tname;
                        List<Student> liststudent=baseDao.list(hqlgetstu);
                        int count=liststudent.size();
                        int curpage=1;
                        int size=3;
                        double num=(double)count/size;
                        int p=1;
                        p=(int)Math.ceil(num);

                        List list=null;
                        String s=request.getParameter("action");
                        if (s==null) {
                            s="1";
                            curpage = Integer.parseInt(s);
                        }else  curpage = Integer.parseInt(s);
                        list = baseDao.list(hqlgetstu, curpage, size);
                %>
                <%--表格循环--%>
                <%
                    Student stu=null;
                    for (Student student:liststudent) {
                        stu = student;
                        int sid=stu.getSid();
                        String name=stu.getSname();
                        String snum=stu.getSnum();
                        String state=stu.getState();
                        String grade=stu.getMajor().getGrade();
                        String profession=stu.getMajor().getProfession();
                        int mid=stu.getMajor().getMid();
                        double total=stu.getTotal();
                        int number = 0;
                        int zhiyuTotal = 0;

//                      计算专业名次
                        String pronum = "select new Student(s.sid,s.total,s.state) from Student s,Major m where s.major=m.mid and m.mid=" + mid + "order by s.total desc,s.major desc";
                        List<Student> pronumlist = baseDao.list(pronum);
                        for (int proi = 0; proi < pronumlist.size(); proi++) {
                            int newSid = pronumlist.get(proi).getSid();
                            System.out.print("+" + newSid + "++" + proi);
                            if (sid == newSid) {
                                number = proi + 1;
                                break;
                            }
                        }
//                      获取智育分总分
                        Student student2=(Student) baseDao.find(Student.class,sid);
                        String grade2=student2.getMajor().getGrade();
                        if (grade2.equals("研究生二年级")){
                            String hqlgetharvest2 = "select new Harvest(i.mark) from Harvest h,Iterm i where h.iterms=i.iid and h.comment!='不通过' and i.type!='体育分' and i.type!='德育分' and i.type!='体育基本分' and i.type!='德育基本分' and i.type!='辅体' and i.type!='辅德' and i.type!='绩点' and h.student=" + sid;
                            List<Harvest> harvestList2 = baseDao.list(hqlgetharvest2);
                            int zhiyuMark = 0;
                            for (Harvest har : harvestList2) {
                                zhiyuMark = har.getMark();
                                zhiyuTotal = zhiyuTotal + zhiyuMark;
                            }
                        }else {
                            String hqlharvest2grade="select new Iterm(i.mark) from Harvest h,Iterm i where h.iterms=i.iid and h.comment='已通过' and i.type='绩点' and h.student="+sid;
                            List<Iterm> itermList=baseDao.list(hqlharvest2grade);
                            int itermmark=0;
                            for (Iterm i:itermList){
                                itermmark =i.getMark()*10;
                            }
                            String hqlgetharvest2 = "select new Harvest(i.mark) from Harvest h,Iterm i where h.iterms=i.iid and h.comment='已通过' and i.type!='体育分' and i.type!='德育分' and i.type!='体育基本分' and i.type!='德育基本分' and i.type!='智育基本分' and i.type!='辅体' and i.type!='辅德' and i.type!='绩点' and h.student=" + sid;
                            List<Harvest> harvestList2 = baseDao.list(hqlgetharvest2);
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
//
                %>
                <tr>
                    <td><%=snum%></td>
                    <td><%=name%></td>
                    <td><%=number%></td>
                    <td><%=total%></td>
                    <td><%=zhiyuTotal%></td>
                    <td><%=state%></td>
                    <td><%=grade%></td>
                    <td><%=profession%></td>
                </tr>
                <%
                        }
                    }
                %>
            </table>
        </div>
    </form>
</div>
<!--主要区域结束-->
<div id="footer">
    <p>[真正做到最公平的，最全面的研究生成绩考核系统]</p>
    <p>版权所有(C)浙江工业大学 </p>
</div>
</body>
</html>
