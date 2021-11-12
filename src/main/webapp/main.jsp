<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.io.PrintWriter" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width", initial-scale="1" >
    <link rel="stylesheet" href="css/bootstrap.css" />
    <link rel="stylesheet" href="css/custom.css" />
    <link rel="favicon"  type="image/x-icon" href="images/favicon.ico">
    <title>메인</title>
</head>
<body>

    <jsp:include page="nav.jsp"/>
   
    <!-- 본문 -->
    <div class="container">
    	<div class="jumbotron">
    		<div class="container"></div>
    		  <h1>웹사이트 소개</h1>
    		  <p>이 웹사이트는 부트스트랩으로 만든 JSP 웹사이트입니다. 최소한의 간단한 로직만을 이용해서 개발했습니다.
    		  디자인 템플릿으로는 부트스트랩을 사용했습니다.</p>
    		  <p><a class="btn btn-primary btn-pull" href="#" role="button">자세히 알아보기</a></p>
    	</div>
    </div>
    
    <!-- 사진 -->
    <div class="container">
    	<div id="myCarousel" class="carousel slide" data-ride="carousel">
    	   <ol class="carousel-indicators">
    	       <li data-target="#myCarousel" data-slide-to="0" class="active"></li>
    	       <li data-target="#myCarousel" data-slide-to="1"></li>
    	       <li data-target="#myCarousel" data-slide-to="2"></li>
    	   </ol>
    	   <div class="carousel-inner">
    	       <div class="item active">
    	           <img src="images/photo1.jpg" alt="" />
    	       </div>
               <div class="item">
                   <img src="images/photo2.jpg" alt="" />
               </div>
               <div class="item">
                   <img src="images/photo3.jpg" alt="" />
               </div>
    	   </div>
    	
    	   <a class="left carousel-control" href="#myCarousel" data-slide="prev">
    	       <span class="glyphicon glyphicon-chevron-left"></span>
    	   </a>
           <a class="right carousel-control" href="#myCarousel" data-slide="prev">
               <span class="glyphicon glyphicon-chevron-right"></span>
           </a>
    	</div>
    </div>



    <script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
    <script src="js/bootstrap.js"></script>
</body>
</html>