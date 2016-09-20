package com.webstart.DTO;

import java.util.ArrayList;
import java.util.List;

public class EmbeddedDataWrapper {

    private List<EmbeddedData> emList;

    public EmbeddedDataWrapper() {
    }

    public EmbeddedDataWrapper(List<EmbeddedData> emList) {
        this.emList = emList;
    }

    public List<String> GetFeatureIdentifiers() {
        List<String> list = new ArrayList<String>();

        for (final EmbeddedData embeddedData : getEmList()) {
            list.add(embeddedData.getZigbeeAddress());
        }

        return list;
    }

    public List<EmbeddedData> getEmList() {
        return emList;
    }

    public void setEmList(List<EmbeddedData> emList) {
        this.emList = emList;
    }


}
