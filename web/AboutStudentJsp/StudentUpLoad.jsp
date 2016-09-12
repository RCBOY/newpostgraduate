<%@ page import="DAO.BaseDAO" %>
<%@ page import="com.model.Student" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.List" %><%--
  Created by IntelliJ IDEA.
  User: 1234ztc
  Date: 2016/7/3
  Time: 21:06
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>上传证明文件</title>
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
    <form action="/Servlet/UploadHandleServlet" enctype="multipart/form-data" method="post" class="main_form">
        <table id="datalist">
            <tr>
                <th >
                    <b>证明材料上传</b>
                </th>
            </tr>
            <tr>
                <td >
                    <div ><b>上传文件：</b><input type="file" name="file2"></div>
                </td>
            </tr>
            <tr>
                <td >
                    <div ><input type="submit" value="提交" class="btn_save" ><br/></div>
                </td>
            </tr>
            <tr>
                <td >
                    <div ><a href="/Servlet/StudentListFileServlet">查看上传文件</a><br/></div>
                </td>
            </tr>
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
