<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width", initial-scale="1" >
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
    <script src="js/bootstrap.js"></script>
	<%@ include file="/commonInclude.jsp" %>
<title>회원가입</title>
</head>
<body>
    <jsp:include page="nav.jsp"/>
    
    <!-- 회원가입 양식 -->
    <div class="container">
        <div class="col-lg-4"></div>
        <div class="col-lg-4">
            <div class="jumbotron" style="paddint-top:20px;">
                <form method="post" action="joinAction.jsp" >
                    <h3 style="text-align:center;">회원가입 화면</h3>
                    <div class="form-group">
                        <input type="text" id= "userInputID" class="form-control" placeholder="아이디" name="userID" maxlength="20"/>
                        <label class="form-group" id="resultCheckID"></label>
                    </div>
                    
                    <div class="form-group">
                        <input type="password" class="form-control" placeholder="비밀번호" name="userPassword" maxlength="20"/>
                    </div>
                    <div class="form-group">    <!-- 이름 -->
                        <input type="text" class="form-control" placeholder="이름" name="userName" maxlength="20"/>
                    </div>
                    <div class="form-group" style="text-align:center;"> <!-- 성별 -->
                        <div class="btn-group" data-toggle="buttons">
                            <label class="btn btn-primary active">
                                <input type="radio" name="userGender" autocomplete="off" value = "남자" checked>남자
                            </label>
                            <label class="btn btn-primary active">
                                <input type="radio" name="userGender" autocomplete="off" value = "여자" >여자
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <input type="email" class="form-control" placeholder="이메일" name="userEmail" maxlength="20"/>
                    </div>
                    <input type="submit" class="btn btn-primary form-control" value="회원가입" />
                
                </form>
                
            </div>
        </div>
        <div class="col-lg-4"></div>
    
    </div>

	

	   <script>       
 		$("#userInputID").blur(function(){
            $.ajax({
              type : 'post',
              url : 'idCheckServlet',
              data : {
                  userID : $("#userInputID").val()
              },
              success : function(result){   //성공이면 result라는 변수로 값을 받아옴
                  if(result == 'noDup'){
                      $("#resultCheckID").html("사용가능");
                      $("#resultCheckID").attr('class', 'modal-content panel-success');
                  }
                  else if(result == 'dup'){
                      $("#resultCheckID").html("사용 불가능한 아이디입니다.");
                      $("#resultCheckID").attr('class', 'modal-content panel-warning');
                  }
              }
            })
        })
    </script>
</body>
</html>