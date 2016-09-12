<%@ page import="java.util.Map" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.io.File" %>
<%@ page import="DAO.BaseDAO" %>
<%@ page import="com.model.Student" %><%--
  Created by IntelliJ IDEA.
  User: 1234ztc
  Date: 2016/7/9
  Time: 23:58
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>下载列表</title>
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
    <!--保存操作后的提示信息：成功或者失败-->
    <div id="save_result_info" class="save_success">修改成功！</div><!--保存失败，数据并发错误！-->
    <form action="" method="post" class="main_form">
        <table id="datalist">
            <tr>
                <th colspan="3"><b>证明材料下载</b></th>
                <th></th>
            </tr>
            <tr>
                <th>文件名</th>
                <th></th>
            </tr>
        <!-- 遍历Map集合 -->
        <%
            request.setCharacterEncoding("UTF-8");
            response.setCharacterEncoding("UTF-8");
          String id=  request.getParameter("sid");
            int sid=Integer.parseInt(id);
            BaseDAO baseDAO=new BaseDAO();
          Student student=(Student) baseDAO.find(Student.class,sid);
           String snum= student.getSnum();
          Map<String,String> map= (Map<String, String>) request.getAttribute("fileNameMap");
            for (Map.Entry<String,String> entry : map.entrySet()) {
                String Key =  entry.getKey() ;
                String Value =entry.getValue();
                String str=Value.substring(0,5);
                String realValue=Value.substring(5);
                if (snum.equals(str)){
        %>
            <tr>
                <td><%=realValue%></td>
                <td><a href="/Servlet/DownLoadServlet?filename=<%=Value%>>">点击下载</a></td>
            </tr>

        <%
            }
            }
        %>
        </table>
    </form>
</div>
<!--主要区域结束-->
<div id="footer">
    <p>[真正做到最公平的，最全面的研究生成绩考核系统]</p>
    <p>版权所有(C)浙江工业大学 </p>
</div>
</body>
</html>
