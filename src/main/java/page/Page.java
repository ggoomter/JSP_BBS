package page;

public class Page {
	/* 한페이지와 관련된 변수 */
	private int pageSize = 10;	//한 페이지에 출력할 글의 수
	private int pageNum;		//클릭한 페이지링크번호 / 현재페이지		즉 현재3페이지인데 5페이지 클릭하면 5/3 오른쪽을 클릭했으면 1, 왼쪽을 클릭했으면 0이 나옴.
	private int currentPage; 	//현재페이지
	private int startRow;		//해당페이지의 시작 글번호
	private int endRow;			//해당페이지의 시작 글번호
	private int count;			//db에 저장된 총 글수
	
	/* 페이지간의 변수 */
	private int pageCount;		//총 페이지 수
	private int pageBlock=10;	//한 화면에 보여줄 페이지의 수
	private int startPage;		//한화면의 시작 페이지번호
	private int endPage;		//한화면의 마지막 페이지번호
	public int getPageSize() {
		return pageSize;
	}
	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
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
	public int getStartRow() {
		return startRow;
	}
	public void setStartRow(int startRow) {
		this.startRow = startRow;
	}
	public int getEndRow() {
		return endRow;
	}
	public void setEndRow(int endRow) {
		this.endRow = endRow;
	}
	public int getCount() {
		return count;
	}
	public void setCount(int count) {
		this.count = count;
	}
	public int getPageCount() {
		return pageCount;
	}
	public void setPageCount(int pageCount) {
		this.pageCount = pageCount;
	}
	public int getPageBlock() {
		return pageBlock;
	}
	public void setPageBlock(int pageBlock) {
		this.pageBlock = pageBlock;
	}
	public int getStartPage() {
		return startPage;
	}
	public void setStartPage(int startPage) {
		this.startPage = startPage;
	}
	public int getEndPage() {
		return endPage;
	}
	public void setEndPage(int endPage) {
		this.endPage = endPage;
	}
	
	
	
	
	


}
