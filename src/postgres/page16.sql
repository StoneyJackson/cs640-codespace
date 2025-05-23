--
-- PostgreSQL database dump
--

-- Dumped from database version 11.3 (Debian 11.3-1.pgdg90+1)
-- Dumped by pg_dump version 11.3 (Debian 11.3-1.pgdg90+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: cities; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cities (
    name text NOT NULL,
    postal_code character varying(9) NOT NULL,
    country_code character(2) NOT NULL,
    CONSTRAINT cities_postal_code_check CHECK (((postal_code)::text <> ''::text))
);


ALTER TABLE public.cities OWNER TO postgres;

--
-- Name: countries; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.countries (
    country_code character(2) NOT NULL,
    country_name text
);


ALTER TABLE public.countries OWNER TO postgres;

--
-- Name: venues; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.venues (
    venue_id integer NOT NULL,
    name character varying(255),
    street_address text,
    type character(7) DEFAULT 'public'::bpchar,
    postal_code character varying(9),
    country_code character(2),
    CONSTRAINT venues_type_check CHECK ((type = ANY (ARRAY['public'::bpchar, 'private'::bpchar])))
);


ALTER TABLE public.venues OWNER TO postgres;

--
-- Name: venues_venue_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.venues_venue_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.venues_venue_id_seq OWNER TO postgres;

--
-- Name: venues_venue_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.venues_venue_id_seq OWNED BY public.venues.venue_id;


--
-- Name: venues venue_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.venues ALTER COLUMN venue_id SET DEFAULT nextval('public.venues_venue_id_seq'::regclass);


--
-- Data for Name: cities; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.cities (name, postal_code, country_code) FROM stdin;
Portland	97206	us
\.


--
-- Data for Name: countries; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.countries (country_code, country_name) FROM stdin;
us	United States
mx	Mexico
au	Australia
gb	United Kingdom
de	Germany
\.


--
-- Data for Name: venues; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.venues (venue_id, name, street_address, type, postal_code, country_code) FROM stdin;
1	Crystal Ballroom	\N	public 	97206	us
2	Voodoo Doughnut	\N	public 	97206	us
\.


--
-- Name: venues_venue_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.venues_venue_id_seq', 2, true);


--
-- Name: cities cities_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cities
    ADD CONSTRAINT cities_pkey PRIMARY KEY (country_code, postal_code);


--
-- Name: countries countries_country_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.countries
    ADD CONSTRAINT countries_country_name_key UNIQUE (country_name);


--
-- Name: countries countries_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.countries
    ADD CONSTRAINT countries_pkey PRIMARY KEY (country_code);


--
-- Name: venues venues_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.venues
    ADD CONSTRAINT venues_pkey PRIMARY KEY (venue_id);


--
-- Name: cities cities_country_code_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cities
    ADD CONSTRAINT cities_country_code_fkey FOREIGN KEY (country_code) REFERENCES public.countries(country_code);


--
-- Name: venues venues_country_code_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.venues
    ADD CONSTRAINT venues_country_code_fkey FOREIGN KEY (country_code, postal_code) REFERENCES public.cities(country_code, postal_code) MATCH FULL;


--
-- PostgreSQL database dump complete
--

