package page;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import bbs.Bbs;

/**
 * 
 * @author ggoomter 2021.11.18
 */

public class Paging {

    private Connection conn;
    private ResultSet rs;

    public Paging() {
        try {
            //mysql 접속 정보
            String dbURL = "jdbc:mysql://localhost:3306/BBS?characterEncoding=UTF-8&serverTimezone=UTC";
            String dbID = "ggoomter"; //mysql 접속 id
            String dbPassword = "0070"; //mysql 접속 비밀번호
            Class.forName("com.mysql.cj.jdbc.Driver"); //드라이버 인터페이스를 구현한 클래스를 로딩
            conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    
    private int pageSize = 10;   //한 페이지에 출력할 글의 수
    private int pageBlock = 10;  //한 화면에 보여줄 페이지의 수
    private int pageNo;         //클릭한 페이지번호
    private int currentPage = 1; //현재페이지
    private int totalCount; //글전체수

    private int firstPageNo = 1; //모든페이지중에 첫번째 페이지번호
    private int finalPageNo; //모든페이지중에 마지막 페이지번호

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

    public int getPageNo() {
        return pageNo;
    }

    public void setPageNo(int pageNo) {
        this.pageNo = pageNo;
    }

    public int getCurrentPage() {
        return currentPage;
    }

    public void setCurrentPage(int currentPage) {
        this.currentPage = currentPage;
    }

    //현재변수값 totalCount를 가지고옴. 진짜가져오는건 getBbsTotalCount
    public int getTotalCount() {    
        this.makePaging();
        return totalCount;
    }

    public void setTotalCount(int totalCount) {
        this.totalCount = totalCount;
        this.makePaging();
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
        if (this.totalCount == 0)
            return; // 게시 글 전체 수가 없는 경우
        if (this.pageNo == 0)
            this.setPageNo(1); // 기본 값 설정
        if (this.pageSize == 0)
            this.setPageSize(10); // 기본 값 설정

        // 마지막 페이지
        int finalPage = (totalCount + (pageSize - 1)) / pageSize; 
        if (this.pageNo > finalPage)    // 어떤 이유로든지 넘겨받은 페이지번호가 마지막보다 크다면
            this.setPageNo(finalPage);  // 마지막 페이지로 설정


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

        if (isNowFirst) { //현재가 첫번째 페이지라면
            this.setPrevPageNo(1); // 이전 페이지 번호를 1로
        } else { //현재가 첫번째 페이지가 아니라면
            this.setPrevPageNo(currentPage - 1); // 현재 페이지번호 -1
        }

        this.setStartPageNo(startPage); // 시작 페이지 (페이징 네비 기준)
        this.setEndPageNo(endPage); // 끝 페이지 (페이징 네비 기준)

        if (isNowFinal) {
            this.setNextPageNo(finalPage); // 다음 페이지 번호
        } else {
            this.setNextPageNo(pageNo + 1); // 현재페이지번호 +1
        }

        this.setFinalPageNo(finalPage); // 마지막 페이지 번호
    }



    // 하나의 페이지에 보여줄 글 리스트
    public List<Bbs> getBbsList(int startRow, int endRow) throws SQLException {
        // 페이징 처리를 위한 sql / 인라인뷰, rownum 사용
        String SQL = "select @rownum:=@rownum+1, bbsID, bbsTitle, userID, bbsDate, bbsContent, bbsAvailable, VIEWCOUNT "
                + "FROM bbs, (SELECT @rownum:=0) TMP " + "where bbsId between ? and ? " + "order by bbsID desc";
        List<Bbs> list = null;
        try {
            PreparedStatement pstmt = conn.prepareStatement(SQL);
            pstmt.setInt(1, startRow); // sql 물음표에 값 매핑
            pstmt.setInt(2, endRow);
            rs = pstmt.executeQuery(); // sql 실행
            if (rs.next()) { // 데이터베이스에 데이터가 있으면 실행
                list = new ArrayList<>(); // list 객체 생성
                while (rs.next()) {
                    // 반복할 때마다 ExboardDTO 객체를 생성 및 데이터 저장
                    Bbs bbs = new Bbs();
                    bbs.setBbsID(rs.getInt(1));
                    bbs.setBbsTitle(rs.getString(2));
                    bbs.setUserID(rs.getString(3));
                    bbs.setBbsDate(rs.getString(4));
                    bbs.setBbsContent(rs.getString(5));
                    bbs.setBbsAvailable(rs.getInt(6));
                    bbs.setViewCount(rs.getInt(7));
                    list.add(bbs);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            conn.close(); // DB 연결 종료 / Connection 반환
        }
        return list; // list 반환
    }

    
    public int getBbsTotalCount() throws SQLException {
        int count = 0;
        String SQL = "SELECT COUNT(*) FROM BBS";
        try {
            PreparedStatement pstmt = conn.prepareStatement(SQL);
            rs = pstmt.executeQuery(); // sql 실행
            if (rs.next()) { // 데이터베이스에 데이터가 있으면 실행
                count = rs.getInt(1);
            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            conn.close();
        }
        return count;
    }

}
