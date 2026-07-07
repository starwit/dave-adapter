package de.starwit.dave.persistence;

public class CountResults {

    long count;
    String compassDirFrom;
    String compassDirTo;
    long objectClassId;

    public long getCount() {
        return count;
    }

    public void setCount(long count) {
        this.count = count;
    }

    public String getCompassDirFrom() {
        return compassDirFrom;
    }

    public void setCompassDirFrom(String compassDirFrom) {
        this.compassDirFrom = compassDirFrom;
    }

    public String getCompassDirTo() {
        return compassDirTo;
    }

    public void setCompassDirTo(String compassDirTo) {
        this.compassDirTo = compassDirTo;
    }

    public long getObjectClassId() {
        return objectClassId;
    }

    public void setObjectClassId(long objectClassId) {
        this.objectClassId = objectClassId;
    }

    @Override
    public String toString() {
        return "CountResults [count=" + count + ",\ncompassDirFrom=" + compassDirFrom + ", \ncompassDirTo="
                + compassDirTo
                + ", \nobjectClassId=" + objectClassId + "]\n";
    }
}
