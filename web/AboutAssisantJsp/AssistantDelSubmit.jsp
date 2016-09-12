<%@ page import="DAO.BaseDAO" %>
<%@ page import="java.util.List" %>
<%@ page import="com.model.Iterm" %>
<%@ page import="java.util.Date" %>
<%--
  Created by IntelliJ IDEA.
  User: 1234ztc
  Date: 2016/7/6
  Time: 21:28
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>撤销加减分</title>
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
        <%--表结构--%>

        <div id="data">
            <table id="datalist">
                <tr>
                    <td class="title" colspan="7"><b>已评分项列表</b></td>
                </tr>
                <tr>
                    <th>项目ID</th>
                    <th>项目名称</th>
                    <th>项目类型</th>
                    <th>创建时间</th>
                    <th>项目分值</th>
                    <th>项目状态</th>
                    <th></th>
                </tr>
               <% request.setCharacterEncoding("utf-8");
                response.setCharacterEncoding("utf-8");
                HttpSession httpsession=request.getSession();
                String sname=(String) httpsession.getAttribute("username");
                   int sid=Integer.parseInt(request.getParameter("sid"));
                BaseDAO baseDao=new BaseDAO();
                String hql= "select new com.model.Iterm(i.iid,i.iname,i.mark,i.type,h.comment,h.time,h.hid) from Harvest h, Iterm i where i.type!='德育分' and i.type!='智育分' and i.type!='体育分' and i.type!='德育基本分' and i.type!='体育基本分' and i.type!='智育基本分' and i.type!='绩点' and h.iterms=i.iid and h.student="+sid;
                List list2=baseDao.list(hql);
                int count=list2.size();
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
                list = baseDao.list(hql, curpage, size);
                %>
                <%--表格循环--%>
                <%
                    for (int i=0;list!=null&&i<list.size();i++){
                        Iterm iterm=(Iterm) list.get(i);

                        int i1=iterm.getIid();
                        String iname=iterm.getIname();
                        String type=iterm.getType();
                        Date time=iterm.getTime();
                        int mark=iterm.getMark();
                        int hid=iterm.getHid();
                        String coment=iterm.getComment();

                %>


                <tr>
                    <td><%=i1%></td>
                    <td><%=iname%></td>
                    <td><%=type%></td>
                    <td><%=time%></td>
                    <td><%=mark%></td>
                    <td><%=coment%></td>
                    <td class="td_modi" align="center">
                        <a href="/Servlet/AssistantDelSubmit?hid=<%=hid%>&&sid=<%=sid%>" methods="post">撤销申请</a>
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
            <a href="${pageContext.request.requestURI}?action=<%=i%>&&sid=<%=sid%>"><%=i%></a>
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
