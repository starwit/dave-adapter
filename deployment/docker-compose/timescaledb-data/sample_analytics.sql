--
-- PostgreSQL database dump
--


SET timezone = 'UTC';
SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: timescaledb; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS timescaledb WITH SCHEMA public;


--
-- Name: EXTENSION timescaledb; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION timescaledb IS 'Enables scalable inserts and complex queries for time-series data';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: linecrossing; Type: TABLE; Schema: public; Owner: analytics
--

CREATE TABLE public.linecrossing (
    object_id character varying(255),
    direction character varying(255),
    crossing_time timestamp with time zone NOT NULL,
    object_class_id bigint,
    metadata_id bigint
);


ALTER TABLE public.linecrossing OWNER TO analytics;

--
-- Name: coordinate_id_seq; Type: SEQUENCE; Schema: public; Owner: analytics
--

CREATE SEQUENCE public.coordinate_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.coordinate_id_seq OWNER TO analytics;

--
-- Name: coordinate; Type: TABLE; Schema: public; Owner: analytics
--

CREATE TABLE public.coordinate (
    id bigint DEFAULT nextval('public.coordinate_id_seq'::regclass) NOT NULL,
    latitude numeric(22,19),
    longitude numeric(22,19),
    metadata_id bigint
);


ALTER TABLE public.coordinate OWNER TO analytics;

--
-- Name: flyway_schema_history; Type: TABLE; Schema: public; Owner: analytics
--

CREATE TABLE public.flyway_schema_history (
    installed_rank integer NOT NULL,
    version character varying(50),
    description character varying(200) NOT NULL,
    type character varying(20) NOT NULL,
    script character varying(1000) NOT NULL,
    checksum integer,
    installed_by character varying(100) NOT NULL,
    installed_on timestamp without time zone DEFAULT now() NOT NULL,
    execution_time integer NOT NULL,
    success boolean NOT NULL
);


ALTER TABLE public.flyway_schema_history OWNER TO analytics;

--
-- Name: flyway_schema_history_timescale; Type: TABLE; Schema: public; Owner: analytics
--

CREATE TABLE public.flyway_schema_history_timescale (
    installed_rank integer NOT NULL,
    version character varying(50),
    description character varying(200) NOT NULL,
    type character varying(20) NOT NULL,
    script character varying(1000) NOT NULL,
    checksum integer,
    installed_by character varying(100) NOT NULL,
    installed_on timestamp without time zone DEFAULT now() NOT NULL,
    execution_time integer NOT NULL,
    success boolean NOT NULL
);


ALTER TABLE public.flyway_schema_history_timescale OWNER TO analytics;

--
-- Name: metadata_id_seq; Type: SEQUENCE; Schema: public; Owner: analytics
--

CREATE SEQUENCE public.metadata_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.metadata_id_seq OWNER TO analytics;

--
-- Name: metadata; Type: TABLE; Schema: public; Owner: analytics
--

CREATE TABLE public.metadata (
    id bigint DEFAULT nextval('public.metadata_id_seq'::regclass) NOT NULL,
    name character varying(255) NOT NULL,
    classification character varying(255),
    geo_referenced boolean,
    center_longitude numeric(22,19),
    center_latitude numeric(22,19),
    observation_area_id bigint,
    direction character varying(255) DEFAULT NULL::character varying
);


ALTER TABLE public.metadata OWNER TO analytics;

--
-- Name: objectclass; Type: TABLE; Schema: public; Owner: analytics
--

CREATE TABLE public.objectclass (
    name character varying(255),
    class_id integer NOT NULL
);


ALTER TABLE public.objectclass OWNER TO analytics;

CREATE TABLE public.areaoccupancy
(
    occupancy_time timestamp with time zone NOT NULL,
    count integer NOT NULL,
    object_class_id bigint,
    metadata_id bigint
);

ALTER TABLE public.areaoccupancy OWNER to analytics;


INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('08271f81464d3b63b14205b466a3d4b7', 'in', '2026-09-15 16:00:19.219', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('43d702154d0139d9bb28c706513be049', 'in', '2026-09-15 16:00:28.73', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('43d702154d0139d9bb28c706513be049', 'out', '2026-09-15 16:00:33.936', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('70a4ffe8bade3cb5a3f0dbaebff886d4', 'out', '2026-09-15 16:00:34.092', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('43d702154d0139d9bb28c706513be049', 'in', '2026-09-15 16:00:39.242', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('d484be13ae51378a9685e5dcb37ff9e0', 'out', '2026-09-15 16:00:40.5', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('d484be13ae51378a9685e5dcb37ff9e0', 'in', '2026-09-15 16:00:47.309', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('d484be13ae51378a9685e5dcb37ff9e0', 'out', '2026-09-15 16:01:15.143', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('d7c6baf8e09c3fac9dc890d833100953', 'out', '2026-09-15 16:01:23.652', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('7f3e742329f833e28474417299abf2fd', 'in', '2026-09-15 16:01:44.726', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('82f52eac6f7031dea25392c60729f213', 'out', '2026-09-15 16:01:50.386', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('415e74c6b4bf3d26a82be06597fe5311', 'out', '2026-09-15 16:02:19.22', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('aa5f5e7e3c303ffbbb44616a9108df68', 'out', '2026-09-15 16:02:28.933', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('092e8fd5c4f135f4817a580894c5a32f', 'in', '2026-09-15 16:02:37.293', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('5c1f9b82fc1c3919ae6f862b41d1dafc', 'out', '2026-09-15 16:02:41.748', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('c354a5b5cf413193b645e8d296001369', 'out', '2026-09-15 16:02:58.77', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('8768ca26cea93aa582d6a53e95b4fdf0', 'in', '2026-09-15 16:03:53.592', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('338de9cd90bb33c39df30b774af67991', 'out', '2026-09-15 16:04:11.357', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('23638aeb40cb3e8984d9aade71cc5104', 'in', '2026-09-15 16:04:14.817', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('338de9cd90bb33c39df30b774af67991', 'in', '2026-09-15 16:04:17.265', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('fe652074c5cf395a8570c7e5867f7e2b', 'in', '2026-09-15 16:05:03.277', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('77d0e937be9b3b9ba97ed740735b322c', 'out', '2026-09-15 16:05:26.459', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('a18f26e0eb043a79aba06f5c7d1c35fa', 'out', '2026-09-15 16:05:51.689', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('ff75fff0094f3bd593993945224865e2', 'in', '2026-09-15 16:06:59.727', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('d202c236913b38b2afd25f4f8b161e2b', 'out', '2026-09-15 16:07:22.304', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('31d2f8e8e79c39fb9e64d2824cbd8cd7', 'in', '2026-09-15 16:07:35.621', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('31d2f8e8e79c39fb9e64d2824cbd8cd7', 'out', '2026-09-15 16:07:49.34', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('71635593c23b3d868d06fdd7d45913b9', 'in', '2026-09-15 16:08:51.264', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('6e5ac5dc363b3bb790fa5de143f30348', 'out', '2026-09-15 16:09:09.34', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('2efdabfb2fb93f5283fce8a948ccd99e', 'out', '2026-09-15 16:10:03.208', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('54d81cae9ca03b55a08aeb1fbe503002', 'in', '2026-09-15 16:11:21.051', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('47e2820689963b4bb029432fae132b03', 'in', '2026-09-15 16:11:48.285', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('67b3e0d777ee3ccc88f94ab403e1c1ec', 'out', '2026-09-15 16:11:57.249', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('2081e42aeb3e3c979105ee5d9dea2234', 'in', '2026-09-15 16:12:18.22', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('77121e28471d38c897b1812234c44ea0', 'out', '2026-09-15 16:12:36.798', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('3a013cbd15603074847c9e011314618a', 'in', '2026-09-15 16:13:01.978', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('fac2eb0f61dc353692ddc72f8091f606', 'out', '2026-09-15 16:13:07.436', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('a178b2c211713ea8bc330e2d3ae59623', 'in', '2026-09-15 16:13:40.026', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('e6446cfb6cf533dca693cae17e1d703d', 'in', '2026-09-15 16:14:42.704', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('d6e596c0b2703f8e94faa187132aa8fd', 'out', '2026-09-15 16:14:49.564', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('aa04d25f37e83a4fb975d17732b2fbed', 'out', '2026-09-15 16:15:28.915', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('db083acf4a5a37b18a13ef44fa0732ca', 'in', '2026-09-15 16:16:10.714', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('4d5e08ecc31d3706a1ff3c6bba65f3c5', 'out', '2026-09-15 16:16:30.094', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('c431413c8905314e822acd94e1be0509', 'in', '2026-09-15 16:16:30.839', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('2a5a3113defd3648a293c80fbb2342d3', 'out', '2026-09-15 16:16:58.23', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('fed20b356b263e8ba68d67240554b113', 'in', '2026-09-15 16:18:04.461', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('c980837474ee3b73a5e723050be83cd3', 'out', '2026-09-15 16:18:42.062', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('0517a055f38d3eba963e6b5fb26bea0c', 'out', '2026-09-15 16:18:46.467', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('0fc7fdf0bb253aca86c49c57e71feba4', 'out', '2026-09-15 16:18:50.675', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('e85e8bc6158a34c48751811f6f263f98', 'out', '2026-09-15 16:18:57.284', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('1e0643e8f43932ee947343ac0ee6790d', 'in', '2026-09-15 16:19:00.929', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('87be877ab5c632238e7f30f9d464b331', 'out', '2026-09-15 16:19:31.726', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('064736631534365a8bc2e6d662da911e', 'out', '2026-09-15 16:19:46.545', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('87870923e0993380be1d13c1d4932fea', 'in', '2026-09-15 16:19:49.192', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('ae3fd3be3bf03d77997725fd515be7fc', 'in', '2026-09-15 16:19:56.959', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('87870923e0993380be1d13c1d4932fea', 'out', '2026-09-15 16:19:57.102', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('3f3b6106a4d33496a845857946dd8569', 'out', '2026-09-15 16:20:07.574', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('99914090be9030d89b47f127bd8f0566', 'out', '2026-09-15 16:20:29.403', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('66dcbd298f083871b5a309079f826898', 'in', '2026-09-15 16:20:31.245', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('9c5650ecc4683cbd92f438225341f881', 'in', '2026-09-15 16:21:06.59', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('f69afc1e777438fa9a57c3a653459e43', 'in', '2026-09-15 16:21:55.753', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('bff3016b3a053780961e4cfd250671f1', 'out', '2026-09-15 16:22:19.345', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('86a8603f1ec230dca59df2e84f31b07e', 'in', '2026-09-15 16:24:51.575', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('b48bd3f5e3453d4da463045e9e7551e2', 'out', '2026-09-15 16:25:01.146', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('e6446cfb6cf533dca693cae17e1d703d', 'out', '2026-09-15 16:25:12.303', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('0db4df58c4043b9a8f8e201dc9746964', 'in', '2026-09-15 16:25:39.236', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('1c6d1bc183093334a53fbe8c579eeae3', 'in', '2026-09-15 16:26:14.981', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('1c6d1bc183093334a53fbe8c579eeae3', 'out', '2026-09-15 16:26:16.081', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('b371dedbd94c3bf98db40ed9301f58a3', 'out', '2026-09-15 16:27:30.536', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('a35aaef1f0833f61b3c0ac1222373e53', 'in', '2026-09-15 16:27:44.254', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('14193ae9bf423c88bbe9a771b7ce3586', 'in', '2026-09-15 16:27:54.105', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('a1960cc339773830a69b922aeb2fd275', 'out', '2026-09-15 16:28:31.715', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('b567505af2a03917aa9cacf5899236bc', 'in', '2026-09-15 16:28:44.674', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('5e200380b3ed3c5dbf9fa38c570aee41', 'out', '2026-09-15 16:29:34.494', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('bb372d8664c53b74b80a4f00a1348cf0', 'out', '2026-09-15 16:29:39.699', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('e4b5cf2e6d223c2fbbbf88d1e7a147b4', 'in', '2026-09-15 16:29:46.557', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('aa4bb8a404b8364f80d3236256233a6d', 'out', '2026-09-15 16:29:47.909', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('4f643ede918a3b9d97e4edb5ca0adb2a', 'in', '2026-09-15 16:29:51.864', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('40a946b041a23cf184cfdc2b104633bf', 'out', '2026-09-15 16:30:04.131', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('746363e6c6e137f4a3aa1786a29a918e', 'in', '2026-09-15 16:31:26.485', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('ce60c4fc5f4933668a96cb2bcc493bfb', 'out', '2026-09-15 16:31:33.442', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('f665a18924af359fba241ed584d0cc8a', 'in', '2026-09-15 16:31:55.02', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('4c02099cc1bb30a1a1194dc2cd25f68c', 'out', '2026-09-15 16:33:07.514', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('85ed2c7273b1319f9d9e3410a2b4833d', 'in', '2026-09-15 16:33:56.878', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('0225182b842f361a8129e9de0cc13298', 'in', '2026-09-15 16:34:16.504', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('fb47faaf6005323b8d7af4473ecedb4c', 'out', '2026-09-15 16:34:18.051', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('8cc251f124d13b878500c8790a33b5d2', 'out', '2026-09-15 16:34:39.078', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('26ab70b1168b37caa497f693da5eec1b', 'out', '2026-09-15 16:34:39.134', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('1c161f478fde3ee5a5c03010a5e40c30', 'in', '2026-09-15 16:35:04.165', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('f48ec90741b433e88df859eb615e3a49', 'in', '2026-09-15 16:35:33.302', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('37246e199e0d3dd6b18c1db2a5f67a89', 'in', '2026-09-15 16:36:16.959', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('8784cd76bae43ef49a477a978389d028', 'out', '2026-09-15 16:36:48.545', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('c07e4fb4fd363defa5f90d9bdde1ca42', 'in', '2026-09-15 16:36:59.514', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('ddc76c2bdba432bc83859763afbc6483', 'in', '2026-09-15 16:37:22.542', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('43d4c3fb279738569b086072ac9a36d7', 'in', '2026-09-15 16:37:54.882', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('c6ce3ad2a3bb3ac3afe91ea68eaf7cf0', 'in', '2026-09-15 16:38:02.195', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('5bd93a179a9139eba820982fb1e45e8e', 'out', '2026-09-15 16:38:41.789', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('984e12a9da9c382eb7a7acf9a0fdc612', 'in', '2026-09-15 16:39:33.112', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('62a94fbe5627311f977218a918d827f1', 'out', '2026-09-15 16:39:56.686', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('25d772b72ebb3d01b6ba2915e7a11214', 'in', '2026-09-15 16:40:46.607', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('066fa160afa737a798611ca75ef4b7f2', 'in', '2026-09-15 16:40:53.259', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('066fa160afa737a798611ca75ef4b7f2', 'out', '2026-09-15 16:41:00.669', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('6e03b2b1d1e43e63b11764adca086786', 'out', '2026-09-15 16:41:08.177', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('a0e5a85ebb9f3de2936f1806a8cc3ece', 'in', '2026-09-15 16:41:22.195', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('b9b12b1750db33acbfec8a85b875c7b5', 'in', '2026-09-15 16:41:35.365', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('a0172a4b123d33d9953f8b82fd6b5f7d', 'in', '2026-09-15 16:42:11.91', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('ae3fd3be3bf03d77997725fd515be7fc', 'out', '2026-09-15 16:43:17.14', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('23b8d5ba8fce3174acfb5c97ee9fc01c', 'out', '2026-09-15 16:43:24.149', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('23b8d5ba8fce3174acfb5c97ee9fc01c', 'in', '2026-09-15 16:43:28.754', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('d5145d58cdde3c91872de6980e84e294', 'out', '2026-09-15 16:43:36.063', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('f3e52136841f3be5a908c1e8d9b09608', 'out', '2026-09-15 16:43:54.886', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('040d92593e3e3934b8ab4096c854a1d3', 'in', '2026-09-15 16:44:53.819', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('14193ae9bf423c88bbe9a771b7ce3586', 'out', '2026-09-15 16:45:06.936', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('03735cca7df93a478a3b6dedb7ebc459', 'out', '2026-09-15 16:45:09.683', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('c7b8a5174583354c86fff2e41a8f9bad', 'out', '2026-09-15 16:45:14.289', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('98dbb278858330d08fef868240da307d', 'out', '2026-09-15 16:45:38.017', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('7792615a59773d0582930ebb81d7d6a7', 'out', '2026-09-15 16:46:39.896', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('abf3a135be9533cc8f79b0214ea5ad61', 'in', '2026-09-15 16:47:47.943', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('9757cdcc17c833a49d4634b1ad5b054f', 'in', '2026-09-15 16:47:55.254', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('a278ccd9f19531c19e03cf799536912b', 'out', '2026-09-15 16:48:13.925', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('cbe15d9055963935bd98285090851b89', 'out', '2026-09-15 16:48:56.931', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('2cb4424a155234fe877a19727606d98c', 'out', '2026-09-15 16:49:38.237', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('657eae93769935069f7cc5bb1e90a6fb', 'in', '2026-09-15 16:52:15.583', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('18800bc400bd3871b2845efdef2c88db', 'out', '2026-09-15 16:55:02.654', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('1acb8ccca41d3c56bc86fea0ab6446ee', 'in', '2026-09-15 16:57:03.849', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('e6d87b8c896c3d528f2f992757ae5ff5', 'in', '2026-09-15 16:58:02.219', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('39207a24949c32b8842a2992de2fa361', 'out', '2026-09-15 16:58:35.824', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('f60f8ab09b2534219d7371abe0a7ec6b', 'in', '2026-09-15 16:59:16.617', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('9e374b032c6a3ad1a42fc457fa0b07bc', 'out', '2026-09-15 16:59:36.709', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('a9bee4698ef138b2a30979fad05c2a70', 'out', '2026-09-15 16:59:45.62', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('11a9983f93d333a183bb99107665747d', 'in', '2026-09-15 17:00:01.774', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('1da8c179ccef39ecb262e0259f6757be', 'in', '2026-09-15 17:00:58.951', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('ebe3ddfe3cbb32778a0892375c6c664f', 'in', '2026-09-15 17:01:19.777', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('17345bc3e962343c8c0c0917cae5beac', 'out', '2026-09-15 17:01:23.849', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('2920134219753758aed04ad375aeaa39', 'out', '2026-09-15 17:01:40.971', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('9b66b566c39b3d1ebd3c37d4d46e7798', 'in', '2026-09-15 17:02:38.578', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('52d2750ca118393b8f1e40b0db26cdea', 'in', '2026-09-15 17:02:42.586', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('f8e20b3cdbb23b6584f47e5088e4dc5b', 'in', '2026-09-15 17:02:45.59', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('c0156dbc92ea366c82f8c872fca5f4ac', 'out', '2026-09-15 17:03:03.476', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('a78ee613b3183581b19d1fb762fd2870', 'out', '2026-09-15 17:03:21.101', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('f2f65340a1b13e0d841c40a4b65fa582', 'out', '2026-09-15 17:04:02.253', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('092e8fd5c4f135f4817a580894c5a32f', 'out', '2026-09-15 17:04:07.791', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('06604440fa6f38b9a9629433728939e8', 'in', '2026-09-15 17:04:19.406', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('0293a8a641bb3712b7c7e795191defd5', 'in', '2026-09-15 17:04:55.85', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('8a63e5f6035237feba641f3c77ba4787', 'out', '2026-09-15 17:04:57.322', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('0df246983f313abb8dc88600cce2fae6', 'in', '2026-09-15 17:05:19.38', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('59f2a2fddd41398fa6326a104559dd71', 'out', '2026-09-15 17:05:48.591', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('9713b57241fa35909c92b340b85d6a8a', 'in', '2026-09-15 17:05:49.818', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('bf7e5a41084b34ce8e7fd788ad6e5048', 'out', '2026-09-15 17:06:15.125', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('8b4d2b9af57b302fbe38b47b266e5af2', 'out', '2026-09-15 17:06:43.861', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('590ca6254af43672af52e9aa3950050a', 'in', '2026-09-15 17:06:58.606', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('5b122721ef17346caeb83f2af1d288f5', 'out', '2026-09-15 17:07:28.521', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('338de9cd90bb33c39df30b774af67991', 'out', '2026-09-15 17:07:33.826', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('198b58aeaf5c340fa68fa5c3b1cfcee5', 'out', '2026-09-15 17:07:52.45', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('a52bb2280bbf3cb4a02569839de5ece3', 'in', '2026-09-15 17:08:12.978', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('4f643ede918a3b9d97e4edb5ca0adb2a', 'out', '2026-09-15 17:08:20.511', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('131679766b883ea1adc1d59531218863', 'in', '2026-09-15 17:09:50.622', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('6f7df01a0d4e3e21ba19cfb25d38ab22', 'in', '2026-09-15 17:10:09.746', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('c481a975690d340db4b62395bf577c14', 'out', '2026-09-15 17:10:20.261', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('3ed24bef81b43822ab1bcf2046b2d0cf', 'in', '2026-09-15 17:10:49.215', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('eb6c20f9853e3c028bb52c60694e15a6', 'out', '2026-09-15 17:11:00.696', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('c9235bc0e83a34a2a29cdba6ba4a48a1', 'out', '2026-09-15 17:11:12.909', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('28001362673d3adaaae38aee36b6956f', 'out', '2026-09-15 17:13:10.361', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('d047ec694d5e320e8f1d9dcb817dad06', 'out', '2026-09-15 17:13:37.997', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('23b8d5ba8fce3174acfb5c97ee9fc01c', 'out', '2026-09-15 17:14:03.129', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('306512b9c8ea39e5817951871b1c4bb8', 'in', '2026-09-15 17:14:08.205', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('e5cfbb60fb1b311caff9dbb7b475e021', 'out', '2026-09-15 17:14:29.461', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('e5cfbb60fb1b311caff9dbb7b475e021', 'in', '2026-09-15 17:14:45.681', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('3df27dbd26473f46899b52c88eee836e', 'in', '2026-09-15 17:14:55.064', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('c01da8e5fb613d2b85f54a38d4ec9fd0', 'out', '2026-09-15 17:15:02.303', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('b643687230743175a20ced7f6a1f0901', 'in', '2026-09-15 17:15:06.78', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('bc486a05a4fc3dd380786f5f480ac8a0', 'in', '2026-09-15 17:15:53.341', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('4fe23063a4b43bf580c12116f1293278', 'in', '2026-09-15 17:16:03.454', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('b5f64c13b32a3d45ac5e3ed80a449565', 'out', '2026-09-15 17:16:25.209', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('2b127dfc5e423d8abe7f90f495cdbc33', 'out', '2026-09-15 17:16:38.728', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('93d3f83c93e331a2b8dfbed280564468', 'in', '2026-09-15 17:17:06.136', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('13c9b501548035c39a28ba1299767e9e', 'in', '2026-09-15 17:17:38.28', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('c57ff3f5f9843a0498286a501f47eab2', 'out', '2026-09-15 17:17:59.132', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('f0954b5285a93479b53d52e5db2c770f', 'out', '2026-09-15 17:18:03.938', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('6077cb313a5c32cbbfcff1189b2b7a15', 'in', '2026-09-15 17:18:53.876', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('cc0d53774e9038d9995f44f89fe9c282', 'out', '2026-09-15 17:19:19.534', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('b140c4b1d2853c0784141df190834146', 'out', '2026-09-15 17:19:24.54', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('c39bb587cc7538739b9d63a656f26875', 'in', '2026-09-15 17:20:29.096', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('5035274d2e093381946e0921335c3478', 'in', '2026-09-15 17:20:34.202', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('b1c49c2e974a3dd093cde6c89c03a4ae', 'in', '2026-09-15 17:20:47.421', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('82f93c7d699a3d5c95b7dae720f7ef7e', 'out', '2026-09-15 17:21:21.288', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('5f4e2d4585b534a2bb939e8dde20310c', 'in', '2026-09-15 17:22:20.74', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('82c7427db2c539d99cb00f1781dddd36', 'in', '2026-09-15 17:24:34.91', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('dc361d3435193ce5912dc941acd9a2dc', 'in', '2026-09-15 17:26:38.172', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('4c94105b9d1436459d3eb02b84ba5a77', 'out', '2026-09-15 17:26:57.828', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('5dd82f295f033d44b04641257370b07b', 'in', '2026-09-15 17:28:01.279', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('0e656b050d06304095a4a6fda109d095', 'out', '2026-09-15 17:28:40.661', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('54a88015b81a3473b7328f3ab6c67cc3', 'in', '2026-09-15 17:29:21.984', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('eadb664cf6863bd6aa4bd383bd089ba3', 'in', '2026-09-15 17:29:36.303', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('5ab31bcdd79f3d7392c5b4fe54cec65b', 'out', '2026-09-15 17:30:17.386', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('c92d41b08ca23600b2ec91f7edfb2ea2', 'in', '2026-09-15 17:30:24.462', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('4155c7e40e0a36978f921429bf962c85', 'out', '2026-09-15 17:30:37.813', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('60142f10fad032d4bdd0a674415d29f6', 'in', '2026-09-15 17:30:46.89', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('70686b14d72336b78d07a91d99a936fd', 'out', '2026-09-15 17:31:04.747', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('48624fe21c763897a2da8ce062c00d9a', 'in', '2026-09-15 17:31:22.336', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('37eca5f1fe8b3c51b586fde1193406b1', 'out', '2026-09-15 17:31:25.175', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('29a48a7a34aa31c39247bceb56935db9', 'in', '2026-09-15 17:32:47.545', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('cb0a5cac6d3a30d8be8e38a8973df052', 'in', '2026-09-15 17:33:02.763', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('3c8870c720e33d639273fa8b6851d525', 'out', '2026-09-15 17:33:48.259', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('8f044323be663118a43fc8ce10e92459', 'in', '2026-09-15 17:34:14.155', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('d274248565973d07a8b59986c2d55baa', 'out', '2026-09-15 17:34:38.923', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('164d41f685b83903b2e8540e76b50a6c', 'in', '2026-09-15 17:35:14.831', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('7c779ea0348f3c2c8825c4fd4bdf283a', 'out', '2026-09-15 17:36:01.132', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('17d98528a1303740a9e59640ed8223c6', 'in', '2026-09-15 17:37:34.009', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('9feb43270fd334e980f0aec034581f8e', 'out', '2026-09-15 17:37:57.278', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('ffb14966f3ba375aaed06379c594f270', 'out', '2026-09-15 17:39:01.96', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('26ed73bc9a163eb6bdb1b661628698f7', 'in', '2026-09-15 17:39:07.228', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('e5cfbb60fb1b311caff9dbb7b475e021', 'out', '2026-09-15 17:39:32.497', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('e4d101cfc252309593265e17eb6157cb', 'in', '2026-09-15 17:40:02', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('bf5fbb219d913c6398638f8a7887fd16', 'in', '2026-09-15 17:40:06.504', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('0b5f1a897a4a318fb4d621c72145ef3a', 'in', '2026-09-15 17:40:24.427', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('b46442734c8e3e9395516a7f36d88478', 'out', '2026-09-15 17:40:55.808', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('f3beab41b00c33398d053a2f9a4725b1', 'in', '2026-09-15 17:41:32.114', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('a52bb2280bbf3cb4a02569839de5ece3', 'out', '2026-09-15 17:41:35.456', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('ce01264a4b2135ad929a9c31b2e633e2', 'in', '2026-09-15 17:41:44.928', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('b98d1aabb3333e1c99029b662b71bf6e', 'out', '2026-09-15 17:41:56.585', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('5a8e5621f13c35f4972f744163b33d29', 'in', '2026-09-15 17:42:03.651', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('0a1a0cff8aee3e639a27bf2548ffac1c', 'out', '2026-09-15 17:42:32.53', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('db36a74119f2353197ca64f1f83be281', 'in', '2026-09-15 17:42:52.215', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('4a1f0cc0cf8030bdbb701cbfce8468e6', 'in', '2026-09-15 17:43:12.239', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('8aff895177363f05955182350d1a9ccc', 'in', '2026-09-15 17:43:16.946', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('ef33a53f4d413e3dbed8b79bc1c1f6fe', 'out', '2026-09-15 17:43:43.022', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('c9c7fc341caf3682b3d41f3cab11ff55', 'out', '2026-09-15 17:43:46.827', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('ab2de296cb67391b87f7519b517c9081', 'in', '2026-09-15 17:44:35.144', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('77a34453485a3360bc192985a9b15314', 'in', '2026-09-15 17:45:06.986', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('1b3fec99b80d310a8892f5b0d7b24558', 'out', '2026-09-15 17:45:18.15', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('0ad24882aef039c8a96e8d904ef18026', 'out', '2026-09-15 17:45:25.459', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('0ff7e249d9e535fab3a27d0f75c7ac1d', 'in', '2026-09-15 17:45:35.524', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('d7a5a9884b5131aab92a166d555856d0', 'out', '2026-09-15 17:45:47.587', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('50c267ecc4ef3cc7a9b7da6395f1f73c', 'out', '2026-09-15 17:46:52.167', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('4a58e33709df3ddead92e7a6b71df2c4', 'in', '2026-09-15 17:46:54.826', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('551a91fb0f75371384ee3b1069a343b0', 'out', '2026-09-15 17:47:03.581', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('14d29135b7703833885850eca0cc8de5', 'in', '2026-09-15 17:47:30.57', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('b1fa9f10588232c3bd5dc1a55246a69b', 'out', '2026-09-15 17:47:34.021', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('c41eace095003304b178866ff4988e70', 'out', '2026-09-15 17:47:40.73', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('83a0bca29fb532dd94cd69f726928c41', 'out', '2026-09-15 17:47:49.641', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('c3af88507c95320eba80c8b9eaa3819b', 'out', '2026-09-15 17:47:55.548', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('a13e4e29c11e3ed88d680fd7933bedd7', 'in', '2026-09-15 17:48:15.332', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('8ae1c32a3d8c35428bc297ee88bcd98c', 'out', '2026-09-15 17:49:37.279', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('4b3a3cedcdef338a8fb400150ee29128', 'out', '2026-09-15 17:49:40.082', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('7e53ff454acd3ff8bee69d355c11a1b5', 'out', '2026-09-15 17:50:53.378', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('c757dfb35bd3330e832f5bf185f5e9d7', 'out', '2026-09-15 17:51:22.969', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('5911c3e62a373ad3b6f43dc711cc0c14', 'in', '2026-09-15 17:52:24.844', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('5911c3e62a373ad3b6f43dc711cc0c14', 'out', '2026-09-15 17:52:29.35', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('693480609fec37b8990ebb7dc0df2dae', 'out', '2026-09-15 17:53:20.565', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('dd171864a96e35d9b11b74dce6518394', 'in', '2026-09-15 17:54:04.974', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('fb260bfc570b3013a8713b21d96703af', 'in', '2026-09-15 17:54:08.778', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('938dd3bca14a3cddb992abd10486ccc2', 'in', '2026-09-15 17:54:48.153', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('5d41397bc6db30d89d2e7a9376855703', 'out', '2026-09-15 17:55:03.495', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('52ad8310858f3d9d88179ffe3097168e', 'in', '2026-09-15 17:55:07.778', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('ecaa25def9223bc68450f7e3ae5790b4', 'out', '2026-09-15 17:55:08.103', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('d3b0de70a6fe3178aa5a9fc9ef8f1dad', 'in', '2026-09-15 17:55:13.888', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('b3ffa8b2817a3a6f9836f90e4532cc47', 'in', '2026-09-15 17:55:19.796', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('ebe590330a033c9b9ed19d5919b1dd47', 'in', '2026-09-15 17:55:30.51', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('67ab42018ab837c29dc55b45a284dd3a', 'out', '2026-09-15 17:55:34.135', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('f365ed6d5822343197917504d0ec6f5d', 'in', '2026-09-15 17:56:16.367', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('96ac00dbfe3334cbab8a508afeaa84eb', 'out', '2026-09-15 17:56:18.293', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('a2a8cfc3ffc03330b3476770ba122e9b', 'in', '2026-09-15 17:57:37.474', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('1cbf4ee041b03de89e69c162abaa00f9', 'in', '2026-09-15 17:59:29.919', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('fac7f6f1822038559bf498a5a78e568b', 'in', '2026-09-15 17:59:36.928', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('d3da8e21b1c43141980ca9cc354edb55', 'out', '2026-09-15 18:03:16.116', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('acd60faac61a30bd85cc87c52bd6a38e', 'in', '2026-09-15 18:04:16.185', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('1a10a157bc5f338b817b01bcc5226413', 'in', '2026-09-15 18:04:56.638', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('a7421c138d9e3f1eb5705a6c39235af6', 'in', '2026-09-15 18:05:02.042', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('1d156f1878943d0c83b46c9e77ef199e', 'out', '2026-09-15 18:05:24.78', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('71f58471944f3c7194e1788c7d6b64b9', 'out', '2026-09-15 18:05:31.288', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('7fae388df93d31ea88dfd6b64313e079', 'in', '2026-09-15 18:06:48.778', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('fbba3a90d627335d913bd9cb6faa3be1', 'in', '2026-09-15 18:07:33.134', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('1a027a00783e3040989522c6879e9b6d', 'out', '2026-09-15 18:07:37.549', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('2a9453f034f93b0a9699127a73abd029', 'in', '2026-09-15 18:08:19.694', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('a0f132dd99bd3ea89bcfdd98e5971bbc', 'in', '2026-09-15 18:08:37.015', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('b5db17fff5c632fe8bcc59a854cba10c', 'out', '2026-09-15 18:10:35.773', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('4be1d5b2753d3e0cbacedad6de474c46', 'out', '2026-09-15 18:11:58.475', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('3c7a56f0adc738439e8aed855f34b6ad', 'in', '2026-09-15 18:12:44.722', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('aad0d00c86d03ff0936063560ab8389a', 'in', '2026-09-15 18:13:46.298', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('b90089f5f92339dbaaa03a5e80f2a10c', 'in', '2026-09-15 18:13:56.311', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('00f0006d9e10376ba33574353d9f7321', 'in', '2026-09-15 18:14:02.117', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('fe2dff46787830dea27f1e16e624429d', 'out', '2026-09-15 18:14:15.445', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('59c9aeb725633fe289ae585a54b1c588', 'in', '2026-09-15 18:14:49.381', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('dbb53f7dcae336aa8afe1248bd8be2fe', 'out', '2026-09-15 18:15:00.601', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('175ac7a48b3c32f69a3b9d3592df3b8b', 'in', '2026-09-15 18:15:16.215', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('2e24e531144e362b805f60751cf25a57', 'out', '2026-09-15 18:15:18.623', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('25c509c4582535da98e5e54d4a794fb2', 'out', '2026-09-15 18:15:27.736', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('7707d3eb0485395b804e95cb5a8b7ea8', 'in', '2026-09-15 18:15:50.958', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('733c7e41e26837bb9f9c357ac5161703', 'in', '2026-09-15 18:17:36.791', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('9216e06884b1316b9f030dc943445a49', 'out', '2026-09-15 18:17:38.502', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('3f879c855acb3b9286135f92c92c7cbe', 'out', '2026-09-15 18:17:56.028', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('1518ccff08a43042ad6d1fe1e7e1a121', 'in', '2026-09-15 18:20:11.388', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('4ef2751585273c33b63ff3429fd09452', 'in', '2026-09-15 18:20:18.596', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('ff67c07bcf0130fc8cb0122f8cb226fc', 'in', '2026-09-15 18:20:29.11', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('af2e397265913b8fb97451458eb0d2be', 'in', '2026-09-15 18:20:45.429', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('d0d27775b2d138959d55d6e4d5c1b015', 'out', '2026-09-15 18:21:55.027', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('ab1bcbf45c4537ec9adc9f455779a2bd', 'out', '2026-09-15 18:21:58.431', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('ae4e2057e9e9387a8d5530f096da3f7b', 'out', '2026-09-15 18:23:01.814', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('12151dfb12533a5784c3cbc264054762', 'out', '2026-09-15 18:23:06.219', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('dadbfa0cbf00345cb791680b6237f690', 'out', '2026-09-15 18:23:16.032', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('ce74a520352b3e92b3b30269de911baa', 'out', '2026-09-15 18:23:36.758', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('25a03ae0ce0e39c989ee12fa7c68e7a9', 'in', '2026-09-15 18:23:52.376', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('73f34334a441353fa8ca54f0d1bb3a79', 'out', '2026-09-15 18:24:20.513', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('ad29cb071f7232599ff6aa725f77c153', 'in', '2026-09-15 18:24:33.03', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('bfe732af11e43780bd33f8eb0ad170a6', 'in', '2026-09-15 18:25:36.205', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('cafb641e6dbd3ca094dfc7b276ed57f5', 'out', '2026-09-15 18:25:44.219', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('20dc568487b138849cd293e76e1d8819', 'out', '2026-09-15 18:26:02.241', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('606f3fae43583c249469fc83f03021c4', 'in', '2026-09-15 18:26:17.155', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('e6436ec340a733228a052c6f0ba39f72', 'out', '2026-09-15 18:26:45.694', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('91a857650220371b85f2aee821ce8ff7', 'in', '2026-09-15 18:29:50.435', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('61fe1e18a37832b1874131eb85c3fac1', 'in', '2026-09-15 18:30:52.918', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('fc1ca2c840783a958c165d00a817db48', 'out', '2026-09-15 18:31:21.347', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('c6b6d8969f033bbb9dc3cd3f49001baf', 'out', '2026-09-15 18:31:26.151', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('a6b4783c6a7d333f90042ba3fbeb710a', 'in', '2026-09-15 18:32:51.965', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('75894daacd9430e484023f67703dd871', 'out', '2026-09-15 18:32:52.263', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('64f1bf278ba8365ab4dd3094924075ed', 'out', '2026-09-15 18:33:20.7', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('d60e20eb09643e61a41f0ec391e2ea54', 'in', '2026-09-15 18:33:40.031', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('17fdfeb5c19a33b793911aa50653ea89', 'out', '2026-09-15 18:33:47.936', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('e74b6a9c08443ca5a06ac0c5f3509084', 'out', '2026-09-15 18:36:51.866', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('832ac74a02263ec2b853d2d0fe6b288c', 'in', '2026-09-15 18:36:58.898', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('471cfda8f0a338589320b0b1df1c3e30', 'out', '2026-09-15 18:37:10.388', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('0c9c1cf479043a2e982c4da801d31a5a', 'out', '2026-09-15 18:37:18.899', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('162c7a3293f43506968c5ae59505454e', 'out', '2026-09-15 18:37:58.948', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('bdedf1b3c7bd373f85e2b00ad1304e11', 'out', '2026-09-15 18:38:51.013', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('14593beddcf93a0c848ae4b8ea4e0180', 'out', '2026-09-15 18:38:54.918', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('9260a0e9d9153c3cab223631283716f3', 'out', '2026-09-15 18:40:02.802', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('2188c6c57ace31b0a9c7b9b71bd37444', 'out', '2026-09-15 18:40:08.008', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('26f4801521bc3d6fbc0566ece59a311b', 'in', '2026-09-15 18:40:37.065', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('f7abb2dabe163e66a7f5fd8a5b741648', 'out', '2026-09-15 18:41:07.082', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('f81be5132ed73afe8a53a622ef3c39c1', 'in', '2026-09-15 18:41:17.214', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('9e374b032c6a3ad1a42fc457fa0b07bc', 'in', '2026-09-15 18:41:25.808', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('9e374b032c6a3ad1a42fc457fa0b07bc', 'out', '2026-09-15 18:41:31.714', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('8b76549f207b3afc937a70bacaeeb6d4', 'out', '2026-09-15 18:41:36.319', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('0d00957ae1a23fdd9b484e9f9feff7fb', 'in', '2026-09-15 18:41:44.448', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('52dd40bac60d30d897ed35e81cf37d00', 'in', '2026-09-15 18:41:58.967', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('928a945eec74323d8b5c1e5702ebd34a', 'out', '2026-09-15 18:42:01.952', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('af925d7fe67331f789c068da31337435', 'out', '2026-09-15 18:42:07.261', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('5a1d096a62be307697d355998781c4cb', 'in', '2026-09-15 18:43:30.178', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('2a17f11093533ab09ef594d2fdfc0ad7', 'in', '2026-09-15 18:43:43.279', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('2a17f11093533ab09ef594d2fdfc0ad7', 'out', '2026-09-15 18:43:46.482', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('db5c83ba71443b2c9841e67a3fa687a4', 'in', '2026-09-15 18:44:36.159', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('4a3debc2dce83f84a9d9ef088f73694e', 'in', '2026-09-15 18:44:55.983', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('874ddf879f26327b9110b141421b82dd', 'out', '2026-09-15 18:45:11.885', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('1ac6e509129a34a496a542312fb876f2', 'in', '2026-09-15 18:45:22.916', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('49f0af4355253f3c9a08cef98198dc51', 'out', '2026-09-15 18:46:04.849', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('41de323f9d66310cb62fd8d43f137601', 'out', '2026-09-15 18:46:13.158', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('49dc452e324234219eff500f9b472576', 'out', '2026-09-15 18:46:42.998', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('a61370b14ae531589df4a018e7c056d7', 'out', '2026-09-15 18:48:47.961', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('43d8bef7a878319ab3a0477bb163ec31', 'in', '2026-09-15 18:48:50.954', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('eb36fcdf0fad359182d71af4cb0fbf0a', 'out', '2026-09-15 18:51:06.225', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('a2877311d40838b184dfa1240ab7f490', 'in', '2026-09-15 18:51:28.05', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('37afb576682236018e7deca8e8fad5c0', 'in', '2026-09-15 18:51:47.974', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('4e5e8145f018397eafd8706c414b160f', 'out', '2026-09-15 18:51:49.371', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('7408dcb67467320fbbbf57459d72d484', 'in', '2026-09-15 18:52:20.611', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('e8e44da462193e588362e96e1bee654b', 'out', '2026-09-15 18:53:27.291', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('82bc876666d43cbfbb5c1e355c8a2bb7', 'in', '2026-09-15 18:54:55.901', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('4b9086df43653977a602c3e06bb3fbe2', 'out', '2026-09-15 18:57:04.96', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('2bd08a0375ce397da072324483a56335', 'out', '2026-09-15 18:57:31.092', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('f95daecd5aff3a47bdf16af11e505fa5', 'out', '2026-09-15 18:57:47.512', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('c58c0184b0843d289dc8bc91351f8e90', 'out', '2026-09-15 18:57:53.62', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('ee6cb3b44be231189f37335f02b55e1c', 'in', '2026-09-15 18:58:10.543', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('0748356daeb3379f8e26dcd3bd6fc054', 'out', '2026-09-15 19:00:15.998', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('b719f56be11532f2b3be2d50f4b20ca6', 'in', '2026-09-15 19:00:22.405', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('b00f4f096e173e1f981869b971b2c0e5', 'out', '2026-09-15 19:00:32.115', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('580b61800bae3ae0a0315ff793441f51', 'in', '2026-09-15 19:00:42.93', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('e3dfe4af56723ceea9e929ba020acd09', 'out', '2026-09-15 19:01:07.161', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('e3f3805d829d334d85c9c06e79e803b2', 'in', '2026-09-15 19:03:55.467', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('d9af9bcaff8d3a7d9e7f503ff9e24e8a', 'out', '2026-09-15 19:04:27.104', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('ae2e963178b335918d76e07211dad1d3', 'in', '2026-09-15 19:04:34.217', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('747a266f512f36778bcc1e73b1ea5477', 'out', '2026-09-15 19:04:40.02', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('d3d6c41e650a3ac18b375f82b47142d6', 'out', '2026-09-15 19:04:47.729', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('60125bc3b6ed367b9ce6306d063fbb82', 'out', '2026-09-15 19:04:58.442', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('4a3debc2dce83f84a9d9ef088f73694e', 'out', '2026-09-15 19:05:12.361', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('81ab3c0dee143dc99e2475e5ba1fa5a6', 'in', '2026-09-15 19:05:37.994', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('4da7bc21383039749bcdeba6a5e988b9', 'out', '2026-09-15 19:05:44.399', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('fe3514832c1a398fa592d47837d59b77', 'in', '2026-09-15 19:06:15.238', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('43cafb8e6f27327d8a241068784cd171', 'out', '2026-09-15 19:06:39.266', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('302a30c762543e4c91337799306dfe26', 'out', '2026-09-15 19:07:19.014', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('1cbf4ee041b03de89e69c162abaa00f9', 'out', '2026-09-15 19:07:48.654', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('f81a10219ec4315e8eb000dd6a1ffe56', 'in', '2026-09-15 19:07:53.862', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('17b14324cd8d384ba3cf815bab2d8eb3', 'out', '2026-09-15 19:09:58.309', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('ff6490b371493d5b9e6e705c5844cc9f', 'in', '2026-09-15 19:10:52.684', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('25a03ae0ce0e39c989ee12fa7c68e7a9', 'out', '2026-09-15 19:14:08.014', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('657eae93769935069f7cc5bb1e90a6fb', 'out', '2026-09-15 19:14:09.023', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('657eae93769935069f7cc5bb1e90a6fb', 'in', '2026-09-15 19:14:12.93', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('e345d6a6ee9f36deafd46a3b4da4cefd', 'in', '2026-09-15 19:14:20.739', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('31df6fa240a334649210c494a45f14f4', 'out', '2026-09-15 19:14:36.748', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('004c91d566d032ab8c1d6eaa852da5b9', 'out', '2026-09-15 19:14:49.865', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('058f695e1b6b3e9c878cc6fd16b9b712', 'out', '2026-09-15 19:15:42.938', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('4d2c090dc0ca32998e9c023310e6b67d', 'in', '2026-09-15 19:16:02.56', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('c1c224dc79db3a78a51dc3dfbce5b71c', 'out', '2026-09-15 19:16:22.277', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('43d8bef7a878319ab3a0477bb163ec31', 'out', '2026-09-15 19:17:48.086', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('f0c821498b473b139a26854caf2e53a6', 'in', '2026-09-15 19:18:19.728', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('ab967806a4513c69bf9bfdbc18384040', 'in', '2026-09-15 19:19:20.703', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('dfab93ee1f61361d95c31ecc4b32eb63', 'out', '2026-09-15 19:19:23.902', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('ab967806a4513c69bf9bfdbc18384040', 'out', '2026-09-15 19:19:29.515', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('6ba8051d8ac43bf880bb9ab16cb9d6cc', 'out', '2026-09-15 19:20:10.659', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('070c7e6a2d483e7a8d17bce60e9c0a80', 'out', '2026-09-15 19:20:53.513', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('52a46e96e0d5330b8e57b7c6d2785967', 'in', '2026-09-15 19:21:48.984', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('43f8095412a331599c4c84502aa4d113', 'out', '2026-09-15 19:21:52.485', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('5b3a9849a9a83c47a65028d1cc47dbf0', 'out', '2026-09-15 19:23:09.376', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('83485e0d87023a209575fbb57e99325e', 'out', '2026-09-15 19:24:52.303', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('be81bbc90ccd31fb802530418489f13d', 'out', '2026-09-15 19:26:22.112', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('d52f025fa38f38bbb3a9bcfdb716f20d', 'out', '2026-09-15 19:27:31.498', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('a6b4783c6a7d333f90042ba3fbeb710a', 'out', '2026-09-15 19:27:52.53', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('095e477458483ec4abb663b6e41e7b66', 'out', '2026-09-15 19:28:02.141', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('8647863a8ec93e0d9f1aa8b5c964213c', 'in', '2026-09-15 19:28:11.552', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('b726f0fe51e232b0983e3b3ff8474ac3', 'in', '2026-09-15 19:28:28.474', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('27f32964bb1d3e129a4cdf3f8e7112dc', 'in', '2026-09-15 19:32:37.074', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('dc7e9ddd77c5376a8552673889ada3a1', 'in', '2026-09-15 19:33:07.912', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('57dd0c281bd93a41a99ebf254d43278d', 'out', '2026-09-15 19:33:30.537', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('d177637741be3af38159af155ced034a', 'out', '2026-09-15 19:34:36.217', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('ec82163c8f7c381a86c48429b8f5a5b6', 'in', '2026-09-15 19:35:06.257', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('8b86fb65c8a73906acfba7821a822a76', 'out', '2026-09-15 19:35:27.38', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('d1b74b5bd9b63a9c8738565c31a15dcd', 'in', '2026-09-15 19:36:38.968', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('791943cdda0a3b9095bcd0465d89a442', 'out', '2026-09-15 19:36:45.573', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('d7735b33b6b134218d7ca1684c98f85d', 'in', '2026-09-15 19:41:51.547', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('b1e1daeb1b6c359f97158f2c855a077a', 'out', '2026-09-15 19:42:28.285', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('3284cc88bd15358896af56e9592c58df', 'out', '2026-09-15 19:43:43.272', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('d75b01a7f68b348ab2acebdb5b0cb359', 'out', '2026-09-15 19:46:46.209', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('45406d3e73e93a63a5c8760a0fa9d52d', 'in', '2026-09-15 19:50:23.178', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('ef055d79f1d235d089cf9260a55f9642', 'out', '2026-09-15 19:50:45.397', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('ce04c6eda30431f1980a9e90991ef036', 'out', '2026-09-15 19:53:52.635', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('01f8edac4f363b8aaf459266c11dab59', 'out', '2026-09-15 19:58:09.542', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('7f09b0fa7451363cb21d83a814109117', 'out', '2026-09-15 20:14:27.038', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('4e5e8145f018397eafd8706c414b160f', 'in', '2026-09-15 20:14:37.349', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('4e5e8145f018397eafd8706c414b160f', 'out', '2026-09-15 20:14:41.954', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('fc3b84cee4c13838998e185cf40465da', 'out', '2026-09-15 20:20:35.185', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('f9a813c985ca3935a1d9b0b8360e7a2c', 'out', '2026-09-15 20:22:11.392', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('0c934399cf6835dc950aa669b3bb9f24', 'out', '2026-09-15 20:22:13.394', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('d70aaddedec437719ef7db15b07454d0', 'in', '2026-09-15 20:22:18.6', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('e6c6d8aa59fe371299ca69a7bbe177a2', 'out', '2026-09-15 20:22:39.237', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('776361afacb83c5ca9cf309560425e8d', 'out', '2026-09-15 20:23:04.57', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('9c1465742e8238eba31f8d6dc7654842', 'in', '2026-09-15 20:23:06.258', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('4c9fbda621d338af9b2922b04b504551', 'out', '2026-09-15 20:23:22.891', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('ff6490b371493d5b9e6e705c5844cc9f', 'out', '2026-09-15 20:32:39.156', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('1d54edd255a03dc2a43fef07cc523244', 'in', '2026-09-15 20:33:25.726', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('9cbcd8d2c00f3eb699a9e8b0dafca6a8', 'in', '2026-09-15 20:48:05.978', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('d105820ba01532c3b927823194d564a3', 'in', '2026-09-15 21:01:43.251', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('ab0a19a1f651389a8a1f3fee6523a5d8', 'out', '2026-09-15 21:02:01.184', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('0da7166e211334f58e932d5238155c29', 'out', '2026-09-15 21:02:25.414', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('3ff703bd8bc83c2f9f897f1f52813678', 'out', '2026-09-15 21:05:53.054', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('77862bf6f5213477948132c0397b5c4c', 'in', '2026-09-15 21:10:55.71', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('a325259a5b6c3c39a13b7d308c6f6e74', 'out', '2026-09-15 21:11:12.036', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('ac3e4855815d32388036a184a53d9400', 'out', '2026-09-15 21:24:33.799', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('d1b74b5bd9b63a9c8738565c31a15dcd', 'out', '2026-09-15 21:32:09.241', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('e1cb3ce1b3c03518bff838f7d265fcff', 'out', '2026-09-15 21:34:09.489', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('6d8de73b8d6b3f74b0b4702fbf72bd10', 'in', '2026-09-15 21:41:16.8', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('a8654840fa493c44b0cbdf73e0e56691', 'out', '2026-09-15 21:41:40.927', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('b454edce06b53542a57b8ab86b45fa64', 'in', '2026-09-15 22:01:14.851', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('ce135bbefd133ce39f2c58f4bc9c0974', 'out', '2026-09-15 22:01:54.165', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('1ff758bb8e1f3b19a7908adffa5d1e05', 'in', '2026-09-15 22:20:55.773', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('7d87436e0f3c39dc881c0bf9da8a4d89', 'out', '2026-09-15 22:21:14.861', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('732cabb5c2503f228067adf42392f947', 'in', '2026-09-15 22:33:05.654', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('fac183bd6bed3cd099fd9fdceb0d8b9f', 'out', '2026-09-15 22:33:21.065', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('b6ad357830b93f2bb40263325a03d472', 'out', '2026-09-15 22:35:19.711', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('b261334474ab37838cca88096e46f432', 'in', '2026-09-15 23:07:43.653', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('5dd76857794830beb9192abe4ea8a97e', 'in', '2026-09-15 23:22:12.982', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('a51f657536ca3085b968514f40a1d6b1', 'out', '2026-09-15 23:23:24.342', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('1d54edd255a03dc2a43fef07cc523244', 'out', '2026-09-15 23:24:13.299', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('c5588025111e355982be8053d00f6b24', 'in', '2026-09-15 23:38:26.918', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('8acf0ab972443e1bb1f288b8487a9976', 'out', '2026-09-15 23:38:47.512', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('e509febfc6d63d3db065259728a26577', 'in', '2026-09-16 01:21:14.706', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('53499f40a7653169a7bac47f1d50f0e2', 'out', '2026-09-16 01:21:33.809', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('8140566ac033385983c83a054d7df821', 'out', '2026-09-16 06:29:36.961', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('922369ca0afc396eb5d07880bfde915e', 'in', '2026-09-16 07:10:01.061', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('0d38b63747b73a21ac8424070027a46d', 'out', '2026-09-16 07:11:53.758', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('db7e52242bd53962a68b93b6e1a09c1d', 'in', '2026-09-16 07:13:19.764', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('1bd30466575b3ddfa927977206eaf0e6', 'out', '2026-09-16 07:13:40.852', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('73323a3ba0c53537b5578f50331c2121', 'in', '2026-09-16 07:32:52.016', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('ecb51343e98b312d8912574d5f92356c', 'in', '2026-09-16 07:34:22.529', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('9f4ef3c0df66361b878e7ee9e77c5b81', 'in', '2026-09-16 07:34:28.783', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('50de757f5f1239c1ba6fcc51d70f38a3', 'in', '2026-09-16 07:36:59.822', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('b7a1ea55abb03a6ead53d6606199d535', 'out', '2026-09-16 07:37:23.4', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('aad938e33947350882be925f68688e35', 'in', '2026-09-16 07:37:49.184', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('81fde9a4eb0d39b297fb153ed025e07a', 'in', '2026-09-16 07:37:53.989', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('3c51bbc9fc6a396fb3483bf45fb73680', 'in', '2026-09-16 07:38:07.506', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('7b82b4c11f2e38e0b26c1703b9d1724e', 'out', '2026-09-16 07:38:09.053', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('a992fb4092fc3d7fb1e8c1b834987b52', 'in', '2026-09-16 07:40:14.462', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('5233c14e957837918830a2baf3afec34', 'out', '2026-09-16 07:40:39.738', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('6c29ecd64fb039af9db1608b1d0915f9', 'in', '2026-09-16 07:41:34.46', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('6b8effc6601f38469289cfe144e1fb32', 'in', '2026-09-16 07:41:47.376', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('65da5ec686a936c1b01c9d4ec80bf56f', 'in', '2026-09-16 07:42:21.863', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('ed7ef217ff5837a59ced42959e5ae8a5', 'in', '2026-09-16 07:44:06.442', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('48e8f9c28ba1325dadb3a7abf440b396', 'out', '2026-09-16 07:44:20.305', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('48e8f9c28ba1325dadb3a7abf440b396', 'in', '2026-09-16 07:44:27.213', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('ef60480ea52133539cec20da30b73aeb', 'in', '2026-09-16 07:45:54.689', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('f2c5b58d8cd73b1f82260951e4123aa1', 'in', '2026-09-16 07:45:54.919', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('06d07568f4403be28a79d883b8f73ffd', 'out', '2026-09-16 07:46:13.241', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('45f9b637cbb23a8caf103c1a1ed3cea5', 'in', '2026-09-16 07:47:29.111', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('3412ddcdf46238b0909074fb7ff06065', 'out', '2026-09-16 07:47:49.564', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('c59fa6ffb92834e8aec4648b5c161161', 'in', '2026-09-16 07:49:23.449', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('8d24537084cd36e885a62299d98e980c', 'in', '2026-09-16 07:49:32.561', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('07db445e7f8335e482b05830b7f8bd0f', 'out', '2026-09-16 07:50:06.032', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('6afa36a473f23803b340d8a29efaba8e', 'in', '2026-09-16 07:51:44.128', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('afcf679ecc27359fb77f77065b3688cc', 'in', '2026-09-16 07:51:54.243', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('fc535f1b0ac13f94ac435a0c473c92da', 'in', '2026-09-16 07:52:09.36', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('d36ac857f18d3e7b8245a5b373d2a940', 'in', '2026-09-16 07:53:53.596', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('9f4ef3c0df66361b878e7ee9e77c5b81', 'out', '2026-09-16 07:57:12.55', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('f2c5b58d8cd73b1f82260951e4123aa1', 'out', '2026-09-16 07:59:23.209', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('4a9ffabcada23ee4b687eb0e2ccbe1a4', 'out', '2026-09-16 08:01:16.047', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('4a9ffabcada23ee4b687eb0e2ccbe1a4', 'in', '2026-09-16 08:01:19.15', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('4a9ffabcada23ee4b687eb0e2ccbe1a4', 'out', '2026-09-16 08:01:26.86', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('8eb17047226a3621a13dd116649c291d', 'in', '2026-09-16 08:01:30.559', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('4df5a9750d97380b905287b23a8a6a4b', 'in', '2026-09-16 08:03:28.704', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('5015e86b2dd83725bbce50957469bd7f', 'in', '2026-09-16 08:03:36.514', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('19cfc88328dd32f493b79e641b1a8fbe', 'out', '2026-09-16 08:03:51.24', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('57ff774b5b503b98a9bd44310b9792cc', 'out', '2026-09-16 08:03:58.251', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('57ff774b5b503b98a9bd44310b9792cc', 'in', '2026-09-16 08:04:04.757', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('c025f70b90d83f9682df1bf32085d540', 'in', '2026-09-16 08:04:18.565', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('43603cc519f13ef799696d7351d625e4', 'out', '2026-09-16 08:06:55.174', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('6acd0baabfd7368d9b9db43ea15a5306', 'out', '2026-09-16 08:06:59.785', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('1e13804cfb2436a3b4eddbf900f44728', 'in', '2026-09-16 08:09:11.737', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('afe78adfdf813505b5f5fd72d70798b9', 'out', '2026-09-16 08:09:32.366', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('3b64a27dc36438c9848ccea38a14a93e', 'in', '2026-09-16 08:10:08.107', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('a3ae4559da5d32858a1e6968fa01088f', 'in', '2026-09-16 08:11:26.402', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('650a6993fbf13a048abbfa6c20e2c34f', 'out', '2026-09-16 08:11:53.44', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('650a6993fbf13a048abbfa6c20e2c34f', 'in', '2026-09-16 08:11:55.14', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('133707bd5f0d38aaafa2b2d433b07bf5', 'in', '2026-09-16 08:13:05.422', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('133707bd5f0d38aaafa2b2d433b07bf5', 'out', '2026-09-16 08:13:08.126', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('8f28349a91073ca298c4d77451575591', 'in', '2026-09-16 08:18:35.033', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('bda8ce44182632dab27589252fc54fbc', 'in', '2026-09-16 08:18:48.049', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('4078ecdc3800351fb9d61fd9799b22d2', 'out', '2026-09-16 08:18:51.457', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('16733b995cb93d118d2c4801c93f9ca8', 'out', '2026-09-16 08:19:10.38', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('dfc05808a0cf3d1887585eb4449451cb', 'in', '2026-09-16 08:24:36.581', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('96097639bf6e32ff89c8a8e8f3493798', 'out', '2026-09-16 08:24:43.592', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('355fdeac97c63ba8b8af1b7c1d6ec7bf', 'out', '2026-09-16 08:24:57.91', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('a9dabd3510ec3e60bd29177a6b206b57', 'in', '2026-09-16 08:26:29.323', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('552e6f52065233469f647bde42bc9231', 'in', '2026-09-16 08:27:58.132', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('cba397d83add30f4982f602a28b014da', 'out', '2026-09-16 08:29:19.753', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('b65bd3d248683e3ca298b2510152718e', 'in', '2026-09-16 08:30:36.525', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('67a656ced21532c0bf0ea16e57679d96', 'in', '2026-09-16 08:31:17.375', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('317b19979e5835f6bf32beae89fcfcc6', 'in', '2026-09-16 08:32:45.081', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('7845f7b095833ded9db28e93520db5d7', 'in', '2026-09-16 08:32:56.497', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('e3c990119994336aad07c6092b568ba6', 'out', '2026-09-16 08:33:06.029', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('3acc0727cdd8312fb2e08197adb821af', 'in', '2026-09-16 08:35:32.984', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('aaf162f47b593a5ba1d79713ba8ebf0a', 'in', '2026-09-16 08:35:40.995', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('cb479c782fce349a9f5dc7f086843b73', 'in', '2026-09-16 08:37:10.705', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('054086ea5b1638e5bbb0ec2d3941afee', 'in', '2026-09-16 08:38:33.406', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('1d99a08f50a2314d9bd604753e454dd6', 'out', '2026-09-16 08:39:19.987', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('9a0193bd7f2f3b3c81598b6c4730580a', 'in', '2026-09-16 08:39:23.967', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('1d99a08f50a2314d9bd604753e454dd6', 'in', '2026-09-16 08:39:25.094', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('1d99a08f50a2314d9bd604753e454dd6', 'out', '2026-09-16 08:39:28.798', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('cb2d3ebf7e9234719cb25659c2c6d1a9', 'in', '2026-09-16 08:39:30.976', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('cb2d3ebf7e9234719cb25659c2c6d1a9', 'out', '2026-09-16 08:39:55.006', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('6ecf9437d46e32788d820e669b5e9f98', 'out', '2026-09-16 08:39:55.931', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('24062ca29cfc363da1a00f915ae73aa1', 'in', '2026-09-16 08:40:38.958', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('0202b4a026fd3c3682e0966ac7f08aac', 'out', '2026-09-16 08:41:15.826', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('8259a4f5ecbf36a2b147bf30b538f5d1', 'out', '2026-09-16 08:41:23.635', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('3c51bbc9fc6a396fb3483bf45fb73680', 'out', '2026-09-16 08:46:32.912', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('3c51bbc9fc6a396fb3483bf45fb73680', 'in', '2026-09-16 08:46:38.419', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('0c8349f1645c3978af0c289f0fb7c79b', 'in', '2026-09-16 08:46:45.226', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('36205658db443dc78b06df2efc496b21', 'out', '2026-09-16 08:47:00.047', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('ea71032795173b46b6a99d8ebb76fa43', 'in', '2026-09-16 08:47:31.082', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('9dde6406978b343bb5c3cfc23fba36d7', 'out', '2026-09-16 08:47:49.907', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('d0c6cbb377f63c5dbd1851f784200122', 'in', '2026-09-16 08:49:59.259', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('ebcceb731cd4347589af9a0fbd4ffa02', 'in', '2026-09-16 08:50:57.83', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('8352dfa483143b168c107ec9e89a6aa7', 'in', '2026-09-16 08:52:06.014', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('94ba675a27343fa1b8017735101f4708', 'in', '2026-09-16 08:55:21.446', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('e38ee5fdb2fa39059f99bc1379cbba8e', 'in', '2026-09-16 08:57:08.977', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('416b3d6e8f3437ccada05440289b4e5e', 'in', '2026-09-16 08:59:15.034', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('0f394a253f1a3c1f9ef1e392ee5a1b75', 'in', '2026-09-16 09:00:05.595', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('8054bf349d0d32cda08ffea814eeeda6', 'out', '2026-09-16 09:00:35.837', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('41c46d5e051d36d0a1830d5dd3af2468', 'in', '2026-09-16 09:01:34.402', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('a3021e138c8f30418293fc1158a20b35', 'in', '2026-09-16 09:02:35.278', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('53330e7b6fca3068a1dfc0bf25e779b7', 'in', '2026-09-16 09:02:43.392', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('6ec06a7a87673c838002b23c0469e699', 'out', '2026-09-16 09:02:50.908', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('e9609775cd033d2ab7aa053aa88cdf4c', 'in', '2026-09-16 09:03:45.587', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('88947da8768c3253ba308a73da4db8a4', 'out', '2026-09-16 09:04:09.404', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('622a7f039e9333d9a2a8ee7fc774c8f5', 'out', '2026-09-16 09:05:08.877', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('a5fe2cd284473551a29c8ccca7e8564e', 'in', '2026-09-16 09:05:09.492', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('1ba439f094913a6f9e47772010937233', 'in', '2026-09-16 09:05:45.334', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('0035d5c7c320344fb084d7bd7145a217', 'in', '2026-09-16 09:08:46.556', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('3b509b75ff1336779c51d62b5ba9af68', 'out', '2026-09-16 09:08:57.657', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('fa2e3e5456e63630836c0671a903b3da', 'out', '2026-09-16 09:09:11.674', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('6567b00a42e23c0096f4155eb70c19de', 'in', '2026-09-16 09:09:18.293', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('f214e9fe4a6939b0ae45efe4d90f77c1', 'out', '2026-09-16 09:09:37.205', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('894507424de73d0a9cb1c140cb76014d', 'out', '2026-09-16 09:10:56.002', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('9fb5709d6f743fb0bd78a59f3f48ea0f', 'out', '2026-09-16 09:11:07.116', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('c14a153fae9b3d65ab1f982123ddf997', 'out', '2026-09-16 09:11:24.338', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('88ba64bece513d18a57ed2576a0b15bc', 'out', '2026-09-16 09:11:46.064', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('e1902d7e5c0f31acbfab0faaaab8f689', 'out', '2026-09-16 09:12:14.803', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('0035d5c7c320344fb084d7bd7145a217', 'out', '2026-09-16 09:12:48.044', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('65da5ec686a936c1b01c9d4ec80bf56f', 'out', '2026-09-16 09:13:38.999', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('d8edcddaf2fc3669a99e55a63410db2a', 'in', '2026-09-16 09:14:22.959', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('848608d7a9fe32d2ade08ad1a75e32c4', 'out', '2026-09-16 09:14:43.277', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('7bac61f2abb5306981dc65dad493fdb8', 'in', '2026-09-16 09:15:40.952', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('f9ca1d5c34853bf58b077b4528190a72', 'out', '2026-09-16 09:15:53.266', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('7d8f8168b3c338099dcf2c7e3458191a', 'in', '2026-09-16 09:18:14.944', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('6ab50e71f80f3528bc1f83993b65264f', 'in', '2026-09-16 09:18:23.356', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('c9a94e0086953f8e9b770ba9484e6601', 'out', '2026-09-16 09:19:21.122', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('343d83fc7a313caabe6f795b767afc13', 'in', '2026-09-16 09:20:27.82', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('df9a8351d14636e9a6d808fa1bccfa01', 'in', '2026-09-16 09:20:33.928', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('62cb37d7a7f2322c95c3475606482695', 'in', '2026-09-16 09:21:04.265', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('381dfece7ee235f0a3455d08eef507aa', 'in', '2026-09-16 09:23:45.163', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('65da9bb899b13a35bb39e976a1641e42', 'in', '2026-09-16 09:25:23.985', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('a719ed34785b3b0688cd94294c5eb1bd', 'out', '2026-09-16 09:25:50.311', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('c09808a074cd3548b59ca52ce4128db8', 'out', '2026-09-16 09:27:18.121', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('eef52c927c2235c786fb3116d91fb9b7', 'in', '2026-09-16 09:28:26.01', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('4ff1a7bab8d033368957b047bdf106ca', 'out', '2026-09-16 09:29:02.543', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('30f020a76b483cafb50b86d0f9f01a95', 'in', '2026-09-16 09:29:19.573', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('89d92119481f3edd96d6afd51dd19fc8', 'in', '2026-09-16 09:29:25.682', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('67f003b5b3633f5b81f493962c1a0875', 'out', '2026-09-16 09:29:34.983', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('e4fb61e1427a3e0f916e6cb4e4aad44e', 'in', '2026-09-16 09:31:15.014', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('60fda65ad4c236ff8753392d012abeea', 'out', '2026-09-16 09:31:36.43', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('60fda65ad4c236ff8753392d012abeea', 'in', '2026-09-16 09:31:38.733', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('42ee205658803710a25e92869276f7cd', 'in', '2026-09-16 09:32:14.084', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('6ee1f9282a013b6182443de4b66dedd9', 'out', '2026-09-16 09:32:37.805', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('8c05fcfe96ec33348a89d25d172dc38f', 'in', '2026-09-16 09:34:02.418', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('6202cc2881f934fb9b3d697ea0731ad1', 'in', '2026-09-16 09:34:07.835', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('efe7ac89b7a63b9a912246f9433bfdb6', 'in', '2026-09-16 09:34:13.233', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('e371ae56e4e93723afdc3db5177ae0fd', 'in', '2026-09-16 09:34:43.885', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('50467fae6c25378b82ccbccf3013206a', 'in', '2026-09-16 09:36:37.808', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('8e82748f281e3a4ebf2235494ac2db4e', 'out', '2026-09-16 09:37:07.36', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('48e8f9c28ba1325dadb3a7abf440b396', 'out', '2026-09-16 09:38:03.128', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('df3da56aa1ba3ff9aa4105b45c5a158a', 'in', '2026-09-16 09:38:42.475', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('ac39eae4cc0e3384834bc1b442bcf612', 'in', '2026-09-16 09:40:03.563', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('4b545e7e8bc33620a58a836a8a597b4c', 'out', '2026-09-16 09:40:30.708', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('676d341eab433daca9a995ed5108a081', 'in', '2026-09-16 09:40:41.108', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('e71dbb4dc5af3cf1973b4a2cdc67aa1b', 'in', '2026-09-16 09:41:20.358', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('eb91939e9deb366f88a48dfce6b82faa', 'in', '2026-09-16 09:41:51.397', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('4f450929fcda3c8485e07d6055815fee', 'in', '2026-09-16 09:41:59.713', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('650a6993fbf13a048abbfa6c20e2c34f', 'out', '2026-09-16 09:42:33.962', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('a328e4e222383db5bdab368264c40d76', 'in', '2026-09-16 09:42:45.175', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('99b01104a54c397985d91b1f1761ac8e', 'in', '2026-09-16 09:42:49.57', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('7fb87257eb603bfebcf212d836fc1c50', 'out', '2026-09-16 09:42:52.786', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('f575c77aa6243bd68de2bf31f5eefda3', 'in', '2026-09-16 09:42:57.792', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('31636d94c4563463867af665bcf6fd4e', 'in', '2026-09-16 09:43:12.398', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('f575c77aa6243bd68de2bf31f5eefda3', 'out', '2026-09-16 09:43:18.418', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('f575c77aa6243bd68de2bf31f5eefda3', 'in', '2026-09-16 09:43:22.822', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('bfa53932f7223ffda339071d1794eb26', 'out', '2026-09-16 09:44:11.784', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('eed4aec9e8653b239ec5cbf7f3634719', 'out', '2026-09-16 09:44:25', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('629234ce123732f284943c752c6b2e11', 'out', '2026-09-16 09:45:13.458', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('e11e90368fbe320b905d9103984416c4', 'in', '2026-09-16 09:45:18.154', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('2a3f308cf4fb3b228760b526dc99f3bb', 'out', '2026-09-16 09:45:48.5', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('e25086298f2135bdba56727137f47fd4', 'out', '2026-09-16 09:47:05.492', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('b01648dbf7053a81832eaea351bb3d74', 'in', '2026-09-16 09:47:57.951', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('6e4420ef97943f8c8d59a03749c344d9', 'out', '2026-09-16 09:48:16.279', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('d28dc2f79e7937c59916292edc073eab', 'in', '2026-09-16 09:48:38.102', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('75e2b3818eab393e82c1de9ca828da51', 'in', '2026-09-16 09:48:48.215', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('1b12c8ada4c93928ac03fc89d5da4037', 'out', '2026-09-16 09:48:58.43', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('b926e67df4c13978ac171d46d8034a9e', 'out', '2026-09-16 09:49:04.738', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('271d7c62185b3bd188d0d2fe0ee75e53', 'in', '2026-09-16 09:50:14.22', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('e0db4062ef8e35ce949d4c2bc7ee4c88', 'in', '2026-09-16 09:50:41.856', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('1a001856e56a3b95b3435d0405d0f6a6', 'in', '2026-09-16 09:50:57.373', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('8a7b2529fcfa31a8941b7c93380c65cd', 'out', '2026-09-16 09:50:57.783', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('f828853388af3c14bdb513da1b8499f6', 'in', '2026-09-16 09:51:44.832', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('04fbbbdf77aa3e748d5b9ee73652e34a', 'out', '2026-09-16 09:52:04.362', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('688b4bf05459334d87e5fd26315214e0', 'in', '2026-09-16 09:52:43.904', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('563d25bacbca3714b80a7e99e931df53', 'out', '2026-09-16 09:52:45.104', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('1132fe7151343b60bbeaa1e3db0882a2', 'out', '2026-09-16 09:54:24.638', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('2c945e1fbbd438b4a74aa327a3ad6002', 'out', '2026-09-16 09:56:44.21', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('61cd5590a4ee321f85b03aa4d40576a1', 'in', '2026-09-16 09:58:21.512', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('d3100f7a14dc3deb93e4219a309a1e6e', 'out', '2026-09-16 09:58:23.927', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('e885f4fea6993b52adceed08ef3e2cbb', 'in', '2026-09-16 09:58:41.537', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('4a2e9225c570387bbbd8ea1e2bfced07', 'out', '2026-09-16 09:59:00.469', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('c458b281ddc23053ae06327d374ae82e', 'in', '2026-09-16 09:59:25.991', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('b1eb8ff803b03ee29ceeb6742d3f38f8', 'out', '2026-09-16 09:59:45.625', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('c49ebd2c729c3939b89f22344a4af53c', 'in', '2026-09-16 10:00:15.35', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('4004986cbb523bed9a1429b6523e37f9', 'in', '2026-09-16 10:00:50.393', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('fbec0c3fc663355eb1bcfdeb98a2bf1e', 'out', '2026-09-16 10:01:22.042', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('90179c0860cc3e649da698cc75dff4b7', 'in', '2026-09-16 10:02:54.246', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('41b10bbf6958374dabcc9997855b69cf', 'in', '2026-09-16 10:03:08.963', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('710a398471b833629968a8f92ec68ed3', 'out', '2026-09-16 10:03:10.675', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('80f83e77335f3d63b783a80940bd98f0', 'out', '2026-09-16 10:03:50.426', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('ef56bf7c11e03fa19f717dd5d01f9be9', 'out', '2026-09-16 10:03:58.836', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('eabba06c5bdd30b6ad9bd1205013eec9', 'out', '2026-09-16 10:04:03.542', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('cb2d3ebf7e9234719cb25659c2c6d1a9', 'in', '2026-09-16 10:04:57.097', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('8ce26d1b542c37b3a8cc3a8ab5cf4df1', 'in', '2026-09-16 10:05:12.417', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('e653b902fc18313da4c2b49f8a91aee8', 'out', '2026-09-16 10:05:22.738', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('8ce26d1b542c37b3a8cc3a8ab5cf4df1', 'out', '2026-09-16 10:05:35.546', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('70a153614909376db36a717676652bfe', 'out', '2026-09-16 10:05:41.46', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('98edb8695e1c34ccaeee12e038434553', 'out', '2026-09-16 10:06:33.022', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('dcddb6ff0bc73c51a6a903211eda8e3b', 'in', '2026-09-16 10:06:37.726', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('f4b8a0b41049301bb999de836829668b', 'in', '2026-09-16 10:06:44.335', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('7b9ca4aeec7c3532959fd60892ef73c2', 'in', '2026-09-16 10:07:06.661', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('eb23859a7df53f4bbbabd0e95a9eaa3a', 'in', '2026-09-16 10:10:32.815', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('f25a2fb04c04330d935496d18b3db118', 'in', '2026-09-16 10:11:12.463', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('110f3ff83347344fbc7b329c70fc56c6', 'in', '2026-09-16 10:12:20.248', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('6202cc2881f934fb9b3d697ea0731ad1', 'out', '2026-09-16 10:12:27.961', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('b175f8a24bba35b79c29027f0f016062', 'in', '2026-09-16 10:14:03.181', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('de8f44b41c8c333897f1306576332d62', 'out', '2026-09-16 10:14:43.928', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('d819b3a10d4235c3b8da2e15a1672399', 'in', '2026-09-16 10:14:44.531', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('de8f44b41c8c333897f1306576332d62', 'in', '2026-09-16 10:14:52.238', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('6234dcec106639d589aea6b912e9f63b', 'in', '2026-09-16 10:14:52.841', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('1f3d32f97b993124bd58e487d4312d80', 'in', '2026-09-16 10:14:56.846', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('7ed5428bb2133df187489ba4427b8dc3', 'in', '2026-09-16 10:15:01.652', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('de8f44b41c8c333897f1306576332d62', 'out', '2026-09-16 10:15:03.752', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('afd4a2a64f173be1a7d97e5889be564d', 'out', '2026-09-16 10:15:13.164', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('f4b8a0b41049301bb999de836829668b', 'out', '2026-09-16 10:15:57.319', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('3504756d2cf535f38238cb2458ce7484', 'out', '2026-09-16 10:16:07.33', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('6bbeaa965ef5319181a58127c8234859', 'out', '2026-09-16 10:16:14.94', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('965685c771943d1abd231fd2bfe8b61a', 'out', '2026-09-16 10:16:29.357', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('46faf778eea935ccbd947a0b0805679b', 'in', '2026-09-16 10:16:40.271', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('456c2c2fd4b439d5971018fa37f5d2b5', 'in', '2026-09-16 10:16:49.884', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('f135d8d32d1132508d7e91395a9c1927', 'out', '2026-09-16 10:16:55.991', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('e0d715f8332a3e338f5cec97d0c831f0', 'in', '2026-09-16 10:17:26.231', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('b8b1e983ebd336aaba4706d858bcc426', 'out', '2026-09-16 10:17:44.048', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('736a4c1bbadc3270b63f677627f0eae4', 'in', '2026-09-16 10:17:52.961', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('d3fd1795f5a6321bbd5faf3f19807f70', 'out', '2026-09-16 10:19:19.665', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('98f84e99b8553b4f92a267aa2dfbdb5c', 'in', '2026-09-16 10:19:32.782', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('d33ca747df0733b09fd6d176ca10118e', 'in', '2026-09-16 10:20:49.376', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('a26d6b1767b63ad28c88ad006ab98fad', 'out', '2026-09-16 10:20:59.687', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('294cf875780832e286936ed91d4f5a7b', 'in', '2026-09-16 10:21:42.34', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('13ce200573fc36aab29d6f35e58ecb0a', 'in', '2026-09-16 10:21:48.147', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('ae8d0348e2833978a1af81a932d2e1e3', 'in', '2026-09-16 10:22:09.373', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('28e260820ecb318da35ba8d57617bf95', 'out', '2026-09-16 10:22:19.382', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('4177bf1df46e3297873ee769aeea455b', 'in', '2026-09-16 10:22:31.9', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('7fc9655f50403132a779710dc07c633c', 'out', '2026-09-16 10:22:47.816', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('4e0cd92ad8393d8dbcae232a4701e0a1', 'out', '2026-09-16 10:22:55.025', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('f46eb5ca919835e5bb5e6f593f92d140', 'in', '2026-09-16 10:23:22.661', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('f46eb5ca919835e5bb5e6f593f92d140', 'out', '2026-09-16 10:23:30.676', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('36cb6db139403ca39511e2aa476088ad', 'out', '2026-09-16 10:23:53.394', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('2e43aeb04b8a3dcf9efa8849746fe25d', 'out', '2026-09-16 10:24:18.125', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('24df045a2f0134ca992ac9116e637770', 'out', '2026-09-16 10:25:38.123', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('71897b76fe153d6f80a4b82e42d17436', 'in', '2026-09-16 10:26:53.924', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('5cc406c733653d128c36d742029d0435', 'in', '2026-09-16 10:26:57.628', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('5cc406c733653d128c36d742029d0435', 'out', '2026-09-16 10:27:07.639', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('cf29230fcb833a13895431b29901689a', 'in', '2026-09-16 10:27:12.745', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('f249ed01325033e4a0a834d42c9cc0d2', 'out', '2026-09-16 10:27:28.358', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('c80bec49e29a36a6b433aa940239f40e', 'in', '2026-09-16 10:27:39.082', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('6780059a95e133e9b3e24b192d6cf7eb', 'out', '2026-09-16 10:28:01.497', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('df3da56aa1ba3ff9aa4105b45c5a158a', 'out', '2026-09-16 10:29:15.591', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('d4eddce2998f3e02a2edcf287762bd76', 'in', '2026-09-16 10:29:30.814', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('12f420da1555317184de7a0acf76197f', 'in', '2026-09-16 10:29:37.924', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('57ff774b5b503b98a9bd44310b9792cc', 'out', '2026-09-16 10:29:45.728', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('637a23031c563fdba9c2e77642e2af13', 'out', '2026-09-16 10:29:49.732', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('e0ee42de5395340e9ed9f349890fb7ec', 'out', '2026-09-16 10:30:13.061', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('3a55a4559e5131ea8aa36505851db1cf', 'out', '2026-09-16 10:30:19.669', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('a2c09c5f40f539ec8772803021fb11d7', 'in', '2026-09-16 10:30:55.716', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('4b1ef4de16da3e9baaa4b09bf7f461a2', 'out', '2026-09-16 10:31:26.65', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('3a1f6c4dabf935a99ba872b424c0e75c', 'out', '2026-09-16 10:31:35.161', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('6d504ded86da3e7894ee4fe8edc63629', 'in', '2026-09-16 10:32:47.151', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('0a0b120f2dd83d29bb9292d376bd4653', 'out', '2026-09-16 10:33:22.689', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('5c84e2a72d6c3c358fb75909b4285e40', 'in', '2026-09-16 10:34:55.808', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('8701143b6d1d3d91ac615e14355cd6b8', 'out', '2026-09-16 10:35:18.729', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('9cec7e1d0e3231749122da5ddabbb8bb', 'in', '2026-09-16 10:35:33.155', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('6f869b8c13a5359eb591625ccce30cb4', 'in', '2026-09-16 10:35:46.271', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('b6fb38ed43723d0cb1b04857966ea0c0', 'in', '2026-09-16 10:36:39.135', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('a8209a6fd3143a2baae6965db2559b02', 'in', '2026-09-16 10:38:32.773', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('a906eaaf3c703cb389111f0181119cd4', 'out', '2026-09-16 10:39:25.435', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('e6bd312258d431d7be51944aedfdf37a', 'in', '2026-09-16 10:41:10.563', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('e384c368e7e93710913a684757b62881', 'in', '2026-09-16 10:41:32.395', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('d2a6a7ebbc5635d1ab0506c5496a93e0', 'out', '2026-09-16 10:41:37.395', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('ad292a2471a5329ea76730851ae62e17', 'in', '2026-09-16 10:41:39.504', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('63fc5afd43e43fd7ae9c78616fd536f9', 'in', '2026-09-16 10:41:55.422', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('aad7277ec9523fd4966b6b056f4d04b0', 'out', '2026-09-16 10:42:42.977', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('7306ad116b3d39e9b3ccaaa0bba63075', 'out', '2026-09-16 10:42:46.878', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('1867b2d4c50233b4ac15255529035dd4', 'in', '2026-09-16 10:43:10.911', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('4024f0b9da7f3905833bf803b33c4790', 'out', '2026-09-16 10:44:11.681', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('2356d07595813dbf968a2ca693060636', 'in', '2026-09-16 10:44:24.599', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('b492837cbd5f37a08bad64d701eed220', 'in', '2026-09-16 10:45:58.216', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('c35fd325faad3884afe11017a3081a4b', 'out', '2026-09-16 10:46:28.249', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('273e4c64df2e317e97bcc703c89d1af9', 'in', '2026-09-16 10:46:45.975', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('2132c4e02aa230338fae2d27dabc659c', 'out', '2026-09-16 10:46:47.478', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('bbb829e6c03f3d2bb56bf15b9ae3488c', 'in', '2026-09-16 10:47:29.629', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('d63b04fd48d3349ab488798abeed63da', 'in', '2026-09-16 10:47:36.738', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('6916cbf41d6e3d29bd837c2b42730e40', 'out', '2026-09-16 10:47:40.545', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('b6353a587bc13d11939786d63dfa84bb', 'out', '2026-09-16 10:47:58.267', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('4257beb1d4d73db28fdc01f5b256ad03', 'in', '2026-09-16 10:48:59.237', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('7235ab97482b3904ad774a62d8bbbb41', 'in', '2026-09-16 10:49:19.861', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('e159448ae5af3dc49c234f86696b18ba', 'out', '2026-09-16 10:49:20.671', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('75ddfde8b2dd3b8a9265117a08bdaa41', 'in', '2026-09-16 10:49:46.394', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('058c841921b03a59ad136903013c4f99', 'in', '2026-09-16 10:50:30.651', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('bb1d1f31ec9f3e97ae7a5f02632cdef8', 'out', '2026-09-16 10:50:43.974', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('46e4439f0c373e43891d91db2428ee1e', 'in', '2026-09-16 10:50:45.267', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('d1613b3c82f8350697de68db93194338', 'out', '2026-09-16 10:50:52.084', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('d8e1870d78a23de7959a12ebf03eb5c9', 'in', '2026-09-16 10:50:52.175', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('47f3e0d3cc80372592e97d7ef8fb8d03', 'in', '2026-09-16 10:51:08.997', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('6baaaf7a11043bc8bb93919fe701de01', 'out', '2026-09-16 10:51:10.406', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('3af3f0b593933fe881b2c460b91f54e9', 'out', '2026-09-16 10:51:20.518', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('243de9ed11a832ffa1d2d74eb4415a7a', 'out', '2026-09-16 10:51:24.323', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('eac2ac5f08a1366aae814253ddc4a487', 'in', '2026-09-16 10:51:25.916', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('fac9ba6198e835c3bf406d19f80816b2', 'in', '2026-09-16 10:51:38.531', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('0e1f4f413431373b957953e09b4d2b08', 'out', '2026-09-16 10:51:49.452', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('2eb46be4c97834239ad34e3ad720ef68', 'out', '2026-09-16 10:51:57.162', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('9ea1d59dacbb3c4caabcbd8a69fa4f08', 'out', '2026-09-16 10:52:10.477', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('5652604d57903ec0976e48faa38fb3e2', 'in', '2026-09-16 10:53:11.746', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('3edf1f24d9a33d40ae6218bac20981aa', 'in', '2026-09-16 10:54:33.845', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('4404977adbad3c04b5fc57124c565d96', 'out', '2026-09-16 10:55:39.734', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('ae8c8e6a906a3a2a9384d33af4a8d16a', 'in', '2026-09-16 10:56:14.77', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('54ad555652ad397386d2e6a00e867508', 'out', '2026-09-16 10:56:15.176', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('1f9c35d8b474326f87a0eb36bc9efd2d', 'in', '2026-09-16 10:56:22.479', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('8470eb0aa3c63606bdb07692cd487eac', 'out', '2026-09-16 10:56:35.101', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('6936212abdff369aae3e2820dcc22c78', 'out', '2026-09-16 10:56:43.311', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('c081f0260b333c90a95288b811cb6b18', 'in', '2026-09-16 10:57:50.085', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('a59d0a0bb8883b17822b8c964a956a17', 'out', '2026-09-16 10:57:55.498', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('2d6153cea7ad3b9bb5032cb7efdb19b4', 'out', '2026-09-16 10:58:20.93', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('629432ef58cc3fa4898e97dac45de190', 'in', '2026-09-16 10:58:59.069', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('0ad971ee80a03258a2559ad172ebe8e7', 'out', '2026-09-16 10:59:15.998', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('4d7c6376554436e7b7758e863d89e03b', 'out', '2026-09-16 10:59:25.108', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('65f710deffd03244a75056fe4209803f', 'in', '2026-09-16 10:59:38.318', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('bdec684ac3903a3584b498c46522f364', 'in', '2026-09-16 10:59:59.744', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('24be7b80dc7338d8bc7f6ad783657b93', 'out', '2026-09-16 11:00:23.877', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('6ab50e71f80f3528bc1f83993b65264f', 'out', '2026-09-16 11:00:36.086', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('74dd47feac3d3178b4084cdbac132340', 'out', '2026-09-16 11:01:16.343', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('3678e9d641a33d43a00f728de157fc76', 'out', '2026-09-16 11:01:58.093', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('0aa0357e4a473399946e1186b6be0f32', 'in', '2026-09-16 11:03:23.993', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('49947e7e95c93f40be13dc18253105ec', 'out', '2026-09-16 11:03:37.82', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('feee46fdfff3372bbcfc43896d445b06', 'in', '2026-09-16 11:03:41.617', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('fc5924cbe9cc347892d50bfb8ac9e8fb', 'in', '2026-09-16 11:03:55.933', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('5dd7bd19e4da3b2b99258d74b31ef290', 'in', '2026-09-16 11:04:07.547', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('cc48a60e6a2a3b0cb90df11b8c692115', 'in', '2026-09-16 11:04:13.754', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('53ed6d66d0713ac4ba48a75dbf6de898', 'out', '2026-09-16 11:04:34.989', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('bd891f22eb883e64b45db23c9a47d13f', 'out', '2026-09-16 11:05:16.739', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('d0766c89534832c39cec448a3656c5fc', 'in', '2026-09-16 11:05:20.038', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('550f39b9997a3b71a09accf9512d6c75', 'out', '2026-09-16 11:05:44.27', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('a0117ca6892e3d48aa00579cd7113394', 'in', '2026-09-16 11:06:55.153', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('cd30e6ccf53d3955a1c9d6595a9bd8af', 'in', '2026-09-16 11:07:03.163', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('30b99b91e60332df8882078496e6bc2f', 'in', '2026-09-16 11:07:20.786', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('5ba30dcfb6a23cc890670f432f29af19', 'out', '2026-09-16 11:07:27.196', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('608faef736dd338881cf4b0a035e9993', 'out', '2026-09-16 11:07:53.127', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('950a4c6ac82231aaa7fd1f53b3157de3', 'in', '2026-09-16 11:07:59.032', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('53a3ba5304123d59aae4caebc88d3a06', 'in', '2026-09-16 11:08:19.157', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('a719ed34785b3b0688cd94294c5eb1bd', 'out', '2026-09-16 11:08:20.761', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('d0b5444e2b4437a19ef7d72b6476863c', 'out', '2026-09-16 11:08:27.97', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('629432ef58cc3fa4898e97dac45de190', 'out', '2026-09-16 11:09:01.409', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('e349cde3c7ad369fb8639f27aa18f2f8', 'out', '2026-09-16 11:10:56.755', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('ee9abe5e68383bbf8212abfa299df513', 'out', '2026-09-16 11:11:08.268', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('c6f54671c7643d65a369f22a422794f1', 'in', '2026-09-16 11:11:16.076', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('f5a1c0c63c7f3d5eb54969237c47d3a7', 'in', '2026-09-16 11:11:31.595', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('2d3802b7f3273d2ea57a6df2dd29a134', 'out', '2026-09-16 11:12:08.642', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('7f3e94e27a11319ca4bec8e53360adf9', 'in', '2026-09-16 11:12:38.676', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('ef9cb95c94833dae9fbacc7f023bb009', 'in', '2026-09-16 11:13:24.834', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('21340190797639cd883beeaf62f3e764', 'out', '2026-09-16 11:14:27.915', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('b31c965a0b9334f1b5c55b34e227d1b0', 'in', '2026-09-16 11:14:31.923', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('3590005e04d23540a6cdec21efb03b69', 'in', '2026-09-16 11:14:43.136', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('87193267ac023c5e8d1fa08370d18712', 'out', '2026-09-16 11:14:56.15', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('16a0aa95f78331fc89e806c07f3489a5', 'in', '2026-09-16 11:16:05.734', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('3becf966a9de3f7083c4c8e84c7fee27', 'in', '2026-09-16 11:16:42.28', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('dd814ff1dad83a72acf47573e814c9fd', 'in', '2026-09-16 11:17:09.612', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('c9cc973668943756a1b09832ba3b84d3', 'out', '2026-09-16 11:17:10.812', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('7cc93cbe7e8c33cb98f02c44b58b9b94', 'in', '2026-09-16 11:17:31.345', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('7c86cbe468db3138b4ebc0cfe5db04a2', 'in', '2026-09-16 11:17:47.265', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('9a94389278233268ab97cbff0a45abeb', 'out', '2026-09-16 11:17:56.069', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('86781697437d39d88ed363184c3c69eb', 'out', '2026-09-16 11:18:01.577', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('e324c2ed2cbc36b4a36fd1592b2f3962', 'in', '2026-09-16 11:18:46.837', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('f562ffd59f7c3acf8feb00e99af8de18', 'in', '2026-09-16 11:18:56.25', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('8012bb1a94ef3eaa8c6d35b08ab49667', 'in', '2026-09-16 11:19:10.87', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('a15a543815b6371a974790353efb3058', 'out', '2026-09-16 11:20:05.835', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('60fda65ad4c236ff8753392d012abeea', 'out', '2026-09-16 11:20:12.944', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('d07a8e0f2748380e8f9306db5e7cce16', 'out', '2026-09-16 11:20:40.878', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('05b1155cd73e3ccbb2c1fc51c67c026b', 'in', '2026-09-16 11:20:46.292', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('1a85cbe0dff13469ba55103acb47094a', 'in', '2026-09-16 11:21:28.542', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('1a85cbe0dff13469ba55103acb47094a', 'out', '2026-09-16 11:21:37.053', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('0d635a0cafb53cd5831c7b8a53bb7741', 'out', '2026-09-16 11:21:44.354', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('d4113b245ebf3780ae94a4663fe37608', 'out', '2026-09-16 11:22:16.294', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('5a86badaf6af34ebbc9cac27bb268e1d', 'out', '2026-09-16 11:22:21.701', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('66e0c81406b935eaa297a0052c815a3f', 'in', '2026-09-16 11:22:31.524', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('9d524796d4d63bbb9092f1cabd7c6801', 'in', '2026-09-16 11:22:38.131', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('ed8ac133eef23b919028a108e40deea9', 'in', '2026-09-16 11:22:41.636', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('a005ee9344243356bce03fb675cedee2', 'out', '2026-09-16 11:23:33.289', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('5cc406c733653d128c36d742029d0435', 'in', '2026-09-16 11:24:37.777', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('88d2638e7fb93dcea6e6c8943c1716ec', 'in', '2026-09-16 11:24:56.799', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('57ee63ccc8953dbe83b750f1929d76d1', 'out', '2026-09-16 11:25:07.907', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('04b4df4aba7c3da4addc40ee370a586b', 'out', '2026-09-16 11:25:30.632', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('361b711d749b3e988f113394bd34e93d', 'in', '2026-09-16 11:26:34.517', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('a2c79006cce93250b3fe03e79ebe802d', 'in', '2026-09-16 11:26:48.935', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('e383e132071138d4a0304d8145326547', 'out', '2026-09-16 11:27:07.454', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('5462446f5fda344bbf4f847a07169741', 'in', '2026-09-16 11:27:15.768', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('66dd5284f0f939439db7d8e93bbfa483', 'in', '2026-09-16 11:27:30.684', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('4631466988c433fa8b274201664b6907', 'out', '2026-09-16 11:28:17.539', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('ef96cb23fc7d3c39b55beca3b66cc7fe', 'in', '2026-09-16 11:29:42.346', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('6d61ab8c06be34ddbe799a21018c31ed', 'out', '2026-09-16 11:30:21.993', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('0815d66af0c23975b94a962fb51a5a2e', 'out', '2026-09-16 11:32:10.723', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('9e7f63bcf3a93892afec6c75f33fa880', 'out', '2026-09-16 11:32:34.154', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('a5519833f5a636609351c8b0b82dd7aa', 'out', '2026-09-16 11:33:03.487', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('9b9f25e517bf3b35a635b922dd0c25e0', 'in', '2026-09-16 11:33:25.222', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('c2f33ec8d10b313283a5479ed8448a9f', 'in', '2026-09-16 11:34:01.867', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('3378136760ea3c22a810001c7ef2fef5', 'in', '2026-09-16 11:34:09.977', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('ffcd1dfcdb08313a8cb46001d43e0304', 'in', '2026-09-16 11:34:23.694', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('697b6bcdbc2537158c3b919696431a0a', 'in', '2026-09-16 11:34:40.614', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('953a7c834d403c3c862a0140919ca5f5', 'out', '2026-09-16 11:34:48.115', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('be1405c1eea73a5d8c7bf5d6f9060982', 'out', '2026-09-16 11:35:12.043', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('a387dcff55d43bea9eda1c515c35e2e2', 'out', '2026-09-16 11:35:15.647', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('5e89b75236b336c186fb9cc21ec03e9e', 'in', '2026-09-16 11:35:24.965', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('3d47c6a404563ef38445fed485e566fd', 'out', '2026-09-16 11:35:26.962', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('938dce440d093206a01083fb68081e4d', 'in', '2026-09-16 11:35:56.905', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('24047c8fba1d3298a48498c9402d3b4e', 'out', '2026-09-16 11:35:59.903', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('c21941f33c0a304b9f8cbd6064a6cf79', 'in', '2026-09-16 11:36:38.854', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('bd44f4863d7c32889c4e3319761a582e', 'out', '2026-09-16 11:37:15.096', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('bd44f4863d7c32889c4e3319761a582e', 'out', '2026-09-16 11:37:16.098', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('8b28e37d94d33b3e98a3ae947879d3d0', 'out', '2026-09-16 11:37:25.209', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('157ae9b627493ae49a5d48393914a9c8', 'in', '2026-09-16 11:37:45.937', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('a1f895bf13d43f5d81c3074e65fb1fc7', 'out', '2026-09-16 11:37:52.943', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('29df5788b27232519ea84fbf2b848ad9', 'in', '2026-09-16 11:38:23.082', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('7821f8d81ac637c2bb1925914d71dd80', 'in', '2026-09-16 11:38:40.603', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('79b55405a8ce3744abf204b8108993cb', 'out', '2026-09-16 11:38:48.311', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('7a5df923984d3ed4849f39dce52ae45a', 'in', '2026-09-16 11:39:35.772', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('7b92258e8e373383acdd857e9cfb2125', 'out', '2026-09-16 11:40:03.808', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('3447e7f9c3113bb8a28bdfa92b576777', 'out', '2026-09-16 11:40:18.025', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('9d005d0274fa330295f5a3dd5ca727b6', 'in', '2026-09-16 11:40:31.44', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('9ae3b89e969e34798d7df690373e255f', 'in', '2026-09-16 11:40:36.547', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('c317a84f2bb73d32b041f6879474df27', 'in', '2026-09-16 11:41:18.499', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('905f216f5bbe35b596f969f1ef0e305e', 'out', '2026-09-16 11:42:14.667', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('380f86ca08193f32838c32f1d61659d1', 'out', '2026-09-16 11:42:27.082', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('bdabf458bf993901ae3e340873fb3ac3', 'out', '2026-09-16 11:42:44.304', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('6151523f49b1355ba85a1d2b76fff0f7', 'out', '2026-09-16 11:42:53.013', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('05ef9b079ae73b31a0631364dad5e004', 'in', '2026-09-16 11:43:40.771', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('9443a1d163ba33be971a01b839e1d404', 'out', '2026-09-16 11:43:55.289', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('e2cee6fe6d4f32d0bef2913498d27135', 'in', '2026-09-16 11:44:09.104', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('04ee823315053535847f1b518ef28357', 'in', '2026-09-16 11:44:15.112', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('0eb7c387e5ef386a9151103fbe97e8ec', 'in', '2026-09-16 11:44:26.525', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('e9abf581e9e834a38f511e62c3af6b13', 'out', '2026-09-16 11:44:37.042', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('4692c37fc156372490b40d3bf2f3641f', 'out', '2026-09-16 11:45:08.98', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('d9b1f2b2d6e73ac3a1c03b1a94d14a97', 'in', '2026-09-16 11:46:38.993', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('6c29ecd64fb039af9db1608b1d0915f9', 'out', '2026-09-16 11:46:41.997', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('ef52c955964d38c892d8a41771b113dc', 'out', '2026-09-16 11:46:56.716', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('e6528cebd67d3d3590c52bf1a069653d', 'out', '2026-09-16 11:47:08.43', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('d721c599d1b2333ab4257edb55532b2b', 'out', '2026-09-16 11:49:05.976', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('9ed896b73ca03f3880cafac083740d3f', 'in', '2026-09-16 11:50:02.837', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('3607a48a3ef83da7bd2d15169acc9bce', 'in', '2026-09-16 11:51:03.413', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('684678e887fb3531b378b604ca93ca1b', 'in', '2026-09-16 11:51:35.052', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('a8aac98e380d3bd7929d832c6b182662', 'out', '2026-09-16 11:52:10.598', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('4c500e02adb23bf6a0f26fb0d6e9a27b', 'out', '2026-09-16 11:52:53.652', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('86c111d3b952343b8ff1c2f316a96700', 'in', '2026-09-16 11:55:06.216', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('e324c2ed2cbc36b4a36fd1592b2f3962', 'out', '2026-09-16 12:00:33.83', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('f09faf939a47391fb5224689940d22ec', 'in', '2026-09-16 12:00:51.252', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('3bed40b51f9e3c22b7a6566c89c52660', 'in', '2026-09-16 12:01:32.004', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('a4832e7a101f389e96d771a289c575b8', 'in', '2026-09-16 12:02:31.576', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('29fb106b49ee3af18a4946fb833768dd', 'out', '2026-09-16 12:02:54.187', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('4694236a4bcf3b1b8f9142787dee31cc', 'out', '2026-09-16 12:03:24.625', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('f6d0d5cbb8fb3a2e904b634bcf19e2c7', 'in', '2026-09-16 12:04:02.69', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('b010bfb666633b3596a614cbc2afb1a0', 'in', '2026-09-16 12:04:23.818', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('c6dcbce4252a3aa1b9d21ad15c9881ea', 'out', '2026-09-16 12:04:25.498', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('a7d7e7a105c63840bd5587aa0ca66828', 'out', '2026-09-16 12:05:01.241', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('87d550d5511530b5a2c5f58213cd20f8', 'in', '2026-09-16 12:06:28.666', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('f039699ebcbc31968e21744495c19007', 'in', '2026-09-16 12:07:19.328', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('6c7d8e0bcfb7352488088f4f3894ba56', 'out', '2026-09-16 12:07:43.238', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('9f1a4a7091bc32ffb9076e052e094d7e', 'out', '2026-09-16 12:07:49.344', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('087d7e695fd43199ab631e45f337aeea', 'in', '2026-09-16 12:08:55.652', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('523f833a5c653949881675d8a9411603', 'out', '2026-09-16 12:09:11.675', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('2b35ddce04a63bdbb77c6f639708f035', 'in', '2026-09-16 12:10:22.558', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('0d00a7cdc4bf308aad1cbaa52d85d18c', 'in', '2026-09-16 12:10:31.969', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('4f204047312e3c0fa89fb5b3e8123666', 'out', '2026-09-16 12:10:41.754', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('4c337d2a42ae3df39280dc05b8eeac94', 'out', '2026-09-16 12:10:57.973', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('828de82a4c3f3e6fbc68da916ff46aca', 'out', '2026-09-16 12:13:42.271', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('785b3081306a371998d2c6297052dbae', 'in', '2026-09-16 12:13:46.21', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('67993200e1f9390185bfc0c8ac15c2a8', 'out', '2026-09-16 12:14:10.504', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('406b3f49a33534b1993d395bd85e1e5e', 'in', '2026-09-16 12:14:19.652', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('267847ea9c35331c8cbaefd6d3cb0f6d', 'in', '2026-09-16 12:15:56.272', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('267847ea9c35331c8cbaefd6d3cb0f6d', 'out', '2026-09-16 12:16:02.179', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('4b4c9e25058c3ee081004bf04797749b', 'in', '2026-09-16 12:16:23.106', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('21ee6650dfe13a6b8e25b839545e6caf', 'out', '2026-09-16 12:16:24.672', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('8ef241178de931c5bf22d12f06e2c02f', 'out', '2026-09-16 12:16:40.59', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('867a793033ad3630a052d2067c43277b', 'out', '2026-09-16 12:17:07.622', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('ac13fac8b6253bb0a266d32595ee8a4e', 'out', '2026-09-16 12:17:15.732', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('eac95fb8388b3736b2bd0e54fa139716', 'out', '2026-09-16 12:17:35.557', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('0e1effcf33883813a1f461fbeb821ec5', 'in', '2026-09-16 12:18:35.371', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('c6f54671c7643d65a369f22a422794f1', 'out', '2026-09-16 12:19:12.317', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('c3743d407c4b3046b75ce36ab4d3d765', 'in', '2026-09-16 12:19:14.319', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('242755cb8a463f6badbde8fa82305fce', 'out', '2026-09-16 12:19:42.112', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('4acbc95f246a337099e860b931faaf2d', 'out', '2026-09-16 12:19:46.219', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('45560a303c213516958935b4fa0e2537', 'in', '2026-09-16 12:19:48.161', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('874c4038413f3cdc88e6fe86580c4330', 'in', '2026-09-16 12:20:20.4', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('ec163f26b7cf3f96bc9d1e915b466d18', 'in', '2026-09-16 12:20:36.179', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('fb72e08ad2a13ebe80faf49ab553ca5a', 'out', '2026-09-16 12:21:35.751', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('0a1b45c880773428b88f7e5b4982369c', 'out', '2026-09-16 12:23:22.285', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('98e2f2405f873f569d9d091eba0d1b7e', 'out', '2026-09-16 12:23:33.097', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('d80cae9c31b930fc999f84e3cb9f032d', 'in', '2026-09-16 12:24:02.676', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('83659c91451236daa021f4f5d9f629ab', 'out', '2026-09-16 12:25:01.3', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('c24308a22cfd373f8cb659c5628253c4', 'out', '2026-09-16 12:25:44.955', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('8f5d963538a83f3aa638ba7e9c95fa94', 'in', '2026-09-16 12:28:29.71', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('679d16865b803f44887fb5a44976b34d', 'out', '2026-09-16 12:28:52.586', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('4629ebbede993104b16396da1b05673d', 'in', '2026-09-16 12:29:04.055', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('ba012ff434d13e39b93175286354427c', 'in', '2026-09-16 12:29:12.963', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('98ea3f2945523bc6912b2288066c96ce', 'in', '2026-09-16 12:30:16.843', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('d89fcf21cd043756b44c3341012d0bf5', 'out', '2026-09-16 12:30:32.608', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('05ad224eca943c0ab445b34633af016e', 'in', '2026-09-16 12:30:42.576', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('4e1d6f9fd7e03a52a5642be4a3685329', 'in', '2026-09-16 12:31:02.002', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('28abf3282fb337d18cd513ed3bc6e62a', 'out', '2026-09-16 12:31:12.256', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('efc70cde51123f12b56cae567d58c0e0', 'out', '2026-09-16 12:31:22.268', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('9d038ed5ab0e327bad8b7d0d0f0964ca', 'in', '2026-09-16 12:31:25.231', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('a795fb7ed7123d5abf8d9ae3974b6a8a', 'out', '2026-09-16 12:31:40.592', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('a4573933c0b43abbb86f44c535ad7823', 'out', '2026-09-16 12:31:51.304', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('5b23e78db782376a903f866f057c0c86', 'out', '2026-09-16 12:35:43.006', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('bb7c5ad60af53ca0b4263acf6dc90477', 'out', '2026-09-16 12:35:50.254', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('34f6bbf8d2273daca475aa4da2c72ca6', 'in', '2026-09-16 12:35:53.057', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('b401a090347a3349bafc0894bfa8c1b3', 'in', '2026-09-16 12:36:39.016', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('424a89d007f3390ca109080ed2f44310', 'out', '2026-09-16 12:37:08.609', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('a2040c88081a308989157a1cf174933e', 'out', '2026-09-16 12:38:28.704', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('ff83bf56c0a2330f97e9849e75e07c14', 'out', '2026-09-16 12:38:43.521', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('7ff0684db8e23f0a88e248f54dacaf59', 'out', '2026-09-16 12:39:54.408', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('c784fe3b17f731aba20e5892650b44ee', 'out', '2026-09-16 12:40:25.148', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('8bd7bd19088a3af4b9f1867018b939a4', 'out', '2026-09-16 12:42:13.68', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('f6d0d5cbb8fb3a2e904b634bcf19e2c7', 'out', '2026-09-16 12:42:24.042', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('ba342aa2fde837e69427a6e8e94eec16', 'out', '2026-09-16 12:42:50.623', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('b2f353e302fc3b57875b23a9d2d90040', 'in', '2026-09-16 12:42:53.788', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('0bf6818e916139baa9b53338abb293c1', 'in', '2026-09-16 12:45:00.146', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('d1678ebcde5e3320b379837e06d96a3c', 'out', '2026-09-16 12:45:30.617', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('cf77b29aa87f395a8806536fd9f6bd87', 'out', '2026-09-16 12:46:22.68', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('cf77b29aa87f395a8806536fd9f6bd87', 'in', '2026-09-16 12:46:31.992', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('cf77b29aa87f395a8806536fd9f6bd87', 'out', '2026-09-16 12:47:10.438', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('fd713b2f5caf3db787f971b2cb45eafd', 'in', '2026-09-16 12:47:19.914', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('73b06f799124326ca5cd12091fb6a7e6', 'in', '2026-09-16 12:47:25.619', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('ad5c5e3235be35e9bbe537c4e167d2eb', 'out', '2026-09-16 12:47:33.466', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('0ce39302ad89394190087eba1401c346', 'out', '2026-09-16 12:48:06.306', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('4608630b8be237d7bfe0832839c9dbd4', 'out', '2026-09-16 12:48:29.534', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('dd4fe1eebb843e6e8fb64ac5524c4e15', 'in', '2026-09-16 12:53:27.193', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('938e343eb3a33091b8919ec0034a24f3', 'out', '2026-09-16 12:56:08.291', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('7aa5e5240c78389aa210265e5da589d3', 'in', '2026-09-16 12:57:11.843', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('3d3458f8f5f1397bbdd0e44db707ba5b', 'out', '2026-09-16 12:57:38.699', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('5013889f1425301597d668993e2a9a04', 'in', '2026-09-16 12:58:32.444', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('c14c37e6625e3648aef7aef2c751b8f4', 'out', '2026-09-16 13:03:07.183', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('bf9cdf8f2aa83329b36556521614d836', 'in', '2026-09-16 13:03:42.431', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('80bd68b71c333b52910b76f2fd014fbb', 'in', '2026-09-16 13:08:11.963', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('d76ec6731caf32d19c1068531101200a', 'out', '2026-09-16 13:08:31.996', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('67d0f91c035035718c31495cff929f7a', 'out', '2026-09-16 13:09:16.642', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('7915d9dc62a233ef87e5f368b5705942', 'in', '2026-09-16 13:16:49.995', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('24ea5cc740ab358b82ed695103388046', 'in', '2026-09-16 13:16:58.205', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('af1ea4ecedf53929a5adf1edf1db9afc', 'out', '2026-09-16 13:18:05.598', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('7c71091f431f3d79ac2ed0bc10de0ef2', 'in', '2026-09-16 13:20:05.238', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('4b854230ab263effa55d6431379fef01', 'in', '2026-09-16 13:20:20.254', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('c64a6771d62f32ac9ae275fd993d595c', 'out', '2026-09-16 13:20:51.814', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('14ea7bfbef8a3ab0981200107115ec78', 'in', '2026-09-16 13:22:55.347', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('473db1e83876361292b7b121f95e67de', 'in', '2026-09-16 13:23:06.36', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('8cfe82335ce337c68ccccf4371633ae1', 'out', '2026-09-16 13:23:31.711', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('ec163f26b7cf3f96bc9d1e915b466d18', 'out', '2026-09-16 13:27:53.729', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('e037d3bc302231489e5d4cf82e583c1e', 'in', '2026-09-16 13:28:05.936', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('461e9b2142813877903b9a90db78ff31', 'out', '2026-09-16 13:28:22.263', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('1a71a7b63c7b30d19a965180d48540a6', 'in', '2026-09-16 13:28:24.667', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('ade20cd91d013565b012f2706090bca5', 'out', '2026-09-16 13:30:28.013', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('d240260f98823a8bbe16d274f77947d0', 'in', '2026-09-16 13:30:58.547', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('a63da335d47e3f399ebe2ffda014475b', 'out', '2026-09-16 13:31:25.186', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('697216509eee32e1acbb8d25b1fa7ffa', 'in', '2026-09-16 13:31:27.48', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('352ee08b29a93baf9cd84a3073463e25', 'in', '2026-09-16 13:31:57.518', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('8fa2b03105a03db181074b5a2d7f51ae', 'out', '2026-09-16 13:32:15.546', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('dd4fe1eebb843e6e8fb64ac5524c4e15', 'out', '2026-09-16 13:32:39.375', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('18ee885b683e3d3583746714053b2d69', 'out', '2026-09-16 13:34:30.215', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('9a813f4fbd5035a2a37b2d55aabe7d86', 'out', '2026-09-16 13:35:44.506', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('dfef32a5fef8367db06ab203a671efd7', 'in', '2026-09-16 13:36:06.427', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('7d43ef9e0fa538088c8c467b5ebe3e2b', 'out', '2026-09-16 13:36:23.153', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('d240260f98823a8bbe16d274f77947d0', 'out', '2026-09-16 13:37:31.028', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('bca71b95db653982962b632d5f56d92c', 'in', '2026-09-16 13:40:11.823', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('645cce597e5a328ea18fd8b0bf40d302', 'out', '2026-09-16 13:40:20.042', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('d5a57577379d3da4afae5810860c1a49', 'in', '2026-09-16 13:41:05.488', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('575063824b373139abc86f6e4d19f2fa', 'in', '2026-09-16 13:41:27.122', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('49bf43502f9633bcb60cfd25c5bfbad8', 'out', '2026-09-16 13:43:07.342', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('759610a07a053207b0cf5c329353ce9a', 'out', '2026-09-16 13:43:36.179', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('a573914ff4763b97a4830c365f39ecbf', 'out', '2026-09-16 13:44:21.033', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('b0523c6e81d53392affd647141bdd312', 'in', '2026-09-16 13:47:56.592', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('4e3ce397b8fb39959101dba767dbfc7b', 'in', '2026-09-16 13:49:27.205', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('1304adcb4d8030bf9d1b14d41372fb54', 'out', '2026-09-16 13:50:42.804', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('88aee00e3211373a9657a8396b1343fa', 'in', '2026-09-16 13:50:56.013', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('ce428949ff9d365b99a6fd50caf0b4e9', 'in', '2026-09-16 13:57:47.326', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('ce428949ff9d365b99a6fd50caf0b4e9', 'out', '2026-09-16 13:57:51.531', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('ce428949ff9d365b99a6fd50caf0b4e9', 'in', '2026-09-16 13:57:54.734', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('08763e770ae13b729800824d91547339', 'in', '2026-09-16 13:59:08.625', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('76f308734d513722a18cb26ae96c6117', 'in', '2026-09-16 14:00:21.718', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('f327bf5615eb33538d1e117d662ca76a', 'in', '2026-09-16 14:01:05.572', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('a98a1382c53a314e878940dd8e9e1d1a', 'out', '2026-09-16 14:01:11.776', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('415d66e906353db394802b2780b8c100', 'in', '2026-09-16 14:02:19.165', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('7fc6dbae6fc3302185c5baffffa02fb7', 'in', '2026-09-16 14:02:54.508', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('0f2c4bfefa5939bd979144d9574279a8', 'out', '2026-09-16 14:03:17.031', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('936f99b21a4e3c0fae30bf489ae078dc', 'out', '2026-09-16 14:03:58.181', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('5013889f1425301597d668993e2a9a04', 'out', '2026-09-16 14:03:59.489', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('f9aa772de67f3c7b8b5f58abea037706', 'in', '2026-09-16 14:05:14.482', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('7bcdf3989d023774a10109f2e051cbe9', 'in', '2026-09-16 14:06:39.384', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('deef0d2fe18f326580ab9e350bbdd3ec', 'in', '2026-09-16 14:06:49.296', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('08db860f1e1f369f8972fe1188ca7124', 'out', '2026-09-16 14:07:08.314', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('4b09bfd3ee443bd295ae7d6a3b24dffd', 'in', '2026-09-16 14:07:25.639', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('e2e3440b670533549c3610eb9b25c911', 'out', '2026-09-16 14:08:43.532', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('ce428949ff9d365b99a6fd50caf0b4e9', 'out', '2026-09-16 14:09:30.588', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('caa67541d3ae3d4fa71f4eae0575f5eb', 'in', '2026-09-16 14:10:09.238', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('1bf962d05f633233872cc11db5b3a4ab', 'out', '2026-09-16 14:10:11.543', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('64cea694b2413100bd9ed77ac45df8ed', 'in', '2026-09-16 14:11:39.246', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('8f26228a814e399880c9a5861fb90ff5', 'in', '2026-09-16 14:11:43.751', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('cae4ef948d533fe5bf9c56d6d1c41ec9', 'out', '2026-09-16 14:11:44.255', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('07d2d1ce8d643a379823606ecd7270c6', 'in', '2026-09-16 14:11:48.658', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('bc5b7ebf4a4c3cf083b507b41b9ee554', 'in', '2026-09-16 14:13:25.076', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('1004d6412d0a330088e03df028e2f5ea', 'in', '2026-09-16 14:14:00.92', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('feaa5699e7d4301494998c4881a5db2f', 'out', '2026-09-16 14:14:03.225', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('7a3adeceeb4f362f9b8dc1133fa54d39', 'out', '2026-09-16 14:14:26.654', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('55ca803392d6360a980ccffb09c2dcc1', 'in', '2026-09-16 14:14:28.255', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('06d76a35b3a437d6940a7d6cd0ed857c', 'in', '2026-09-16 14:14:43.576', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('16765dba785f349985d3f84b73357924', 'in', '2026-09-16 14:15:43.349', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('06df7911bbc530658935d0d5eb01a4eb', 'in', '2026-09-16 14:16:00.469', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('8ab70a57983c39488294d2d55ce29cf0', 'in', '2026-09-16 14:17:26.375', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('afd0ea19706a3ebf984e22d4e8dd03e5', 'in', '2026-09-16 14:17:41.393', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('afd0ea19706a3ebf984e22d4e8dd03e5', 'out', '2026-09-16 14:17:44.998', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('e53bf9d314a73b2ca05253bb52cac3f8', 'in', '2026-09-16 14:19:08.604', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('fffa1d52a9113fddb93aeecfdb1ef5c9', 'in', '2026-09-16 14:19:20.518', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('c0c26087ae833309aac083a66b3e2609', 'in', '2026-09-16 14:19:29.929', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('05f5c33df3473e9da4529b2ad5f6347d', 'in', '2026-09-16 14:19:36.437', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('32342e9e902a368e8d0f8b668bce8ff6', 'in', '2026-09-16 14:22:02.218', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('32342e9e902a368e8d0f8b668bce8ff6', 'out', '2026-09-16 14:22:12.531', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('580b48fea9723d59a61b247ae87eb92f', 'in', '2026-09-16 14:22:54.582', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('246b7585a6463837871dceb864857348', 'out', '2026-09-16 14:23:14.899', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('9a5f7e1ea00d38689d8b91374b6a5071', 'in', '2026-09-16 14:23:50.35', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('044f01f38fc63fe284e67c163f0b5231', 'out', '2026-09-16 14:24:23.882', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('deef0d2fe18f326580ab9e350bbdd3ec', 'out', '2026-09-16 14:25:18.152', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('fcfb0aa650203c309a089223da4add03', 'in', '2026-09-16 14:25:35.975', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('f427efa66ccc3954b47802238db732db', 'out', '2026-09-16 14:26:23.433', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('7491ede5003a34acb31a6ec763e1ebe2', 'in', '2026-09-16 14:26:47.862', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('5efeb7639b723236854a4541a839ae49', 'in', '2026-09-16 14:27:02.88', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('45a91a4403793986be644dbaa8f346fa', 'out', '2026-09-16 14:27:44.634', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('1a71a7b63c7b30d19a965180d48540a6', 'out', '2026-09-16 14:27:56.748', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('05e9734ee59c373f8e506b02528ae70b', 'in', '2026-09-16 14:28:12.867', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('ee52953d80e736c9ba5dc92acc4afc5e', 'in', '2026-09-16 14:28:27.584', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('10621260556734c29840a18c4bd62122', 'in', '2026-09-16 14:28:54.62', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('1243fc7d838a38b3987b45be009ee77e', 'in', '2026-09-16 14:28:59.126', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('e47be4ff0a643072bd519464b6ca644e', 'in', '2026-09-16 14:29:36.771', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('1485b80a13d9300d894d511af6f75032', 'in', '2026-09-16 14:29:48.988', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('94599ca4f26732e9848fa671f4a41aea', 'out', '2026-09-16 14:29:57.798', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('3e194d5b91e83f6f8868c99c6b0eb02b', 'in', '2026-09-16 14:30:20.827', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('e00a1d64f69a32009412c9adea17f25c', 'out', '2026-09-16 14:30:33.741', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('a07af0b6bbeb3cf79ce06369b5adeec0', 'out', '2026-09-16 14:30:48.458', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('2b5e8d8706db3a34b6a3fd0dbb779283', 'in', '2026-09-16 14:31:13.291', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('9983e832813838e698865389c8255984', 'in', '2026-09-16 14:31:25.103', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('ae7176daee2032b7bb8fcf209c6902a7', 'in', '2026-09-16 14:32:01.254', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('d69aa46c805e370c8e9fc1c8478dbaf3', 'in', '2026-09-16 14:32:38.496', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('84812cafa6fe37f4a055101a81f9434b', 'out', '2026-09-16 14:33:07.227', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('510c51b2a2933b7aad82ff08193edab5', 'out', '2026-09-16 14:33:51.581', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('9983e832813838e698865389c8255984', 'out', '2026-09-16 14:34:39.54', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('bf0c5afbe99830cc8fb1ab3024b29fb9', 'in', '2026-09-16 14:34:40.651', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('aff18e6dfcac30e191f786bcc35f4722', 'in', '2026-09-16 14:34:49.162', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('423c052cb13a36a1873fd20474dd841b', 'out', '2026-09-16 14:35:58.139', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('5ef059fa078d323e942405b4df87edf9', 'in', '2026-09-16 14:36:11.061', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('c65632e130b73554b2033775a6b17830', 'out', '2026-09-16 14:36:22.269', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('e1eca4beb1d33072acb2e48aa87ddb50', 'out', '2026-09-16 14:36:26.975', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('e2fb55063ef637719ec685d15ca219b8', 'in', '2026-09-16 14:37:01.225', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('98f18e16fd50320980d66127c8514451', 'in', '2026-09-16 14:37:25.952', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('3ac9ddeec1573190a8f17cf72eee0b2f', 'out', '2026-09-16 14:37:34.756', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('e6bd312258d431d7be51944aedfdf37a', 'out', '2026-09-16 14:37:56.283', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('e4aabe495454333880d1fb4542221f4a', 'in', '2026-09-16 14:38:13.81', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('fb96770d5eb431abaa1f3099c3db5f69', 'out', '2026-09-16 14:38:22.315', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('0db7cb95614f37b3a1ed3d293990ad62', 'out', '2026-09-16 14:38:37.332', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('29acfd382bb73a82a88a300f0e14dc0a', 'out', '2026-09-16 14:38:43.94', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('9f2f919b7ebc3733934f98cabc711bd0', 'in', '2026-09-16 14:38:57.965', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('9998c7e3a5233b06a545a0fb26d93379', 'in', '2026-09-16 14:39:05.574', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('9b5a4870825539f384e3ff2e1fff7758', 'in', '2026-09-16 14:40:06.05', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('61b287d44aa83acd9d2c02b2c12d91c6', 'out', '2026-09-16 14:40:50.795', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('c0bf67cf2ac335b88b0d352b8cbf1960', 'in', '2026-09-16 14:40:51.808', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('98713329a5a93a4a8bbaf537cd0af697', 'in', '2026-09-16 14:41:05.723', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('e647d71ca6ae36ff84f38f0735ab2160', 'out', '2026-09-16 14:41:39.254', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('f19f9fd4c7d3304190ad06c33877281e', 'in', '2026-09-16 14:41:53.18', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('a882cb78ea1b3456b31401c0c933b63f', 'out', '2026-09-16 14:42:20.704', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('3bcb23017df53a1f8458d510315d04b1', 'in', '2026-09-16 14:44:08.942', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('99ff655660a9343da34ed87b0d5ca5d7', 'out', '2026-09-16 14:45:41.748', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('24047485fe9b3857bcafc8f3ebb56ce1', 'in', '2026-09-16 14:46:15.097', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('236239dfde3733619d4d18846ca8a5ed', 'out', '2026-09-16 14:46:47.628', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('505c6353721832e2b5d71ddff14d3ae1', 'out', '2026-09-16 14:46:57.04', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('536c5cc1ff263c5a9d9eb6adf20e176e', 'in', '2026-09-16 14:47:26.783', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('1b7030f788b23458b27a819f5c5fb29f', 'in', '2026-09-16 14:47:33.992', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('a4d8742eb0473ac6b6d6eaa19095ea09', 'in', '2026-09-16 14:47:38.89', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('b2f353e302fc3b57875b23a9d2d90040', 'out', '2026-09-16 14:47:43.503', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('a4d8742eb0473ac6b6d6eaa19095ea09', 'out', '2026-09-16 14:47:43.694', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('0b3791c331a634318a66c015d256be14', 'out', '2026-09-16 14:47:53.005', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('45fb33ba13d4358799aea78f484cc503', 'out', '2026-09-16 14:47:56.81', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('9337800949a63c7ba3c1e0025ce9dc14', 'in', '2026-09-16 14:48:07.332', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('590d1506df45347db17e9b905568beb1', 'in', '2026-09-16 14:48:18.948', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('1e60ad3fe8c13af483faa42240af5ef4', 'out', '2026-09-16 14:48:42.067', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('0b76db33b5b4304e842443c8dd42700d', 'in', '2026-09-16 14:49:41.051', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('d3dd7885cb1e388db55031265f1a7e66', 'out', '2026-09-16 14:50:02.461', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('51103dc3e5013cba84dc1fb7cfe26ca3', 'in', '2026-09-16 14:52:20.441', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('8d215aeb66a83c6e893b858b0e965a4d', 'out', '2026-09-16 14:53:02.379', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('23ab278f62043337b4f794b3f737b4f4', 'in', '2026-09-16 14:53:32.932', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('1c936eacfe953fdea7a9490df224f460', 'in', '2026-09-16 14:53:46.949', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('a20a56f5b4d63c2f93f8f48a5eceb28a', 'in', '2026-09-16 14:53:58.563', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('c38864845ecc3051a38b66cc5dc6df90', 'out', '2026-09-16 14:53:59.649', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('731570bcfe96378c97ec0cadecbc2f4b', 'in', '2026-09-16 14:54:03.069', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('c38864845ecc3051a38b66cc5dc6df90', 'in', '2026-09-16 14:54:06.257', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('c38864845ecc3051a38b66cc5dc6df90', 'out', '2026-09-16 14:54:09.463', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('6bd17bbcbd3b337faaac518c1969f1e5', 'out', '2026-09-16 14:54:17.871', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('69d983f574713da187380d0482f8ed5a', 'out', '2026-09-16 14:54:43.305', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('5847643956193b208ccefa19b1119a1f', 'in', '2026-09-16 14:55:22.071', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('5a0a76b5e1eb350680e977d9d7166814', 'in', '2026-09-16 14:56:47.479', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('c0c2bbcc4d323adca4e0eb5f38e98f6b', 'out', '2026-09-16 14:56:53.67', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('8ab28ecd8e763a498ef9b2f02b0891b7', 'out', '2026-09-16 14:57:09.588', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('c8e13690f58632b09a65fcdffeb5d0a0', 'out', '2026-09-16 14:57:13.292', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('efea9ed78c133bb99596505108fc923f', 'in', '2026-09-16 14:57:22.824', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('3a6b8be630853f57a8d9e534e2fc8d59', 'out', '2026-09-16 14:57:40.025', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('a276d1cbd5003010972eb5d751cca527', 'out', '2026-09-16 14:58:10.063', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('68befe3fac823f7a9bc265b1717a8e34', 'in', '2026-09-16 14:59:24.173', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('73ec8b23852e37188ab1707e7faa19b9', 'in', '2026-09-16 14:59:30.082', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('3fdca828e85633f4971f673e370b669b', 'in', '2026-09-16 14:59:34.686', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('453bfaf1a8d9393689bb9257139ea9e6', 'in', '2026-09-16 14:59:39.393', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('b097a64e11ef3192b774dcacdd81b54a', 'in', '2026-09-16 14:59:56.914', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('1469474c41573321b08461acdebf2737', 'out', '2026-09-16 14:59:57.299', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('23c0b5325a4c395683e39a3c7dfc647b', 'out', '2026-09-16 15:00:02.306', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('d05b25dc1ad830ae9a39c09b5ed85c1f', 'out', '2026-09-16 15:00:13.119', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('8ade979c17d63779888807359b6f8626', 'in', '2026-09-16 15:00:28.653', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('b67c6607ceaa3e3680d4d252e094537d', 'out', '2026-09-16 15:00:32.844', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('2d390e1523f83b3485c1a5539ffedf08', 'in', '2026-09-16 15:00:46.776', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('8837badb09c1397daf50f6120e9b453c', 'in', '2026-09-16 15:01:10.502', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('0482b733bdef3b75a4985f754a2664d7', 'in', '2026-09-16 15:01:18.012', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('a8059a557fda319cac8e0f452b61e405', 'out', '2026-09-16 15:02:22.881', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('815bb532e78936dea05fe0e0a194e0fb', 'in', '2026-09-16 15:02:35.506', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('634d8a2962af3203aa935df4879e9e5a', 'out', '2026-09-16 15:03:33.372', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('29d53a573cae34399a2ca1fc23ccfea5', 'out', '2026-09-16 15:03:38.779', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('4a783dc919e03969ba2e9a7628ee34c0', 'out', '2026-09-16 15:03:46.389', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('3f85e1ab4be839ee91a0a4292b7f2ad0', 'in', '2026-09-16 15:03:55.104', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('575d71b4991732d88d4f4705e8d19918', 'out', '2026-09-16 15:04:15.925', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('29873423a9c43840a40b048b2f16ae1d', 'out', '2026-09-16 15:05:13.099', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('2b02c57d15c03590b5bf57abfca1cdff', 'out', '2026-09-16 15:05:17.806', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('2b02c57d15c03590b5bf57abfca1cdff', 'in', '2026-09-16 15:05:23.813', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('366667d3a8923a088a55a88803843156', 'in', '2026-09-16 15:06:04.27', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('23a770640e21393f96b4bf855e860349', 'in', '2026-09-16 15:06:19.488', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('f88ac3cc92a53e3ea3187e8127becc1d', 'in', '2026-09-16 15:06:42.817', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('ee6c20a2ba443d6b961eb6a45ca96141', 'out', '2026-09-16 15:07:13.452', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('8d117837087e3e6eb06df95735578d41', 'in', '2026-09-16 15:07:15.458', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('ee7f2ec2bf9c307bb100a00f47157488', 'out', '2026-09-16 15:07:24.065', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('dd5d285031593dff85352511353a5d76', 'out', '2026-09-16 15:07:58.512', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('2a826eedd4c231adaaa90e952513e128', 'in', '2026-09-16 15:09:16.716', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('15b6f59ba3bc3db0910021c14ab3cd6c', 'in', '2026-09-16 15:09:51.357', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('83215ff2e3e13f9492417e0501a0764a', 'in', '2026-09-16 15:10:00.168', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('81c87ed6343b3c0fab09ece3f598fb1d', 'out', '2026-09-16 15:10:08.081', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('800e171050ab3e6bb2c8e3bf616e047d', 'in', '2026-09-16 15:10:51.241', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('35a8243c70a13492925e745fa2d9fda5', 'out', '2026-09-16 15:12:20.347', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('0154eb5fdeb63be5b327598add825fc3', 'in', '2026-09-16 15:12:21.555', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('1962f8efcd6f363c81bbef24a5e94e6c', 'out', '2026-09-16 15:12:45.178', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('f229dc51e1b73f21b5324f135639e3a7', 'in', '2026-09-16 15:13:02.608', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('48f05fc7fd543defbb16ed83ef62ea1e', 'out', '2026-09-16 15:13:06.007', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('210fdb805509302cb43e3975f12ea4bf', 'out', '2026-09-16 15:13:31.336', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('133449e44c4039d29c4a01be9497f5a6', 'in', '2026-09-16 15:14:04.192', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('a92ad58364073fb78546b882708b24c0', 'out', '2026-09-16 15:14:23.705', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('61a2c32a1f21319d8acb0ebe3f9ecce2', 'in', '2026-09-16 15:15:12.781', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('a8ae1f659e193a15bfa8858b59659ec4', 'out', '2026-09-16 15:15:35.197', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('3669621be18f38d7b0b858c9d78f0fd0', 'out', '2026-09-16 15:16:02.032', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('3f4cb879da913c6c9a988dcfde6cfc09', 'out', '2026-09-16 15:16:28.166', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('54b7824528bd3b8582fa8fb1562c1233', 'in', '2026-09-16 15:16:36.088', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('1bd33014a310317d999d6907b6dbd961', 'out', '2026-09-16 15:17:17.129', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('9a375f0485a734a08d4e2e826510132e', 'in', '2026-09-16 15:17:18.64', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('89e6ecea7d1c3854972a20cf9998a881', 'out', '2026-09-16 15:17:34.95', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('08057bb4f988369ebb47b9d25dfefd4b', 'in', '2026-09-16 15:17:46.778', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('ef971a1700003f6cb642b0c942eb9f49', 'in', '2026-09-16 15:17:58.894', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('7de094238907376191ced9ff98041618', 'in', '2026-09-16 15:18:27.029', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('2fb233c5fde83d489e96ebc74d60c885', 'in', '2026-09-16 15:18:38.944', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('b46598816b1836008919caaf243fe076', 'out', '2026-09-16 15:19:07.172', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('e7e7eaa2517936e3b942c9077b7df426', 'out', '2026-09-16 15:19:22.991', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('a75e3c4e899630188eb9fb52ff01d1f1', 'out', '2026-09-16 15:19:48.723', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('40f77a2f3b1f3c20bedeb4ff80840f2b', 'in', '2026-09-16 15:20:04.457', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('485bce71ba7a31a68c62552bcd65c756', 'in', '2026-09-16 15:20:18.174', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('4c68b7d3e13f302f989330277ec31c45', 'in', '2026-09-16 15:20:25.082', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('cff5948488ba32d5911c314e60c6e0e5', 'out', '2026-09-16 15:21:00.215', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('a9c8383165c7304e965ad2c81bfcb5a1', 'out', '2026-09-16 15:21:13.832', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('6f30ac3ddce038a397b6eb82b060b5ca', 'out', '2026-09-16 15:21:21.844', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('cfcd5459052f3dd7a734ced382afceab', 'in', '2026-09-16 15:22:04.908', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('9a8426ef4a52345cba4415150bc1cc5f', 'in', '2026-09-16 15:22:10.916', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('c55d2bc6be7f3b54a84b2e318dfc9819', 'in', '2026-09-16 15:22:28.839', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('1d239deebeea3baf9b7818f8f87b0d3c', 'out', '2026-09-16 15:22:32.334', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('21cf51a3b19c386bbf6b5b5c8cd28191', 'out', '2026-09-16 15:23:05.676', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('1124314a0415300ab64fabdcb0d585e8', 'out', '2026-09-16 15:23:08.379', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('4bbd9a984d2d3b17a164c3538b9dfe0e', 'in', '2026-09-16 15:23:19.105', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('0346b854bd983873b37bdbf95fac519c', 'in', '2026-09-16 15:23:28.318', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('c2146ac4d5513085bff5c5a411e1a210', 'in', '2026-09-16 15:23:33.723', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('927d165c580d3f198a8043f842f8be38', 'out', '2026-09-16 15:23:46.829', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('d911ca1f59f131dd8c2d95ea51a78319', 'in', '2026-09-16 15:23:51.045', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('35f14a10641834ff8b701397d9204de1', 'out', '2026-09-16 15:24:09.258', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('9df4c100634e377dae0669d49a623163', 'in', '2026-09-16 15:24:17.377', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('a782e4b37fef3b8c94af72c5dd0f12e2', 'out', '2026-09-16 15:25:25.266', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('c79ab0886f333f7d9ef6cadd926bbc27', 'out', '2026-09-16 15:25:26.856', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('fc282e27bcb03f31ac2351ce55267b8f', 'out', '2026-09-16 15:25:29.76', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('1295c286598c3671b01a74655571319e', 'in', '2026-09-16 15:25:36.783', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('f84d90ef2f243df1923f034ca94bd632', 'in', '2026-09-16 15:25:43.509', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('eac49778cb733256a6724c611660aafe', 'in', '2026-09-16 15:27:03.312', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('be71ac5388f931a985c11141761da695', 'out', '2026-09-16 15:27:12.593', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('e142e13f9da03154827ea28391ad97f5', 'in', '2026-09-16 15:27:27.342', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('ec254450db2b36e4a0f1a57d291cff70', 'out', '2026-09-16 15:27:29.515', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('dc57feb67e373f2b804026facdf912f5', 'out', '2026-09-16 15:27:38.726', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('4a2aabd7dfc63377ac3d296b7b074e29', 'in', '2026-09-16 15:27:39.958', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('24a625e72d5537ce85a0921dd9f61ac7', 'out', '2026-09-16 15:28:02.757', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('a26fa933d124384db3945d258374e6bc', 'out', '2026-09-16 15:28:11.467', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('3b151baa8e053f85bc0d161449458c75', 'out', '2026-09-16 15:28:23.381', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('a9a94a86bab435b7816c19414b5fb4fd', 'in', '2026-09-16 15:29:31.117', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('89e397b41c5d365a8b7388cb61373de3', 'out', '2026-09-16 15:29:47.486', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('9f5ec4ff95c9399fb728ad43c0eb46ec', 'out', '2026-09-16 15:30:34.848', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('48665c1b6e4234539be22d55e19ba53f', 'out', '2026-09-16 15:31:19.203', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('0a8f4242bb5d3c4cbbda07b2e53aed9e', 'in', '2026-09-16 15:31:34.275', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('419211517bfe3a00a926ac1a17784dd6', 'in', '2026-09-16 15:32:16.429', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('0f2645c9d57e3b528486bc891bb7a755', 'in', '2026-09-16 15:32:24.837', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('fca7394906a330adaf5048328fbdb5a4', 'out', '2026-09-16 15:32:54.727', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('178023056e783d51bf85197e9ea46d57', 'out', '2026-09-16 15:34:17.533', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('a2e194630df231f5be1b77b4609911ee', 'out', '2026-09-16 15:35:07.396', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('61ed69adc8fc3259af6f779549a2aea0', 'in', '2026-09-16 15:35:51.901', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('6e4190710f7936bb85331168b052a4c3', 'in', '2026-09-16 15:35:55.606', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('88b8338d87273ac1ace2905cc1e7a6d1', 'in', '2026-09-16 15:36:00.511', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('c2f237eb44133ce5b9f45aa27711f15c', 'out', '2026-09-16 15:36:17.886', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('9b1efe251d433527b9677906fc8d3ace', 'out', '2026-09-16 15:36:22.293', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('553add8d5fbb316b957ba8b990ed28fc', 'in', '2026-09-16 15:36:32.552', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('d53bd0f089253e14bd8a22abacb41596', 'in', '2026-09-16 15:36:39.761', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('bb49135653293d36b72c48a3721d3873', 'out', '2026-09-16 15:36:45.22', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('1b0f4698d6213828a85ff9ea9c613220', 'out', '2026-09-16 15:37:10.253', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('0f5882745c603d59b928dae4cdea0aa4', 'out', '2026-09-16 15:37:17.361', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('66245a3a398537f0a71768dc7a0e95a1', 'in', '2026-09-16 15:37:19.811', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('c5b453717da3301094215751fff2bd97', 'out', '2026-09-16 15:37:37.488', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('f5400024c3c33849957f63dcda7c27b6', 'in', '2026-09-16 15:38:11.575', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('b3666d3e26ed39fe99cf6df0ae19ce7e', 'out', '2026-09-16 15:38:43.572', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('1e4bdbff42743987858ba43e85973b4e', 'in', '2026-09-16 15:39:49.597', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('8a5d5fd54ff93750ad4815931e1bc945', 'out', '2026-09-16 15:40:21.397', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('6b4876c726e13a98b018bb08715aea4f', 'in', '2026-09-16 15:41:05.599', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('06a415a8d5de368bb048c8d50f824186', 'out', '2026-09-16 15:41:17.166', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('162d9d269da33d4b8dc732fdb7a94826', 'in', '2026-09-16 15:41:18.415', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('0b358869124638778cb3f76819c51536', 'out', '2026-09-16 15:41:21.872', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('162d9d269da33d4b8dc732fdb7a94826', 'out', '2026-09-16 15:41:22.42', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('464124a4f9c9368b9732e7a050e7c6ee', 'in', '2026-09-16 15:41:30.471', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('0cbcaef066f33dc684a2840a9c8f41af', 'out', '2026-09-16 15:41:30.982', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('6e89d2f650ee335e9db3bcb23d2626ea', 'in', '2026-09-16 15:42:26.443', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('6a15185ebea73e06bc9342a6f354eb6b', 'in', '2026-09-16 15:42:41.863', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('4d5444646e3534ee8b3b630dead56a95', 'out', '2026-09-16 15:42:53.684', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('52e28775cb7e3924b65bde4ad1f4e978', 'in', '2026-09-16 15:43:09.598', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('9e4d2b0c9df735d4be740df984612903', 'in', '2026-09-16 15:43:23.818', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('67f9dc9c1e403785b653ea5418fb18a0', 'out', '2026-09-16 15:43:37.74', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('f528de3bc70231bfb71126fd75d2ce77', 'out', '2026-09-16 15:43:54.461', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('f528de3bc70231bfb71126fd75d2ce77', 'in', '2026-09-16 15:44:00.87', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('827bbc9d193f3836b97fa44722e7c0d4', 'in', '2026-09-16 15:44:16.687', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('23b8e9ec2df634ff8187500bb3bd8943', 'out', '2026-09-16 15:44:19.792', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('f6c616633c1634eda84153c4912b4382', 'in', '2026-09-16 15:44:22.995', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('e44b848ce7473578922a05480b956cfa', 'in', '2026-09-16 15:44:28.701', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('5508dde6ede6391e9f9a269bd8bbed9e', 'in', '2026-09-16 15:45:13.862', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('783a07e534a9325abb34425d214e9611', 'in', '2026-09-16 15:46:45.18', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('783a07e534a9325abb34425d214e9611', 'out', '2026-09-16 15:46:51.489', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('0d35184da5c839a9800fd520bd7645c6', 'in', '2026-09-16 15:48:03.787', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('6b1bcad2d38f339c8d0750d384f39a76', 'out', '2026-09-16 15:48:11.099', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('f5a3cfe660533a97a05bc35edfec6404', 'in', '2026-09-16 15:49:19.883', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('fe4fc87afc9f3294b258eeb7e93c653e', 'in', '2026-09-16 15:49:37.204', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('a71a11f3e15032c09aac67b5ef790164', 'out', '2026-09-16 15:49:43.115', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('8c77f7f6cec03415adaabdc6a48765fc', 'in', '2026-09-16 15:50:29.371', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('ae58c6079bcb33a9baf66fcf17c11fb4', 'out', '2026-09-16 15:50:35.582', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('596cf4e52f1e3fa9b836c1ac43d8f005', 'in', '2026-09-16 15:50:52.4', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('2b02c57d15c03590b5bf57abfca1cdff', 'out', '2026-09-16 15:50:52.602', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('618a4e0f718932f28ebdb21cbf0c620f', 'out', '2026-09-16 15:50:58.811', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('618a4e0f718932f28ebdb21cbf0c620f', 'in', '2026-09-16 15:51:02.916', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('a4da8d726c6739799d334774637bf000', 'out', '2026-09-16 15:51:42.867', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('99871f87b9563752af0adc5b82f5cbf5', 'in', '2026-09-16 15:51:56.984', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('5bf08a2d1d1a3fbab1d482a8b1a2cc08', 'out', '2026-09-16 15:52:14.509', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('c004ed30d9ae3c008ea8c61e9d550c94', 'in', '2026-09-16 15:52:32.829', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('94682f1de0923c69befe92f3f8552cf2', 'out', '2026-09-16 15:52:37.943', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('003f379a008c3c3b8d831ec8a391a8a6', 'in', '2026-09-16 15:53:01.966', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('a4783e85d4c63abe8b1cf5b107a1cf4b', 'out', '2026-09-16 15:54:48.414', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('45351018302f3fac80103d4329b31850', 'out', '2026-09-16 15:54:59.028', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('f00c8fe059ed3cb19021656f40451f60', 'in', '2026-09-16 15:55:29.955', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('4e3ce397b8fb39959101dba767dbfc7b', 'out', '2026-09-16 15:57:56.441', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('19d8e3c951643f40a628cea622993c4e', 'in', '2026-09-16 15:58:17.266', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('ff6e8619a63432b38afd7f1a668ceec0', 'in', '2026-09-16 15:59:07.63', 2, 10);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('c01e01f08a1835458c78c92dd7e693c3', 'out', '2026-09-16 15:59:34.569', 2, 14);
INSERT INTO public.linecrossing (object_id, direction, crossing_time, object_class_id, metadata_id) VALUES ('496cdd2afc9432569f044bfe571af28f', 'out', '2026-09-16 15:59:40.977', 2, 14);


--
-- Data for Name: objectclass; Type: TABLE DATA; Schema: public; Owner: analytics
--

INSERT INTO public.objectclass (name, class_id) VALUES ('car', 2);


--
-- Name: bgw_job_id_seq; Type: SEQUENCE SET; Schema: _timescaledb_catalog; Owner: analytics
--

SELECT pg_catalog.setval('_timescaledb_catalog.bgw_job_id_seq', 1000, false);


--
-- Name: chunk_column_stats_id_seq; Type: SEQUENCE SET; Schema: _timescaledb_catalog; Owner: analytics
--

SELECT pg_catalog.setval('_timescaledb_catalog.chunk_column_stats_id_seq', 1, false);


--
-- Name: chunk_id_seq; Type: SEQUENCE SET; Schema: _timescaledb_catalog; Owner: analytics
--

SELECT pg_catalog.setval('_timescaledb_catalog.chunk_id_seq', 188, true);


--
-- Name: dimension_id_seq; Type: SEQUENCE SET; Schema: _timescaledb_catalog; Owner: analytics
--

SELECT pg_catalog.setval('_timescaledb_catalog.dimension_id_seq', 2, true);


--
-- Name: dimension_slice_id_seq; Type: SEQUENCE SET; Schema: _timescaledb_catalog; Owner: analytics
--

SELECT pg_catalog.setval('_timescaledb_catalog.dimension_slice_id_seq', 188, true);


--
-- Name: hypertable_id_seq; Type: SEQUENCE SET; Schema: _timescaledb_catalog; Owner: analytics
--

SELECT pg_catalog.setval('_timescaledb_catalog.hypertable_id_seq', 2, true);


--
-- Name: coordinate_id_seq; Type: SEQUENCE SET; Schema: public; Owner: analytics
--

SELECT pg_catalog.setval('public.coordinate_id_seq', 1, false);


--
-- Name: metadata_id_seq; Type: SEQUENCE SET; Schema: public; Owner: analytics
--

SELECT pg_catalog.setval('public.metadata_id_seq', 79, true);


--
-- Name: flyway_schema_history flyway_schema_history_pk; Type: CONSTRAINT; Schema: public; Owner: analytics
--

ALTER TABLE ONLY public.flyway_schema_history
    ADD CONSTRAINT flyway_schema_history_pk PRIMARY KEY (installed_rank);


--
-- Name: flyway_schema_history_timescale flyway_schema_history_timescale_pk; Type: CONSTRAINT; Schema: public; Owner: analytics
--

ALTER TABLE ONLY public.flyway_schema_history_timescale
    ADD CONSTRAINT flyway_schema_history_timescale_pk PRIMARY KEY (installed_rank);


--
-- Name: objectclass objectclass_pkey; Type: CONSTRAINT; Schema: public; Owner: analytics
--

ALTER TABLE ONLY public.objectclass
    ADD CONSTRAINT objectclass_pkey PRIMARY KEY (class_id);



--
-- Name: areaoccupancy_occupancy_time_idx; Type: INDEX; Schema: public; Owner: analytics
--

CREATE INDEX areaoccupancy_occupancy_time_idx ON public.areaoccupancy USING btree (occupancy_time DESC);


--
-- Name: flyway_schema_history_s_idx; Type: INDEX; Schema: public; Owner: analytics
--

CREATE INDEX flyway_schema_history_s_idx ON public.flyway_schema_history USING btree (success);


--
-- Name: flyway_schema_history_timescale_s_idx; Type: INDEX; Schema: public; Owner: analytics
--

CREATE INDEX flyway_schema_history_timescale_s_idx ON public.flyway_schema_history_timescale USING btree (success);


--
-- Name: linecrossing_crossing_time_idx; Type: INDEX; Schema: public; Owner: analytics
--

CREATE INDEX linecrossing_crossing_time_idx ON public.linecrossing USING btree (crossing_time DESC);


--
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: pg_database_owner
--

REVOKE USAGE ON SCHEMA public FROM PUBLIC;
GRANT ALL ON SCHEMA public TO PUBLIC;

