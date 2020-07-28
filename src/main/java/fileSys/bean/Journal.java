package fileSys.bean;

public class Journal {

    private int id;
    private int adminId;
    private String adminAccount;
    private String event;
    private String createTime;
    private String adminName;

    public Journal() {
    }

    public int getId() {
        return id;
    }

    public int getAdminId() {
        return adminId;
    }

    public String getEvent() {
        return event;
    }

    public String getCreateTime() {
        return createTime;
    }

    public void setId(int id) {
        this.id = id;
    }

    public void setAdminId(int adminId) {
        this.adminId = adminId;
    }

    public void setEvent(String event) {
        this.event = event;
    }

    public void setCreateTime(String createTime) {
        this.createTime = createTime;
    }

    public String getAdminName() {
        return adminName;
    }

    public void setAdminName(String adminName) {
        this.adminName = adminName;
    }

    public String getAdminAccount() {
        return adminAccount;
    }

    public void setAdminAccount(String adminAccount) {
        this.adminAccount = adminAccount;
    }
}
