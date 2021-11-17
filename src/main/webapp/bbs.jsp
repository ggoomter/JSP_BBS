<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.io.PrintWriter" %>
<%@ page import = "bbs.BbsDAO" %>
<%@ page import = "bbs.Bbs" %>
<%@ page import = "java.util.ArrayList" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>


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
	/* 페이지처리 */
	int pageNumber = 1;    
	if(request.getParameter("pageNumber")!=null){
	    pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
	}
	
	/* 글 목록 */
	BbsDAO bbsDAO = new BbsDAO();
	ArrayList<Bbs> list = bbsDAO.getList(pageNumber);
	pageContext.setAttribute("list", list);
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
	    	       		<th style="backgroud-color: #eeeeee; text-align:center;">조회수</th>
	    	       </tr>
    	       </thead>
    	       <tbody>
    	       <!-- 글 리스트 동적 처리 -->
               <c:forEach var="board" items="${list}" varStatus="status">
					<tr>
                       <td class="col-md-1">${board.bbsID}</td>
                       <td class="col-md-5"><a href="view.jsp?bbsID=${board.bbsID}"> <c:out value ="${board.bbsTitle}" escapeXml="true"></c:out></a></td><!-- 특수문자나 공백, 줄띄움 처리 --> 
                       <td class="col-md-2">${board.userID}</td>
                       
                       <!-- db에는 datetime이지만 자바객체에선 String 이기때문에 먼저 parseDate를 통해 date형태로 값을 파싱후에 formatDate사용 -->
                       <fmt:parseDate value="${board.bbsDate}" var="parseDateValue" pattern ="yyyy-MM-dd HH:ss"></fmt:parseDate>
                       <td class="col-md-2"><fmt:formatDate value="${parseDateValue}" pattern="yyyy.MM.dd  HH:ss"/></td>
                       <td class="col-md-1">${board.viewCount}</td>
                   </tr>  
               </c:forEach>
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