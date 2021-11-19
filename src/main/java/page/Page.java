package page;

public class Page {
    /* 한페이지와 관련된 변수 */
    private int pageSize = 10; //한 페이지에 출력할 글의 수
    private int pageBlock = 10; //한 화면에 보여줄 페이지의 수
    private int pageNum; //현재페이지번호
    private int currentPage = 1; //현재페이지
    private int totalCount; //글전체수

    private int firstPageNo=1; //모든페이지중에 첫번째 페이지번호
    private int finalPageNo;   //모든페이지중에 마지막 페이지번호

    private int prevPageNo; //이전페이지번호
    private int nextPageNo; //다음페이지번호

    private int startPageNo; //현재 페이지번호 리스트에서 보여줄 시작번호
    private int endPageNo; //현재 페이지번호 리스트에서 보여줄 끝번호

    public int getPageSize() {
        return pageSize;
    }

    public void setPageSize(int pageSize) {
        this.pageSize = pageSize;
    }

    public int getPageBlock() {
        return pageBlock;
    }

    public void setPageBlock(int pageBlock) {
        this.pageBlock = pageBlock;
    }

    public int getPageNum() {
        return pageNum;
    }

    public void setPageNum(int pageNum) {
        this.pageNum = pageNum;
    }

    public int getCurrentPage() {
        return currentPage;
    }

    public void setCurrentPage(int currentPage) {
        this.currentPage = currentPage;
    }

    public int getTotalCount() {
        return totalCount;
    }

    public void setTotalCount(int totalCount) {
        this.totalCount = totalCount;
    }

    public int getFirstPageNo() {
        return firstPageNo;
    }

    public void setFirstPageNo(int firstPageNo) {
        this.firstPageNo = firstPageNo;
    }

    public int getFinalPageNo() {
        return finalPageNo;
    }

    public void setFinalPageNo(int finalPageNo) {
        this.finalPageNo = finalPageNo;
    }

    public int getPrevPageNo() {
        return prevPageNo;
    }

    public void setPrevPageNo(int prevPageNo) {
        this.prevPageNo = prevPageNo;
    }

    public int getNextPageNo() {
        return nextPageNo;
    }

    public void setNextPageNo(int nextPageNo) {
        this.nextPageNo = nextPageNo;
    }

    public int getStartPageNo() {
        return startPageNo;
    }

    public void setStartPageNo(int startPageNo) {
        this.startPageNo = startPageNo;
    }

    public int getEndPageNo() {
        return endPageNo;
    }

    public void setEndPageNo(int endPageNo) {
        this.endPageNo = endPageNo;
    }

    
    /**
     * 페이징 생성
     */
    public void makePaging() {
        if (this.totalCount == 0) return; // 게시 글 전체 수가 없는 경우
        if (this.pageNum == 0) this.setPageNum(1); // 기본 값 설정
        if (this.pageSize == 0) this.setPageSize(10); // 기본 값 설정

        int finalPage = (totalCount + (pageSize - 1)) / pageSize; // 마지막 페이지
        
        // 현재페이지가 마지막페이지보다 넘게 입력되면 마지막 페이지로 기본 값 설정
        if (this.currentPage > finalPage) {
            this.setCurrentPage(finalPage); 
        }

        // 현재 페이지 유효성 체크
        if (this.currentPage < 0 || this.currentPage > finalPage) {
            this.currentPage = 1; 
        }

        boolean isNowFirst = currentPage == 1 ? true : false; // 시작 페이지 (전체)
        boolean isNowFinal = currentPage == finalPage ? true : false; // 마지막 페이지 (전체)

        int startPage = ((currentPage - 1) / 10) * 10 + 1; // 시작 페이지 (페이징 네비 기준)
        int endPage = startPage + 10 - 1; // 끝 페이지 (페이징 네비 기준)

        if (endPage > finalPage) { // [마지막 페이지 (페이징 네비 기준) > 마지막 페이지] 보다 큰 경우
            endPage = finalPage;
        }

        if (isNowFirst) {   //현재가 첫번째 페이지라면
            this.setPrevPageNo(1);  // 이전 페이지 번호를 1로
        } else {            //현재가 첫번째 페이지가 아니라면
            this.setPrevPageNo((currentPage - 1) < 1 ? 1 : (currentPage - 1)); // 이전 페이지 번호
        }

        this.setStartPageNo(startPage); // 시작 페이지 (페이징 네비 기준)
        this.setEndPageNo(endPage); // 끝 페이지 (페이징 네비 기준)

        if (isNowFinal) {
            this.setNextPageNo(finalPage); // 다음 페이지 번호
        } else {
            this.setNextPageNo(((pageNum + 1) > finalPage ? finalPage : (pageNum + 1))); // 다음 페이지 번호
        }

        this.setFinalPageNo(finalPage); // 마지막 페이지 번호
    }

}
