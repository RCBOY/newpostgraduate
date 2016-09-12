<%@ page import="DAO.BaseDAO" %>
<%@ page import="com.model.Assistant" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Iterator" %><%--
  Created by IntelliJ IDEA.
  User: 1234ztc
  Date: 2016/7/4
  Time: 21:03
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>辅导员个人信息</title>
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
String hql="from Assistant a where a.acc_num="+username;
List<Assistant> list= baseDAO.list(hql);
    Assistant ass=null;
    Iterator<Assistant> iterator=list.iterator();
        while (iterator.hasNext()){
        ass=(Assistant) iterator.next();
        }
        String anum=ass.getAcc_num();
        String name=ass.getAname();
        String tel=ass.getAtel();
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
    <div id="save_result_info" class="save_success">保存成功！</div><!--保存失败，数据并发错误！-->
    <form action="/Servlet/AssistantInfoChangeServlet" method="post" class="main_form">
        <div class="text_info clearfix"><span>账号：</span></div>
        <div class="input_info">
            <input type="text" name="account" readonly="readonly" class="readonly" value="<%=anum%>" />
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
