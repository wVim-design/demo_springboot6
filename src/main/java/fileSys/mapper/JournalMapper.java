package fileSys.mapper;

import fileSys.bean.Journal;
import org.apache.ibatis.annotations.Mapper;

import java.util.HashMap;
import java.util.List;


public interface JournalMapper {

    public int insertJournal(Journal journal);
    public int deleteJournal(int journalId);
    public int selectJournalNum(HashMap<String, Object> condition);
    public List<Journal> selectJournalList(HashMap<String, Object> condition);
}
