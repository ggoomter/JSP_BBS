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
 * @author ggoomter
 * 2021.11.18 
 */

public class PageDAO {
    private Connection conn;
    private ResultSet rs;
    
    public PageDAO() {
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
	

	
	// 하나의 페이지에 보여줄 글 리스트
	public List<Bbs> getBbsList(int startRow, int endRow) throws SQLException {
		// 페이징 처리를 위한 sql / 인라인뷰, rownum 사용
		String SQL = "select @rownum:=@rownum+1, bbsID, bbsTitle, userID, bbsDate, bbsContent, bbsAvailable, VIEWCOUNT "
				+ "FROM bbs, (SELECT @rownum:=0) TMP "
				+ "where bbsId between ? and ? "
				+ "order by bbsID desc";
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
}
