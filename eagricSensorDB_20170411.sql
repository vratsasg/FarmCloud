--
-- PostgreSQL database dump
--

-- Dumped from database version 9.6.2
-- Dumped by pg_dump version 9.6.2

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: eagricsensordb; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE eagricsensordb WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'Greek_Greece.1253' LC_CTYPE = 'Greek_Greece.1253';


ALTER DATABASE eagricsensordb OWNER TO postgres;

\connect eagricsensordb

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: tiger; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA tiger;


ALTER SCHEMA tiger OWNER TO postgres;

--
-- Name: tiger_data; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA tiger_data;


ALTER SCHEMA tiger_data OWNER TO postgres;

--
-- Name: topology; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA topology;


ALTER SCHEMA topology OWNER TO postgres;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


--
-- Name: adminpack; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS adminpack WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION adminpack; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION adminpack IS 'administrative functions for PostgreSQL';


--
-- Name: fuzzystrmatch; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS fuzzystrmatch WITH SCHEMA public;


--
-- Name: EXTENSION fuzzystrmatch; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION fuzzystrmatch IS 'determine similarities and distance between strings';


--
-- Name: postgis; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS postgis WITH SCHEMA public;


--
-- Name: EXTENSION postgis; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION postgis IS 'PostGIS geometry, geography, and raster spatial types and functions';


--
-- Name: postgis_tiger_geocoder; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS postgis_tiger_geocoder WITH SCHEMA tiger;


--
-- Name: EXTENSION postgis_tiger_geocoder; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION postgis_tiger_geocoder IS 'PostGIS tiger geocoder and reverse geocoder';


--
-- Name: postgis_topology; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS postgis_topology WITH SCHEMA topology;


--
-- Name: EXTENSION postgis_topology; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION postgis_topology IS 'PostGIS topology spatial types and functions';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: enddevice; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE enddevice (
    humidity bigint,
    itemp bigint,
    wtemp bigint,
    soil integer,
    id integer NOT NULL
);


ALTER TABLE enddevice OWNER TO postgres;

--
-- Name: EndDevice_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE "EndDevice_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "EndDevice_id_seq" OWNER TO postgres;

--
-- Name: EndDevice_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE "EndDevice_id_seq" OWNED BY enddevice.id;


--
-- Name: blobvalue; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE blobvalue (
    observationid bigint NOT NULL,
    value oid
);


ALTER TABLE blobvalue OWNER TO postgres;

--
-- Name: booleanvalue; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE booleanvalue (
    observationid bigint NOT NULL,
    value character(1),
    CONSTRAINT booleanvalue_value_check CHECK ((value = ANY (ARRAY['T'::bpchar, 'F'::bpchar])))
);


ALTER TABLE booleanvalue OWNER TO postgres;

--
-- Name: categoryvalue; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE categoryvalue (
    observationid bigint NOT NULL,
    value character varying(255)
);


ALTER TABLE categoryvalue OWNER TO postgres;

--
-- Name: codespace; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE codespace (
    codespaceid bigint NOT NULL,
    codespace character varying(255) NOT NULL
);


ALTER TABLE codespace OWNER TO postgres;

--
-- Name: codespaceid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE codespaceid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE codespaceid_seq OWNER TO postgres;

--
-- Name: compositephenomenon; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE compositephenomenon (
    parentobservablepropertyid bigint NOT NULL,
    childobservablepropertyid bigint NOT NULL
);


ALTER TABLE compositephenomenon OWNER TO postgres;

--
-- Name: countvalue; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE countvalue (
    observationid bigint NOT NULL,
    value integer
);


ALTER TABLE countvalue OWNER TO postgres;

--
-- Name: featureofinterest; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE featureofinterest (
    hibernatediscriminator character(1) NOT NULL,
    featureofinteresttypeid bigint NOT NULL,
    identifier character varying(255),
    codespaceid bigint,
    name text,
    geom geometry,
    descriptionxml text,
    url character varying(255),
    featureofinterestid integer NOT NULL,
    userid integer,
    parentid integer,
    datetimefrom timestamp without time zone,
    datetimeto timestamp without time zone,
    irrigation boolean DEFAULT false,
    measuring boolean DEFAULT false,
    waterconsumption numeric(10,2)
);


ALTER TABLE featureofinterest OWNER TO postgres;

--
-- Name: featureofinterest_featureofinterestid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE featureofinterest_featureofinterestid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE featureofinterest_featureofinterestid_seq OWNER TO postgres;

--
-- Name: featureofinterest_featureofinterestid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE featureofinterest_featureofinterestid_seq OWNED BY featureofinterest.featureofinterestid;


--
-- Name: featureofinterestid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE featureofinterestid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE featureofinterestid_seq OWNER TO postgres;

--
-- Name: featureofinteresttype; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE featureofinteresttype (
    featureofinteresttypeid bigint NOT NULL,
    featureofinteresttype character varying(255) NOT NULL
);


ALTER TABLE featureofinteresttype OWNER TO postgres;

--
-- Name: featureofinteresttypeid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE featureofinteresttypeid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE featureofinteresttypeid_seq OWNER TO postgres;

--
-- Name: featurerelation; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE featurerelation (
    parentfeatureid bigint NOT NULL,
    childfeatureid bigint NOT NULL
);


ALTER TABLE featurerelation OWNER TO postgres;

--
-- Name: geometryvalue; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE geometryvalue (
    observationid bigint NOT NULL,
    value geometry
);


ALTER TABLE geometryvalue OWNER TO postgres;

--
-- Name: hasfeatures; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE hasfeatures (
    user_id integer NOT NULL,
    featureofinterestid integer NOT NULL
);


ALTER TABLE hasfeatures OWNER TO postgres;

--
-- Name: notifications_notifid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE notifications_notifid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE notifications_notifid_seq OWNER TO postgres;

--
-- Name: notifications; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE notifications (
    notificationid integer DEFAULT nextval('notifications_notifid_seq'::regclass) NOT NULL,
    userid integer,
    isreaded boolean,
    description character varying,
    datecreated timestamp without time zone
);


ALTER TABLE notifications OWNER TO postgres;

--
-- Name: numericvalue; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE numericvalue (
    observationid bigint NOT NULL,
    value numeric(19,2)
);


ALTER TABLE numericvalue OWNER TO postgres;

--
-- Name: observableproperty; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE observableproperty (
    observablepropertyid bigint NOT NULL,
    hibernatediscriminator character(1) NOT NULL,
    identifier character varying(255) NOT NULL,
    description character varying(255)
);


ALTER TABLE observableproperty OWNER TO postgres;

--
-- Name: observablepropertyid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE observablepropertyid_seq
    START WITH 21
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE observablepropertyid_seq OWNER TO postgres;

--
-- Name: observablepropertyminmax; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE observablepropertyminmax (
    obspropertyid bigint NOT NULL,
    featureofinterestid bigint NOT NULL,
    observablepropertyid bigint NOT NULL,
    minval numeric,
    maxval numeric
);


ALTER TABLE observablepropertyminmax OWNER TO postgres;

--
-- Name: observationid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE observationid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE observationid_seq OWNER TO postgres;

--
-- Name: observation; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE observation (
    observationid bigint DEFAULT nextval('observationid_seq'::regclass) NOT NULL,
    seriesid bigint NOT NULL,
    phenomenontimestart timestamp without time zone NOT NULL,
    phenomenontimeend timestamp without time zone NOT NULL,
    resulttime timestamp without time zone NOT NULL,
    validtimestart timestamp without time zone,
    validtimeend timestamp without time zone,
    deleted character(1) DEFAULT 'F'::bpchar NOT NULL,
    identifier character varying(255),
    codespaceid bigint,
    description character varying(255),
    unitid bigint,
    CONSTRAINT observation_deleted_check CHECK ((deleted = ANY (ARRAY['T'::bpchar, 'F'::bpchar])))
);


ALTER TABLE observation OWNER TO postgres;

--
-- Name: observationconstellation; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE observationconstellation (
    observationconstellationid bigint NOT NULL,
    observablepropertyid bigint NOT NULL,
    procedureid bigint NOT NULL,
    observationtypeid bigint,
    offeringid bigint NOT NULL,
    deleted character(1) DEFAULT 'F'::bpchar NOT NULL,
    hiddenchild character(1) DEFAULT 'F'::bpchar NOT NULL,
    CONSTRAINT observationconstellation_deleted_check CHECK ((deleted = ANY (ARRAY['T'::bpchar, 'F'::bpchar]))),
    CONSTRAINT observationconstellation_hiddenchild_check CHECK ((hiddenchild = ANY (ARRAY['T'::bpchar, 'F'::bpchar])))
);


ALTER TABLE observationconstellation OWNER TO postgres;

--
-- Name: observationconstellationid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE observationconstellationid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE observationconstellationid_seq OWNER TO postgres;

--
-- Name: observationhasoffering; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE observationhasoffering (
    observationid bigint NOT NULL,
    offeringid bigint NOT NULL
);


ALTER TABLE observationhasoffering OWNER TO postgres;

--
-- Name: observationtype; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE observationtype (
    observationtypeid bigint NOT NULL,
    observationtype character varying(255) NOT NULL
);


ALTER TABLE observationtype OWNER TO postgres;

--
-- Name: observationtypeid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE observationtypeid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE observationtypeid_seq OWNER TO postgres;

--
-- Name: offering; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE offering (
    offeringid bigint NOT NULL,
    hibernatediscriminator character(1) NOT NULL,
    identifier character varying(255) NOT NULL,
    name character varying(255)
);


ALTER TABLE offering OWNER TO postgres;

--
-- Name: offeringallowedfeaturetype; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE offeringallowedfeaturetype (
    offeringid bigint NOT NULL,
    featureofinteresttypeid bigint NOT NULL
);


ALTER TABLE offeringallowedfeaturetype OWNER TO postgres;

--
-- Name: offeringallowedobservationtype; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE offeringallowedobservationtype (
    offeringid bigint NOT NULL,
    observationtypeid bigint NOT NULL
);


ALTER TABLE offeringallowedobservationtype OWNER TO postgres;

--
-- Name: offeringhasrelatedfeature; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE offeringhasrelatedfeature (
    relatedfeatureid bigint NOT NULL,
    offeringid bigint NOT NULL
);


ALTER TABLE offeringhasrelatedfeature OWNER TO postgres;

--
-- Name: offeringid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE offeringid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE offeringid_seq OWNER TO postgres;

--
-- Name: parameter; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE parameter (
    parameterid bigint NOT NULL,
    observationid bigint NOT NULL,
    definition character varying(255) NOT NULL,
    title character varying(255),
    value oid NOT NULL
);


ALTER TABLE parameter OWNER TO postgres;

--
-- Name: parameterid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE parameterid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE parameterid_seq OWNER TO postgres;

--
-- Name: procdescformatid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE procdescformatid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE procdescformatid_seq OWNER TO postgres;

--
-- Name: procedure; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE procedure (
    procedureid bigint NOT NULL,
    hibernatediscriminator character(1) NOT NULL,
    proceduredescriptionformatid bigint NOT NULL,
    identifier character varying(255) NOT NULL,
    deleted character(1) DEFAULT 'F'::bpchar NOT NULL,
    descriptionfile text,
    CONSTRAINT procedure_deleted_check CHECK ((deleted = ANY (ARRAY['T'::bpchar, 'F'::bpchar])))
);


ALTER TABLE procedure OWNER TO postgres;

--
-- Name: proceduredescriptionformat; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE proceduredescriptionformat (
    proceduredescriptionformatid bigint NOT NULL,
    proceduredescriptionformat character varying(255) NOT NULL
);


ALTER TABLE proceduredescriptionformat OWNER TO postgres;

--
-- Name: procedureid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE procedureid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE procedureid_seq OWNER TO postgres;

--
-- Name: relatedfeature; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE relatedfeature (
    relatedfeatureid bigint NOT NULL,
    featureofinterestid bigint NOT NULL
);


ALTER TABLE relatedfeature OWNER TO postgres;

--
-- Name: relatedfeaturehasrole; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE relatedfeaturehasrole (
    relatedfeatureid bigint NOT NULL,
    relatedfeatureroleid bigint NOT NULL
);


ALTER TABLE relatedfeaturehasrole OWNER TO postgres;

--
-- Name: relatedfeatureid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE relatedfeatureid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE relatedfeatureid_seq OWNER TO postgres;

--
-- Name: relatedfeaturerole; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE relatedfeaturerole (
    relatedfeatureroleid bigint NOT NULL,
    relatedfeaturerole character varying(255) NOT NULL
);


ALTER TABLE relatedfeaturerole OWNER TO postgres;

--
-- Name: relatedfeatureroleid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE relatedfeatureroleid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE relatedfeatureroleid_seq OWNER TO postgres;

--
-- Name: resulttemplate; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE resulttemplate (
    resulttemplateid bigint NOT NULL,
    offeringid bigint NOT NULL,
    observablepropertyid bigint NOT NULL,
    procedureid bigint NOT NULL,
    featureofinterestid bigint NOT NULL,
    identifier character varying(255) NOT NULL,
    resultstructure text NOT NULL,
    resultencoding text NOT NULL
);


ALTER TABLE resulttemplate OWNER TO postgres;

--
-- Name: resulttemplateid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE resulttemplateid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE resulttemplateid_seq OWNER TO postgres;

--
-- Name: sensorsystem; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE sensorsystem (
    parentsensorid bigint NOT NULL,
    childsensorid bigint NOT NULL
);


ALTER TABLE sensorsystem OWNER TO postgres;

--
-- Name: seriesid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE seriesid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE seriesid_seq OWNER TO postgres;

--
-- Name: series; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE series (
    seriesid bigint DEFAULT nextval('seriesid_seq'::regclass) NOT NULL,
    featureofinterestid bigint NOT NULL,
    observablepropertyid bigint NOT NULL,
    procedureid bigint NOT NULL,
    deleted character(1) DEFAULT 'F'::bpchar NOT NULL,
    CONSTRAINT series_deleted_check CHECK ((deleted = ANY (ARRAY['T'::bpchar, 'F'::bpchar])))
);


ALTER TABLE series OWNER TO postgres;

--
-- Name: spatialfilteringprofile; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE spatialfilteringprofile (
    spatialfilteringprofileid bigint NOT NULL,
    observation bigint NOT NULL,
    definition character varying(255) NOT NULL,
    title character varying(255),
    geom geometry NOT NULL
);


ALTER TABLE spatialfilteringprofile OWNER TO postgres;

--
-- Name: spatialfilteringprofileid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE spatialfilteringprofileid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE spatialfilteringprofileid_seq OWNER TO postgres;

--
-- Name: swedataarrayvalue; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE swedataarrayvalue (
    observationid bigint NOT NULL,
    value text
);


ALTER TABLE swedataarrayvalue OWNER TO postgres;

--
-- Name: textvalue; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE textvalue (
    observationid bigint NOT NULL,
    value text
);


ALTER TABLE textvalue OWNER TO postgres;

--
-- Name: unit; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE unit (
    unitid bigint NOT NULL,
    unit character varying(255) NOT NULL
);


ALTER TABLE unit OWNER TO postgres;

--
-- Name: unitid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE unitid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE unitid_seq OWNER TO postgres;

--
-- Name: user_role; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE user_role (
    user_role_id bigint NOT NULL,
    name character varying(20),
    description character varying(80)
);


ALTER TABLE user_role OWNER TO postgres;

--
-- Name: userprofile; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE userprofile (
    user_id integer NOT NULL,
    firstname character varying(20) NOT NULL,
    lastname character varying(20) NOT NULL,
    fathersname character varying(20) NOT NULL,
    dateofbirth date,
    address character varying(50),
    addressnum character varying(10),
    zipcode character varying(10),
    telephone character varying(15),
    mobile character varying(15)
);


ALTER TABLE userprofile OWNER TO postgres;

--
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE users (
    username character varying(20),
    password character varying(20),
    email character varying(30),
    user_role_id bigint,
    user_id integer NOT NULL
);


ALTER TABLE users OWNER TO postgres;

--
-- Name: users_user_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE users_user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE users_user_id_seq OWNER TO postgres;

--
-- Name: users_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE users_user_id_seq OWNED BY users.user_id;


--
-- Name: uthbaldata_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE uthbaldata_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE uthbaldata_seq OWNER TO postgres;

--
-- Name: validproceduretime; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE validproceduretime (
    validproceduretimeid bigint NOT NULL,
    procedureid bigint NOT NULL,
    proceduredescriptionformatid bigint NOT NULL,
    starttime timestamp without time zone NOT NULL,
    endtime timestamp without time zone,
    descriptionxml text NOT NULL
);


ALTER TABLE validproceduretime OWNER TO postgres;

--
-- Name: validproceduretimeid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE validproceduretimeid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE validproceduretimeid_seq OWNER TO postgres;

--
-- Name: enddevice id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY enddevice ALTER COLUMN id SET DEFAULT nextval('"EndDevice_id_seq"'::regclass);


--
-- Name: featureofinterest featureofinterestid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY featureofinterest ALTER COLUMN featureofinterestid SET DEFAULT nextval('featureofinterest_featureofinterestid_seq'::regclass);


--
-- Name: users user_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY users ALTER COLUMN user_id SET DEFAULT nextval('users_user_id_seq'::regclass);


--
-- Name: EndDevice_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"EndDevice_id_seq"', 5, true);


--
-- Data for Name: blobvalue; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: booleanvalue; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: categoryvalue; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: codespace; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Name: codespaceid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('codespaceid_seq', 1, false);


--
-- Data for Name: compositephenomenon; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: countvalue; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: enddevice; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO enddevice (humidity, itemp, wtemp, soil, id) VALUES (50, 40, 30, 20, 4);
INSERT INTO enddevice (humidity, itemp, wtemp, soil, id) VALUES (2, 3, 4, 5, 5);


--
-- Data for Name: featureofinterest; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO featureofinterest (hibernatediscriminator, featureofinteresttypeid, identifier, codespaceid, name, geom, descriptionxml, url, featureofinterestid, userid, parentid, datetimefrom, datetimeto, irrigation, measuring, waterconsumption) VALUES ('N', 1, 'Main Crop', NULL, 'Crop with olives', NULL, NULL, NULL, 1, 1, NULL, NULL, NULL, false, false, NULL);
INSERT INTO featureofinterest (hibernatediscriminator, featureofinteresttypeid, identifier, codespaceid, name, geom, descriptionxml, url, featureofinterestid, userid, parentid, datetimefrom, datetimeto, irrigation, measuring, waterconsumption) VALUES ('N', 3, '40D6A2CF', NULL, 'North end device', NULL, NULL, NULL, 5, 1, 2, '2016-12-14 21:07:00', '2016-12-14 21:09:00', false, false, NULL);
INSERT INTO featureofinterest (hibernatediscriminator, featureofinteresttypeid, identifier, codespaceid, name, geom, descriptionxml, url, featureofinterestid, userid, parentid, datetimefrom, datetimeto, irrigation, measuring, waterconsumption) VALUES ('N', 3, '40E7CC39', NULL, 'West end device', NULL, NULL, NULL, 3, 1, 2, '2016-12-14 21:08:00', '2016-12-14 21:10:00', false, false, NULL);
INSERT INTO featureofinterest (hibernatediscriminator, featureofinteresttypeid, identifier, codespaceid, name, geom, descriptionxml, url, featureofinterestid, userid, parentid, datetimefrom, datetimeto, irrigation, measuring, waterconsumption) VALUES ('N', 3, '40D6A2C9', NULL, 'East end device', NULL, NULL, NULL, 4, 1, 2, '2016-12-14 21:09:00', '2016-12-14 21:11:00', false, false, NULL);
INSERT INTO featureofinterest (hibernatediscriminator, featureofinteresttypeid, identifier, codespaceid, name, geom, descriptionxml, url, featureofinterestid, userid, parentid, datetimefrom, datetimeto, irrigation, measuring, waterconsumption) VALUES ('N', 2, '40E7CC41', NULL, 'Base station', '0101000020E610000033333333337337403D0AD7A3703D4340', NULL, NULL, 2, 1, 1, '1970-01-01 23:00:00', '1970-01-01 05:20:00', false, false, 500.00);


--
-- Name: featureofinterest_featureofinterestid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('featureofinterest_featureofinterestid_seq', 1, true);


--
-- Name: featureofinterestid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('featureofinterestid_seq', 1, false);


--
-- Data for Name: featureofinteresttype; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO featureofinteresttype (featureofinteresttypeid, featureofinteresttype) VALUES (1, 'Crop');
INSERT INTO featureofinteresttype (featureofinteresttypeid, featureofinteresttype) VALUES (2, 'Station');
INSERT INTO featureofinteresttype (featureofinteresttypeid, featureofinteresttype) VALUES (3, 'End Device');


--
-- Name: featureofinteresttypeid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('featureofinteresttypeid_seq', 1, false);


--
-- Data for Name: featurerelation; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO featurerelation (parentfeatureid, childfeatureid) VALUES (1, 2);
INSERT INTO featurerelation (parentfeatureid, childfeatureid) VALUES (2, 3);
INSERT INTO featurerelation (parentfeatureid, childfeatureid) VALUES (2, 4);
INSERT INTO featurerelation (parentfeatureid, childfeatureid) VALUES (2, 5);


--
-- Data for Name: geometryvalue; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: hasfeatures; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO hasfeatures (user_id, featureofinterestid) VALUES (1, 1);
INSERT INTO hasfeatures (user_id, featureofinterestid) VALUES (1, 2);
INSERT INTO hasfeatures (user_id, featureofinterestid) VALUES (1, 3);
INSERT INTO hasfeatures (user_id, featureofinterestid) VALUES (1, 4);
INSERT INTO hasfeatures (user_id, featureofinterestid) VALUES (1, 5);


--
-- Data for Name: notifications; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Name: notifications_notifid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('notifications_notifid_seq', 1, false);


--
-- Data for Name: numericvalue; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO numericvalue (observationid, value) VALUES (5, 28.00);
INSERT INTO numericvalue (observationid, value) VALUES (6, 30.00);
INSERT INTO numericvalue (observationid, value) VALUES (7, 32.00);
INSERT INTO numericvalue (observationid, value) VALUES (8, 32.00);
INSERT INTO numericvalue (observationid, value) VALUES (21, 60.00);
INSERT INTO numericvalue (observationid, value) VALUES (22, 59.00);
INSERT INTO numericvalue (observationid, value) VALUES (23, 55.00);
INSERT INTO numericvalue (observationid, value) VALUES (24, 52.00);
INSERT INTO numericvalue (observationid, value) VALUES (2155880, 42.10);
INSERT INTO numericvalue (observationid, value) VALUES (2155881, 30.40);
INSERT INTO numericvalue (observationid, value) VALUES (2155882, 20.51);
INSERT INTO numericvalue (observationid, value) VALUES (2155883, 1023.00);
INSERT INTO numericvalue (observationid, value) VALUES (2155884, 42.10);
INSERT INTO numericvalue (observationid, value) VALUES (2155885, 30.30);
INSERT INTO numericvalue (observationid, value) VALUES (2155886, 328.61);
INSERT INTO numericvalue (observationid, value) VALUES (2155887, 1023.00);
INSERT INTO numericvalue (observationid, value) VALUES (2155888, 44.50);
INSERT INTO numericvalue (observationid, value) VALUES (2155889, 30.30);
INSERT INTO numericvalue (observationid, value) VALUES (2155890, 28.81);
INSERT INTO numericvalue (observationid, value) VALUES (2155891, 1023.00);
INSERT INTO numericvalue (observationid, value) VALUES (2155892, 29.80);
INSERT INTO numericvalue (observationid, value) VALUES (2155893, 28.60);
INSERT INTO numericvalue (observationid, value) VALUES (2155894, 20.51);
INSERT INTO numericvalue (observationid, value) VALUES (2155895, 1023.00);
INSERT INTO numericvalue (observationid, value) VALUES (2155896, 30.70);
INSERT INTO numericvalue (observationid, value) VALUES (2155897, 28.50);
INSERT INTO numericvalue (observationid, value) VALUES (2155898, 27.83);
INSERT INTO numericvalue (observationid, value) VALUES (2155899, 1023.00);
INSERT INTO numericvalue (observationid, value) VALUES (2155900, 32.60);
INSERT INTO numericvalue (observationid, value) VALUES (2155901, 28.70);
INSERT INTO numericvalue (observationid, value) VALUES (2155902, 29.30);
INSERT INTO numericvalue (observationid, value) VALUES (2155903, 1021.00);
INSERT INTO numericvalue (observationid, value) VALUES (2155904, 29.90);
INSERT INTO numericvalue (observationid, value) VALUES (2155905, 28.60);
INSERT INTO numericvalue (observationid, value) VALUES (2155906, 18.55);
INSERT INTO numericvalue (observationid, value) VALUES (2155907, 1023.00);
INSERT INTO numericvalue (observationid, value) VALUES (2155908, 30.70);
INSERT INTO numericvalue (observationid, value) VALUES (2155909, 28.40);
INSERT INTO numericvalue (observationid, value) VALUES (2155910, 27.83);
INSERT INTO numericvalue (observationid, value) VALUES (2155911, 1023.00);
INSERT INTO numericvalue (observationid, value) VALUES (2155912, 32.50);
INSERT INTO numericvalue (observationid, value) VALUES (3, 23.93);
INSERT INTO numericvalue (observationid, value) VALUES (4, 1023.00);
INSERT INTO numericvalue (observationid, value) VALUES (9, 35.80);
INSERT INTO numericvalue (observationid, value) VALUES (10, 30.00);
INSERT INTO numericvalue (observationid, value) VALUES (11, 43.95);
INSERT INTO numericvalue (observationid, value) VALUES (12, 1022.00);
INSERT INTO numericvalue (observationid, value) VALUES (13, 0.00);
INSERT INTO numericvalue (observationid, value) VALUES (15, 0.00);
INSERT INTO numericvalue (observationid, value) VALUES (16, 0.00);
INSERT INTO numericvalue (observationid, value) VALUES (17, 34.00);
INSERT INTO numericvalue (observationid, value) VALUES (18, 30.30);
INSERT INTO numericvalue (observationid, value) VALUES (19, 23.44);
INSERT INTO numericvalue (observationid, value) VALUES (20, 1023.00);
INSERT INTO numericvalue (observationid, value) VALUES (25, 36.40);
INSERT INTO numericvalue (observationid, value) VALUES (26, 29.00);
INSERT INTO numericvalue (observationid, value) VALUES (27, 22.95);
INSERT INTO numericvalue (observationid, value) VALUES (28, 1023.00);
INSERT INTO numericvalue (observationid, value) VALUES (30, 29.20);
INSERT INTO numericvalue (observationid, value) VALUES (31, 28.32);
INSERT INTO numericvalue (observationid, value) VALUES (32, 1023.00);
INSERT INTO numericvalue (observationid, value) VALUES (33, 38.10);
INSERT INTO numericvalue (observationid, value) VALUES (34, 29.50);
INSERT INTO numericvalue (observationid, value) VALUES (35, 27.34);
INSERT INTO numericvalue (observationid, value) VALUES (36, 1022.00);
INSERT INTO numericvalue (observationid, value) VALUES (37, 36.30);
INSERT INTO numericvalue (observationid, value) VALUES (38, 29.00);
INSERT INTO numericvalue (observationid, value) VALUES (39, 24.41);
INSERT INTO numericvalue (observationid, value) VALUES (41, 36.20);
INSERT INTO numericvalue (observationid, value) VALUES (42, 29.20);
INSERT INTO numericvalue (observationid, value) VALUES (43, 28.32);
INSERT INTO numericvalue (observationid, value) VALUES (44, 1023.00);
INSERT INTO numericvalue (observationid, value) VALUES (45, 37.90);
INSERT INTO numericvalue (observationid, value) VALUES (46, 29.50);
INSERT INTO numericvalue (observationid, value) VALUES (47, 27.34);
INSERT INTO numericvalue (observationid, value) VALUES (48, 1022.00);
INSERT INTO numericvalue (observationid, value) VALUES (49, 36.30);
INSERT INTO numericvalue (observationid, value) VALUES (50, 29.00);
INSERT INTO numericvalue (observationid, value) VALUES (52, 1023.00);
INSERT INTO numericvalue (observationid, value) VALUES (53, 36.20);
INSERT INTO numericvalue (observationid, value) VALUES (54, 29.20);
INSERT INTO numericvalue (observationid, value) VALUES (55, 28.32);
INSERT INTO numericvalue (observationid, value) VALUES (56, 1023.00);
INSERT INTO numericvalue (observationid, value) VALUES (57, 37.90);
INSERT INTO numericvalue (observationid, value) VALUES (58, 29.40);
INSERT INTO numericvalue (observationid, value) VALUES (59, 27.34);
INSERT INTO numericvalue (observationid, value) VALUES (60, 1023.00);
INSERT INTO numericvalue (observationid, value) VALUES (61, 34.30);
INSERT INTO numericvalue (observationid, value) VALUES (63, 26.37);
INSERT INTO numericvalue (observationid, value) VALUES (64, 1023.00);
INSERT INTO numericvalue (observationid, value) VALUES (65, 34.20);
INSERT INTO numericvalue (observationid, value) VALUES (66, 29.00);
INSERT INTO numericvalue (observationid, value) VALUES (67, 28.32);
INSERT INTO numericvalue (observationid, value) VALUES (68, 1023.00);
INSERT INTO numericvalue (observationid, value) VALUES (69, 36.30);
INSERT INTO numericvalue (observationid, value) VALUES (70, 29.00);
INSERT INTO numericvalue (observationid, value) VALUES (71, 26.86);
INSERT INTO numericvalue (observationid, value) VALUES (72, 1022.00);
INSERT INTO numericvalue (observationid, value) VALUES (74, 28.70);
INSERT INTO numericvalue (observationid, value) VALUES (75, 28.32);
INSERT INTO numericvalue (observationid, value) VALUES (76, 1023.00);
INSERT INTO numericvalue (observationid, value) VALUES (77, 33.90);
INSERT INTO numericvalue (observationid, value) VALUES (78, 29.10);
INSERT INTO numericvalue (observationid, value) VALUES (79, 28.32);
INSERT INTO numericvalue (observationid, value) VALUES (80, 1023.00);
INSERT INTO numericvalue (observationid, value) VALUES (81, 36.00);
INSERT INTO numericvalue (observationid, value) VALUES (82, 29.00);
INSERT INTO numericvalue (observationid, value) VALUES (83, 26.86);
INSERT INTO numericvalue (observationid, value) VALUES (85, 33.50);
INSERT INTO numericvalue (observationid, value) VALUES (86, 28.60);
INSERT INTO numericvalue (observationid, value) VALUES (87, 28.81);
INSERT INTO numericvalue (observationid, value) VALUES (88, 1023.00);
INSERT INTO numericvalue (observationid, value) VALUES (89, 33.10);
INSERT INTO numericvalue (observationid, value) VALUES (90, 29.10);
INSERT INTO numericvalue (observationid, value) VALUES (91, 28.32);
INSERT INTO numericvalue (observationid, value) VALUES (92, 1023.00);
INSERT INTO numericvalue (observationid, value) VALUES (93, 35.20);
INSERT INTO numericvalue (observationid, value) VALUES (94, 29.00);
INSERT INTO numericvalue (observationid, value) VALUES (96, 1023.00);
INSERT INTO numericvalue (observationid, value) VALUES (97, 33.40);
INSERT INTO numericvalue (observationid, value) VALUES (98, 28.60);
INSERT INTO numericvalue (observationid, value) VALUES (99, 28.81);
INSERT INTO numericvalue (observationid, value) VALUES (100, 1023.00);
INSERT INTO numericvalue (observationid, value) VALUES (101, 32.90);
INSERT INTO numericvalue (observationid, value) VALUES (115, 28.32);
INSERT INTO numericvalue (observationid, value) VALUES (116, 1023.00);
INSERT INTO numericvalue (observationid, value) VALUES (117, 35.00);
INSERT INTO numericvalue (observationid, value) VALUES (118, 29.10);
INSERT INTO numericvalue (observationid, value) VALUES (120, 1023.00);
INSERT INTO numericvalue (observationid, value) VALUES (121, 33.10);
INSERT INTO numericvalue (observationid, value) VALUES (122, 28.60);
INSERT INTO numericvalue (observationid, value) VALUES (123, 29.79);
INSERT INTO numericvalue (observationid, value) VALUES (124, 1023.00);
INSERT INTO numericvalue (observationid, value) VALUES (125, 32.60);
INSERT INTO numericvalue (observationid, value) VALUES (126, 29.10);
INSERT INTO numericvalue (observationid, value) VALUES (127, 28.32);
INSERT INTO numericvalue (observationid, value) VALUES (128, 1023.00);
INSERT INTO numericvalue (observationid, value) VALUES (129, 34.60);
INSERT INTO numericvalue (observationid, value) VALUES (131, 26.86);
INSERT INTO numericvalue (observationid, value) VALUES (132, 1023.00);
INSERT INTO numericvalue (observationid, value) VALUES (133, 33.10);
INSERT INTO numericvalue (observationid, value) VALUES (134, 28.60);
INSERT INTO numericvalue (observationid, value) VALUES (135, 30.27);
INSERT INTO numericvalue (observationid, value) VALUES (136, 1023.00);
INSERT INTO numericvalue (observationid, value) VALUES (137, 32.50);
INSERT INTO numericvalue (observationid, value) VALUES (138, 29.10);
INSERT INTO numericvalue (observationid, value) VALUES (139, 28.32);
INSERT INTO numericvalue (observationid, value) VALUES (2155913, 28.50);
INSERT INTO numericvalue (observationid, value) VALUES (2155914, 29.30);
INSERT INTO numericvalue (observationid, value) VALUES (2155915, 1023.00);
INSERT INTO numericvalue (observationid, value) VALUES (2155916, 37.50);
INSERT INTO numericvalue (observationid, value) VALUES (2155917, 28.60);
INSERT INTO numericvalue (observationid, value) VALUES (2155918, 20.02);
INSERT INTO numericvalue (observationid, value) VALUES (2155919, 1023.00);
INSERT INTO numericvalue (observationid, value) VALUES (2155920, 37.90);
INSERT INTO numericvalue (observationid, value) VALUES (2155921, 28.40);
INSERT INTO numericvalue (observationid, value) VALUES (2155922, 34.67);
INSERT INTO numericvalue (observationid, value) VALUES (2155923, 1023.00);
INSERT INTO numericvalue (observationid, value) VALUES (2155924, 39.80);
INSERT INTO numericvalue (observationid, value) VALUES (2155925, 28.50);
INSERT INTO numericvalue (observationid, value) VALUES (2155926, 30.27);
INSERT INTO numericvalue (observationid, value) VALUES (2155927, 1022.00);
INSERT INTO numericvalue (observationid, value) VALUES (2155928, 31.80);
INSERT INTO numericvalue (observationid, value) VALUES (2155929, 29.50);
INSERT INTO numericvalue (observationid, value) VALUES (2155930, 23.44);
INSERT INTO numericvalue (observationid, value) VALUES (2155931, 1023.00);
INSERT INTO numericvalue (observationid, value) VALUES (2155932, 32.80);
INSERT INTO numericvalue (observationid, value) VALUES (2155933, 29.30);
INSERT INTO numericvalue (observationid, value) VALUES (2155934, 42.97);
INSERT INTO numericvalue (observationid, value) VALUES (2155935, 1023.00);
INSERT INTO numericvalue (observationid, value) VALUES (2155936, 34.50);
INSERT INTO numericvalue (observationid, value) VALUES (2155937, 29.50);
INSERT INTO numericvalue (observationid, value) VALUES (2155938, 36.62);
INSERT INTO numericvalue (observationid, value) VALUES (2155939, 1022.00);
INSERT INTO numericvalue (observationid, value) VALUES (2155940, 30.00);
INSERT INTO numericvalue (observationid, value) VALUES (2155941, 29.70);
INSERT INTO numericvalue (observationid, value) VALUES (2155942, 22.95);
INSERT INTO numericvalue (observationid, value) VALUES (2155943, 1023.00);
INSERT INTO numericvalue (observationid, value) VALUES (2155944, 29.00);
INSERT INTO numericvalue (observationid, value) VALUES (2155945, 29.70);
INSERT INTO numericvalue (observationid, value) VALUES (2155946, 23.44);
INSERT INTO numericvalue (observationid, value) VALUES (2155947, 1023.00);
INSERT INTO numericvalue (observationid, value) VALUES (1, 31.80);
INSERT INTO numericvalue (observationid, value) VALUES (2, 30.00);
INSERT INTO numericvalue (observationid, value) VALUES (14, 0.00);
INSERT INTO numericvalue (observationid, value) VALUES (29, 36.10);
INSERT INTO numericvalue (observationid, value) VALUES (40, 1023.00);
INSERT INTO numericvalue (observationid, value) VALUES (51, 26.86);
INSERT INTO numericvalue (observationid, value) VALUES (62, 28.80);
INSERT INTO numericvalue (observationid, value) VALUES (73, 34.10);
INSERT INTO numericvalue (observationid, value) VALUES (84, 1023.00);
INSERT INTO numericvalue (observationid, value) VALUES (95, 26.86);
INSERT INTO numericvalue (observationid, value) VALUES (102, 29.10);
INSERT INTO numericvalue (observationid, value) VALUES (103, 28.32);
INSERT INTO numericvalue (observationid, value) VALUES (104, 1023.00);
INSERT INTO numericvalue (observationid, value) VALUES (105, 35.00);
INSERT INTO numericvalue (observationid, value) VALUES (106, 29.10);
INSERT INTO numericvalue (observationid, value) VALUES (107, 26.86);
INSERT INTO numericvalue (observationid, value) VALUES (108, 1023.00);
INSERT INTO numericvalue (observationid, value) VALUES (109, 33.40);
INSERT INTO numericvalue (observationid, value) VALUES (110, 28.60);
INSERT INTO numericvalue (observationid, value) VALUES (111, 29.30);
INSERT INTO numericvalue (observationid, value) VALUES (112, 1023.00);
INSERT INTO numericvalue (observationid, value) VALUES (113, 32.80);
INSERT INTO numericvalue (observationid, value) VALUES (114, 29.10);
INSERT INTO numericvalue (observationid, value) VALUES (119, 27.34);
INSERT INTO numericvalue (observationid, value) VALUES (130, 29.10);
INSERT INTO numericvalue (observationid, value) VALUES (140, 1023.00);
INSERT INTO numericvalue (observationid, value) VALUES (141, 34.40);
INSERT INTO numericvalue (observationid, value) VALUES (142, 29.00);
INSERT INTO numericvalue (observationid, value) VALUES (143, 27.34);
INSERT INTO numericvalue (observationid, value) VALUES (144, 1023.00);
INSERT INTO numericvalue (observationid, value) VALUES (145, 32.90);
INSERT INTO numericvalue (observationid, value) VALUES (146, 28.60);
INSERT INTO numericvalue (observationid, value) VALUES (147, 31.25);
INSERT INTO numericvalue (observationid, value) VALUES (148, 1023.00);
INSERT INTO numericvalue (observationid, value) VALUES (149, 32.20);
INSERT INTO numericvalue (observationid, value) VALUES (150, 29.10);
INSERT INTO numericvalue (observationid, value) VALUES (151, 28.32);
INSERT INTO numericvalue (observationid, value) VALUES (152, 1023.00);
INSERT INTO numericvalue (observationid, value) VALUES (153, 34.20);
INSERT INTO numericvalue (observationid, value) VALUES (154, 29.10);
INSERT INTO numericvalue (observationid, value) VALUES (155, 26.86);
INSERT INTO numericvalue (observationid, value) VALUES (156, 1023.00);
INSERT INTO numericvalue (observationid, value) VALUES (157, 32.50);
INSERT INTO numericvalue (observationid, value) VALUES (158, 28.50);
INSERT INTO numericvalue (observationid, value) VALUES (159, 32.71);
INSERT INTO numericvalue (observationid, value) VALUES (160, 1023.00);
INSERT INTO numericvalue (observationid, value) VALUES (161, 31.70);
INSERT INTO numericvalue (observationid, value) VALUES (162, 29.00);
INSERT INTO numericvalue (observationid, value) VALUES (163, 27.83);
INSERT INTO numericvalue (observationid, value) VALUES (164, 1023.00);
INSERT INTO numericvalue (observationid, value) VALUES (165, 33.80);
INSERT INTO numericvalue (observationid, value) VALUES (166, 29.10);
INSERT INTO numericvalue (observationid, value) VALUES (167, 26.86);
INSERT INTO numericvalue (observationid, value) VALUES (168, 1023.00);
INSERT INTO numericvalue (observationid, value) VALUES (169, 32.00);
INSERT INTO numericvalue (observationid, value) VALUES (170, 28.50);
INSERT INTO numericvalue (observationid, value) VALUES (171, 34.67);
INSERT INTO numericvalue (observationid, value) VALUES (172, 1023.00);
INSERT INTO numericvalue (observationid, value) VALUES (173, 31.10);
INSERT INTO numericvalue (observationid, value) VALUES (174, 29.00);
INSERT INTO numericvalue (observationid, value) VALUES (175, 27.83);
INSERT INTO numericvalue (observationid, value) VALUES (176, 1023.00);
INSERT INTO numericvalue (observationid, value) VALUES (177, 33.30);
INSERT INTO numericvalue (observationid, value) VALUES (178, 29.00);
INSERT INTO numericvalue (observationid, value) VALUES (179, 26.86);
INSERT INTO numericvalue (observationid, value) VALUES (180, 1023.00);
INSERT INTO numericvalue (observationid, value) VALUES (181, 31.80);
INSERT INTO numericvalue (observationid, value) VALUES (182, 28.40);
INSERT INTO numericvalue (observationid, value) VALUES (183, 35.16);
INSERT INTO numericvalue (observationid, value) VALUES (184, 1023.00);
INSERT INTO numericvalue (observationid, value) VALUES (185, 31.00);
INSERT INTO numericvalue (observationid, value) VALUES (186, 29.00);
INSERT INTO numericvalue (observationid, value) VALUES (187, 27.83);
INSERT INTO numericvalue (observationid, value) VALUES (188, 1023.00);
INSERT INTO numericvalue (observationid, value) VALUES (189, 32.90);
INSERT INTO numericvalue (observationid, value) VALUES (190, 29.00);
INSERT INTO numericvalue (observationid, value) VALUES (191, 26.86);
INSERT INTO numericvalue (observationid, value) VALUES (192, 1023.00);
INSERT INTO numericvalue (observationid, value) VALUES (193, 31.60);
INSERT INTO numericvalue (observationid, value) VALUES (194, 28.40);
INSERT INTO numericvalue (observationid, value) VALUES (195, 35.64);
INSERT INTO numericvalue (observationid, value) VALUES (196, 1023.00);
INSERT INTO numericvalue (observationid, value) VALUES (197, 30.70);
INSERT INTO numericvalue (observationid, value) VALUES (198, 28.90);
INSERT INTO numericvalue (observationid, value) VALUES (199, 27.83);
INSERT INTO numericvalue (observationid, value) VALUES (200, 1023.00);
INSERT INTO numericvalue (observationid, value) VALUES (201, 32.90);
INSERT INTO numericvalue (observationid, value) VALUES (202, 29.00);
INSERT INTO numericvalue (observationid, value) VALUES (203, 26.86);
INSERT INTO numericvalue (observationid, value) VALUES (204, 1023.00);
INSERT INTO numericvalue (observationid, value) VALUES (205, 33.00);
INSERT INTO numericvalue (observationid, value) VALUES (206, 29.30);
INSERT INTO numericvalue (observationid, value) VALUES (207, 294.43);
INSERT INTO numericvalue (observationid, value) VALUES (208, 980.00);
INSERT INTO numericvalue (observationid, value) VALUES (209, 34.00);
INSERT INTO numericvalue (observationid, value) VALUES (210, 29.40);
INSERT INTO numericvalue (observationid, value) VALUES (211, 235.35);
INSERT INTO numericvalue (observationid, value) VALUES (212, 980.00);
INSERT INTO numericvalue (observationid, value) VALUES (213, 35.80);
INSERT INTO numericvalue (observationid, value) VALUES (214, 29.10);
INSERT INTO numericvalue (observationid, value) VALUES (215, 19.53);
INSERT INTO numericvalue (observationid, value) VALUES (216, 997.00);
INSERT INTO numericvalue (observationid, value) VALUES (217, 38.60);
INSERT INTO numericvalue (observationid, value) VALUES (218, 28.90);
INSERT INTO numericvalue (observationid, value) VALUES (219, 27.83);
INSERT INTO numericvalue (observationid, value) VALUES (220, 993.00);
INSERT INTO numericvalue (observationid, value) VALUES (221, 34.90);
INSERT INTO numericvalue (observationid, value) VALUES (222, 29.50);
INSERT INTO numericvalue (observationid, value) VALUES (223, 27.83);
INSERT INTO numericvalue (observationid, value) VALUES (224, 980.00);
INSERT INTO numericvalue (observationid, value) VALUES (225, 47.00);
INSERT INTO numericvalue (observationid, value) VALUES (226, 29.50);
INSERT INTO numericvalue (observationid, value) VALUES (227, 21.00);
INSERT INTO numericvalue (observationid, value) VALUES (228, 4.00);
INSERT INTO numericvalue (observationid, value) VALUES (229, 48.70);
INSERT INTO numericvalue (observationid, value) VALUES (230, 29.60);
INSERT INTO numericvalue (observationid, value) VALUES (231, 28.81);
INSERT INTO numericvalue (observationid, value) VALUES (232, 5.00);
INSERT INTO numericvalue (observationid, value) VALUES (233, 45.00);
INSERT INTO numericvalue (observationid, value) VALUES (234, 30.00);
INSERT INTO numericvalue (observationid, value) VALUES (235, 28.81);
INSERT INTO numericvalue (observationid, value) VALUES (236, 6.00);
INSERT INTO numericvalue (observationid, value) VALUES (237, 6.00);
INSERT INTO numericvalue (observationid, value) VALUES (249, 46.90);
INSERT INTO numericvalue (observationid, value) VALUES (250, 29.60);
INSERT INTO numericvalue (observationid, value) VALUES (251, 21.00);
INSERT INTO numericvalue (observationid, value) VALUES (252, 4.00);
INSERT INTO numericvalue (observationid, value) VALUES (253, 48.80);
INSERT INTO numericvalue (observationid, value) VALUES (254, 29.50);
INSERT INTO numericvalue (observationid, value) VALUES (255, 28.32);
INSERT INTO numericvalue (observationid, value) VALUES (256, 4.00);
INSERT INTO numericvalue (observationid, value) VALUES (257, 44.80);
INSERT INTO numericvalue (observationid, value) VALUES (258, 30.00);
INSERT INTO numericvalue (observationid, value) VALUES (259, 28.81);
INSERT INTO numericvalue (observationid, value) VALUES (260, 6.00);
INSERT INTO numericvalue (observationid, value) VALUES (261, 46.90);
INSERT INTO numericvalue (observationid, value) VALUES (262, 29.60);
INSERT INTO numericvalue (observationid, value) VALUES (263, 21.48);
INSERT INTO numericvalue (observationid, value) VALUES (264, 4.00);
INSERT INTO numericvalue (observationid, value) VALUES (265, 49.00);
INSERT INTO numericvalue (observationid, value) VALUES (266, 29.60);
INSERT INTO numericvalue (observationid, value) VALUES (267, 27.83);
INSERT INTO numericvalue (observationid, value) VALUES (268, 5.00);
INSERT INTO numericvalue (observationid, value) VALUES (269, 44.70);
INSERT INTO numericvalue (observationid, value) VALUES (270, 30.00);
INSERT INTO numericvalue (observationid, value) VALUES (271, 28.81);
INSERT INTO numericvalue (observationid, value) VALUES (272, 6.00);
INSERT INTO numericvalue (observationid, value) VALUES (273, 48.10);
INSERT INTO numericvalue (observationid, value) VALUES (274, 29.70);
INSERT INTO numericvalue (observationid, value) VALUES (275, 21.48);
INSERT INTO numericvalue (observationid, value) VALUES (276, 4.00);
INSERT INTO numericvalue (observationid, value) VALUES (277, 50.40);
INSERT INTO numericvalue (observationid, value) VALUES (278, 29.60);
INSERT INTO numericvalue (observationid, value) VALUES (279, 30.27);
INSERT INTO numericvalue (observationid, value) VALUES (280, 5.00);
INSERT INTO numericvalue (observationid, value) VALUES (281, 45.90);
INSERT INTO numericvalue (observationid, value) VALUES (282, 30.20);
INSERT INTO numericvalue (observationid, value) VALUES (283, 28.81);
INSERT INTO numericvalue (observationid, value) VALUES (284, 6.00);
INSERT INTO numericvalue (observationid, value) VALUES (285, 48.30);
INSERT INTO numericvalue (observationid, value) VALUES (286, 29.70);
INSERT INTO numericvalue (observationid, value) VALUES (287, 21.48);
INSERT INTO numericvalue (observationid, value) VALUES (288, 4.00);
INSERT INTO numericvalue (observationid, value) VALUES (289, 50.60);
INSERT INTO numericvalue (observationid, value) VALUES (290, 29.60);
INSERT INTO numericvalue (observationid, value) VALUES (291, 29.30);
INSERT INTO numericvalue (observationid, value) VALUES (292, 5.00);
INSERT INTO numericvalue (observationid, value) VALUES (293, 46.00);
INSERT INTO numericvalue (observationid, value) VALUES (294, 30.20);
INSERT INTO numericvalue (observationid, value) VALUES (295, 28.81);
INSERT INTO numericvalue (observationid, value) VALUES (296, 7.00);
INSERT INTO numericvalue (observationid, value) VALUES (297, 45.20);
INSERT INTO numericvalue (observationid, value) VALUES (298, 29.30);
INSERT INTO numericvalue (observationid, value) VALUES (299, 21.00);
INSERT INTO numericvalue (observationid, value) VALUES (300, 4.00);
INSERT INTO numericvalue (observationid, value) VALUES (301, 47.40);
INSERT INTO numericvalue (observationid, value) VALUES (302, 29.20);
INSERT INTO numericvalue (observationid, value) VALUES (303, 29.79);
INSERT INTO numericvalue (observationid, value) VALUES (304, 5.00);
INSERT INTO numericvalue (observationid, value) VALUES (305, 42.90);
INSERT INTO numericvalue (observationid, value) VALUES (306, 29.90);
INSERT INTO numericvalue (observationid, value) VALUES (307, 28.32);
INSERT INTO numericvalue (observationid, value) VALUES (308, 6.00);
INSERT INTO numericvalue (observationid, value) VALUES (321, 44.50);
INSERT INTO numericvalue (observationid, value) VALUES (322, 29.30);
INSERT INTO numericvalue (observationid, value) VALUES (323, 21.48);
INSERT INTO numericvalue (observationid, value) VALUES (324, 4.00);
INSERT INTO numericvalue (observationid, value) VALUES (325, 46.80);
INSERT INTO numericvalue (observationid, value) VALUES (326, 29.20);
INSERT INTO numericvalue (observationid, value) VALUES (327, 29.79);
INSERT INTO numericvalue (observationid, value) VALUES (328, 5.00);
INSERT INTO numericvalue (observationid, value) VALUES (329, 42.20);
INSERT INTO numericvalue (observationid, value) VALUES (330, 29.90);
INSERT INTO numericvalue (observationid, value) VALUES (331, 29.30);
INSERT INTO numericvalue (observationid, value) VALUES (332, 6.00);
INSERT INTO numericvalue (observationid, value) VALUES (333, 28.30);
INSERT INTO numericvalue (observationid, value) VALUES (334, 25.90);
INSERT INTO numericvalue (observationid, value) VALUES (335, 17.09);
INSERT INTO numericvalue (observationid, value) VALUES (336, 4.00);
INSERT INTO numericvalue (observationid, value) VALUES (337, 30.60);
INSERT INTO numericvalue (observationid, value) VALUES (338, 25.90);
INSERT INTO numericvalue (observationid, value) VALUES (339, 26.86);
INSERT INTO numericvalue (observationid, value) VALUES (340, 5.00);
INSERT INTO numericvalue (observationid, value) VALUES (341, 28.10);
INSERT INTO numericvalue (observationid, value) VALUES (342, 26.50);
INSERT INTO numericvalue (observationid, value) VALUES (343, 75.20);
INSERT INTO numericvalue (observationid, value) VALUES (344, 6.00);
INSERT INTO numericvalue (observationid, value) VALUES (345, 28.00);
INSERT INTO numericvalue (observationid, value) VALUES (346, 25.90);
INSERT INTO numericvalue (observationid, value) VALUES (347, 17.09);
INSERT INTO numericvalue (observationid, value) VALUES (348, 4.00);
INSERT INTO numericvalue (observationid, value) VALUES (349, 30.40);
INSERT INTO numericvalue (observationid, value) VALUES (350, 25.80);
INSERT INTO numericvalue (observationid, value) VALUES (351, 26.86);
INSERT INTO numericvalue (observationid, value) VALUES (352, 5.00);
INSERT INTO numericvalue (observationid, value) VALUES (353, 28.20);
INSERT INTO numericvalue (observationid, value) VALUES (354, 26.60);
INSERT INTO numericvalue (observationid, value) VALUES (355, 79.59);
INSERT INTO numericvalue (observationid, value) VALUES (356, 7.00);
INSERT INTO numericvalue (observationid, value) VALUES (357, 28.10);
INSERT INTO numericvalue (observationid, value) VALUES (358, 26.00);
INSERT INTO numericvalue (observationid, value) VALUES (359, 17.09);
INSERT INTO numericvalue (observationid, value) VALUES (360, 4.00);
INSERT INTO numericvalue (observationid, value) VALUES (361, 30.80);
INSERT INTO numericvalue (observationid, value) VALUES (362, 25.90);
INSERT INTO numericvalue (observationid, value) VALUES (363, 26.86);
INSERT INTO numericvalue (observationid, value) VALUES (364, 5.00);
INSERT INTO numericvalue (observationid, value) VALUES (365, 28.10);
INSERT INTO numericvalue (observationid, value) VALUES (366, 26.70);
INSERT INTO numericvalue (observationid, value) VALUES (367, 81.05);
INSERT INTO numericvalue (observationid, value) VALUES (368, 7.00);
INSERT INTO numericvalue (observationid, value) VALUES (373, 30.30);
INSERT INTO numericvalue (observationid, value) VALUES (374, 25.90);
INSERT INTO numericvalue (observationid, value) VALUES (375, 26.86);
INSERT INTO numericvalue (observationid, value) VALUES (376, 5.00);
INSERT INTO numericvalue (observationid, value) VALUES (377, 27.90);
INSERT INTO numericvalue (observationid, value) VALUES (378, 26.60);
INSERT INTO numericvalue (observationid, value) VALUES (379, 83.01);
INSERT INTO numericvalue (observationid, value) VALUES (380, 7.00);
INSERT INTO numericvalue (observationid, value) VALUES (381, 27.90);
INSERT INTO numericvalue (observationid, value) VALUES (382, 26.60);
INSERT INTO numericvalue (observationid, value) VALUES (383, 83.01);
INSERT INTO numericvalue (observationid, value) VALUES (384, 7.00);
INSERT INTO numericvalue (observationid, value) VALUES (389, 28.20);
INSERT INTO numericvalue (observationid, value) VALUES (390, 26.60);
INSERT INTO numericvalue (observationid, value) VALUES (391, 79.59);
INSERT INTO numericvalue (observationid, value) VALUES (392, 7.00);
INSERT INTO numericvalue (observationid, value) VALUES (393, 28.20);
INSERT INTO numericvalue (observationid, value) VALUES (394, 26.60);
INSERT INTO numericvalue (observationid, value) VALUES (395, 79.59);
INSERT INTO numericvalue (observationid, value) VALUES (396, 7.00);
INSERT INTO numericvalue (observationid, value) VALUES (397, 30.50);
INSERT INTO numericvalue (observationid, value) VALUES (398, 25.90);
INSERT INTO numericvalue (observationid, value) VALUES (399, 26.86);
INSERT INTO numericvalue (observationid, value) VALUES (400, 5.00);
INSERT INTO numericvalue (observationid, value) VALUES (401, 28.10);
INSERT INTO numericvalue (observationid, value) VALUES (402, 26.60);
INSERT INTO numericvalue (observationid, value) VALUES (403, 81.54);
INSERT INTO numericvalue (observationid, value) VALUES (404, 7.00);
INSERT INTO numericvalue (observationid, value) VALUES (409, 30.60);
INSERT INTO numericvalue (observationid, value) VALUES (410, 25.90);
INSERT INTO numericvalue (observationid, value) VALUES (411, 27.34);
INSERT INTO numericvalue (observationid, value) VALUES (412, 5.00);
INSERT INTO numericvalue (observationid, value) VALUES (413, 28.20);
INSERT INTO numericvalue (observationid, value) VALUES (414, 26.60);
INSERT INTO numericvalue (observationid, value) VALUES (415, 83.50);
INSERT INTO numericvalue (observationid, value) VALUES (416, 7.00);
INSERT INTO numericvalue (observationid, value) VALUES (417, 28.20);
INSERT INTO numericvalue (observationid, value) VALUES (418, 26.60);
INSERT INTO numericvalue (observationid, value) VALUES (419, 83.50);
INSERT INTO numericvalue (observationid, value) VALUES (420, 7.00);
INSERT INTO numericvalue (observationid, value) VALUES (425, 28.20);
INSERT INTO numericvalue (observationid, value) VALUES (426, 26.60);
INSERT INTO numericvalue (observationid, value) VALUES (427, 81.05);
INSERT INTO numericvalue (observationid, value) VALUES (428, 7.00);
INSERT INTO numericvalue (observationid, value) VALUES (429, 28.20);
INSERT INTO numericvalue (observationid, value) VALUES (430, 26.60);
INSERT INTO numericvalue (observationid, value) VALUES (431, 81.05);
INSERT INTO numericvalue (observationid, value) VALUES (432, 7.00);
INSERT INTO numericvalue (observationid, value) VALUES (433, 30.60);
INSERT INTO numericvalue (observationid, value) VALUES (434, 25.90);
INSERT INTO numericvalue (observationid, value) VALUES (435, 27.34);
INSERT INTO numericvalue (observationid, value) VALUES (436, 5.00);
INSERT INTO numericvalue (observationid, value) VALUES (441, 28.10);
INSERT INTO numericvalue (observationid, value) VALUES (442, 26.60);
INSERT INTO numericvalue (observationid, value) VALUES (443, 83.98);
INSERT INTO numericvalue (observationid, value) VALUES (444, 7.00);
INSERT INTO numericvalue (observationid, value) VALUES (445, 31.00);
INSERT INTO numericvalue (observationid, value) VALUES (446, 25.90);
INSERT INTO numericvalue (observationid, value) VALUES (447, 27.34);
INSERT INTO numericvalue (observationid, value) VALUES (448, 5.00);
INSERT INTO numericvalue (observationid, value) VALUES (449, 28.40);
INSERT INTO numericvalue (observationid, value) VALUES (450, 26.60);
INSERT INTO numericvalue (observationid, value) VALUES (451, 81.54);
INSERT INTO numericvalue (observationid, value) VALUES (452, 7.00);
INSERT INTO numericvalue (observationid, value) VALUES (457, 30.60);
INSERT INTO numericvalue (observationid, value) VALUES (458, 25.90);
INSERT INTO numericvalue (observationid, value) VALUES (459, 27.34);
INSERT INTO numericvalue (observationid, value) VALUES (460, 5.00);
INSERT INTO numericvalue (observationid, value) VALUES (461, 28.10);
INSERT INTO numericvalue (observationid, value) VALUES (462, 26.60);
INSERT INTO numericvalue (observationid, value) VALUES (463, 81.05);
INSERT INTO numericvalue (observationid, value) VALUES (464, 7.00);
INSERT INTO numericvalue (observationid, value) VALUES (465, 0.00);
INSERT INTO numericvalue (observationid, value) VALUES (466, 0.00);
INSERT INTO numericvalue (observationid, value) VALUES (467, 0.00);
INSERT INTO numericvalue (observationid, value) VALUES (468, 135.00);
INSERT INTO numericvalue (observationid, value) VALUES (469, 30.70);
INSERT INTO numericvalue (observationid, value) VALUES (470, 25.90);
INSERT INTO numericvalue (observationid, value) VALUES (471, 27.34);
INSERT INTO numericvalue (observationid, value) VALUES (472, 5.00);
INSERT INTO numericvalue (observationid, value) VALUES (473, 28.20);
INSERT INTO numericvalue (observationid, value) VALUES (474, 26.60);
INSERT INTO numericvalue (observationid, value) VALUES (475, 82.03);
INSERT INTO numericvalue (observationid, value) VALUES (476, 7.00);
INSERT INTO numericvalue (observationid, value) VALUES (477, 0.00);
INSERT INTO numericvalue (observationid, value) VALUES (478, 0.00);
INSERT INTO numericvalue (observationid, value) VALUES (479, 0.00);
INSERT INTO numericvalue (observationid, value) VALUES (480, 135.00);
INSERT INTO numericvalue (observationid, value) VALUES (481, 31.30);
INSERT INTO numericvalue (observationid, value) VALUES (482, 25.90);
INSERT INTO numericvalue (observationid, value) VALUES (483, 27.34);
INSERT INTO numericvalue (observationid, value) VALUES (484, 5.00);
INSERT INTO numericvalue (observationid, value) VALUES (485, 28.40);
INSERT INTO numericvalue (observationid, value) VALUES (486, 26.50);
INSERT INTO numericvalue (observationid, value) VALUES (487, 325.68);
INSERT INTO numericvalue (observationid, value) VALUES (488, 6.00);
INSERT INTO numericvalue (observationid, value) VALUES (489, 28.40);
INSERT INTO numericvalue (observationid, value) VALUES (490, 26.50);
INSERT INTO numericvalue (observationid, value) VALUES (491, 325.68);
INSERT INTO numericvalue (observationid, value) VALUES (492, 6.00);
INSERT INTO numericvalue (observationid, value) VALUES (493, 30.90);
INSERT INTO numericvalue (observationid, value) VALUES (494, 25.90);
INSERT INTO numericvalue (observationid, value) VALUES (495, 27.34);
INSERT INTO numericvalue (observationid, value) VALUES (496, 5.00);
INSERT INTO numericvalue (observationid, value) VALUES (497, 28.20);
INSERT INTO numericvalue (observationid, value) VALUES (498, 26.50);
INSERT INTO numericvalue (observationid, value) VALUES (499, 325.20);
INSERT INTO numericvalue (observationid, value) VALUES (500, 6.00);
INSERT INTO numericvalue (observationid, value) VALUES (505, 31.00);
INSERT INTO numericvalue (observationid, value) VALUES (506, 25.90);
INSERT INTO numericvalue (observationid, value) VALUES (507, 27.83);
INSERT INTO numericvalue (observationid, value) VALUES (508, 5.00);
INSERT INTO numericvalue (observationid, value) VALUES (509, 28.20);
INSERT INTO numericvalue (observationid, value) VALUES (510, 26.50);
INSERT INTO numericvalue (observationid, value) VALUES (511, 324.71);
INSERT INTO numericvalue (observationid, value) VALUES (512, 6.00);
INSERT INTO numericvalue (observationid, value) VALUES (513, 28.20);
INSERT INTO numericvalue (observationid, value) VALUES (514, 26.50);
INSERT INTO numericvalue (observationid, value) VALUES (515, 324.71);
INSERT INTO numericvalue (observationid, value) VALUES (516, 6.00);
INSERT INTO numericvalue (observationid, value) VALUES (517, 31.20);
INSERT INTO numericvalue (observationid, value) VALUES (518, 25.90);
INSERT INTO numericvalue (observationid, value) VALUES (519, 27.83);
INSERT INTO numericvalue (observationid, value) VALUES (520, 5.00);
INSERT INTO numericvalue (observationid, value) VALUES (521, 28.30);
INSERT INTO numericvalue (observationid, value) VALUES (522, 26.50);
INSERT INTO numericvalue (observationid, value) VALUES (523, 323.73);
INSERT INTO numericvalue (observationid, value) VALUES (524, 6.00);
INSERT INTO numericvalue (observationid, value) VALUES (529, 31.30);
INSERT INTO numericvalue (observationid, value) VALUES (530, 25.90);
INSERT INTO numericvalue (observationid, value) VALUES (531, 27.83);
INSERT INTO numericvalue (observationid, value) VALUES (532, 5.00);
INSERT INTO numericvalue (observationid, value) VALUES (533, 28.40);
INSERT INTO numericvalue (observationid, value) VALUES (534, 26.60);
INSERT INTO numericvalue (observationid, value) VALUES (535, 323.73);
INSERT INTO numericvalue (observationid, value) VALUES (536, 6.00);
INSERT INTO numericvalue (observationid, value) VALUES (537, 28.40);
INSERT INTO numericvalue (observationid, value) VALUES (538, 26.60);
INSERT INTO numericvalue (observationid, value) VALUES (539, 323.73);
INSERT INTO numericvalue (observationid, value) VALUES (540, 6.00);
INSERT INTO numericvalue (observationid, value) VALUES (545, 28.40);
INSERT INTO numericvalue (observationid, value) VALUES (546, 26.60);
INSERT INTO numericvalue (observationid, value) VALUES (547, 322.75);
INSERT INTO numericvalue (observationid, value) VALUES (548, 6.00);
INSERT INTO numericvalue (observationid, value) VALUES (549, 28.40);
INSERT INTO numericvalue (observationid, value) VALUES (550, 26.60);
INSERT INTO numericvalue (observationid, value) VALUES (551, 322.75);
INSERT INTO numericvalue (observationid, value) VALUES (552, 6.00);
INSERT INTO numericvalue (observationid, value) VALUES (553, 31.20);
INSERT INTO numericvalue (observationid, value) VALUES (554, 26.00);
INSERT INTO numericvalue (observationid, value) VALUES (555, 27.83);
INSERT INTO numericvalue (observationid, value) VALUES (556, 5.00);
INSERT INTO numericvalue (observationid, value) VALUES (561, 0.00);
INSERT INTO numericvalue (observationid, value) VALUES (562, 0.00);
INSERT INTO numericvalue (observationid, value) VALUES (563, 0.00);
INSERT INTO numericvalue (observationid, value) VALUES (564, 135.00);
INSERT INTO numericvalue (observationid, value) VALUES (565, 30.90);
INSERT INTO numericvalue (observationid, value) VALUES (566, 25.90);
INSERT INTO numericvalue (observationid, value) VALUES (567, 27.83);
INSERT INTO numericvalue (observationid, value) VALUES (568, 5.00);
INSERT INTO numericvalue (observationid, value) VALUES (569, 28.00);
INSERT INTO numericvalue (observationid, value) VALUES (570, 26.60);
INSERT INTO numericvalue (observationid, value) VALUES (571, 323.73);
INSERT INTO numericvalue (observationid, value) VALUES (572, 6.00);
INSERT INTO numericvalue (observationid, value) VALUES (573, 28.00);
INSERT INTO numericvalue (observationid, value) VALUES (574, 26.60);
INSERT INTO numericvalue (observationid, value) VALUES (575, 323.73);
INSERT INTO numericvalue (observationid, value) VALUES (576, 6.00);
INSERT INTO numericvalue (observationid, value) VALUES (577, 30.10);
INSERT INTO numericvalue (observationid, value) VALUES (578, 25.80);
INSERT INTO numericvalue (observationid, value) VALUES (579, 27.83);
INSERT INTO numericvalue (observationid, value) VALUES (580, 5.00);
INSERT INTO numericvalue (observationid, value) VALUES (581, 27.70);
INSERT INTO numericvalue (observationid, value) VALUES (582, 26.50);
INSERT INTO numericvalue (observationid, value) VALUES (583, 324.22);
INSERT INTO numericvalue (observationid, value) VALUES (584, 6.00);
INSERT INTO numericvalue (observationid, value) VALUES (589, 30.10);
INSERT INTO numericvalue (observationid, value) VALUES (590, 25.90);
INSERT INTO numericvalue (observationid, value) VALUES (591, 27.83);
INSERT INTO numericvalue (observationid, value) VALUES (592, 5.00);
INSERT INTO numericvalue (observationid, value) VALUES (593, 27.70);
INSERT INTO numericvalue (observationid, value) VALUES (594, 26.50);
INSERT INTO numericvalue (observationid, value) VALUES (595, 323.73);
INSERT INTO numericvalue (observationid, value) VALUES (596, 6.00);
INSERT INTO numericvalue (observationid, value) VALUES (597, 0.00);
INSERT INTO numericvalue (observationid, value) VALUES (598, 0.00);
INSERT INTO numericvalue (observationid, value) VALUES (599, 0.00);
INSERT INTO numericvalue (observationid, value) VALUES (600, 135.00);
INSERT INTO numericvalue (observationid, value) VALUES (601, 30.60);
INSERT INTO numericvalue (observationid, value) VALUES (602, 25.90);
INSERT INTO numericvalue (observationid, value) VALUES (603, 27.83);
INSERT INTO numericvalue (observationid, value) VALUES (604, 5.00);
INSERT INTO numericvalue (observationid, value) VALUES (605, 28.00);
INSERT INTO numericvalue (observationid, value) VALUES (606, 26.50);
INSERT INTO numericvalue (observationid, value) VALUES (607, 323.73);
INSERT INTO numericvalue (observationid, value) VALUES (608, 6.00);
INSERT INTO numericvalue (observationid, value) VALUES (609, 28.00);
INSERT INTO numericvalue (observationid, value) VALUES (610, 26.50);
INSERT INTO numericvalue (observationid, value) VALUES (611, 323.73);
INSERT INTO numericvalue (observationid, value) VALUES (612, 6.00);
INSERT INTO numericvalue (observationid, value) VALUES (613, 31.30);
INSERT INTO numericvalue (observationid, value) VALUES (614, 25.90);
INSERT INTO numericvalue (observationid, value) VALUES (615, 27.83);
INSERT INTO numericvalue (observationid, value) VALUES (616, 5.00);
INSERT INTO numericvalue (observationid, value) VALUES (617, 28.30);
INSERT INTO numericvalue (observationid, value) VALUES (618, 26.50);
INSERT INTO numericvalue (observationid, value) VALUES (619, 323.24);
INSERT INTO numericvalue (observationid, value) VALUES (620, 6.00);
INSERT INTO numericvalue (observationid, value) VALUES (625, 31.00);
INSERT INTO numericvalue (observationid, value) VALUES (626, 25.90);
INSERT INTO numericvalue (observationid, value) VALUES (627, 27.83);
INSERT INTO numericvalue (observationid, value) VALUES (628, 5.00);
INSERT INTO numericvalue (observationid, value) VALUES (629, 28.40);
INSERT INTO numericvalue (observationid, value) VALUES (630, 26.60);
INSERT INTO numericvalue (observationid, value) VALUES (631, 322.75);
INSERT INTO numericvalue (observationid, value) VALUES (632, 6.00);
INSERT INTO numericvalue (observationid, value) VALUES (633, 0.00);
INSERT INTO numericvalue (observationid, value) VALUES (634, 0.00);
INSERT INTO numericvalue (observationid, value) VALUES (635, 0.00);
INSERT INTO numericvalue (observationid, value) VALUES (636, 135.00);
INSERT INTO numericvalue (observationid, value) VALUES (637, 31.10);
INSERT INTO numericvalue (observationid, value) VALUES (638, 26.00);
INSERT INTO numericvalue (observationid, value) VALUES (639, 28.32);
INSERT INTO numericvalue (observationid, value) VALUES (640, 5.00);
INSERT INTO numericvalue (observationid, value) VALUES (641, 28.20);
INSERT INTO numericvalue (observationid, value) VALUES (642, 26.60);
INSERT INTO numericvalue (observationid, value) VALUES (643, 323.73);
INSERT INTO numericvalue (observationid, value) VALUES (644, 6.00);
INSERT INTO numericvalue (observationid, value) VALUES (645, 0.00);
INSERT INTO numericvalue (observationid, value) VALUES (646, 0.00);
INSERT INTO numericvalue (observationid, value) VALUES (647, 0.00);
INSERT INTO numericvalue (observationid, value) VALUES (648, 135.00);
INSERT INTO numericvalue (observationid, value) VALUES (649, 30.70);
INSERT INTO numericvalue (observationid, value) VALUES (650, 25.90);
INSERT INTO numericvalue (observationid, value) VALUES (651, 28.32);
INSERT INTO numericvalue (observationid, value) VALUES (652, 5.00);
INSERT INTO numericvalue (observationid, value) VALUES (653, 27.80);
INSERT INTO numericvalue (observationid, value) VALUES (654, 26.60);
INSERT INTO numericvalue (observationid, value) VALUES (655, 323.73);
INSERT INTO numericvalue (observationid, value) VALUES (656, 6.00);
INSERT INTO numericvalue (observationid, value) VALUES (657, 27.80);
INSERT INTO numericvalue (observationid, value) VALUES (658, 26.60);
INSERT INTO numericvalue (observationid, value) VALUES (659, 323.73);
INSERT INTO numericvalue (observationid, value) VALUES (660, 6.00);
INSERT INTO numericvalue (observationid, value) VALUES (661, 29.90);
INSERT INTO numericvalue (observationid, value) VALUES (662, 25.90);
INSERT INTO numericvalue (observationid, value) VALUES (663, 28.32);
INSERT INTO numericvalue (observationid, value) VALUES (664, 5.00);
INSERT INTO numericvalue (observationid, value) VALUES (665, 27.20);
INSERT INTO numericvalue (observationid, value) VALUES (666, 26.60);
INSERT INTO numericvalue (observationid, value) VALUES (667, 325.20);
INSERT INTO numericvalue (observationid, value) VALUES (668, 6.00);
INSERT INTO numericvalue (observationid, value) VALUES (669, 27.20);
INSERT INTO numericvalue (observationid, value) VALUES (670, 26.60);
INSERT INTO numericvalue (observationid, value) VALUES (671, 325.20);
INSERT INTO numericvalue (observationid, value) VALUES (672, 6.00);
INSERT INTO numericvalue (observationid, value) VALUES (673, 29.70);
INSERT INTO numericvalue (observationid, value) VALUES (674, 25.90);
INSERT INTO numericvalue (observationid, value) VALUES (675, 28.32);
INSERT INTO numericvalue (observationid, value) VALUES (676, 5.00);
INSERT INTO numericvalue (observationid, value) VALUES (677, 26.90);
INSERT INTO numericvalue (observationid, value) VALUES (678, 26.50);
INSERT INTO numericvalue (observationid, value) VALUES (679, 324.71);
INSERT INTO numericvalue (observationid, value) VALUES (680, 6.00);
INSERT INTO numericvalue (observationid, value) VALUES (681, 26.90);
INSERT INTO numericvalue (observationid, value) VALUES (682, 26.50);
INSERT INTO numericvalue (observationid, value) VALUES (683, 324.71);
INSERT INTO numericvalue (observationid, value) VALUES (684, 6.00);
INSERT INTO numericvalue (observationid, value) VALUES (685, 29.80);
INSERT INTO numericvalue (observationid, value) VALUES (686, 25.80);
INSERT INTO numericvalue (observationid, value) VALUES (687, 28.32);
INSERT INTO numericvalue (observationid, value) VALUES (688, 5.00);
INSERT INTO numericvalue (observationid, value) VALUES (689, 27.00);
INSERT INTO numericvalue (observationid, value) VALUES (690, 26.50);
INSERT INTO numericvalue (observationid, value) VALUES (691, 323.24);
INSERT INTO numericvalue (observationid, value) VALUES (692, 6.00);
INSERT INTO numericvalue (observationid, value) VALUES (693, 27.00);
INSERT INTO numericvalue (observationid, value) VALUES (694, 26.50);
INSERT INTO numericvalue (observationid, value) VALUES (695, 323.24);
INSERT INTO numericvalue (observationid, value) VALUES (696, 6.00);
INSERT INTO numericvalue (observationid, value) VALUES (697, 30.00);
INSERT INTO numericvalue (observationid, value) VALUES (698, 25.80);
INSERT INTO numericvalue (observationid, value) VALUES (699, 28.32);
INSERT INTO numericvalue (observationid, value) VALUES (700, 5.00);
INSERT INTO numericvalue (observationid, value) VALUES (701, 27.30);
INSERT INTO numericvalue (observationid, value) VALUES (702, 26.50);
INSERT INTO numericvalue (observationid, value) VALUES (703, 325.20);
INSERT INTO numericvalue (observationid, value) VALUES (704, 6.00);
INSERT INTO numericvalue (observationid, value) VALUES (705, 28.30);
INSERT INTO numericvalue (observationid, value) VALUES (706, 25.80);
INSERT INTO numericvalue (observationid, value) VALUES (707, 16.60);
INSERT INTO numericvalue (observationid, value) VALUES (708, 4.00);
INSERT INTO numericvalue (observationid, value) VALUES (709, 31.00);
INSERT INTO numericvalue (observationid, value) VALUES (710, 25.70);
INSERT INTO numericvalue (observationid, value) VALUES (711, 28.81);
INSERT INTO numericvalue (observationid, value) VALUES (712, 5.00);
INSERT INTO numericvalue (observationid, value) VALUES (713, 27.90);
INSERT INTO numericvalue (observationid, value) VALUES (714, 26.60);
INSERT INTO numericvalue (observationid, value) VALUES (715, 43.95);
INSERT INTO numericvalue (observationid, value) VALUES (716, 6.00);
INSERT INTO numericvalue (observationid, value) VALUES (717, 583.33);
INSERT INTO numericvalue (observationid, value) VALUES (718, 16.67);
INSERT INTO numericvalue (observationid, value) VALUES (719, 16.67);
INSERT INTO numericvalue (observationid, value) VALUES (720, 25.00);
INSERT INTO numericvalue (observationid, value) VALUES (721, 16.67);
INSERT INTO numericvalue (observationid, value) VALUES (722, 16.67);
INSERT INTO numericvalue (observationid, value) VALUES (723, 8.33);
INSERT INTO numericvalue (observationid, value) VALUES (724, 8.33);
INSERT INTO numericvalue (observationid, value) VALUES (725, 16.67);
INSERT INTO numericvalue (observationid, value) VALUES (726, 8.33);
INSERT INTO numericvalue (observationid, value) VALUES (728, 49.10);
INSERT INTO numericvalue (observationid, value) VALUES (729, 22.40);
INSERT INTO numericvalue (observationid, value) VALUES (730, 12.70);
INSERT INTO numericvalue (observationid, value) VALUES (731, 5.00);
INSERT INTO numericvalue (observationid, value) VALUES (732, 50.70);
INSERT INTO numericvalue (observationid, value) VALUES (733, 22.70);
INSERT INTO numericvalue (observationid, value) VALUES (734, 24.41);
INSERT INTO numericvalue (observationid, value) VALUES (735, 5.00);
INSERT INTO numericvalue (observationid, value) VALUES (736, 47.20);
INSERT INTO numericvalue (observationid, value) VALUES (737, 22.60);
INSERT INTO numericvalue (observationid, value) VALUES (738, 21.97);
INSERT INTO numericvalue (observationid, value) VALUES (739, 7.00);
INSERT INTO numericvalue (observationid, value) VALUES (740, 49.60);
INSERT INTO numericvalue (observationid, value) VALUES (741, 22.50);
INSERT INTO numericvalue (observationid, value) VALUES (742, 13.67);
INSERT INTO numericvalue (observationid, value) VALUES (743, 5.00);
INSERT INTO numericvalue (observationid, value) VALUES (744, 51.20);
INSERT INTO numericvalue (observationid, value) VALUES (745, 22.80);
INSERT INTO numericvalue (observationid, value) VALUES (746, 25.39);
INSERT INTO numericvalue (observationid, value) VALUES (747, 5.00);
INSERT INTO numericvalue (observationid, value) VALUES (748, 47.20);
INSERT INTO numericvalue (observationid, value) VALUES (749, 23.00);
INSERT INTO numericvalue (observationid, value) VALUES (750, 22.46);
INSERT INTO numericvalue (observationid, value) VALUES (751, 8.00);
INSERT INTO numericvalue (observationid, value) VALUES (764, 49.60);
INSERT INTO numericvalue (observationid, value) VALUES (765, 22.50);
INSERT INTO numericvalue (observationid, value) VALUES (766, 13.67);
INSERT INTO numericvalue (observationid, value) VALUES (767, 5.00);
INSERT INTO numericvalue (observationid, value) VALUES (768, 51.20);
INSERT INTO numericvalue (observationid, value) VALUES (769, 22.80);
INSERT INTO numericvalue (observationid, value) VALUES (770, 25.39);
INSERT INTO numericvalue (observationid, value) VALUES (771, 5.00);
INSERT INTO numericvalue (observationid, value) VALUES (772, 47.20);
INSERT INTO numericvalue (observationid, value) VALUES (773, 23.00);
INSERT INTO numericvalue (observationid, value) VALUES (774, 22.46);
INSERT INTO numericvalue (observationid, value) VALUES (775, 8.00);
INSERT INTO numericvalue (observationid, value) VALUES (776, 50.70);
INSERT INTO numericvalue (observationid, value) VALUES (777, 22.40);
INSERT INTO numericvalue (observationid, value) VALUES (778, 14.16);
INSERT INTO numericvalue (observationid, value) VALUES (779, 5.00);
INSERT INTO numericvalue (observationid, value) VALUES (780, 52.50);
INSERT INTO numericvalue (observationid, value) VALUES (781, 22.60);
INSERT INTO numericvalue (observationid, value) VALUES (782, 28.32);
INSERT INTO numericvalue (observationid, value) VALUES (783, 5.00);
INSERT INTO numericvalue (observationid, value) VALUES (784, 47.90);
INSERT INTO numericvalue (observationid, value) VALUES (785, 22.70);
INSERT INTO numericvalue (observationid, value) VALUES (786, 22.46);
INSERT INTO numericvalue (observationid, value) VALUES (787, 7.00);
INSERT INTO numericvalue (observationid, value) VALUES (788, 16.67);
INSERT INTO numericvalue (observationid, value) VALUES (789, 8.33);
INSERT INTO numericvalue (observationid, value) VALUES (790, 16.67);
INSERT INTO numericvalue (observationid, value) VALUES (794, 50.70);
INSERT INTO numericvalue (observationid, value) VALUES (795, 22.40);
INSERT INTO numericvalue (observationid, value) VALUES (796, 14.16);
INSERT INTO numericvalue (observationid, value) VALUES (797, 5.00);
INSERT INTO numericvalue (observationid, value) VALUES (798, 52.50);
INSERT INTO numericvalue (observationid, value) VALUES (799, 22.60);
INSERT INTO numericvalue (observationid, value) VALUES (800, 28.81);
INSERT INTO numericvalue (observationid, value) VALUES (801, 5.00);
INSERT INTO numericvalue (observationid, value) VALUES (802, 47.90);
INSERT INTO numericvalue (observationid, value) VALUES (803, 22.60);
INSERT INTO numericvalue (observationid, value) VALUES (804, 22.46);
INSERT INTO numericvalue (observationid, value) VALUES (805, 8.00);
INSERT INTO numericvalue (observationid, value) VALUES (806, 50.70);
INSERT INTO numericvalue (observationid, value) VALUES (807, 22.40);
INSERT INTO numericvalue (observationid, value) VALUES (808, 14.65);
INSERT INTO numericvalue (observationid, value) VALUES (809, 5.00);
INSERT INTO numericvalue (observationid, value) VALUES (810, 52.50);
INSERT INTO numericvalue (observationid, value) VALUES (811, 22.60);
INSERT INTO numericvalue (observationid, value) VALUES (812, 28.81);
INSERT INTO numericvalue (observationid, value) VALUES (813, 5.00);
INSERT INTO numericvalue (observationid, value) VALUES (814, 48.20);
INSERT INTO numericvalue (observationid, value) VALUES (815, 22.60);
INSERT INTO numericvalue (observationid, value) VALUES (816, 22.46);
INSERT INTO numericvalue (observationid, value) VALUES (817, 8.00);
INSERT INTO numericvalue (observationid, value) VALUES (818, 50.80);
INSERT INTO numericvalue (observationid, value) VALUES (819, 22.40);
INSERT INTO numericvalue (observationid, value) VALUES (820, 15.14);
INSERT INTO numericvalue (observationid, value) VALUES (821, 5.00);
INSERT INTO numericvalue (observationid, value) VALUES (822, 52.60);
INSERT INTO numericvalue (observationid, value) VALUES (823, 22.60);
INSERT INTO numericvalue (observationid, value) VALUES (824, 28.81);
INSERT INTO numericvalue (observationid, value) VALUES (825, 5.00);
INSERT INTO numericvalue (observationid, value) VALUES (826, 48.30);
INSERT INTO numericvalue (observationid, value) VALUES (827, 22.70);
INSERT INTO numericvalue (observationid, value) VALUES (828, 21.97);
INSERT INTO numericvalue (observationid, value) VALUES (829, 8.00);
INSERT INTO numericvalue (observationid, value) VALUES (830, 50.80);
INSERT INTO numericvalue (observationid, value) VALUES (831, 22.40);
INSERT INTO numericvalue (observationid, value) VALUES (832, 14.16);
INSERT INTO numericvalue (observationid, value) VALUES (833, 5.00);
INSERT INTO numericvalue (observationid, value) VALUES (834, 52.50);
INSERT INTO numericvalue (observationid, value) VALUES (835, 22.60);
INSERT INTO numericvalue (observationid, value) VALUES (836, 28.81);
INSERT INTO numericvalue (observationid, value) VALUES (837, 5.00);
INSERT INTO numericvalue (observationid, value) VALUES (838, 48.20);
INSERT INTO numericvalue (observationid, value) VALUES (839, 22.60);
INSERT INTO numericvalue (observationid, value) VALUES (840, 22.46);
INSERT INTO numericvalue (observationid, value) VALUES (841, 8.00);
INSERT INTO numericvalue (observationid, value) VALUES (842, 50.80);
INSERT INTO numericvalue (observationid, value) VALUES (843, 22.30);
INSERT INTO numericvalue (observationid, value) VALUES (844, 15.14);
INSERT INTO numericvalue (observationid, value) VALUES (845, 5.00);
INSERT INTO numericvalue (observationid, value) VALUES (846, 53.00);
INSERT INTO numericvalue (observationid, value) VALUES (847, 22.50);
INSERT INTO numericvalue (observationid, value) VALUES (848, 29.79);
INSERT INTO numericvalue (observationid, value) VALUES (849, 5.00);
INSERT INTO numericvalue (observationid, value) VALUES (850, 48.30);
INSERT INTO numericvalue (observationid, value) VALUES (851, 22.50);
INSERT INTO numericvalue (observationid, value) VALUES (852, 22.95);
INSERT INTO numericvalue (observationid, value) VALUES (853, 8.00);
INSERT INTO numericvalue (observationid, value) VALUES (854, 50.90);
INSERT INTO numericvalue (observationid, value) VALUES (855, 22.30);
INSERT INTO numericvalue (observationid, value) VALUES (856, 15.14);
INSERT INTO numericvalue (observationid, value) VALUES (857, 5.00);
INSERT INTO numericvalue (observationid, value) VALUES (858, 52.60);
INSERT INTO numericvalue (observationid, value) VALUES (859, 22.50);
INSERT INTO numericvalue (observationid, value) VALUES (860, 29.79);
INSERT INTO numericvalue (observationid, value) VALUES (861, 5.00);
INSERT INTO numericvalue (observationid, value) VALUES (862, 48.00);
INSERT INTO numericvalue (observationid, value) VALUES (863, 22.50);
INSERT INTO numericvalue (observationid, value) VALUES (864, 22.95);
INSERT INTO numericvalue (observationid, value) VALUES (865, 8.00);
INSERT INTO numericvalue (observationid, value) VALUES (866, 50.80);
INSERT INTO numericvalue (observationid, value) VALUES (867, 22.30);
INSERT INTO numericvalue (observationid, value) VALUES (868, 15.14);
INSERT INTO numericvalue (observationid, value) VALUES (869, 5.00);
INSERT INTO numericvalue (observationid, value) VALUES (870, 52.20);
INSERT INTO numericvalue (observationid, value) VALUES (871, 22.50);
INSERT INTO numericvalue (observationid, value) VALUES (872, 29.79);
INSERT INTO numericvalue (observationid, value) VALUES (873, 5.00);
INSERT INTO numericvalue (observationid, value) VALUES (874, 48.10);
INSERT INTO numericvalue (observationid, value) VALUES (875, 22.50);
INSERT INTO numericvalue (observationid, value) VALUES (876, 22.95);
INSERT INTO numericvalue (observationid, value) VALUES (877, 7.00);
INSERT INTO numericvalue (observationid, value) VALUES (878, 50.80);
INSERT INTO numericvalue (observationid, value) VALUES (879, 22.30);
INSERT INTO numericvalue (observationid, value) VALUES (880, 15.14);
INSERT INTO numericvalue (observationid, value) VALUES (881, 5.00);
INSERT INTO numericvalue (observationid, value) VALUES (882, 52.80);
INSERT INTO numericvalue (observationid, value) VALUES (883, 22.50);
INSERT INTO numericvalue (observationid, value) VALUES (884, 29.79);
INSERT INTO numericvalue (observationid, value) VALUES (885, 5.00);
INSERT INTO numericvalue (observationid, value) VALUES (886, 48.20);
INSERT INTO numericvalue (observationid, value) VALUES (887, 22.50);
INSERT INTO numericvalue (observationid, value) VALUES (888, 22.95);
INSERT INTO numericvalue (observationid, value) VALUES (889, 7.00);
INSERT INTO numericvalue (observationid, value) VALUES (890, 50.70);
INSERT INTO numericvalue (observationid, value) VALUES (891, 22.30);
INSERT INTO numericvalue (observationid, value) VALUES (892, 15.14);
INSERT INTO numericvalue (observationid, value) VALUES (893, 5.00);
INSERT INTO numericvalue (observationid, value) VALUES (894, 52.70);
INSERT INTO numericvalue (observationid, value) VALUES (895, 22.50);
INSERT INTO numericvalue (observationid, value) VALUES (896, 30.27);
INSERT INTO numericvalue (observationid, value) VALUES (897, 5.00);
INSERT INTO numericvalue (observationid, value) VALUES (898, 48.30);
INSERT INTO numericvalue (observationid, value) VALUES (899, 22.50);
INSERT INTO numericvalue (observationid, value) VALUES (900, 22.95);
INSERT INTO numericvalue (observationid, value) VALUES (901, 8.00);
INSERT INTO numericvalue (observationid, value) VALUES (902, 50.70);
INSERT INTO numericvalue (observationid, value) VALUES (903, 22.30);
INSERT INTO numericvalue (observationid, value) VALUES (904, 15.14);
INSERT INTO numericvalue (observationid, value) VALUES (905, 5.00);
INSERT INTO numericvalue (observationid, value) VALUES (906, 53.00);
INSERT INTO numericvalue (observationid, value) VALUES (907, 22.50);
INSERT INTO numericvalue (observationid, value) VALUES (908, 30.27);
INSERT INTO numericvalue (observationid, value) VALUES (909, 5.00);
INSERT INTO numericvalue (observationid, value) VALUES (910, 48.30);
INSERT INTO numericvalue (observationid, value) VALUES (911, 22.50);
INSERT INTO numericvalue (observationid, value) VALUES (912, 22.95);
INSERT INTO numericvalue (observationid, value) VALUES (913, 8.00);
INSERT INTO numericvalue (observationid, value) VALUES (914, 16.67);
INSERT INTO numericvalue (observationid, value) VALUES (915, 25.00);
INSERT INTO numericvalue (observationid, value) VALUES (916, 16.67);
INSERT INTO numericvalue (observationid, value) VALUES (917, 16.67);
INSERT INTO numericvalue (observationid, value) VALUES (918, 16.67);
INSERT INTO numericvalue (observationid, value) VALUES (919, 25.00);
INSERT INTO numericvalue (observationid, value) VALUES (920, 16.67);
INSERT INTO numericvalue (observationid, value) VALUES (921, 16.67);
INSERT INTO numericvalue (observationid, value) VALUES (922, 16.67);
INSERT INTO numericvalue (observationid, value) VALUES (926, 0.00);
INSERT INTO numericvalue (observationid, value) VALUES (927, 0.00);
INSERT INTO numericvalue (observationid, value) VALUES (928, 0.00);
INSERT INTO numericvalue (observationid, value) VALUES (929, 135.00);
INSERT INTO numericvalue (observationid, value) VALUES (930, 41.30);
INSERT INTO numericvalue (observationid, value) VALUES (931, 21.30);
INSERT INTO numericvalue (observationid, value) VALUES (932, 24.90);
INSERT INTO numericvalue (observationid, value) VALUES (933, 99.00);
INSERT INTO numericvalue (observationid, value) VALUES (934, 38.30);
INSERT INTO numericvalue (observationid, value) VALUES (935, 21.20);
INSERT INTO numericvalue (observationid, value) VALUES (936, 20.51);
INSERT INTO numericvalue (observationid, value) VALUES (937, 32.00);
INSERT INTO numericvalue (observationid, value) VALUES (938, 38.80);
INSERT INTO numericvalue (observationid, value) VALUES (939, 21.30);
INSERT INTO numericvalue (observationid, value) VALUES (940, 13.67);
INSERT INTO numericvalue (observationid, value) VALUES (941, 44.00);
INSERT INTO numericvalue (observationid, value) VALUES (942, 41.40);
INSERT INTO numericvalue (observationid, value) VALUES (943, 21.40);
INSERT INTO numericvalue (observationid, value) VALUES (944, 27.34);
INSERT INTO numericvalue (observationid, value) VALUES (945, 96.00);
INSERT INTO numericvalue (observationid, value) VALUES (946, 38.10);
INSERT INTO numericvalue (observationid, value) VALUES (947, 21.30);
INSERT INTO numericvalue (observationid, value) VALUES (948, 21.00);
INSERT INTO numericvalue (observationid, value) VALUES (949, 7.00);
INSERT INTO numericvalue (observationid, value) VALUES (950, 39.00);
INSERT INTO numericvalue (observationid, value) VALUES (951, 21.40);
INSERT INTO numericvalue (observationid, value) VALUES (952, 13.67);
INSERT INTO numericvalue (observationid, value) VALUES (953, 45.00);
INSERT INTO numericvalue (observationid, value) VALUES (954, 41.70);
INSERT INTO numericvalue (observationid, value) VALUES (955, 21.40);
INSERT INTO numericvalue (observationid, value) VALUES (956, 28.32);
INSERT INTO numericvalue (observationid, value) VALUES (957, 94.00);
INSERT INTO numericvalue (observationid, value) VALUES (958, 38.00);
INSERT INTO numericvalue (observationid, value) VALUES (959, 21.40);
INSERT INTO numericvalue (observationid, value) VALUES (960, 21.00);
INSERT INTO numericvalue (observationid, value) VALUES (961, 7.00);
INSERT INTO numericvalue (observationid, value) VALUES (962, 39.00);
INSERT INTO numericvalue (observationid, value) VALUES (963, 21.40);
INSERT INTO numericvalue (observationid, value) VALUES (964, 13.18);
INSERT INTO numericvalue (observationid, value) VALUES (965, 46.00);
INSERT INTO numericvalue (observationid, value) VALUES (966, 39.00);
INSERT INTO numericvalue (observationid, value) VALUES (967, 21.40);
INSERT INTO numericvalue (observationid, value) VALUES (968, 13.18);
INSERT INTO numericvalue (observationid, value) VALUES (969, 46.00);
INSERT INTO numericvalue (observationid, value) VALUES (970, 37.90);
INSERT INTO numericvalue (observationid, value) VALUES (971, 21.30);
INSERT INTO numericvalue (observationid, value) VALUES (972, 21.48);
INSERT INTO numericvalue (observationid, value) VALUES (973, 68.00);
INSERT INTO numericvalue (observationid, value) VALUES (974, 38.70);
INSERT INTO numericvalue (observationid, value) VALUES (975, 21.40);
INSERT INTO numericvalue (observationid, value) VALUES (976, 13.67);
INSERT INTO numericvalue (observationid, value) VALUES (977, 43.00);
INSERT INTO numericvalue (observationid, value) VALUES (978, 38.70);
INSERT INTO numericvalue (observationid, value) VALUES (979, 21.40);
INSERT INTO numericvalue (observationid, value) VALUES (980, 13.67);
INSERT INTO numericvalue (observationid, value) VALUES (981, 43.00);
INSERT INTO numericvalue (observationid, value) VALUES (982, 37.80);
INSERT INTO numericvalue (observationid, value) VALUES (983, 21.30);
INSERT INTO numericvalue (observationid, value) VALUES (984, 21.48);
INSERT INTO numericvalue (observationid, value) VALUES (985, 58.00);
INSERT INTO numericvalue (observationid, value) VALUES (986, 0.00);
INSERT INTO numericvalue (observationid, value) VALUES (987, 0.00);
INSERT INTO numericvalue (observationid, value) VALUES (988, 0.00);
INSERT INTO numericvalue (observationid, value) VALUES (989, 135.00);
INSERT INTO numericvalue (observationid, value) VALUES (990, 40.60);
INSERT INTO numericvalue (observationid, value) VALUES (991, 21.50);
INSERT INTO numericvalue (observationid, value) VALUES (992, 20.02);
INSERT INTO numericvalue (observationid, value) VALUES (993, 104.00);
INSERT INTO numericvalue (observationid, value) VALUES (994, 37.90);
INSERT INTO numericvalue (observationid, value) VALUES (995, 21.40);
INSERT INTO numericvalue (observationid, value) VALUES (996, 21.97);
INSERT INTO numericvalue (observationid, value) VALUES (997, 42.00);
INSERT INTO numericvalue (observationid, value) VALUES (998, 37.90);
INSERT INTO numericvalue (observationid, value) VALUES (999, 21.40);
INSERT INTO numericvalue (observationid, value) VALUES (1000, 21.97);
INSERT INTO numericvalue (observationid, value) VALUES (1001, 42.00);
INSERT INTO numericvalue (observationid, value) VALUES (1002, 40.60);
INSERT INTO numericvalue (observationid, value) VALUES (1003, 21.50);
INSERT INTO numericvalue (observationid, value) VALUES (1004, 20.02);
INSERT INTO numericvalue (observationid, value) VALUES (1005, 108.00);
INSERT INTO numericvalue (observationid, value) VALUES (1006, 38.20);
INSERT INTO numericvalue (observationid, value) VALUES (1007, 21.40);
INSERT INTO numericvalue (observationid, value) VALUES (1008, 21.97);
INSERT INTO numericvalue (observationid, value) VALUES (1009, 104.00);
INSERT INTO numericvalue (observationid, value) VALUES (1018, 38.20);
INSERT INTO numericvalue (observationid, value) VALUES (1019, 21.40);
INSERT INTO numericvalue (observationid, value) VALUES (1020, 22.46);
INSERT INTO numericvalue (observationid, value) VALUES (1021, 103.00);
INSERT INTO numericvalue (observationid, value) VALUES (1022, 0.00);
INSERT INTO numericvalue (observationid, value) VALUES (1023, 0.00);
INSERT INTO numericvalue (observationid, value) VALUES (1024, 0.00);
INSERT INTO numericvalue (observationid, value) VALUES (1025, 135.00);
INSERT INTO numericvalue (observationid, value) VALUES (1026, 40.70);
INSERT INTO numericvalue (observationid, value) VALUES (1027, 21.60);
INSERT INTO numericvalue (observationid, value) VALUES (1028, 19.53);
INSERT INTO numericvalue (observationid, value) VALUES (1029, 5.00);
INSERT INTO numericvalue (observationid, value) VALUES (1030, 38.50);
INSERT INTO numericvalue (observationid, value) VALUES (1031, 21.40);
INSERT INTO numericvalue (observationid, value) VALUES (1032, 21.97);
INSERT INTO numericvalue (observationid, value) VALUES (1033, 7.00);
INSERT INTO numericvalue (observationid, value) VALUES (1034, 0.00);
INSERT INTO numericvalue (observationid, value) VALUES (1035, 0.00);
INSERT INTO numericvalue (observationid, value) VALUES (1036, 0.00);
INSERT INTO numericvalue (observationid, value) VALUES (1037, 135.00);
INSERT INTO numericvalue (observationid, value) VALUES (1038, 41.00);
INSERT INTO numericvalue (observationid, value) VALUES (1039, 21.60);
INSERT INTO numericvalue (observationid, value) VALUES (1040, 20.02);
INSERT INTO numericvalue (observationid, value) VALUES (1041, 111.00);
INSERT INTO numericvalue (observationid, value) VALUES (1042, 39.00);
INSERT INTO numericvalue (observationid, value) VALUES (1043, 21.40);
INSERT INTO numericvalue (observationid, value) VALUES (1044, 22.46);
INSERT INTO numericvalue (observationid, value) VALUES (1045, 105.00);
INSERT INTO numericvalue (observationid, value) VALUES (1046, 0.00);
INSERT INTO numericvalue (observationid, value) VALUES (1047, 0.00);
INSERT INTO numericvalue (observationid, value) VALUES (1048, 0.00);
INSERT INTO numericvalue (observationid, value) VALUES (1049, 135.00);
INSERT INTO numericvalue (observationid, value) VALUES (1050, 41.40);
INSERT INTO numericvalue (observationid, value) VALUES (1051, 21.60);
INSERT INTO numericvalue (observationid, value) VALUES (1052, 20.02);
INSERT INTO numericvalue (observationid, value) VALUES (1053, 5.00);
INSERT INTO numericvalue (observationid, value) VALUES (1054, 38.90);
INSERT INTO numericvalue (observationid, value) VALUES (1055, 21.40);
INSERT INTO numericvalue (observationid, value) VALUES (1056, 22.46);
INSERT INTO numericvalue (observationid, value) VALUES (1057, 7.00);
INSERT INTO numericvalue (observationid, value) VALUES (1058, 38.90);
INSERT INTO numericvalue (observationid, value) VALUES (1059, 21.40);
INSERT INTO numericvalue (observationid, value) VALUES (1060, 22.46);
INSERT INTO numericvalue (observationid, value) VALUES (1061, 7.00);
INSERT INTO numericvalue (observationid, value) VALUES (1062, 41.10);
INSERT INTO numericvalue (observationid, value) VALUES (1063, 21.70);
INSERT INTO numericvalue (observationid, value) VALUES (1064, 20.02);
INSERT INTO numericvalue (observationid, value) VALUES (1065, 109.00);
INSERT INTO numericvalue (observationid, value) VALUES (1066, 38.80);
INSERT INTO numericvalue (observationid, value) VALUES (1067, 21.40);
INSERT INTO numericvalue (observationid, value) VALUES (1068, 22.46);
INSERT INTO numericvalue (observationid, value) VALUES (1069, 106.00);
INSERT INTO numericvalue (observationid, value) VALUES (1070, 0.00);
INSERT INTO numericvalue (observationid, value) VALUES (1071, 0.00);
INSERT INTO numericvalue (observationid, value) VALUES (1072, 0.00);
INSERT INTO numericvalue (observationid, value) VALUES (1073, 135.00);
INSERT INTO numericvalue (observationid, value) VALUES (1074, 41.00);
INSERT INTO numericvalue (observationid, value) VALUES (1075, 21.70);
INSERT INTO numericvalue (observationid, value) VALUES (1076, 20.02);
INSERT INTO numericvalue (observationid, value) VALUES (1077, 108.00);
INSERT INTO numericvalue (observationid, value) VALUES (1078, 38.70);
INSERT INTO numericvalue (observationid, value) VALUES (1079, 21.40);
INSERT INTO numericvalue (observationid, value) VALUES (1080, 22.95);
INSERT INTO numericvalue (observationid, value) VALUES (1081, 7.00);
INSERT INTO numericvalue (observationid, value) VALUES (1082, 0.00);
INSERT INTO numericvalue (observationid, value) VALUES (1083, 0.00);
INSERT INTO numericvalue (observationid, value) VALUES (1084, 0.00);
INSERT INTO numericvalue (observationid, value) VALUES (1085, 135.00);
INSERT INTO numericvalue (observationid, value) VALUES (1086, 41.20);
INSERT INTO numericvalue (observationid, value) VALUES (1087, 21.70);
INSERT INTO numericvalue (observationid, value) VALUES (1088, 20.02);
INSERT INTO numericvalue (observationid, value) VALUES (1089, 5.00);
INSERT INTO numericvalue (observationid, value) VALUES (1090, 39.10);
INSERT INTO numericvalue (observationid, value) VALUES (1091, 21.40);
INSERT INTO numericvalue (observationid, value) VALUES (1092, 22.95);
INSERT INTO numericvalue (observationid, value) VALUES (1093, 7.00);
INSERT INTO numericvalue (observationid, value) VALUES (1094, 39.10);
INSERT INTO numericvalue (observationid, value) VALUES (1095, 21.40);
INSERT INTO numericvalue (observationid, value) VALUES (1096, 22.95);
INSERT INTO numericvalue (observationid, value) VALUES (1097, 7.00);
INSERT INTO numericvalue (observationid, value) VALUES (1098, 40.70);
INSERT INTO numericvalue (observationid, value) VALUES (1099, 21.60);
INSERT INTO numericvalue (observationid, value) VALUES (1100, 20.02);
INSERT INTO numericvalue (observationid, value) VALUES (1101, 111.00);
INSERT INTO numericvalue (observationid, value) VALUES (1102, 39.00);
INSERT INTO numericvalue (observationid, value) VALUES (1103, 21.40);
INSERT INTO numericvalue (observationid, value) VALUES (1104, 23.44);
INSERT INTO numericvalue (observationid, value) VALUES (1105, 110.00);
INSERT INTO numericvalue (observationid, value) VALUES (1106, 0.00);
INSERT INTO numericvalue (observationid, value) VALUES (1107, 0.00);
INSERT INTO numericvalue (observationid, value) VALUES (1108, 0.00);
INSERT INTO numericvalue (observationid, value) VALUES (1109, 135.00);
INSERT INTO numericvalue (observationid, value) VALUES (1110, 44.10);
INSERT INTO numericvalue (observationid, value) VALUES (1111, 21.60);
INSERT INTO numericvalue (observationid, value) VALUES (1112, 20.02);
INSERT INTO numericvalue (observationid, value) VALUES (1113, 5.00);
INSERT INTO numericvalue (observationid, value) VALUES (1114, 41.70);
INSERT INTO numericvalue (observationid, value) VALUES (1115, 21.50);
INSERT INTO numericvalue (observationid, value) VALUES (1116, 21.97);
INSERT INTO numericvalue (observationid, value) VALUES (1117, 7.00);
INSERT INTO numericvalue (observationid, value) VALUES (1118, 41.70);
INSERT INTO numericvalue (observationid, value) VALUES (1119, 21.50);
INSERT INTO numericvalue (observationid, value) VALUES (1120, 21.97);
INSERT INTO numericvalue (observationid, value) VALUES (1121, 7.00);
INSERT INTO numericvalue (observationid, value) VALUES (1122, 44.00);
INSERT INTO numericvalue (observationid, value) VALUES (1123, 21.70);
INSERT INTO numericvalue (observationid, value) VALUES (1124, 20.02);
INSERT INTO numericvalue (observationid, value) VALUES (1125, 108.00);
INSERT INTO numericvalue (observationid, value) VALUES (1126, 41.70);
INSERT INTO numericvalue (observationid, value) VALUES (1127, 21.50);
INSERT INTO numericvalue (observationid, value) VALUES (1128, 22.46);
INSERT INTO numericvalue (observationid, value) VALUES (1129, 105.00);
INSERT INTO numericvalue (observationid, value) VALUES (1130, 0.00);
INSERT INTO numericvalue (observationid, value) VALUES (1131, 0.00);
INSERT INTO numericvalue (observationid, value) VALUES (1132, 0.00);
INSERT INTO numericvalue (observationid, value) VALUES (1133, 100.00);
INSERT INTO numericvalue (observationid, value) VALUES (1134, 44.90);
INSERT INTO numericvalue (observationid, value) VALUES (1135, 21.80);
INSERT INTO numericvalue (observationid, value) VALUES (1136, 20.02);
INSERT INTO numericvalue (observationid, value) VALUES (1137, 4.00);
INSERT INTO numericvalue (observationid, value) VALUES (1138, 42.20);
INSERT INTO numericvalue (observationid, value) VALUES (1139, 21.60);
INSERT INTO numericvalue (observationid, value) VALUES (1140, 22.95);
INSERT INTO numericvalue (observationid, value) VALUES (1141, 5.00);
INSERT INTO numericvalue (observationid, value) VALUES (1142, 42.20);
INSERT INTO numericvalue (observationid, value) VALUES (1143, 21.60);
INSERT INTO numericvalue (observationid, value) VALUES (1144, 22.95);
INSERT INTO numericvalue (observationid, value) VALUES (1145, 5.00);
INSERT INTO numericvalue (observationid, value) VALUES (1146, 44.90);
INSERT INTO numericvalue (observationid, value) VALUES (1147, 21.80);
INSERT INTO numericvalue (observationid, value) VALUES (1148, 20.02);
INSERT INTO numericvalue (observationid, value) VALUES (1149, 82.00);
INSERT INTO numericvalue (observationid, value) VALUES (1150, 42.70);
INSERT INTO numericvalue (observationid, value) VALUES (1151, 21.70);
INSERT INTO numericvalue (observationid, value) VALUES (1152, 23.44);
INSERT INTO numericvalue (observationid, value) VALUES (1153, 78.00);
INSERT INTO numericvalue (observationid, value) VALUES (1154, 25.00);
INSERT INTO numericvalue (observationid, value) VALUES (1155, 25.00);
INSERT INTO numericvalue (observationid, value) VALUES (1156, 0.00);
INSERT INTO numericvalue (observationid, value) VALUES (1157, 0.00);
INSERT INTO numericvalue (observationid, value) VALUES (1158, 0.00);
INSERT INTO numericvalue (observationid, value) VALUES (1159, 100.00);
INSERT INTO numericvalue (observationid, value) VALUES (1160, 48.50);
INSERT INTO numericvalue (observationid, value) VALUES (1161, 21.00);
INSERT INTO numericvalue (observationid, value) VALUES (1162, 19.04);
INSERT INTO numericvalue (observationid, value) VALUES (1163, 4.00);
INSERT INTO numericvalue (observationid, value) VALUES (1164, 45.50);
INSERT INTO numericvalue (observationid, value) VALUES (1165, 20.80);
INSERT INTO numericvalue (observationid, value) VALUES (1166, 19.53);
INSERT INTO numericvalue (observationid, value) VALUES (1167, 5.00);
INSERT INTO numericvalue (observationid, value) VALUES (1168, 0.00);
INSERT INTO numericvalue (observationid, value) VALUES (1169, 0.00);
INSERT INTO numericvalue (observationid, value) VALUES (1170, 0.00);
INSERT INTO numericvalue (observationid, value) VALUES (1171, 100.00);
INSERT INTO numericvalue (observationid, value) VALUES (1172, 48.70);
INSERT INTO numericvalue (observationid, value) VALUES (1173, 21.00);
INSERT INTO numericvalue (observationid, value) VALUES (1174, 19.04);
INSERT INTO numericvalue (observationid, value) VALUES (1175, 3.00);
INSERT INTO numericvalue (observationid, value) VALUES (1176, 45.60);
INSERT INTO numericvalue (observationid, value) VALUES (1177, 20.80);
INSERT INTO numericvalue (observationid, value) VALUES (1178, 19.53);
INSERT INTO numericvalue (observationid, value) VALUES (1179, 5.00);
INSERT INTO numericvalue (observationid, value) VALUES (1180, 0.00);
INSERT INTO numericvalue (observationid, value) VALUES (1181, 0.00);
INSERT INTO numericvalue (observationid, value) VALUES (1182, 0.00);
INSERT INTO numericvalue (observationid, value) VALUES (1183, 100.00);
INSERT INTO numericvalue (observationid, value) VALUES (1184, 48.50);
INSERT INTO numericvalue (observationid, value) VALUES (1185, 21.00);
INSERT INTO numericvalue (observationid, value) VALUES (1186, 19.53);
INSERT INTO numericvalue (observationid, value) VALUES (1187, 4.00);
INSERT INTO numericvalue (observationid, value) VALUES (1188, 45.50);
INSERT INTO numericvalue (observationid, value) VALUES (1189, 20.80);
INSERT INTO numericvalue (observationid, value) VALUES (1190, 19.53);
INSERT INTO numericvalue (observationid, value) VALUES (1191, 5.00);
INSERT INTO numericvalue (observationid, value) VALUES (1192, 45.30);
INSERT INTO numericvalue (observationid, value) VALUES (1193, 19.30);
INSERT INTO numericvalue (observationid, value) VALUES (1194, 6.35);
INSERT INTO numericvalue (observationid, value) VALUES (1195, 2.00);
INSERT INTO numericvalue (observationid, value) VALUES (1196, 46.90);
INSERT INTO numericvalue (observationid, value) VALUES (1197, 19.20);
INSERT INTO numericvalue (observationid, value) VALUES (1198, 15.14);
INSERT INTO numericvalue (observationid, value) VALUES (1199, 4.00);
INSERT INTO numericvalue (observationid, value) VALUES (1200, 43.50);
INSERT INTO numericvalue (observationid, value) VALUES (1201, 19.30);
INSERT INTO numericvalue (observationid, value) VALUES (1202, 18.55);
INSERT INTO numericvalue (observationid, value) VALUES (1203, 5.00);
INSERT INTO numericvalue (observationid, value) VALUES (1204, 0.00);
INSERT INTO numericvalue (observationid, value) VALUES (1205, 0.00);
INSERT INTO numericvalue (observationid, value) VALUES (1206, 0.00);
INSERT INTO numericvalue (observationid, value) VALUES (1207, 100.00);
INSERT INTO numericvalue (observationid, value) VALUES (1208, 48.30);
INSERT INTO numericvalue (observationid, value) VALUES (1209, 20.90);
INSERT INTO numericvalue (observationid, value) VALUES (1210, 18.07);
INSERT INTO numericvalue (observationid, value) VALUES (1211, 4.00);
INSERT INTO numericvalue (observationid, value) VALUES (1212, 44.40);
INSERT INTO numericvalue (observationid, value) VALUES (1213, 21.00);
INSERT INTO numericvalue (observationid, value) VALUES (1214, 20.51);
INSERT INTO numericvalue (observationid, value) VALUES (1215, 5.00);


--
-- Data for Name: observableproperty; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO observableproperty (observablepropertyid, hibernatediscriminator, identifier, description) VALUES (1, 'N', 'Internal Humidity', 'Internal Humidity');
INSERT INTO observableproperty (observablepropertyid, hibernatediscriminator, identifier, description) VALUES (2, 'N', 'Internal Temperature ', 'Internal Temperature ');
INSERT INTO observableproperty (observablepropertyid, hibernatediscriminator, identifier, description) VALUES (3, 'N', 'Temperature', 'Temperature');
INSERT INTO observableproperty (observablepropertyid, hibernatediscriminator, identifier, description) VALUES (4, 'N', 'Soil Moisture', 'Soil Moisture');
INSERT INTO observableproperty (observablepropertyid, hibernatediscriminator, identifier, description) VALUES (5, 'N', 'Water Consumption', 'Water Consumption');


--
-- Name: observablepropertyid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('observablepropertyid_seq', 21, true);


--
-- Data for Name: observablepropertyminmax; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO observablepropertyminmax (obspropertyid, featureofinterestid, observablepropertyid, minval, maxval) VALUES (2, 3, 4, 70, 80);
INSERT INTO observablepropertyminmax (obspropertyid, featureofinterestid, observablepropertyid, minval, maxval) VALUES (1, 3, 3, 0, 10);
INSERT INTO observablepropertyminmax (obspropertyid, featureofinterestid, observablepropertyid, minval, maxval) VALUES (4, 4, 4, 70, 80);
INSERT INTO observablepropertyminmax (obspropertyid, featureofinterestid, observablepropertyid, minval, maxval) VALUES (3, 4, 3, 0, 10);
INSERT INTO observablepropertyminmax (obspropertyid, featureofinterestid, observablepropertyid, minval, maxval) VALUES (6, 5, 4, 70, 80);
INSERT INTO observablepropertyminmax (obspropertyid, featureofinterestid, observablepropertyid, minval, maxval) VALUES (5, 5, 3, 0, 10);


--
-- Data for Name: observation; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (1, 2, '2016-08-06 21:37:00', '2016-08-06 21:37:00', '2016-08-06 21:37:00', NULL, NULL, 'F', '201686213700-1bddc73d-c176-4e39-bae3-64edfae6af72', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (2, 3, '2016-08-06 21:37:00', '2016-08-06 21:37:00', '2016-08-06 21:37:00', NULL, NULL, 'F', '201686213700-079c09a4-b07d-4970-815a-bf62c0faedb0', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (3, 1, '2016-08-06 21:37:00', '2016-08-06 21:37:00', '2016-08-06 21:37:00', NULL, NULL, 'F', '201686213700-2ae23420-aafc-4570-a1df-9f22dbefd1f5', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (4, 4, '2016-08-06 21:37:00', '2016-08-06 21:37:00', '2016-08-06 21:37:00', NULL, NULL, 'F', '201686213700-e82a6973-1ea5-4096-b956-7d69f49e7ec2', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (9, 2, '2016-08-06 21:40:00', '2016-08-06 21:40:00', '2016-08-06 21:40:00', NULL, NULL, 'F', '201686214000-72b6a2e5-c8db-4ddc-9a90-48905866db3e', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (10, 3, '2016-08-06 21:40:00', '2016-08-06 21:40:00', '2016-08-06 21:40:00', NULL, NULL, 'F', '201686214000-b7302e44-7b94-49c0-9e7c-aebbeae0a025', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (11, 1, '2016-08-06 21:40:00', '2016-08-06 21:40:00', '2016-08-06 21:40:00', NULL, NULL, 'F', '201686214000-d24995f3-55fe-477f-99a1-4a7f3dd54609', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (12, 4, '2016-08-06 21:40:00', '2016-08-06 21:40:00', '2016-08-06 21:40:00', NULL, NULL, 'F', '201686214000-162b23ff-cbdc-43e8-8bcc-bd9bdee38237', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (13, 10, '2016-08-06 21:40:00', '2016-08-06 21:40:00', '2016-08-06 21:40:00', NULL, NULL, 'F', '201686214000-fc97a78f-a691-43e7-aa6d-644cd9dca860', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (14, 11, '2016-08-06 21:40:00', '2016-08-06 21:40:00', '2016-08-06 21:40:00', NULL, NULL, 'F', '201686214000-a8794177-def5-43f9-85f1-583c6826a832', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (15, 9, '2016-08-06 21:40:00', '2016-08-06 21:40:00', '2016-08-06 21:40:00', NULL, NULL, 'F', '201686214000-e2c7a666-ebe2-4a90-abb8-72626630b904', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (16, 12, '2016-08-06 21:40:00', '2016-08-06 21:40:00', '2016-08-06 21:40:00', NULL, NULL, 'F', '201686214000-36e285a6-8c2d-4e15-97b8-b2c3a8ee15f6', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (17, 2, '2016-08-06 21:36:00', '2016-08-06 21:36:00', '2016-08-06 21:36:00', NULL, NULL, 'F', '201686213600-d031dd14-90e3-47a5-b11c-5a4ee23320da', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (18, 3, '2016-08-06 21:36:00', '2016-08-06 21:36:00', '2016-08-06 21:36:00', NULL, NULL, 'F', '201686213600-8b1150a0-e4d6-42c1-98c1-1bf9c025bbc2', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (19, 1, '2016-08-06 21:36:00', '2016-08-06 21:36:00', '2016-08-06 21:36:00', NULL, NULL, 'F', '201686213600-efd6a10c-f63a-4883-bb31-e8939cde2444', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (20, 4, '2016-08-06 21:36:00', '2016-08-06 21:36:00', '2016-08-06 21:36:00', NULL, NULL, 'F', '201686213600-f5cccc1b-54cd-41f6-902e-976c2822a340', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (25, 2, '2016-08-07 01:51:00', '2016-08-07 01:51:00', '2016-08-07 01:51:00', NULL, NULL, 'F', '20168715100-8f8201e2-df75-487a-b9a3-b0058160e29b', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (26, 3, '2016-08-07 01:51:00', '2016-08-07 01:51:00', '2016-08-07 01:51:00', NULL, NULL, 'F', '20168715100-87d999ef-7941-4f0a-b314-f350899439d0', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (27, 1, '2016-08-07 01:51:00', '2016-08-07 01:51:00', '2016-08-07 01:51:00', NULL, NULL, 'F', '20168715100-c9810eb9-416c-4e6d-9fb9-6853323334bf', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (28, 4, '2016-08-07 01:51:00', '2016-08-07 01:51:00', '2016-08-07 01:51:00', NULL, NULL, 'F', '20168715100-6bf4f14c-7130-4f2d-a114-70a69c76d2a3', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (29, 6, '2016-08-07 01:51:00', '2016-08-07 01:51:00', '2016-08-07 01:51:00', NULL, NULL, 'F', '20168715100-abf80856-4ce3-4869-9246-1387d297d781', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (30, 7, '2016-08-07 01:51:00', '2016-08-07 01:51:00', '2016-08-07 01:51:00', NULL, NULL, 'F', '20168715100-f720b9ca-29ad-448a-a9bb-d05cb395b9e1', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (31, 5, '2016-08-07 01:51:00', '2016-08-07 01:51:00', '2016-08-07 01:51:00', NULL, NULL, 'F', '20168715100-046e8daa-25dc-46a6-ab77-8af2f891df83', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (32, 8, '2016-08-07 01:51:00', '2016-08-07 01:51:00', '2016-08-07 01:51:00', NULL, NULL, 'F', '20168715100-c88cf7f8-4027-43da-8439-46e6d1514999', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (33, 10, '2016-08-07 01:51:00', '2016-08-07 01:51:00', '2016-08-07 01:51:00', NULL, NULL, 'F', '20168715100-b03a1da9-8ab3-413d-9ff3-16b4f694cc22', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (34, 11, '2016-08-07 01:51:00', '2016-08-07 01:51:00', '2016-08-07 01:51:00', NULL, NULL, 'F', '20168715100-69c19b51-942e-4292-a90f-2a8c1827ed65', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (35, 9, '2016-08-07 01:51:00', '2016-08-07 01:51:00', '2016-08-07 01:51:00', NULL, NULL, 'F', '20168715100-cefe0236-90a1-4202-ae0d-dd42a93341c4', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (36, 12, '2016-08-07 01:51:00', '2016-08-07 01:51:00', '2016-08-07 01:51:00', NULL, NULL, 'F', '20168715100-737b714c-d63b-4048-a1f0-bed52d9c2c61', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (37, 2, '2016-08-07 01:50:00', '2016-08-07 01:50:00', '2016-08-07 01:50:00', NULL, NULL, 'F', '20168715000-b44e4279-fcc2-4e65-bbcb-43f120da6491', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (38, 3, '2016-08-07 01:50:00', '2016-08-07 01:50:00', '2016-08-07 01:50:00', NULL, NULL, 'F', '20168715000-4b75c09f-68e9-42ff-9eb5-9712174f95e7', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (39, 1, '2016-08-07 01:50:00', '2016-08-07 01:50:00', '2016-08-07 01:50:00', NULL, NULL, 'F', '20168715000-2d88af34-841e-4061-a5e9-c63b604c2096', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (40, 4, '2016-08-07 01:50:00', '2016-08-07 01:50:00', '2016-08-07 01:50:00', NULL, NULL, 'F', '20168715000-6a760eaa-e063-4dcc-b273-280482796057', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (41, 6, '2016-08-07 01:50:00', '2016-08-07 01:50:00', '2016-08-07 01:50:00', NULL, NULL, 'F', '20168715000-7f8e488f-b5f8-4940-8e10-7ccdd6c5021d', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (42, 7, '2016-08-07 01:50:00', '2016-08-07 01:50:00', '2016-08-07 01:50:00', NULL, NULL, 'F', '20168715000-9f1ab4cf-fdc0-4bcf-bb7d-0fb42c4619c8', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (43, 5, '2016-08-07 01:50:00', '2016-08-07 01:50:00', '2016-08-07 01:50:00', NULL, NULL, 'F', '20168715000-b2c3e8ff-d97e-482d-ba1e-93ca184cb667', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (44, 8, '2016-08-07 01:50:00', '2016-08-07 01:50:00', '2016-08-07 01:50:00', NULL, NULL, 'F', '20168715000-1a9ac757-c039-42f3-a7cd-982654482125', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (45, 10, '2016-08-07 01:50:00', '2016-08-07 01:50:00', '2016-08-07 01:50:00', NULL, NULL, 'F', '20168715000-323dc4d5-2341-4926-bc0c-351a45f64876', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (46, 11, '2016-08-07 01:50:00', '2016-08-07 01:50:00', '2016-08-07 01:50:00', NULL, NULL, 'F', '20168715000-a798e272-01e5-4a56-827b-882d39a597a6', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (47, 9, '2016-08-07 01:50:00', '2016-08-07 01:50:00', '2016-08-07 01:50:00', NULL, NULL, 'F', '20168715000-44539d00-ce21-47c0-944c-73e33b3d5ac4', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (48, 12, '2016-08-07 01:50:00', '2016-08-07 01:50:00', '2016-08-07 01:50:00', NULL, NULL, 'F', '20168715000-df3bc290-a1bc-4e59-bcc4-ed1333b033c0', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (49, 2, '2016-08-07 02:09:00', '2016-08-07 02:09:00', '2016-08-07 02:09:00', NULL, NULL, 'F', '20168720900-51b5437a-6b69-4af0-87cd-5876eda463bd', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (50, 3, '2016-08-07 02:09:00', '2016-08-07 02:09:00', '2016-08-07 02:09:00', NULL, NULL, 'F', '20168720900-e06ddbf0-f116-4925-bb5d-e8bea24a130d', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (51, 1, '2016-08-07 02:09:00', '2016-08-07 02:09:00', '2016-08-07 02:09:00', NULL, NULL, 'F', '20168720900-8b23f18f-06f9-4a7c-b20d-599d3d8e4f7e', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (52, 4, '2016-08-07 02:09:00', '2016-08-07 02:09:00', '2016-08-07 02:09:00', NULL, NULL, 'F', '20168720900-d81fba11-be00-42d8-a20d-469bac77846e', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (53, 6, '2016-08-07 02:09:00', '2016-08-07 02:09:00', '2016-08-07 02:09:00', NULL, NULL, 'F', '20168720900-7c16876a-2f87-41b8-921f-dc1af2059c7e', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (54, 7, '2016-08-07 02:09:00', '2016-08-07 02:09:00', '2016-08-07 02:09:00', NULL, NULL, 'F', '20168720900-9deeb5d2-50b7-4cff-a1aa-509c0ef6467b', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (55, 5, '2016-08-07 02:09:00', '2016-08-07 02:09:00', '2016-08-07 02:09:00', NULL, NULL, 'F', '20168720900-41329e80-7e8e-49f3-a260-5c3eab3c94e0', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (56, 8, '2016-08-07 02:09:00', '2016-08-07 02:09:00', '2016-08-07 02:09:00', NULL, NULL, 'F', '20168720900-a221de73-6992-4b04-bf0c-a679eb4a3e8c', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (57, 10, '2016-08-07 02:09:00', '2016-08-07 02:09:00', '2016-08-07 02:09:00', NULL, NULL, 'F', '20168720900-1588c2a2-7f49-47b1-ae8c-fb16ae8dd5c5', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (58, 11, '2016-08-07 02:09:00', '2016-08-07 02:09:00', '2016-08-07 02:09:00', NULL, NULL, 'F', '20168720900-a895afd7-5758-4796-886b-d1afbb1fa41c', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (59, 9, '2016-08-07 02:09:00', '2016-08-07 02:09:00', '2016-08-07 02:09:00', NULL, NULL, 'F', '20168720900-d8bc0913-bc56-4941-b03c-c84bf8234e07', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (60, 12, '2016-08-07 02:09:00', '2016-08-07 02:09:00', '2016-08-07 02:09:00', NULL, NULL, 'F', '20168720900-6fb2d9f1-74b9-4ce7-9e89-5c3d6cfb8794', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (61, 2, '2016-08-07 02:37:00', '2016-08-07 02:37:00', '2016-08-07 02:37:00', NULL, NULL, 'F', '20168723700-83bd6e2a-61c1-4ca4-8b11-655255c20e7b', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (62, 3, '2016-08-07 02:37:00', '2016-08-07 02:37:00', '2016-08-07 02:37:00', NULL, NULL, 'F', '20168723700-92d201ba-db4e-4e8a-836b-240ab0fd2a5d', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (63, 1, '2016-08-07 02:37:00', '2016-08-07 02:37:00', '2016-08-07 02:37:00', NULL, NULL, 'F', '20168723700-d6e03c5a-708c-4e05-acec-e70bbf08277b', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (64, 4, '2016-08-07 02:37:00', '2016-08-07 02:37:00', '2016-08-07 02:37:00', NULL, NULL, 'F', '20168723700-1381febb-1d25-41fb-a3e6-eab254fa9ff7', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (65, 6, '2016-08-07 02:38:00', '2016-08-07 02:38:00', '2016-08-07 02:38:00', NULL, NULL, 'F', '20168723800-323d2345-227e-4f21-95a2-6ea2ca8e3981', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (66, 7, '2016-08-07 02:38:00', '2016-08-07 02:38:00', '2016-08-07 02:38:00', NULL, NULL, 'F', '20168723800-73ec4b82-042c-470d-8c76-b330e58e5135', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (67, 5, '2016-08-07 02:38:00', '2016-08-07 02:38:00', '2016-08-07 02:38:00', NULL, NULL, 'F', '20168723800-933c681d-a3d5-485d-a572-38bb57799cab', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (68, 8, '2016-08-07 02:38:00', '2016-08-07 02:38:00', '2016-08-07 02:38:00', NULL, NULL, 'F', '20168723800-75bc2ddc-ab93-4f39-9cad-3731fb6fa67e', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (69, 10, '2016-08-07 02:38:00', '2016-08-07 02:38:00', '2016-08-07 02:38:00', NULL, NULL, 'F', '20168723800-c4be6f9f-6505-4eae-b74c-54b85381760e', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (70, 11, '2016-08-07 02:38:00', '2016-08-07 02:38:00', '2016-08-07 02:38:00', NULL, NULL, 'F', '20168723800-f62c6f03-6002-4380-9dca-894b816cd720', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (71, 9, '2016-08-07 02:38:00', '2016-08-07 02:38:00', '2016-08-07 02:38:00', NULL, NULL, 'F', '20168723800-d6e1b029-ac61-4e5d-9876-89c99db9adfc', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (72, 12, '2016-08-07 02:38:00', '2016-08-07 02:38:00', '2016-08-07 02:38:00', NULL, NULL, 'F', '20168723800-77c01aac-c913-4347-879a-16fee7b35ed6', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (73, 2, '2016-08-07 02:44:00', '2016-08-07 02:44:00', '2016-08-07 02:44:00', NULL, NULL, 'F', '20168724400-d50f2434-7fb3-4a0d-bd28-c995dcef93c6', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (74, 3, '2016-08-07 02:44:00', '2016-08-07 02:44:00', '2016-08-07 02:44:00', NULL, NULL, 'F', '20168724400-38efc138-f6b9-4ec0-9ea6-c8898cc3cdf6', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (75, 1, '2016-08-07 02:44:00', '2016-08-07 02:44:00', '2016-08-07 02:44:00', NULL, NULL, 'F', '20168724400-1812fa24-9c01-4d9b-a74e-c7106e43e61d', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (76, 4, '2016-08-07 02:44:00', '2016-08-07 02:44:00', '2016-08-07 02:44:00', NULL, NULL, 'F', '20168724400-9d008f0f-c499-4ad5-acd7-54d5e7d49ca8', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (77, 6, '2016-08-07 02:44:00', '2016-08-07 02:44:00', '2016-08-07 02:44:00', NULL, NULL, 'F', '20168724400-a68c0f09-14a8-470d-8457-15f277a404a3', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (78, 7, '2016-08-07 02:44:00', '2016-08-07 02:44:00', '2016-08-07 02:44:00', NULL, NULL, 'F', '20168724400-de66b47d-a269-4852-990b-90d619d9e8c1', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (79, 5, '2016-08-07 02:44:00', '2016-08-07 02:44:00', '2016-08-07 02:44:00', NULL, NULL, 'F', '20168724400-4c8104f4-ffca-4c14-9492-b1e8a87f0218', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (80, 8, '2016-08-07 02:44:00', '2016-08-07 02:44:00', '2016-08-07 02:44:00', NULL, NULL, 'F', '20168724400-206e0d1b-707b-401c-a953-2bee4097774f', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (81, 10, '2016-08-07 02:44:00', '2016-08-07 02:44:00', '2016-08-07 02:44:00', NULL, NULL, 'F', '20168724400-ef10e58b-5219-4444-a4dd-83f5c5d17ae8', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (82, 11, '2016-08-07 02:44:00', '2016-08-07 02:44:00', '2016-08-07 02:44:00', NULL, NULL, 'F', '20168724400-222fba2c-7ea8-4ec2-80db-0d2f4b297d54', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (83, 9, '2016-08-07 02:44:00', '2016-08-07 02:44:00', '2016-08-07 02:44:00', NULL, NULL, 'F', '20168724400-0b3d3187-ae31-4420-8a38-39a87ec55cab', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (84, 12, '2016-08-07 02:44:00', '2016-08-07 02:44:00', '2016-08-07 02:44:00', NULL, NULL, 'F', '20168724400-a1462dfe-321d-46e1-8934-aae21b7044ca', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (85, 2, '2016-08-07 02:45:00', '2016-08-07 02:45:00', '2016-08-07 02:45:00', NULL, NULL, 'F', '20168724500-a6736dd8-4090-44a8-81dd-7218fc00a078', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (86, 3, '2016-08-07 02:45:00', '2016-08-07 02:45:00', '2016-08-07 02:45:00', NULL, NULL, 'F', '20168724500-7c6b4e46-36e0-4781-9eec-c96317a7f191', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (87, 1, '2016-08-07 02:45:00', '2016-08-07 02:45:00', '2016-08-07 02:45:00', NULL, NULL, 'F', '20168724500-82d68572-2f9d-4a50-a078-88cf11f0d374', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (88, 4, '2016-08-07 02:45:00', '2016-08-07 02:45:00', '2016-08-07 02:45:00', NULL, NULL, 'F', '20168724500-b7f7afc6-e29e-440c-9235-ab2bcc182c57', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (89, 6, '2016-08-07 02:45:00', '2016-08-07 02:45:00', '2016-08-07 02:45:00', NULL, NULL, 'F', '20168724500-95bd58fe-bc10-49b4-aeb2-3d20263c241d', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (90, 7, '2016-08-07 02:45:00', '2016-08-07 02:45:00', '2016-08-07 02:45:00', NULL, NULL, 'F', '20168724500-bb273f8a-8d61-451d-a693-2e6bab3db212', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (91, 5, '2016-08-07 02:45:00', '2016-08-07 02:45:00', '2016-08-07 02:45:00', NULL, NULL, 'F', '20168724500-d57adf67-c3e4-49df-9aa7-84055db2ffe0', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (92, 8, '2016-08-07 02:45:00', '2016-08-07 02:45:00', '2016-08-07 02:45:00', NULL, NULL, 'F', '20168724500-c5f39345-3ad8-4dd9-813f-680e47ebe705', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (93, 10, '2016-08-07 02:45:00', '2016-08-07 02:45:00', '2016-08-07 02:45:00', NULL, NULL, 'F', '20168724500-00345026-924a-4c1e-965d-b35c46b0fb2a', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (94, 11, '2016-08-07 02:45:00', '2016-08-07 02:45:00', '2016-08-07 02:45:00', NULL, NULL, 'F', '20168724500-87269183-63c1-495d-b60a-6d33fb44ec4b', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (95, 9, '2016-08-07 02:45:00', '2016-08-07 02:45:00', '2016-08-07 02:45:00', NULL, NULL, 'F', '20168724500-33bb8979-2e09-4d1e-a11d-43772adb746b', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (96, 12, '2016-08-07 02:45:00', '2016-08-07 02:45:00', '2016-08-07 02:45:00', NULL, NULL, 'F', '20168724500-90aae188-de1a-4bc2-9e9a-5d40e7541f8f', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (97, 2, '2016-08-07 02:46:00', '2016-08-07 02:46:00', '2016-08-07 02:46:00', NULL, NULL, 'F', '20168724600-78d1c6c3-98bc-4c4f-bf1b-dfadf5db4338', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (98, 3, '2016-08-07 02:46:00', '2016-08-07 02:46:00', '2016-08-07 02:46:00', NULL, NULL, 'F', '20168724600-05641634-3d27-4a22-8298-5e86be05e58f', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (99, 1, '2016-08-07 02:46:00', '2016-08-07 02:46:00', '2016-08-07 02:46:00', NULL, NULL, 'F', '20168724600-2c889e8d-9462-46f2-b88e-40a670cecb59', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (100, 4, '2016-08-07 02:46:00', '2016-08-07 02:46:00', '2016-08-07 02:46:00', NULL, NULL, 'F', '20168724600-2c2e323d-a88f-44ea-a049-a1b2cbde1195', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (101, 6, '2016-08-07 02:47:00', '2016-08-07 02:47:00', '2016-08-07 02:47:00', NULL, NULL, 'F', '20168724700-af5c47a5-b1fd-40ba-8628-68753b7a3914', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (102, 7, '2016-08-07 02:47:00', '2016-08-07 02:47:00', '2016-08-07 02:47:00', NULL, NULL, 'F', '20168724700-26aa8d1d-bb4e-427a-8007-b405bc0fddbc', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (103, 5, '2016-08-07 02:47:00', '2016-08-07 02:47:00', '2016-08-07 02:47:00', NULL, NULL, 'F', '20168724700-7cea4745-8693-40f1-9ea5-07a658349a90', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (104, 8, '2016-08-07 02:47:00', '2016-08-07 02:47:00', '2016-08-07 02:47:00', NULL, NULL, 'F', '20168724700-146869d0-4cca-421d-92bf-8c2eef1fd22a', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (105, 10, '2016-08-07 02:47:00', '2016-08-07 02:47:00', '2016-08-07 02:47:00', NULL, NULL, 'F', '20168724700-3229d6d1-45e8-410a-94ce-d2e9ab073bbe', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (106, 11, '2016-08-07 02:47:00', '2016-08-07 02:47:00', '2016-08-07 02:47:00', NULL, NULL, 'F', '20168724700-f4ad648a-7bb5-474e-91a1-ed2c61991902', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (107, 9, '2016-08-07 02:47:00', '2016-08-07 02:47:00', '2016-08-07 02:47:00', NULL, NULL, 'F', '20168724700-5b387bf7-c05e-4b4d-a7c3-e00d7cbaf4ed', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (108, 12, '2016-08-07 02:47:00', '2016-08-07 02:47:00', '2016-08-07 02:47:00', NULL, NULL, 'F', '20168724700-990bf0b8-3fc6-4dd4-bbd9-603b6ccb2b4f', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (109, 2, '2016-08-07 02:49:00', '2016-08-07 02:49:00', '2016-08-07 02:49:00', NULL, NULL, 'F', '20168724900-e12e6c4f-9b2e-4246-87b8-12aeed32ae03', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (110, 3, '2016-08-07 02:49:00', '2016-08-07 02:49:00', '2016-08-07 02:49:00', NULL, NULL, 'F', '20168724900-2f883c08-7e49-456d-bbee-6744bc2e6d1c', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (111, 1, '2016-08-07 02:49:00', '2016-08-07 02:49:00', '2016-08-07 02:49:00', NULL, NULL, 'F', '20168724900-e56c8876-6ad5-4969-9c8e-b5e62c8ba514', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (112, 4, '2016-08-07 02:49:00', '2016-08-07 02:49:00', '2016-08-07 02:49:00', NULL, NULL, 'F', '20168724900-6e768c2c-1e8c-4e2d-8e27-e3ed994ab97f', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (113, 6, '2016-08-07 02:49:00', '2016-08-07 02:49:00', '2016-08-07 02:49:00', NULL, NULL, 'F', '20168724900-3a289d7b-479b-4c8c-9ee6-914d905ce559', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (114, 7, '2016-08-07 02:49:00', '2016-08-07 02:49:00', '2016-08-07 02:49:00', NULL, NULL, 'F', '20168724900-107f77fa-e742-4c14-b390-6695b51811fa', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (115, 5, '2016-08-07 02:49:00', '2016-08-07 02:49:00', '2016-08-07 02:49:00', NULL, NULL, 'F', '20168724900-7799ada1-ee57-4154-bfec-ea36ecf07930', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (116, 8, '2016-08-07 02:49:00', '2016-08-07 02:49:00', '2016-08-07 02:49:00', NULL, NULL, 'F', '20168724900-13497221-80b3-43d2-b223-2142f97eefe1', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (117, 10, '2016-08-07 02:49:00', '2016-08-07 02:49:00', '2016-08-07 02:49:00', NULL, NULL, 'F', '20168724900-56c4e28b-5772-4564-a99d-0e4fc5028349', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (118, 11, '2016-08-07 02:49:00', '2016-08-07 02:49:00', '2016-08-07 02:49:00', NULL, NULL, 'F', '20168724900-a56d57b5-d066-4ff0-a194-2daeceba0105', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (119, 9, '2016-08-07 02:49:00', '2016-08-07 02:49:00', '2016-08-07 02:49:00', NULL, NULL, 'F', '20168724900-0200f184-8a9e-47c9-badb-8f597721517e', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (120, 12, '2016-08-07 02:49:00', '2016-08-07 02:49:00', '2016-08-07 02:49:00', NULL, NULL, 'F', '20168724900-df3e9add-a939-4f61-8bef-0bc70194f073', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (121, 2, '2016-08-07 02:50:00', '2016-08-07 02:50:00', '2016-08-07 02:50:00', NULL, NULL, 'F', '20168725000-617be618-9d53-4734-b2a0-19897c7b907f', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (122, 3, '2016-08-07 02:50:00', '2016-08-07 02:50:00', '2016-08-07 02:50:00', NULL, NULL, 'F', '20168725000-b4baab41-85d4-4e5a-87c2-a98d01bdf9c7', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (123, 1, '2016-08-07 02:50:00', '2016-08-07 02:50:00', '2016-08-07 02:50:00', NULL, NULL, 'F', '20168725000-af4539f6-f133-480a-8746-a90594cd0ef0', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (124, 4, '2016-08-07 02:50:00', '2016-08-07 02:50:00', '2016-08-07 02:50:00', NULL, NULL, 'F', '20168725000-d6f7d9c7-9bd7-4feb-8089-c586b822dd29', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (125, 6, '2016-08-07 02:50:00', '2016-08-07 02:50:00', '2016-08-07 02:50:00', NULL, NULL, 'F', '20168725000-f8b004c3-0fbe-479a-9aaa-c70c52627628', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (126, 7, '2016-08-07 02:50:00', '2016-08-07 02:50:00', '2016-08-07 02:50:00', NULL, NULL, 'F', '20168725000-b78240b8-1aa6-4f2f-b292-a1207c384388', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (127, 5, '2016-08-07 02:50:00', '2016-08-07 02:50:00', '2016-08-07 02:50:00', NULL, NULL, 'F', '20168725000-6e718b5f-eca4-40c7-8c70-a0effefb6c86', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (128, 8, '2016-08-07 02:50:00', '2016-08-07 02:50:00', '2016-08-07 02:50:00', NULL, NULL, 'F', '20168725000-38383b3d-9349-4f3a-9da0-3139b1059209', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (129, 10, '2016-08-07 02:51:00', '2016-08-07 02:51:00', '2016-08-07 02:51:00', NULL, NULL, 'F', '20168725100-c06ece15-d4dc-4711-a898-2c831d18aadb', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (130, 11, '2016-08-07 02:51:00', '2016-08-07 02:51:00', '2016-08-07 02:51:00', NULL, NULL, 'F', '20168725100-dfcea544-038c-4f47-a06d-ed97cddb1177', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (131, 9, '2016-08-07 02:51:00', '2016-08-07 02:51:00', '2016-08-07 02:51:00', NULL, NULL, 'F', '20168725100-595ba7ab-c5e4-4356-952f-4986e3051df9', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (132, 12, '2016-08-07 02:51:00', '2016-08-07 02:51:00', '2016-08-07 02:51:00', NULL, NULL, 'F', '20168725100-3962a8a1-0485-4efa-bb32-c2bab5af0b32', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (133, 2, '2016-08-07 02:53:00', '2016-08-07 02:53:00', '2016-08-07 02:53:00', NULL, NULL, 'F', '20168725300-f2061e4e-df28-4724-a64e-88e2ff100532', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (134, 3, '2016-08-07 02:53:00', '2016-08-07 02:53:00', '2016-08-07 02:53:00', NULL, NULL, 'F', '20168725300-f8f77aab-b4f9-4755-8af8-954944499412', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (135, 1, '2016-08-07 02:53:00', '2016-08-07 02:53:00', '2016-08-07 02:53:00', NULL, NULL, 'F', '20168725300-d77eeb2f-853a-4889-a928-085625dacbab', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (136, 4, '2016-08-07 02:53:00', '2016-08-07 02:53:00', '2016-08-07 02:53:00', NULL, NULL, 'F', '20168725300-65ba60a1-21af-4c1c-af23-cf4dd7c3bdb4', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (137, 6, '2016-08-07 02:54:00', '2016-08-07 02:54:00', '2016-08-07 02:54:00', NULL, NULL, 'F', '20168725400-ab63c22e-fe0c-41f1-b486-4c7e5eafc922', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (138, 7, '2016-08-07 02:54:00', '2016-08-07 02:54:00', '2016-08-07 02:54:00', NULL, NULL, 'F', '20168725400-41711aee-4fee-4cb0-bf9d-dc1c0169db88', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (139, 5, '2016-08-07 02:54:00', '2016-08-07 02:54:00', '2016-08-07 02:54:00', NULL, NULL, 'F', '20168725400-c599059a-6ec2-4ad6-86fc-84b176c83f55', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (140, 8, '2016-08-07 02:54:00', '2016-08-07 02:54:00', '2016-08-07 02:54:00', NULL, NULL, 'F', '20168725400-a4ad2424-f1d4-4f42-b2da-1096a09c6435', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (141, 10, '2016-08-07 02:54:00', '2016-08-07 02:54:00', '2016-08-07 02:54:00', NULL, NULL, 'F', '20168725400-f8ed6ef6-e61a-40f8-83a4-f78fe3f61b27', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (142, 11, '2016-08-07 02:54:00', '2016-08-07 02:54:00', '2016-08-07 02:54:00', NULL, NULL, 'F', '20168725400-099c3b47-94ca-498d-b250-a29026d2ba45', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (143, 9, '2016-08-07 02:54:00', '2016-08-07 02:54:00', '2016-08-07 02:54:00', NULL, NULL, 'F', '20168725400-ccbaea90-c984-4352-8cf7-244cf362387d', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (144, 12, '2016-08-07 02:54:00', '2016-08-07 02:54:00', '2016-08-07 02:54:00', NULL, NULL, 'F', '20168725400-f3cdaad5-189a-4c83-bd35-1b9bf5ac0cbe', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (145, 2, '2016-08-07 02:58:00', '2016-08-07 02:58:00', '2016-08-07 02:58:00', NULL, NULL, 'F', '20168725800-30f4feac-3f2e-4eb8-aaf9-0c5b65cf90ba', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (146, 3, '2016-08-07 02:58:00', '2016-08-07 02:58:00', '2016-08-07 02:58:00', NULL, NULL, 'F', '20168725800-c635c155-fd72-40a5-a1dd-518eed4146a1', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (147, 1, '2016-08-07 02:58:00', '2016-08-07 02:58:00', '2016-08-07 02:58:00', NULL, NULL, 'F', '20168725800-445baffe-c98f-438f-86e8-82dee257c8d0', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (148, 4, '2016-08-07 02:58:00', '2016-08-07 02:58:00', '2016-08-07 02:58:00', NULL, NULL, 'F', '20168725800-44719314-1ce9-41f5-8608-315d677bc343', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (149, 6, '2016-08-07 02:59:00', '2016-08-07 02:59:00', '2016-08-07 02:59:00', NULL, NULL, 'F', '20168725900-6b99d67c-639a-4fc7-bbb2-c29abe209716', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (150, 7, '2016-08-07 02:59:00', '2016-08-07 02:59:00', '2016-08-07 02:59:00', NULL, NULL, 'F', '20168725900-cefeb128-1f98-4cca-8538-8c4a02e35a7e', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (151, 5, '2016-08-07 02:59:00', '2016-08-07 02:59:00', '2016-08-07 02:59:00', NULL, NULL, 'F', '20168725900-0f1c3291-10c6-4307-9d0e-aca0b35a94c4', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (152, 8, '2016-08-07 02:59:00', '2016-08-07 02:59:00', '2016-08-07 02:59:00', NULL, NULL, 'F', '20168725900-c8e3aa02-1529-4df1-8cbf-471512a66b21', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (153, 10, '2016-08-07 02:59:00', '2016-08-07 02:59:00', '2016-08-07 02:59:00', NULL, NULL, 'F', '20168725900-f0c4275d-465e-4bc2-9172-d52cf7d939ad', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (154, 11, '2016-08-07 02:59:00', '2016-08-07 02:59:00', '2016-08-07 02:59:00', NULL, NULL, 'F', '20168725900-64b49186-3327-49ab-ad48-165d449b9caa', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (155, 9, '2016-08-07 02:59:00', '2016-08-07 02:59:00', '2016-08-07 02:59:00', NULL, NULL, 'F', '20168725900-0f222389-64f9-4ed7-85d3-f38e264fba23', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (156, 12, '2016-08-07 02:59:00', '2016-08-07 02:59:00', '2016-08-07 02:59:00', NULL, NULL, 'F', '20168725900-6964c501-cbd8-46ef-b5ee-f42eda661571', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (157, 2, '2016-08-07 03:09:00', '2016-08-07 03:09:00', '2016-08-07 03:09:00', NULL, NULL, 'F', '20168730900-973fb8c3-d855-4194-bae6-d14635024143', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (158, 3, '2016-08-07 03:09:00', '2016-08-07 03:09:00', '2016-08-07 03:09:00', NULL, NULL, 'F', '20168730900-1842f075-8863-4024-ba0b-659f9aafaf76', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (159, 1, '2016-08-07 03:09:00', '2016-08-07 03:09:00', '2016-08-07 03:09:00', NULL, NULL, 'F', '20168730900-0e5728e5-fafc-4963-b791-25c3c5e3885f', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (160, 4, '2016-08-07 03:09:00', '2016-08-07 03:09:00', '2016-08-07 03:09:00', NULL, NULL, 'F', '20168730900-c9aaf905-75e0-4557-9417-605331d86d0e', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (161, 6, '2016-08-07 03:09:00', '2016-08-07 03:09:00', '2016-08-07 03:09:00', NULL, NULL, 'F', '20168730900-da7dce65-55b2-434f-b822-0dd2608b8ca2', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (162, 7, '2016-08-07 03:09:00', '2016-08-07 03:09:00', '2016-08-07 03:09:00', NULL, NULL, 'F', '20168730900-eca9f362-ad6f-402d-9e3a-c5247ee0f93c', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (163, 5, '2016-08-07 03:09:00', '2016-08-07 03:09:00', '2016-08-07 03:09:00', NULL, NULL, 'F', '20168730900-f4442670-056f-48e9-ab0c-3b9cff5a7f5e', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (164, 8, '2016-08-07 03:09:00', '2016-08-07 03:09:00', '2016-08-07 03:09:00', NULL, NULL, 'F', '20168730900-7cd20173-350b-44a0-9526-63312175a597', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (165, 10, '2016-08-07 03:10:00', '2016-08-07 03:10:00', '2016-08-07 03:10:00', NULL, NULL, 'F', '20168731000-2200c855-84c8-4b80-96b2-4a1f7b7f4332', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (166, 11, '2016-08-07 03:10:00', '2016-08-07 03:10:00', '2016-08-07 03:10:00', NULL, NULL, 'F', '20168731000-3ce4367f-b819-40bb-8f62-4ba0f0a2f46d', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (167, 9, '2016-08-07 03:10:00', '2016-08-07 03:10:00', '2016-08-07 03:10:00', NULL, NULL, 'F', '20168731000-6ab21bda-8492-4960-8d9d-6cf5ecee4a48', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (168, 12, '2016-08-07 03:10:00', '2016-08-07 03:10:00', '2016-08-07 03:10:00', NULL, NULL, 'F', '20168731000-43f4e284-1fba-4898-9ca5-bc708d4f1190', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (169, 2, '2016-08-07 03:15:00', '2016-08-07 03:15:00', '2016-08-07 03:15:00', NULL, NULL, 'F', '20168731500-9a706f79-7044-45fe-adb6-8b2bb664acf0', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (170, 3, '2016-08-07 03:15:00', '2016-08-07 03:15:00', '2016-08-07 03:15:00', NULL, NULL, 'F', '20168731500-eb4a1a7f-37ab-4460-a045-4f04ca42aa2b', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (171, 1, '2016-08-07 03:15:00', '2016-08-07 03:15:00', '2016-08-07 03:15:00', NULL, NULL, 'F', '20168731500-81fa5f30-0da7-43fc-8f21-6360beebcb4e', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (172, 4, '2016-08-07 03:15:00', '2016-08-07 03:15:00', '2016-08-07 03:15:00', NULL, NULL, 'F', '20168731500-d26ee454-d32f-4fd2-90ad-a7379f172f24', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (173, 6, '2016-08-07 03:15:00', '2016-08-07 03:15:00', '2016-08-07 03:15:00', NULL, NULL, 'F', '20168731500-0f971a95-1814-4cab-aebf-f32876dff368', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (174, 7, '2016-08-07 03:15:00', '2016-08-07 03:15:00', '2016-08-07 03:15:00', NULL, NULL, 'F', '20168731500-700e6187-c172-4bcf-9bbc-343080b8c9a6', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (175, 5, '2016-08-07 03:15:00', '2016-08-07 03:15:00', '2016-08-07 03:15:00', NULL, NULL, 'F', '20168731500-363c5092-6507-4f68-b00d-40a71e6ed922', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (176, 8, '2016-08-07 03:15:00', '2016-08-07 03:15:00', '2016-08-07 03:15:00', NULL, NULL, 'F', '20168731500-229e2350-5604-4c44-9362-02fbc2dc88ea', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (177, 10, '2016-08-07 03:15:00', '2016-08-07 03:15:00', '2016-08-07 03:15:00', NULL, NULL, 'F', '20168731500-29e7a450-b5c6-4e32-a032-9e8d3d10a9d0', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (178, 11, '2016-08-07 03:15:00', '2016-08-07 03:15:00', '2016-08-07 03:15:00', NULL, NULL, 'F', '20168731500-25e7d7bb-7b08-4831-895f-563fd1b28abb', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (179, 9, '2016-08-07 03:15:00', '2016-08-07 03:15:00', '2016-08-07 03:15:00', NULL, NULL, 'F', '20168731500-07a0ca44-0bb8-4539-8505-d6aed1d9336a', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (180, 12, '2016-08-07 03:15:00', '2016-08-07 03:15:00', '2016-08-07 03:15:00', NULL, NULL, 'F', '20168731500-3195af74-a3fd-4536-abe1-905ec95dbda0', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (181, 2, '2016-08-07 03:19:00', '2016-08-07 03:19:00', '2016-08-07 03:19:00', NULL, NULL, 'F', '20168731900-39268bf7-781c-48cd-8f2f-c9b7502d0d41', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (182, 3, '2016-08-07 03:19:00', '2016-08-07 03:19:00', '2016-08-07 03:19:00', NULL, NULL, 'F', '20168731900-093e23c9-1970-4294-ae2e-878c23a729b7', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (183, 1, '2016-08-07 03:19:00', '2016-08-07 03:19:00', '2016-08-07 03:19:00', NULL, NULL, 'F', '20168731900-988590e1-33c5-4b63-bcc8-ce348bee29dc', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (184, 4, '2016-08-07 03:19:00', '2016-08-07 03:19:00', '2016-08-07 03:19:00', NULL, NULL, 'F', '20168731900-91826c4e-94ab-4669-b5df-a2fad3959d45', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (185, 6, '2016-08-07 03:19:00', '2016-08-07 03:19:00', '2016-08-07 03:19:00', NULL, NULL, 'F', '20168731900-3f7545c8-9c1a-4be3-af33-9eb8eee3f62e', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (186, 7, '2016-08-07 03:19:00', '2016-08-07 03:19:00', '2016-08-07 03:19:00', NULL, NULL, 'F', '20168731900-cc1ab0b5-5ca2-43eb-9122-acbe71543a79', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (187, 5, '2016-08-07 03:19:00', '2016-08-07 03:19:00', '2016-08-07 03:19:00', NULL, NULL, 'F', '20168731900-abdba089-17f5-4b10-a0ba-b184f0b1ff48', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (188, 8, '2016-08-07 03:19:00', '2016-08-07 03:19:00', '2016-08-07 03:19:00', NULL, NULL, 'F', '20168731900-96f212a4-39b7-4118-b360-b9283bce2837', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (189, 10, '2016-08-07 03:19:00', '2016-08-07 03:19:00', '2016-08-07 03:19:00', NULL, NULL, 'F', '20168731900-1985febc-b07b-436f-98de-232e85f8d5b2', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (190, 11, '2016-08-07 03:19:00', '2016-08-07 03:19:00', '2016-08-07 03:19:00', NULL, NULL, 'F', '20168731900-a79b7173-237e-4df0-915b-7dc3dfd61214', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (191, 9, '2016-08-07 03:19:00', '2016-08-07 03:19:00', '2016-08-07 03:19:00', NULL, NULL, 'F', '20168731900-0a14a490-bac5-4b50-a747-1a4ee35f5d65', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (192, 12, '2016-08-07 03:19:00', '2016-08-07 03:19:00', '2016-08-07 03:19:00', NULL, NULL, 'F', '20168731900-8c3bfa84-13d1-4015-9cb5-0bc9971ae3bc', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (193, 2, '2016-08-07 03:21:00', '2016-08-07 03:21:00', '2016-08-07 03:21:00', NULL, NULL, 'F', '20168732100-48be3693-18f2-4201-8e34-da3f93b6482d', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (194, 3, '2016-08-07 03:21:00', '2016-08-07 03:21:00', '2016-08-07 03:21:00', NULL, NULL, 'F', '20168732100-4b1f2ec8-607b-4ce0-95bc-a9472d3ff2f1', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (195, 1, '2016-08-07 03:21:00', '2016-08-07 03:21:00', '2016-08-07 03:21:00', NULL, NULL, 'F', '20168732100-cb3d7ad5-baf3-45df-ba22-91d020956934', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (196, 4, '2016-08-07 03:21:00', '2016-08-07 03:21:00', '2016-08-07 03:21:00', NULL, NULL, 'F', '20168732100-e2d2fe34-7f7c-4086-8765-1f577ab0b802', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (197, 6, '2016-08-07 03:21:00', '2016-08-07 03:21:00', '2016-08-07 03:21:00', NULL, NULL, 'F', '20168732100-ce442a5c-effc-4b80-b26e-f9a9bfbedf70', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (198, 7, '2016-08-07 03:21:00', '2016-08-07 03:21:00', '2016-08-07 03:21:00', NULL, NULL, 'F', '20168732100-db0ebd63-7b28-472e-94b1-afade886694a', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (199, 5, '2016-08-07 03:21:00', '2016-08-07 03:21:00', '2016-08-07 03:21:00', NULL, NULL, 'F', '20168732100-42071492-e3fd-4088-b762-f8061662680c', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (200, 8, '2016-08-07 03:21:00', '2016-08-07 03:21:00', '2016-08-07 03:21:00', NULL, NULL, 'F', '20168732100-82b83045-8a72-4f76-a3fd-9867fabff432', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (201, 10, '2016-08-07 03:21:00', '2016-08-07 03:21:00', '2016-08-07 03:21:00', NULL, NULL, 'F', '20168732100-c8d4a44d-41a7-40ac-87e0-5ac485870462', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (202, 11, '2016-08-07 03:21:00', '2016-08-07 03:21:00', '2016-08-07 03:21:00', NULL, NULL, 'F', '20168732100-7ea30de7-6bfe-4dad-a66b-c730e49d631d', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (203, 9, '2016-08-07 03:21:00', '2016-08-07 03:21:00', '2016-08-07 03:21:00', NULL, NULL, 'F', '20168732100-bef71329-35c3-4f64-a7c9-c74f9d8f1afc', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (204, 12, '2016-08-07 03:21:00', '2016-08-07 03:21:00', '2016-08-07 03:21:00', NULL, NULL, 'F', '20168732100-09e1f766-1341-4b23-aa55-4f885f8d52e9', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (206, 7, '2016-09-16 00:14:00', '2016-09-16 00:14:00', '2016-09-16 00:14:00', NULL, NULL, 'F', '201691601400-8f3edc49-d2bc-412a-b98e-1d7945b07044', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (207, 5, '2016-09-16 00:14:00', '2016-09-16 00:14:00', '2016-09-16 00:14:00', NULL, NULL, 'F', '201691601400-f6d88bcc-2ecd-4167-b851-6c9eae26eccb', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (205, 6, '2016-09-16 00:14:00', '2016-09-16 00:14:00', '2016-09-16 00:14:00', NULL, NULL, 'F', '201691601400-40f2deff-bf6c-445f-99dc-9915b8628f86', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (208, 8, '2016-09-16 00:14:00', '2016-09-16 00:14:00', '2016-09-16 00:14:00', NULL, NULL, 'F', '201691601400-37f38622-f164-49f8-990d-b98d0748acef', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (209, 6, '2016-09-16 00:36:00', '2016-09-16 00:36:00', '2016-09-16 00:36:00', NULL, NULL, 'F', '201691603600-54761112-eebf-492f-b30e-7713ec6fe97a', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (212, 8, '2016-09-16 00:36:00', '2016-09-16 00:36:00', '2016-09-16 00:36:00', NULL, NULL, 'F', '201691603600-0791b929-1a58-4f31-8bad-a15b841754ce', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (213, 2, '2016-09-16 00:44:00', '2016-09-16 00:44:00', '2016-09-16 00:44:00', NULL, NULL, 'F', '201691604400-c1d72529-e29d-473c-899b-da74ac58b5dc', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (216, 4, '2016-09-16 00:44:00', '2016-09-16 00:44:00', '2016-09-16 00:44:00', NULL, NULL, 'F', '201691604400-4f475bf5-fd86-428c-bf9e-455efaf8c946', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (217, 10, '2016-09-16 00:44:00', '2016-09-16 00:44:00', '2016-09-16 00:44:00', NULL, NULL, 'F', '201691604400-d02a6ef1-d6d7-4ac3-b26a-2fbf28bbe55a', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (220, 12, '2016-09-16 00:44:00', '2016-09-16 00:44:00', '2016-09-16 00:44:00', NULL, NULL, 'F', '201691604400-d8f2689b-afeb-4b2a-8c81-0a451fde660b', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (221, 6, '2016-09-16 00:44:00', '2016-09-16 00:44:00', '2016-09-16 00:44:00', NULL, NULL, 'F', '201691604400-35e2e9bd-0b6a-4029-ae21-90e077cd4ffa', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (224, 8, '2016-09-16 00:44:00', '2016-09-16 00:44:00', '2016-09-16 00:44:00', NULL, NULL, 'F', '201691604400-5997c795-da05-4412-bad7-8c668e36aeec', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (225, 2, '2016-09-17 15:15:00', '2016-09-17 15:15:00', '2016-09-17 15:15:00', NULL, NULL, 'F', '2016917151500-0b987e8e-7e2f-4a95-9ee6-784af8e0e725', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (228, 4, '2016-09-17 15:15:00', '2016-09-17 15:15:00', '2016-09-17 15:15:00', NULL, NULL, 'F', '2016917151500-0796349b-34ec-4ebe-9f95-65e1f8d868ae', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (229, 10, '2016-09-17 15:15:00', '2016-09-17 15:15:00', '2016-09-17 15:15:00', NULL, NULL, 'F', '2016917151500-bd5d3e95-3a22-43f3-90f3-26b159d8606d', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (232, 12, '2016-09-17 15:15:00', '2016-09-17 15:15:00', '2016-09-17 15:15:00', NULL, NULL, 'F', '2016917151500-6292f5d1-375e-40a9-94a1-a32ebdf74ec6', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (233, 6, '2016-09-17 15:15:00', '2016-09-17 15:15:00', '2016-09-17 15:15:00', NULL, NULL, 'F', '2016917151500-66146839-9e06-4163-a944-51e23ab51fce', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (249, 2, '2016-09-17 17:28:00', '2016-09-17 17:28:00', '2016-09-17 17:28:00', NULL, NULL, 'F', '2016917172800-1f049fae-df76-412b-aefe-1ee611204753', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (252, 4, '2016-09-17 17:28:00', '2016-09-17 17:28:00', '2016-09-17 17:28:00', NULL, NULL, 'F', '2016917172800-08761e40-60cc-4c5b-8018-20da139822e4', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (253, 10, '2016-09-17 17:28:00', '2016-09-17 17:28:00', '2016-09-17 17:28:00', NULL, NULL, 'F', '2016917172800-0159ee63-00f9-4b0b-8775-d7c17e5c488b', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (256, 12, '2016-09-17 17:28:00', '2016-09-17 17:28:00', '2016-09-17 17:28:00', NULL, NULL, 'F', '2016917172800-4fbb3fc0-f1af-4966-b41a-58628efed538', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (257, 6, '2016-09-17 17:28:00', '2016-09-17 17:28:00', '2016-09-17 17:28:00', NULL, NULL, 'F', '2016917172800-ebf8dff5-352d-4ddd-88a6-26bce31950a0', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (260, 8, '2016-09-17 17:28:00', '2016-09-17 17:28:00', '2016-09-17 17:28:00', NULL, NULL, 'F', '2016917172800-8fb43084-2413-4690-a4dc-5560ab31d560', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (261, 2, '2016-09-17 17:32:00', '2016-09-17 17:32:00', '2016-09-17 17:32:00', NULL, NULL, 'F', '2016917173200-62942948-79dc-4d4d-bf55-8b1754264ab3', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (264, 4, '2016-09-17 17:32:00', '2016-09-17 17:32:00', '2016-09-17 17:32:00', NULL, NULL, 'F', '2016917173200-894d655b-ce53-4ec7-831e-a0daaa887fc2', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (265, 10, '2016-09-17 17:32:00', '2016-09-17 17:32:00', '2016-09-17 17:32:00', NULL, NULL, 'F', '2016917173200-6da19cb9-6a27-4e7b-8cf0-ffd85e35d09b', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (268, 12, '2016-09-17 17:32:00', '2016-09-17 17:32:00', '2016-09-17 17:32:00', NULL, NULL, 'F', '2016917173200-399ed1ec-d325-4857-a9fb-b37c655a8851', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (269, 6, '2016-09-17 17:32:00', '2016-09-17 17:32:00', '2016-09-17 17:32:00', NULL, NULL, 'F', '2016917173200-e40fda37-8182-4ba8-8f5e-c2a9094d7ad4', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (272, 8, '2016-09-17 17:32:00', '2016-09-17 17:32:00', '2016-09-17 17:32:00', NULL, NULL, 'F', '2016917173200-0a8d9a70-6662-4dc2-ba49-8cc1141f1ee4', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (273, 2, '2016-09-17 18:04:00', '2016-09-17 18:04:00', '2016-09-17 18:04:00', NULL, NULL, 'F', '2016917180400-cd0d7b93-d172-44b6-884e-8ae43e71e099', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (276, 4, '2016-09-17 18:04:00', '2016-09-17 18:04:00', '2016-09-17 18:04:00', NULL, NULL, 'F', '2016917180400-f1d4a0d1-1b5a-437e-8394-b0fdd4de7767', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (277, 10, '2016-09-17 18:04:00', '2016-09-17 18:04:00', '2016-09-17 18:04:00', NULL, NULL, 'F', '2016917180400-1b6c6518-a40b-4fa9-8de6-6611b0455c91', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (280, 12, '2016-09-17 18:04:00', '2016-09-17 18:04:00', '2016-09-17 18:04:00', NULL, NULL, 'F', '2016917180400-b22eb05a-0f76-488b-a9b9-30aa213cc99a', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (281, 6, '2016-09-17 18:04:00', '2016-09-17 18:04:00', '2016-09-17 18:04:00', NULL, NULL, 'F', '2016917180400-d64d5d00-dc57-4028-b00a-b867c44b2cdc', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (284, 8, '2016-09-17 18:04:00', '2016-09-17 18:04:00', '2016-09-17 18:04:00', NULL, NULL, 'F', '2016917180400-482199a9-ddde-4af4-80bf-14eec396a114', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (285, 2, '2016-09-17 18:23:00', '2016-09-17 18:23:00', '2016-09-17 18:23:00', NULL, NULL, 'F', '2016917182300-084da98d-1c03-4790-9077-5e9c01ae4332', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (288, 4, '2016-09-17 18:23:00', '2016-09-17 18:23:00', '2016-09-17 18:23:00', NULL, NULL, 'F', '2016917182300-ccea5f8d-d124-4081-83b5-2becb45dcb6e', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (289, 10, '2016-09-17 18:23:00', '2016-09-17 18:23:00', '2016-09-17 18:23:00', NULL, NULL, 'F', '2016917182300-0c75ae47-2a7d-45f2-a12c-d20aa2faa027', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (292, 12, '2016-09-17 18:23:00', '2016-09-17 18:23:00', '2016-09-17 18:23:00', NULL, NULL, 'F', '2016917182300-5cf9060e-280f-4fae-9159-80b16fc23abc', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (293, 6, '2016-09-17 18:23:00', '2016-09-17 18:23:00', '2016-09-17 18:23:00', NULL, NULL, 'F', '2016917182300-a1ff5a5b-58a2-45e8-9296-84cace789c9e', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (296, 8, '2016-09-17 18:23:00', '2016-09-17 18:23:00', '2016-09-17 18:23:00', NULL, NULL, 'F', '2016917182300-c70ad95a-b221-4b7d-a3d2-118d14e41e17', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (297, 2, '2016-09-17 20:24:00', '2016-09-17 20:24:00', '2016-09-17 20:24:00', NULL, NULL, 'F', '2016917202400-cd663618-3a92-4a97-831f-74e26b972775', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (298, 3, '2016-09-17 20:24:00', '2016-09-17 20:24:00', '2016-09-17 20:24:00', NULL, NULL, 'F', '2016917202400-7d72c29a-a8e1-4d48-a772-98ed19d0ade5', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (299, 1, '2016-09-17 20:24:00', '2016-09-17 20:24:00', '2016-09-17 20:24:00', NULL, NULL, 'F', '2016917202400-856e025b-5f26-4350-857d-736d537aabe9', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (300, 4, '2016-09-17 20:24:00', '2016-09-17 20:24:00', '2016-09-17 20:24:00', NULL, NULL, 'F', '2016917202400-f970bc14-2cba-4a87-86fa-bb6e9f8b7b61', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (301, 10, '2016-09-17 20:24:00', '2016-09-17 20:24:00', '2016-09-17 20:24:00', NULL, NULL, 'F', '2016917202400-46c36b85-f457-4bce-a1ef-1b7cceebbd98', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (302, 11, '2016-09-17 20:24:00', '2016-09-17 20:24:00', '2016-09-17 20:24:00', NULL, NULL, 'F', '2016917202400-7d6bd8e5-152b-4830-bc41-77b6ad1d6d84', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (303, 9, '2016-09-17 20:24:00', '2016-09-17 20:24:00', '2016-09-17 20:24:00', NULL, NULL, 'F', '2016917202400-3b1b1f14-c528-476c-a5bd-75408f9e80ea', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (304, 12, '2016-09-17 20:24:00', '2016-09-17 20:24:00', '2016-09-17 20:24:00', NULL, NULL, 'F', '2016917202400-40fcf688-f19c-4feb-b3a5-7b9cd5159f0a', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (305, 6, '2016-09-17 20:24:00', '2016-09-17 20:24:00', '2016-09-17 20:24:00', NULL, NULL, 'F', '2016917202400-3f3fc688-392c-479d-bcdf-6db4796c0847', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (306, 7, '2016-09-17 20:24:00', '2016-09-17 20:24:00', '2016-09-17 20:24:00', NULL, NULL, 'F', '2016917202400-1ff66248-ed2b-4b8b-b4ae-9092b0dbd242', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (307, 5, '2016-09-17 20:24:00', '2016-09-17 20:24:00', '2016-09-17 20:24:00', NULL, NULL, 'F', '2016917202400-da1d6215-3359-4f08-abf1-a3db0c4ddc92', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (308, 8, '2016-09-17 20:24:00', '2016-09-17 20:24:00', '2016-09-17 20:24:00', NULL, NULL, 'F', '2016917202400-9d6e58fa-a663-452d-8584-67a2930751b2', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (321, 2, '2016-09-17 20:31:00', '2016-09-17 20:31:00', '2016-09-17 20:31:00', NULL, NULL, 'F', '2016917203100-8f43682d-a23e-4baf-b705-b8d932e44106', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (322, 3, '2016-09-17 20:31:00', '2016-09-17 20:31:00', '2016-09-17 20:31:00', NULL, NULL, 'F', '2016917203100-104763f1-79ec-455e-a30c-2df2d2430775', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (323, 1, '2016-09-17 20:31:00', '2016-09-17 20:31:00', '2016-09-17 20:31:00', NULL, NULL, 'F', '2016917203100-8fca664e-653a-47be-8ea3-dedeac7dbb24', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (324, 4, '2016-09-17 20:31:00', '2016-09-17 20:31:00', '2016-09-17 20:31:00', NULL, NULL, 'F', '2016917203100-bafae239-dd6a-4b5b-8586-8c91d5028897', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (325, 10, '2016-09-17 20:31:00', '2016-09-17 20:31:00', '2016-09-17 20:31:00', NULL, NULL, 'F', '2016917203100-29143dba-7dfd-4325-aefa-8364c58e8338', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (326, 11, '2016-09-17 20:31:00', '2016-09-17 20:31:00', '2016-09-17 20:31:00', NULL, NULL, 'F', '2016917203100-224fab2c-cd2c-4754-94b2-b677b58ce2d2', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (327, 9, '2016-09-17 20:31:00', '2016-09-17 20:31:00', '2016-09-17 20:31:00', NULL, NULL, 'F', '2016917203100-9e1cab7d-b2f9-4564-a139-3fc90630232f', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (328, 12, '2016-09-17 20:31:00', '2016-09-17 20:31:00', '2016-09-17 20:31:00', NULL, NULL, 'F', '2016917203100-2c4841ff-9f97-4c92-a01e-879b9f757321', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (329, 6, '2016-09-17 20:31:00', '2016-09-17 20:31:00', '2016-09-17 20:31:00', NULL, NULL, 'F', '2016917203100-80b5f244-0c1b-42aa-9ea3-056a7c32de8b', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (330, 7, '2016-09-17 20:31:00', '2016-09-17 20:31:00', '2016-09-17 20:31:00', NULL, NULL, 'F', '2016917203100-0b8ed891-a014-43d2-b0e7-b5e297fa2f46', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (331, 5, '2016-09-17 20:31:00', '2016-09-17 20:31:00', '2016-09-17 20:31:00', NULL, NULL, 'F', '2016917203100-e32cb65f-a443-4ac1-8571-4f23545f6084', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (332, 8, '2016-09-17 20:31:00', '2016-09-17 20:31:00', '2016-09-17 20:31:00', NULL, NULL, 'F', '2016917203100-b753abb9-909f-4368-a1fc-cff96a43fc28', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (333, 2, '2016-09-25 16:37:00', '2016-09-25 16:37:00', '2016-09-25 16:37:00', NULL, NULL, 'F', '2016925163700-5e108252-8678-4c61-855e-96e0ca1491f4', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (334, 3, '2016-09-25 16:37:00', '2016-09-25 16:37:00', '2016-09-25 16:37:00', NULL, NULL, 'F', '2016925163700-ea0e111d-f361-4b23-b2fb-05dbcfdb2b1d', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (335, 1, '2016-09-25 16:37:00', '2016-09-25 16:37:00', '2016-09-25 16:37:00', NULL, NULL, 'F', '2016925163700-63922b93-88ab-44d7-89f7-e54418e2446a', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (336, 4, '2016-09-25 16:37:00', '2016-09-25 16:37:00', '2016-09-25 16:37:00', NULL, NULL, 'F', '2016925163700-bc9844ff-e2ff-404b-a7ed-186032c0a3ad', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (337, 10, '2016-09-25 16:37:00', '2016-09-25 16:37:00', '2016-09-25 16:37:00', NULL, NULL, 'F', '2016925163700-b2f835ce-732c-4bb2-90eb-588e6323ff10', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (338, 11, '2016-09-25 16:37:00', '2016-09-25 16:37:00', '2016-09-25 16:37:00', NULL, NULL, 'F', '2016925163700-582a4478-b6c2-405d-99e4-2e2fb61551ca', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (339, 9, '2016-09-25 16:37:00', '2016-09-25 16:37:00', '2016-09-25 16:37:00', NULL, NULL, 'F', '2016925163700-948cce45-68e1-4f07-b9f7-c629081787ac', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (340, 12, '2016-09-25 16:37:00', '2016-09-25 16:37:00', '2016-09-25 16:37:00', NULL, NULL, 'F', '2016925163700-755f6449-b6da-4eac-ae7f-28b38e168c0f', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (341, 6, '2016-09-25 16:37:00', '2016-09-25 16:37:00', '2016-09-25 16:37:00', NULL, NULL, 'F', '2016925163700-6b4a104b-d1f0-4b1f-a4c9-02ff67f27f3c', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (342, 7, '2016-09-25 16:37:00', '2016-09-25 16:37:00', '2016-09-25 16:37:00', NULL, NULL, 'F', '2016925163700-b619b866-3ca6-4a60-9666-83006cc6b9e6', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (343, 5, '2016-09-25 16:37:00', '2016-09-25 16:37:00', '2016-09-25 16:37:00', NULL, NULL, 'F', '2016925163700-46e82fd5-310e-4926-b450-91478a3d46f5', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (344, 8, '2016-09-25 16:37:00', '2016-09-25 16:37:00', '2016-09-25 16:37:00', NULL, NULL, 'F', '2016925163700-cf079ce7-8f8e-42c4-93f3-7e9698151f4c', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (345, 2, '2016-09-25 16:49:00', '2016-09-25 16:49:00', '2016-09-25 16:49:00', NULL, NULL, 'F', '2016925164900-4e5ea82a-165d-4746-af7b-9201e1d6e526', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (346, 3, '2016-09-25 16:49:00', '2016-09-25 16:49:00', '2016-09-25 16:49:00', NULL, NULL, 'F', '2016925164900-fdee7998-9834-4f52-821e-76c5efe378b1', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (347, 1, '2016-09-25 16:49:00', '2016-09-25 16:49:00', '2016-09-25 16:49:00', NULL, NULL, 'F', '2016925164900-28e36112-645f-4dce-8140-c417429a5e2c', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (348, 4, '2016-09-25 16:49:00', '2016-09-25 16:49:00', '2016-09-25 16:49:00', NULL, NULL, 'F', '2016925164900-822cdc80-99d7-4ebc-bda4-9dd76b677a0a', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (349, 10, '2016-09-25 16:49:00', '2016-09-25 16:49:00', '2016-09-25 16:49:00', NULL, NULL, 'F', '2016925164900-e75b2205-2d11-4c8e-a38b-1e7989bd4171', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (350, 11, '2016-09-25 16:49:00', '2016-09-25 16:49:00', '2016-09-25 16:49:00', NULL, NULL, 'F', '2016925164900-a58a08d8-d492-4a80-b84d-2b2695bdb8d3', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (351, 9, '2016-09-25 16:49:00', '2016-09-25 16:49:00', '2016-09-25 16:49:00', NULL, NULL, 'F', '2016925164900-4b8adaca-4689-4814-b0f4-4206e3df8e23', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (352, 12, '2016-09-25 16:49:00', '2016-09-25 16:49:00', '2016-09-25 16:49:00', NULL, NULL, 'F', '2016925164900-4bdf88a8-4283-443a-8266-ea534f32e2f7', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (353, 6, '2016-09-25 16:49:00', '2016-09-25 16:49:00', '2016-09-25 16:49:00', NULL, NULL, 'F', '2016925164900-8fdc9e01-6389-4aab-8041-b6734c19b9b0', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (354, 7, '2016-09-25 16:49:00', '2016-09-25 16:49:00', '2016-09-25 16:49:00', NULL, NULL, 'F', '2016925164900-5edb4ea9-d4c4-40af-b6e3-3e5e1d601ef7', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (355, 5, '2016-09-25 16:49:00', '2016-09-25 16:49:00', '2016-09-25 16:49:00', NULL, NULL, 'F', '2016925164900-49513630-0d64-4b72-89f4-fd7a39a13a62', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (356, 8, '2016-09-25 16:49:00', '2016-09-25 16:49:00', '2016-09-25 16:49:00', NULL, NULL, 'F', '2016925164900-2003f4bb-5e9a-4eec-894b-d199ddde31e3', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (357, 2, '2016-09-25 16:59:00', '2016-09-25 16:59:00', '2016-09-25 16:59:00', NULL, NULL, 'F', '2016925165900-a01a2caf-975d-4e11-9b6a-9fec585d3b47', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (358, 3, '2016-09-25 16:59:00', '2016-09-25 16:59:00', '2016-09-25 16:59:00', NULL, NULL, 'F', '2016925165900-32cf34bc-fafe-49d6-a5e3-a5efba9401c8', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (359, 1, '2016-09-25 16:59:00', '2016-09-25 16:59:00', '2016-09-25 16:59:00', NULL, NULL, 'F', '2016925165900-d3d8eb11-2ee4-4114-b4bd-e1c80f7e3c8b', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (360, 4, '2016-09-25 16:59:00', '2016-09-25 16:59:00', '2016-09-25 16:59:00', NULL, NULL, 'F', '2016925165900-c44f7ac7-d12d-4822-8754-a3f2e94f66d4', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (361, 10, '2016-09-25 16:59:00', '2016-09-25 16:59:00', '2016-09-25 16:59:00', NULL, NULL, 'F', '2016925165900-4329ae17-82a0-4fb8-bec7-ea725da47fde', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (362, 11, '2016-09-25 16:59:00', '2016-09-25 16:59:00', '2016-09-25 16:59:00', NULL, NULL, 'F', '2016925165900-33258ccf-e536-408d-9d37-94b0f321549d', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (363, 9, '2016-09-25 16:59:00', '2016-09-25 16:59:00', '2016-09-25 16:59:00', NULL, NULL, 'F', '2016925165900-28c23327-1139-41b9-b900-6b6444a7ba12', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (364, 12, '2016-09-25 16:59:00', '2016-09-25 16:59:00', '2016-09-25 16:59:00', NULL, NULL, 'F', '2016925165900-37b1533f-0879-4dc9-bd5f-920dbed0b3b3', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (365, 6, '2016-09-25 16:59:00', '2016-09-25 16:59:00', '2016-09-25 16:59:00', NULL, NULL, 'F', '2016925165900-c358fdbd-df97-4d97-8002-e8bd9b85bd6b', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (366, 7, '2016-09-25 16:59:00', '2016-09-25 16:59:00', '2016-09-25 16:59:00', NULL, NULL, 'F', '2016925165900-53f1a51f-d0dc-4a61-9516-aa7c114b0b9b', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (367, 5, '2016-09-25 16:59:00', '2016-09-25 16:59:00', '2016-09-25 16:59:00', NULL, NULL, 'F', '2016925165900-9f984533-a2ed-4c1b-847b-a75471e13458', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (368, 8, '2016-09-25 16:59:00', '2016-09-25 16:59:00', '2016-09-25 16:59:00', NULL, NULL, 'F', '2016925165900-1031ccb4-cc22-405a-9c80-7fab3fe4040d', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (373, 10, '2016-09-25 17:00:00', '2016-09-25 17:00:00', '2016-09-25 17:00:00', NULL, NULL, 'F', '2016925170000-98270ce6-d1d6-47db-a89c-16d7b111befb', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (374, 11, '2016-09-25 17:00:00', '2016-09-25 17:00:00', '2016-09-25 17:00:00', NULL, NULL, 'F', '2016925170000-1ae1902c-0db7-4154-9c2d-e3ea6c171442', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (375, 9, '2016-09-25 17:00:00', '2016-09-25 17:00:00', '2016-09-25 17:00:00', NULL, NULL, 'F', '2016925170000-6f46ed24-ca90-413c-b556-5f2550e62691', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (376, 12, '2016-09-25 17:00:00', '2016-09-25 17:00:00', '2016-09-25 17:00:00', NULL, NULL, 'F', '2016925170000-4cbb9a18-bb6d-437a-903d-63f7b869e327', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (377, 6, '2016-09-25 17:00:00', '2016-09-25 17:00:00', '2016-09-25 17:00:00', NULL, NULL, 'F', '2016925170000-5f0536c5-7031-463b-afaa-1ca40f72f9ea', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (378, 7, '2016-09-25 17:00:00', '2016-09-25 17:00:00', '2016-09-25 17:00:00', NULL, NULL, 'F', '2016925170000-65f04e34-b44e-4264-a658-2e44ec5b5dc4', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (379, 5, '2016-09-25 17:00:00', '2016-09-25 17:00:00', '2016-09-25 17:00:00', NULL, NULL, 'F', '2016925170000-9046352e-61f1-40ff-8e83-4716d01f5207', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (380, 8, '2016-09-25 17:00:00', '2016-09-25 17:00:00', '2016-09-25 17:00:00', NULL, NULL, 'F', '2016925170000-b773efc6-d595-4816-baa0-a2ec7c10c533', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (381, 2, '2016-09-25 17:00:00', '2016-09-25 17:00:00', '2016-09-25 17:00:00', NULL, NULL, 'F', '2016925170000-132bd2c2-fede-478f-84b6-ab795532e74a', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (382, 3, '2016-09-25 17:00:00', '2016-09-25 17:00:00', '2016-09-25 17:00:00', NULL, NULL, 'F', '2016925170000-f8e21019-8f33-429e-b31e-261662a97e70', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (383, 1, '2016-09-25 17:00:00', '2016-09-25 17:00:00', '2016-09-25 17:00:00', NULL, NULL, 'F', '2016925170000-899c1f0e-7d18-40b9-b559-387df26b9906', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (384, 4, '2016-09-25 17:00:00', '2016-09-25 17:00:00', '2016-09-25 17:00:00', NULL, NULL, 'F', '2016925170000-6891428a-40ed-4a86-ab44-cd0b4c2a8670', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (389, 6, '2016-09-25 17:01:00', '2016-09-25 17:01:00', '2016-09-25 17:01:00', NULL, NULL, 'F', '2016925170100-472c5666-c70a-48cc-a84f-11881025fb57', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (390, 7, '2016-09-25 17:01:00', '2016-09-25 17:01:00', '2016-09-25 17:01:00', NULL, NULL, 'F', '2016925170100-4497e97f-3583-451d-911d-3ad4a3c11d5c', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (391, 5, '2016-09-25 17:01:00', '2016-09-25 17:01:00', '2016-09-25 17:01:00', NULL, NULL, 'F', '2016925170100-df56ea4c-dc9e-43cf-bb4b-92f7594e9901', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (392, 8, '2016-09-25 17:01:00', '2016-09-25 17:01:00', '2016-09-25 17:01:00', NULL, NULL, 'F', '2016925170100-1a50b3c3-af0b-4020-8126-f3aab8787c67', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (393, 2, '2016-09-25 17:09:00', '2016-09-25 17:09:00', '2016-09-25 17:09:00', NULL, NULL, 'F', '2016925170900-79324632-5fd1-46fb-b2c2-371289e44adf', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (394, 3, '2016-09-25 17:09:00', '2016-09-25 17:09:00', '2016-09-25 17:09:00', NULL, NULL, 'F', '2016925170900-6c66500d-27d3-435c-b638-2ca769134eac', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (395, 1, '2016-09-25 17:09:00', '2016-09-25 17:09:00', '2016-09-25 17:09:00', NULL, NULL, 'F', '2016925170900-167f617f-e5a2-445f-8467-8f09e1e49ef2', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (396, 4, '2016-09-25 17:09:00', '2016-09-25 17:09:00', '2016-09-25 17:09:00', NULL, NULL, 'F', '2016925170900-077bf198-aaf4-4ae3-9210-6476ee6bc18d', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (397, 10, '2016-09-25 17:09:00', '2016-09-25 17:09:00', '2016-09-25 17:09:00', NULL, NULL, 'F', '2016925170900-7fd083fa-8873-45e9-b108-1eadf27fd937', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (398, 11, '2016-09-25 17:09:00', '2016-09-25 17:09:00', '2016-09-25 17:09:00', NULL, NULL, 'F', '2016925170900-5355fec8-803f-464c-8fe3-603b5aa8574f', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (399, 9, '2016-09-25 17:09:00', '2016-09-25 17:09:00', '2016-09-25 17:09:00', NULL, NULL, 'F', '2016925170900-1d28bbd7-af43-4639-bc7a-a04a0de58e99', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (400, 12, '2016-09-25 17:09:00', '2016-09-25 17:09:00', '2016-09-25 17:09:00', NULL, NULL, 'F', '2016925170900-57d1fb2b-cc4d-49c5-9d4f-bfa2fd62e16c', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (401, 6, '2016-09-25 17:09:00', '2016-09-25 17:09:00', '2016-09-25 17:09:00', NULL, NULL, 'F', '2016925170900-d3779039-07d2-410b-809e-56a1e60bda9d', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (402, 7, '2016-09-25 17:09:00', '2016-09-25 17:09:00', '2016-09-25 17:09:00', NULL, NULL, 'F', '2016925170900-a1dad7e3-be42-4e52-adb6-a399dc6fa8f3', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (403, 5, '2016-09-25 17:09:00', '2016-09-25 17:09:00', '2016-09-25 17:09:00', NULL, NULL, 'F', '2016925170900-e056d1a8-909f-4aba-9264-4e169964afbd', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (404, 8, '2016-09-25 17:09:00', '2016-09-25 17:09:00', '2016-09-25 17:09:00', NULL, NULL, 'F', '2016925170900-ba731a34-0262-4e81-b585-34da2a9e434c', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (409, 10, '2016-09-25 17:10:00', '2016-09-25 17:10:00', '2016-09-25 17:10:00', NULL, NULL, 'F', '2016925171000-709dc1cc-ffa9-4407-bcb0-594eb3682b86', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (410, 11, '2016-09-25 17:10:00', '2016-09-25 17:10:00', '2016-09-25 17:10:00', NULL, NULL, 'F', '2016925171000-73c520df-c888-49d2-9078-7bbbdc1e61ee', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (411, 9, '2016-09-25 17:10:00', '2016-09-25 17:10:00', '2016-09-25 17:10:00', NULL, NULL, 'F', '2016925171000-d5b2327d-80fe-45a0-81f6-39480b29fafa', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (412, 12, '2016-09-25 17:10:00', '2016-09-25 17:10:00', '2016-09-25 17:10:00', NULL, NULL, 'F', '2016925171000-d4411ef2-ca86-4518-a2ef-03224758a9f0', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (413, 6, '2016-09-25 17:10:00', '2016-09-25 17:10:00', '2016-09-25 17:10:00', NULL, NULL, 'F', '2016925171000-8fc503c6-7b9d-47c9-94fa-24e1c329d725', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (414, 7, '2016-09-25 17:10:00', '2016-09-25 17:10:00', '2016-09-25 17:10:00', NULL, NULL, 'F', '2016925171000-2f7f2924-3532-4736-9bb5-ee0a839408f8', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (415, 5, '2016-09-25 17:10:00', '2016-09-25 17:10:00', '2016-09-25 17:10:00', NULL, NULL, 'F', '2016925171000-341aff0b-991d-4aca-b4b8-fbec4c5a431a', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (416, 8, '2016-09-25 17:10:00', '2016-09-25 17:10:00', '2016-09-25 17:10:00', NULL, NULL, 'F', '2016925171000-4b4ef430-17a8-43c0-9344-51067c80ce76', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (417, 2, '2016-09-25 17:10:00', '2016-09-25 17:10:00', '2016-09-25 17:10:00', NULL, NULL, 'F', '2016925171000-7c16fe8d-3fbc-43b8-9352-29ef74cef258', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (418, 3, '2016-09-25 17:10:00', '2016-09-25 17:10:00', '2016-09-25 17:10:00', NULL, NULL, 'F', '2016925171000-3f5ebb08-d697-4f13-b9de-32254d07e615', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (419, 1, '2016-09-25 17:10:00', '2016-09-25 17:10:00', '2016-09-25 17:10:00', NULL, NULL, 'F', '2016925171000-1ca76bb7-43e6-4ecf-bb34-48be1604c5f1', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (420, 4, '2016-09-25 17:10:00', '2016-09-25 17:10:00', '2016-09-25 17:10:00', NULL, NULL, 'F', '2016925171000-0f1b0791-d6c7-4b32-b2ae-5a927b6e64ea', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (425, 6, '2016-09-25 17:11:00', '2016-09-25 17:11:00', '2016-09-25 17:11:00', NULL, NULL, 'F', '2016925171100-949ed752-0653-44be-b76c-0df115d856f9', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (426, 7, '2016-09-25 17:11:00', '2016-09-25 17:11:00', '2016-09-25 17:11:00', NULL, NULL, 'F', '2016925171100-60a0c5ef-3ae7-4d10-83e1-d3635a6b9bf3', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (427, 5, '2016-09-25 17:11:00', '2016-09-25 17:11:00', '2016-09-25 17:11:00', NULL, NULL, 'F', '2016925171100-f2dc427c-c1d0-4b51-967d-20aa491e5cbc', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (428, 8, '2016-09-25 17:11:00', '2016-09-25 17:11:00', '2016-09-25 17:11:00', NULL, NULL, 'F', '2016925171100-4fc978f1-18ba-4bfb-8ee6-548bf81900e1', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (429, 2, '2016-09-25 17:11:00', '2016-09-25 17:11:00', '2016-09-25 17:11:00', NULL, NULL, 'F', '2016925171100-5d16bc91-09c5-4639-92ad-c467e639fe1e', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (430, 3, '2016-09-25 17:11:00', '2016-09-25 17:11:00', '2016-09-25 17:11:00', NULL, NULL, 'F', '2016925171100-288f645d-2895-46e2-a6f3-500332d77edb', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (431, 1, '2016-09-25 17:11:00', '2016-09-25 17:11:00', '2016-09-25 17:11:00', NULL, NULL, 'F', '2016925171100-52c04838-d543-4f2b-94c1-b09895dd5a9a', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (432, 4, '2016-09-25 17:11:00', '2016-09-25 17:11:00', '2016-09-25 17:11:00', NULL, NULL, 'F', '2016925171100-7eae9ec0-a4ff-4a9f-811b-24076cc52892', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (433, 10, '2016-09-25 17:11:00', '2016-09-25 17:11:00', '2016-09-25 17:11:00', NULL, NULL, 'F', '2016925171100-0a829044-db33-48bd-a886-eb900bbb624d', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (434, 11, '2016-09-25 17:11:00', '2016-09-25 17:11:00', '2016-09-25 17:11:00', NULL, NULL, 'F', '2016925171100-6c9d08ec-2f4a-4003-864c-b84afdb9642e', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (435, 9, '2016-09-25 17:11:00', '2016-09-25 17:11:00', '2016-09-25 17:11:00', NULL, NULL, 'F', '2016925171100-0db4dc07-e3bc-49ea-bed7-c3ae7544e6e6', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (436, 12, '2016-09-25 17:11:00', '2016-09-25 17:11:00', '2016-09-25 17:11:00', NULL, NULL, 'F', '2016925171100-50fa45c5-9a09-459e-ae9a-458b860f0f5f', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (441, 2, '2016-09-25 17:12:00', '2016-09-25 17:12:00', '2016-09-25 17:12:00', NULL, NULL, 'F', '2016925171200-b2b99560-d593-4808-9a65-8c607602f257', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (442, 3, '2016-09-25 17:12:00', '2016-09-25 17:12:00', '2016-09-25 17:12:00', NULL, NULL, 'F', '2016925171200-28247b89-b199-47d4-a8a2-cabd780e966f', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (443, 1, '2016-09-25 17:12:00', '2016-09-25 17:12:00', '2016-09-25 17:12:00', NULL, NULL, 'F', '2016925171200-45b5d512-f6d1-413f-8ff4-66fcef0fa4e6', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (444, 4, '2016-09-25 17:12:00', '2016-09-25 17:12:00', '2016-09-25 17:12:00', NULL, NULL, 'F', '2016925171200-84e42e0a-c9a2-47a2-9dea-bd6405f70f9c', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (445, 10, '2016-09-25 17:12:00', '2016-09-25 17:12:00', '2016-09-25 17:12:00', NULL, NULL, 'F', '2016925171200-9dc23536-7ccf-4992-971c-5f903ba7eb68', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (446, 11, '2016-09-25 17:12:00', '2016-09-25 17:12:00', '2016-09-25 17:12:00', NULL, NULL, 'F', '2016925171200-a2c0e406-8c08-409a-ba8f-3ee09fa6aaa6', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (447, 9, '2016-09-25 17:12:00', '2016-09-25 17:12:00', '2016-09-25 17:12:00', NULL, NULL, 'F', '2016925171200-96484d3a-0ddf-4adc-b79c-a45ac22c8cb9', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (448, 12, '2016-09-25 17:12:00', '2016-09-25 17:12:00', '2016-09-25 17:12:00', NULL, NULL, 'F', '2016925171200-fe1a2438-3b37-4408-a1e0-2f67ab85a48b', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (449, 6, '2016-09-25 17:12:00', '2016-09-25 17:12:00', '2016-09-25 17:12:00', NULL, NULL, 'F', '2016925171200-199ba7b5-925b-4c4d-98d5-ed17acd1d8c5', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (450, 7, '2016-09-25 17:12:00', '2016-09-25 17:12:00', '2016-09-25 17:12:00', NULL, NULL, 'F', '2016925171200-2df74b69-df30-43b3-a65b-ac43a64e2cf8', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (451, 5, '2016-09-25 17:12:00', '2016-09-25 17:12:00', '2016-09-25 17:12:00', NULL, NULL, 'F', '2016925171200-d4c49c9a-b93f-4b80-aa80-9213cae29ecb', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (452, 8, '2016-09-25 17:12:00', '2016-09-25 17:12:00', '2016-09-25 17:12:00', NULL, NULL, 'F', '2016925171200-96dddf42-5ba4-40ca-9559-2c736d6c8c93', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (457, 10, '2016-09-25 17:13:00', '2016-09-25 17:13:00', '2016-09-25 17:13:00', NULL, NULL, 'F', '2016925171300-25d1a964-c0c2-4e26-b5bc-b68be657122f', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (458, 11, '2016-09-25 17:13:00', '2016-09-25 17:13:00', '2016-09-25 17:13:00', NULL, NULL, 'F', '2016925171300-cb765fe4-1b4b-476e-839b-5f597c95586e', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (459, 9, '2016-09-25 17:13:00', '2016-09-25 17:13:00', '2016-09-25 17:13:00', NULL, NULL, 'F', '2016925171300-605347e7-6c61-42ee-ae1e-0c3102234ac6', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (460, 12, '2016-09-25 17:13:00', '2016-09-25 17:13:00', '2016-09-25 17:13:00', NULL, NULL, 'F', '2016925171300-f96efa90-f0c7-4936-a6f1-93c0550d1a4c', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (461, 6, '2016-09-25 17:13:00', '2016-09-25 17:13:00', '2016-09-25 17:13:00', NULL, NULL, 'F', '2016925171300-4eac105e-862c-400a-8582-286d08b0a35f', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (462, 7, '2016-09-25 17:13:00', '2016-09-25 17:13:00', '2016-09-25 17:13:00', NULL, NULL, 'F', '2016925171300-b6ef98fc-6cf1-47cd-9354-d712077fe539', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (463, 5, '2016-09-25 17:13:00', '2016-09-25 17:13:00', '2016-09-25 17:13:00', NULL, NULL, 'F', '2016925171300-83bcadb0-804b-4377-a4ff-13b54d3916ae', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (464, 8, '2016-09-25 17:13:00', '2016-09-25 17:13:00', '2016-09-25 17:13:00', NULL, NULL, 'F', '2016925171300-734e7f30-ca2d-47ce-9b8a-e839924aba98', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (465, 2, '2016-09-25 17:15:00', '2016-09-25 17:15:00', '2016-09-25 17:15:00', NULL, NULL, 'F', '2016925171500-c81d26d3-7580-45d0-b105-3018f513059c', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (466, 3, '2016-09-25 17:15:00', '2016-09-25 17:15:00', '2016-09-25 17:15:00', NULL, NULL, 'F', '2016925171500-7cde5dbd-04da-4934-9cea-6e432118ddd5', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (467, 1, '2016-09-25 17:15:00', '2016-09-25 17:15:00', '2016-09-25 17:15:00', NULL, NULL, 'F', '2016925171500-f3d4e532-b237-4181-b104-86615e8ebd75', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (468, 4, '2016-09-25 17:15:00', '2016-09-25 17:15:00', '2016-09-25 17:15:00', NULL, NULL, 'F', '2016925171500-b76d9940-2015-47ef-898d-86cb68b79df0', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (469, 10, '2016-09-25 17:15:00', '2016-09-25 17:15:00', '2016-09-25 17:15:00', NULL, NULL, 'F', '2016925171500-5a3d6f19-139a-4d26-9c57-0702db95cf2e', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (470, 11, '2016-09-25 17:15:00', '2016-09-25 17:15:00', '2016-09-25 17:15:00', NULL, NULL, 'F', '2016925171500-a0a1563c-53dd-4c6e-a513-f88ecc036dd4', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (471, 9, '2016-09-25 17:15:00', '2016-09-25 17:15:00', '2016-09-25 17:15:00', NULL, NULL, 'F', '2016925171500-1b7d2499-3565-4639-b366-56df5c2147c3', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (472, 12, '2016-09-25 17:15:00', '2016-09-25 17:15:00', '2016-09-25 17:15:00', NULL, NULL, 'F', '2016925171500-c0e28333-986b-4cb2-98e5-7ee6325df600', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (473, 6, '2016-09-25 17:15:00', '2016-09-25 17:15:00', '2016-09-25 17:15:00', NULL, NULL, 'F', '2016925171500-f4a855e7-a28b-47f1-a6d4-702d73a283fd', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (474, 7, '2016-09-25 17:15:00', '2016-09-25 17:15:00', '2016-09-25 17:15:00', NULL, NULL, 'F', '2016925171500-ab0f405e-b75c-4344-aefe-534eb5faa3f0', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (475, 5, '2016-09-25 17:15:00', '2016-09-25 17:15:00', '2016-09-25 17:15:00', NULL, NULL, 'F', '2016925171500-8ce82425-f125-455a-a92b-84f782c26b37', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (476, 8, '2016-09-25 17:15:00', '2016-09-25 17:15:00', '2016-09-25 17:15:00', NULL, NULL, 'F', '2016925171500-df0ccd0d-d06c-4435-a68b-7c341b0bc5dd', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (477, 2, '2016-09-25 17:20:00', '2016-09-25 17:20:00', '2016-09-25 17:20:00', NULL, NULL, 'F', '2016925172000-d6dc3215-50c4-4a21-b742-8834454132e4', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (478, 3, '2016-09-25 17:20:00', '2016-09-25 17:20:00', '2016-09-25 17:20:00', NULL, NULL, 'F', '2016925172000-60b0541f-2b97-4bd7-a098-81eb2853c850', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (479, 1, '2016-09-25 17:20:00', '2016-09-25 17:20:00', '2016-09-25 17:20:00', NULL, NULL, 'F', '2016925172000-ea3c52b9-885f-438e-850e-8aa67787b9ee', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (480, 4, '2016-09-25 17:20:00', '2016-09-25 17:20:00', '2016-09-25 17:20:00', NULL, NULL, 'F', '2016925172000-ebf1020c-657d-43da-aa5b-2d45cb4eec2e', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (481, 10, '2016-09-25 17:20:00', '2016-09-25 17:20:00', '2016-09-25 17:20:00', NULL, NULL, 'F', '2016925172000-7086cd79-f8c9-4621-b2e9-0a24c7a516fe', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (482, 11, '2016-09-25 17:20:00', '2016-09-25 17:20:00', '2016-09-25 17:20:00', NULL, NULL, 'F', '2016925172000-32baff1c-9d2d-4306-a9f3-925d199268cb', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (483, 9, '2016-09-25 17:20:00', '2016-09-25 17:20:00', '2016-09-25 17:20:00', NULL, NULL, 'F', '2016925172000-f5d26e38-305f-45fd-a518-c00cd172ec8c', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (484, 12, '2016-09-25 17:20:00', '2016-09-25 17:20:00', '2016-09-25 17:20:00', NULL, NULL, 'F', '2016925172000-a1e1b652-f84f-4085-9ea1-91e8ca3530bc', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (485, 6, '2016-09-25 17:20:00', '2016-09-25 17:20:00', '2016-09-25 17:20:00', NULL, NULL, 'F', '2016925172000-7d1a618a-a782-4a82-801b-c0833bd4f56a', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (486, 7, '2016-09-25 17:20:00', '2016-09-25 17:20:00', '2016-09-25 17:20:00', NULL, NULL, 'F', '2016925172000-82bd3339-6136-4a8f-b433-50303e595cca', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (487, 5, '2016-09-25 17:20:00', '2016-09-25 17:20:00', '2016-09-25 17:20:00', NULL, NULL, 'F', '2016925172000-2f208330-2bab-41bb-a7a6-c42a9e53f8f7', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (488, 8, '2016-09-25 17:20:00', '2016-09-25 17:20:00', '2016-09-25 17:20:00', NULL, NULL, 'F', '2016925172000-288e7994-d273-45d7-8b46-6abdc1256bb5', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (489, 2, '2016-09-25 17:23:00', '2016-09-25 17:23:00', '2016-09-25 17:23:00', NULL, NULL, 'F', '2016925172300-568716ee-9753-4c76-9804-43100c3b6f42', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (490, 3, '2016-09-25 17:23:00', '2016-09-25 17:23:00', '2016-09-25 17:23:00', NULL, NULL, 'F', '2016925172300-3691a47e-c1d0-4cb4-93d8-09ac63af6af1', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (491, 1, '2016-09-25 17:23:00', '2016-09-25 17:23:00', '2016-09-25 17:23:00', NULL, NULL, 'F', '2016925172300-5bbb2f32-c04a-42b9-80bc-b44cd41da0af', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (492, 4, '2016-09-25 17:23:00', '2016-09-25 17:23:00', '2016-09-25 17:23:00', NULL, NULL, 'F', '2016925172300-a48920f1-87a3-4735-958e-e335966ddd4e', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (493, 10, '2016-09-25 17:23:00', '2016-09-25 17:23:00', '2016-09-25 17:23:00', NULL, NULL, 'F', '2016925172300-7b76207b-5f1e-4d00-8915-699fa02aa81c', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (494, 11, '2016-09-25 17:23:00', '2016-09-25 17:23:00', '2016-09-25 17:23:00', NULL, NULL, 'F', '2016925172300-aefcdfac-9349-4387-a2df-238d06a5a3f1', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (495, 9, '2016-09-25 17:23:00', '2016-09-25 17:23:00', '2016-09-25 17:23:00', NULL, NULL, 'F', '2016925172300-1d648aec-1903-466d-87a6-a9a2b2eb763f', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (496, 12, '2016-09-25 17:23:00', '2016-09-25 17:23:00', '2016-09-25 17:23:00', NULL, NULL, 'F', '2016925172300-4dd3207d-1709-438d-af20-78e721e94fa3', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (497, 6, '2016-09-25 17:23:00', '2016-09-25 17:23:00', '2016-09-25 17:23:00', NULL, NULL, 'F', '2016925172300-d3f10d9d-fe6b-4194-b626-3be7834536d3', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (498, 7, '2016-09-25 17:23:00', '2016-09-25 17:23:00', '2016-09-25 17:23:00', NULL, NULL, 'F', '2016925172300-ef6b42e5-0323-4036-bbbf-c6a4604bf2dc', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (499, 5, '2016-09-25 17:23:00', '2016-09-25 17:23:00', '2016-09-25 17:23:00', NULL, NULL, 'F', '2016925172300-2c26e4dd-e25c-4013-985f-debbb8b555f8', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (500, 8, '2016-09-25 17:23:00', '2016-09-25 17:23:00', '2016-09-25 17:23:00', NULL, NULL, 'F', '2016925172300-3eb445aa-c0b9-4c80-92ab-7f16a07a4574', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (505, 10, '2016-09-25 17:24:00', '2016-09-25 17:24:00', '2016-09-25 17:24:00', NULL, NULL, 'F', '2016925172400-a3fffb6e-a81e-41ab-a381-0b71f6ec5921', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (506, 11, '2016-09-25 17:24:00', '2016-09-25 17:24:00', '2016-09-25 17:24:00', NULL, NULL, 'F', '2016925172400-377b71f2-124c-4ee8-a90e-395ccc9c1e59', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (507, 9, '2016-09-25 17:24:00', '2016-09-25 17:24:00', '2016-09-25 17:24:00', NULL, NULL, 'F', '2016925172400-b26a1104-f25b-4ff1-a101-30733079ea82', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (508, 12, '2016-09-25 17:24:00', '2016-09-25 17:24:00', '2016-09-25 17:24:00', NULL, NULL, 'F', '2016925172400-f85f46f1-eb23-4867-bcc5-10961633a586', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (509, 6, '2016-09-25 17:24:00', '2016-09-25 17:24:00', '2016-09-25 17:24:00', NULL, NULL, 'F', '2016925172400-a426cab8-9fe7-4df6-bfd3-ca4fd01bf130', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (510, 7, '2016-09-25 17:24:00', '2016-09-25 17:24:00', '2016-09-25 17:24:00', NULL, NULL, 'F', '2016925172400-9c09a011-b8d9-4034-8b24-d90c85b644ab', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (511, 5, '2016-09-25 17:24:00', '2016-09-25 17:24:00', '2016-09-25 17:24:00', NULL, NULL, 'F', '2016925172400-d8354324-1824-48eb-bd2b-d82b6aebc2a6', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (512, 8, '2016-09-25 17:24:00', '2016-09-25 17:24:00', '2016-09-25 17:24:00', NULL, NULL, 'F', '2016925172400-cd1cb5d0-3e08-4c39-9c24-5a42ed6ca890', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (513, 2, '2016-09-25 17:26:00', '2016-09-25 17:26:00', '2016-09-25 17:26:00', NULL, NULL, 'F', '2016925172600-fa8a766b-5de1-4884-b5df-ed407bc1a7b8', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (514, 3, '2016-09-25 17:26:00', '2016-09-25 17:26:00', '2016-09-25 17:26:00', NULL, NULL, 'F', '2016925172600-e2fcad6a-1e38-41ff-b75f-16aa9e0fe19f', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (515, 1, '2016-09-25 17:26:00', '2016-09-25 17:26:00', '2016-09-25 17:26:00', NULL, NULL, 'F', '2016925172600-460387ea-4466-40c4-9456-23bbdeffa81e', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (516, 4, '2016-09-25 17:26:00', '2016-09-25 17:26:00', '2016-09-25 17:26:00', NULL, NULL, 'F', '2016925172600-8d056453-0d09-4b85-82cf-8bb006e4e48b', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (517, 10, '2016-09-25 17:26:00', '2016-09-25 17:26:00', '2016-09-25 17:26:00', NULL, NULL, 'F', '2016925172600-cf22725a-6309-4a4d-aa79-374e6df0a876', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (518, 11, '2016-09-25 17:26:00', '2016-09-25 17:26:00', '2016-09-25 17:26:00', NULL, NULL, 'F', '2016925172600-1a1599e4-91f8-4dcd-a1bc-a6558e64774d', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (519, 9, '2016-09-25 17:26:00', '2016-09-25 17:26:00', '2016-09-25 17:26:00', NULL, NULL, 'F', '2016925172600-1d97e6c2-a8cb-434f-86e5-42e4c5cb30e6', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (520, 12, '2016-09-25 17:26:00', '2016-09-25 17:26:00', '2016-09-25 17:26:00', NULL, NULL, 'F', '2016925172600-1ae8df04-3861-4b9a-ab01-a18416576e4e', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (521, 6, '2016-09-25 17:26:00', '2016-09-25 17:26:00', '2016-09-25 17:26:00', NULL, NULL, 'F', '2016925172600-c41f4dd3-f709-420b-8aac-570b96eba16c', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (522, 7, '2016-09-25 17:26:00', '2016-09-25 17:26:00', '2016-09-25 17:26:00', NULL, NULL, 'F', '2016925172600-7a05be7e-8013-4669-ab1d-07e103b68296', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (523, 5, '2016-09-25 17:26:00', '2016-09-25 17:26:00', '2016-09-25 17:26:00', NULL, NULL, 'F', '2016925172600-704cf6f0-5a72-4c9b-bb3f-033a9ad083ca', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (524, 8, '2016-09-25 17:26:00', '2016-09-25 17:26:00', '2016-09-25 17:26:00', NULL, NULL, 'F', '2016925172600-5eca30f7-c8db-477f-b0ad-2a30d256fee1', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (529, 10, '2016-09-25 17:27:00', '2016-09-25 17:27:00', '2016-09-25 17:27:00', NULL, NULL, 'F', '2016925172700-743f452f-5162-4b09-bf91-dcc65ab45db1', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (530, 11, '2016-09-25 17:27:00', '2016-09-25 17:27:00', '2016-09-25 17:27:00', NULL, NULL, 'F', '2016925172700-068f93e1-79ef-44d4-8a0b-53300be58f91', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (531, 9, '2016-09-25 17:27:00', '2016-09-25 17:27:00', '2016-09-25 17:27:00', NULL, NULL, 'F', '2016925172700-ae5492f5-2112-4589-a2b0-3e8c63625bac', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (532, 12, '2016-09-25 17:27:00', '2016-09-25 17:27:00', '2016-09-25 17:27:00', NULL, NULL, 'F', '2016925172700-8375a587-a4a3-445e-91b6-e63f780bfcaf', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (533, 6, '2016-09-25 17:27:00', '2016-09-25 17:27:00', '2016-09-25 17:27:00', NULL, NULL, 'F', '2016925172700-715b9484-7bec-43b9-ab34-ce18e7d46fb0', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (534, 7, '2016-09-25 17:27:00', '2016-09-25 17:27:00', '2016-09-25 17:27:00', NULL, NULL, 'F', '2016925172700-6b5a4914-828f-4ae5-9e0e-92bb7361d457', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (535, 5, '2016-09-25 17:27:00', '2016-09-25 17:27:00', '2016-09-25 17:27:00', NULL, NULL, 'F', '2016925172700-945e09be-ca3a-4dfb-ae46-0b0da34e13d7', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (536, 8, '2016-09-25 17:27:00', '2016-09-25 17:27:00', '2016-09-25 17:27:00', NULL, NULL, 'F', '2016925172700-dfbfda33-8713-4a0d-9b96-51a3a805faaf', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (537, 2, '2016-09-25 17:27:00', '2016-09-25 17:27:00', '2016-09-25 17:27:00', NULL, NULL, 'F', '2016925172700-c1d2d48a-cbc0-46f7-b5d5-8b40c00f730b', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (538, 3, '2016-09-25 17:27:00', '2016-09-25 17:27:00', '2016-09-25 17:27:00', NULL, NULL, 'F', '2016925172700-9f17ec78-fa90-4466-ae5f-9868e5c99dfa', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (539, 1, '2016-09-25 17:27:00', '2016-09-25 17:27:00', '2016-09-25 17:27:00', NULL, NULL, 'F', '2016925172700-fad4533d-39e6-4163-ae78-c61e9c3326f7', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (540, 4, '2016-09-25 17:27:00', '2016-09-25 17:27:00', '2016-09-25 17:27:00', NULL, NULL, 'F', '2016925172700-f8180f05-8e93-4289-bde2-f03941e32865', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (545, 6, '2016-09-25 17:28:00', '2016-09-25 17:28:00', '2016-09-25 17:28:00', NULL, NULL, 'F', '2016925172800-a2461d71-98ae-4390-98cd-aa49e001d91f', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (546, 7, '2016-09-25 17:28:00', '2016-09-25 17:28:00', '2016-09-25 17:28:00', NULL, NULL, 'F', '2016925172800-230506f0-7662-4a3a-9869-342fd3db742a', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (547, 5, '2016-09-25 17:28:00', '2016-09-25 17:28:00', '2016-09-25 17:28:00', NULL, NULL, 'F', '2016925172800-1a182592-e693-4b43-b6a3-49db7041bd9c', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (548, 8, '2016-09-25 17:28:00', '2016-09-25 17:28:00', '2016-09-25 17:28:00', NULL, NULL, 'F', '2016925172800-5869ca1f-4ea9-46f5-9d30-92267b070163', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (549, 2, '2016-09-25 17:28:00', '2016-09-25 17:28:00', '2016-09-25 17:28:00', NULL, NULL, 'F', '2016925172800-4aefa64f-94d8-42a0-9a92-70c2a65b76eb', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (550, 3, '2016-09-25 17:28:00', '2016-09-25 17:28:00', '2016-09-25 17:28:00', NULL, NULL, 'F', '2016925172800-c3a575dc-19ac-4f3e-9769-303e2beee855', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (551, 1, '2016-09-25 17:28:00', '2016-09-25 17:28:00', '2016-09-25 17:28:00', NULL, NULL, 'F', '2016925172800-4505b426-eb61-46f2-8633-b2a64b1188f7', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (552, 4, '2016-09-25 17:28:00', '2016-09-25 17:28:00', '2016-09-25 17:28:00', NULL, NULL, 'F', '2016925172800-06fa3a7f-c5f2-4618-a5dc-b5b53d8115a8', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (553, 10, '2016-09-25 17:28:00', '2016-09-25 17:28:00', '2016-09-25 17:28:00', NULL, NULL, 'F', '2016925172800-2c312f56-4e96-43d4-9592-2b11a68ff110', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (554, 11, '2016-09-25 17:28:00', '2016-09-25 17:28:00', '2016-09-25 17:28:00', NULL, NULL, 'F', '2016925172800-9615ef3b-6447-47d4-9a44-d84b7f96b730', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (555, 9, '2016-09-25 17:28:00', '2016-09-25 17:28:00', '2016-09-25 17:28:00', NULL, NULL, 'F', '2016925172800-23fa989a-866c-43f5-a9aa-3bb6079d9cfe', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (556, 12, '2016-09-25 17:28:00', '2016-09-25 17:28:00', '2016-09-25 17:28:00', NULL, NULL, 'F', '2016925172800-33e1efde-73bb-4b4b-b5c2-afcd3c052ebb', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (561, 2, '2016-09-25 17:32:00', '2016-09-25 17:32:00', '2016-09-25 17:32:00', NULL, NULL, 'F', '2016925173200-831c8ea4-bb36-4cbe-bd7e-9b310248f4ff', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (562, 3, '2016-09-25 17:32:00', '2016-09-25 17:32:00', '2016-09-25 17:32:00', NULL, NULL, 'F', '2016925173200-60e36167-62e7-4ae5-8ff6-b2126fd3bf56', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (563, 1, '2016-09-25 17:32:00', '2016-09-25 17:32:00', '2016-09-25 17:32:00', NULL, NULL, 'F', '2016925173200-7162f2d2-5c14-49a0-9e1b-a8035d63e607', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (564, 4, '2016-09-25 17:32:00', '2016-09-25 17:32:00', '2016-09-25 17:32:00', NULL, NULL, 'F', '2016925173200-6acd010b-ada8-42c8-96ba-7e91fd64905c', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (565, 10, '2016-09-25 17:32:00', '2016-09-25 17:32:00', '2016-09-25 17:32:00', NULL, NULL, 'F', '2016925173200-0fe3f995-5f0b-4c44-98be-e6ba98db53be', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (566, 11, '2016-09-25 17:32:00', '2016-09-25 17:32:00', '2016-09-25 17:32:00', NULL, NULL, 'F', '2016925173200-4508c94f-b163-4da6-ab59-cd57242818e6', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (567, 9, '2016-09-25 17:32:00', '2016-09-25 17:32:00', '2016-09-25 17:32:00', NULL, NULL, 'F', '2016925173200-003ad7e1-d9a3-4381-ae20-03e68b525241', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (568, 12, '2016-09-25 17:32:00', '2016-09-25 17:32:00', '2016-09-25 17:32:00', NULL, NULL, 'F', '2016925173200-d0c11f8d-6355-414f-bd5b-bef925419d4a', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (569, 6, '2016-09-25 17:32:00', '2016-09-25 17:32:00', '2016-09-25 17:32:00', NULL, NULL, 'F', '2016925173200-82b7cf29-de85-451a-948a-b5500524e45d', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (570, 7, '2016-09-25 17:32:00', '2016-09-25 17:32:00', '2016-09-25 17:32:00', NULL, NULL, 'F', '2016925173200-285db976-b774-42c5-9acc-c6378184f0cc', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (571, 5, '2016-09-25 17:32:00', '2016-09-25 17:32:00', '2016-09-25 17:32:00', NULL, NULL, 'F', '2016925173200-8144e109-c03b-447a-84b8-46626e1546e5', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (572, 8, '2016-09-25 17:32:00', '2016-09-25 17:32:00', '2016-09-25 17:32:00', NULL, NULL, 'F', '2016925173200-a9621234-541f-4eb1-99e0-325df36c8a1e', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (573, 2, '2016-09-25 17:35:00', '2016-09-25 17:35:00', '2016-09-25 17:35:00', NULL, NULL, 'F', '2016925173500-8fe17165-8979-4129-bc13-3b5cabaa072b', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (574, 3, '2016-09-25 17:35:00', '2016-09-25 17:35:00', '2016-09-25 17:35:00', NULL, NULL, 'F', '2016925173500-f5ea0d35-4fe7-47f9-a3f9-679b3e55d6ec', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (575, 1, '2016-09-25 17:35:00', '2016-09-25 17:35:00', '2016-09-25 17:35:00', NULL, NULL, 'F', '2016925173500-9d76fbde-5456-46ca-957c-439d94ffb940', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (576, 4, '2016-09-25 17:35:00', '2016-09-25 17:35:00', '2016-09-25 17:35:00', NULL, NULL, 'F', '2016925173500-3cd7c199-f5de-4658-80e6-eaecb3ff31e8', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (577, 10, '2016-09-25 17:35:00', '2016-09-25 17:35:00', '2016-09-25 17:35:00', NULL, NULL, 'F', '2016925173500-8e004cf9-7670-4e0e-8f0e-d39785a863bc', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (578, 11, '2016-09-25 17:35:00', '2016-09-25 17:35:00', '2016-09-25 17:35:00', NULL, NULL, 'F', '2016925173500-b27fa6f2-2d07-4c0b-934d-d0c20cea34cc', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (579, 9, '2016-09-25 17:35:00', '2016-09-25 17:35:00', '2016-09-25 17:35:00', NULL, NULL, 'F', '2016925173500-26285ec5-4ad5-4779-8011-61c2f292f9e2', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (580, 12, '2016-09-25 17:35:00', '2016-09-25 17:35:00', '2016-09-25 17:35:00', NULL, NULL, 'F', '2016925173500-3678203b-daee-429d-a2ab-4c8ba3cf20a6', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (581, 6, '2016-09-25 17:35:00', '2016-09-25 17:35:00', '2016-09-25 17:35:00', NULL, NULL, 'F', '2016925173500-5f15f321-bef7-4bea-b63a-5e22d245fe0f', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (582, 7, '2016-09-25 17:35:00', '2016-09-25 17:35:00', '2016-09-25 17:35:00', NULL, NULL, 'F', '2016925173500-4c66d09a-4e0b-4001-8de0-95b5df460000', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (583, 5, '2016-09-25 17:35:00', '2016-09-25 17:35:00', '2016-09-25 17:35:00', NULL, NULL, 'F', '2016925173500-6135fbd1-6223-4172-ad77-4a12e400b1c9', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (584, 8, '2016-09-25 17:35:00', '2016-09-25 17:35:00', '2016-09-25 17:35:00', NULL, NULL, 'F', '2016925173500-f9b5c743-1244-4db6-80b2-782bf3d8af75', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (589, 10, '2016-09-25 17:36:00', '2016-09-25 17:36:00', '2016-09-25 17:36:00', NULL, NULL, 'F', '2016925173600-ede0ded9-608c-467f-a684-41c2c38ccad4', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (590, 11, '2016-09-25 17:36:00', '2016-09-25 17:36:00', '2016-09-25 17:36:00', NULL, NULL, 'F', '2016925173600-56f85cd7-c5a2-4e3d-b643-d233deb68328', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (591, 9, '2016-09-25 17:36:00', '2016-09-25 17:36:00', '2016-09-25 17:36:00', NULL, NULL, 'F', '2016925173600-a3a886b4-0a3e-47f1-af38-54eeb75cd350', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (592, 12, '2016-09-25 17:36:00', '2016-09-25 17:36:00', '2016-09-25 17:36:00', NULL, NULL, 'F', '2016925173600-55c82a41-aef5-4040-947a-038f3be8db43', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (593, 6, '2016-09-25 17:36:00', '2016-09-25 17:36:00', '2016-09-25 17:36:00', NULL, NULL, 'F', '2016925173600-6f43d895-67be-4207-8ea7-29ba866b1b4a', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (594, 7, '2016-09-25 17:36:00', '2016-09-25 17:36:00', '2016-09-25 17:36:00', NULL, NULL, 'F', '2016925173600-b26c0dc5-bd26-494c-a530-07bb45fcc5db', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (595, 5, '2016-09-25 17:36:00', '2016-09-25 17:36:00', '2016-09-25 17:36:00', NULL, NULL, 'F', '2016925173600-223a4373-ab20-4754-a861-10e1d32de316', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (596, 8, '2016-09-25 17:36:00', '2016-09-25 17:36:00', '2016-09-25 17:36:00', NULL, NULL, 'F', '2016925173600-07a687cf-20f2-4ca5-81ef-8904b874e42e', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (597, 2, '2016-09-25 17:40:00', '2016-09-25 17:40:00', '2016-09-25 17:40:00', NULL, NULL, 'F', '2016925174000-dc38d9ad-751f-4b6e-b4d7-918d4ba77046', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (598, 3, '2016-09-25 17:40:00', '2016-09-25 17:40:00', '2016-09-25 17:40:00', NULL, NULL, 'F', '2016925174000-4da0d300-a7e4-4d5b-aefd-177629dafb26', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (599, 1, '2016-09-25 17:40:00', '2016-09-25 17:40:00', '2016-09-25 17:40:00', NULL, NULL, 'F', '2016925174000-f957e1cd-0022-47ec-8e12-73e04ef20151', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (600, 4, '2016-09-25 17:40:00', '2016-09-25 17:40:00', '2016-09-25 17:40:00', NULL, NULL, 'F', '2016925174000-5c19e537-d81c-4ab1-bb25-67cb390bac72', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (601, 10, '2016-09-25 17:40:00', '2016-09-25 17:40:00', '2016-09-25 17:40:00', NULL, NULL, 'F', '2016925174000-bd89e2fc-58c9-4bdb-aee7-bbe56d50035a', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (602, 11, '2016-09-25 17:40:00', '2016-09-25 17:40:00', '2016-09-25 17:40:00', NULL, NULL, 'F', '2016925174000-fa6456d2-5b54-45bd-ad96-696c8ceca7f8', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (603, 9, '2016-09-25 17:40:00', '2016-09-25 17:40:00', '2016-09-25 17:40:00', NULL, NULL, 'F', '2016925174000-b9cb8f16-73d8-46db-9b8f-17aac6c828cc', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (604, 12, '2016-09-25 17:40:00', '2016-09-25 17:40:00', '2016-09-25 17:40:00', NULL, NULL, 'F', '2016925174000-fac13e5c-6894-4dfa-bb11-35ff46747ba4', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (605, 6, '2016-09-25 17:40:00', '2016-09-25 17:40:00', '2016-09-25 17:40:00', NULL, NULL, 'F', '2016925174000-2ecd96c5-c7b8-4425-a004-f86ab7ff7084', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (606, 7, '2016-09-25 17:40:00', '2016-09-25 17:40:00', '2016-09-25 17:40:00', NULL, NULL, 'F', '2016925174000-e7efbe6a-2c95-4391-a9a6-eac0b8fd9880', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (607, 5, '2016-09-25 17:40:00', '2016-09-25 17:40:00', '2016-09-25 17:40:00', NULL, NULL, 'F', '2016925174000-396d5b2e-58d0-4504-b5b8-b4c31667f830', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (608, 8, '2016-09-25 17:40:00', '2016-09-25 17:40:00', '2016-09-25 17:40:00', NULL, NULL, 'F', '2016925174000-bf151cf0-ed4b-4d21-a7f3-0adebc880559', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (609, 2, '2016-09-25 17:43:00', '2016-09-25 17:43:00', '2016-09-25 17:43:00', NULL, NULL, 'F', '2016925174300-ae2402ad-f62d-415b-9914-280c04f11c95', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (610, 3, '2016-09-25 17:43:00', '2016-09-25 17:43:00', '2016-09-25 17:43:00', NULL, NULL, 'F', '2016925174300-3eab4229-974a-4779-b539-aaf0008a28a5', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (611, 1, '2016-09-25 17:43:00', '2016-09-25 17:43:00', '2016-09-25 17:43:00', NULL, NULL, 'F', '2016925174300-6c9fb6c4-4d3e-4195-9673-90a2922c1f16', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (612, 4, '2016-09-25 17:43:00', '2016-09-25 17:43:00', '2016-09-25 17:43:00', NULL, NULL, 'F', '2016925174300-0d32a425-5663-4857-9a67-9b8122e04050', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (613, 10, '2016-09-25 17:43:00', '2016-09-25 17:43:00', '2016-09-25 17:43:00', NULL, NULL, 'F', '2016925174300-72bd137d-d106-49d9-a024-88043651a5b7', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (614, 11, '2016-09-25 17:43:00', '2016-09-25 17:43:00', '2016-09-25 17:43:00', NULL, NULL, 'F', '2016925174300-e5d0a777-4e34-4484-a41c-ca3bc4db26b2', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (615, 9, '2016-09-25 17:43:00', '2016-09-25 17:43:00', '2016-09-25 17:43:00', NULL, NULL, 'F', '2016925174300-76c6a9e3-875f-4bd9-a1b5-9ca463fe1b28', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (616, 12, '2016-09-25 17:43:00', '2016-09-25 17:43:00', '2016-09-25 17:43:00', NULL, NULL, 'F', '2016925174300-93b64cff-1bde-4c01-9b45-ce6e67125a4a', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (617, 6, '2016-09-25 17:43:00', '2016-09-25 17:43:00', '2016-09-25 17:43:00', NULL, NULL, 'F', '2016925174300-a023c2ea-cb99-48a6-961b-95410e6c6715', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (618, 7, '2016-09-25 17:43:00', '2016-09-25 17:43:00', '2016-09-25 17:43:00', NULL, NULL, 'F', '2016925174300-0cba7765-ac21-4662-87f7-cd5a91f9d68e', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (619, 5, '2016-09-25 17:43:00', '2016-09-25 17:43:00', '2016-09-25 17:43:00', NULL, NULL, 'F', '2016925174300-a834a3e2-bd6b-47d1-a78a-dc089078737b', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (620, 8, '2016-09-25 17:43:00', '2016-09-25 17:43:00', '2016-09-25 17:43:00', NULL, NULL, 'F', '2016925174300-6a72a208-4a68-4332-8fa6-cea95593568a', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (625, 10, '2016-09-25 17:44:00', '2016-09-25 17:44:00', '2016-09-25 17:44:00', NULL, NULL, 'F', '2016925174400-a0194579-e3fb-4929-b245-fdd7ef759de2', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (626, 11, '2016-09-25 17:44:00', '2016-09-25 17:44:00', '2016-09-25 17:44:00', NULL, NULL, 'F', '2016925174400-aa03e950-545b-4f9b-b048-bab4c4a66ff0', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (627, 9, '2016-09-25 17:44:00', '2016-09-25 17:44:00', '2016-09-25 17:44:00', NULL, NULL, 'F', '2016925174400-a651a0ee-a5c6-4bec-805e-95a5ac737693', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (628, 12, '2016-09-25 17:44:00', '2016-09-25 17:44:00', '2016-09-25 17:44:00', NULL, NULL, 'F', '2016925174400-436d344c-1f43-4213-b2bb-b4672be385c2', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (629, 6, '2016-09-25 17:44:00', '2016-09-25 17:44:00', '2016-09-25 17:44:00', NULL, NULL, 'F', '2016925174400-2845b868-9c4f-4510-8af6-33a4b0f20631', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (630, 7, '2016-09-25 17:44:00', '2016-09-25 17:44:00', '2016-09-25 17:44:00', NULL, NULL, 'F', '2016925174400-875a78cc-9282-472a-a23c-c76bc7cd510b', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (631, 5, '2016-09-25 17:44:00', '2016-09-25 17:44:00', '2016-09-25 17:44:00', NULL, NULL, 'F', '2016925174400-9d31b1ab-98a4-4e49-9f66-ad478df33f65', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (632, 8, '2016-09-25 17:44:00', '2016-09-25 17:44:00', '2016-09-25 17:44:00', NULL, NULL, 'F', '2016925174400-385015ec-553d-4440-9499-cb498de52355', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (633, 2, '2016-09-25 17:49:00', '2016-09-25 17:49:00', '2016-09-25 17:49:00', NULL, NULL, 'F', '2016925174900-bb4c1e8a-370f-4439-929f-7e0fe06bf265', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (634, 3, '2016-09-25 17:49:00', '2016-09-25 17:49:00', '2016-09-25 17:49:00', NULL, NULL, 'F', '2016925174900-f3c9eb6b-0e8d-4deb-bcbd-67a4e8adc00c', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (635, 1, '2016-09-25 17:49:00', '2016-09-25 17:49:00', '2016-09-25 17:49:00', NULL, NULL, 'F', '2016925174900-cf550a55-4d1c-409e-95b6-faf00478feee', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (636, 4, '2016-09-25 17:49:00', '2016-09-25 17:49:00', '2016-09-25 17:49:00', NULL, NULL, 'F', '2016925174900-7387947a-e88b-49dd-9946-5d3c205527f4', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (637, 10, '2016-09-25 17:49:00', '2016-09-25 17:49:00', '2016-09-25 17:49:00', NULL, NULL, 'F', '2016925174900-bb344103-8a0b-45fc-ae61-35fbe485684c', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (638, 11, '2016-09-25 17:49:00', '2016-09-25 17:49:00', '2016-09-25 17:49:00', NULL, NULL, 'F', '2016925174900-ff74d227-1eec-418b-8191-48e280972c83', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (639, 9, '2016-09-25 17:49:00', '2016-09-25 17:49:00', '2016-09-25 17:49:00', NULL, NULL, 'F', '2016925174900-0c28c40c-9255-4bc3-8204-d1f694e0d4c9', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (640, 12, '2016-09-25 17:49:00', '2016-09-25 17:49:00', '2016-09-25 17:49:00', NULL, NULL, 'F', '2016925174900-3cd0e1b5-8a83-4202-97ba-b2e08fa3e9cd', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (641, 6, '2016-09-25 17:49:00', '2016-09-25 17:49:00', '2016-09-25 17:49:00', NULL, NULL, 'F', '2016925174900-5e6252cd-f955-4212-b456-ba6708fd311c', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (642, 7, '2016-09-25 17:49:00', '2016-09-25 17:49:00', '2016-09-25 17:49:00', NULL, NULL, 'F', '2016925174900-3e8ef10b-4974-4ae2-8ca0-2f326d4b1638', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (643, 5, '2016-09-25 17:49:00', '2016-09-25 17:49:00', '2016-09-25 17:49:00', NULL, NULL, 'F', '2016925174900-08cefa1f-d27e-42ff-a8c7-7fbbbb544d01', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (644, 8, '2016-09-25 17:49:00', '2016-09-25 17:49:00', '2016-09-25 17:49:00', NULL, NULL, 'F', '2016925174900-37a2f0f8-9679-4f95-9484-75d261980cce', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (645, 2, '2016-09-25 17:55:00', '2016-09-25 17:55:00', '2016-09-25 17:55:00', NULL, NULL, 'F', '2016925175500-5b7acf8d-0a40-4e2c-bb64-94bbf8bfac01', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (646, 3, '2016-09-25 17:55:00', '2016-09-25 17:55:00', '2016-09-25 17:55:00', NULL, NULL, 'F', '2016925175500-fbec946d-8be9-473f-bab2-3db29bc23fc7', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (647, 1, '2016-09-25 17:55:00', '2016-09-25 17:55:00', '2016-09-25 17:55:00', NULL, NULL, 'F', '2016925175500-1a811f79-fdbc-4724-9dcc-336d06945e59', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (648, 4, '2016-09-25 17:55:00', '2016-09-25 17:55:00', '2016-09-25 17:55:00', NULL, NULL, 'F', '2016925175500-ee202b01-4ee8-4bda-92ff-90d6d196a833', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (649, 10, '2016-09-25 17:55:00', '2016-09-25 17:55:00', '2016-09-25 17:55:00', NULL, NULL, 'F', '2016925175500-9e2995a5-2add-41d8-b4a5-a9f70732fc90', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (650, 11, '2016-09-25 17:55:00', '2016-09-25 17:55:00', '2016-09-25 17:55:00', NULL, NULL, 'F', '2016925175500-f49e60fc-d7dd-4f68-a304-dbfebfc7cb72', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (651, 9, '2016-09-25 17:55:00', '2016-09-25 17:55:00', '2016-09-25 17:55:00', NULL, NULL, 'F', '2016925175500-587c3fcf-93af-4d7a-92e2-200a56419dc5', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (652, 12, '2016-09-25 17:55:00', '2016-09-25 17:55:00', '2016-09-25 17:55:00', NULL, NULL, 'F', '2016925175500-983ed159-def2-4d2e-882a-b4f7c624f400', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (653, 6, '2016-09-25 17:55:00', '2016-09-25 17:55:00', '2016-09-25 17:55:00', NULL, NULL, 'F', '2016925175500-9f7c71ba-6d86-4b78-8d5f-1abffd2500a6', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (654, 7, '2016-09-25 17:55:00', '2016-09-25 17:55:00', '2016-09-25 17:55:00', NULL, NULL, 'F', '2016925175500-0e2ef678-51ae-45aa-ae8e-12130f3c59b7', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (655, 5, '2016-09-25 17:55:00', '2016-09-25 17:55:00', '2016-09-25 17:55:00', NULL, NULL, 'F', '2016925175500-3bf344ef-b9cd-4686-b410-d2de11bfd5ed', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (656, 8, '2016-09-25 17:55:00', '2016-09-25 17:55:00', '2016-09-25 17:55:00', NULL, NULL, 'F', '2016925175500-c5d13f17-8749-402d-a15c-f46a35482387', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (657, 2, '2016-09-25 18:05:00', '2016-09-25 18:05:00', '2016-09-25 18:05:00', NULL, NULL, 'F', '2016925180500-942ea039-a92c-4d7d-a021-5ca4bc4eed84', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (658, 3, '2016-09-25 18:05:00', '2016-09-25 18:05:00', '2016-09-25 18:05:00', NULL, NULL, 'F', '2016925180500-50142351-0c17-4b29-880c-c038ab8ea95d', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (659, 1, '2016-09-25 18:05:00', '2016-09-25 18:05:00', '2016-09-25 18:05:00', NULL, NULL, 'F', '2016925180500-66676d95-03ad-4e85-bef9-57eb86afadd1', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (660, 4, '2016-09-25 18:05:00', '2016-09-25 18:05:00', '2016-09-25 18:05:00', NULL, NULL, 'F', '2016925180500-db0036e7-7a33-46b8-8c03-feac266ec77a', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (661, 10, '2016-09-25 18:05:00', '2016-09-25 18:05:00', '2016-09-25 18:05:00', NULL, NULL, 'F', '2016925180500-4cca8aba-dbaf-4187-b337-ba29a391f116', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (662, 11, '2016-09-25 18:05:00', '2016-09-25 18:05:00', '2016-09-25 18:05:00', NULL, NULL, 'F', '2016925180500-e452d38d-2f76-41da-ae1c-cb4ad4948c28', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (663, 9, '2016-09-25 18:05:00', '2016-09-25 18:05:00', '2016-09-25 18:05:00', NULL, NULL, 'F', '2016925180500-4476ddb3-aeeb-4acf-9ad7-f33eeabdeae0', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (664, 12, '2016-09-25 18:05:00', '2016-09-25 18:05:00', '2016-09-25 18:05:00', NULL, NULL, 'F', '2016925180500-ef1d6e18-221f-4114-95c4-bab297a07a54', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (665, 6, '2016-09-25 18:06:00', '2016-09-25 18:06:00', '2016-09-25 18:06:00', NULL, NULL, 'F', '2016925180600-07b475db-78d3-4795-a788-919b3f9cc65b', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (666, 7, '2016-09-25 18:06:00', '2016-09-25 18:06:00', '2016-09-25 18:06:00', NULL, NULL, 'F', '2016925180600-a7d2a220-a452-493a-b5d4-b2833e335b68', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (667, 5, '2016-09-25 18:06:00', '2016-09-25 18:06:00', '2016-09-25 18:06:00', NULL, NULL, 'F', '2016925180600-a986161e-7369-41c6-a4cb-7ee1db8d4999', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (668, 8, '2016-09-25 18:06:00', '2016-09-25 18:06:00', '2016-09-25 18:06:00', NULL, NULL, 'F', '2016925180600-aadefc9a-b367-4098-a9df-543cd7a7befa', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (669, 2, '2016-09-25 18:08:00', '2016-09-25 18:08:00', '2016-09-25 18:08:00', NULL, NULL, 'F', '2016925180800-20400066-94fb-4ef7-b855-93bcd1b86643', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (670, 3, '2016-09-25 18:08:00', '2016-09-25 18:08:00', '2016-09-25 18:08:00', NULL, NULL, 'F', '2016925180800-94ac73b4-d07c-468d-b6d8-6a32ee4d3f33', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (671, 1, '2016-09-25 18:08:00', '2016-09-25 18:08:00', '2016-09-25 18:08:00', NULL, NULL, 'F', '2016925180800-52da4a0e-75a3-495f-b1d9-6f6d219ed4fe', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (672, 4, '2016-09-25 18:08:00', '2016-09-25 18:08:00', '2016-09-25 18:08:00', NULL, NULL, 'F', '2016925180800-0226ae1e-5d08-4ed8-90ff-fb543c4f1edd', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (673, 10, '2016-09-25 18:08:00', '2016-09-25 18:08:00', '2016-09-25 18:08:00', NULL, NULL, 'F', '2016925180800-c2fe6b04-a411-4f0c-ada0-9711cfd07b3f', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (674, 11, '2016-09-25 18:08:00', '2016-09-25 18:08:00', '2016-09-25 18:08:00', NULL, NULL, 'F', '2016925180800-2d46d49f-1ca0-41eb-817f-f038fba28fb5', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (675, 9, '2016-09-25 18:08:00', '2016-09-25 18:08:00', '2016-09-25 18:08:00', NULL, NULL, 'F', '2016925180800-dd5fb154-130a-4ffd-87aa-c2a19bda0dfa', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (676, 12, '2016-09-25 18:08:00', '2016-09-25 18:08:00', '2016-09-25 18:08:00', NULL, NULL, 'F', '2016925180800-3929a434-4200-4efb-9fde-21773c054c00', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (677, 6, '2016-09-25 18:09:00', '2016-09-25 18:09:00', '2016-09-25 18:09:00', NULL, NULL, 'F', '2016925180900-4795e2ef-ec35-4eab-a9a8-46d4ace58ab1', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (678, 7, '2016-09-25 18:09:00', '2016-09-25 18:09:00', '2016-09-25 18:09:00', NULL, NULL, 'F', '2016925180900-fd5ab17e-b9a2-43eb-8670-571cdd7ec2b7', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (679, 5, '2016-09-25 18:09:00', '2016-09-25 18:09:00', '2016-09-25 18:09:00', NULL, NULL, 'F', '2016925180900-c0ca1c2a-685d-4b17-9954-cbc542a72c49', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (680, 8, '2016-09-25 18:09:00', '2016-09-25 18:09:00', '2016-09-25 18:09:00', NULL, NULL, 'F', '2016925180900-ce83ecf1-6e4f-4001-8956-0f0f303137ec', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (681, 2, '2016-09-25 18:11:00', '2016-09-25 18:11:00', '2016-09-25 18:11:00', NULL, NULL, 'F', '2016925181100-de6eba3a-2e3e-4a30-a060-77d99469f201', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (682, 3, '2016-09-25 18:11:00', '2016-09-25 18:11:00', '2016-09-25 18:11:00', NULL, NULL, 'F', '2016925181100-f79bb61d-e43d-4a7f-ae7e-6146249f9014', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (683, 1, '2016-09-25 18:11:00', '2016-09-25 18:11:00', '2016-09-25 18:11:00', NULL, NULL, 'F', '2016925181100-46fc5bee-98fc-4c9b-9c08-04c53cf67fa4', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (684, 4, '2016-09-25 18:11:00', '2016-09-25 18:11:00', '2016-09-25 18:11:00', NULL, NULL, 'F', '2016925181100-68afbe8e-3819-40d9-b1c1-a1eb941c96e3', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (685, 10, '2016-09-25 18:11:00', '2016-09-25 18:11:00', '2016-09-25 18:11:00', NULL, NULL, 'F', '2016925181100-bc907cef-9e05-438c-9e00-a2638ab9b590', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (686, 11, '2016-09-25 18:11:00', '2016-09-25 18:11:00', '2016-09-25 18:11:00', NULL, NULL, 'F', '2016925181100-de206d5e-67a2-4d40-9d48-d7accddf7d67', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (687, 9, '2016-09-25 18:11:00', '2016-09-25 18:11:00', '2016-09-25 18:11:00', NULL, NULL, 'F', '2016925181100-aa83fb57-d1ff-4b6d-8f7b-68ae1131af18', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (688, 12, '2016-09-25 18:11:00', '2016-09-25 18:11:00', '2016-09-25 18:11:00', NULL, NULL, 'F', '2016925181100-894b78a1-47c3-4d81-989d-f1ae234caaea', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (689, 6, '2016-09-25 18:12:00', '2016-09-25 18:12:00', '2016-09-25 18:12:00', NULL, NULL, 'F', '2016925181200-741bf2da-8cd0-4bee-83cd-6c988eff14e2', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (690, 7, '2016-09-25 18:12:00', '2016-09-25 18:12:00', '2016-09-25 18:12:00', NULL, NULL, 'F', '2016925181200-93658c36-b8d5-40fa-befd-648e35c2858a', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (691, 5, '2016-09-25 18:12:00', '2016-09-25 18:12:00', '2016-09-25 18:12:00', NULL, NULL, 'F', '2016925181200-80262ba4-0f3b-466b-bf0b-9f77a03e1814', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (692, 8, '2016-09-25 18:12:00', '2016-09-25 18:12:00', '2016-09-25 18:12:00', NULL, NULL, 'F', '2016925181200-d828b423-d26e-4047-91ee-14340ec7f4db', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (693, 2, '2016-09-25 18:14:00', '2016-09-25 18:14:00', '2016-09-25 18:14:00', NULL, NULL, 'F', '2016925181400-e94d6ddd-08b5-41f2-95bc-3ee5e98a8fdd', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (694, 3, '2016-09-25 18:14:00', '2016-09-25 18:14:00', '2016-09-25 18:14:00', NULL, NULL, 'F', '2016925181400-14a89c7e-1691-4a90-b5ff-29b8ba435b19', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (695, 1, '2016-09-25 18:14:00', '2016-09-25 18:14:00', '2016-09-25 18:14:00', NULL, NULL, 'F', '2016925181400-e20f7a07-ec02-482f-a454-83d6dabc3542', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (696, 4, '2016-09-25 18:14:00', '2016-09-25 18:14:00', '2016-09-25 18:14:00', NULL, NULL, 'F', '2016925181400-8c479547-a83b-4777-94d1-79e56fe1a6a0', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (697, 10, '2016-09-25 18:14:00', '2016-09-25 18:14:00', '2016-09-25 18:14:00', NULL, NULL, 'F', '2016925181400-45fcd4c7-c075-4273-ba9d-7b0a8a2ec337', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (698, 11, '2016-09-25 18:14:00', '2016-09-25 18:14:00', '2016-09-25 18:14:00', NULL, NULL, 'F', '2016925181400-fb6ae767-273b-4e50-b155-c1705f766a6e', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (699, 9, '2016-09-25 18:14:00', '2016-09-25 18:14:00', '2016-09-25 18:14:00', NULL, NULL, 'F', '2016925181400-dc8d9b10-b0ec-409e-b7be-0423159699fb', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (700, 12, '2016-09-25 18:14:00', '2016-09-25 18:14:00', '2016-09-25 18:14:00', NULL, NULL, 'F', '2016925181400-880652cb-17a4-483a-89ed-003d3a5069b0', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (701, 6, '2016-09-25 18:15:00', '2016-09-25 18:15:00', '2016-09-25 18:15:00', NULL, NULL, 'F', '2016925181500-3ab62f1a-7e1d-4649-a4e7-c27d55e0407f', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (702, 7, '2016-09-25 18:15:00', '2016-09-25 18:15:00', '2016-09-25 18:15:00', NULL, NULL, 'F', '2016925181500-9d311d13-01c6-40d6-a1ed-df97607ac273', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (703, 5, '2016-09-25 18:15:00', '2016-09-25 18:15:00', '2016-09-25 18:15:00', NULL, NULL, 'F', '2016925181500-adc130a3-87f9-4427-ac14-8850c16ef5f1', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (704, 8, '2016-09-25 18:15:00', '2016-09-25 18:15:00', '2016-09-25 18:15:00', NULL, NULL, 'F', '2016925181500-fe2085b3-bdd8-42a2-b51f-b9b60146fb2a', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (705, 2, '2016-09-25 21:12:00', '2016-09-25 21:12:00', '2016-09-25 21:12:00', NULL, NULL, 'F', '2016925211200-05da55d3-e0be-4d72-b8e8-7b081f774b42', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (706, 3, '2016-09-25 21:12:00', '2016-09-25 21:12:00', '2016-09-25 21:12:00', NULL, NULL, 'F', '2016925211200-2906b578-c9a2-4385-a972-d0f27c0b1bec', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (707, 1, '2016-09-25 21:12:00', '2016-09-25 21:12:00', '2016-09-25 21:12:00', NULL, NULL, 'F', '2016925211200-cc6df3f2-56ed-4ae2-a6a2-6e3b29993dbd', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (708, 4, '2016-09-25 21:12:00', '2016-09-25 21:12:00', '2016-09-25 21:12:00', NULL, NULL, 'F', '2016925211200-aafd7cde-5f6a-4c0b-9d9f-26b9b77c8041', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (709, 10, '2016-09-25 21:12:00', '2016-09-25 21:12:00', '2016-09-25 21:12:00', NULL, NULL, 'F', '2016925211200-4420a5d6-fa6c-44d6-9a1f-5a84d4b73dce', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (710, 11, '2016-09-25 21:12:00', '2016-09-25 21:12:00', '2016-09-25 21:12:00', NULL, NULL, 'F', '2016925211200-3bcfbf8f-9559-4b68-8a55-085666d6ebd5', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (711, 9, '2016-09-25 21:12:00', '2016-09-25 21:12:00', '2016-09-25 21:12:00', NULL, NULL, 'F', '2016925211200-bde3f00f-9633-448e-83e5-f48372b4ad12', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (712, 12, '2016-09-25 21:12:00', '2016-09-25 21:12:00', '2016-09-25 21:12:00', NULL, NULL, 'F', '2016925211200-a4b4db5c-d67a-480f-8fff-d873851bab56', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (713, 6, '2016-09-25 21:12:00', '2016-09-25 21:12:00', '2016-09-25 21:12:00', NULL, NULL, 'F', '2016925211200-391359b8-df6c-4c6e-ae75-4e9479e25402', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (714, 7, '2016-09-25 21:12:00', '2016-09-25 21:12:00', '2016-09-25 21:12:00', NULL, NULL, 'F', '2016925211200-7dc48e0b-ff36-4d16-94d6-013b10807a78', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (715, 5, '2016-09-25 21:12:00', '2016-09-25 21:12:00', '2016-09-25 21:12:00', NULL, NULL, 'F', '2016925211200-59061086-b513-40ca-b086-70c99d014232', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (716, 8, '2016-09-25 21:12:00', '2016-09-25 21:12:00', '2016-09-25 21:12:00', NULL, NULL, 'F', '2016925211200-22d64e92-1154-4336-9925-e0078ceb16df', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (210, 7, '2016-09-16 00:36:00', '2016-09-16 00:36:00', '2016-09-16 00:36:00', NULL, NULL, 'F', '201691603600-f3c4b416-8229-4b51-863e-33eec35e2942', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (211, 5, '2016-09-16 00:36:00', '2016-09-16 00:36:00', '2016-09-16 00:36:00', NULL, NULL, 'F', '201691603600-4e14e42b-ef1c-4f63-9421-b44da3137011', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (214, 3, '2016-09-16 00:44:00', '2016-09-16 00:44:00', '2016-09-16 00:44:00', NULL, NULL, 'F', '201691604400-7934860d-378a-4fe0-82e1-75a18fc4cd82', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (215, 1, '2016-09-16 00:44:00', '2016-09-16 00:44:00', '2016-09-16 00:44:00', NULL, NULL, 'F', '201691604400-1ba2cc82-e21f-48f1-9152-0bedbbcf90d7', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (218, 11, '2016-09-16 00:44:00', '2016-09-16 00:44:00', '2016-09-16 00:44:00', NULL, NULL, 'F', '201691604400-644f1557-8d95-4de5-af33-c8821efb228c', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (219, 9, '2016-09-16 00:44:00', '2016-09-16 00:44:00', '2016-09-16 00:44:00', NULL, NULL, 'F', '201691604400-308c890e-5d5f-465b-a718-5a005a0ff9f5', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (222, 7, '2016-09-16 00:44:00', '2016-09-16 00:44:00', '2016-09-16 00:44:00', NULL, NULL, 'F', '201691604400-54d8fb5d-d951-471d-8fbb-ceb03af1e905', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (223, 5, '2016-09-16 00:44:00', '2016-09-16 00:44:00', '2016-09-16 00:44:00', NULL, NULL, 'F', '201691604400-f69bbb8d-5557-43f1-9294-4cbc91058f41', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (226, 3, '2016-09-17 15:15:00', '2016-09-17 15:15:00', '2016-09-17 15:15:00', NULL, NULL, 'F', '2016917151500-8e6b92bd-5863-46fd-9eac-d752d7a14b96', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (227, 1, '2016-09-17 15:15:00', '2016-09-17 15:15:00', '2016-09-17 15:15:00', NULL, NULL, 'F', '2016917151500-af7591ce-48e0-429a-8cf0-618a0bd210d7', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (230, 11, '2016-09-17 15:15:00', '2016-09-17 15:15:00', '2016-09-17 15:15:00', NULL, NULL, 'F', '2016917151500-6d6214ae-9c58-4c3c-a9bd-de7058f5ab61', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (231, 9, '2016-09-17 15:15:00', '2016-09-17 15:15:00', '2016-09-17 15:15:00', NULL, NULL, 'F', '2016917151500-bad4a322-053c-4a48-bf6e-b48e6d97d021', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (234, 7, '2016-09-17 15:15:00', '2016-09-17 15:15:00', '2016-09-17 15:15:00', NULL, NULL, 'F', '2016917151500-a64d3921-872a-4e77-b5d2-b76a3b97c2c8', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (235, 5, '2016-09-17 15:15:00', '2016-09-17 15:15:00', '2016-09-17 15:15:00', NULL, NULL, 'F', '2016917151500-64681c0f-ece0-43b2-959f-834119acc6ad', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (250, 3, '2016-09-17 17:28:00', '2016-09-17 17:28:00', '2016-09-17 17:28:00', NULL, NULL, 'F', '2016917172800-a023bd9d-b78b-4ed8-84bb-a11208338aaf', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (251, 1, '2016-09-17 17:28:00', '2016-09-17 17:28:00', '2016-09-17 17:28:00', NULL, NULL, 'F', '2016917172800-a1d0ec88-ecf4-43c6-817f-1b4b3a651498', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (254, 11, '2016-09-17 17:28:00', '2016-09-17 17:28:00', '2016-09-17 17:28:00', NULL, NULL, 'F', '2016917172800-1e83c115-21ae-4c4c-ae87-f1d294f57175', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (255, 9, '2016-09-17 17:28:00', '2016-09-17 17:28:00', '2016-09-17 17:28:00', NULL, NULL, 'F', '2016917172800-8ed924f7-d86c-48bb-9654-337947b63731', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (258, 7, '2016-09-17 17:28:00', '2016-09-17 17:28:00', '2016-09-17 17:28:00', NULL, NULL, 'F', '2016917172800-6c8d5dc5-e75c-4c20-8948-c76ab0d738a1', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (259, 5, '2016-09-17 17:28:00', '2016-09-17 17:28:00', '2016-09-17 17:28:00', NULL, NULL, 'F', '2016917172800-48dcbf53-0391-4f82-b765-cc10e231c22e', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (262, 3, '2016-09-17 17:32:00', '2016-09-17 17:32:00', '2016-09-17 17:32:00', NULL, NULL, 'F', '2016917173200-ecd19dd5-1473-4ae0-a575-3247cc8b9dfa', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (263, 1, '2016-09-17 17:32:00', '2016-09-17 17:32:00', '2016-09-17 17:32:00', NULL, NULL, 'F', '2016917173200-f15581aa-e9bb-4f27-8489-2fb06df845df', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (266, 11, '2016-09-17 17:32:00', '2016-09-17 17:32:00', '2016-09-17 17:32:00', NULL, NULL, 'F', '2016917173200-e3824905-d3c8-4de7-9171-81e39f25d515', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (267, 9, '2016-09-17 17:32:00', '2016-09-17 17:32:00', '2016-09-17 17:32:00', NULL, NULL, 'F', '2016917173200-f226de33-1d6d-498b-864b-34f866e51671', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (270, 7, '2016-09-17 17:32:00', '2016-09-17 17:32:00', '2016-09-17 17:32:00', NULL, NULL, 'F', '2016917173200-7af229f0-e7af-4d8e-9626-46b4ac9c9de9', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (271, 5, '2016-09-17 17:32:00', '2016-09-17 17:32:00', '2016-09-17 17:32:00', NULL, NULL, 'F', '2016917173200-3df95b84-8f8d-4592-a194-31abf6c941c8', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (274, 3, '2016-09-17 18:04:00', '2016-09-17 18:04:00', '2016-09-17 18:04:00', NULL, NULL, 'F', '2016917180400-c872815a-ff7c-4085-a24a-9672574e0575', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (275, 1, '2016-09-17 18:04:00', '2016-09-17 18:04:00', '2016-09-17 18:04:00', NULL, NULL, 'F', '2016917180400-c8ae4e4f-38f9-4fbf-858c-1bfa6597b7fd', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (278, 11, '2016-09-17 18:04:00', '2016-09-17 18:04:00', '2016-09-17 18:04:00', NULL, NULL, 'F', '2016917180400-23997342-9a91-40aa-abd2-2b5bc8d0e911', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (279, 9, '2016-09-17 18:04:00', '2016-09-17 18:04:00', '2016-09-17 18:04:00', NULL, NULL, 'F', '2016917180400-caa5a8f1-ad58-4e1e-903d-344a5f172961', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (282, 7, '2016-09-17 18:04:00', '2016-09-17 18:04:00', '2016-09-17 18:04:00', NULL, NULL, 'F', '2016917180400-138f9ec0-1e6f-48f1-bd91-b259ab8cfccf', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (283, 5, '2016-09-17 18:04:00', '2016-09-17 18:04:00', '2016-09-17 18:04:00', NULL, NULL, 'F', '2016917180400-5caac33f-6926-4da7-a0d9-ce5a16aa3150', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (286, 3, '2016-09-17 18:23:00', '2016-09-17 18:23:00', '2016-09-17 18:23:00', NULL, NULL, 'F', '2016917182300-34b13a05-361b-46dd-acb8-25adea1b1d06', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (287, 1, '2016-09-17 18:23:00', '2016-09-17 18:23:00', '2016-09-17 18:23:00', NULL, NULL, 'F', '2016917182300-5eec84e7-db97-4e0d-8e9e-b436a4764785', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (290, 11, '2016-09-17 18:23:00', '2016-09-17 18:23:00', '2016-09-17 18:23:00', NULL, NULL, 'F', '2016917182300-5fa6e6c0-82a0-4920-92e0-de2d659c9759', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (291, 9, '2016-09-17 18:23:00', '2016-09-17 18:23:00', '2016-09-17 18:23:00', NULL, NULL, 'F', '2016917182300-68363bfa-139b-4ac4-8023-03c66514e5f7', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (294, 7, '2016-09-17 18:23:00', '2016-09-17 18:23:00', '2016-09-17 18:23:00', NULL, NULL, 'F', '2016917182300-2d8c0542-8cb3-4206-9ef1-1a32fd6cb78b', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (295, 5, '2016-09-17 18:23:00', '2016-09-17 18:23:00', '2016-09-17 18:23:00', NULL, NULL, 'F', '2016917182300-f8561e46-b71e-441b-8317-0e6fd26f0891', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (236, 8, '2016-09-17 15:15:00', '2016-09-17 15:15:00', '2016-09-17 15:15:00', NULL, NULL, 'F', '2016917151500-eaab32e1-04a6-4c74-ad84-69250f8bc52b', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (717, 13, '2016-11-29 17:00:00', '2016-11-29 18:10:00', '2016-11-29 18:10:00', NULL, NULL, 'F', '20161129181000-246eaabe-9bec-4112-a007-c1475d0c22f4', NULL, NULL, 22);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (718, 14, '2016-12-03 21:11:00', '2016-12-03 21:13:00', '2016-12-03 21:13:00', NULL, NULL, 'F', '20161203211300-db5abb5f-352f-4283-bc60-86f07d578280', NULL, NULL, 22);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (719, 14, '2016-12-03 21:15:00', '2016-12-03 21:17:00', '2016-12-03 21:17:00', NULL, NULL, 'F', '20161203211700-76c60b4e-32a0-4e71-88f2-b82012562a8c', NULL, NULL, 22);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (720, 14, '2016-12-03 19:18:00', '2016-12-03 19:21:00', '2016-12-03 19:21:00', NULL, NULL, 'F', '20161203192100-64488a76-7a94-43f8-be33-3f782550ff2d', NULL, NULL, 22);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (721, 13, '2016-12-03 21:42:00', '2016-12-03 21:44:00', '2016-12-03 21:44:00', NULL, NULL, 'F', '20161203214400-9003c48a-237f-4f8c-97be-1eba8034852a', NULL, NULL, 22);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (722, 13, '2016-12-03 22:42:00', '2016-12-03 22:44:00', '2016-12-03 22:44:00', NULL, NULL, 'F', '20161203224400-253b55b6-b797-4efb-bdd0-58b1f55c9b20', NULL, NULL, 22);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (723, 15, '2016-12-03 22:08:00', '2016-12-03 22:09:00', '2016-12-03 22:09:00', NULL, NULL, 'F', '20161203220900-8ee171f0-e45f-406d-b23a-593383ef943f', NULL, NULL, 22);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (724, 15, '2016-12-03 21:08:00', '2016-12-03 21:09:00', '2016-12-03 21:09:00', NULL, NULL, 'F', '20161203210900-7442c71b-ebdf-4d6d-997e-e0995fa4446c', NULL, NULL, 22);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (725, 14, '2016-12-03 22:25:00', '2016-12-03 22:27:00', '2016-12-03 22:27:00', NULL, NULL, 'F', '20161203222700-06bb4365-2e0d-4b88-8199-7969a50c9359', NULL, NULL, 22);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (726, 14, '2016-12-03 22:26:00', '2016-12-03 22:27:00', '2016-12-03 22:27:00', NULL, NULL, 'F', '20161203222700-e3930370-168d-4444-82f6-c9d820de7a43', NULL, NULL, 22);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (728, 2, '2016-12-12 21:22:00', '2016-12-12 21:22:00', '2016-12-12 21:22:00', NULL, NULL, 'F', '20161212212200-fb2414b6-5acb-4dff-961a-2bd34b30887b', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (729, 3, '2016-12-12 21:22:00', '2016-12-12 21:22:00', '2016-12-12 21:22:00', NULL, NULL, 'F', '20161212212200-46db18b6-461b-47b4-a69c-9a7fc92d7ad8', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (730, 1, '2016-12-12 21:22:00', '2016-12-12 21:22:00', '2016-12-12 21:22:00', NULL, NULL, 'F', '20161212212200-39ff81b6-effe-4d27-bcaa-c8aa6ac1a880', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (731, 4, '2016-12-12 21:22:00', '2016-12-12 21:22:00', '2016-12-12 21:22:00', NULL, NULL, 'F', '20161212212200-a6ecc149-3224-4407-a899-437d5798ea45', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (732, 10, '2016-12-12 21:22:00', '2016-12-12 21:22:00', '2016-12-12 21:22:00', NULL, NULL, 'F', '20161212212200-2623211d-6bad-49c9-acb2-15f6db8bce6e', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (733, 11, '2016-12-12 21:22:00', '2016-12-12 21:22:00', '2016-12-12 21:22:00', NULL, NULL, 'F', '20161212212200-aeb30974-e1a4-47bc-a6d3-f70b3b83bee0', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (734, 9, '2016-12-12 21:22:00', '2016-12-12 21:22:00', '2016-12-12 21:22:00', NULL, NULL, 'F', '20161212212200-6553e3d2-e768-4763-a9ad-08583f6fb1ef', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (735, 12, '2016-12-12 21:22:00', '2016-12-12 21:22:00', '2016-12-12 21:22:00', NULL, NULL, 'F', '20161212212200-d45b890f-4aa1-4b5c-b5de-375844676224', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (736, 6, '2016-12-12 21:22:00', '2016-12-12 21:22:00', '2016-12-12 21:22:00', NULL, NULL, 'F', '20161212212200-17d267ff-09fb-47af-be0c-f57cff194a15', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (737, 7, '2016-12-12 21:22:00', '2016-12-12 21:22:00', '2016-12-12 21:22:00', NULL, NULL, 'F', '20161212212200-0e03ac16-9781-4696-bf4d-39a6515a2d4e', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (738, 5, '2016-12-12 21:22:00', '2016-12-12 21:22:00', '2016-12-12 21:22:00', NULL, NULL, 'F', '20161212212200-23abf2cd-a98c-4963-b1ca-07d99d5c14aa', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (739, 8, '2016-12-12 21:22:00', '2016-12-12 21:22:00', '2016-12-12 21:22:00', NULL, NULL, 'F', '20161212212200-a022bc76-8cbf-42d4-9b0e-2525b8dd7109', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (740, 2, '2016-12-12 21:35:00', '2016-12-12 21:35:00', '2016-12-12 21:35:00', NULL, NULL, 'F', '2016-12-12213500-eaf7a711-1a80-4d11-946b-b7ed234989aa', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (741, 3, '2016-12-12 21:35:00', '2016-12-12 21:35:00', '2016-12-12 21:35:00', NULL, NULL, 'F', '2016-12-12213500-1019f963-88ad-4377-b37a-2381304f2767', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (742, 1, '2016-12-12 21:35:00', '2016-12-12 21:35:00', '2016-12-12 21:35:00', NULL, NULL, 'F', '2016-12-12213500-126f6c23-6104-4df4-8df5-79749203cd88', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (743, 4, '2016-12-12 21:35:00', '2016-12-12 21:35:00', '2016-12-12 21:35:00', NULL, NULL, 'F', '2016-12-12213500-d1f5b448-211b-4366-9431-21b9a994032d', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (744, 10, '2016-12-12 21:36:00', '2016-12-12 21:36:00', '2016-12-12 21:36:00', NULL, NULL, 'F', '2016-12-12213600-6985ed27-4ee7-499f-813c-d7484629eb1d', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (745, 11, '2016-12-12 21:36:00', '2016-12-12 21:36:00', '2016-12-12 21:36:00', NULL, NULL, 'F', '2016-12-12213600-d5be8813-f050-4bae-aed4-21fc53bffea6', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (746, 9, '2016-12-12 21:36:00', '2016-12-12 21:36:00', '2016-12-12 21:36:00', NULL, NULL, 'F', '2016-12-12213600-4c218d54-210b-4544-99b1-dd53fd16fd94', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (747, 12, '2016-12-12 21:36:00', '2016-12-12 21:36:00', '2016-12-12 21:36:00', NULL, NULL, 'F', '2016-12-12213600-f0cf1eeb-85e1-486c-8891-8c0c4bb72758', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (748, 6, '2016-12-12 21:36:00', '2016-12-12 21:36:00', '2016-12-12 21:36:00', NULL, NULL, 'F', '2016-12-12213600-e6c90909-f73f-4566-99f7-e099b9683cd9', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (749, 7, '2016-12-12 21:36:00', '2016-12-12 21:36:00', '2016-12-12 21:36:00', NULL, NULL, 'F', '2016-12-12213600-62399050-2a57-4ca8-a271-6f4f7ada2337', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (750, 5, '2016-12-12 21:36:00', '2016-12-12 21:36:00', '2016-12-12 21:36:00', NULL, NULL, 'F', '2016-12-12213600-35ede9db-512d-4564-ae07-e7e7e3482e6b', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (751, 8, '2016-12-12 21:36:00', '2016-12-12 21:36:00', '2016-12-12 21:36:00', NULL, NULL, 'F', '2016-12-12213600-84c0dd67-37b2-418e-86f3-e76de447318b', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (764, 2, '2016-12-12 21:55:00', '2016-12-12 21:55:00', '2016-12-12 21:55:00', NULL, NULL, 'F', '2016-12-12215500-7b67a1ba-d5e2-4665-be8a-be072d3a6485', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (765, 3, '2016-12-12 21:55:00', '2016-12-12 21:55:00', '2016-12-12 21:55:00', NULL, NULL, 'F', '2016-12-12215500-c71b623e-ba8a-4559-9c31-24ff23c461e8', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (766, 1, '2016-12-12 21:55:00', '2016-12-12 21:55:00', '2016-12-12 21:55:00', NULL, NULL, 'F', '2016-12-12215500-f4ed6a85-4dec-4436-80e8-eb9d5e2e1cee', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (767, 4, '2016-12-12 21:55:00', '2016-12-12 21:55:00', '2016-12-12 21:55:00', NULL, NULL, 'F', '2016-12-12215500-f2732639-5632-46c1-8714-c9f19c7f4ed6', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (768, 10, '2016-12-12 21:55:00', '2016-12-12 21:55:00', '2016-12-12 21:55:00', NULL, NULL, 'F', '2016-12-12215500-120f64e4-664d-4398-9852-a871620a7c3f', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (769, 11, '2016-12-12 21:55:00', '2016-12-12 21:55:00', '2016-12-12 21:55:00', NULL, NULL, 'F', '2016-12-12215500-31eff8a4-e5e6-456a-be53-eaa19885d373', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (770, 9, '2016-12-12 21:55:00', '2016-12-12 21:55:00', '2016-12-12 21:55:00', NULL, NULL, 'F', '2016-12-12215500-209c0b14-58c8-430e-aa41-bbb0f378d85e', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (771, 12, '2016-12-12 21:55:00', '2016-12-12 21:55:00', '2016-12-12 21:55:00', NULL, NULL, 'F', '2016-12-12215500-e4dcbb21-7b31-4dd7-afba-834361ad15c1', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (772, 6, '2016-12-12 21:55:00', '2016-12-12 21:55:00', '2016-12-12 21:55:00', NULL, NULL, 'F', '2016-12-12215500-73e4b1cc-f85f-4aec-b374-e7fe400a348c', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (773, 7, '2016-12-12 21:55:00', '2016-12-12 21:55:00', '2016-12-12 21:55:00', NULL, NULL, 'F', '2016-12-12215500-3d22c16c-3d73-4bca-b386-64f948e7fa20', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (774, 5, '2016-12-12 21:55:00', '2016-12-12 21:55:00', '2016-12-12 21:55:00', NULL, NULL, 'F', '2016-12-12215500-0a07e6cf-a153-42f6-8b57-6f9e1e2b71c9', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (775, 8, '2016-12-12 21:55:00', '2016-12-12 21:55:00', '2016-12-12 21:55:00', NULL, NULL, 'F', '2016-12-12215500-94b818cc-8c59-45e9-829d-3bd8d9cafc72', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (776, 2, '2016-12-12 23:19:00', '2016-12-12 23:19:00', '2016-12-12 23:19:00', NULL, NULL, 'F', '2016-12-12231900-c5f714a9-170f-47d6-a27f-9020169c3580', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (777, 3, '2016-12-12 23:19:00', '2016-12-12 23:19:00', '2016-12-12 23:19:00', NULL, NULL, 'F', '2016-12-12231900-9676d271-c5e3-4699-95a6-baa80cffb3fa', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (778, 1, '2016-12-12 23:19:00', '2016-12-12 23:19:00', '2016-12-12 23:19:00', NULL, NULL, 'F', '2016-12-12231900-052e5763-794c-41a6-bbcf-e22331010b16', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (779, 4, '2016-12-12 23:19:00', '2016-12-12 23:19:00', '2016-12-12 23:19:00', NULL, NULL, 'F', '2016-12-12231900-85fdf2af-304f-4b57-bf37-7c072cc93f07', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (780, 10, '2016-12-12 23:19:00', '2016-12-12 23:19:00', '2016-12-12 23:19:00', NULL, NULL, 'F', '2016-12-12231900-afacb122-fe64-4c85-936d-8faccc9404f1', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (781, 11, '2016-12-12 23:19:00', '2016-12-12 23:19:00', '2016-12-12 23:19:00', NULL, NULL, 'F', '2016-12-12231900-20401e89-b40e-4c9d-9a5d-731f5c36fbe4', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (782, 9, '2016-12-12 23:19:00', '2016-12-12 23:19:00', '2016-12-12 23:19:00', NULL, NULL, 'F', '2016-12-12231900-e2a80479-72d8-4935-bd2e-0b4d25c54893', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (783, 12, '2016-12-12 23:19:00', '2016-12-12 23:19:00', '2016-12-12 23:19:00', NULL, NULL, 'F', '2016-12-12231900-c7372d72-40e3-4ec6-ad93-65077692a6d2', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (784, 6, '2016-12-12 23:19:00', '2016-12-12 23:19:00', '2016-12-12 23:19:00', NULL, NULL, 'F', '2016-12-12231900-95bc2aff-a77e-4dde-bb95-056186b84b97', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (785, 7, '2016-12-12 23:19:00', '2016-12-12 23:19:00', '2016-12-12 23:19:00', NULL, NULL, 'F', '2016-12-12231900-1247d873-401e-4c5f-ac9e-c3c5ce30b9ab', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (786, 5, '2016-12-12 23:19:00', '2016-12-12 23:19:00', '2016-12-12 23:19:00', NULL, NULL, 'F', '2016-12-12231900-7ca2b19e-98fb-4731-941a-3161971ad818', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (787, 8, '2016-12-12 23:19:00', '2016-12-12 23:19:00', '2016-12-12 23:19:00', NULL, NULL, 'F', '2016-12-12231900-81477bfa-2029-4b3b-835e-08001bcb1444', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (788, 15, '2016-12-12 23:23:00', '2016-12-12 23:25:00', '2016-12-12 23:25:00', NULL, NULL, 'F', '20161212232500-865ab35b-8ab1-438f-9bf9-9e936ea66340', NULL, NULL, 22);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (789, 13, '2016-12-12 23:26:00', '2016-12-12 23:27:00', '2016-12-12 23:27:00', NULL, NULL, 'F', '20161212232700-e8eb01cb-51ba-41f6-9058-442c1ff0b750', NULL, NULL, 22);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (790, 14, '2016-12-12 23:26:00', '2016-12-12 23:28:00', '2016-12-12 23:28:00', NULL, NULL, 'F', '20161212232800-e9ed752d-3f01-47a1-a258-2e33dd098d79', NULL, NULL, 22);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (794, 2, '2016-12-12 23:35:00', '2016-12-12 23:35:00', '2016-12-12 23:35:00', NULL, NULL, 'F', '2016-12-12233500-80e75359-b42c-4d07-85ba-a232f86d5ea1', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (795, 3, '2016-12-12 23:35:00', '2016-12-12 23:35:00', '2016-12-12 23:35:00', NULL, NULL, 'F', '2016-12-12233500-285c0b5b-86c6-4369-bcb0-1295f29ac517', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (796, 1, '2016-12-12 23:35:00', '2016-12-12 23:35:00', '2016-12-12 23:35:00', NULL, NULL, 'F', '2016-12-12233500-33faac76-eedb-4832-96d4-ceed31d21414', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (797, 4, '2016-12-12 23:35:00', '2016-12-12 23:35:00', '2016-12-12 23:35:00', NULL, NULL, 'F', '2016-12-12233500-569dcfbf-99c7-4ff4-b720-24e46084fd47', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (798, 10, '2016-12-12 23:35:00', '2016-12-12 23:35:00', '2016-12-12 23:35:00', NULL, NULL, 'F', '2016-12-12233500-a010f1cd-069c-4dde-974c-f108076ebeb3', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (799, 11, '2016-12-12 23:35:00', '2016-12-12 23:35:00', '2016-12-12 23:35:00', NULL, NULL, 'F', '2016-12-12233500-28edcd81-6a4f-4c32-9a66-2c547aa573bd', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (800, 9, '2016-12-12 23:35:00', '2016-12-12 23:35:00', '2016-12-12 23:35:00', NULL, NULL, 'F', '2016-12-12233500-d9f09067-3219-4aaa-86a8-7216f9cc46e6', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (801, 12, '2016-12-12 23:35:00', '2016-12-12 23:35:00', '2016-12-12 23:35:00', NULL, NULL, 'F', '2016-12-12233500-ded5331c-4621-4041-8be1-b144d723c8c6', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (802, 6, '2016-12-12 23:35:00', '2016-12-12 23:35:00', '2016-12-12 23:35:00', NULL, NULL, 'F', '2016-12-12233500-6885e9a6-66c7-4e14-8e05-454a7b49ed4f', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (803, 7, '2016-12-12 23:35:00', '2016-12-12 23:35:00', '2016-12-12 23:35:00', NULL, NULL, 'F', '2016-12-12233500-ab4fac04-25fa-4bb1-b8be-9c1cfebdd386', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (804, 5, '2016-12-12 23:35:00', '2016-12-12 23:35:00', '2016-12-12 23:35:00', NULL, NULL, 'F', '2016-12-12233500-1437be0c-9acd-4723-8845-17ee13049996', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (805, 8, '2016-12-12 23:35:00', '2016-12-12 23:35:00', '2016-12-12 23:35:00', NULL, NULL, 'F', '2016-12-12233500-720ac9eb-057d-4613-b649-6205fe158278', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (806, 2, '2016-12-12 23:37:00', '2016-12-12 23:37:00', '2016-12-12 23:37:00', NULL, NULL, 'F', '2016-12-12233700-5c2f1ddf-0791-434f-95e6-08e38476c01e', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (807, 3, '2016-12-12 23:37:00', '2016-12-12 23:37:00', '2016-12-12 23:37:00', NULL, NULL, 'F', '2016-12-12233700-9dbb130d-ef67-43e0-b3b2-93cfb64d490e', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (808, 1, '2016-12-12 23:37:00', '2016-12-12 23:37:00', '2016-12-12 23:37:00', NULL, NULL, 'F', '2016-12-12233700-2b359c1c-36dd-4c20-a958-98214ba7ea55', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (809, 4, '2016-12-12 23:37:00', '2016-12-12 23:37:00', '2016-12-12 23:37:00', NULL, NULL, 'F', '2016-12-12233700-3d3750fb-6872-4e22-95fa-37b5bda6c425', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (810, 10, '2016-12-12 23:37:00', '2016-12-12 23:37:00', '2016-12-12 23:37:00', NULL, NULL, 'F', '2016-12-12233700-916856a1-0692-4001-bb93-8d314fc3bf01', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (811, 11, '2016-12-12 23:37:00', '2016-12-12 23:37:00', '2016-12-12 23:37:00', NULL, NULL, 'F', '2016-12-12233700-8a06c606-a151-44ae-b5b7-71d8abb7d474', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (812, 9, '2016-12-12 23:37:00', '2016-12-12 23:37:00', '2016-12-12 23:37:00', NULL, NULL, 'F', '2016-12-12233700-62fe906f-d8a6-4a96-af9c-a89ebcb35966', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (813, 12, '2016-12-12 23:37:00', '2016-12-12 23:37:00', '2016-12-12 23:37:00', NULL, NULL, 'F', '2016-12-12233700-5a1adcac-040e-499b-bbd2-088d401b31c0', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (814, 6, '2016-12-12 23:38:00', '2016-12-12 23:38:00', '2016-12-12 23:38:00', NULL, NULL, 'F', '2016-12-12233800-9d366ecc-d8df-4f49-9444-2792396a446d', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (815, 7, '2016-12-12 23:38:00', '2016-12-12 23:38:00', '2016-12-12 23:38:00', NULL, NULL, 'F', '2016-12-12233800-7258bc77-b84a-43aa-9e96-beef204d519b', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (816, 5, '2016-12-12 23:38:00', '2016-12-12 23:38:00', '2016-12-12 23:38:00', NULL, NULL, 'F', '2016-12-12233800-124d385d-f75d-490f-a52c-014438a71362', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (817, 8, '2016-12-12 23:38:00', '2016-12-12 23:38:00', '2016-12-12 23:38:00', NULL, NULL, 'F', '2016-12-12233800-8ecb54c3-12fd-4706-8825-ecbb0b5d6ada', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (818, 2, '2016-12-12 23:40:00', '2016-12-12 23:40:00', '2016-12-12 23:40:00', NULL, NULL, 'F', '2016-12-12234000-097ebcfe-cdab-4730-ac16-114b535a8279', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (819, 3, '2016-12-12 23:40:00', '2016-12-12 23:40:00', '2016-12-12 23:40:00', NULL, NULL, 'F', '2016-12-12234000-a7f0d406-680e-4fe9-9f1f-4374b14820ac', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (820, 1, '2016-12-12 23:40:00', '2016-12-12 23:40:00', '2016-12-12 23:40:00', NULL, NULL, 'F', '2016-12-12234000-63918b12-0932-4dec-899f-ac533635aaeb', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (821, 4, '2016-12-12 23:40:00', '2016-12-12 23:40:00', '2016-12-12 23:40:00', NULL, NULL, 'F', '2016-12-12234000-97299aa5-b7d7-4a71-bf5b-9bf432d16a84', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (822, 10, '2016-12-12 23:40:00', '2016-12-12 23:40:00', '2016-12-12 23:40:00', NULL, NULL, 'F', '2016-12-12234000-94b8198f-1aea-4dcf-b7a0-4d8515f84bac', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (823, 11, '2016-12-12 23:40:00', '2016-12-12 23:40:00', '2016-12-12 23:40:00', NULL, NULL, 'F', '2016-12-12234000-439d2c34-69a3-4b37-abba-12893a01910a', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (824, 9, '2016-12-12 23:40:00', '2016-12-12 23:40:00', '2016-12-12 23:40:00', NULL, NULL, 'F', '2016-12-12234000-b6280357-311a-4f3f-8c5d-503deaea0822', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (825, 12, '2016-12-12 23:40:00', '2016-12-12 23:40:00', '2016-12-12 23:40:00', NULL, NULL, 'F', '2016-12-12234000-f223f7de-3199-4e12-bd40-d4059860e7ec', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (826, 6, '2016-12-12 23:41:00', '2016-12-12 23:41:00', '2016-12-12 23:41:00', NULL, NULL, 'F', '2016-12-12234100-937d1034-6eff-407c-a0d1-18d1f85b5bd2', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (827, 7, '2016-12-12 23:41:00', '2016-12-12 23:41:00', '2016-12-12 23:41:00', NULL, NULL, 'F', '2016-12-12234100-6026fc01-78b5-4137-a52a-963389d1daf7', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (828, 5, '2016-12-12 23:41:00', '2016-12-12 23:41:00', '2016-12-12 23:41:00', NULL, NULL, 'F', '2016-12-12234100-3beab39d-2e57-4871-9eb9-60064a0aaf1a', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (829, 8, '2016-12-12 23:41:00', '2016-12-12 23:41:00', '2016-12-12 23:41:00', NULL, NULL, 'F', '2016-12-12234100-09b69fb0-23c0-4fe4-9b17-2d854cd48825', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (830, 2, '2016-12-12 23:43:00', '2016-12-12 23:43:00', '2016-12-12 23:43:00', NULL, NULL, 'F', '2016-12-12234300-23473cd9-a37a-43e8-a060-1ee7f796004a', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (831, 3, '2016-12-12 23:43:00', '2016-12-12 23:43:00', '2016-12-12 23:43:00', NULL, NULL, 'F', '2016-12-12234300-802ee144-7402-49ac-b3d9-f6ce6fd3c28e', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (832, 1, '2016-12-12 23:43:00', '2016-12-12 23:43:00', '2016-12-12 23:43:00', NULL, NULL, 'F', '2016-12-12234300-d6e4b891-47a8-4e6b-891c-619049636bd2', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (833, 4, '2016-12-12 23:43:00', '2016-12-12 23:43:00', '2016-12-12 23:43:00', NULL, NULL, 'F', '2016-12-12234300-a56b4477-adfb-4d2a-9325-bb9dd443e213', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (834, 10, '2016-12-12 23:43:00', '2016-12-12 23:43:00', '2016-12-12 23:43:00', NULL, NULL, 'F', '2016-12-12234300-751fccfb-5dab-413d-a01d-1988fc1ff9c0', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (835, 11, '2016-12-12 23:43:00', '2016-12-12 23:43:00', '2016-12-12 23:43:00', NULL, NULL, 'F', '2016-12-12234300-86b885a5-970e-41c7-bcf9-30be13c3f267', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (836, 9, '2016-12-12 23:43:00', '2016-12-12 23:43:00', '2016-12-12 23:43:00', NULL, NULL, 'F', '2016-12-12234300-5549e68a-013a-4b94-aa8f-b0e8073040a7', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (837, 12, '2016-12-12 23:43:00', '2016-12-12 23:43:00', '2016-12-12 23:43:00', NULL, NULL, 'F', '2016-12-12234300-692094db-5f21-4e6f-a155-a16db1126efe', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (838, 6, '2016-12-12 23:44:00', '2016-12-12 23:44:00', '2016-12-12 23:44:00', NULL, NULL, 'F', '2016-12-12234400-3bd1a5ae-ed84-4de8-b439-78b5fe90a84b', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (839, 7, '2016-12-12 23:44:00', '2016-12-12 23:44:00', '2016-12-12 23:44:00', NULL, NULL, 'F', '2016-12-12234400-e8cb17b1-da87-4ec3-8821-a9dddb34d97c', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (840, 5, '2016-12-12 23:44:00', '2016-12-12 23:44:00', '2016-12-12 23:44:00', NULL, NULL, 'F', '2016-12-12234400-f7c42aaa-8fff-40dd-bed7-20c57b066edf', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (841, 8, '2016-12-12 23:44:00', '2016-12-12 23:44:00', '2016-12-12 23:44:00', NULL, NULL, 'F', '2016-12-12234400-d98fb58b-beb6-45dc-80d6-867a29611df0', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (842, 2, '2016-12-13 00:12:00', '2016-12-13 00:12:00', '2016-12-13 00:12:00', NULL, NULL, 'F', '2016-12-13001200-1195ad78-6e75-4d84-9ca8-577d5d321d05', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (843, 3, '2016-12-13 00:12:00', '2016-12-13 00:12:00', '2016-12-13 00:12:00', NULL, NULL, 'F', '2016-12-13001200-9412c262-828f-4db5-8c31-d88fa37bef1b', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (844, 1, '2016-12-13 00:12:00', '2016-12-13 00:12:00', '2016-12-13 00:12:00', NULL, NULL, 'F', '2016-12-13001200-215ef992-6a98-4681-91c8-9ca4e619dc51', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (845, 4, '2016-12-13 00:12:00', '2016-12-13 00:12:00', '2016-12-13 00:12:00', NULL, NULL, 'F', '2016-12-13001200-38d75a0c-5a79-4fc6-800c-f2cbbcf2b8f3', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (846, 10, '2016-12-13 00:12:00', '2016-12-13 00:12:00', '2016-12-13 00:12:00', NULL, NULL, 'F', '2016-12-13001200-3a08025e-0b39-432f-aecf-0c51443c613c', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (847, 11, '2016-12-13 00:12:00', '2016-12-13 00:12:00', '2016-12-13 00:12:00', NULL, NULL, 'F', '2016-12-13001200-1446feb1-a97d-44bf-96a0-3b0dcc876b0f', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (848, 9, '2016-12-13 00:12:00', '2016-12-13 00:12:00', '2016-12-13 00:12:00', NULL, NULL, 'F', '2016-12-13001200-8a49b26d-dfa4-45b3-ab66-3aae7e92841d', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (849, 12, '2016-12-13 00:12:00', '2016-12-13 00:12:00', '2016-12-13 00:12:00', NULL, NULL, 'F', '2016-12-13001200-2fd1ba4d-e189-4ab7-95e1-46b141bf41d9', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (850, 6, '2016-12-13 00:12:00', '2016-12-13 00:12:00', '2016-12-13 00:12:00', NULL, NULL, 'F', '2016-12-13001200-ce3f2e5b-4cf0-4281-bd55-83eb7ac3561c', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (851, 7, '2016-12-13 00:12:00', '2016-12-13 00:12:00', '2016-12-13 00:12:00', NULL, NULL, 'F', '2016-12-13001200-431f8002-a978-4b3f-89da-b42474a356dc', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (852, 5, '2016-12-13 00:12:00', '2016-12-13 00:12:00', '2016-12-13 00:12:00', NULL, NULL, 'F', '2016-12-13001200-b42bb393-c556-4d80-8099-43fdaf20b5f0', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (853, 8, '2016-12-13 00:12:00', '2016-12-13 00:12:00', '2016-12-13 00:12:00', NULL, NULL, 'F', '2016-12-13001200-11b74c7a-70a4-46ef-a481-302d89b77ea8', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (854, 2, '2016-12-13 00:14:00', '2016-12-13 00:14:00', '2016-12-13 00:14:00', NULL, NULL, 'F', '2016-12-13001400-4c91ff6c-4974-44fc-a264-89a5a271ac11', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (855, 3, '2016-12-13 00:14:00', '2016-12-13 00:14:00', '2016-12-13 00:14:00', NULL, NULL, 'F', '2016-12-13001400-2f0be14b-79fc-4dfd-b2b1-d9bcc76d74f9', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (856, 1, '2016-12-13 00:14:00', '2016-12-13 00:14:00', '2016-12-13 00:14:00', NULL, NULL, 'F', '2016-12-13001400-f36765c3-f05f-4cbc-adc5-a0e5a23c7027', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (857, 4, '2016-12-13 00:14:00', '2016-12-13 00:14:00', '2016-12-13 00:14:00', NULL, NULL, 'F', '2016-12-13001400-e5875fd4-1912-4615-89c9-10915f848941', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (858, 10, '2016-12-13 00:14:00', '2016-12-13 00:14:00', '2016-12-13 00:14:00', NULL, NULL, 'F', '2016-12-13001400-7e76e172-d62b-4d95-aa1f-ba4db771e309', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (859, 11, '2016-12-13 00:14:00', '2016-12-13 00:14:00', '2016-12-13 00:14:00', NULL, NULL, 'F', '2016-12-13001400-063cb720-c40e-4f2b-974a-c62a6626a339', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (860, 9, '2016-12-13 00:14:00', '2016-12-13 00:14:00', '2016-12-13 00:14:00', NULL, NULL, 'F', '2016-12-13001400-03c10670-93e5-438a-af64-ceecbaa0156e', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (861, 12, '2016-12-13 00:14:00', '2016-12-13 00:14:00', '2016-12-13 00:14:00', NULL, NULL, 'F', '2016-12-13001400-41744965-5c72-4db8-b35a-d47eb94872c2', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (862, 6, '2016-12-13 00:15:00', '2016-12-13 00:15:00', '2016-12-13 00:15:00', NULL, NULL, 'F', '2016-12-13001500-33359cbc-a0e9-4b2a-8e05-65ae5022d29a', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (863, 7, '2016-12-13 00:15:00', '2016-12-13 00:15:00', '2016-12-13 00:15:00', NULL, NULL, 'F', '2016-12-13001500-77c2b9e5-6248-4413-9ddc-5b3e5dcd02f6', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (864, 5, '2016-12-13 00:15:00', '2016-12-13 00:15:00', '2016-12-13 00:15:00', NULL, NULL, 'F', '2016-12-13001500-3b3e930b-d819-4300-8582-b13d13ade945', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (865, 8, '2016-12-13 00:15:00', '2016-12-13 00:15:00', '2016-12-13 00:15:00', NULL, NULL, 'F', '2016-12-13001500-1ab9705a-852a-4293-9820-4e269533c645', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (866, 2, '2016-12-13 00:17:00', '2016-12-13 00:17:00', '2016-12-13 00:17:00', NULL, NULL, 'F', '2016-12-13001700-1415de7d-8f29-44b7-b237-37ee4cb1b163', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (867, 3, '2016-12-13 00:17:00', '2016-12-13 00:17:00', '2016-12-13 00:17:00', NULL, NULL, 'F', '2016-12-13001700-3493810d-3c91-47bb-8340-768b02666968', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (868, 1, '2016-12-13 00:17:00', '2016-12-13 00:17:00', '2016-12-13 00:17:00', NULL, NULL, 'F', '2016-12-13001700-a199b4a4-8f86-4e74-952a-519233a69521', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (869, 4, '2016-12-13 00:17:00', '2016-12-13 00:17:00', '2016-12-13 00:17:00', NULL, NULL, 'F', '2016-12-13001700-52346248-0d4e-497c-bada-d1836d169479', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (870, 10, '2016-12-13 00:17:00', '2016-12-13 00:17:00', '2016-12-13 00:17:00', NULL, NULL, 'F', '2016-12-13001700-4f5b8655-bca7-4fe1-8294-505b7ad355e8', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (871, 11, '2016-12-13 00:17:00', '2016-12-13 00:17:00', '2016-12-13 00:17:00', NULL, NULL, 'F', '2016-12-13001700-6ae7643d-de12-4c53-93d5-6aa622414975', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (872, 9, '2016-12-13 00:17:00', '2016-12-13 00:17:00', '2016-12-13 00:17:00', NULL, NULL, 'F', '2016-12-13001700-b0261f83-80d5-4899-8bee-0cadd101d6da', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (873, 12, '2016-12-13 00:17:00', '2016-12-13 00:17:00', '2016-12-13 00:17:00', NULL, NULL, 'F', '2016-12-13001700-5d61599c-0a74-4ac9-acea-709e6b02b7b1', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (874, 6, '2016-12-13 00:18:00', '2016-12-13 00:18:00', '2016-12-13 00:18:00', NULL, NULL, 'F', '2016-12-13001800-1c623828-d602-466e-9994-31a55b1991c8', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (875, 7, '2016-12-13 00:18:00', '2016-12-13 00:18:00', '2016-12-13 00:18:00', NULL, NULL, 'F', '2016-12-13001800-9db65374-016b-4a64-9b00-d1c6bba2a2e8', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (876, 5, '2016-12-13 00:18:00', '2016-12-13 00:18:00', '2016-12-13 00:18:00', NULL, NULL, 'F', '2016-12-13001800-667938af-a369-41c6-84e4-ec29a37c3ab8', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (877, 8, '2016-12-13 00:18:00', '2016-12-13 00:18:00', '2016-12-13 00:18:00', NULL, NULL, 'F', '2016-12-13001800-b42e7a5f-e81b-4193-a6f6-07249869e10e', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (878, 2, '2016-12-13 00:20:00', '2016-12-13 00:20:00', '2016-12-13 00:20:00', NULL, NULL, 'F', '2016-12-13002000-3a42b351-68f3-42dd-8f6d-eb338f191a60', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (879, 3, '2016-12-13 00:20:00', '2016-12-13 00:20:00', '2016-12-13 00:20:00', NULL, NULL, 'F', '2016-12-13002000-378eb853-a6d9-451c-a1fb-930648154d9c', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (880, 1, '2016-12-13 00:20:00', '2016-12-13 00:20:00', '2016-12-13 00:20:00', NULL, NULL, 'F', '2016-12-13002000-da0b4651-b02c-4730-9b9c-bd9a5135b611', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (881, 4, '2016-12-13 00:20:00', '2016-12-13 00:20:00', '2016-12-13 00:20:00', NULL, NULL, 'F', '2016-12-13002000-4e1dacc3-c517-4063-bee2-06276d94d2f7', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (882, 10, '2016-12-13 00:20:00', '2016-12-13 00:20:00', '2016-12-13 00:20:00', NULL, NULL, 'F', '2016-12-13002000-c7eeee38-4099-4720-a8b4-2421cd8910c0', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (883, 11, '2016-12-13 00:20:00', '2016-12-13 00:20:00', '2016-12-13 00:20:00', NULL, NULL, 'F', '2016-12-13002000-3ccc24ed-88a0-4b5a-9016-5e019307895b', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (884, 9, '2016-12-13 00:20:00', '2016-12-13 00:20:00', '2016-12-13 00:20:00', NULL, NULL, 'F', '2016-12-13002000-2cc5b8b4-c7fc-4e22-9c41-05dab04ddf8a', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (885, 12, '2016-12-13 00:20:00', '2016-12-13 00:20:00', '2016-12-13 00:20:00', NULL, NULL, 'F', '2016-12-13002000-8ce5b5df-de9e-4dff-90e5-e07caa804e24', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (886, 6, '2016-12-13 00:21:00', '2016-12-13 00:21:00', '2016-12-13 00:21:00', NULL, NULL, 'F', '2016-12-13002100-8eed3087-eb1b-490c-ba2e-9099335ce862', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (887, 7, '2016-12-13 00:21:00', '2016-12-13 00:21:00', '2016-12-13 00:21:00', NULL, NULL, 'F', '2016-12-13002100-eeaf5a8e-6e93-4b05-be28-7f08d8d569f7', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (888, 5, '2016-12-13 00:21:00', '2016-12-13 00:21:00', '2016-12-13 00:21:00', NULL, NULL, 'F', '2016-12-13002100-0891c805-e56c-4d12-beb3-fbded79c9f4e', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (889, 8, '2016-12-13 00:21:00', '2016-12-13 00:21:00', '2016-12-13 00:21:00', NULL, NULL, 'F', '2016-12-13002100-9b7d9857-8206-431d-8124-94c36ae9931d', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (890, 2, '2016-12-13 00:23:00', '2016-12-13 00:23:00', '2016-12-13 00:23:00', NULL, NULL, 'F', '2016-12-13002300-823ca855-026f-4367-a6f0-f77f9390f2a9', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (891, 3, '2016-12-13 00:23:00', '2016-12-13 00:23:00', '2016-12-13 00:23:00', NULL, NULL, 'F', '2016-12-13002300-bdd384fa-94ea-4db6-9e23-81f6bd68cdbc', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (892, 1, '2016-12-13 00:23:00', '2016-12-13 00:23:00', '2016-12-13 00:23:00', NULL, NULL, 'F', '2016-12-13002300-7b7ef16a-254f-454f-902f-d91663ba1b7c', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (893, 4, '2016-12-13 00:23:00', '2016-12-13 00:23:00', '2016-12-13 00:23:00', NULL, NULL, 'F', '2016-12-13002300-e9497f5c-7999-4324-a10b-34d5f6d53a64', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (894, 10, '2016-12-13 00:23:00', '2016-12-13 00:23:00', '2016-12-13 00:23:00', NULL, NULL, 'F', '2016-12-13002300-77fff3ba-1c6a-41c3-871e-3a50d95fb49f', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (895, 11, '2016-12-13 00:23:00', '2016-12-13 00:23:00', '2016-12-13 00:23:00', NULL, NULL, 'F', '2016-12-13002300-d3417f28-9023-4779-99fb-17d3c5b46fb0', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (896, 9, '2016-12-13 00:23:00', '2016-12-13 00:23:00', '2016-12-13 00:23:00', NULL, NULL, 'F', '2016-12-13002300-af2da0d8-f110-4301-9421-1e2112b63856', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (897, 12, '2016-12-13 00:23:00', '2016-12-13 00:23:00', '2016-12-13 00:23:00', NULL, NULL, 'F', '2016-12-13002300-0e2e514a-fbfe-48b2-b474-8a5cbaeae71d', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (898, 6, '2016-12-13 00:24:00', '2016-12-13 00:24:00', '2016-12-13 00:24:00', NULL, NULL, 'F', '2016-12-13002400-9683183f-a860-430b-a290-443dea70aa22', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (899, 7, '2016-12-13 00:24:00', '2016-12-13 00:24:00', '2016-12-13 00:24:00', NULL, NULL, 'F', '2016-12-13002400-48d9c0db-e1c3-4a74-854d-d1664c1eae25', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (900, 5, '2016-12-13 00:24:00', '2016-12-13 00:24:00', '2016-12-13 00:24:00', NULL, NULL, 'F', '2016-12-13002400-4082c3be-cf5f-49e3-a902-4cddd66dbadb', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (901, 8, '2016-12-13 00:24:00', '2016-12-13 00:24:00', '2016-12-13 00:24:00', NULL, NULL, 'F', '2016-12-13002400-0d74ba90-1c98-4ef5-b2ce-bc13cacfc3cb', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (902, 2, '2016-12-13 00:26:00', '2016-12-13 00:26:00', '2016-12-13 00:26:00', NULL, NULL, 'F', '2016-12-13002600-c0319c87-41fb-4c4e-b388-83c9c1a44790', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (903, 3, '2016-12-13 00:26:00', '2016-12-13 00:26:00', '2016-12-13 00:26:00', NULL, NULL, 'F', '2016-12-13002600-cdf43782-870b-4788-b402-4b9075ac9999', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (904, 1, '2016-12-13 00:26:00', '2016-12-13 00:26:00', '2016-12-13 00:26:00', NULL, NULL, 'F', '2016-12-13002600-8d4dbd9a-25c6-4b55-b6c6-098dd0b33dd4', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (905, 4, '2016-12-13 00:26:00', '2016-12-13 00:26:00', '2016-12-13 00:26:00', NULL, NULL, 'F', '2016-12-13002600-395f2ad6-66b6-4126-9b3a-5b83914b818e', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (906, 10, '2016-12-13 00:26:00', '2016-12-13 00:26:00', '2016-12-13 00:26:00', NULL, NULL, 'F', '2016-12-13002600-bb6d0aeb-012c-4b1c-bb70-59b4d7068b71', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (907, 11, '2016-12-13 00:26:00', '2016-12-13 00:26:00', '2016-12-13 00:26:00', NULL, NULL, 'F', '2016-12-13002600-e5f01bb9-e83d-4bc5-8478-d8c37e7d6220', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (908, 9, '2016-12-13 00:26:00', '2016-12-13 00:26:00', '2016-12-13 00:26:00', NULL, NULL, 'F', '2016-12-13002600-0410f266-6ba1-488b-851a-121328f64ffd', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (909, 12, '2016-12-13 00:26:00', '2016-12-13 00:26:00', '2016-12-13 00:26:00', NULL, NULL, 'F', '2016-12-13002600-ff79e5d1-abc0-44de-8ebe-1caff93a85de', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (910, 6, '2016-12-13 00:27:00', '2016-12-13 00:27:00', '2016-12-13 00:27:00', NULL, NULL, 'F', '2016-12-13002700-df6b0aca-d257-4803-8c98-ec8898c30f3f', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (911, 7, '2016-12-13 00:27:00', '2016-12-13 00:27:00', '2016-12-13 00:27:00', NULL, NULL, 'F', '2016-12-13002700-5d862d00-9fe2-47fc-b835-8f51f72d91ff', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (912, 5, '2016-12-13 00:27:00', '2016-12-13 00:27:00', '2016-12-13 00:27:00', NULL, NULL, 'F', '2016-12-13002700-ece8507c-bef0-46d6-8826-8f72c56663de', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (913, 8, '2016-12-13 00:27:00', '2016-12-13 00:27:00', '2016-12-13 00:27:00', NULL, NULL, 'F', '2016-12-13002700-7719d502-9237-441a-a6e4-64a5939c4768', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (914, 15, '2016-12-14 20:54:00', '2016-12-14 20:56:00', '2016-12-14 20:56:00', NULL, NULL, 'F', '20161214205600-f6382a7f-44d7-4dc1-8897-6e138dd3c35e', NULL, NULL, 22);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (915, 13, '2016-12-14 20:55:00', '2016-12-14 20:58:00', '2016-12-14 20:58:00', NULL, NULL, 'F', '20161214205800-15734d28-1047-4ae5-b464-7ace53dfa026', NULL, NULL, 22);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (916, 14, '2016-12-14 20:55:00', '2016-12-14 20:57:00', '2016-12-14 20:57:00', NULL, NULL, 'F', '20161214205700-cd5098ca-657a-46dc-b474-9d9a7d937c17', NULL, NULL, 22);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (917, 15, '2016-12-14 20:58:00', '2016-12-14 21:00:00', '2016-12-14 21:00:00', NULL, NULL, 'F', '20161214210000-69537df8-116a-4075-b27c-e1b030363b06', NULL, NULL, 22);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (918, 13, '2016-12-14 20:59:00', '2016-12-14 21:01:00', '2016-12-14 21:01:00', NULL, NULL, 'F', '20161214210100-077316a8-abfb-4f1e-9ec6-2a9359931258', NULL, NULL, 22);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (919, 14, '2016-12-14 20:59:00', '2016-12-14 21:02:00', '2016-12-14 21:02:00', NULL, NULL, 'F', '20161214210200-08cced4e-7d09-4286-936d-f7bd49e2fb07', NULL, NULL, 22);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (920, 15, '2016-12-14 21:07:00', '2016-12-14 21:09:00', '2016-12-14 21:09:00', NULL, NULL, 'F', '20161214210900-b877d046-7a72-4bea-82d2-7232aa440f89', NULL, NULL, 22);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (921, 13, '2016-12-14 21:08:00', '2016-12-14 21:10:00', '2016-12-14 21:10:00', NULL, NULL, 'F', '20161214211000-2a1bbbd1-a813-43a9-b639-f5d38745a836', NULL, NULL, 22);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (922, 14, '2016-12-14 21:09:00', '2016-12-14 21:11:00', '2016-12-14 21:11:00', NULL, NULL, 'F', '20161214211100-2245a6c8-0a98-44cf-b020-7ac0e0280972', NULL, NULL, 22);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (926, 2, '2016-12-15 00:06:00', '2016-12-15 00:06:00', '2016-12-15 00:06:00', NULL, NULL, 'F', '2016-12-15000600-0bac935e-8a6a-4d43-8a5b-74396a9bd1fc', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (927, 3, '2016-12-15 00:06:00', '2016-12-15 00:06:00', '2016-12-15 00:06:00', NULL, NULL, 'F', '2016-12-15000600-f9ae6bd2-04e4-4bce-8117-90122e81a072', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (928, 1, '2016-12-15 00:06:00', '2016-12-15 00:06:00', '2016-12-15 00:06:00', NULL, NULL, 'F', '2016-12-15000600-93a9350e-c193-4f2d-bdd1-a9794094bc5a', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (929, 4, '2016-12-15 00:06:00', '2016-12-15 00:06:00', '2016-12-15 00:06:00', NULL, NULL, 'F', '2016-12-15000600-7b6f649f-428f-4013-aab8-f5731a1e95b4', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (930, 10, '2016-12-15 00:06:00', '2016-12-15 00:06:00', '2016-12-15 00:06:00', NULL, NULL, 'F', '2016-12-15000600-466b5cd0-84e6-43c2-b279-ba599f84822d', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (931, 11, '2016-12-15 00:06:00', '2016-12-15 00:06:00', '2016-12-15 00:06:00', NULL, NULL, 'F', '2016-12-15000600-74ada224-39a3-49ef-8f86-5445f203ae01', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (932, 9, '2016-12-15 00:06:00', '2016-12-15 00:06:00', '2016-12-15 00:06:00', NULL, NULL, 'F', '2016-12-15000600-f608fa6c-aadf-4551-a704-878af4e27c90', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (933, 12, '2016-12-15 00:06:00', '2016-12-15 00:06:00', '2016-12-15 00:06:00', NULL, NULL, 'F', '2016-12-15000600-4065b5c2-f610-410d-9d77-ef2ce1619f72', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (934, 6, '2016-12-15 00:06:00', '2016-12-15 00:06:00', '2016-12-15 00:06:00', NULL, NULL, 'F', '2016-12-15000600-d91ac82a-c1db-41da-ac34-1bb2c466f89e', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (935, 7, '2016-12-15 00:06:00', '2016-12-15 00:06:00', '2016-12-15 00:06:00', NULL, NULL, 'F', '2016-12-15000600-6d85766a-3b65-49e7-b7b0-c02bf6a6c954', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (936, 5, '2016-12-15 00:06:00', '2016-12-15 00:06:00', '2016-12-15 00:06:00', NULL, NULL, 'F', '2016-12-15000600-c52dcffc-8759-49b9-9104-30fbf6ec0415', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (937, 8, '2016-12-15 00:06:00', '2016-12-15 00:06:00', '2016-12-15 00:06:00', NULL, NULL, 'F', '2016-12-15000600-ebec4ed2-6818-42d5-a9c6-89b7c1a8c87a', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (938, 2, '2016-12-15 00:14:00', '2016-12-15 00:14:00', '2016-12-15 00:14:00', NULL, NULL, 'F', '2016-12-15001400-8ca03d07-6543-43bc-a618-bea88c86ce9c', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (939, 3, '2016-12-15 00:14:00', '2016-12-15 00:14:00', '2016-12-15 00:14:00', NULL, NULL, 'F', '2016-12-15001400-07e16d0f-f94e-420f-9128-0980d690dde3', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (940, 1, '2016-12-15 00:14:00', '2016-12-15 00:14:00', '2016-12-15 00:14:00', NULL, NULL, 'F', '2016-12-15001400-5248e140-5a87-44f4-99ee-912b27057084', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (941, 4, '2016-12-15 00:14:00', '2016-12-15 00:14:00', '2016-12-15 00:14:00', NULL, NULL, 'F', '2016-12-15001400-beed8242-907d-4ca1-bc98-6a2597c953e7', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (942, 10, '2016-12-15 00:14:00', '2016-12-15 00:14:00', '2016-12-15 00:14:00', NULL, NULL, 'F', '2016-12-15001400-07e655aa-8387-492f-9ff6-6adc2f91938f', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (943, 11, '2016-12-15 00:14:00', '2016-12-15 00:14:00', '2016-12-15 00:14:00', NULL, NULL, 'F', '2016-12-15001400-b97a9619-9cba-44c1-8241-31853dbaf891', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (944, 9, '2016-12-15 00:14:00', '2016-12-15 00:14:00', '2016-12-15 00:14:00', NULL, NULL, 'F', '2016-12-15001400-083e7bc8-53af-4a90-8391-019e15208942', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (945, 12, '2016-12-15 00:14:00', '2016-12-15 00:14:00', '2016-12-15 00:14:00', NULL, NULL, 'F', '2016-12-15001400-79d1fc2b-f46d-4f4c-bda9-9bbef1c249c1', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (946, 6, '2016-12-15 00:14:00', '2016-12-15 00:14:00', '2016-12-15 00:14:00', NULL, NULL, 'F', '2016-12-15001400-157af976-6b20-4672-ad65-aa0100567e03', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (947, 7, '2016-12-15 00:14:00', '2016-12-15 00:14:00', '2016-12-15 00:14:00', NULL, NULL, 'F', '2016-12-15001400-fd0dee71-a5f1-422a-aa4f-9bdd4056d63b', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (948, 5, '2016-12-15 00:14:00', '2016-12-15 00:14:00', '2016-12-15 00:14:00', NULL, NULL, 'F', '2016-12-15001400-59998e8d-4887-4a2e-9b77-f886fb787ebd', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (949, 8, '2016-12-15 00:14:00', '2016-12-15 00:14:00', '2016-12-15 00:14:00', NULL, NULL, 'F', '2016-12-15001400-badbb184-668c-4b24-bb9c-4f8da446b9f8', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (950, 2, '2016-12-15 00:20:00', '2016-12-15 00:20:00', '2016-12-15 00:20:00', NULL, NULL, 'F', '2016-12-15002000-b8b41cae-d1fb-4ff2-8e48-cc3dec083095', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (951, 3, '2016-12-15 00:20:00', '2016-12-15 00:20:00', '2016-12-15 00:20:00', NULL, NULL, 'F', '2016-12-15002000-afd7b8b5-e51f-4ec1-a5a1-c43407f5ddff', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (952, 1, '2016-12-15 00:20:00', '2016-12-15 00:20:00', '2016-12-15 00:20:00', NULL, NULL, 'F', '2016-12-15002000-41c2b36f-03f2-4591-8e92-4215e3cb960e', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (953, 4, '2016-12-15 00:20:00', '2016-12-15 00:20:00', '2016-12-15 00:20:00', NULL, NULL, 'F', '2016-12-15002000-61f982d2-37f4-40b8-bdc2-d7e3547d4cef', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (954, 10, '2016-12-15 00:20:00', '2016-12-15 00:20:00', '2016-12-15 00:20:00', NULL, NULL, 'F', '2016-12-15002000-209a9016-4964-492f-9882-2b3929a4e2e5', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (955, 11, '2016-12-15 00:20:00', '2016-12-15 00:20:00', '2016-12-15 00:20:00', NULL, NULL, 'F', '2016-12-15002000-75a28028-ced8-45e0-a0da-7844d47bba29', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (956, 9, '2016-12-15 00:20:00', '2016-12-15 00:20:00', '2016-12-15 00:20:00', NULL, NULL, 'F', '2016-12-15002000-e7a700b2-da00-4de6-8e0f-eb828426fcc4', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (957, 12, '2016-12-15 00:20:00', '2016-12-15 00:20:00', '2016-12-15 00:20:00', NULL, NULL, 'F', '2016-12-15002000-008e2b04-4a2b-4227-83a1-05297ffabe36', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (958, 6, '2016-12-15 00:20:00', '2016-12-15 00:20:00', '2016-12-15 00:20:00', NULL, NULL, 'F', '2016-12-15002000-a56408f6-361f-4035-ae7a-a15201bb9d0a', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (959, 7, '2016-12-15 00:20:00', '2016-12-15 00:20:00', '2016-12-15 00:20:00', NULL, NULL, 'F', '2016-12-15002000-fa3196eb-408c-4012-ad08-3b04589de292', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (960, 5, '2016-12-15 00:20:00', '2016-12-15 00:20:00', '2016-12-15 00:20:00', NULL, NULL, 'F', '2016-12-15002000-43687781-dfd3-4c8f-af11-f5b8a7738902', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (961, 8, '2016-12-15 00:20:00', '2016-12-15 00:20:00', '2016-12-15 00:20:00', NULL, NULL, 'F', '2016-12-15002000-412a3c9a-adff-4354-8dad-e91c5b26b798', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (962, 2, '2016-12-15 00:32:00', '2016-12-15 00:32:00', '2016-12-15 00:32:00', NULL, NULL, 'F', '2016-12-15003200-9af5624c-2d22-4f06-b8ac-a4294af6d924', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (963, 3, '2016-12-15 00:32:00', '2016-12-15 00:32:00', '2016-12-15 00:32:00', NULL, NULL, 'F', '2016-12-15003200-9ee67593-c8c2-48dc-ab92-b71d40236387', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (964, 1, '2016-12-15 00:32:00', '2016-12-15 00:32:00', '2016-12-15 00:32:00', NULL, NULL, 'F', '2016-12-15003200-1a94d126-f828-4d6a-a15c-2a53a78e6793', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (965, 4, '2016-12-15 00:32:00', '2016-12-15 00:32:00', '2016-12-15 00:32:00', NULL, NULL, 'F', '2016-12-15003200-77564245-3c31-44fa-aa5e-f7d8505a956f', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (966, 10, '2016-12-15 00:32:00', '2016-12-15 00:32:00', '2016-12-15 00:32:00', NULL, NULL, 'F', '2016-12-15003200-eb5fe712-c78b-4efd-b919-bca5107ebfda', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (967, 11, '2016-12-15 00:32:00', '2016-12-15 00:32:00', '2016-12-15 00:32:00', NULL, NULL, 'F', '2016-12-15003200-b9083614-ab18-474f-aef3-b3cd6fe3f8bf', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (968, 9, '2016-12-15 00:32:00', '2016-12-15 00:32:00', '2016-12-15 00:32:00', NULL, NULL, 'F', '2016-12-15003200-eaba0ac4-0082-4a3e-b7cb-ce54fdc129a3', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (969, 12, '2016-12-15 00:32:00', '2016-12-15 00:32:00', '2016-12-15 00:32:00', NULL, NULL, 'F', '2016-12-15003200-f8480979-a2a2-4b23-be59-016690a5f608', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (970, 6, '2016-12-15 00:32:00', '2016-12-15 00:32:00', '2016-12-15 00:32:00', NULL, NULL, 'F', '2016-12-15003200-98dc164f-9f38-460f-ba99-4e4b455fafbe', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (971, 7, '2016-12-15 00:32:00', '2016-12-15 00:32:00', '2016-12-15 00:32:00', NULL, NULL, 'F', '2016-12-15003200-355eac90-a327-45f5-b2ce-1b16b47ce758', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (972, 5, '2016-12-15 00:32:00', '2016-12-15 00:32:00', '2016-12-15 00:32:00', NULL, NULL, 'F', '2016-12-15003200-fd166cb3-6b80-49be-a519-109a6b0bcacf', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (973, 8, '2016-12-15 00:32:00', '2016-12-15 00:32:00', '2016-12-15 00:32:00', NULL, NULL, 'F', '2016-12-15003200-b821d2a8-90ce-472e-9a98-20eb690182cc', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (974, 2, '2016-12-15 00:36:00', '2016-12-15 00:36:00', '2016-12-15 00:36:00', NULL, NULL, 'F', '2016-12-15003600-a580c29a-ccc4-4761-9ca5-9c37c91a74c1', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (975, 3, '2016-12-15 00:36:00', '2016-12-15 00:36:00', '2016-12-15 00:36:00', NULL, NULL, 'F', '2016-12-15003600-c36c3b31-a774-4b2f-8787-403c0d12c8aa', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (976, 1, '2016-12-15 00:36:00', '2016-12-15 00:36:00', '2016-12-15 00:36:00', NULL, NULL, 'F', '2016-12-15003600-874622a5-fc53-41a6-a1d3-6cf86a1ca36e', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (977, 4, '2016-12-15 00:36:00', '2016-12-15 00:36:00', '2016-12-15 00:36:00', NULL, NULL, 'F', '2016-12-15003600-e1754259-eba0-43a9-92bb-7c8423eb9a82', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (978, 10, '2016-12-15 00:36:00', '2016-12-15 00:36:00', '2016-12-15 00:36:00', NULL, NULL, 'F', '2016-12-15003600-f6a109ee-a2dc-4d6e-858b-c42024243b1f', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (979, 11, '2016-12-15 00:36:00', '2016-12-15 00:36:00', '2016-12-15 00:36:00', NULL, NULL, 'F', '2016-12-15003600-6250ea49-9fe8-486c-a82b-7ece9eb8dfc6', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (980, 9, '2016-12-15 00:36:00', '2016-12-15 00:36:00', '2016-12-15 00:36:00', NULL, NULL, 'F', '2016-12-15003600-795886cd-01a4-407d-b8a1-35b6cefb92fa', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (981, 12, '2016-12-15 00:36:00', '2016-12-15 00:36:00', '2016-12-15 00:36:00', NULL, NULL, 'F', '2016-12-15003600-2dea0251-8fe2-4c03-bd7b-f3370f0bb305', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (982, 6, '2016-12-15 00:36:00', '2016-12-15 00:36:00', '2016-12-15 00:36:00', NULL, NULL, 'F', '2016-12-15003600-a6470bfa-f4c8-468c-9e1c-371405812905', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (983, 7, '2016-12-15 00:36:00', '2016-12-15 00:36:00', '2016-12-15 00:36:00', NULL, NULL, 'F', '2016-12-15003600-c4723075-03c2-465d-af18-ffd217b18429', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (984, 5, '2016-12-15 00:36:00', '2016-12-15 00:36:00', '2016-12-15 00:36:00', NULL, NULL, 'F', '2016-12-15003600-fdb40fdb-b3bf-4dde-8739-985258094b3c', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (985, 8, '2016-12-15 00:36:00', '2016-12-15 00:36:00', '2016-12-15 00:36:00', NULL, NULL, 'F', '2016-12-15003600-80a530c0-3d0f-4ea6-8f6d-91d657d13170', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (986, 2, '2016-12-15 00:45:00', '2016-12-15 00:45:00', '2016-12-15 00:45:00', NULL, NULL, 'F', '2016-12-15004500-d3b8eae2-6986-4040-8890-89fd1cb2ef29', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (987, 3, '2016-12-15 00:45:00', '2016-12-15 00:45:00', '2016-12-15 00:45:00', NULL, NULL, 'F', '2016-12-15004500-96494389-ed21-4eda-b6eb-78666415d39b', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (988, 1, '2016-12-15 00:45:00', '2016-12-15 00:45:00', '2016-12-15 00:45:00', NULL, NULL, 'F', '2016-12-15004500-f3ed9233-943e-46f6-8ec8-1b99e4678471', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (989, 4, '2016-12-15 00:45:00', '2016-12-15 00:45:00', '2016-12-15 00:45:00', NULL, NULL, 'F', '2016-12-15004500-8dae5471-af25-4534-8c6a-4d8951b602e3', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (990, 10, '2016-12-15 00:45:00', '2016-12-15 00:45:00', '2016-12-15 00:45:00', NULL, NULL, 'F', '2016-12-15004500-79f3ed9e-95e2-4bf2-9260-e977e015e396', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (991, 11, '2016-12-15 00:45:00', '2016-12-15 00:45:00', '2016-12-15 00:45:00', NULL, NULL, 'F', '2016-12-15004500-472008af-9080-4a71-a98e-63c581430a3d', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (992, 9, '2016-12-15 00:45:00', '2016-12-15 00:45:00', '2016-12-15 00:45:00', NULL, NULL, 'F', '2016-12-15004500-24c40f88-d764-4e10-a7ee-09a39f7a3691', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (993, 12, '2016-12-15 00:45:00', '2016-12-15 00:45:00', '2016-12-15 00:45:00', NULL, NULL, 'F', '2016-12-15004500-1ff1717e-54da-4448-aa51-24ca4c91cb6d', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (994, 6, '2016-12-15 00:45:00', '2016-12-15 00:45:00', '2016-12-15 00:45:00', NULL, NULL, 'F', '2016-12-15004500-9ccda10c-9927-47ee-8632-df6c9e7e1289', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (995, 7, '2016-12-15 00:45:00', '2016-12-15 00:45:00', '2016-12-15 00:45:00', NULL, NULL, 'F', '2016-12-15004500-18b6dfb6-68ea-4cde-8cac-1e7c3ec11e77', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (996, 5, '2016-12-15 00:45:00', '2016-12-15 00:45:00', '2016-12-15 00:45:00', NULL, NULL, 'F', '2016-12-15004500-0f90f254-2a2a-452a-95c2-7c3a7ae0b382', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (997, 8, '2016-12-15 00:45:00', '2016-12-15 00:45:00', '2016-12-15 00:45:00', NULL, NULL, 'F', '2016-12-15004500-7c524933-6e48-427f-ab2e-1deef9aa989d', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (998, 2, '2016-12-15 00:47:00', '2016-12-15 00:47:00', '2016-12-15 00:47:00', NULL, NULL, 'F', '2016-12-15004700-d39b5e94-b554-4fc0-9548-25fc192aa343', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (999, 3, '2016-12-15 00:47:00', '2016-12-15 00:47:00', '2016-12-15 00:47:00', NULL, NULL, 'F', '2016-12-15004700-b15959e9-15ec-4219-a63b-f0aae85dc456', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (1000, 1, '2016-12-15 00:47:00', '2016-12-15 00:47:00', '2016-12-15 00:47:00', NULL, NULL, 'F', '2016-12-15004700-3327bd67-2bd1-4d0a-a8c1-0d319668c939', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (1001, 4, '2016-12-15 00:47:00', '2016-12-15 00:47:00', '2016-12-15 00:47:00', NULL, NULL, 'F', '2016-12-15004700-7e8e011b-d623-4fa9-baad-70daf332c16d', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (1002, 10, '2016-12-15 00:47:00', '2016-12-15 00:47:00', '2016-12-15 00:47:00', NULL, NULL, 'F', '2016-12-15004700-f7fdac6c-68ab-4c08-a366-d1918fc98a8c', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (1003, 11, '2016-12-15 00:47:00', '2016-12-15 00:47:00', '2016-12-15 00:47:00', NULL, NULL, 'F', '2016-12-15004700-0571f1de-6b19-4e4a-b0f9-1292381025e7', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (1004, 9, '2016-12-15 00:47:00', '2016-12-15 00:47:00', '2016-12-15 00:47:00', NULL, NULL, 'F', '2016-12-15004700-b46959bd-e1e7-4873-b76c-8e9965682652', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (1005, 12, '2016-12-15 00:47:00', '2016-12-15 00:47:00', '2016-12-15 00:47:00', NULL, NULL, 'F', '2016-12-15004700-52ee59b5-c191-420c-b28a-a2f3949f85ca', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (1006, 6, '2016-12-15 00:48:00', '2016-12-15 00:48:00', '2016-12-15 00:48:00', NULL, NULL, 'F', '2016-12-15004800-9b936168-9481-450e-85d7-7d1a8fcdc8f5', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (1007, 7, '2016-12-15 00:48:00', '2016-12-15 00:48:00', '2016-12-15 00:48:00', NULL, NULL, 'F', '2016-12-15004800-fa0edb14-a8b4-43aa-9718-f595f001cf81', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (1008, 5, '2016-12-15 00:48:00', '2016-12-15 00:48:00', '2016-12-15 00:48:00', NULL, NULL, 'F', '2016-12-15004800-e9fec489-19f1-4ec3-8bb9-391bc3f384d7', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (1009, 8, '2016-12-15 00:48:00', '2016-12-15 00:48:00', '2016-12-15 00:48:00', NULL, NULL, 'F', '2016-12-15004800-747ddb54-0b92-41d4-af72-7b8eccadbffb', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (1018, 6, '2016-12-15 00:46:00', '2016-12-15 00:46:00', '2016-12-15 00:46:00', NULL, NULL, 'F', '2016-12-15004600-b113c667-0c27-41da-99f4-a1da48a52d29', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (1019, 7, '2016-12-15 00:46:00', '2016-12-15 00:46:00', '2016-12-15 00:46:00', NULL, NULL, 'F', '2016-12-15004600-eaa0861f-5a82-4af9-a07d-a60ac44dc699', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (1020, 5, '2016-12-15 00:46:00', '2016-12-15 00:46:00', '2016-12-15 00:46:00', NULL, NULL, 'F', '2016-12-15004600-1200924b-fbbe-42c6-95d3-0d8681dfc72e', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (1021, 8, '2016-12-15 00:46:00', '2016-12-15 00:46:00', '2016-12-15 00:46:00', NULL, NULL, 'F', '2016-12-15004600-79087bad-4a4a-4f64-9717-a0cf0ee1ceb5', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (1022, 2, '2016-12-15 00:55:00', '2016-12-15 00:55:00', '2016-12-15 00:55:00', NULL, NULL, 'F', '2016-12-15005500-3f10b83f-9765-48ea-b78c-bf60e5a870e8', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (1023, 3, '2016-12-15 00:55:00', '2016-12-15 00:55:00', '2016-12-15 00:55:00', NULL, NULL, 'F', '2016-12-15005500-b82c290b-5778-4407-950b-cad081c3a95e', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (1024, 1, '2016-12-15 00:55:00', '2016-12-15 00:55:00', '2016-12-15 00:55:00', NULL, NULL, 'F', '2016-12-15005500-ba1f1add-4c98-4f75-ba5f-6740f00b8ad1', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (1025, 4, '2016-12-15 00:55:00', '2016-12-15 00:55:00', '2016-12-15 00:55:00', NULL, NULL, 'F', '2016-12-15005500-75a0e835-12f9-45a6-a678-c1439c08669a', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (1026, 10, '2016-12-15 00:55:00', '2016-12-15 00:55:00', '2016-12-15 00:55:00', NULL, NULL, 'F', '2016-12-15005500-2810cc9d-1cee-410c-a27d-5af8cf95c778', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (1027, 11, '2016-12-15 00:55:00', '2016-12-15 00:55:00', '2016-12-15 00:55:00', NULL, NULL, 'F', '2016-12-15005500-3776e14d-cc14-4d67-bd45-bb548ab4f458', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (1028, 9, '2016-12-15 00:55:00', '2016-12-15 00:55:00', '2016-12-15 00:55:00', NULL, NULL, 'F', '2016-12-15005500-b5397d3c-66c1-4b0a-a11a-9b7ba56329c6', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (1029, 12, '2016-12-15 00:55:00', '2016-12-15 00:55:00', '2016-12-15 00:55:00', NULL, NULL, 'F', '2016-12-15005500-b9b9bcf1-fb17-4b02-bc48-69b234486ac5', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (1030, 6, '2016-12-15 00:55:00', '2016-12-15 00:55:00', '2016-12-15 00:55:00', NULL, NULL, 'F', '2016-12-15005500-9a74e28b-7aa7-4289-92e2-361d5478f69e', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (1031, 7, '2016-12-15 00:55:00', '2016-12-15 00:55:00', '2016-12-15 00:55:00', NULL, NULL, 'F', '2016-12-15005500-0094d454-febf-4eb0-8c6d-a229c24560c6', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (1032, 5, '2016-12-15 00:55:00', '2016-12-15 00:55:00', '2016-12-15 00:55:00', NULL, NULL, 'F', '2016-12-15005500-d6b5be0a-49f1-49ad-b520-2d2f528acef1', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (1033, 8, '2016-12-15 00:55:00', '2016-12-15 00:55:00', '2016-12-15 00:55:00', NULL, NULL, 'F', '2016-12-15005500-cfeb13f4-668b-4c6b-921c-c2855b3eed9c', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (1034, 2, '2016-12-15 01:07:00', '2016-12-15 01:07:00', '2016-12-15 01:07:00', NULL, NULL, 'F', '2016-12-15010700-13cf4ffc-6536-46a1-bffa-a52fef1309e9', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (1035, 3, '2016-12-15 01:07:00', '2016-12-15 01:07:00', '2016-12-15 01:07:00', NULL, NULL, 'F', '2016-12-15010700-b94b6a9d-3e43-412c-a9c5-2eeb758201b2', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (1036, 1, '2016-12-15 01:07:00', '2016-12-15 01:07:00', '2016-12-15 01:07:00', NULL, NULL, 'F', '2016-12-15010700-48ef8360-44d7-47f8-9d9d-bf7a8a912399', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (1037, 4, '2016-12-15 01:07:00', '2016-12-15 01:07:00', '2016-12-15 01:07:00', NULL, NULL, 'F', '2016-12-15010700-3361c226-a1e0-4d5a-bf6a-87a58c65e079', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (1038, 10, '2016-12-15 01:07:00', '2016-12-15 01:07:00', '2016-12-15 01:07:00', NULL, NULL, 'F', '2016-12-15010700-8cd362b2-6b95-4935-903c-f9cd5e728788', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (1039, 11, '2016-12-15 01:07:00', '2016-12-15 01:07:00', '2016-12-15 01:07:00', NULL, NULL, 'F', '2016-12-15010700-92bf0c53-b776-41b9-9434-687d2ab2d039', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (1040, 9, '2016-12-15 01:07:00', '2016-12-15 01:07:00', '2016-12-15 01:07:00', NULL, NULL, 'F', '2016-12-15010700-f18daf1b-330c-4daa-a0cf-fa07c02fff46', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (1041, 12, '2016-12-15 01:07:00', '2016-12-15 01:07:00', '2016-12-15 01:07:00', NULL, NULL, 'F', '2016-12-15010700-faf6e1b0-08b5-484e-8482-471ed2fc9e7f', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (1042, 6, '2016-12-15 01:07:00', '2016-12-15 01:07:00', '2016-12-15 01:07:00', NULL, NULL, 'F', '2016-12-15010700-718d110a-e47a-44e1-b1a3-5306758b7c60', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (1043, 7, '2016-12-15 01:07:00', '2016-12-15 01:07:00', '2016-12-15 01:07:00', NULL, NULL, 'F', '2016-12-15010700-659da5ce-7c8b-488e-a76f-78fc6a5d5e6e', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (1044, 5, '2016-12-15 01:07:00', '2016-12-15 01:07:00', '2016-12-15 01:07:00', NULL, NULL, 'F', '2016-12-15010700-041b2a70-efd6-40fd-95bf-fda66f89e4f4', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (1045, 8, '2016-12-15 01:07:00', '2016-12-15 01:07:00', '2016-12-15 01:07:00', NULL, NULL, 'F', '2016-12-15010700-ebd8da37-27c9-41a1-86a0-8a8f384c2abf', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (1046, 2, '2016-12-15 01:10:00', '2016-12-15 01:10:00', '2016-12-15 01:10:00', NULL, NULL, 'F', '2016-12-15011000-ff721004-af1a-4275-a1e6-2e4e7513b253', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (1047, 3, '2016-12-15 01:10:00', '2016-12-15 01:10:00', '2016-12-15 01:10:00', NULL, NULL, 'F', '2016-12-15011000-6f506548-ddd6-4e11-a7fc-e69bd3e7a97d', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (1048, 1, '2016-12-15 01:10:00', '2016-12-15 01:10:00', '2016-12-15 01:10:00', NULL, NULL, 'F', '2016-12-15011000-fbc353e5-26dc-4ea1-a686-65b144d7f582', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (1049, 4, '2016-12-15 01:10:00', '2016-12-15 01:10:00', '2016-12-15 01:10:00', NULL, NULL, 'F', '2016-12-15011000-a8163f5f-deee-48f2-b27c-28b10bf13aea', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (1050, 10, '2016-12-15 01:10:00', '2016-12-15 01:10:00', '2016-12-15 01:10:00', NULL, NULL, 'F', '2016-12-15011000-48177949-6889-4fba-b2d2-6b81c62630b5', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (1051, 11, '2016-12-15 01:10:00', '2016-12-15 01:10:00', '2016-12-15 01:10:00', NULL, NULL, 'F', '2016-12-15011000-2c6f0279-db29-47b5-8536-391b28bccb88', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (1052, 9, '2016-12-15 01:10:00', '2016-12-15 01:10:00', '2016-12-15 01:10:00', NULL, NULL, 'F', '2016-12-15011000-7ea3fc4d-7c95-4edc-8326-302522849085', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (1053, 12, '2016-12-15 01:10:00', '2016-12-15 01:10:00', '2016-12-15 01:10:00', NULL, NULL, 'F', '2016-12-15011000-41c11f0c-6ae8-4ff6-abde-c572fc1d5bf0', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (1054, 6, '2016-12-15 01:10:00', '2016-12-15 01:10:00', '2016-12-15 01:10:00', NULL, NULL, 'F', '2016-12-15011000-a1c40818-f979-410a-90f0-a1136cf230ed', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (1055, 7, '2016-12-15 01:10:00', '2016-12-15 01:10:00', '2016-12-15 01:10:00', NULL, NULL, 'F', '2016-12-15011000-d9ede437-25b8-4a8e-a993-dc07f2917e01', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (1056, 5, '2016-12-15 01:10:00', '2016-12-15 01:10:00', '2016-12-15 01:10:00', NULL, NULL, 'F', '2016-12-15011000-0b0e0d70-3fab-4cd1-b14f-259f60e16487', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (1057, 8, '2016-12-15 01:10:00', '2016-12-15 01:10:00', '2016-12-15 01:10:00', NULL, NULL, 'F', '2016-12-15011000-1bcd738f-86fd-4037-8d1b-dfef2098a41b', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (1058, 2, '2016-12-15 01:12:00', '2016-12-15 01:12:00', '2016-12-15 01:12:00', NULL, NULL, 'F', '2016-12-15011200-a6d9f02a-6604-4192-8bc9-d90b943f81a1', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (1059, 3, '2016-12-15 01:12:00', '2016-12-15 01:12:00', '2016-12-15 01:12:00', NULL, NULL, 'F', '2016-12-15011200-19cee2cd-c447-41b8-8101-9d2c747875c6', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (1060, 1, '2016-12-15 01:12:00', '2016-12-15 01:12:00', '2016-12-15 01:12:00', NULL, NULL, 'F', '2016-12-15011200-7d601390-7800-4be1-98ba-afadea67df00', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (1061, 4, '2016-12-15 01:12:00', '2016-12-15 01:12:00', '2016-12-15 01:12:00', NULL, NULL, 'F', '2016-12-15011200-e5736248-43e1-4a78-9c35-1525e880ac51', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (1062, 10, '2016-12-15 01:12:00', '2016-12-15 01:12:00', '2016-12-15 01:12:00', NULL, NULL, 'F', '2016-12-15011200-17399214-7451-4ab2-8b76-c4f521e1a831', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (1063, 11, '2016-12-15 01:12:00', '2016-12-15 01:12:00', '2016-12-15 01:12:00', NULL, NULL, 'F', '2016-12-15011200-a37eef87-eda1-4b97-abc0-a2bf2013b265', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (1064, 9, '2016-12-15 01:12:00', '2016-12-15 01:12:00', '2016-12-15 01:12:00', NULL, NULL, 'F', '2016-12-15011200-772ba88f-94e0-4701-97fd-a9db59df75ef', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (1065, 12, '2016-12-15 01:12:00', '2016-12-15 01:12:00', '2016-12-15 01:12:00', NULL, NULL, 'F', '2016-12-15011200-1398fe25-96bf-4723-85ce-00c97d95c1e4', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (1066, 6, '2016-12-15 01:13:00', '2016-12-15 01:13:00', '2016-12-15 01:13:00', NULL, NULL, 'F', '2016-12-15011300-9aa09a5b-6230-4227-8df2-5bdf9e8cc4bb', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (1067, 7, '2016-12-15 01:13:00', '2016-12-15 01:13:00', '2016-12-15 01:13:00', NULL, NULL, 'F', '2016-12-15011300-0b5f73de-8cd9-4f8e-ad0d-f7455f52e148', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (1068, 5, '2016-12-15 01:13:00', '2016-12-15 01:13:00', '2016-12-15 01:13:00', NULL, NULL, 'F', '2016-12-15011300-c7aca8a4-810a-4815-85ae-6556e3c21ca2', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (1069, 8, '2016-12-15 01:13:00', '2016-12-15 01:13:00', '2016-12-15 01:13:00', NULL, NULL, 'F', '2016-12-15011300-7a54be16-a7e6-4ec1-8666-3b71e5f32a38', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (1070, 2, '2016-12-15 01:18:00', '2016-12-15 01:18:00', '2016-12-15 01:18:00', NULL, NULL, 'F', '2016-12-15011800-62143590-65a4-4b61-b0b5-28be52a873fa', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (1071, 3, '2016-12-15 01:18:00', '2016-12-15 01:18:00', '2016-12-15 01:18:00', NULL, NULL, 'F', '2016-12-15011800-bd49b0c0-6d83-4c74-8c6f-e68f7ad2ea99', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (1072, 1, '2016-12-15 01:18:00', '2016-12-15 01:18:00', '2016-12-15 01:18:00', NULL, NULL, 'F', '2016-12-15011800-dea5979c-c022-4a4f-815f-a247b2414875', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (1073, 4, '2016-12-15 01:18:00', '2016-12-15 01:18:00', '2016-12-15 01:18:00', NULL, NULL, 'F', '2016-12-15011800-3021e30f-84bd-4178-a766-c2f890501ad5', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (1074, 10, '2016-12-15 01:18:00', '2016-12-15 01:18:00', '2016-12-15 01:18:00', NULL, NULL, 'F', '2016-12-15011800-7a04df67-36de-485d-9be9-c7d4bdc88e5a', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (1075, 11, '2016-12-15 01:18:00', '2016-12-15 01:18:00', '2016-12-15 01:18:00', NULL, NULL, 'F', '2016-12-15011800-2c80c08d-b831-4f6e-a82f-fdd1077b9c51', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (1076, 9, '2016-12-15 01:18:00', '2016-12-15 01:18:00', '2016-12-15 01:18:00', NULL, NULL, 'F', '2016-12-15011800-2641c0bc-b83a-4080-8990-f280943637c6', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (1077, 12, '2016-12-15 01:18:00', '2016-12-15 01:18:00', '2016-12-15 01:18:00', NULL, NULL, 'F', '2016-12-15011800-8b8efa7f-bff8-4b83-bdd8-86e1c7b5778b', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (1078, 6, '2016-12-15 01:18:00', '2016-12-15 01:18:00', '2016-12-15 01:18:00', NULL, NULL, 'F', '2016-12-15011800-ff6b9195-a22b-4ade-9dad-53a3d80bf98f', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (1079, 7, '2016-12-15 01:18:00', '2016-12-15 01:18:00', '2016-12-15 01:18:00', NULL, NULL, 'F', '2016-12-15011800-1245bcaf-f4cb-4120-979f-d6b1cce684bd', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (1080, 5, '2016-12-15 01:18:00', '2016-12-15 01:18:00', '2016-12-15 01:18:00', NULL, NULL, 'F', '2016-12-15011800-d335a0dc-609f-46d7-a898-d2e6fa957dbd', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (1081, 8, '2016-12-15 01:18:00', '2016-12-15 01:18:00', '2016-12-15 01:18:00', NULL, NULL, 'F', '2016-12-15011800-ab1571f1-5788-4922-ac10-9f13c22cfb2a', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (1082, 2, '2016-12-15 01:24:00', '2016-12-15 01:24:00', '2016-12-15 01:24:00', NULL, NULL, 'F', '2016-12-15012400-d71d47f9-f567-47e8-bcd8-041d1b4d2899', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (1083, 3, '2016-12-15 01:24:00', '2016-12-15 01:24:00', '2016-12-15 01:24:00', NULL, NULL, 'F', '2016-12-15012400-e640c456-b95f-4915-8991-cd20ec731038', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (1084, 1, '2016-12-15 01:24:00', '2016-12-15 01:24:00', '2016-12-15 01:24:00', NULL, NULL, 'F', '2016-12-15012400-6f1d6451-d464-4b9e-85a2-967c8eb64b1d', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (1085, 4, '2016-12-15 01:24:00', '2016-12-15 01:24:00', '2016-12-15 01:24:00', NULL, NULL, 'F', '2016-12-15012400-d999c9cf-1a7a-4453-83f5-e025b104ad89', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (1086, 10, '2016-12-15 01:24:00', '2016-12-15 01:24:00', '2016-12-15 01:24:00', NULL, NULL, 'F', '2016-12-15012400-11515561-ea14-428f-b477-62a241ec0013', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (1087, 11, '2016-12-15 01:24:00', '2016-12-15 01:24:00', '2016-12-15 01:24:00', NULL, NULL, 'F', '2016-12-15012400-be962723-0fbd-4ad2-a591-6e5b4d96f8b5', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (1088, 9, '2016-12-15 01:24:00', '2016-12-15 01:24:00', '2016-12-15 01:24:00', NULL, NULL, 'F', '2016-12-15012400-86ccddf7-4ff0-4341-86ae-c9a1f7c55566', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (1089, 12, '2016-12-15 01:24:00', '2016-12-15 01:24:00', '2016-12-15 01:24:00', NULL, NULL, 'F', '2016-12-15012400-40afe0f8-59a0-4d8a-9988-2f75747b62b8', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (1090, 6, '2016-12-15 01:24:00', '2016-12-15 01:24:00', '2016-12-15 01:24:00', NULL, NULL, 'F', '2016-12-15012400-4e839502-f8ca-4784-a6fa-07c60018c71a', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (1091, 7, '2016-12-15 01:24:00', '2016-12-15 01:24:00', '2016-12-15 01:24:00', NULL, NULL, 'F', '2016-12-15012400-722b4ee7-0d05-47b2-b2fd-f79582611690', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (1092, 5, '2016-12-15 01:24:00', '2016-12-15 01:24:00', '2016-12-15 01:24:00', NULL, NULL, 'F', '2016-12-15012400-b912163d-b283-4c19-9f16-19858695bd2b', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (1093, 8, '2016-12-15 01:24:00', '2016-12-15 01:24:00', '2016-12-15 01:24:00', NULL, NULL, 'F', '2016-12-15012400-d26e9d94-b8d3-4cc3-adbf-89f44cc188df', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (1094, 2, '2016-12-15 01:26:00', '2016-12-15 01:26:00', '2016-12-15 01:26:00', NULL, NULL, 'F', '2016-12-15012600-55992aca-9cc5-461d-aebc-78650b503490', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (1095, 3, '2016-12-15 01:26:00', '2016-12-15 01:26:00', '2016-12-15 01:26:00', NULL, NULL, 'F', '2016-12-15012600-256476fb-59b6-4ec9-abee-1cc3319a1479', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (1096, 1, '2016-12-15 01:26:00', '2016-12-15 01:26:00', '2016-12-15 01:26:00', NULL, NULL, 'F', '2016-12-15012600-08883ab5-4abf-4939-a434-61866d8dd410', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (1097, 4, '2016-12-15 01:26:00', '2016-12-15 01:26:00', '2016-12-15 01:26:00', NULL, NULL, 'F', '2016-12-15012600-45b4d50a-3af3-41c9-b29b-ebbbdc92ae17', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (1098, 10, '2016-12-15 01:26:00', '2016-12-15 01:26:00', '2016-12-15 01:26:00', NULL, NULL, 'F', '2016-12-15012600-d230d202-153f-4a9f-a9a5-d44b8ce1dcfa', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (1099, 11, '2016-12-15 01:26:00', '2016-12-15 01:26:00', '2016-12-15 01:26:00', NULL, NULL, 'F', '2016-12-15012600-9de995ac-8b40-4acf-b2c6-3a1ca56dcc3f', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (1100, 9, '2016-12-15 01:26:00', '2016-12-15 01:26:00', '2016-12-15 01:26:00', NULL, NULL, 'F', '2016-12-15012600-641c3752-259d-4b8f-ac6f-710392c52407', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (1101, 12, '2016-12-15 01:26:00', '2016-12-15 01:26:00', '2016-12-15 01:26:00', NULL, NULL, 'F', '2016-12-15012600-bea1dacb-0c50-4672-9c25-d23c45b43bc6', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (1102, 6, '2016-12-15 01:21:00', '2016-12-15 01:21:00', '2016-12-15 01:21:00', NULL, NULL, 'F', '2016-12-15012100-18fbe77e-170f-4e14-9ff2-ebe4f795c020', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (1103, 7, '2016-12-15 01:21:00', '2016-12-15 01:21:00', '2016-12-15 01:21:00', NULL, NULL, 'F', '2016-12-15012100-793b357b-f923-43b5-bc29-49666f922353', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (1104, 5, '2016-12-15 01:21:00', '2016-12-15 01:21:00', '2016-12-15 01:21:00', NULL, NULL, 'F', '2016-12-15012100-9023aee3-4021-4166-9ec1-1bf9caccc185', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (1105, 8, '2016-12-15 01:21:00', '2016-12-15 01:21:00', '2016-12-15 01:21:00', NULL, NULL, 'F', '2016-12-15012100-df4685a1-07ee-4b5f-8a3a-aed2e7e9f2a1', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (1106, 2, '2016-12-15 21:14:00', '2016-12-15 21:14:00', '2016-12-15 21:14:00', NULL, NULL, 'F', '2016-12-15211400-088d0113-5257-453c-89e6-d80155c5ae49', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (1107, 3, '2016-12-15 21:14:00', '2016-12-15 21:14:00', '2016-12-15 21:14:00', NULL, NULL, 'F', '2016-12-15211400-308a4727-615d-4a0f-bdbc-b2cc193ee3a8', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (1108, 1, '2016-12-15 21:14:00', '2016-12-15 21:14:00', '2016-12-15 21:14:00', NULL, NULL, 'F', '2016-12-15211400-983dc0eb-557f-447c-a57e-0dabdef05624', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (1109, 4, '2016-12-15 21:14:00', '2016-12-15 21:14:00', '2016-12-15 21:14:00', NULL, NULL, 'F', '2016-12-15211400-8a6ccb26-a556-4edb-9b55-689326b934e6', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (1110, 10, '2016-12-15 21:14:00', '2016-12-15 21:14:00', '2016-12-15 21:14:00', NULL, NULL, 'F', '2016-12-15211400-60166a82-232c-4d14-a6bf-51a445babaff', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (1111, 11, '2016-12-15 21:14:00', '2016-12-15 21:14:00', '2016-12-15 21:14:00', NULL, NULL, 'F', '2016-12-15211400-7cccb0e1-3fb8-45a5-b6ed-dba8dc08d6da', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (1112, 9, '2016-12-15 21:14:00', '2016-12-15 21:14:00', '2016-12-15 21:14:00', NULL, NULL, 'F', '2016-12-15211400-664cfff7-44ca-4b0b-8b6d-1ea4412a244b', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (1113, 12, '2016-12-15 21:14:00', '2016-12-15 21:14:00', '2016-12-15 21:14:00', NULL, NULL, 'F', '2016-12-15211400-5862b52b-75d1-4c75-82c2-98d5e102e4a7', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (1114, 6, '2016-12-15 21:14:00', '2016-12-15 21:14:00', '2016-12-15 21:14:00', NULL, NULL, 'F', '2016-12-15211400-d699a274-2d3d-4c86-8f3a-fe23d803ed76', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (1115, 7, '2016-12-15 21:14:00', '2016-12-15 21:14:00', '2016-12-15 21:14:00', NULL, NULL, 'F', '2016-12-15211400-947a37bb-32f4-443c-b242-0154f07fa5fa', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (1116, 5, '2016-12-15 21:14:00', '2016-12-15 21:14:00', '2016-12-15 21:14:00', NULL, NULL, 'F', '2016-12-15211400-fc7bfd0d-79f0-4b88-9498-3bb587dac28a', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (1117, 8, '2016-12-15 21:14:00', '2016-12-15 21:14:00', '2016-12-15 21:14:00', NULL, NULL, 'F', '2016-12-15211400-ae318105-c377-42c7-b990-48caffaf919c', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (1118, 2, '2016-12-15 21:16:00', '2016-12-15 21:16:00', '2016-12-15 21:16:00', NULL, NULL, 'F', '2016-12-15211600-6e6bf27d-841e-4724-9bf7-0ba0417c9131', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (1119, 3, '2016-12-15 21:16:00', '2016-12-15 21:16:00', '2016-12-15 21:16:00', NULL, NULL, 'F', '2016-12-15211600-34125de1-18d7-4349-80e5-31cdf4015f44', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (1120, 1, '2016-12-15 21:16:00', '2016-12-15 21:16:00', '2016-12-15 21:16:00', NULL, NULL, 'F', '2016-12-15211600-e22320ab-788d-4cc4-a751-9e584943382a', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (1121, 4, '2016-12-15 21:16:00', '2016-12-15 21:16:00', '2016-12-15 21:16:00', NULL, NULL, 'F', '2016-12-15211600-ac95b2f6-2d30-4b9b-88bb-ed07827d71a3', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (1122, 10, '2016-12-15 21:16:00', '2016-12-15 21:16:00', '2016-12-15 21:16:00', NULL, NULL, 'F', '2016-12-15211600-5be75a16-fd18-4596-8310-9d1e13174dd4', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (1123, 11, '2016-12-15 21:16:00', '2016-12-15 21:16:00', '2016-12-15 21:16:00', NULL, NULL, 'F', '2016-12-15211600-21bea6f6-dc0c-4aff-9820-841389cb4574', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (1124, 9, '2016-12-15 21:16:00', '2016-12-15 21:16:00', '2016-12-15 21:16:00', NULL, NULL, 'F', '2016-12-15211600-48426e6a-3a4b-4f31-93ae-0c18b061977b', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (1125, 12, '2016-12-15 21:16:00', '2016-12-15 21:16:00', '2016-12-15 21:16:00', NULL, NULL, 'F', '2016-12-15211600-c1f75e62-3ec3-4121-9bc7-e371414371b5', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (1126, 6, '2016-12-15 21:17:00', '2016-12-15 21:17:00', '2016-12-15 21:17:00', NULL, NULL, 'F', '2016-12-15211700-98eea0a4-774d-40e2-8648-ecf952e71f0a', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (1127, 7, '2016-12-15 21:17:00', '2016-12-15 21:17:00', '2016-12-15 21:17:00', NULL, NULL, 'F', '2016-12-15211700-21710fcc-6e97-4642-9e65-d2c7b2a2486e', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (1128, 5, '2016-12-15 21:17:00', '2016-12-15 21:17:00', '2016-12-15 21:17:00', NULL, NULL, 'F', '2016-12-15211700-4cb0dec5-16d4-48c5-ad10-dfeb7aa96586', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (1129, 8, '2016-12-15 21:17:00', '2016-12-15 21:17:00', '2016-12-15 21:17:00', NULL, NULL, 'F', '2016-12-15211700-2a05dc2d-b2cd-4715-8fb3-1b77fe2979d6', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (1130, 2, '2016-12-15 22:09:00', '2016-12-15 22:09:00', '2016-12-15 22:09:00', NULL, NULL, 'F', '2016-12-15220900-5deb993f-3c6d-452c-bec8-e50ca63fd7b8', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (1131, 3, '2016-12-15 22:09:00', '2016-12-15 22:09:00', '2016-12-15 22:09:00', NULL, NULL, 'F', '2016-12-15220900-bd6d68c2-b121-4544-b4af-fb556e97ddb3', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (1132, 1, '2016-12-15 22:09:00', '2016-12-15 22:09:00', '2016-12-15 22:09:00', NULL, NULL, 'F', '2016-12-15220900-19db013a-a040-492a-bfb0-403e90b584fb', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (1133, 4, '2016-12-15 22:09:00', '2016-12-15 22:09:00', '2016-12-15 22:09:00', NULL, NULL, 'F', '2016-12-15220900-122fd72c-c43c-4100-94f5-c4604ff4bceb', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (1134, 10, '2016-12-15 22:09:00', '2016-12-15 22:09:00', '2016-12-15 22:09:00', NULL, NULL, 'F', '2016-12-15220900-df6cd1a3-2af1-46c7-8488-84518a2f9f38', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (1135, 11, '2016-12-15 22:09:00', '2016-12-15 22:09:00', '2016-12-15 22:09:00', NULL, NULL, 'F', '2016-12-15220900-a9af2323-413d-4a79-99fe-a879890f90f8', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (1136, 9, '2016-12-15 22:09:00', '2016-12-15 22:09:00', '2016-12-15 22:09:00', NULL, NULL, 'F', '2016-12-15220900-4bf8bbbe-51fe-4510-b930-f0855b93160b', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (1137, 12, '2016-12-15 22:09:00', '2016-12-15 22:09:00', '2016-12-15 22:09:00', NULL, NULL, 'F', '2016-12-15220900-43cc98d3-06ad-45c0-a7db-0629a5a92b4f', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (1138, 6, '2016-12-15 22:09:00', '2016-12-15 22:09:00', '2016-12-15 22:09:00', NULL, NULL, 'F', '2016-12-15220900-ecea6655-e40d-43a5-91e3-cf5ff0d14094', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (1139, 7, '2016-12-15 22:09:00', '2016-12-15 22:09:00', '2016-12-15 22:09:00', NULL, NULL, 'F', '2016-12-15220900-708d2c4d-b547-40ba-a7c7-59db013a93ac', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (1140, 5, '2016-12-15 22:09:00', '2016-12-15 22:09:00', '2016-12-15 22:09:00', NULL, NULL, 'F', '2016-12-15220900-d511d2b0-7a97-4df2-8ea4-91ae79f679b2', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (1141, 8, '2016-12-15 22:09:00', '2016-12-15 22:09:00', '2016-12-15 22:09:00', NULL, NULL, 'F', '2016-12-15220900-a41432ab-948f-4aa2-8bc5-5a1cdf81bce1', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (1142, 2, '2016-12-15 22:11:00', '2016-12-15 22:11:00', '2016-12-15 22:11:00', NULL, NULL, 'F', '2016-12-15221100-aefd6b7a-f435-4d0c-99cb-98aefd7698b0', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (1143, 3, '2016-12-15 22:11:00', '2016-12-15 22:11:00', '2016-12-15 22:11:00', NULL, NULL, 'F', '2016-12-15221100-283b059c-98da-41c9-80a1-444b1ee41619', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (1144, 1, '2016-12-15 22:11:00', '2016-12-15 22:11:00', '2016-12-15 22:11:00', NULL, NULL, 'F', '2016-12-15221100-684b63ba-7896-41a9-a153-60b31518a3d8', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (1145, 4, '2016-12-15 22:11:00', '2016-12-15 22:11:00', '2016-12-15 22:11:00', NULL, NULL, 'F', '2016-12-15221100-9ba540ce-75bc-4d23-bec0-231d80e3880a', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (1146, 10, '2016-12-15 22:11:00', '2016-12-15 22:11:00', '2016-12-15 22:11:00', NULL, NULL, 'F', '2016-12-15221100-74c635f8-5fde-46e6-a853-7c25809ffbf4', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (1147, 11, '2016-12-15 22:11:00', '2016-12-15 22:11:00', '2016-12-15 22:11:00', NULL, NULL, 'F', '2016-12-15221100-be63cecf-ecb7-4b17-9e2c-016779842601', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (1148, 9, '2016-12-15 22:11:00', '2016-12-15 22:11:00', '2016-12-15 22:11:00', NULL, NULL, 'F', '2016-12-15221100-d3717006-ceaa-461a-9cfa-9b612b543d29', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (1149, 12, '2016-12-15 22:11:00', '2016-12-15 22:11:00', '2016-12-15 22:11:00', NULL, NULL, 'F', '2016-12-15221100-94f2f9ef-7515-4be6-b383-4f5429584ab6', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (1150, 6, '2016-12-15 22:12:00', '2016-12-15 22:12:00', '2016-12-15 22:12:00', NULL, NULL, 'F', '2016-12-15221200-32f13926-8525-4cae-ade0-424eb0ae4505', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (1151, 7, '2016-12-15 22:12:00', '2016-12-15 22:12:00', '2016-12-15 22:12:00', NULL, NULL, 'F', '2016-12-15221200-c8b34804-b714-41a3-ab80-4622d9c84871', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (1152, 5, '2016-12-15 22:12:00', '2016-12-15 22:12:00', '2016-12-15 22:12:00', NULL, NULL, 'F', '2016-12-15221200-7db2e558-8b82-44a6-9a15-f085075e2d13', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (1153, 8, '2016-12-15 22:12:00', '2016-12-15 22:12:00', '2016-12-15 22:12:00', NULL, NULL, 'F', '2016-12-15221200-4a73ef3f-2cf8-44bd-823f-2446e17dd550', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (1154, 15, '2016-12-15 22:09:00', '2016-12-15 22:12:00', '2016-12-15 22:12:00', NULL, NULL, 'F', '20161215221200-351bb20c-6d55-4a54-853f-05c3fd4267e1', NULL, NULL, 22);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (1155, 14, '2016-12-15 22:09:00', '2016-12-15 22:12:00', '2016-12-15 22:12:00', NULL, NULL, 'F', '20161215221200-ee44edeb-a767-4a42-8a51-82d72cd68eb8', NULL, NULL, 22);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (1156, 2, '2016-12-16 02:21:00', '2016-12-16 02:21:00', '2016-12-16 02:21:00', NULL, NULL, 'F', '2016-12-16022100-6cd208ef-bdc1-482e-bede-1d838242337e', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (1157, 3, '2016-12-16 02:21:00', '2016-12-16 02:21:00', '2016-12-16 02:21:00', NULL, NULL, 'F', '2016-12-16022100-2213b3c7-7699-4ec7-91ee-d2f670e83b6c', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (1158, 1, '2016-12-16 02:21:00', '2016-12-16 02:21:00', '2016-12-16 02:21:00', NULL, NULL, 'F', '2016-12-16022100-107f48a9-8e41-4800-b362-3bbbbb6b9efd', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (1159, 4, '2016-12-16 02:21:00', '2016-12-16 02:21:00', '2016-12-16 02:21:00', NULL, NULL, 'F', '2016-12-16022100-fe54e586-982b-4860-8fdf-7cc53a0f21a2', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (1160, 10, '2016-12-16 02:21:00', '2016-12-16 02:21:00', '2016-12-16 02:21:00', NULL, NULL, 'F', '2016-12-16022100-dfd8b5d0-5a2c-4d31-8c54-e7552458692b', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (1161, 11, '2016-12-16 02:21:00', '2016-12-16 02:21:00', '2016-12-16 02:21:00', NULL, NULL, 'F', '2016-12-16022100-12ba5f2b-e6ed-4f69-8cf1-9f964608f886', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (1162, 9, '2016-12-16 02:21:00', '2016-12-16 02:21:00', '2016-12-16 02:21:00', NULL, NULL, 'F', '2016-12-16022100-8db9ad54-3203-4f27-8670-5144a17cf367', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (1163, 12, '2016-12-16 02:21:00', '2016-12-16 02:21:00', '2016-12-16 02:21:00', NULL, NULL, 'F', '2016-12-16022100-35a97fbc-49b2-4bbb-97c2-3a2ce9841eb8', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (1164, 6, '2016-12-16 02:21:00', '2016-12-16 02:21:00', '2016-12-16 02:21:00', NULL, NULL, 'F', '2016-12-16022100-a16a322b-daca-43b5-862f-2e3e74f009df', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (1165, 7, '2016-12-16 02:21:00', '2016-12-16 02:21:00', '2016-12-16 02:21:00', NULL, NULL, 'F', '2016-12-16022100-8265e5aa-4cfe-4e2a-a3c2-db4984e72470', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (1166, 5, '2016-12-16 02:21:00', '2016-12-16 02:21:00', '2016-12-16 02:21:00', NULL, NULL, 'F', '2016-12-16022100-5ec9d060-b449-474a-af6d-8feea7570688', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (1167, 8, '2016-12-16 02:21:00', '2016-12-16 02:21:00', '2016-12-16 02:21:00', NULL, NULL, 'F', '2016-12-16022100-61a279de-efe4-4ef0-88c0-c32db1d8cc7e', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (1168, 2, '2016-12-16 02:31:00', '2016-12-16 02:31:00', '2016-12-16 02:31:00', NULL, NULL, 'F', '2016-12-16023100-b33164af-04ff-4eda-890c-81159fd5ec42', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (1169, 3, '2016-12-16 02:31:00', '2016-12-16 02:31:00', '2016-12-16 02:31:00', NULL, NULL, 'F', '2016-12-16023100-0b5106c6-2285-4946-a849-60ed431277b3', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (1170, 1, '2016-12-16 02:31:00', '2016-12-16 02:31:00', '2016-12-16 02:31:00', NULL, NULL, 'F', '2016-12-16023100-0e181bad-63d0-4642-b82b-a93722c10e64', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (1171, 4, '2016-12-16 02:31:00', '2016-12-16 02:31:00', '2016-12-16 02:31:00', NULL, NULL, 'F', '2016-12-16023100-476be5fe-ec11-457e-8719-7928a367e31a', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (1172, 10, '2016-12-16 02:32:00', '2016-12-16 02:32:00', '2016-12-16 02:32:00', NULL, NULL, 'F', '2016-12-16023200-883e8be5-e1bd-4b9e-a47e-532a25ac9469', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (1173, 11, '2016-12-16 02:32:00', '2016-12-16 02:32:00', '2016-12-16 02:32:00', NULL, NULL, 'F', '2016-12-16023200-16a11663-e9bb-44f1-b225-c32efb404109', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (1174, 9, '2016-12-16 02:32:00', '2016-12-16 02:32:00', '2016-12-16 02:32:00', NULL, NULL, 'F', '2016-12-16023200-f03a79d7-ceb1-4f08-9f6d-50ff7f6c416f', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (1175, 12, '2016-12-16 02:32:00', '2016-12-16 02:32:00', '2016-12-16 02:32:00', NULL, NULL, 'F', '2016-12-16023200-8e3c8c4c-eac3-4828-bb26-d9cd11e26dbb', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (1176, 6, '2016-12-16 02:27:00', '2016-12-16 02:27:00', '2016-12-16 02:27:00', NULL, NULL, 'F', '2016-12-16022700-eb8db022-d52c-459c-923e-244da7d302b7', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (1177, 7, '2016-12-16 02:27:00', '2016-12-16 02:27:00', '2016-12-16 02:27:00', NULL, NULL, 'F', '2016-12-16022700-e1e0c67c-5db3-4268-af54-b7237c3fe881', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (1178, 5, '2016-12-16 02:27:00', '2016-12-16 02:27:00', '2016-12-16 02:27:00', NULL, NULL, 'F', '2016-12-16022700-c4a5f99b-0a38-4e56-8693-1276cf239413', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (1179, 8, '2016-12-16 02:27:00', '2016-12-16 02:27:00', '2016-12-16 02:27:00', NULL, NULL, 'F', '2016-12-16022700-6ddeff31-2037-41ad-83a0-8536340ecd21', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (1180, 2, '2016-12-16 02:38:00', '2016-12-16 02:38:00', '2016-12-16 02:38:00', NULL, NULL, 'F', '2016-12-16023800-e3f8b7c0-95b7-496b-a9c3-200aca7a5682', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (1181, 3, '2016-12-16 02:38:00', '2016-12-16 02:38:00', '2016-12-16 02:38:00', NULL, NULL, 'F', '2016-12-16023800-00d20050-ebed-4594-8dab-1e309dc18927', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (1182, 1, '2016-12-16 02:38:00', '2016-12-16 02:38:00', '2016-12-16 02:38:00', NULL, NULL, 'F', '2016-12-16023800-808d7372-e3f3-4974-84be-645e804afcd8', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (1183, 4, '2016-12-16 02:38:00', '2016-12-16 02:38:00', '2016-12-16 02:38:00', NULL, NULL, 'F', '2016-12-16023800-ec4f3b58-bb50-42e4-9310-dc892c1932a4', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (1184, 10, '2016-12-16 02:38:00', '2016-12-16 02:38:00', '2016-12-16 02:38:00', NULL, NULL, 'F', '2016-12-16023800-e844fc4e-3650-41c7-9fda-e351b9bf3804', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (1185, 11, '2016-12-16 02:38:00', '2016-12-16 02:38:00', '2016-12-16 02:38:00', NULL, NULL, 'F', '2016-12-16023800-967635bf-750a-4729-b38f-9ab7d77756e9', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (1186, 9, '2016-12-16 02:38:00', '2016-12-16 02:38:00', '2016-12-16 02:38:00', NULL, NULL, 'F', '2016-12-16023800-46e6cccc-032e-427f-af4e-5b06b3b3c55d', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (1187, 12, '2016-12-16 02:38:00', '2016-12-16 02:38:00', '2016-12-16 02:38:00', NULL, NULL, 'F', '2016-12-16023800-df2cced4-7b5a-4471-a55d-04c123dfd9b0', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (1188, 6, '2016-12-16 02:38:00', '2016-12-16 02:38:00', '2016-12-16 02:38:00', NULL, NULL, 'F', '2016-12-16023800-dfddd2e6-bbf7-4623-af88-b3150572ceba', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (1189, 7, '2016-12-16 02:38:00', '2016-12-16 02:38:00', '2016-12-16 02:38:00', NULL, NULL, 'F', '2016-12-16023800-8d4777ba-e82c-4dbf-a3fb-f85920e2976e', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (1190, 5, '2016-12-16 02:38:00', '2016-12-16 02:38:00', '2016-12-16 02:38:00', NULL, NULL, 'F', '2016-12-16023800-2e542328-61e2-4356-b8c0-aee7395cd3f8', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (1191, 8, '2016-12-16 02:38:00', '2016-12-16 02:38:00', '2016-12-16 02:38:00', NULL, NULL, 'F', '2016-12-16023800-719b776c-d8b1-46d9-bffd-b9cbcedb3c53', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (1192, 2, '2016-12-16 11:34:00', '2016-12-16 11:34:00', '2016-12-16 11:34:00', NULL, NULL, 'F', '2016-12-16113400-d347391f-16ba-454e-adb8-e7b1367cc52e', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (1193, 3, '2016-12-16 11:34:00', '2016-12-16 11:34:00', '2016-12-16 11:34:00', NULL, NULL, 'F', '2016-12-16113400-698e299e-36a5-4de1-bfa2-f7dd9c386822', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (1194, 1, '2016-12-16 11:34:00', '2016-12-16 11:34:00', '2016-12-16 11:34:00', NULL, NULL, 'F', '2016-12-16113400-a882bfbf-95c3-4fc4-a04b-704d40d4c756', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (1195, 4, '2016-12-16 11:34:00', '2016-12-16 11:34:00', '2016-12-16 11:34:00', NULL, NULL, 'F', '2016-12-16113400-e93a2fdb-5cd0-4b6d-90cc-dd5cc58dcf1b', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (1196, 10, '2016-12-16 11:34:00', '2016-12-16 11:34:00', '2016-12-16 11:34:00', NULL, NULL, 'F', '2016-12-16113400-7f519e75-c74b-43a3-a19d-f70619a8d81b', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (1197, 11, '2016-12-16 11:34:00', '2016-12-16 11:34:00', '2016-12-16 11:34:00', NULL, NULL, 'F', '2016-12-16113400-49075d6f-7946-4fd5-adba-11847a7fab6f', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (1198, 9, '2016-12-16 11:34:00', '2016-12-16 11:34:00', '2016-12-16 11:34:00', NULL, NULL, 'F', '2016-12-16113400-ece8fec1-6968-49ed-aa8b-b34b3412eee0', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (1199, 12, '2016-12-16 11:34:00', '2016-12-16 11:34:00', '2016-12-16 11:34:00', NULL, NULL, 'F', '2016-12-16113400-06a78272-4680-4a21-a1de-80f8e7a42e64', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (1200, 6, '2016-12-16 11:34:00', '2016-12-16 11:34:00', '2016-12-16 11:34:00', NULL, NULL, 'F', '2016-12-16113400-371f550b-7e4c-49e7-b34d-3af0eb87df31', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (1201, 7, '2016-12-16 11:34:00', '2016-12-16 11:34:00', '2016-12-16 11:34:00', NULL, NULL, 'F', '2016-12-16113400-23e23dc3-3321-4cd3-a538-41de2aa3a9d3', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (1202, 5, '2016-12-16 11:34:00', '2016-12-16 11:34:00', '2016-12-16 11:34:00', NULL, NULL, 'F', '2016-12-16113400-85f1b6e7-7d03-41f4-9831-4e88d13815ff', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (1203, 8, '2016-12-16 11:34:00', '2016-12-16 11:34:00', '2016-12-16 11:34:00', NULL, NULL, 'F', '2016-12-16113400-ad921d1e-e221-4a3b-aca5-0bd3b8ec5e2f', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (1204, 2, '2016-12-16 13:40:00', '2016-12-16 13:40:00', '2016-12-16 13:40:00', NULL, NULL, 'F', '2016-12-16134000-e6e10338-ca40-405c-a916-713e1744f3b5', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (1205, 3, '2016-12-16 13:40:00', '2016-12-16 13:40:00', '2016-12-16 13:40:00', NULL, NULL, 'F', '2016-12-16134000-6c764cc8-7a2e-48e1-81ac-505fe427aade', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (1206, 1, '2016-12-16 13:40:00', '2016-12-16 13:40:00', '2016-12-16 13:40:00', NULL, NULL, 'F', '2016-12-16134000-8fb1b0df-0924-4411-9661-911b49586bfd', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (1207, 4, '2016-12-16 13:40:00', '2016-12-16 13:40:00', '2016-12-16 13:40:00', NULL, NULL, 'F', '2016-12-16134000-63e6512e-6e74-4191-b910-3ab132fc900f', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (1208, 10, '2016-12-16 13:40:00', '2016-12-16 13:40:00', '2016-12-16 13:40:00', NULL, NULL, 'F', '2016-12-16134000-612b4c74-2b90-4aeb-a63c-3db3f0ecdf3d', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (1209, 11, '2016-12-16 13:40:00', '2016-12-16 13:40:00', '2016-12-16 13:40:00', NULL, NULL, 'F', '2016-12-16134000-b4286546-c082-417e-a5d0-9f52f54e5a43', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (1210, 9, '2016-12-16 13:40:00', '2016-12-16 13:40:00', '2016-12-16 13:40:00', NULL, NULL, 'F', '2016-12-16134000-67a1cdf7-7b6a-4e4f-aa5f-16a7ef0b8422', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (1211, 12, '2016-12-16 13:40:00', '2016-12-16 13:40:00', '2016-12-16 13:40:00', NULL, NULL, 'F', '2016-12-16134000-cfcfdb05-88c5-42f9-8486-6b4b7ccf8118', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (1212, 6, '2016-12-16 13:40:00', '2016-12-16 13:40:00', '2016-12-16 13:40:00', NULL, NULL, 'F', '2016-12-16134000-9b1114f3-0080-461b-a2d7-e48bcfb8c5a4', NULL, NULL, 21);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (1213, 7, '2016-12-16 13:40:00', '2016-12-16 13:40:00', '2016-12-16 13:40:00', NULL, NULL, 'F', '2016-12-16134000-af0809b1-93aa-4482-888c-33f41b991893', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (1214, 5, '2016-12-16 13:40:00', '2016-12-16 13:40:00', '2016-12-16 13:40:00', NULL, NULL, 'F', '2016-12-16134000-f82bf2a5-3e1c-4e8e-ae24-0fddf2a7355b', NULL, NULL, 7);
INSERT INTO observation (observationid, seriesid, phenomenontimestart, phenomenontimeend, resulttime, validtimestart, validtimeend, deleted, identifier, codespaceid, description, unitid) VALUES (1215, 8, '2016-12-16 13:40:00', '2016-12-16 13:40:00', '2016-12-16 13:40:00', NULL, NULL, 'F', '2016-12-16134000-3bd525d6-1f18-4607-a389-e6f3a193b02f', NULL, NULL, 21);


--
-- Data for Name: observationconstellation; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Name: observationconstellationid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('observationconstellationid_seq', 1, false);


--
-- Data for Name: observationhasoffering; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Name: observationid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('observationid_seq', 1215, true);


--
-- Data for Name: observationtype; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Name: observationtypeid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('observationtypeid_seq', 1, false);


--
-- Data for Name: offering; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: offeringallowedfeaturetype; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: offeringallowedobservationtype; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: offeringhasrelatedfeature; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Name: offeringid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('offeringid_seq', 1, false);


--
-- Data for Name: parameter; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Name: parameterid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('parameterid_seq', 1, false);


--
-- Name: procdescformatid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('procdescformatid_seq', 1, false);


--
-- Data for Name: procedure; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO procedure (procedureid, hibernatediscriminator, proceduredescriptionformatid, identifier, deleted, descriptionfile) VALUES (1, 'N', 1, 'LM35', 'F', 'Analog Temperature');
INSERT INTO procedure (procedureid, hibernatediscriminator, proceduredescriptionformatid, identifier, deleted, descriptionfile) VALUES (3, 'N', 1, 'LM393', 'F', 'Soil Moisture');
INSERT INTO procedure (procedureid, hibernatediscriminator, proceduredescriptionformatid, identifier, deleted, descriptionfile) VALUES (2, 'N', 1, 'DHT22', 'F', 'Digital Measurement');
INSERT INTO procedure (procedureid, hibernatediscriminator, proceduredescriptionformatid, identifier, deleted, descriptionfile) VALUES (4, 'N', 1, 'Hunter PGV 100 GB DC', 'F', 'DC Latching Solenoid');


--
-- Data for Name: proceduredescriptionformat; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO proceduredescriptionformat (proceduredescriptionformatid, proceduredescriptionformat) VALUES (1, 'Δεδομένα προς θέαση');
INSERT INTO proceduredescriptionformat (proceduredescriptionformatid, proceduredescriptionformat) VALUES (2, 'Δεδομένα που δεν είναι προς θέαση');


--
-- Name: procedureid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('procedureid_seq', 13, true);


--
-- Data for Name: relatedfeature; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: relatedfeaturehasrole; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Name: relatedfeatureid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('relatedfeatureid_seq', 1, false);


--
-- Data for Name: relatedfeaturerole; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Name: relatedfeatureroleid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('relatedfeatureroleid_seq', 1, false);


--
-- Data for Name: resulttemplate; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Name: resulttemplateid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('resulttemplateid_seq', 1, false);


--
-- Data for Name: sensorsystem; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: series; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO series (seriesid, featureofinterestid, observablepropertyid, procedureid, deleted) VALUES (1, 3, 3, 1, 'F');
INSERT INTO series (seriesid, featureofinterestid, observablepropertyid, procedureid, deleted) VALUES (2, 3, 1, 2, 'F');
INSERT INTO series (seriesid, featureofinterestid, observablepropertyid, procedureid, deleted) VALUES (3, 3, 2, 2, 'F');
INSERT INTO series (seriesid, featureofinterestid, observablepropertyid, procedureid, deleted) VALUES (4, 3, 4, 3, 'F');
INSERT INTO series (seriesid, featureofinterestid, observablepropertyid, procedureid, deleted) VALUES (5, 4, 3, 1, 'F');
INSERT INTO series (seriesid, featureofinterestid, observablepropertyid, procedureid, deleted) VALUES (6, 4, 1, 2, 'F');
INSERT INTO series (seriesid, featureofinterestid, observablepropertyid, procedureid, deleted) VALUES (7, 4, 2, 2, 'F');
INSERT INTO series (seriesid, featureofinterestid, observablepropertyid, procedureid, deleted) VALUES (8, 4, 4, 3, 'F');
INSERT INTO series (seriesid, featureofinterestid, observablepropertyid, procedureid, deleted) VALUES (9, 5, 3, 1, 'F');
INSERT INTO series (seriesid, featureofinterestid, observablepropertyid, procedureid, deleted) VALUES (10, 5, 1, 2, 'F');
INSERT INTO series (seriesid, featureofinterestid, observablepropertyid, procedureid, deleted) VALUES (11, 5, 2, 2, 'F');
INSERT INTO series (seriesid, featureofinterestid, observablepropertyid, procedureid, deleted) VALUES (12, 5, 4, 3, 'F');
INSERT INTO series (seriesid, featureofinterestid, observablepropertyid, procedureid, deleted) VALUES (13, 3, 5, 4, 'F');
INSERT INTO series (seriesid, featureofinterestid, observablepropertyid, procedureid, deleted) VALUES (14, 4, 5, 4, 'F');
INSERT INTO series (seriesid, featureofinterestid, observablepropertyid, procedureid, deleted) VALUES (15, 5, 5, 4, 'F');


--
-- Name: seriesid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('seriesid_seq', 15, true);


--
-- Data for Name: spatial_ref_sys; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: spatialfilteringprofile; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Name: spatialfilteringprofileid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('spatialfilteringprofileid_seq', 1, false);


--
-- Data for Name: swedataarrayvalue; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: textvalue; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: unit; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO unit (unitid, unit) VALUES (1, 'm/s');
INSERT INTO unit (unitid, unit) VALUES (2, 'rad');
INSERT INTO unit (unitid, unit) VALUES (3, 'rV');
INSERT INTO unit (unitid, unit) VALUES (4, 'W/m²');
INSERT INTO unit (unitid, unit) VALUES (5, 'mm');
INSERT INTO unit (unitid, unit) VALUES (6, 'kbps');
INSERT INTO unit (unitid, unit) VALUES (7, '°C');
INSERT INTO unit (unitid, unit) VALUES (9, 'V');
INSERT INTO unit (unitid, unit) VALUES (8, 'sec');
INSERT INTO unit (unitid, unit) VALUES (10, 'NTU');
INSERT INTO unit (unitid, unit) VALUES (11, 'μS/cm');
INSERT INTO unit (unitid, unit) VALUES (15, 'ppm');
INSERT INTO unit (unitid, unit) VALUES (17, 'm');
INSERT INTO unit (unitid, unit) VALUES (20, 'mg/l');
INSERT INTO unit (unitid, unit) VALUES (21, 'RH');
INSERT INTO unit (unitid, unit) VALUES (22, 'lt');


--
-- Name: unitid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('unitid_seq', 20, true);


--
-- Data for Name: user_role; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO user_role (user_role_id, name, description) VALUES (2, 'user', NULL);
INSERT INTO user_role (user_role_id, name, description) VALUES (1, 'admin', NULL);


--
-- Data for Name: userprofile; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO userprofile (user_id, firstname, lastname, fathersname, dateofbirth, address, addressnum, zipcode, telephone, mobile) VALUES (2, 'geor', 'geor', 'pol', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO userprofile (user_id, firstname, lastname, fathersname, dateofbirth, address, addressnum, zipcode, telephone, mobile) VALUES (3, 'stef', 'kour', 'kour', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO userprofile (user_id, firstname, lastname, fathersname, dateofbirth, address, addressnum, zipcode, telephone, mobile) VALUES (4, 'kostas', 'tacoon', 'rac', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO userprofile (user_id, firstname, lastname, fathersname, dateofbirth, address, addressnum, zipcode, telephone, mobile) VALUES (5, 'ydro', 'ydro', 'ydro', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO userprofile (user_id, firstname, lastname, fathersname, dateofbirth, address, addressnum, zipcode, telephone, mobile) VALUES (1, 'dim', 'smirn', 'alex', '1988-03-01', 'filade', '5556', '123', '5678954', '456445');


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO users (username, password, email, user_role_id, user_id) VALUES ('dim', '123', 'dim@gmail.com', 2, 1);
INSERT INTO users (username, password, email, user_role_id, user_id) VALUES ('george', '123', 'g@gmail.com', 1, 2);
INSERT INTO users (username, password, email, user_role_id, user_id) VALUES ('stef', '123123', 'stef@gmail.com', 2, 3);
INSERT INTO users (username, password, email, user_role_id, user_id) VALUES ('kostas', '123456', 'kostas@email.gr', 1, 4);
INSERT INTO users (username, password, email, user_role_id, user_id) VALUES ('ydro', '123456', 'ydro@in.gr', 1, 5);


--
-- Name: users_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('users_user_id_seq', 3, true);


--
-- Name: uthbaldata_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('uthbaldata_seq', 2059, true);


--
-- Data for Name: validproceduretime; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Name: validproceduretimeid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('validproceduretimeid_seq', 1, false);


SET search_path = tiger, pg_catalog;

--
-- Data for Name: geocode_settings; Type: TABLE DATA; Schema: tiger; Owner: postgres
--

INSERT INTO geocode_settings (name, setting, unit, category, short_desc) VALUES ('debug_geocode_address', 'false', 'boolean', 'debug', 'outputs debug information in notice log such as queries when geocode_addresss is called if true');
INSERT INTO geocode_settings (name, setting, unit, category, short_desc) VALUES ('debug_geocode_intersection', 'false', 'boolean', 'debug', 'outputs debug information in notice log such as queries when geocode_intersection is called if true');
INSERT INTO geocode_settings (name, setting, unit, category, short_desc) VALUES ('debug_normalize_address', 'false', 'boolean', 'debug', 'outputs debug information in notice log such as queries and intermediate expressions when normalize_address is called if true');
INSERT INTO geocode_settings (name, setting, unit, category, short_desc) VALUES ('debug_reverse_geocode', 'false', 'boolean', 'debug', 'if true, outputs debug information in notice log such as queries and intermediate expressions when reverse_geocode');
INSERT INTO geocode_settings (name, setting, unit, category, short_desc) VALUES ('reverse_geocode_numbered_roads', '0', 'integer', 'rating', 'For state and county highways, 0 - no preference in name, 1 - prefer the numbered highway name, 2 - prefer local state/county name');
INSERT INTO geocode_settings (name, setting, unit, category, short_desc) VALUES ('use_pagc_address_parser', 'false', 'boolean', 'normalize', 'If set to true, will try to use the pagc_address normalizer instead of tiger built one');


--
-- Data for Name: pagc_gaz; Type: TABLE DATA; Schema: tiger; Owner: postgres
--



--
-- Data for Name: pagc_lex; Type: TABLE DATA; Schema: tiger; Owner: postgres
--



--
-- Data for Name: pagc_rules; Type: TABLE DATA; Schema: tiger; Owner: postgres
--



SET search_path = topology, pg_catalog;

--
-- Data for Name: topology; Type: TABLE DATA; Schema: topology; Owner: postgres
--



--
-- Data for Name: layer; Type: TABLE DATA; Schema: topology; Owner: postgres
--



SET search_path = public, pg_catalog;

--
-- Name: blobvalue blobvalue_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY blobvalue
    ADD CONSTRAINT blobvalue_pkey PRIMARY KEY (observationid);


--
-- Name: booleanvalue booleanvalue_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY booleanvalue
    ADD CONSTRAINT booleanvalue_pkey PRIMARY KEY (observationid);


--
-- Name: categoryvalue categoryvalue_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY categoryvalue
    ADD CONSTRAINT categoryvalue_pkey PRIMARY KEY (observationid);


--
-- Name: codespace codespace_codespace_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY codespace
    ADD CONSTRAINT codespace_codespace_key UNIQUE (codespace);


--
-- Name: codespace codespace_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY codespace
    ADD CONSTRAINT codespace_pkey PRIMARY KEY (codespaceid);


--
-- Name: compositephenomenon compositephenomenon_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY compositephenomenon
    ADD CONSTRAINT compositephenomenon_pkey PRIMARY KEY (childobservablepropertyid, parentobservablepropertyid);


--
-- Name: countvalue countvalue_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY countvalue
    ADD CONSTRAINT countvalue_pkey PRIMARY KEY (observationid);


--
-- Name: featureofinterest featureofinterest_identifier_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY featureofinterest
    ADD CONSTRAINT featureofinterest_identifier_key UNIQUE (identifier);


--
-- Name: featureofinterest featureofinterest_url_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY featureofinterest
    ADD CONSTRAINT featureofinterest_url_key UNIQUE (url);


--
-- Name: featureofinterest featureofinterestid; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY featureofinterest
    ADD CONSTRAINT featureofinterestid PRIMARY KEY (featureofinterestid);


--
-- Name: featureofinteresttype featureofinteresttype_featureofinteresttype_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY featureofinteresttype
    ADD CONSTRAINT featureofinteresttype_featureofinteresttype_key UNIQUE (featureofinteresttype);


--
-- Name: featureofinteresttype featureofinteresttype_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY featureofinteresttype
    ADD CONSTRAINT featureofinteresttype_pkey PRIMARY KEY (featureofinteresttypeid);


--
-- Name: featurerelation featurerelation_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY featurerelation
    ADD CONSTRAINT featurerelation_pkey PRIMARY KEY (parentfeatureid, childfeatureid);


--
-- Name: geometryvalue geometryvalue_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY geometryvalue
    ADD CONSTRAINT geometryvalue_pkey PRIMARY KEY (observationid);


--
-- Name: hasfeatures hasfeatures_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY hasfeatures
    ADD CONSTRAINT hasfeatures_pkey PRIMARY KEY (user_id, featureofinterestid);


--
-- Name: notifications notifidpk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY notifications
    ADD CONSTRAINT notifidpk PRIMARY KEY (notificationid);


--
-- Name: numericvalue numericvalue_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY numericvalue
    ADD CONSTRAINT numericvalue_pkey PRIMARY KEY (observationid);


--
-- Name: observableproperty observableproperty_identifier_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY observableproperty
    ADD CONSTRAINT observableproperty_identifier_key UNIQUE (identifier);


--
-- Name: observableproperty observableproperty_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY observableproperty
    ADD CONSTRAINT observableproperty_pkey PRIMARY KEY (observablepropertyid);


--
-- Name: observation observation_identifier_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY observation
    ADD CONSTRAINT observation_identifier_key UNIQUE (identifier);


--
-- Name: observation observation_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY observation
    ADD CONSTRAINT observation_pkey PRIMARY KEY (observationid);


--
-- Name: observation observation_seriesid_phenomenontimestart_phenomenontimeend__key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY observation
    ADD CONSTRAINT observation_seriesid_phenomenontimestart_phenomenontimeend__key UNIQUE (seriesid, phenomenontimestart, phenomenontimeend, resulttime);


--
-- Name: observationconstellation observationconstellation_observablepropertyid_procedureid_o_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY observationconstellation
    ADD CONSTRAINT observationconstellation_observablepropertyid_procedureid_o_key UNIQUE (observablepropertyid, procedureid, offeringid);


--
-- Name: observationconstellation observationconstellation_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY observationconstellation
    ADD CONSTRAINT observationconstellation_pkey PRIMARY KEY (observationconstellationid);


--
-- Name: observationhasoffering observationhasoffering_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY observationhasoffering
    ADD CONSTRAINT observationhasoffering_pkey PRIMARY KEY (observationid, offeringid);


--
-- Name: observationtype observationtype_observationtype_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY observationtype
    ADD CONSTRAINT observationtype_observationtype_key UNIQUE (observationtype);


--
-- Name: observationtype observationtype_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY observationtype
    ADD CONSTRAINT observationtype_pkey PRIMARY KEY (observationtypeid);


--
-- Name: offering offering_identifier_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY offering
    ADD CONSTRAINT offering_identifier_key UNIQUE (identifier);


--
-- Name: offering offering_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY offering
    ADD CONSTRAINT offering_pkey PRIMARY KEY (offeringid);


--
-- Name: offeringallowedfeaturetype offeringallowedfeaturetype_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY offeringallowedfeaturetype
    ADD CONSTRAINT offeringallowedfeaturetype_pkey PRIMARY KEY (offeringid, featureofinteresttypeid);


--
-- Name: offeringallowedobservationtype offeringallowedobservationtype_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY offeringallowedobservationtype
    ADD CONSTRAINT offeringallowedobservationtype_pkey PRIMARY KEY (offeringid, observationtypeid);


--
-- Name: offeringhasrelatedfeature offeringhasrelatedfeature_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY offeringhasrelatedfeature
    ADD CONSTRAINT offeringhasrelatedfeature_pkey PRIMARY KEY (offeringid, relatedfeatureid);


--
-- Name: parameter parameter_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY parameter
    ADD CONSTRAINT parameter_pkey PRIMARY KEY (parameterid);


--
-- Name: enddevice pk_id; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY enddevice
    ADD CONSTRAINT pk_id PRIMARY KEY (id);


--
-- Name: observablepropertyminmax pk_observationpropertyminmax; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY observablepropertyminmax
    ADD CONSTRAINT pk_observationpropertyminmax PRIMARY KEY (obspropertyid);


--
-- Name: users pk_user; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY users
    ADD CONSTRAINT pk_user PRIMARY KEY (user_id);


--
-- Name: user_role pk_user_role; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY user_role
    ADD CONSTRAINT pk_user_role PRIMARY KEY (user_role_id);


--
-- Name: procedure procedure_identifier_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY procedure
    ADD CONSTRAINT procedure_identifier_key UNIQUE (identifier);


--
-- Name: procedure procedure_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY procedure
    ADD CONSTRAINT procedure_pkey PRIMARY KEY (procedureid);


--
-- Name: proceduredescriptionformat proceduredescriptionformat_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY proceduredescriptionformat
    ADD CONSTRAINT proceduredescriptionformat_pkey PRIMARY KEY (proceduredescriptionformatid);


--
-- Name: relatedfeature relatedfeature_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY relatedfeature
    ADD CONSTRAINT relatedfeature_pkey PRIMARY KEY (relatedfeatureid);


--
-- Name: relatedfeaturehasrole relatedfeaturehasrole_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY relatedfeaturehasrole
    ADD CONSTRAINT relatedfeaturehasrole_pkey PRIMARY KEY (relatedfeatureid, relatedfeatureroleid);


--
-- Name: relatedfeaturerole relatedfeaturerole_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY relatedfeaturerole
    ADD CONSTRAINT relatedfeaturerole_pkey PRIMARY KEY (relatedfeatureroleid);


--
-- Name: relatedfeaturerole relatedfeaturerole_relatedfeaturerole_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY relatedfeaturerole
    ADD CONSTRAINT relatedfeaturerole_relatedfeaturerole_key UNIQUE (relatedfeaturerole);


--
-- Name: resulttemplate resulttemplate_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY resulttemplate
    ADD CONSTRAINT resulttemplate_pkey PRIMARY KEY (resulttemplateid);


--
-- Name: sensorsystem sensorsystem_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY sensorsystem
    ADD CONSTRAINT sensorsystem_pkey PRIMARY KEY (childsensorid, parentsensorid);


--
-- Name: series series_featureofinterestid_observablepropertyid_procedureid_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY series
    ADD CONSTRAINT series_featureofinterestid_observablepropertyid_procedureid_key UNIQUE (featureofinterestid, observablepropertyid, procedureid);


--
-- Name: series series_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY series
    ADD CONSTRAINT series_pkey PRIMARY KEY (seriesid);


--
-- Name: spatialfilteringprofile spatialfilteringprofile_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY spatialfilteringprofile
    ADD CONSTRAINT spatialfilteringprofile_pkey PRIMARY KEY (spatialfilteringprofileid);


--
-- Name: swedataarrayvalue swedataarrayvalue_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY swedataarrayvalue
    ADD CONSTRAINT swedataarrayvalue_pkey PRIMARY KEY (observationid);


--
-- Name: textvalue textvalue_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY textvalue
    ADD CONSTRAINT textvalue_pkey PRIMARY KEY (observationid);


--
-- Name: unit unit_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY unit
    ADD CONSTRAINT unit_pkey PRIMARY KEY (unitid);


--
-- Name: unit unit_unit_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY unit
    ADD CONSTRAINT unit_unit_key UNIQUE (unit);


--
-- Name: userprofile userprofile_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY userprofile
    ADD CONSTRAINT userprofile_pkey PRIMARY KEY (user_id);


--
-- Name: validproceduretime validproceduretime_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY validproceduretime
    ADD CONSTRAINT validproceduretime_pkey PRIMARY KEY (validproceduretimeid);


--
-- Name: obscodespaceidx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX obscodespaceidx ON observation USING btree (codespaceid);


--
-- Name: obsconstobspropidx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX obsconstobspropidx ON observationconstellation USING btree (observablepropertyid);


--
-- Name: obsconstofferingidx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX obsconstofferingidx ON observationconstellation USING btree (offeringid);


--
-- Name: obsconstprocedureidx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX obsconstprocedureidx ON observationconstellation USING btree (procedureid);


--
-- Name: obshasoffobservationidx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX obshasoffobservationidx ON observationhasoffering USING btree (observationid);


--
-- Name: obshasoffofferingidx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX obshasoffofferingidx ON observationhasoffering USING btree (offeringid);


--
-- Name: obsphentimeendidx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX obsphentimeendidx ON observation USING btree (phenomenontimeend);


--
-- Name: obsphentimestartidx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX obsphentimestartidx ON observation USING btree (phenomenontimestart);


--
-- Name: obsresulttimeidx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX obsresulttimeidx ON observation USING btree (resulttime);


--
-- Name: obsseriesidx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX obsseriesidx ON observation USING btree (seriesid);


--
-- Name: resulttempeobspropidx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX resulttempeobspropidx ON resulttemplate USING btree (observablepropertyid);


--
-- Name: resulttempidentifieridx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX resulttempidentifieridx ON resulttemplate USING btree (identifier);


--
-- Name: resulttempofferingidx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX resulttempofferingidx ON resulttemplate USING btree (offeringid);


--
-- Name: resulttempprocedureidx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX resulttempprocedureidx ON resulttemplate USING btree (procedureid);


--
-- Name: seriesfeatureidx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX seriesfeatureidx ON series USING btree (featureofinterestid);


--
-- Name: seriesobspropidx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX seriesobspropidx ON series USING btree (observablepropertyid);


--
-- Name: seriesprocedureidx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX seriesprocedureidx ON series USING btree (procedureid);


--
-- Name: sfpobservationidx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX sfpobservationidx ON spatialfilteringprofile USING btree (observation);


--
-- Name: validproceduretimeendtimeidx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX validproceduretimeendtimeidx ON validproceduretime USING btree (endtime);


--
-- Name: validproceduretimestarttimeidx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX validproceduretimestarttimeidx ON validproceduretime USING btree (starttime);


--
-- Name: featurerelation childfeatureid; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY featurerelation
    ADD CONSTRAINT childfeatureid FOREIGN KEY (childfeatureid) REFERENCES featureofinterest(featureofinterestid);


--
-- Name: featureofinterest featurecodespacefk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY featureofinterest
    ADD CONSTRAINT featurecodespacefk FOREIGN KEY (codespaceid) REFERENCES codespace(codespaceid);


--
-- Name: featureofinterest featurefeaturetypefk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY featureofinterest
    ADD CONSTRAINT featurefeaturetypefk FOREIGN KEY (featureofinteresttypeid) REFERENCES featureofinteresttype(featureofinteresttypeid);


--
-- Name: featureofinterest featureofinterest_parentid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY featureofinterest
    ADD CONSTRAINT featureofinterest_parentid_fkey FOREIGN KEY (parentid) REFERENCES featureofinterest(featureofinterestid);


--
-- Name: hasfeatures featureofinterestid; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY hasfeatures
    ADD CONSTRAINT featureofinterestid FOREIGN KEY (featureofinterestid) REFERENCES featureofinterest(featureofinterestid);


--
-- Name: users fk1_user_role; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY users
    ADD CONSTRAINT fk1_user_role FOREIGN KEY (user_role_id) REFERENCES user_role(user_role_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: offeringallowedobservationtype fk28e66a64e4ef3005; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY offeringallowedobservationtype
    ADD CONSTRAINT fk28e66a64e4ef3005 FOREIGN KEY (offeringid) REFERENCES offering(offeringid);


--
-- Name: relatedfeaturehasrole fk5643e7654a79987; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY relatedfeaturehasrole
    ADD CONSTRAINT fk5643e7654a79987 FOREIGN KEY (relatedfeatureid) REFERENCES relatedfeature(relatedfeatureid);


--
-- Name: observationhasoffering fk7d7608f4e759db68; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY observationhasoffering
    ADD CONSTRAINT fk7d7608f4e759db68 FOREIGN KEY (observationid) REFERENCES observation(observationid);


--
-- Name: observablepropertyminmax fk_observableproperty_obsprop; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY observablepropertyminmax
    ADD CONSTRAINT fk_observableproperty_obsprop FOREIGN KEY (observablepropertyid) REFERENCES observableproperty(observablepropertyid);


--
-- Name: observablepropertyminmax fk_observationpropertyminmax; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY observablepropertyminmax
    ADD CONSTRAINT fk_observationpropertyminmax FOREIGN KEY (featureofinterestid) REFERENCES featureofinterest(featureofinterestid);


--
-- Name: users fk_users_userprofile; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY users
    ADD CONSTRAINT fk_users_userprofile FOREIGN KEY (user_id) REFERENCES userprofile(user_id) ON DELETE CASCADE;


--
-- Name: offeringallowedfeaturetype fkf68cb72ee4ef3005; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY offeringallowedfeaturetype
    ADD CONSTRAINT fkf68cb72ee4ef3005 FOREIGN KEY (offeringid) REFERENCES offering(offeringid);


--
-- Name: observationconstellation obsconstobservationiypefk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY observationconstellation
    ADD CONSTRAINT obsconstobservationiypefk FOREIGN KEY (observationtypeid) REFERENCES observationtype(observationtypeid);


--
-- Name: observationconstellation obsconstobspropfk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY observationconstellation
    ADD CONSTRAINT obsconstobspropfk FOREIGN KEY (observablepropertyid) REFERENCES observableproperty(observablepropertyid);


--
-- Name: observationconstellation obsconstofferingfk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY observationconstellation
    ADD CONSTRAINT obsconstofferingfk FOREIGN KEY (offeringid) REFERENCES offering(offeringid);


--
-- Name: compositephenomenon observablepropertychildfk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY compositephenomenon
    ADD CONSTRAINT observablepropertychildfk FOREIGN KEY (childobservablepropertyid) REFERENCES observableproperty(observablepropertyid);


--
-- Name: compositephenomenon observablepropertyparentfk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY compositephenomenon
    ADD CONSTRAINT observablepropertyparentfk FOREIGN KEY (parentobservablepropertyid) REFERENCES observableproperty(observablepropertyid);


--
-- Name: blobvalue observationblobvaluefk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY blobvalue
    ADD CONSTRAINT observationblobvaluefk FOREIGN KEY (observationid) REFERENCES observation(observationid);


--
-- Name: featurerelation parentfeatureid; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY featurerelation
    ADD CONSTRAINT parentfeatureid FOREIGN KEY (parentfeatureid) REFERENCES featureofinterest(featureofinterestid);


--
-- Name: hasfeatures user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY hasfeatures
    ADD CONSTRAINT user_id FOREIGN KEY (user_id) REFERENCES users(user_id);


--
-- Name: featureofinterest userid; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY featureofinterest
    ADD CONSTRAINT userid FOREIGN KEY (userid) REFERENCES users(user_id);


--
-- Name: notifications useridfk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY notifications
    ADD CONSTRAINT useridfk FOREIGN KEY (userid) REFERENCES users(user_id);


--
-- PostgreSQL database dump complete
--

