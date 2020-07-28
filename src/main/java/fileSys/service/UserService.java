package fileSys.service;

import fileSys.bean.*;

import java.util.HashMap;

public interface UserService {

    public User login(String account);

    public int accTest(String account);

    public int register(User user);

    public LayuiBean<UserInfo> findUserList(HashMap<String, Object> condition);

    public int changeUserStatus(String statusId, String id);

    public UserInfo findUserInfo(int userId);

    public int modifyMsg(UserInfo userInfo);

    public int updateUserForUpload(int userId, int score);

    public int updateUserForDownload(int userId, int score);





}
