package com.webstart.DTO;

import java.util.ArrayList;
import java.util.List;

public class FeatureObsProp {
    private Integer featureofinterestid;
    private String identifier;
    private String name;
    private List<FeatureMinMaxValue> featureObspropMinmaxlist;

    public FeatureObsProp() {

    }

    public FeatureObsProp(Integer featureofinterestid, String identifier, String name) {
        this.featureofinterestid = featureofinterestid;
        this.identifier = identifier;
        this.name = name;
        featureObspropMinmaxlist = new ArrayList<FeatureMinMaxValue>();
    }

    public Integer getFeatureofinterestid() {
        return featureofinterestid;
    }

    public void setFeatureofinterestid(Integer featureofinterestid) {
        this.featureofinterestid = featureofinterestid;
    }

    public String getIdentifier() {
        return identifier;
    }

    public void setIdentifier(String identifier) {
        this.identifier = identifier;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public List<FeatureMinMaxValue> getFeatureObsproplist() {
        return featureObspropMinmaxlist;
    }

    public void setFeatureObsproplist(List<FeatureMinMaxValue> featureObsproplist) {
        featureObspropMinmaxlist = featureObsproplist;
    }
}
