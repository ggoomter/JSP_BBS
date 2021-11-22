<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.io.PrintWriter" %>
<%@ page import = "bbs.BbsDAO" %>
<%@ page import = "bbs.Bbs" %>
<%@ page import = "page.Paging" %>
<%@ page import = "java.util.ArrayList" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ include file="commonInclude.jsp" %>

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
<%!
Paging paging = null;
int pageNo = 1;
int currentPage = 1;
%>

<%
	/* 진짜 페이징처리 */
	paging = new Paging();
    pageNo = request.getParameter("pageNo")==null? 1 : Integer.parseInt(request.getParameter("pageNo"));
    currentPage = request.getParameter("currentPage")==null? pageNo : Integer.parseInt((request.getParameter("currentPage")));
    out.println(pageNo);    //임시 출력
    paging.setPageNo( pageNo); //url로 넘겨받은 페이지 번호
    paging.setCurrentPage(currentPage); //url로 넘겨받은 페이지 번호
    paging.setPageSize(10);
    paging.setTotalCount(paging.getBbsTotalCount());
    pageContext.setAttribute("paging", paging); //다른 jsp로 전달하기 위해서 자바변수에 있던것을 jsp변수에 옮겨담음
    
	/* 글 목록 */
	BbsDAO bbsDAO = new BbsDAO();
	ArrayList<Bbs> list = bbsDAO.getList(paging.getCurrentPage());
	pageContext.setAttribute("list", list);
%>

    <jsp:include page="nav.jsp"/>
    <script>
    console.log('bbs.jsp입니다.');
    console.log(${paging.pageNo});
    </script>

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
                       <td class="col-md-5"><a href="view.jsp?bbsID=${board.bbsID}&pageNo=${paging.pageNo}"> <c:out value ="${board.bbsTitle}" escapeXml="true"></c:out></a></td><!-- 특수문자나 공백, 줄띄움 처리 -->
                       <!-- &pageNo=${pageNo}" 라고 하면 왜 안될까--> 
                       <td class="col-md-2">${board.userID}</td>
                       
                       <!-- db에는 datetime이지만 자바객체에선 String 이기때문에 먼저 parseDate를 통해 date형태로 값을 파싱후에 formatDate사용 -->
                       <fmt:parseDate value="${board.bbsDate}" var="parseDateValue" pattern ="yyyy-MM-dd HH:ss"></fmt:parseDate>
                       <td class="col-md-2"><fmt:formatDate value="${parseDateValue}" pattern="yyyy.MM.dd  HH:ss"/></td>
                       <td class="col-md-1">${board.viewCount}</td>
                   </tr>  
               </c:forEach>
    	       </tbody>
   	       </table>


            <!-- 진짜 페이징처리 -->
            <!-- paging.jsp를 호출하면서 파라미터로 아래의 것들을 넘겨준다. -->
			<jsp:include page="paging.jsp" flush="true">
			    <jsp:param name="firstPageNo" value="${paging.firstPageNo}" />
			    <jsp:param name="prevPageNo" value="${paging.prevPageNo}" />
			    <jsp:param name="startPageNo" value="${paging.startPageNo}" />
			    <jsp:param name="pageNo" value="${paging.pageNo}" />
			    <jsp:param name="endPageNo" value="${paging.endPageNo}" />
			    <jsp:param name="nextPageNo" value="${paging.nextPageNo}" />
			    <jsp:param name="finalPageNo" value="${paging.finalPageNo}" />
			</jsp:include>

   	       <!-- 테이블밑의 버튼들 -->
   	       <a href="write.jsp" class="btn btn-primary pull-right">글쓰기</a>
    	</div>
    </div>
    

    <script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
    <script src="js/bootstrap.js"></script>
    
    
    <script>
    function goPage(pageNo){
        location.href="bbs.jsp?pageNo="+pageNo;
    }
    
    </script>
</body>
</html>