<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div class="row text-center" style="width: 100%">
    <nav aria-label="Page navigation example">
        <ul class="pagination">
            <li class="page-item">
                <a class="page-link" href="javascript:goPage(${param.firstPageNo})" aria-label="Previous">
                    <span aria-hidden="true">&laquo;</span>
                    <span class="sr-only">Previous</span>
                </a>
            </li>
            <li class="page-item">
                <a href="javascript:goPage(${param.prevPageNo})" class="prev">이전 </a> 
            </li>
            <li class="page-item">
            <c:forEach var="i" begin="${param.startPageNo}" end="${param.endPageNo}" step="1">
                <c:choose>
                    <c:when test="${i eq param.pageNo}">
                        <a class="page-link choice" href="javascript:goPage(${i})"> ${i} </a>
                    </c:when>
                    <c:otherwise>
                        <a class="page-link" href="javascript:goPage(${i})"> ${i} </a>
                    </c:otherwise>
                </c:choose>
            </c:forEach>
            </li>
            <li class="page-item">
                <a href="javascript:goPage(${param.nextPageNo})" class="next"> 다음 </a>
            </li>
            <li class="page-item">
                <a class="page-link" href="javascript:goPage(${param.finalPageNo})" aria-label="Next">
                    <span aria-hidden="true">&raquo;</span>
                    <span class="sr-only">Next</span>
                </a>
            </li>
        </ul>
    </nav>
</div>