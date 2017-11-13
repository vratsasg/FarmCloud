package com.webstart.DTO;

/**
 * Created by George on 2/8/2016.
 */
public class FeatureidIdentifier {
    private Integer featureinterestid;
    private String identifier;
    private String description;
    private int userId;

    public FeatureidIdentifier() {
    }

    public FeatureidIdentifier(Integer featureinterestid, String identifier) {
        this.featureinterestid = featureinterestid;
        this.identifier = identifier;
    }

    public FeatureidIdentifier(Integer featureinterestid, String identifier, String description, int userid) {
        this.featureinterestid = featureinterestid;
        this.identifier = identifier;
        this.description = description;
        this.userId = userid;
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

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }
}
