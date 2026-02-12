package de.starwit.dave.dto;

import java.time.Instant;

public class CountResultPerType {
    private Instant start;
    private Instant end;
    private String from;
    private String to;
    private int pkw;
    private int lkw;
    private int busse;
    private int kraftraeder;
    private int fahrradfahrer;
    private int fussgaenger;

    public CountResultPerType(Instant start, Instant end, String from, String to, int pkw, int lkw, int busse, int kraftraeder, int fahrradfahrer, int fussgaenger) {
        this.start = start;
        this.end = end;
        this.from = from;
        this.to = to;
        this.pkw = pkw;
        this.lkw = lkw;
        this.busse = busse;
        this.kraftraeder = kraftraeder;
        this.fahrradfahrer = fahrradfahrer;
        this.fussgaenger = fussgaenger;
    }

    public Instant getStart() {
        return start;
    }

    public void setStart(Instant start) {
        this.start = start;
    }

    public Instant getEnd() {
        return end;
    }

    public void setEnd(Instant end) {
        this.end = end;
    }

    public String getFrom() {
        return from;
    }

    public void setFrom(String from) {
        this.from = from;
    }

    public String getTo() {
        return to;
    }

    public void setTo(String to) {
        this.to = to;
    }

    public int getPkw() {
        return pkw;
    }

    public void setPkw(int pkw) {
        this.pkw = pkw;
    }

    public int getLkw() {
        return lkw;
    }

    public void setLkw(int lkw) {
        this.lkw = lkw;
    }

    public int getBusse() {
        return busse;
    }

    public void setBusse(int busse) {
        this.busse = busse;
    }

    public int getKraftraeder() {
        return kraftraeder;
    }

    public void setKraftraeder(int kraftraeder) {
        this.kraftraeder = kraftraeder;
    }

    public int getFahrradfahrer() {
        return fahrradfahrer;
    }

    public void setFahrradfahrer(int fahrradfahrer) {
        this.fahrradfahrer = fahrradfahrer;
    }

    public int getFussgaenger() {
        return fussgaenger;
    }

    public void setFussgaenger(int fussgaenger) {
        this.fussgaenger = fussgaenger;
    }

    @Override
    public String toString() {
        return "CountResultPerType{" +
                "start=" + start +
                ", end=" + end +
                ", from='" + from + '\'' +
                ", to='" + to + '\'' +
                ", pkw=" + pkw +
                ", lkw=" + lkw +
                ", busse=" + busse +
                ", kraftraeder=" + kraftraeder +
                ", fahrradfahrer=" + fahrradfahrer +
                ", fussgaenger=" + fussgaenger +
                '}';
    }
}
