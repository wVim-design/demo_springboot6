package fileSys.mapper;


import fileSys.bean.User;
import fileSys.bean.UserInfo;
import org.apache.ibatis.annotations.Param;

import java.util.HashMap;
import java.util.List;

public interface UserMapper {

    public User login(String account);
    public int accTest(String account);
    public int register(User user);
    public int selectUserNum(HashMap<String, Object> condition);
    public List<UserInfo> selectUserList(HashMap<String, Object> condition);
    public int changeUserStatus(@Param("statusId") int statusId, @Param("id") int id);
    public UserInfo findUserInfo(int userId);
    public int modifyMeg(UserInfo userInfo);
    public int updateUserForUpload(int userId, int score);
    public int updateUserForDownload(int userId, int score);
}
