package com.webstart.Enums;

public enum NotificationTypeEnum {
    MEASURE(0),
    IRRIGATION(1),
    ERROR(2),
    OTHER(10);

    private final int value;

    NotificationTypeEnum(final int newValue) {
        value = newValue;
    }

    public int getValue() {
        return value;
    }
}
