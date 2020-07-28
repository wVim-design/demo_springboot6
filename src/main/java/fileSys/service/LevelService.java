package fileSys.service;

import fileSys.bean.LayuiBean;
import fileSys.bean.Level;

import java.util.HashMap;


public interface LevelService {

    public LayuiBean<Level> findLevelList(HashMap<String, Object> condition);

    public int editLevel(Level level);

    public int addLevel(Level level);

    public Level findLevelById(int id);

}
