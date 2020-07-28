package fileSys.mapper;



import fileSys.bean.Admin;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface AdminMapper {
//更新返回受影响行数，可以定义int、void。查询返回结果集（可能是int）
    public Admin login(String account);
    public int selectAdminNum();
    public List<Admin> selectAdminList(@Param("pageSize") int pageSize, @Param("offset") int offset);


}
