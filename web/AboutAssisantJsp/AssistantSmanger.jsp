<%@ page import="DAO.BaseDAO" %>
<%@ page import="java.util.List" %>
<%@ page import="com.model.Student" %>
<%@ page import="com.model.Iterm" %>
<%@ page import="java.util.Date" %><%--
  Created by IntelliJ IDEA.
  User: 1234ztc
  Date: 2016/7/5
  Time: 13:06
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>学生管理</title>
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
        <li><a href="/Assistant.jsp" class="index_on"></a></li>
        <li><a href="/AboutAssisantJsp/AssistantSmanger.jsp" class="poststudents_off"></a></li>
        <li><a href="/AboutAssisantJsp/AssistantSmanger2.jsp" class="listStudent_off"></a></li>
        <li><a href="/AboutAssisantJsp/AssistantInfoShow.jsp" class="information_off"></a></li>
        <li><a href="/AboutAssisantJsp/AssistantChangePassword.jsp" class="password_off"></a></li>
        <li><a href="/AboutAssisantJsp/AssistantReport.jsp" class="report_off"></a></li>
    </ul>
</div>
<!--导航区域结束-->
<!--主要区域开始-->
<div id="main">
    <form action="" method="post" class="main_form">
        <%--表头--%>
        <div id="data">
            <table id="datalist">
               <tr>
                   <td class="title" colspan="10"><b>学生列表</b></td>
               </tr>
                <tr>
                    <th>学生ID</th>
                    <th>姓名</th>
                    <th>性别</th>
                    <th>联系方式</th>
                    <th>专业</th>
                    <th>年级</th>
                    <th></th>
                    <th></th>
                    <th></th>
                    <th></th>
                </tr>
                <%
                    request.setCharacterEncoding("utf-8");
                    response.setCharacterEncoding("utf-8");
                    HttpSession httpsession=request.getSession();
                    String aname=(String) httpsession.getAttribute("username");
                    BaseDAO baseDao=new BaseDAO();
                    String hqlgetstu="select new com.model.Student(s.sid,s.sname,s.ssex,s.stel,s.major) from Student s, Major m ,Assistant a where s.major=m.mid and s.assistant=a.aid and a.acc_num="+aname;
                    List liststudent=baseDao.list(hqlgetstu);
//                    Student student=null;
//                    for (Object stu:liststudent)
//                    {
//                        student=(Student)stu;
//                    }
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
                    for (int i=0;list!=null&&i<list.size();i++) {
                        stu = (Student) list.get(i);

                        int sid=stu.getSid();
                        String name=stu.getSname();
                        String sex=stu.getSsex();
                        String tel=stu.getStel();
                        String grade=stu.getMajor().getGrade();
                        String profession=stu.getMajor().getProfession();
                %>


                <tr>
                    <td><%=sid%></td>
                    <td><%=name%></td>
                    <td><%=sex%></td>
                    <td><%=tel%></td>
                    <td><%=grade%></td>
                    <td><%=profession%></td>
                    <td >
                        <a href="/AboutAssisantJsp/CheckStduentSubmit.jsp?sid=<%=sid%>" >审核</a>
                    </td>
                    <td >
                        <a href="/AboutAssisantJsp/AssistantChangeMark.jsp?sid=<%=sid%>" >评分</a>
                    </td>
                    <td >
                        <a href="/AboutAssisantJsp/AssistantDelSubmit.jsp?sid=<%=sid%>" >查看评分</a>
                    </td>
                    <td>
                        <a href="/Servlet/ListFileServlet?sid=<%=sid%>" >下载证明</a>
                    </td>

                </tr>
                <%
                    }
                %>
            </table>
        </div>
        <!--分页-->
        <div id="pages">
            <%
                for (int i=1;i<=p;i++)
                {
            %>
            <a href="${pageContext.request.requestURI}?action=<%=i%>"><%=i%></a>
            <%
                }
            %>
            共<%=p%>页
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
