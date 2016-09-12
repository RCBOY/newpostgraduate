<%@ page import="java.util.List" %>
<%@ page import="com.model.Teacher" %>
<%@ page import="java.util.prefs.BackingStoreException" %>
<%@ page import="DAO.BaseDAO" %>
<%@ page import="com.model.Student" %>
<%@ page import="com.model.Harvest" %>
<%@ page import="com.model.Assistant" %><%--
  Created by IntelliJ IDEA.
  User: 1234ztc
  Date: 2016/7/10
  Time: 10:33
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>指定辅导员</title>
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
        <li><a href="/Admin.jsp" class="index_on"></a></li>
        <li><a href="/AboutAdminJsp/Scorefeedback.jsp" class="information1_off"></a></li>
        <li><a href="/AboutAdminJsp/AdminPointAssistant.jsp" class="information3_off"></a></li>
        <li><a href="/AboutAdminJsp/AdminPointTeacher.jsp" class="information2_off"></a></li>
        <li><a href="/AboutAdminJsp/AdminReport.jsp" class="report_off"></a></li>
    </ul>
</div>
<!--导航区域结束-->
<!--主要区域开始-->
<div id="main">

    <form action="/Servlet/AdminPointAssistantServlet" method="post" class="main_form">
        <%--表结构--%>

        <div id="data">
            <table id="datalist">
                <tr>
                    <th colspan="3"><b>未完成审核导师名单</b></th>
                </tr>
                <tr>
                    <th>导师姓名</th>
                    <th>未审核学生</th>
                    <th>导师联系电话</th>
                </tr>
                <%
                    request.setCharacterEncoding("UTF-8");
                    response.setCharacterEncoding("UTF-8");
                    String daoshihql="from Teacher t";
                    BaseDAO baseDao=new BaseDAO();
                    List<Teacher> teacherlist=baseDao.list(daoshihql);
                    for (Teacher teacher:teacherlist){
                        int tid=teacher.getTid();
                        String tname=teacher.getTname();
                        String ttel=teacher.getTtel();
                        String studenthql="select new Student(s.sid,s.sname) from Student s where s.teacher="+tid;
                        List<Student> studentlist= baseDao.list(studenthql);
                        for (Student stu:studentlist){
                           int sid= stu.getSid();
                            String sname=stu.getSname();
                            String harvesthql="from Harvest h,Iterm i where h.comment='待审核' and h.iterms=i.iid and i.type!='德育分'and i.type!='体育分' and h.student="+sid;
                            List<Harvest> harvestlist=baseDao.list(harvesthql);
                            int num=harvestlist.size();
                            if (num>0){
                                %>
                       <tr>
                                              <td><%=tname%></td>
                                              <td><%=sname%></td>
                                              <td><%=ttel%></td>
                                      </tr>
                <%
                            }
                        }
                    }
                %>
                </table>
         <hr/>
            <table id="datalist2">
                <tr>
                    <th colspan="3"><b>未完成审核辅导员名单</b></th>
                </tr>
                <tr>
                    <th>辅导员姓名</th>
                    <th>未审核学生</th>
                    <th>辅导员联系电话</th>
                </tr>
                <%
                    String fudaohql="from Assistant t";
                    List<Assistant> Assistantlist=baseDao.list(fudaohql);
                    for (Assistant assistant:Assistantlist){
                        int aid=assistant.getAid();
                        String aname=assistant.getAname();
                        String atel=assistant.getAtel();
                        String studenthql="select new Student(s.sid,s.sname) from Student s where s.assistant="+aid;
                        List<Student> studentlist= baseDao.list(studenthql);
                        for (Student stu:studentlist){
                            int sid= stu.getSid();
                            String sname=stu.getSname();
                            String harvesthql="from Harvest h,Iterm i where h.comment='待审核' and h.iterms=i.iid and i.type!='智育分' and h.student="+sid;
                            List harvestlist=baseDao.list(harvesthql);
                            int num=harvestlist.size();
                            if (num>0){
                %>
                <tr>
                    <td><%=aname%></td>
                    <td><%=sname%></td>
                    <td><%=atel%></td>
                </tr>
                <%
                            }
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
