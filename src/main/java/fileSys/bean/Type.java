package fileSys.bean;

public class Type {

    private int id;
    private String suffix;
    private String status;
    private int uploadScore;

    public Type() {

    }

    public int getId() {
        return id;
    }

    public String getSuffix() {
        return suffix;
    }

    public String getStatus() {
        return status;
    }

    public int getUploadScore() {
        return uploadScore;
    }

    public void setId(int id) {
        this.id = id;
    }

    public void setSuffix(String suffix) {
        this.suffix = suffix;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public void setUploadScore(int uploadScore) {
        this.uploadScore = uploadScore;
    }
}
