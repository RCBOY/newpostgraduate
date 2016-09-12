<%@ page import="org.hibernate.Session" %>
<%@ page import="org.omg.CORBA.SystemException" %>
<%@ page import="DAO.BaseDAO" %>
<%@ page import="java.util.List" %>
<%@ page import="com.model.Student" %>
<%@ page import="java.util.Iterator" %><%--
  Created by IntelliJ IDEA.
  User: 1234ztc
  Date: 2016/6/8
  Time: 16:19
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>研究生个人信息</title>
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
    String hql="from Student s where s.snum="+username;
    List<Student> list= baseDAO.list(hql);
    Student stu=null;
   Iterator<Student> iterator=list.iterator();
    while (iterator.hasNext()){
        stu=(Student) iterator.next();
    }
    String snum= stu.getSnum();
    String sname=stu.getSname();
    String sex=stu.getSsex();
    String stel=stu.getStel();
    String profession=stu.getMajor().getProfession();
    String grade=stu.getMajor().getGrade();
    String assistant=stu.getAssistant().getAname();
    String assistanttel=stu.getAssistant().getAtel();
    String teacher=stu.getTeacher().getTname();
    String teachertel=stu.getTeacher().getTtel();

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
    <div id="save_result_info" class="save_success">保存成功！</div><!--保存失败，数据并发错误！-->
    <form action="/Servlet/StudentInfoChangeServlet" method="post" class="main_form">
        <div id="data">
        <table id="datalist">
            <tr>
                <th colspan="2"><b>学生信息</b></th>
            </tr>
            <tr>
                <td class="title"><b>账号</b></td>
                <td><%=snum%></td>
            </tr>
            <tr>
                <td class="title"><b>年级</b></td>
                <td><%=grade%></td>
            </tr>
            <tr>
                <td class="title"><b>专业</b></td>
                <td><%=profession%></td>
            </tr>
            <tr>
                <td class="title"><b>导师</b></td>
                <td><%=teacher%></td>
            </tr>
            <tr>
                <td class="title"><b>导师电话</b></td>
                <td><%=teachertel%></td>
            </tr>
            <tr>
                <td class="title"><b>辅导员</b></td>
                <td><%=assistant%></td>
            </tr>
            <tr>
                <td class="title"><b>辅导员电话</b></td>
                <td><%=assistanttel%></td>
            </tr>
        </table>
        </div>

        <div class="text_info clearfix"><span>姓名：</span></div>
        <div class="input_info">
            <input type="text" name="name"  class="readonly" value="<%=sname%>" />
        </div>
        <div class="text_info clearfix"><span>性别：</span></div>
        <div class="input_info">
            <input type="text" name="sex" value="<%=sex%>" />
            <%--<span class="required">*</span>--%>
            <%--<div class="validate_msg_long error_msg">20长度以内的汉字、字母的组合</div>--%>
        </div>
        <div class="text_info clearfix"><span>电话：</span></div>
        <div class="input_info">
            <input type="text" name="tel" class="width200" value="<%=stel%>" />
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
