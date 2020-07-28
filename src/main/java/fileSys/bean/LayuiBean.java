package fileSys.bean;

import java.util.List;

public class LayuiBean<T>{

    private int code;
    private String msg;
    private int count;
    private List<T> data;
    private List<Params> paramsList;

    public LayuiBean() {
    }


    public int getCode() {
        return code;
    }

    public String getMsg() {
        return msg;
    }

    public int getCount() {
        return count;
    }

    public List<T> getData() {
        return data;
    }

    public void setCode(int code) {
        this.code = code;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }

    public void setCount(int count) {
        this.count = count;
    }

    public void setData(List<T> data) {
        this.data = data;
    }

    public List<Params> getParamsList() {
        return paramsList;
    }

    public void setParamsList(List<Params> paramsList) {
        this.paramsList = paramsList;
    }
}
