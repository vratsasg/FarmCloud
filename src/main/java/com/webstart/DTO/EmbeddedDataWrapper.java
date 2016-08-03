package com.webstart.DTO;

import com.webstart.model.EmbeddedData;

import java.util.ArrayList;
import java.util.List;

public class EmbeddedDataWrapper {

    private List<EmbeddedData> embeddedDataList;

    public EmbeddedDataWrapper() {
    }

    public EmbeddedDataWrapper(List<EmbeddedData> embeddedDataList) {
        this.embeddedDataList = embeddedDataList;
    }

    public List<String> GetFeatureIdentifiers() {
        List<String> list = new ArrayList<String>();

        for (final EmbeddedData embeddedData : getEmbeddedDataList()) {
            list.add(embeddedData.getZbAddress());
        }

        return list;
    }

    public List<EmbeddedData> getEmbeddedDataList() {
        return embeddedDataList;
    }

    public void setEmbeddedDataList(List<EmbeddedData> embeddedDataList) {
        this.embeddedDataList = embeddedDataList;
    }


}
