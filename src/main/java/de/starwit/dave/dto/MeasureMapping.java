package de.starwit.dave.dto;

import java.util.Map;

/**
 * This class maps configuration in Observatory, to DAVe's format.
 */
public class MeasureMapping {

    // id for observation area in Observatory
    private String observationAreaId;

    // counting id in DAVe, uuid
    private String daveCountingId;

    // this maps names of measurement light barriers in Observatory to the
    // corresponding intersection legs in DAVe. Format: "1" : "meckauer-nordost"
    private Map<String, String> intersectionMapping;

    public String getObservationAreaId() {
        return observationAreaId;
    }

    public void setObservationAreaId(String observationAreaId) {
        this.observationAreaId = observationAreaId;
    }

    public String getDaveCountingId() {
        return daveCountingId;
    }

    public void setDaveCountingId(String daveCountingId) {
        this.daveCountingId = daveCountingId;
    }

    public Map<String, String> getIntersectionMapping() {
        return intersectionMapping;
    }

    public void setIntersectionMapping(Map<String, String> intersectionMapping) {
        this.intersectionMapping = intersectionMapping;
    }

    @Override
    public String toString() {
        return "MeasureMapping [observationAreaId=" + observationAreaId + ", daveCountingId=" + daveCountingId
                + ", intersectionMapping=" + intersectionMapping + "]";
    }
}
