package fileSys.bean;

public class MyFileInfo extends MyFile {

    private String userName;
    private int downloadRank;
    private String statusName;
    private String suffix;

    public MyFileInfo() {
    }

    public String getUserName() {
        return userName;
    }

    public int getDownloadRank() {
        return downloadRank;
    }

    public String getStatusName() {
        return statusName;
    }

    public String getSuffix() {
        return suffix;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public void setDownloadRank(int downloadRank) {
        this.downloadRank = downloadRank;
    }

    public void setStatusName(String statusName) {
        this.statusName = statusName;
    }

    public void setSuffix(String suffix) {
        this.suffix = suffix;
    }
}
