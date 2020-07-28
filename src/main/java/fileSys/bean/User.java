package fileSys.bean;

public class User {

    private int id;
    private String account;
    private String password;
    private String name;
    private String sex;
    private String phone;
    private String email;
    private String regtime;
    private int downloadCount;
    private int uploadCount;
    private int score;
    private int statusId;
    private int levelId;

    public User() {
    }

    public int getId() {
        return id;
    }

    public String getAccount() {
        return account;
    }

    public String getPassword() {
        return password;
    }

    public String getName() {
        return name;
    }

    public String getSex() {
        return sex;
    }

    public String getPhone() {
        return phone;
    }

    public String getEmail() {
        return email;
    }

    public String getRegtime() {
        return regtime;
    }

    public int getDownloadCount() {
        return downloadCount;
    }

    public int getUploadCount() {
        return uploadCount;
    }

    public int getScore() {
        return score;
    }

    public int getStatusId() {
        return statusId;
    }

    public int getLevelId() {
        return levelId;
    }

    public void setId(int id) {
        this.id = id;
    }

    public void setAccount(String account) {
        this.account = account;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public void setName(String name) {
        this.name = name;
    }

    public void setSex(String sex) {
        this.sex = sex;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public void setRegtime(String regtime) {
        this.regtime = regtime;
    }

    public void setDownloadCount(int downloadCount) {
        this.downloadCount = downloadCount;
    }

    public void setUploadCount(int uploadCount) {
        this.uploadCount = uploadCount;
    }

    public void setScore(int score) {
        this.score = score;
    }

    public void setStatusId(int statusId) {
        this.statusId = statusId;
    }

    public void setLevelId(int levelId) {
        this.levelId = levelId;
    }
}
