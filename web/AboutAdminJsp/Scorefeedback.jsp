<%@ page import="DAO.BaseDAO" %>
<%@ page import="java.util.List" %>
<%@ page import="com.model.Major" %><%--
  Created by IntelliJ IDEA.
  User: 1234ztc
  Date: 2016/7/7
  Time: 17:59
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>奖学金评定规则</title>
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

    <form action="/Servlet/AdminScoreServlet" method="post" class="main_form">
        <%--表结构--%>

        <div id="data">
            <table id="datalist">
                <tr>
                    <th colspan="4"><b>管理员数据处理</b></th>
                </tr>
                <tr>
                    <th>年级</th>
                    <th>专业</th>
                    <th>前百分比</th>
                    <th>所设等级</th>
                </tr>
                <tr>
                    <td>
                        <select onclick="" name="grade" id="selModules" class="select_search">
                            <%
                                BaseDAO baseDao=new BaseDAO();
                                String hql="select distinct m.grade from Major m";
                                List<String> list=baseDao.list(hql);
                                String grade=null;
                                for (String major:list){
                                    grade=major;

                            %>
                               <option><%=grade%></option>
                            <%
                                }
                            %>
                        </select>
                    </td>
                    <td>
                        <select onclick="" name="profess" id="selModules2" class="select_search">
                            <%
                                String hql2="select distinct m.profession from Major m";
                                List<String> list2=baseDao.list(hql2);
                                String pro=null;
                                for (String major2:list2){
                                    pro=major2;
                            %>
                            <option><%=pro%></option>
                            <%
                                }
                            %>
                        </select>
                    </td>
                    <td>
                        <select onclick="" name="percent" id="selModules3" class="select_search">
                            <option>10</option>
                            <option>20</option>
                            <option>30</option>
                            <option>40</option>
                            <option>50</option>
                            <option>60</option>
                            <option>100</option>
                       </select>
                    </td>
                    <td>
                        <select onclick="" name="ship" id="selModules4" class="select_search">
                            <option>一等奖学金</option>
                            <option>二等奖学金</option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td colspan="4"align="center"> <a href="/Servlet/AdminDeyuTogetherServlet" methods="get" style="text-decoration: underline">添加基本德育分</a>
                    </td>
                </tr>
                <tr>
                    <td colspan="4"align="center"> <a href="/Servlet/AdminZhiyuTogetherServlet" methods="get" style="text-decoration: underline">添加基本智育分</a>
                    </td>
                </tr>
                <tr>
                    <td colspan="4"align="center"> <a href="/Servlet/AdminTiyuTogetherServlet" methods="get" style="text-decoration: underline">添加基本体育分</a>
                    </td>
                </tr>
                <tr>
                    <td colspan="4"align="center"><a href="/Servlet/AdminTotalScoreServlet" methods="get">计算各学生总分</a> </td>
                </tr>

                <tr>
                    <td colspan="4" align="center">
                        <div >
                            <input type="submit" value="设置规则" class="btn_save" />
                        </div>
                    </td>
                </tr>
                <tr>
                    <td colspan="4"align="center"><a href="/Servlet/AdminYesSubmitServlet" methods="get" style="text-decoration: underline">允许提交申请</a>
                        <a href="/Servlet/AdminNoSubmitServlet" methods="get"  style="text-decoration: underline">禁止提交申请</a>
                    </td>
                </tr>
                <tr>
                    <td colspan="4"align="center"> <a href="/Servlet/AdminFeedBackServlet" methods="get" style="text-decoration: underline">允许反馈报表</a>
                        <a href="/Servlet/AdminNoFeedBackServlet" methods="get"  style="text-decoration: underline">禁止反馈报表</a>
                    </td>
                </tr>
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
