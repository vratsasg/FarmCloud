package com.webstart.Enums;

/**
 * Created by DimDesktop on 30/1/2017.
 */
public enum MeasurementTypeEnum {
    INTERNAL_HUMIDITY(1),
    INTERNAL_TEMPERATURE(2),
    TEMPERATURE(3),
    SOIL_MOSTURE(4),
    WATER_CONSUMPTION(5);

    private final int value;

    MeasurementTypeEnum(final int newValue) {
        value = newValue;
    }

    public int getValue() {
        return value;
    }
}
