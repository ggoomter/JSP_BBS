<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<!-- js 소스. 브라우저가 해석 -->
<script type="text/javascript">
    alert("hi");
    let a = 10;
    document.write("a : ", a);
</script>


<!--  java소스. was가 해석 -->
<%
    int b = 10;
    out.println("b : "+b);
%>

<br>

<%
    String name = "홍길동";
    out.println(name + "의 홈페이지입니다.");
%>

<h1>h1제목</h1>
<h3>h3제목</h3>
<h6>h6제목</h6>
<%
    for(int i=1; i<7; i++){
        out.print("<h" + i + ">");
        out.print("제목 태그 (자바로작성)");
        out.println("</h" + i + ">");
    }
%>




</body>
</html>