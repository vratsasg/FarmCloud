package com.webstart.Enums;

/**
 * Created by DimDesktop on 30/1/2017.
 */
public enum FeatureTypeEnum {
    CROP(1),
    STATION(2),
    END_DEVICE(3);

    private final int value;

    FeatureTypeEnum(final int newValue) {
        value = newValue;
    }

    public int getValue() {
        return value;
    }
}

