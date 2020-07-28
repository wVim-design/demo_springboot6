package fileSys.service;

import fileSys.bean.LayuiBean;
import fileSys.bean.Params;
import fileSys.bean.ScoreRec;
import fileSys.bean.UserInfo;
import fileSys.mapper.ScoreRecMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;

@Service("scoreRecService")
public class ScoreRecServiceImpl implements ScoreRecService {

    @Autowired
    public ScoreRecMapper scoreRecMapper;

    @Override
    public int insertScoreRec(ScoreRec scoreRec) {
        return scoreRecMapper.insertScoreRec(scoreRec);
    }

    @Override
    public int hasDownloaded(int fileId, int userId) {
        return scoreRecMapper.hasDownloaded(fileId,userId);
    }

    @Override
    public LayuiBean<ScoreRec> findScoreList(HashMap<String, Object> condition) {
        LayuiBean<ScoreRec> res = new LayuiBean<>();
        int totalNum = scoreRecMapper.selectScoreRecNum(condition);
        res.setCount(totalNum);
        List<ScoreRec> scoreList = scoreRecMapper.selectScoreRecList(condition);
        res.setData(scoreList);
        return res;
    }
}
