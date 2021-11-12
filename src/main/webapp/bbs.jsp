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

    <jsp:include page="nav.jsp"/>

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