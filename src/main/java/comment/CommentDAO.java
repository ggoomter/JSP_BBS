package comment;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class CommentDAO {
    private Connection conn;
    private ResultSet rs;
    
    
    public CommentDAO() {
        try {
            //mysql 접속 정보
            String dbURL = "jdbc:mysql://localhost:3306/BBS?characterEncoding=UTF-8&serverTimezone=UTC";
            String dbID = "root";                       //mysql 접속 id
            String dbPassword = "system123";            //mysql 접속 비밀번호
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
    

    // 다음댓글의 번호 가져오기
    public int getNext() {
        String SQL = "SELECT commentID FROM COMMENT ORDER BY commentID DESC";   //내림차순이기때문에 마지막글에쓴글이 제일 위에 뜸
        try {
            PreparedStatement pstmt = conn.prepareStatement(SQL);
            rs = pstmt.executeQuery();
            if(rs.next()) {
                return rs.getInt(1) + 1;    //다음댓글번호 리턴
            }
            return 1;   //끝까지 돌았을 경우 내가 유일한거니까 1 리턴
        } catch (Exception e) {
            e.printStackTrace();
        }
        return -1;  //데이터베이스 오류       
    }
    
    
    //댓글 쓰기
    public int write(String bbsID, String userID, String commentText) {
        String SQL = "INSERT INTO COMMENT VALUES (?,?,?,?,?)";
        try {
            System.out.println("댓글 쓰기");
            PreparedStatement pstmt = conn.prepareStatement(SQL);
            pstmt.setInt(1, getNext());
            pstmt.setString(2, bbsID);
            pstmt.setString(3, commentText);
            pstmt.setString(4, userID);
            pstmt.setString(5, getDate());
            return pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return -1;  //데이터베이스 오류       
    }
    
    
    /**
     * 댓글 목록
     * @param number : 몇개 보여줄건지
     * @return 댓글의 목록은 갯수가 동적으로 정해지기 때문에 ArrayList사용.
     */
    public ArrayList<Comment> getList(int bbsID, int number){
        String SQL = "SELECT * FROM COMMENT WHERE bbsID = ? ORDER BY commentID DESC LIMIT ?";
        ArrayList<Comment> list = new ArrayList<Comment>();        
        try {
            System.out.println("댓글 목록");
            PreparedStatement pstmt = conn.prepareStatement(SQL);
            pstmt.setInt(1, bbsID);
            pstmt.setInt(2, number);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                Comment comment = new Comment();
                //DB조회 결과로나온것을 순서대로 담아서 자바단으로 저장
                comment.setCommentID(rs.getInt(1));
                comment.setBbsID(rs.getInt(2));
                comment.setCommentText(rs.getString(3));
                comment.setUserID(rs.getString(4));
                comment.setCommentDate(rs.getString(5));
                list.add(comment);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
    
    
    
    
    //댓글 수정
    public int update(int bbsID, int commentID, String commentText) {
        String SQL = "UPDATE COMMENT SET commentText = ?, commentDate = ? WHERE commentID = ? AND bbsID=?";
        try {
            System.out.println("댓글 수정");
            System.out.printf("글번호 : %d    댓글번호 : %d   바꾼내용 : %s\n", bbsID, commentID, commentText);
            PreparedStatement pstmt = conn.prepareStatement(SQL);
            pstmt.setString(1, commentText);
            pstmt.setString(2, getDate());
            pstmt.setInt(3, commentID);
            pstmt.setInt(4, bbsID);
            return pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return -1;  //데이터베이스 오류        
    }
    
    //댓글 삭제
    public int delete(int bbsID, int commentID) {
        String SQL = "DELETE FROM COMMENT WHERE bbsID=? and commentID = ?";
        try {
            System.out.println("댓글 삭제");
            PreparedStatement pstmt = conn.prepareStatement(SQL);
            pstmt.setInt(1, bbsID);
            pstmt.setInt(2, commentID);
            return pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return -1;  //데이터베이스 오류        
    }
    
}
