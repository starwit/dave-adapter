package de.starwit.dave.persistence;

import java.time.Instant;

public class CountResults {

    Instant time;
    long count;
    String route;
    long objectClassId;
    int daveFromRoute;
    int daveToRoute;

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

    public String getRoute() {
        return route;
    }

    public void setRoute(String route) {
        this.route = route;
    }

    public long getObjectClassId() {
        return objectClassId;
    }

    public void setObjectClassId(long objectClassId) {
        this.objectClassId = objectClassId;
    }

    public int getDaveFromRoute() {
        return daveFromRoute;
    }

    public void setDaveFromRoute(int daveRoute) {
        this.daveFromRoute = daveRoute;
    }

    public int getDaveToRoute() {
        return daveToRoute;
    }

    public void setDaveToRoute(int daveToRoute) {
        this.daveToRoute = daveToRoute;
    }

    @Override
    public String toString() {
        return "CountResults [time=" + time + ", count=" + count + ", route=" + route + ", objectClassId="
                + objectClassId + "]";
    }
}
