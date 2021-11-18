package test;

import static org.junit.Assert.assertTrue;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import org.junit.jupiter.api.Test;

import user.User;

class JoinTest {
    private Connection conn;
    private PreparedStatement pstmt;
    private ResultSet rs;
    //회원가입 정보가 db에 제대로 들어가는지 테스트
    @Test
    void test() {
        //1. given 
        //user정보 준비
        User user = new User();
        user.setUserID("20111118Tester");      
        user.setUserPassword("1234");
        user.setUserName("홍길동");    
        user.setUserGender("남자");  
        user.setUserEmail("ggoomter2@gmail.com");   
        
        
        //데이터베이스 접속
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
        
        //2. when
        int result = 0;
        String SQL = "INSERT INTO USER VALUES (?, ?, ?, ?, ?)";
        try {
            pstmt = conn.prepareStatement(SQL);
            pstmt.setString(1,  user.getUserID());          //아이디
            pstmt.setString(2,  user.getUserPassword());    //비밀번호
            pstmt.setString(3,  user.getUserName());        //이름
            pstmt.setString(4,  user.getUserGender());      //성별
            pstmt.setString(5,  user.getUserEmail());       //이메일
            result =  pstmt.executeUpdate();   //SELECT빼고 모든 쿼리실행
            System.out.println(result);
        } catch (Exception e) {
            e.printStackTrace();
            result =  -1;  //데이터베이스 오류
        }

        //3. then
        assertTrue(result==1);
    }

}
