package fileSys.bean;

public class MyFile {

    private int id;
    private String name;
    private int typeId;
    private int downloadScore;
    private String uploadTime;
    private int statusId;
    private String description;
    private int userId;
    private int downloadTimes;
    private String path;



    public MyFile() {
    }

    public int getId() {
        return id;
    }

    public String getName() {
        return name;
    }

    public int getTypeId() {
        return typeId;
    }

    public int getDownloadScore() {
        return downloadScore;
    }

    public String getUploadTime() {
        return uploadTime;
    }

    public int getStatusId() {
        return statusId;
    }

    public String getDescription() {
        return description;
    }

    public int getUserId() {
        return userId;
    }

    public int getDownloadTimes() {
        return downloadTimes;
    }

    public void setId(int id) {
        this.id = id;
    }

    public void setName(String name) {
        this.name = name;
    }

    public void setTypeId(int typeId) {
        this.typeId = typeId;
    }

    public void setDownloadScore(int downloadScore) {
        this.downloadScore = downloadScore;
    }

    public void setUploadTime(String uploadTime) {
        this.uploadTime = uploadTime;
    }

    public void setStatusId(int statusId) {
        this.statusId = statusId;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public void setDownloadTimes(int downloadTimes) {
        this.downloadTimes = downloadTimes;
    }

    public String getPath() {
        return path;
    }

    public void setPath(String path) {
        this.path = path;
    }


}
