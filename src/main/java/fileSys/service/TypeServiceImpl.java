package fileSys.service;

import fileSys.bean.Type;
import fileSys.mapper.TypeMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service("typeService")
public class TypeServiceImpl implements TypeService {

    @Autowired
    public TypeMapper typeMapper;

    @Override
    public List<Type> findFileType() {
        return typeMapper.findFileType();
    }

    @Override
    public int changeTypeStatus(List<Type> typeList) {
        for (Type type:typeList) {
            int res= typeMapper.changeTypeStatus(type);
            if(res!=1){
                return 0;
            }
        }
        return 1;
    }

    @Override
    public int addType(Type type) {
        return typeMapper.addType(type);
    }

    @Override
    public Type findTypeBySuffix(String suffix) {
        return typeMapper.findTypeBySuffix(suffix);
    }
}
