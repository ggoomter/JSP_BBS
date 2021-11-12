package comment;

public class Comment {
    private int commentID;
    private int bbsID;
    private String commentText;
    private String userID;
    private String commentDate;
  
    public int getCommentID() {
        return commentID;
    }
    public void setCommentID(int commentID) {
        this.commentID = commentID;
    }
    public int getBbsID() {
        return bbsID;
    }
    public void setBbsID(int bbsID) {
        this.bbsID = bbsID;
    }
    public String getCommentText() {
        return commentText;
    }
    public void setCommentText(String commentText) {
        this.commentText = commentText;
    }
    public String getUserID() {
        return userID;
    }
    public void setUserID(String userID) {
        this.userID = userID;
    }
    public String getCommentDate() {
        return commentDate;
    }
    public void setCommentDate(String commentDate) {
        this.commentDate = commentDate;
    }
    
}