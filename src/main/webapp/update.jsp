<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.io.PrintWriter" %>
<%@ page import = "bbs.BbsDAO" %>
<%@ page import = "bbs.Bbs" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width", initial-scale="1" >
    <%@ include file="/commonInclude.jsp" %>
    <title>글수정</title>
</head>
<body>
<%
	String userID = null;
	if (session.getAttribute("userID")!=null){  //세션의 userID속성이 null이 아니면
	    userID = (String) session.getAttribute("userID");
	}
	if(userID ==null){
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('로그인을 하세요.')");  
        script.println("location.href = 'login.jsp'");  
        script.println("</script>");
	}
	int bbsID = 0;
	if(request.getParameter("bbsID")!=null){
	    bbsID = Integer.parseInt(request.getParameter("bbsID"));
	}
    if(bbsID == 0){
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('유효하지 않은 글입니다.')");  
        script.println("location.href = 'bbs.jsp'");  
        script.println("</script>");
    }
    Bbs bbs = new BbsDAO().getBbs(bbsID);
    if(!userID.equals(bbs.getUserID())){
       PrintWriter script = response.getWriter();
       script.println("<script>");
       script.println("alert('권한이 없습니다.')");  
       script.println("location.href = 'bbs.jsp'");  
       script.println("</script>");
    }
%>


    <jsp:include page="nav.jsp"/>


    <!-- 게시판 글쓰기 화면 -->
    <div class="container">
        <div class="row">
		    <form method="post" action="updateAction.jsp?bbsID=<%= bbsID %>" >
	    	   <table class="table table-striped" style="text-align:center; border:1px solid #dddddd">
	    	       <thead>
		    	       <tr>
		    	       		<th colspan="2" style="backgroud-color: #eeeeee; text-align:center;">게시판 글수정 양식</th>
		    	       </tr>
	    	       </thead>
	    	       <tbody>
	    	           <tr>
	    	               <td><input type="text" class="form-control" placeholder="글 제목" name="bbsTitle" maxlength="50" value="<%= bbs.getBbsTitle()%>"/></td>
	    	           </tr>
	    	           <tr>
	    	               <td><textarea class="form-control" placeholder="글 내용" name="bbsContent" maxlength="50" style="height:350px;"><%= bbs.getBbsContent()%></textarea></td>
	    	           </tr>
	    	       </tbody>
	   	       </table>
	   	       <input type="submit" class="btn btn-primary pull-right" value="글수정">
		   	</form>
	   	</div>
    </div>


    <script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
    <script src="js/bootstrap.js"></script>
</body>
</html>