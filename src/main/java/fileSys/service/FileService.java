package fileSys.service;

import fileSys.bean.LayuiBean;
import fileSys.bean.MyFile;
import fileSys.bean.MyFileInfo;

import java.util.HashMap;

public interface FileService {

    public LayuiBean<MyFileInfo> findFileList(HashMap<String, Object> condition);

    public int changeFileStatus(String statusId, String id);

    public int insertFile(MyFile myFile);

    public MyFile findFileById(int id);
}
