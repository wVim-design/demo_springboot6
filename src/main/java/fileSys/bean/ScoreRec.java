package fileSys.bean;

public class ScoreRec {

    private String type;
    private int score;
    private String createTime;
    private int userId;
    private int fileId;
    private String fileName;

    public ScoreRec() {
    }

    public ScoreRec(String type, int score, String createTime, int userId, int fileId) {
        this.type = type;
        this.score = score;
        this.createTime = createTime;
        this.userId = userId;
        this.fileId = fileId;
    }

    public String getType() {
        return type;
    }

    public int getScore() {
        return score;
    }

    public String getCreateTime() {
        return createTime;
    }

    public int getUserId() {
        return userId;
    }

    public int getFileId() {
        return fileId;
    }

    public void setType(String type) {
        this.type = type;
    }

    public void setScore(int score) {
        this.score = score;
    }

    public void setCreateTime(String createTime) {
        this.createTime = createTime;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public void setFileId(int fileId) {
        this.fileId = fileId;
    }

    public String getFileName() {
        return fileName;
    }

    public void setFileName(String fileName) {
        this.fileName = fileName;
    }
}
