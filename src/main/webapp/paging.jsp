<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
    <script>
    console.log('paging.jsp입니다.');
    console.log(${param.pageNo});
    /* console.log(${param});       endPageNo=4, finalPageNo=4, pageNo=3, startPageNo=1, prevPageNo=2, nextPageNo=4, firstPageNo=1 */
    /* console.log(${paging});      비어있음 */
    </script>
    
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
            
            <!-- 계산되어나온 시작번호부터 끝번호까지 1씩 반복증가하면서 리스트 출력 -->
            <c:forEach var="i" begin="${param.startPageNo}" end="${param.endPageNo}" step="1">
                <c:choose>
                    <c:when test="${i eq param.pageNo}"> <!-- 클릭했던 번호와 같다면 -->
                    <li class="page-item">
                        <a class="page-link choice" href="javascript:goPage(${i})"> ${i} </a>
                    </li>
                    </c:when>
                    <c:otherwise>
                    <li class="page-item">
                        <a class="page-link" href="javascript:goPage(${i})"> ${i} </a>
                    </li>
                    </c:otherwise>
                </c:choose>
            </c:forEach>
            
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