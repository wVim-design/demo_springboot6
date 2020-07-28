package fileSys.mapper;

import fileSys.bean.ScoreRec;
import fileSys.bean.UserInfo;

import java.util.HashMap;
import java.util.List;

public interface ScoreRecMapper {

    public int insertScoreRec(ScoreRec scoreRec);
    public int hasDownloaded(int fileId, int userId);
    public int selectScoreRecNum(HashMap<String, Object> condition);
    public List<ScoreRec> selectScoreRecList(HashMap<String, Object> condition);
}
