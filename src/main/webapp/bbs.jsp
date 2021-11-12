<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.io.PrintWriter" %>
<%@ page import = "bbs.BbsDAO" %>
<%@ page import = "bbs.Bbs" %>
<%@ page import = "java.util.ArrayList" %>


<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width", initial-scale="1" >
    <%@ include file="/commonInclude.jsp" %>
    <title>게시판</title>
    <style>
        a, a:hover{
            color : #000000;
            text-decoration : none;   
        }
    </style>
</head>
<body>
<%
	String userID = null;
	if (session.getAttribute("userID")!=null){  //세션의 userID속성이 null이 아니면
	    userID = (String) session.getAttribute("userID");
	}
	/* 페이지처리 */
	int pageNumber = 1;    
	if(request.getParameter("pageNumber")!=null){
	    pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
	}
%>


    <nav class="navbar navbar-default">
        <!-- 네브바 헤드 -->
        <div class="navbar-header">
            <button type="button" class="navbar-toggle collapsed" data-toggle="collapse"
            data-target = "#bs-example-navbar-collapse-1" aria-expanded="false">
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <a class="navbar-brand" href="main.jsp">JSP 게시판 웹사이트</a>
        </div>
        
        <!-- 네브바 본문 -->
        <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
            <ul class="nav navbar-nav">
                <li><a href="main.jsp">메인</a></li>
                <li class="active"><a href="bbs.jsp">게시판</a></li>
            </ul>
            
<%
    if(userID == null){ /* 로그인이 안된사람이 보는 화면 */
%>       
            <!-- 네브바 오른쪽 -->
            <ul class="nav navbar-nav navbar-right">
                <li class="dropdown">
                    <!-- 접속하기버튼. 드랍다운 -->
                    <a href="#" class="dropdown-toggle"
                        data-toggle="dropdown" role="button" aria-haspopup="true"
                        aria-expanded="false">접속하기<span class="caret"></span></a>
                    <!-- 드랍다운 눌렀을때 리스트-->
                    <ul class="dropdown-menu">
                        <li><a href="login.jsp">로그인</a></li>
                        <li><a href="join.jsp">회원가입</a></li>
                    </ul>
                </li>
            </ul>                    
                    
<%       
    }else{  /* 로그인이 된사람이 보는 화면 */
%>
            <!-- 네브바 오른쪽 -->
            <ul class="nav navbar-nav navbar-right">
                <li class="dropdown">
                    <!-- 접속하기버튼. 드랍다운 -->
                    <a href="#" class="dropdown-toggle"
                        data-toggle="dropdown" role="button" aria-haspopup="true"
                        aria-expanded="false">회원관리<span class="caret"></span></a>
                    <!-- 드랍다운 눌렀을때 리스트-->
                    <ul class="dropdown-menu">
                        <li><a href="logoutAction.jsp">로그아웃</a></li>
                    </ul>
                </li>
            </ul>  
            
<%
     }
%>

        </div>
    </nav>


    <!-- 게시판 본문 -->
    <div class="container">
    	<div class="row">
    	   <table class="table table-striped" style="text-align:center; border:1px solid #dddddd">
    	       <thead>
	    	       <tr>
	    	       		<th style="backgroud-color: #eeeeee; text-align:center;">번호</th>
	    	       		<th style="backgroud-color: #eeeeee; text-align:center;">제목</th>
	    	       		<th style="backgroud-color: #eeeeee; text-align:center;">작성자</th>
	    	       		<th style="backgroud-color: #eeeeee; text-align:center;">작성일</th>
	    	       </tr>
    	       </thead>
    	       <tbody>
    	       <!-- 글 리스트 동적 처리 -->
<%
   BbsDAO bbsDAO = new BbsDAO();
   ArrayList<Bbs> list = bbsDAO.getList(pageNumber);
   for(int i=0; i<list.size(); i++){
%>
                   <tr>
                       <td><%= list.get(i).getBbsID() %></td>
                       <td><a href="view.jsp?bbsID=<%=list.get(i).getBbsID() %>"><%= list.get(i).getBbsTitle().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>") %></a></td><!-- 특수문자나 공백, 줄띄움 처리 --> 
                       
                       <td><%= list.get(i).getUserID() %></td>
                       <td><%= list.get(i).getBbsDate().substring(0,11) + " " + list.get(i).getBbsDate().substring(11,13)+"시 " + list.get(i).getBbsDate().substring(14,16) + "분"%></td>
                       
                   </tr>  

<%
   }
%>
    	       </tbody>
   	       </table>
   	       
   	       <!-- 페이징처리 -->
   	       <%
   	            if(pageNumber != 1){
   	       %>      
   	            <a href="bbs.jsp?pageNumber=<%=pageNumber-1%>" class="btn btn-success btn-arrow-left">이전</a>
   	       <%   
   	            } if(bbsDAO.nextPage(pageNumber + 1)){
   	       %>
       	       <a href="bbs.jsp?pageNumber=<%=pageNumber+1%>" class="btn btn-success btn-arrow-left">다음</a>
           <%   
				}
           %>
   	       
   	       
   	       <!-- 테이블밑의 버튼들 -->
   	       <a href="write.jsp" class="btn btn-primary pull-right">글쓰기</a>
    	</div>
    </div>
    

    <script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
    <script src="js/bootstrap.js"></script>
</body>
</html>