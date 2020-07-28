package fileSys.service;

import fileSys.bean.LayuiBean;
import fileSys.bean.Level;
import fileSys.mapper.LevelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;

@Service("levelService")
public class LevelServiceImpl implements LevelService{

    @Autowired
    public LevelMapper levelMapper;

    @Override
    public LayuiBean<Level> findLevelList(HashMap<String, Object> condition) {
        LayuiBean<Level> res = new LayuiBean<>();
        int totalNum = levelMapper.selectLevelNum();
        res.setCount(totalNum);
        List<Level> levelList = levelMapper.selectLevelList(condition);
        res.setData(levelList);
        return res;
    }

    @Override
    public int editLevel(Level level) {
        return levelMapper.editLevel(level);
    }

    @Override
    public int addLevel(Level level) {
        return levelMapper.addLevel(level);
    }

    @Override
    public Level findLevelById(int id) {
        return levelMapper.findLevelById(id);
    }
}
