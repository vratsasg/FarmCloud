package com.webstart.Helpers;


import com.webstart.Enums.StatusTimeConverterEnum;
import org.joda.time.DateTime;
import org.joda.time.DateTimeZone;
import org.joda.time.LocalDateTime;
import org.joda.time.format.DateTimeFormatter;

import java.util.TimeZone;

public class HelperCls {
    public static class ConvertToDateTime {
        public DateTime GetUTCDateTime(String dt, DateTimeFormatter dtfInput, String timezone, StatusTimeConverterEnum convertionType) {
            //TimeZone
            TimeZone tz = TimeZone.getTimeZone(timezone);

            //Convert time to UTC
            int offset = DateTimeZone.forID(tz.getID()).getOffset(new DateTime());
            DateTime irrigdtFrom = LocalDateTime.parse(dt, dtfInput).toDateTime(DateTimeZone.forID(tz.getID()));

            if (convertionType.getValue() == StatusTimeConverterEnum.TO_UTC.getValue()){
                irrigdtFrom = irrigdtFrom.minusMillis(offset);
            } else if (convertionType.getValue() == StatusTimeConverterEnum.TO_TIMEZONE.getValue()){
                irrigdtFrom = irrigdtFrom.plusMillis(offset);
            }

            return irrigdtFrom;
    }
    }
}
