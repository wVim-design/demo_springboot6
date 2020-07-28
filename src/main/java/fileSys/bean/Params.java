package fileSys.bean;

public class Params {

    private String type;
    private String name;
    private String value;

    public Params(String type, String name, String value) {
        this.type = type;
        this.name = name;
        this.value = value;
    }

    public Params() {
    }

    public String getType() {
        return type;
    }

    public String getName() {
        return name;
    }

    public String getValue() {
        return value;
    }

    public void setType(String type) {
        this.type = type;
    }

    public void setName(String name) {
        this.name = name;
    }

    public void setValue(String value) {
        this.value = value;
    }

    @Override
    public String toString() {
        return "Params{" +
                "type='" + type + '\'' +
                ", name='" + name + '\'' +
                ", value='" + value + '\'' +
                '}';
    }
}
