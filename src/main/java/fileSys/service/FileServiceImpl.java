package fileSys.service;

import fileSys.bean.LayuiBean;
import fileSys.bean.MyFile;
import fileSys.bean.MyFileInfo;
import fileSys.bean.Params;
import fileSys.mapper.FileMapper;
import fileSys.mapper.ParamsMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;

@Service("fileService")
public class FileServiceImpl implements FileService{

    @Autowired
    public FileMapper fileMapper;
    @Autowired
    public ParamsMapper paramsMapper;

    @Override
    public LayuiBean<MyFileInfo> findFileList(HashMap<String, Object> condition) {
        LayuiBean<MyFileInfo> res = new LayuiBean<>();
        int totalNum = fileMapper.selectFileNum(condition);
        res.setCount(totalNum);
        List<MyFileInfo> fileList = fileMapper.selectFileList(condition);
        res.setData(fileList);
        List<Params> paramsList = paramsMapper.fileStatusList();
        res.setParamsList(paramsList);
        return res;
    }

    @Override
    public int changeFileStatus(String statusId, String id) {
        return fileMapper.changeFileStatus(Integer.parseInt(statusId),Integer.parseInt(id));
    }

    @Override
    public MyFile findFileById(int id) {
        return fileMapper.fileFileById(id);
    }

    @Override
    public int insertFile(MyFile myFile) {
        return fileMapper.insertFile(myFile);
    }
}
