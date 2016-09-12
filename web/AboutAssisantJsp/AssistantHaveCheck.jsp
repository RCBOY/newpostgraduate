<%@ page import="DAO.BaseDAO" %>
<%@ page import="java.util.List" %>
<%@ page import="com.model.Iterm" %><%--
  Created by IntelliJ IDEA.
  User: 1234ztc
  Date: 2016/7/7
  Time: 13:39
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>已审核学生</title>
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
        <%--表头--%>
        <div id="data">
            <table id="datalist">
                <tr>
                    <td class="title" colspan="2"><b>已审核学生项目</b></td>
                </tr>
                <tr>
                    <th>项目ID</th>
                    <th>已审核项目</th>
                    <%--<th>项目类型</th>--%>
                    <%--<th>创建时间</th>--%>
                    <%--<th>项目分值</th>--%>
                    <%--<th>申请状态</th>--%>
                    <%--<th></th>--%>
                    <%--<th></th>--%>
                </tr>
                <%
                    request.setCharacterEncoding("utf-8");
                    response.setCharacterEncoding("utf-8");
                    int sid=Integer.parseInt( request.getParameter("sid"));
//                  int sid=Integer.parseInt(id);

                    HttpSession httpsession=request.getSession();
                    session.setAttribute("sid",sid);
                    String aname=(String) httpsession.getAttribute("username");

                    BaseDAO baseDao=new BaseDAO();
//                    String hqlgetstu="select new com.model.Student(s.sid,s.sname,s.ssex,s.stel,s.major) from Student s, Major m ,Assistant a where s.major=m.mid and s.assistant=a.aid and a.acc_num="+aname;
                    String hql= "select new com.model.Iterm(i.iid,i.iname,i.mark,i.type,h.comment,h.time,h.hid) from Harvest h, Iterm i where h.iterms=i.iid and i.type!='智育分' and i.type!='辅德' and i.type!='辅体' and i.type!='辅智'and i.type!='体育基本分' and i.type!='德育基本分' and i.type!='智育基本分' and h.comment!='待审核' and h.student="+sid;
                    List listiterm=baseDao.list(hql);
//                    Iterm iterm=null;
//                    for (Object stu:listiterm)
//                    {
//                       iterm=(Iterm) stu;
//                    }
//                    List list2=baseDao.list(hqlgetstu);
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
//                        String type=it.getType();
//                        Date time=it.getTime();
//                        int mark=it.getMark();
                        int hid=it.getHid();
//                        String coment=it.getComment();
                %>
                <tr>
                    <td><%=i1%></td>
                    <td><a href="/AboutAssisantJsp/AssistantCheackDetailIterm.jsp?hid=<%=hid%>&&i1=<%=i1%>"><%=iname%></a> </td>
                    <%--<td><%=type%></td>--%>
                    <%--<td><%=time%></td>--%>
                    <%--<td><%=mark%></td>--%>
                    <%--<td><%=coment%></td>--%>
                    <%--<td>--%>
                    <%--<select onclick="" name="search<%=i1%>" id="selModules" class="select_search">--%>
                    <%--<option>已通过</option>--%>
                    <%--<option>不通过</option>--%>
                    <%--</select>--%>
                    <%--</td>--%>
                    <%--<td class="td_modi">--%>
                    <%--<a href="/Servlet/AssistantChangeServlet?hid=<%=hid%>&&i1=<%=i1%>" methods="get">提交</a>--%>
                    <%--&lt;%&ndash;<div class="button_info clearfix">&ndash;%&gt;--%>
                    <%--&lt;%&ndash;<input type="submit" value="保存" class="btn_save" />&ndash;%&gt;--%>
                    <%--&lt;%&ndash;</div>&ndash;%&gt;--%>
                    <%--</td>--%>
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
