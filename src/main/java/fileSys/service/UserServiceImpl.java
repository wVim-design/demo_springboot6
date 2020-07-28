package fileSys.service;

import fileSys.bean.*;
import fileSys.mapper.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;

@Service("userService")
public class UserServiceImpl implements UserService{

    @Autowired
    public UserMapper userMapper;
    @Autowired
    public ParamsMapper paramsMapper;

    @Override
    public LayuiBean<UserInfo> findUserList(HashMap<String, Object> condition) {
        LayuiBean<UserInfo> res = new LayuiBean<>();
        int totalNum = userMapper.selectUserNum(condition);
        res.setCount(totalNum);
        List<UserInfo> userList = userMapper.selectUserList(condition);
        res.setData(userList);
        List<Params> paramsList = paramsMapper.userStatusList();
        res.setParamsList(paramsList);
        return res;
    }

    @Override
    public int updateUserForUpload(int userId, int score) {
        return userMapper.updateUserForUpload(userId,score);
    }

    @Override
    public int updateUserForDownload(int userId, int score) {
        return userMapper.updateUserForDownload(userId,score);
    }

    @Override
    public int changeUserStatus(String statusId,String id) {
        return userMapper.changeUserStatus(Integer.parseInt(statusId),Integer.parseInt(id));
    }

    @Override
    public User login(String account) {
        return  userMapper.login(account);
    }

    @Override
    public int register(User user) {
        return userMapper.register(user);
    }

    @Override
    public int accTest(String account) {
        return userMapper.accTest(account);
    }

    @Override
    public UserInfo findUserInfo(int userId) {
        return userMapper.findUserInfo(userId);
    }

    @Override
    public int modifyMsg(UserInfo userInfo) {
        return userMapper.modifyMeg(userInfo);
    }






}
