package com.webstart.Helpers;


import com.webstart.Enums.StatusTimeConverterEnum;
import org.joda.time.DateTime;
import org.joda.time.DateTimeZone;
import org.joda.time.LocalDateTime;
import org.joda.time.format.DateTimeFormatter;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.util.TimeZone;

public class HelperCls {

    private static final Logger logger =   LoggerFactory.getLogger(HelperCls.class);

    public static class ConvertToDateTime {
        public DateTime GetUTCDateTime(String dt, DateTimeFormatter dtfInput, String timezone, StatusTimeConverterEnum convertionType) {
            //TimeZone
            TimeZone tz = TimeZone.getTimeZone(timezone);
            int offset = tz.getRawOffset();
//            int offset = DateTimeZone.forID(tz.getID()).getOffset(new DateTime());
            DateTime zonedatetime = LocalDateTime.parse(dt, dtfInput).toDateTime(DateTimeZone.UTC);

            if (convertionType.getValue() == StatusTimeConverterEnum.TO_UTC.getValue()) {
                //Convert time to UTC
                zonedatetime = zonedatetime.minusMillis(offset);
            } else if (convertionType.getValue() == StatusTimeConverterEnum.TO_TIMEZONE.getValue()) {
                //Convert time to TIMEZONE
                zonedatetime = zonedatetime.plusMillis(offset);
            }

            logger.debug("params: dtBefore={}, offset={}, conversion={}, datetimeWithZone={}", dt, offset, convertionType.toString(), zonedatetime);

            return zonedatetime;
        }
    }
}
