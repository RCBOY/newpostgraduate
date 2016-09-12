<%@ page import="DAO.BaseDAO" %>
<%@ page import="java.util.List" %>
<%@ page import="com.model.Iterm" %>
<%@ page import="java.util.Date" %><%--
  Created by IntelliJ IDEA.
  User: 1234ztc
  Date: 2016/7/6
  Time: 22:54
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>学生申请详细</title>
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
<div id="main">
    <form action="/Servlet/AssistantChangeSubmitServlet" method="post" class="main_form">
        <%--表头--%>
        <div id="data">
            <table id="datalist">

                <%
                    request.setCharacterEncoding("utf-8");
                    response.setCharacterEncoding("utf-8");
                    int sid= (int)session.getAttribute("sid");

                    int hid=Integer.parseInt(request.getParameter("hid"));
//                    if(i==null){
//                        hid=(int)request.getAttribute("sid");
//                    }else

                    session.setAttribute("hid",hid);
                    HttpSession httpsession=request.getSession();
                    httpsession.setAttribute("sid",sid);
                    String aname=(String) httpsession.getAttribute("username");
                    BaseDAO baseDao=new BaseDAO();
                    String hql= "select new com.model.Iterm(i.iid,i.iname,i.mark,i.type,h.comment,h.time,h.hid) from Harvest h, Iterm i where h.iterms=i.iid  and i.type!='智育分' and i.type!='辅德' and i.type!='辅体' and i.type!='辅智'and h.hid="+hid;
                    List listiterm=baseDao.list(hql);
                    int count=listiterm.size();
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
                    }else {
                        curpage = Integer.parseInt(s);
                    }
                    list = baseDao.list(hql, curpage, size);
                %>
                <%--表格循环--%>
                <%
                    for (int i=0;list!=null&&i<list.size();i++){
                        Iterm it=(Iterm) list.get(i);

                        int i1=it.getIid();
                        String iname=it.getIname();
                        String type=it.getType();
                        Date time=it.getTime();
                        int mark=it.getMark();
                        String coment=it.getComment();
                %>
                <tr>
                    <th class="title" colspan="2"><b>项目详细</b></th>
                </tr>
                <tr>
                    <td class="title">项目ID</td>
                    <td><%=i1%></td>
                </tr>
                <tr>
                    <td class="title">项目名称</td>
                    <td><%=iname%></td>
                </tr>
                <tr>
                    <td class="title">项目类型</td>
                    <td><%=type%></td>
                </tr>
                <tr>
                    <td class="title">创建时间</td>
                    <td><%=time%></td>
                </tr>
                <tr>
                    <td class="title">分数</td>
                    <td><%=mark%></td>
                </tr>
                <tr>
                    <td class="title"> 项目状态</td>
                    <td><%=coment%></td>
                </tr>
                <%
                    }
                %>
                    <tr>
                        <td class="title">

                        </td>
                        <td align="center">
                            <select onclick="" name="select" id="selModules" class="select_search">
                                <option>已通过</option>
                                <option>不通过</option>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td class="title">
                        </td>
                        <td align="center">
                                <input type="submit" value="提交" class="btn_save" />
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
