package fileSys.service;

import fileSys.bean.LayuiBean;
import fileSys.bean.ScoreRec;
import fileSys.bean.UserInfo;

import java.util.HashMap;

public interface ScoreRecService {

    public int insertScoreRec(ScoreRec scoreRec);

    public int hasDownloaded(int fileId, int userId);

    public LayuiBean<ScoreRec> findScoreList(HashMap<String, Object> condition);
}
