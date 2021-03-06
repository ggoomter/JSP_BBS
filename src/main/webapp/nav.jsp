<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="session.jsp" %>   <!-- 세션 -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>


    <nav class="navbar navbar-default">
        <!-- 네브바 헤드 -->
        <div class="navbar-header">
            <button type="button" class="navbar-toggle collapsed" data-toggle="collapse"
            data-target = "#bs-example-navbar-collapse-1" aria-expanded="false">
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <a class="navbar-brand" href="main.jsp">JSP 게시판 웹사이트</a>
        </div>
        
        <!-- 네브바 본문 -->
        <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
            <ul class="nav navbar-nav" id="naviCategory">
                <li><a href="main.jsp">메인</a></li>  <!-- 현재 메인페이지이기때문에 메인을 엑티브로 -->
                <li><a href="bbs.jsp">게시판</a></li>
            </ul>
            

            <!-- 네브바 오른쪽 -->
            <ul class="nav navbar-nav navbar-right">
                <li class="dropdown">
                    <!-- 접속하기버튼. 드랍다운 -->
                    <a href="#" class="dropdown-toggle"
                        data-toggle="dropdown" role="button" aria-haspopup="true"
                        aria-expanded="false">접속하기<span class="caret"></span></a>
                    <!-- 드랍다운 눌렀을때 리스트-->
                    <ul class="dropdown-menu">
                    <c:if test="${userID == null}"> <!-- 로그인안된사람이 보는 메뉴 -->
                        <li><a href="login.jsp">로그인</a></li>
                        <li><a href="join.jsp">회원가입</a></li>
                    </c:if>
                    <c:if test="${userID != null}">
                        <li><a href="logoutAction.jsp">로그아웃</a></li>
                    </c:if>
                    </ul>
                </li>
            </ul>                    
        </div>
    </nav>