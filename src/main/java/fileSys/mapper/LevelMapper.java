package fileSys.mapper;

import fileSys.bean.Level;

import java.util.HashMap;
import java.util.List;

public interface LevelMapper {

    public int selectLevelNum();
    public List<Level> selectLevelList(HashMap<String, Object> condition);

    public int editLevel(Level level);
    public int addLevel(Level level);
    public Level findLevelById(int id);
}
