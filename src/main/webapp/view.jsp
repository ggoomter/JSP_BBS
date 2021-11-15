<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.io.PrintWriter" %>
<%@ page import = "bbs.Bbs" %>
<%@ page import = "bbs.BbsDAO" %>
<%@ page import = "comment.Comment" %>
<%@ page import = "comment.CommentDAO" %>
<%@ page import = "java.util.ArrayList" %>


<!-- 
해야될 내용
1. 댓글 오른쪽에 글쓰기, 글삭제 버튼 만들기
2. 버튼 눌렀을때 기능 연결(새로고침없이 ajax로 구현)
3. 이미지 추가, 삭제
4. 추가된 이미지 미리보기
5. 조회수
-->


<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width", initial-scale="1" >
    <%@ include file="/commonInclude.jsp" %>
    <title>글 자세히 보기</title>
</head>
<body>
<%@ include file="session.jsp" %><!-- 정적포함 -->
<%
	int bbsID = 0;
	if(request.getParameter("bbsID")!=null){   //request에 bbsID가 없다면
	    bbsID = Integer.parseInt(request.getParameter("bbsID"));   //다시 받아오도록
	}
	if(bbsID == 0){    //그래도 못받아왔으면 경고주고 글목록으로 이동
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('유효하지 않은 글입니다.')");  
        script.println("location.href = 'bbs.jsp'");  
        script.println("</script>");
	}
	Bbs bbs = new BbsDAO().getBbs(bbsID);

%>


    <jsp:include page="nav.jsp"/>

    <!-- 게시판 상세보기 화면 -->
    <div class="container">
        <div class="row">
    	   <table class="table table-striped  " style="text-align:center";>
    	       <thead>
	    	       <tr>
	    	       		<th colspan="3" style="backgroud-color: #eeeeee; text-align:center;">글 자세히보기</th>
	    	       </tr>
    	       </thead>
    	       <tbody>
    	           <tr>
    	               <td style="width:20%">글 제목</td>
    	               <td colspan="2"><%=bbs.getBbsTitle().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>") %></td>
    	               <!-- 특수문자나 공백, 줄띄움 처리 --> 
    	           </tr>
    	           <tr>
                       <td>작성자</td>
                       <td colspan="2"><%= bbs.getUserID() %></td>
                   </tr>
                   <tr>
                       <td>작성일자</td>
                       <td colspan="2"><%= bbs.getBbsDate().substring(0,11) + " " + bbs.getBbsDate().substring(11,13)+"시 " + bbs.getBbsDate().substring(14,16) + "분"%></td>
                   </tr>
                   <tr>
                       <td>내용</td>
                       <td colspan="2" style="min-height:200px; text-align:left;"><%=bbs.getBbsContent().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>") %></td>
                       <!-- 특수문자나 공백, 줄띄움 처리 --> 
                   </tr>

    	       </tbody>
   	       </table>
   	       <div class="text-center">
   	            <a href="bbs.jsp" class="btn btn-primary pull-width">목록</a>
   	       </div>
   	       <!-- 작성자가 본인이라면 수정과 삭제가 가능하도록 -->
   	       <%
   	           if(userID != null && userID.equals(bbs.getUserID())){
   	        %>

                   <div class="row-fluid">
                        <a onclick="return confirm('정말로 삭제하시겠습니까?')" href="deleteAction.jsp?bbsID=<%= bbsID %>" class="btn btn-danger pull-right">삭제</a>
                   </div>
   	               <div class="row-fluid">
   	                    <a href="update.jsp?bbsID=<%= bbsID %>" class="btn btn-success pull-right">수정</a>
   	               </div>


   	        <%
   	        }
   	        %>
	   	</div>
    </div>


    <!-- 댓글 리스트 -->
    <div class="container">
        <div class="row">
           <table id="commentTable" class="table table-striped" style="text-align:center; border:1px solid #dddddd">
               <thead>
                   <tr>
                        <th style="backgroud-color: #eeeeee; text-align:center;">작성자</th>
                        <th style="backgroud-color: #eeeeee; text-align:center;">내용</th>
                        <th style="backgroud-color: #eeeeee; text-align:center;">작성일</th>
                   </tr>
               </thead>
               <tbody>
               <!-- 글 리스트 동적 처리 -->
<%
   CommentDAO commentDAO = new CommentDAO();
   ArrayList<Comment> list = commentDAO.getList(bbs.getBbsID(),10);
   for(int i=0; i<list.size(); i++){
%>
                <!-- 작성자, 댓글내용, 댓글작성날짜, 수정,삭제버튼 -->
                   <tr>
                       <td class="col-md-2"><%= list.get(i).getUserID() %></td><!-- 작성자 -->
                       <td class="col-md-7"><%= list.get(i).getCommentText() %></td><!-- 댓글내용 -->
                       <td class="col-md-2"><%= list.get(i).getCommentDate() %></td><!-- 댓글작성날짜 -->
                       <td class="col-md-1 ">
                            <img class="plusBtn" src="images/green_plus.png" alt="" />
                            <img class="minusBtn" src="images/red_minus.png" alt="" />
                       </td>
                   </tr>  

<%
   }
%>
               </tbody>
           </table>
       </div>
   </div>
    

    <script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
    <script src="js/bootstrap.js"></script>
</body>
</html>