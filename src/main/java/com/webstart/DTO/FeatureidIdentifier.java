package com.webstart.DTO;

/**
 * Created by George on 2/8/2016.
 */
public class FeatureidIdentifier {


    private Integer featureinterestid;

    private String identifier;

    public FeatureidIdentifier() {
    }


    public FeatureidIdentifier(Integer featureinterestid, String identifier) {
        this.featureinterestid = featureinterestid;
        this.identifier = identifier;
    }

    public Integer getFeatureinterestid() {
        return featureinterestid;
    }

    public void setFeatureinterestid(Integer featureinterestid) {
        this.featureinterestid = featureinterestid;
    }

    public String getIdentifier() {
        return identifier;
    }

    public void setIdentifier(String identifier) {
        this.identifier = identifier;
    }
}
