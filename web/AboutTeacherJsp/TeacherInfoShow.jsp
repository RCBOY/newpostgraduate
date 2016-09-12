<%@ page import="DAO.BaseDAO" %>
<%@ page import="com.model.Assistant" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="com.model.Teacher" %><%--
  Created by IntelliJ IDEA.
  User: 1234ztc
  Date: 2016/7/7
  Time: 14:47
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>导师个人信息</title>
    <link type="text/css" rel="stylesheet" media="all" href="../styles/global.css" />
    <link type="text/css" rel="stylesheet" media="all" href="../styles/global_color.css" />
    <script language="javascript" type="text/javascript">
        //保存成功的提示信息
        function showResult() {
            showResultDiv(true);
            window.setTimeout("showResultDiv(false);", 3000);
        }
        function showResultDiv(flag) {
            var divResult = document.getElementById("save_result_info");
            if (flag)
                divResult.style.display = "block";
            else
                divResult.style.display = "none";
        }
    </script>
</head>
<body>
<%
    request.setCharacterEncoding("utf-8");
    HttpSession session1= request.getSession();
    String username=session1.getAttribute("username").toString();
    BaseDAO baseDAO=new BaseDAO();
    String hql="from Teacher a where a.acc_tnum="+username;
    List<Teacher> list= baseDAO.list(hql);
    Teacher tea=null;
    Iterator<Teacher> iterator=list.iterator();
    while (iterator.hasNext()){
        tea=(Teacher) iterator.next();
    }
    String tnum=tea.getAcc_tnum();
    String name=tea.getTname();
    String tel=tea.getTtel();
%>
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
    <form action="/Servlet/TeacherInfoChangeServlet" method="post" class="main_form">
        <div class="text_info clearfix"><span>账号：</span></div>
        <div class="input_info">
            <input type="text" name="account" readonly="readonly" class="readonly" value="<%=tnum%>" />
            <div class="validate_msg_medium">不可修改</div>
        </div>
        <div class="text_info clearfix"><span>姓名：</span></div>
        <div class="input_info">
            <input type="text" name="name"  class="readonly" value="<%=name%>" />
        </div>
        <div class="text_info clearfix"><span>电话：</span></div>
        <div class="input_info">
            <input type="text" name="tel" class="width200" value="<%=tel%>" />
            <div class="validate_msg_medium">电话号码格式：手机或固话</div>
        </div>
        <div class="button_info clearfix">
            <input type="submit" value="保存" class="btn_save" onclick="showResult();"  />
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
