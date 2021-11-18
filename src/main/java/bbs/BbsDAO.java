package bbs;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

/**
 * 
 * @author ggoomter
 * 2021.11.16 조회수 추가
 */

public class BbsDAO {
    private Connection conn;
    private ResultSet rs;
    
    
    public BbsDAO() {
        try {
            //mysql 접속 정보
            String dbURL = "jdbc:mysql://localhost:3306/BBS?characterEncoding=UTF-8&serverTimezone=UTC";
            String dbID = "ggoomter";                       //mysql 접속 id
            String dbPassword = "0070";            //mysql 접속 비밀번호
            Class.forName("com.mysql.cj.jdbc.Driver");  //드라이버 인터페이스를 구현한 클래스를 로딩
            conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    
    public String getDate() {
        String SQL = "SELECT NOW()";
        try {
            PreparedStatement pstmt = conn.prepareStatement(SQL);
            rs = pstmt.executeQuery();
            if(rs.next()) {
                return rs.getString(1); //현재의 날짜 반환
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "";       
    }
    

    // 다음글의 번호 가져오기
    public int getNext() {
        String SQL = "SELECT bbsID FROM BBS ORDER BY bbsID DESC";   //내림차순이기때문에 마지막글에쓴글이 제일 위에 뜸
        try {
            PreparedStatement pstmt = conn.prepareStatement(SQL);
            rs = pstmt.executeQuery();
            if(rs.next()) {
                return rs.getInt(1) + 1;    //다음게시물(현재글보다 bbsID가 낮은글)번호 리턴
            }
            return 1;   //끝까지 돌았을 경우 내가 유일한거니까 1 리턴
        } catch (Exception e) {
            e.printStackTrace();
        }
        return -1;  //데이터베이스 오류       
    }
    
    
    //글쓰기
    public int write(String bbsTitle, String userID, String bbsContent) {
        String SQL = "INSERT INTO BBS (bbsID, bbsTitle, userID, bbsDate, bbsContent, bbsAvailable) VALUES (?,?,?,?,?,?)";
        try {
        	System.out.println("글쓰기");
            PreparedStatement pstmt = conn.prepareStatement(SQL);
            pstmt.setInt(1, getNext());
            pstmt.setString(2, bbsTitle);
            pstmt.setString(3, userID);
            pstmt.setString(4, getDate());
            pstmt.setString(5, bbsContent);
            pstmt.setInt(6, 1); //available. 첫글을썼을땐 true
            return pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return -1;  //데이터베이스 오류       
    }
    
    
    /**
     * 글 목록
     * @param pageNum
     * @return 글의 목록은 갯수가 동적으로 정해지기 때문에 ArrayList사용.
     */
    public ArrayList<Bbs> getList(int pageNum){
        String SQL = "SELECT * FROM BBS WHERE bbsID < ? AND bbsAvailable = 1 ORDER BY bbsID DESC LIMIT 10";
        ArrayList<Bbs> list = new ArrayList<Bbs>();        
        try {
            PreparedStatement pstmt = conn.prepareStatement(SQL);
            
            pstmt.setInt(1, getNext() - (pageNum-1)*10);
            /* 현재 총 글의 갯수가 12개면   13 - (1-1)*10 = 13
             * WHERE bbsID < 13 이 되어 13보다 작은 숫자만 가져온다 */
            rs = pstmt.executeQuery();
            while (rs.next()) {
                Bbs bbs = new Bbs();
                //DB조회 결과로나온것을 순서대로 담아서 자바단으로 저장
                bbs.setBbsID(rs.getInt(1));
                bbs.setBbsTitle(rs.getString(2));
                bbs.setUserID(rs.getString(3));
                bbs.setBbsDate(rs.getString(4));
                bbs.setBbsContent(rs.getString(5));
                bbs.setBbsAvailable(rs.getInt(6));
                bbs.setViewCount(rs.getInt(7));
                list.add(bbs);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
    
    
    /**
     * pageNumber에 해당하는 페이지를 출력해야하는지 판단
     * @param pageNum
     * @return
     */
    public boolean nextPage(int pageNum) {
        String SQL = "SELECT * FROM BBS WHERE bbsID < ? AND bbsAvailable = 1 ";
        ArrayList<Bbs> list = new ArrayList<Bbs>();        
        try {
            PreparedStatement pstmt = conn.prepareStatement(SQL);
            
            pstmt.setInt(1, getNext() - (pageNum-1)*10); //페이지 알고리즘
           //현재 총 글의 갯수가 12개이고 페이지번호로 2를 넘겼다면   13 - (2-1)*10 =   13-10   =3
           
            rs = pstmt.executeQuery();  
            while (rs.next()) { //3까지 읽고 다음이 있기 때문에 true반환 
                return true;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
    
    
    /*
     * 하나의 글을 자세하게 보는 기능
     */
    public Bbs getBbs(int bbsID) {
        String SQL = "SELECT * FROM BBS WHERE bbsID = ?";
        ArrayList<Bbs> list = new ArrayList<Bbs>();        
        try {
        	System.out.println("글 자세히 보기");
            PreparedStatement pstmt = conn.prepareStatement(SQL);
            pstmt.setInt(1,  bbsID);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                Bbs bbs = new Bbs();
                //DB조회 결과로나온것을 순서대로 담아서 자바단으로 저장
                bbs.setBbsID(rs.getInt(1));
                bbs.setBbsTitle(rs.getString(2));
                bbs.setUserID(rs.getString(3));
                bbs.setBbsDate(rs.getString(4));
                bbs.setBbsContent(rs.getString(5));
                bbs.setBbsAvailable(rs.getInt(6));
                bbs.setViewCount(rs.getInt(7));
                increaseViewCount(bbsID);
                return bbs;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
    
    //글 수정
    public int update(int bbsID, String bbsTitle, String bbsContent) {
        String SQL = "UPDATE BBS SET bbsTitle=?, bbsContent = ? WHERE bbsID = ?";
        try {
            PreparedStatement pstmt = conn.prepareStatement(SQL);
            pstmt.setString(1, bbsTitle);
            pstmt.setString(2, bbsContent);
            pstmt.setInt(3, bbsID);
            return pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return -1;  //데이터베이스 오류        
    }
    
    //글 삭제
    public int delete(int bbsID, String bbsTitle, String bbsContent) {
        String SQL = "UPDATE BBS SET bbsAvailable=0 WHERE bbsID = ?";
        try {
            PreparedStatement pstmt = conn.prepareStatement(SQL);
            pstmt.setInt(1, bbsID);
            return pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return -1;  //데이터베이스 오류        
    }
    
    
    //게시글 보면 조회수 1 증가
    public int increaseViewCount(int bbsID) {
        String SQL = "UPDATE BBS SET VIEWCOUNT=VIEWCOUNT+1 WHERE bbsID = ?";
        try {
            PreparedStatement pstmt = conn.prepareStatement(SQL);
            pstmt.setInt(1, bbsID);
            return pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return -1;  //데이터베이스 오류    
    }
    

    
}
