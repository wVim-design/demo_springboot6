package fileSys.mapper;

import fileSys.bean.Type;

import java.util.List;

public interface TypeMapper {

    public List<Type> findFileType();
    public int changeTypeStatus(Type type);
    public int addType(Type type);
    public Type findTypeBySuffix(String suffix);
}
