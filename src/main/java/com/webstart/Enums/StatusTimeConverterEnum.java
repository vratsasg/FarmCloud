package com.webstart.Enums;

public enum StatusTimeConverterEnum {
    TO_UTC(1),
    TO_TIMEZONE(2);

    private final int value;

    StatusTimeConverterEnum(final int newValue) {
        value = newValue;
    }

    public int getValue() {
        return value;
    }
}
