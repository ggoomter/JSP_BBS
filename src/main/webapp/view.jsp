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
1. 댓글 오른쪽에 글쓰기, 글삭제 버튼 만들기 : 11/15
2. 버튼 눌렀을때 기능 연결(새로고침없이 ajax로 구현)
3. 이미지 추가, 삭제
4. 추가된 이미지 미리보기
5. 조회수
6. 댓글을 처음부터 지정된 갯수만 가져오는것이 아니라 더보기 누르면 ajax로 조금씩 더가져오기
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
	Bbs bbs = new BbsDAO().getBbs(bbsID);  //해당 글데이터 받아오기

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
    <br><br>
    <!-- 댓글 작성 -->
	<div class="container">
	    <div class="row">
	        <form method="post" action="commentAction.jsp">
	            <!-- 댓글번호commentID는 dao에서 증가시킬거고, 글내용은 아래, 글작성자는 세션에서 -->
	            <input type="hidden" name = "actionType" value="insert">
	            <input type="hidden" name = "bbsID" value="<%=bbs.getBbsID() %>">
	            <table class="table table-striped" style="text-align: center; border: 2px solid #dddddd; height: 70px;">
	                <tr>
	                    <td class="col-md-1 align-middle"><%= userID %></td>
	                    <td class="col-md-8"><textarea id = "commentText" style="height:50px;" class="form-control" placeholder="댓글을 입력해주세요." name="commentText"></textarea></td>
	                    <!-- 제출버튼 -->
	                    <td class="col-md-3 align-middle">
	                       <input type="button" id="commentTextResetButton" class="btn btn-dark" value="초기화" onclick = "resetCommentText();"/></input>
	                       <input type="submit" id="commentTextActionButton" class="btn btn-info"></input>
	                    </td>
	                </tr>
	            </table>
	        </form>
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
           
               <!-- 댓글 리스트 데이터 -->
				<%
				   CommentDAO commentDAO = new CommentDAO();
				   ArrayList<Comment> list = commentDAO.getList(bbs.getBbsID(),10);
				   for(int i=0; i<list.size(); i++){
				%>
                <!-- 작성자, 댓글내용, 댓글작성날짜, 수정버튼 ,삭제버튼 -->
                   <tr>
                       <td class="col-md-2"><%= list.get(i).getUserID() %></td><!-- 작성자 -->
                       <td class="col-md-7"><%= list.get(i).getCommentText() %></td><!-- 댓글내용 -->
                       <td class="col-md-2"><%= list.get(i).getCommentDate() %></td><!-- 댓글작성날짜 -->
                       
                       <%
                       //세션이 종료되었을때 화면이 터짐
                       if(userID.equals(list.get(i).getUserID())) { //댓글 작성자와 로그인유저가 같으면 수정,삭제 버튼 표시
                       %>
                       <td class="col-md-1 ">
                            <img class="modifyBtn" src="images/yellow_modify.png" alt="" onclick="updateComment(<%= list.get(i).getBbsID()%>, <%= list.get(i).getCommentID()%>);"/>
                            <img class="minusBtn" src="images/red_minus.png" alt="" onclick="deleteComment(<%= list.get(i).getBbsID()%>, <%= list.get(i).getCommentID()%>);"/>
                       </td>
                       
                       <%
                       }else{   //댓글작성자와 로그인유저가 다르다면 표시안함
                       %>
                       <td class="col-md-1 "></td>
                           
                       <%    
                       }
                       %>                       
                       

                   </tr>  

				<%
				   }   //end of for list
				%>
               </tbody>
           </table>
       </div>
   </div>
    
    
    <script>
    let writer = null;
    let contentText = null;
    let writedDate = null;
    let boardID = null;
    let commentID = null;
    
    function updateComment(boardID, commentID){
    	//이건 댓글 입력칸의 내용 가져온것
    	//let commentText = document.getElementById("commentText").value;
    	
    	//기능구현 순서 
    	//1. 수정버튼을 누르기전에는 기존댓글 수정불가상태 (고칠필요없음 현상태 그대로)
    	//2. 수정버튼을 클릭하면 색깔변경, 포커스 이동
    	   // 바꿀수있는건 댓글 내용뿐이기 때문에 댓글추가창에 박아주자. 제출 내용을 노란색으로 수정으로 바꾸고.
    	//3. 화면변경없이 유저의 입력값 서버로 넘기기
    	   // 
    	//4. 변경된 댓글내용으로 다시 화면 조회
    	//자바스크립트단의 변수를 jsp(백단)으로 넘기는 가장 쉬운 방법은 input hidden
    	
    	//클릭한 행의 3개 컬럼 정보 변수에 저장
        $("#commentTable tbody").on("click", "tr", function(){

            writer = $(this).find("td:eq(0)").text();
            contentText = $(this).find("td:eq(1)").text();
            writedDate = $(this).find("td:eq(2)").text();
            
            console.log(contentText);
            $("#commentText").val(contentText);
            $("#commentTextActionButton").attr('class','btn btn-warning');
        });


        
    	<%-- db로 변경사항 적용시키는 작업해야함. Action으로 역할을 미루자.  	--%>
    }
    
    function deleteComment(boardID, commentID){
    	console.log("삭제. boardID : "+boardID);
    	console.log("삭제. commentID : "+commentID);
    	$.ajax(
	    	{ type: "GET",
	    	  url: "commentAction.jsp",
	    	  data: {
	    		  type : "delete",
	    		  boardID : boardID,
	    		  commentID : commentID
	    	  },
	    	  success: function(data) {
	    	        alert("success!");
	    	  },
	    	  error: function(error) {
	    	        alert("Error!");
	    	  },

	    	  dataType: 'json'
	    	}
    	);
    }
    
    
    function resetCommentText(){
    	$("#commentText").val("");//reset은 왜안되나 모르겠고 이걸로 해결
    	
    }
    	


    
    </script>    

    <script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
    <script src="js/bootstrap.js"></script>
</body>
</html>