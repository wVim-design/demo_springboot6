package fileSys.service;

import fileSys.bean.*;
import fileSys.mapper.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;

@Service("adminService")
public class AdminServiceImpl implements AdminService{

    @Autowired
    public AdminMapper adminMapper;
    @Autowired
    public MenuMapper menuMapper;
    @Autowired
    public JournalMapper journalMapper;


    @Override
    public Admin login(String account){
        return adminMapper.login(account);
    }


    @Override
    public List<Menu> findMenuList(int adminId){
        return menuMapper.findMenuList(adminId);
    }

    @Override
    public LayuiBean<Admin> findAdminList(int pageSize, int offset) {
        LayuiBean<Admin> res = new LayuiBean<>();
        int totalNum = adminMapper.selectAdminNum();
        res.setCount(totalNum);
        List<Admin> adminList = adminMapper.selectAdminList(pageSize,offset);
        res.setData(adminList);
        return  res;
    }

    @Override
    public int deleteJournal(int journalId) {
        return journalMapper.deleteJournal(journalId);
    }

    @Override
    public LayuiBean<fileSys.bean.Journal> findJournalList(HashMap<String, Object> condition) {
        LayuiBean<fileSys.bean.Journal> res = new LayuiBean<>();
        int totalRec = journalMapper.selectJournalNum(condition);
        res.setCount(totalRec);
        List<fileSys.bean.Journal> journalList = journalMapper.selectJournalList(condition);
        res.setData(journalList);
        return res;
    }








}
