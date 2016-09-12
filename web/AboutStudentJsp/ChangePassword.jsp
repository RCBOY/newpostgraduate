<%--
  Created by IntelliJ IDEA.
  User: 1234ztc
  Date: 2016/7/1
  Time: 11:52
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>密码修改</title>
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

<!--Logo区域开始-->
<div id="header">
    <img src="../images/logo.png" alt="logo" class="left"/>
    <a href="/Servlet/RemoveSessionServlet" methods="GET">[退出]</a>
</div>
<!--Logo区域结束-->
<!--导航区域开始-->
<div id="navi">
    <ul id="menu">
        <li><a href="../Student.jsp" class="index_on"></a></li>
        <li><a href="/AboutStudentJsp/StudentInfoShow.jsp" class="information_off"></a></li>
        <li><a href="/AboutStudentJsp/ChangePassword.jsp" class="password_off"></a></li>
        <li><a href="/AboutStudentJsp/StudentSubmit.jsp" class="request_off"></a></li>
        <li><a href="/AboutStudentJsp/StudentListofSubmit.jsp" class="look_off"></a></li>
        <li><a href="/AboutStudentJsp/StudentReport.jsp" class="report_off"></a></li>
        <li><a href="/AboutStudentJsp/StudentUpLoad.jsp" class="upload_off"></a></li>
    </ul>
</div>
<!--导航区域结束-->
<!--主要区域开始-->
<div id="main">
    <!--保存操作后的提示信息：成功或者失败-->
    <div id="save_result_info" class="save_success">修改成功！</div><!--保存失败，数据并发错误！-->
    <form action="/Servlet/PassWordChangeServlet" method="post" class="main_form">
        <div class="text_info clearfix"><span>原始密码</span></div>
        <div class="input_info">
            <input type="password" name="oldpassword"  class="readonly" placeholder="输入密码" />
            <div class="validate_msg_medium">如有遗忘联系管理员</div>
        </div>
        <div class="text_info clearfix"><span>新密码：</span></div>
        <div class="input_info">
            <input type="password" name="newpassword" class="readonly"  placeholder="输入新密码"/>
            <div class="validate_msg_medium">密码格式不限</div>
        </div>
        <div class="text_info clearfix"><span>确认密码：</span></div>
        <div class="input_info">
            <input type="password"  name="password"  placeholder="再次输入密码"/>
            <%--<span class="required">*</span>--%>
            <%--<div class="validate_msg_long error_msg">20长度以内的汉字、字母的组合</div>--%>
        </div>
        <div class="button_info clearfix">
            <input type="submit" value="保存" class="btn_save" />
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
