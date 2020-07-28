package fileSys.service;

import fileSys.bean.*;

import java.util.HashMap;
import java.util.List;

public interface AdminService {

    public Admin login(String account);

    public List<Menu> findMenuList(int adminId);

    public LayuiBean<Admin> findAdminList(int pageSize, int offset);

    public LayuiBean<Journal> findJournalList(HashMap<String, Object> condition);

    public int deleteJournal(int journalId);


}
