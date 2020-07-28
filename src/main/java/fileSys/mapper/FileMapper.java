package fileSys.mapper;

import fileSys.bean.MyFile;
import fileSys.bean.MyFileInfo;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.HashMap;
import java.util.List;


public interface FileMapper {

    public int selectFileNum(HashMap<String, Object> condition);
    public List<MyFileInfo> selectFileList(HashMap<String, Object> condition);
    public int changeFileStatus(@Param("statusId") int statusId, @Param("id") int id);
    public int insertFile(MyFile myFile);
    public MyFile fileFileById(int id);
}
