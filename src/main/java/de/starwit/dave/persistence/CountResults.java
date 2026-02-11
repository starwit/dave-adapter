package de.starwit.dave.persistence;

import java.time.Instant;

public class CountResults {

    Instant time;
    long count;
    String nameFrom;
    String nameTo;
    long objectClassId;

    public Instant getTime() {
        return time;
    }

    public void setTime(Instant time) {
        this.time = time;
    }

    public long getCount() {
        return count;
    }

    public void setCount(long count) {
        this.count = count;
    }

    public String getNameFrom() {
        return nameFrom;
    }

    public void setNameFrom(String nameFrom) {
        this.nameFrom = nameFrom;
    }

    public String getNameTo() {
        return nameTo;
    }

    public void setNameTo(String nameTo) {
        this.nameTo = nameTo;
    }

    public long getObjectClassId() {
        return objectClassId;
    }

    public void setObjectClassId(long objectClassId) {
        this.objectClassId = objectClassId;
    }

    @Override
    public String toString() {
        return "CountResults [count=" + count + ",\nnameFrom=" + nameFrom + ", \nnameTo=" + nameTo + ", \nobjectClassId=" + objectClassId + ", \ntime=" + time + "]\n";
    }
}
