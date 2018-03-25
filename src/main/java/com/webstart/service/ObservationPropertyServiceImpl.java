package com.webstart.service;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.webstart.DTO.*;
import com.webstart.Enums.FeatureTypeEnum;
import com.webstart.Enums.StatusTimeConverterEnum;
import com.webstart.Helpers.HelperCls;
import com.webstart.model.*;
import com.webstart.repository.FeatureofinterestJpaRepository;
import com.webstart.repository.ObservablePropertyJpaRepository;
import com.webstart.repository.ObservationJpaRepository;
import org.joda.time.DateTime;
import org.joda.time.DateTimeZone;
import org.joda.time.Instant;
import org.joda.time.format.DateTimeFormat;
import org.joda.time.format.DateTimeFormatter;
import org.joda.time.tz.UTCProvider;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.*;


@Service("observationProperyService")
@Transactional
public class ObservationPropertyServiceImpl implements ObservationProperyService {

    @Autowired
    ObservablePropertyJpaRepository observablePropertyJpaRepository;
    @Autowired
    ObservationJpaRepository observationJpaRepository;
    @Autowired
    FeatureofinterestJpaRepository featureofinterestJpaRepository;
    //
    private final Logger logger =   LoggerFactory.getLogger(HelperCls.class);

    public JSONObject getAllObsPropeties() {

        JSONObject finalobj = new JSONObject();
        JSONArray list = new JSONArray();

        List<ObservableProperty> obsPropertiesList = observablePropertyJpaRepository.findAllExceptWatering();

        for (ObservableProperty observableProperty : obsPropertiesList) {
            JSONObject obj = new JSONObject();
            obj.put("observablepropertyid", observableProperty.getObservablePropertyId());
            obj.put("description", observableProperty.getDescription());
            list.add(obj);
        }

        finalobj.put("obsprop", list);

        return finalobj;
    }

    public WateringMeasure getWateringData(int userId, String identifier, Date from, Date to) {
        WateringMeasure wateringMeasure = new WateringMeasure();

        try {
//            DateTimeZone.setDefault(DateTimeZone.UTC);
//            TimeZone.setDefault(TimeZone.getTimeZone("GMT"));
            java.sql.Timestamp timeFrom = new java.sql.Timestamp(from.getTime());
            java.sql.Timestamp timeTo = new java.sql.Timestamp(to.getTime());

            Featureofinterest featureofinterest = featureofinterestJpaRepository.getFeatureofinterestByIdentifier(identifier);
            //
            List<Object[]> listofObjs = observationJpaRepository.findWateringMeasures(userId, identifier, timeFrom, timeTo);

            if (listofObjs.size() == 0) {
                return null;
            }

            int offset =  TimeZone.getDefault().getRawOffset();

            Object[] obj = listofObjs.get(0);
            wateringMeasure.setIdentifier(String.valueOf(listofObjs.get(0)[0]));
            wateringMeasure.setObservableProperty(String.valueOf(listofObjs.get(0)[1]));
            wateringMeasure.setUnit(String.valueOf(listofObjs.get(0)[5]));
            List<WateringValueTime> ls = new ArrayList<WateringValueTime>();

            for (Object[] objValueTime : listofObjs) {
                DateTimeFormatter dtfInput = DateTimeFormat.forPattern("yyyy-MM-dd HH:mm:ss.SSSSSS");
                HelperCls.ConvertToDateTime convertable = new HelperCls.ConvertToDateTime();
                DateTime dtfrom = convertable.GetUTCDateTime(objValueTime[2].toString(), dtfInput, featureofinterest.getTimezone(), StatusTimeConverterEnum.TO_TIMEZONE);
                DateTime dtuntil = convertable.GetUTCDateTime(objValueTime[3].toString(), dtfInput, featureofinterest.getTimezone(), StatusTimeConverterEnum.TO_TIMEZONE);
                //substract the default timezone pc offset in milliseconds
                logger.debug("getWateringData() params: dtfrom={}, offset={} timestamp={}", dtfrom, offset, new Timestamp(dtfrom.getMillis() - offset));
                logger.debug("getWateringData() params: dtuntil={}, offset={} timestamp={}", dtuntil, offset, new Timestamp(dtuntil.getMillis() - offset));
                ls.add(new WateringValueTime((BigDecimal) objValueTime[4], new Timestamp(dtfrom.getMillis() - offset), new Timestamp(dtuntil.getMillis() - offset)));
            }

            wateringMeasure.setMeasuredata(ls);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }

        return wateringMeasure;
    }

    public Long getObservationsCounter(Long obspropId, int userId, String identifier, Date from, Date to) {
        return observationJpaRepository.findMeasuresCount(obspropId, userId, identifier, new java.sql.Timestamp(from.getTime()), new java.sql.Timestamp(to.getTime()));
    }

    public ObservableMeasure getObservationData(Long obspropId, int userId, String identifier, Date from, Date to) {
        ObservableMeasure obsMeasure = new ObservableMeasure();

        try {
            Featureofinterest featureofinterest = featureofinterestJpaRepository.getFeatureofinterestByIdentifier(identifier);
            //
            List<Object[]> listofObjs = observationJpaRepository.findMeasureByObsPropId(obspropId, userId, identifier, new java.sql.Timestamp(from.getTime()), new java.sql.Timestamp(to.getTime()));

            if (listofObjs.size() == 0) {
                return null;
            }

            int offset =  TimeZone.getDefault().getRawOffset();

            Object[] obj = listofObjs.get(0);
            obsMeasure.setIdentifier(String.valueOf(obj[0]));
            obsMeasure.setObservableProperty(String.valueOf(obj[1]));
            obsMeasure.setUnit(String.valueOf(obj[4]));

            List<ValueTime> ls = new ArrayList<ValueTime>();

            for (Object[] objec : listofObjs) {
                DateTimeFormatter dtfInput = DateTimeFormat.forPattern("yyyy-MM-dd HH:mm:ss.SSSSSS");
                HelperCls.ConvertToDateTime convertable = new HelperCls.ConvertToDateTime();
                DateTime dt = convertable.GetUTCDateTime(objec[2].toString(), dtfInput, featureofinterest.getTimezone(), StatusTimeConverterEnum.TO_TIMEZONE);
                Timestamp tTime = new Timestamp(dt.getMillis() - offset);
                logger.debug("getObservationData() params: datetime={}, offset={} timestamp={}", dt, offset, tTime);
                ls.add(new ValueTime(tTime.getTime()/1000L, (BigDecimal) objec[3], tTime));
            }

            obsMeasure.setMeasuredata(ls);
        } catch (Exception exc) {
            exc.printStackTrace();
            return null;
        }

        return obsMeasure;
    }

    public String getLastObservationsDate(int userId) {
        String jsonInString;

        try {
            Timestamp lastdate = observationJpaRepository.findlastdatetime(userId);
            Featureofinterest featureofinterest = featureofinterestJpaRepository.getAllByUseridAndFeatureofinteresttypeid(userId, (long) FeatureTypeEnum.STATION.getValue()).get(0);

            //TODO create a function with timestamp
            //TimeZone
            TimeZone tz = TimeZone.getTimeZone(featureofinterest.getTimezone());

            //Convert time to UTC
            int offset = DateTimeZone.forID(tz.getID()).getOffset(new DateTime());
            Calendar cal = Calendar.getInstance();

            cal.setTimeInMillis(lastdate.getTime());
            cal.add(Calendar.MILLISECOND, offset);
            lastdate = new Timestamp(cal.getTime().getTime());

            ObjectMapper mapper = new ObjectMapper();
            jsonInString = mapper.writeValueAsString(lastdate);

        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }

        return jsonInString;
    }


    public List<ObservationMeasure> getLastObservationbyIdentifier(int userId, String identifier) {
        //String jsonInString = null;
        List<ObservationMeasure> ls = new ArrayList<ObservationMeasure>();

        try {
            Featureofinterest featureofinterest = featureofinterestJpaRepository.getFeatureofinterestByIdentifier(identifier);
            //
            Timestamp lastdate = observationJpaRepository.findlastdatetime(userId, identifier);
            List<Object[]> listMeasures = observationJpaRepository.findLastMeasures(userId, identifier, lastdate);

            if (listMeasures.size() == 0) {
                return null;
            }

            ls = new ArrayList<ObservationMeasure>();
            Iterator itr = listMeasures.iterator();

            while (itr.hasNext()) {
                Object[] obj = (Object[]) itr.next();

                DateTimeFormatter dtfInput = DateTimeFormat.forPattern("yyyy-MM-dd HH:mm:ss.SSSSSS");
                HelperCls.ConvertToDateTime convertable = new HelperCls.ConvertToDateTime();
                DateTime dt = convertable.GetUTCDateTime(obj[1].toString(), dtfInput, featureofinterest.getTimezone(), StatusTimeConverterEnum.TO_TIMEZONE);
                Timestamp tTime = new Timestamp(dt.getMillis());
                ls.add(new ObservationMeasure((tTime.getTime()) / 1000L, (BigDecimal) obj[2], tTime, obj[3].toString(), obj[0].toString()));
            }

            //ObjectMapper mapper = new ObjectMapper();       //Object to JSON in String
            //jsonInString = mapper.writeValueAsString(ls);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }

        return ls;
    }

    public ResponseEntity<AutomaticWater> getLastWateringObsbyIdentifier(int userId, String identifier) {
        AutomaticWater automaticWater = null;

        try {
            Featureofinterest featureofinterest = featureofinterestJpaRepository.getFeatureofinterestByIdentifier(identifier);
            //
            Timestamp lastdate = observationJpaRepository.findWateringlastdatetime(userId, identifier);
            List<Object[]> listMeasures = observationJpaRepository.findLastWateringMeasures(userId, identifier, lastdate);

            if (listMeasures.size() == 0) {
                return new ResponseEntity("Error: Last measure cannot found", HttpStatus.INTERNAL_SERVER_ERROR);
            }

            DateTimeFormatter fmt = DateTimeFormat.forPattern("yyyy-MM-dd HH:mm:ss");

            Iterator itr = listMeasures.iterator();
            while (itr.hasNext()) {
                Object[] obj = (Object[]) itr.next();
                DateTimeFormatter dtfInput = DateTimeFormat.forPattern("yyyy-MM-dd HH:mm:ss.SSSSSS");
                HelperCls.ConvertToDateTime convertable = new HelperCls.ConvertToDateTime();
                DateTime dtfrom = convertable.GetUTCDateTime(obj[1].toString(), dtfInput, featureofinterest.getTimezone(), StatusTimeConverterEnum.TO_TIMEZONE);
                DateTime dtuntil = convertable.GetUTCDateTime(obj[2].toString(), dtfInput, featureofinterest.getTimezone(), StatusTimeConverterEnum.TO_TIMEZONE);
                automaticWater = new AutomaticWater(fmt.print(dtfrom), fmt.print(dtuntil), (BigDecimal) obj[3], identifier);
            }
        } catch (Exception e) {
            e.printStackTrace();
            return new ResponseEntity(e.getMessage(), HttpStatus.BAD_REQUEST);
        }

        return new ResponseEntity<AutomaticWater>(automaticWater, HttpStatus.OK);
    }

    public void setObservationMinmaxValues(List<FeatureMinMaxValue> observationMinmaxList) {
        try {
            for (FeatureMinMaxValue featureMinMaxValue : observationMinmaxList) {
                featureofinterestJpaRepository.setObservableMinmax(featureMinMaxValue.getObspropertyid(), featureMinMaxValue.getMinval(), featureMinMaxValue.getMaxval());
            }
        } catch (Exception exc) {

        }
    }


}


