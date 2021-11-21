package user;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;



public class UserDAO {
    private Connection conn;
    private PreparedStatement pstmt;
    private ResultSet rs;
    private Logger logger = LoggerFactory.getLogger(this.getClass());
    String dbURL = "jdbc:mysql://localhost:3306/BBS?characterEncoding=UTF-8&serverTimezone=UTC";
    String dbID = "ggoomter";                       //mysql 접속 id
    String dbPassword = "0070";            //mysql 접속 비밀번호
    
    
    /**
     * 로그인
     * @param userID
     * @param userPassword
     * @return
     */
    public int login(String userID, String userPassword) {
        String SQL = "SELECT userPassword FROM USER WHERE userID = ?";
        try {
            logger.debug("<접속시도> 아이디 : "+userID +"  비밀번호 : "+ userPassword);
        	Class.forName("com.mysql.cj.jdbc.Driver");  //드라이버 인터페이스를 구현한 클래스를 로딩
            conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
            pstmt = conn.prepareStatement(SQL);
            pstmt.setString(1, userID); // 첫번째 ?에 userID의 값 대입
            rs = pstmt.executeQuery();  // 준비된 쿼리를 실행시키고 결과값을 rs에 대입
            if(rs.next()) { // 존재한다면
                if(rs.getString(1).equals(userPassword))
                    return 1;   // 유저가 입력한 비밀번호와 db의 비밀번호가 같다면 로그인 성공
                else
                    return 0;   // 다르다면 비밀번호 불일치
            }else {
                return -1;  //존재하지 않느다면 아이디가 없음                
            }
        } catch (Exception e) {
            e.printStackTrace();
            logger.error("db접속 에러 발생");
        } finally {
			try {
				if(rs!=null)	  rs.close();
				if(pstmt !=null)  pstmt.close();
				if(conn!=null) 	  conn.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
        return -2;  //데이터베이스 오류
    }
    
    /**
     * 회원가입
     * @param user
     * @return
     */
    public int join(User user) {
        String SQL = "INSERT INTO USER VALUES (?, ?, ?, ?, ?)";
        try {
        	Class.forName("com.mysql.cj.jdbc.Driver");  //드라이버 인터페이스를 구현한 클래스를 로딩
            conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
            pstmt = conn.prepareStatement(SQL);
            pstmt.setString(1,  user.getUserID());          //아이디
            pstmt.setString(2,  user.getUserPassword());    //비밀번호
            pstmt.setString(3,  user.getUserName());        //이름
            pstmt.setString(4,  user.getUserGender());      //성별
            pstmt.setString(5,  user.getUserEmail());       //이메일
            return pstmt.executeUpdate();   //SELECT빼고 모든 쿼리실행
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
			try {
				if(rs!=null)	  rs.close();
				if(pstmt !=null)  pstmt.close();
				if(conn!=null) 	  conn.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
        return -1;  //데이터베이스 오류
    }
    
    
    /**
     * id중복체크
     * @param userID
     * @return
     */
    public int idCheck(String userID) {
        String SQL = "SELECT userID FROM USER WHERE userID = ?";
        int result = -2;
        try {
        	Class.forName("com.mysql.cj.jdbc.Driver");  //드라이버 인터페이스를 구현한 클래스를 로딩
            conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
            pstmt = conn.prepareStatement(SQL);
            pstmt.setString(1, userID); // 첫번째 ?에 userID의 값 대입
            rs = pstmt.executeQuery();  // 준비된 쿼리를 실행시키고 결과값을 rs에 대입
            if(rs.next()) { 
            	result = 1;		//중복
            }else {
            	result = -1;    //기존 회원에 없음            
            }
        } catch (Exception e) {
            e.printStackTrace();
            logger.error("db접속 에러 발생");
        } finally {
			try {
				if(rs!=null)	  rs.close();
				if(pstmt !=null)  pstmt.close();
				if(conn!=null) 	  conn.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
        return result; 
    }

}
