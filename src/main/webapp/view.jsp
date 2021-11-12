<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.io.PrintWriter" %>
<%@ page import = "bbs.Bbs" %>
<%@ page import = "bbs.BbsDAO" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width", initial-scale="1" >
    <link rel="stylesheet" href="css/bootstrap.css" />
    <link rel="stylesheet" href="css/custom.css" />
    <title>글 자세히 보기</title>
</head>
<body>
<%
	String userID = null;
	if (session.getAttribute("userID")!=null){  //세션의 userID속성이 null이 아니면
	    userID = (String) session.getAttribute("userID");
	}
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

    <!-- 게시판 글쓰기 화면 -->
    <div class="container">
        <div class="row">
    	   <table class="table table-striped" style="text-align:center; border:1px solid #dddddd">
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
   	       
   	       <a href="bbs.jsp" class="btn btn-primary">목록</a>
   	       <!-- 작성자가 본인이라면 수정과 삭제가 가능하도록 -->
   	       <%
   	           if(userID != null && userID.equals(bbs.getUserID())){
   	        %>
   	               <a href="update.jsp?bbsID=<%= bbsID %>" class="btn btn-primary">수정</a>
   	               <a onclick="return confirm('정말로 삭제하시겠습니까?')" href="deleteAction.jsp?bbsID=<%= bbsID %>" class="btn btn-primary">삭제</a>
   	        <%
   	        }
   	        %>
   	       <input type="submit" class="btn btn-primary pull-right" value="글쓰기">
	   	</div>
    </div>


    <script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
    <script src="js/bootstrap.js"></script>
</body>
</html>