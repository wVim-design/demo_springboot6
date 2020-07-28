package fileSys.bean;

import java.util.List;

public class Menu {

    private String name;
    private String url;
    private int parentid;
    private int orders;
    private List<Menu> menus;

    public Menu() {
    }

    public String getName() {
        return name;
    }

    public String getUrl() {
        return url;
    }

    public int getParentid() {
        return parentid;
    }

    public int getOrders() {
        return orders;
    }

    public void setName(String name) {
        this.name = name;
    }

    public void setUrl(String url) {
        this.url = url;
    }

    public void setParentid(int parentid) {
        this.parentid = parentid;
    }

    public void setOrders(int orders) {
        this.orders = orders;
    }

    public List<Menu> getMenus() {
        return menus;
    }

    public void setMenus(List<Menu> menus) {
        this.menus = menus;
    }
}
