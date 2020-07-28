package fileSys.service;

import fileSys.bean.Type;

import java.util.List;

public interface TypeService {

    public List<Type> findFileType();

    public int changeTypeStatus(List<Type> typeList);

    public int addType(Type type);

    public Type findTypeBySuffix(String suffix);
}
