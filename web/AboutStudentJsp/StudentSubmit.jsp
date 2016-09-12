<%@ page import="DAO.BaseDAO" %>
<%@ page import="java.util.List" %>
<%@ page import="com.model.Iterm" %><%--
  Created by IntelliJ IDEA.
  User: 1234ztc
  Date: 2016/7/1
  Time: 16:38
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>



<html>
<head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <title>提交申请</title>
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
    <form action="/Servlet/StudentSearchServlet" method="post" class="main_form">
        <%--搜索--%>
        <div class="search_add">
                <div>
                    模块：
                    <select onclick="" name="search" id="selModules" class="select_search">
                    <option>全部</option>
                    <option>德育分</option>
                    <option>智育分</option>
                    <option>体育分</option>
                </select>
                </div>
                <div>名称：<input name="search2" type="text" value="" class="text_search width200"  /></div>
                <div><input type="submit" value="搜索"  class="btn_search"/></div>
            </div>

        <%--表结构--%>

        <div id="data">
            <table id="datalist">
                <tr>
                    <td class="title" colspan="5"><b>申请项目列表</b></td>
                </tr>
                <tr>
                    <th>项目ID</th>
                    <th>项目名称</th>
                    <th>项目类型</th>
                    <th>项目分值</th>
                    <th></th>
                </tr>
                <%
                    request.setCharacterEncoding("utf-8");
                    response.setCharacterEncoding("utf-8");
                    BaseDAO baseDao=new BaseDAO();
                    String hql1=(String) request.getAttribute("hql");
                    String hql=null;
                    List list2=null;
                    System.out.print("+++++"+hql1);
                    if (hql1==null) {
                        hql = "from Iterm i where i.mark>=0 and i.type!='辅德' and i.type!='辅智'and i.type!='辅体'and i.type!='德育基本分'and i.type!='体育基本分'and i.type!='智育基本分'";
                    }
                    else hql=hql1;

                    list2=baseDao.list(hql);
                    int count=list2.size();
                    int curpage=1;
                    int size=6;
                    double num=(double)count/size;
                    int p=1;
                    p=(int)Math.ceil(num);

                    List list=null;
                    String s=request.getParameter("action");
//                    int s1=Integer.parseInt(s);
                    if (s==null) {
                        s="1";
                        curpage = Integer.parseInt(s);
                    }else  curpage = Integer.parseInt(s);
                        list = baseDao.list(hql, curpage, size);
                %>
                <%--表格循环--%>
                 <%
                     for (int i=0;list!=null&&i<list.size();i++){
                         Iterm iterm=(Iterm) list.get(i);
                %>


                <tr>
                    <td><%=iterm.getIid()%></td>
                    <td><%=iterm.getIname()%></td>
                    <td><%=iterm.getType()%></td>
                    <td><%=iterm.getMark()%></td>
                    <td class="td_modi">
                       <a href="/Servlet/StudentSubmitServlet?iid=<%=iterm.getIid()%>">申请</a>
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
