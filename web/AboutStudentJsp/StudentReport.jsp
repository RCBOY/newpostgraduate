<%@ page import="DAO.BaseDAO" %>
<%@ page import="java.util.List" %>
<%@ page import="com.model.Student" %>
<%@ page import="com.model.Iterm" %>
<%@ page import="com.model.Harvest" %>
<%@ page import="javax.swing.*" %><%--
  Created by IntelliJ IDEA.
  User: 1234ztc
  Date: 2016/7/8
  Time: 21:56
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>学生报表</title>
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
    <!--保存操作后的提示信息：成功或者失败-->
    <div id="save_result_info" class="save_success">保存成功！</div><!--保存失败，数据并发错误！-->
    <form action="/Servlet/StudentInfoChangeServlet" method="post" class="main_form">
        <%

            HttpSession httpSession=request.getSession();
            String name=(String) httpSession.getAttribute("username");
            BaseDAO baseDAO=new BaseDAO();
            String hqlclose="from Harvest h where h.comment='禁止反馈'";
            List listclose=baseDAO.list(hqlclose);
            String title="学生报表";
            int sid = 0;
            double total = 0;
            String state = null;
            int deyuTotal = 0;
            int zhiyuTotal = 0;
            int tiyuTotal = 0;
            int fudaoTotal = 0;
            int num = 0;
            if (listclose.size()==0) {
//                获取学生总分和奖学金
                String gettotal = "from Student s where s.snum=" + name;
                List<Student> studentList = baseDAO.list(gettotal);
                Student student = null;

                int mid = 0;
                for (Student stu : studentList) {
                    student = stu;
                    total = student.getTotal();
                    state = student.getState();
                    sid = student.getSid();
                    mid = student.getMajor().getMid();
                }
//            获取德育分总分
                String hqlgetharvest = "select new Harvest(i.mark) from Harvest h,Iterm i where h.comment!='不通过' and h.iterms=i.iid  and i.type!='体育分' and i.type!='智育分' and i.type!='体育基本分' and i.type!='智育基本分' and i.type!='辅体' and i.type!='辅智' and i.type!='绩点' and h.student=" + sid;
                List<Harvest> harvestList = baseDAO.list(hqlgetharvest);
                int mark = 0;
                for (Harvest har : harvestList) {
                    mark = har.getMark();
                    deyuTotal = deyuTotal + mark;
                }
                if (deyuTotal>30){
                    deyuTotal=30;
                }
//            获取智育总分
                Student student2=(Student) baseDAO.find(Student.class,sid);
                String grade=student2.getMajor().getGrade();
                if (grade.equals("研究生二年级")){
                    String hqlgetharvest2 = "select new Harvest(i.mark) from Harvest h,Iterm i where h.iterms=i.iid and h.comment!='不通过' and i.type!='体育分' and i.type!='德育分' and i.type!='体育基本分' and i.type!='德育基本分' and i.type!='辅体' and i.type!='辅德' and i.type!='绩点' and h.student=" + sid;
                    List<Harvest> harvestList2 = baseDAO.list(hqlgetharvest2);
                    int zhiyuMark = 0;
                    for (Harvest har : harvestList2) {
                        zhiyuMark = har.getMark();
                        zhiyuTotal = zhiyuTotal + zhiyuMark;
                    }
                }else {
                    String hqlharvest2grade="select new Iterm(i.mark) from Harvest h,Iterm i where h.iterms=i.iid and h.comment='已通过' and i.type='绩点' and h.student="+sid;
                    List<Iterm> itermList=baseDAO.list(hqlharvest2grade);
                    int itermmark=0;
                    for (Iterm i:itermList){
                        itermmark =i.getMark()*10;
                    }
                    String hqlgetharvest2 = "select new Harvest(i.mark) from Harvest h,Iterm i where h.iterms=i.iid and h.comment='已通过' and i.type!='体育分' and i.type!='德育分' and i.type!='体育基本分' and i.type!='德育基本分' and i.type!='智育基本分' and i.type!='辅体' and i.type!='辅德' and i.type!='绩点' and h.student=" + sid;
                    List<Harvest> harvestList2 = baseDAO.list(hqlgetharvest2);
                    int zhiyuMark = 0;
                    for (Harvest har : harvestList2) {
                        zhiyuMark = har.getMark();
                        zhiyuTotal = zhiyuTotal + zhiyuMark;
                    }
                    zhiyuTotal=zhiyuTotal+itermmark;

                }
                if (zhiyuTotal<0){
                    zhiyuTotal=0;
                }
//            获取体育分
                String hqlgetharvest3 = "select new Harvest(i.mark) from Harvest h,Iterm i where h.comment!='不通过' and h.iterms=i.iid and i.type!='智育分' and i.type!='德育分' and i.type!='智育基本分' and i.type!='德育基本分' and i.type!='辅智' and i.type!='辅德' and i.type!='绩点' and h.student=" + sid;
                List<Harvest> harvestList3 = baseDAO.list(hqlgetharvest3);
                int tiyuMark = 0;
                for (Harvest har : harvestList3) {
                    tiyuMark = har.getMark();
                    tiyuTotal = tiyuTotal + tiyuMark;
                }
                if (tiyuTotal>10){
                    tiyuTotal=10;
                }
//           辅导员加减分
//                String hqlgetharvest4 = "select new Harvest(i.mark) from Harvest h,Iterm i where h.iterms=i.iid and i.type='辅导员' and h.student=" + sid;
//                List<Harvest> harvestList4 = baseDAO.list(hqlgetharvest4);
//                int fudaoMark = 0;
//                for (Harvest har : harvestList4) {
//                    fudaoMark = har.getMark();
//                    fudaoTotal = fudaoTotal + fudaoMark;
//                }
//            计算专业名次
                String pronum = "select new Student(s.sid,s.total,s.state) from Student s,Major m where s.major=m.mid and m.mid=" + mid + "order by s.total desc";
                List<Student> pronumlist = baseDAO.list(pronum);

                for (int i = 0; i < pronumlist.size(); i++) {
                    int newSid = pronumlist.get(i).getSid();
                    System.out.print("+" + newSid + "++" + i);
                    if (sid == newSid) {
                        num = i + 1;
                        break;
                    }
                }
            }else {
                title="学生报表暂未生成";
            }
                %>
        <div id="data">
            <table id="datalist">
                <tr>
                    <th colspan="2" ><%=title%></th>
                </tr>
                <tr>
                    <td width="22%" class="title"><b>总分</b></td>
                    <td width="78%">共<%=total%>分</td>
                </tr>
                <tr>
                    <td class="title"><b>德育分</b></td>
                    <td><a href="/AboutStudentJsp/StudentListReportDeyu.jsp?sid=<%=sid%>">共<%=deyuTotal%>分</a></td>
                </tr>
                <tr>
                    <td class="title"><b>智育分</b></td>
                    <td><a href="/AboutStudentJsp/StudentListReportZhiyu.jsp?sid=<%=sid%>">共<%=zhiyuTotal%>分</a></td>
                </tr>
                <tr>
                    <td class="title"><b>体育分</b></td>
                    <td><a href="/AboutStudentJsp/StudentListReportTiyu.jsp?sid=<%=sid%>">共<%=tiyuTotal%>分</a></td>
                </tr>
                <%--<tr>--%>
                    <%--<td class="title"><b>辅导员加减分</b></td>--%>
                    <%--<td><a href="/AboutStudentJsp/StudentListReportFudao.jsp?sid=<%=sid%>">共<%=fudaoTotal%>分</a></td>--%>
                <%--</tr>--%>
                <tr>
                    <td class="title"><b>奖学金</b></td>
                    <td><%=state%></td>
                </tr>
                <tr>
                    <td class="title"><b>专业名次</b></td>
                    <td><%=num%></td>
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
