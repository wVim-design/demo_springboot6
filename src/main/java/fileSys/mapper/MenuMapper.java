package fileSys.mapper;


import fileSys.bean.Menu;

import java.util.List;

public interface MenuMapper {

    public List<Menu> findMenuList(int adminId);
}
