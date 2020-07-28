package fileSys.bean;

public class Level {

    private int id;
    private String name;
    private float upRatio;
    private float downRatio;
    private int maxScore;
    private int minScore;

    public Level() {
    }

    public int getId() {
        return id;
    }

    public String getName() {
        return name;
    }

    public float getUpRatio() {
        return upRatio;
    }

    public float getDownRatio() {
        return downRatio;
    }

    public int getMaxScore() {
        return maxScore;
    }

    public int getMinScore() {
        return minScore;
    }

    public void setId(int id) {
        this.id = id;
    }

    public void setName(String name) {
        this.name = name;
    }

    public void setUpRatio(float upRatio) {
        this.upRatio = upRatio;
    }

    public void setDownRatio(float downRatio) {
        this.downRatio = downRatio;
    }

    public void setMaxScore(int maxScore) {
        this.maxScore = maxScore;
    }

    public void setMinScore(int minScore) {
        this.minScore = minScore;
    }
}
