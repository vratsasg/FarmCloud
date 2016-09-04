package com.webstart.DTO;

public class CropInfoDTO {

    private String featureIdentifier;
    private String featureName;
    private String observableIdentifier;
    private String procedureIdentifier;
    private String procedureDescription;

    public CropInfoDTO() {

    }

    public CropInfoDTO(String featureIdentifier, String featureName, String observableIdentifier, String procedureIdentifier, String procedureDescription) {
        this.featureIdentifier = featureIdentifier;
        this.featureName = featureName;
        this.observableIdentifier = observableIdentifier;
        this.procedureIdentifier = procedureIdentifier;
        this.procedureDescription = procedureDescription;
    }

    public String getFeatureIdentifier() {
        return featureIdentifier;
    }

    public void setFeatureIdentifier(String featureIdentifier) {
        this.featureIdentifier = featureIdentifier;
    }

    public String getFeatureName() {
        return featureName;
    }

    public void setFeatureName(String featureName) {
        this.featureName = featureName;
    }

    public String getObservableIdentifier() {
        return observableIdentifier;
    }

    public void setObservableIdentifier(String observableIdentifier) {
        this.observableIdentifier = observableIdentifier;
    }

    public String getProcedureIdentifier() {
        return procedureIdentifier;
    }

    public void setProcedureIdentifier(String procedureIdentifier) {
        this.procedureIdentifier = procedureIdentifier;
    }

    public String getProcedureDescription() {
        return procedureDescription;
    }

    public void setProcedureDescription(String procedureDescription) {
        this.procedureDescription = procedureDescription;
    }
}
