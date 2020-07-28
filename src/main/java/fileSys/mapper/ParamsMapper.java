package fileSys.mapper;


import fileSys.bean.Params;

import java.util.List;

public interface ParamsMapper {

    public String searchScore(String englishType);
    public List<Params> userStatusList();
    public List<Params> fileStatusList();
}
