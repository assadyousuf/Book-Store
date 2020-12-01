--
-- PostgreSQL database dump
--

-- Dumped from database version 12.5
-- Dumped by pg_dump version 13.1

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

SET default_table_access_method = heap;

--
-- Name: author; Type: TABLE; Schema: public; Owner: assadyousuf
--

CREATE TABLE public.author (
    id integer NOT NULL,
    firstname character varying(32),
    lastname character varying(32)
);


ALTER TABLE public.author OWNER TO assadyousuf;

--
-- Name: author_id_seq; Type: SEQUENCE; Schema: public; Owner: assadyousuf
--

CREATE SEQUENCE public.author_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.author_id_seq OWNER TO assadyousuf;

--
-- Name: author_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: assadyousuf
--

ALTER SEQUENCE public.author_id_seq OWNED BY public.author.id;


--
-- Name: book; Type: TABLE; Schema: public; Owner: assadyousuf
--

CREATE TABLE public.book (
    isbn character varying(15) NOT NULL,
    publisher integer NOT NULL,
    name character varying(63),
    description character varying(256),
    edition character varying(256),
    noofpages integer,
    price character varying,
    CONSTRAINT book_isbn_check CHECK (((isbn)::text <> ''::text))
);


ALTER TABLE public.book OWNER TO assadyousuf;

--
-- Name: cart; Type: TABLE; Schema: public; Owner: assadyousuf
--

CREATE TABLE public.cart (
    id integer NOT NULL,
    total character varying
);


ALTER TABLE public.cart OWNER TO assadyousuf;

--
-- Name: cart_id_seq; Type: SEQUENCE; Schema: public; Owner: assadyousuf
--

CREATE SEQUENCE public.cart_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.cart_id_seq OWNER TO assadyousuf;

--
-- Name: cart_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: assadyousuf
--

ALTER SEQUENCE public.cart_id_seq OWNED BY public.cart.id;


--
-- Name: currentlyincart; Type: TABLE; Schema: public; Owner: assadyousuf
--

CREATE TABLE public.currentlyincart (
    id integer NOT NULL,
    isbn character varying(15),
    uniqeid integer NOT NULL
);


ALTER TABLE public.currentlyincart OWNER TO assadyousuf;

--
-- Name: currentlyincart_uniqeid_seq; Type: SEQUENCE; Schema: public; Owner: assadyousuf
--

CREATE SEQUENCE public.currentlyincart_uniqeid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.currentlyincart_uniqeid_seq OWNER TO assadyousuf;

--
-- Name: currentlyincart_uniqeid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: assadyousuf
--

ALTER SEQUENCE public.currentlyincart_uniqeid_seq OWNED BY public.currentlyincart.uniqeid;


--
-- Name: genre; Type: TABLE; Schema: public; Owner: assadyousuf
--

CREATE TABLE public.genre (
    id integer NOT NULL,
    name character varying(15)
);


ALTER TABLE public.genre OWNER TO assadyousuf;

--
-- Name: genre_id_seq; Type: SEQUENCE; Schema: public; Owner: assadyousuf
--

CREATE SEQUENCE public.genre_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.genre_id_seq OWNER TO assadyousuf;

--
-- Name: genre_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: assadyousuf
--

ALTER SEQUENCE public.genre_id_seq OWNED BY public.genre.id;


--
-- Name: has; Type: TABLE; Schema: public; Owner: assadyousuf
--

CREATE TABLE public.has (
    username character varying(15) NOT NULL,
    id integer NOT NULL
);


ALTER TABLE public.has OWNER TO assadyousuf;

--
-- Name: hasgenre; Type: TABLE; Schema: public; Owner: assadyousuf
--

CREATE TABLE public.hasgenre (
    id integer NOT NULL,
    isbn character varying(15) NOT NULL,
    CONSTRAINT hasgenre_isbn_check CHECK (((isbn)::text <> ''::text))
);


ALTER TABLE public.hasgenre OWNER TO assadyousuf;

--
-- Name: hasseries; Type: TABLE; Schema: public; Owner: assadyousuf
--

CREATE TABLE public.hasseries (
    id integer NOT NULL,
    isbn character varying(15) NOT NULL,
    CONSTRAINT hasseries_isbn_check CHECK (((isbn)::text <> ''::text))
);


ALTER TABLE public.hasseries OWNER TO assadyousuf;

--
-- Name: ordertable; Type: TABLE; Schema: public; Owner: assadyousuf
--

CREATE TABLE public.ordertable (
    id integer NOT NULL,
    address character varying(50),
    books text[],
    total double precision,
    username character varying(50)
);


ALTER TABLE public.ordertable OWNER TO assadyousuf;

--
-- Name: ordertable_id_seq; Type: SEQUENCE; Schema: public; Owner: assadyousuf
--

CREATE SEQUENCE public.ordertable_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.ordertable_id_seq OWNER TO assadyousuf;

--
-- Name: ordertable_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: assadyousuf
--

ALTER SEQUENCE public.ordertable_id_seq OWNED BY public.ordertable.id;


--
-- Name: publisher; Type: TABLE; Schema: public; Owner: assadyousuf
--

CREATE TABLE public.publisher (
    id integer NOT NULL,
    name character varying(63),
    publishdate date
);


ALTER TABLE public.publisher OWNER TO assadyousuf;

--
-- Name: publisher_id_seq; Type: SEQUENCE; Schema: public; Owner: assadyousuf
--

CREATE SEQUENCE public.publisher_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.publisher_id_seq OWNER TO assadyousuf;

--
-- Name: publisher_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: assadyousuf
--

ALTER SEQUENCE public.publisher_id_seq OWNED BY public.publisher.id;


--
-- Name: series; Type: TABLE; Schema: public; Owner: assadyousuf
--

CREATE TABLE public.series (
    id integer NOT NULL,
    name character varying(63)
);


ALTER TABLE public.series OWNER TO assadyousuf;

--
-- Name: series_id_seq; Type: SEQUENCE; Schema: public; Owner: assadyousuf
--

CREATE SEQUENCE public.series_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.series_id_seq OWNER TO assadyousuf;

--
-- Name: series_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: assadyousuf
--

ALTER SEQUENCE public.series_id_seq OWNED BY public.series.id;


--
-- Name: useraccount; Type: TABLE; Schema: public; Owner: assadyousuf
--

CREATE TABLE public.useraccount (
    username character varying(15) NOT NULL,
    password character varying(128)
);


ALTER TABLE public.useraccount OWNER TO assadyousuf;

--
-- Name: writtenby; Type: TABLE; Schema: public; Owner: assadyousuf
--

CREATE TABLE public.writtenby (
    isbn character varying(15) NOT NULL,
    authorid integer
);


ALTER TABLE public.writtenby OWNER TO assadyousuf;

--
-- Name: author id; Type: DEFAULT; Schema: public; Owner: assadyousuf
--

ALTER TABLE ONLY public.author ALTER COLUMN id SET DEFAULT nextval('public.author_id_seq'::regclass);


--
-- Name: cart id; Type: DEFAULT; Schema: public; Owner: assadyousuf
--

ALTER TABLE ONLY public.cart ALTER COLUMN id SET DEFAULT nextval('public.cart_id_seq'::regclass);


--
-- Name: currentlyincart uniqeid; Type: DEFAULT; Schema: public; Owner: assadyousuf
--

ALTER TABLE ONLY public.currentlyincart ALTER COLUMN uniqeid SET DEFAULT nextval('public.currentlyincart_uniqeid_seq'::regclass);


--
-- Name: genre id; Type: DEFAULT; Schema: public; Owner: assadyousuf
--

ALTER TABLE ONLY public.genre ALTER COLUMN id SET DEFAULT nextval('public.genre_id_seq'::regclass);


--
-- Name: ordertable id; Type: DEFAULT; Schema: public; Owner: assadyousuf
--

ALTER TABLE ONLY public.ordertable ALTER COLUMN id SET DEFAULT nextval('public.ordertable_id_seq'::regclass);


--
-- Name: publisher id; Type: DEFAULT; Schema: public; Owner: assadyousuf
--

ALTER TABLE ONLY public.publisher ALTER COLUMN id SET DEFAULT nextval('public.publisher_id_seq'::regclass);


--
-- Name: series id; Type: DEFAULT; Schema: public; Owner: assadyousuf
--

ALTER TABLE ONLY public.series ALTER COLUMN id SET DEFAULT nextval('public.series_id_seq'::regclass);


--
-- Data for Name: author; Type: TABLE DATA; Schema: public; Owner: assadyousuf
--

COPY public.author (id, firstname, lastname) FROM stdin;
1	apple	applaud
2	banana	bonanza
3	chris	cockadoodledoo
4	denver	dindin
5	epsilon	elephonso
6	fred	flintstone
7	greg	giraffe
8	heaven	halberto
9	ivan	imaginary
10	john	johnson
\.


--
-- Data for Name: book; Type: TABLE DATA; Schema: public; Owner: assadyousuf
--

COPY public.book (isbn, publisher, name, description, edition, noofpages, price) FROM stdin;
1231234512345	1	Battle of the Bulge	montes nascetur ridiculus mus etiam vel augue vestibulum rutrum rutrum	1	1000	55.45
1231234512348	1	Margarets Museum	orci pede venenatis non sodales sed tincidunt eu felis fusce posuere felis	1	543	55.45
1231234512351	1	Pompatus of Love, The	pede lobortis ligula sit amet eleifend pede libero	1	432	55.45
1231234512354	1	Adventures of Sharkboy and Lavagirl 3-D, The	nec nisi volutpat eleifend donec ut dolor morbi	1	728	55.45
1231234512346	2	Replacement Killers, The	gravida sem praesent id massa id	1	923	45.25
1231234512357	2	Submarine	sodales sed tincidunt eu felis fusce posuere felis sed lacus morbi sem mauris	1	696	45.25
1231234512347	3	How to Survive a Plague	ut erat curabitur gravida nisi at nibh in hac habitasse platea dictumst	6	723	60
1231234512349	3	Skippy	vitae consectetuer eget rutrum at lorem integer	1	166	60
1231234512360	3	Maiden Heist, The	duis at velit eu est congue elementum	1	1000	60
1231234512352	4	Prizzis Honor	pellentesque eget nunc donec quis orci eget orci vehicula condimentum curabitur in libero	1	117	30
1231234512358	4	Twin Falls Idaho	ante ipsum primis in faucibus orci luctus et ultrices posuere	1	1234	30
1231234512350	5	Ballerina (La mort du cygne)	ligula sit amet eleifend pede libero quis orci nullam molestie	3	93	25.15
1231234512355	5	Jindabyne	felis fusce posuere felis sed lacus morbi sem mauris	1	319	25.15
1231234512359	6	The Missouri Breaks	molestie sed justo pellentesque viverra pede ac diam cras pellentesque volutpat	1	445	15
1231234512361	6	Between the Devil and the Deep Blue Sea	nisi venenatis tristique fusce congue diam id ornare imperdiet sapien	1	744	15
1231234512365	6	I Hate Christian Laettner	in quam fringilla rhoncus mauris enim leo rhoncus sed vestibulum sit amet	1	613	15
1231234512353	7	Small Cuts (Petites coupures)	risus semper porta volutpat quam pede lobortis ligula	1	261	10.2
1231234512364	7	Loser Takes All, The (O hamenos ta pairnei ola)	quam sollicitudin vitae consectetuer eget rutrum at lorem integer tincidunt	1	192	10.2
1231234512363	8	Crocodile Dundee in Los Angeles	turpis adipiscing lorem vitae mattis nibh ligula nec	2	200	45
1231234512356	9	Innocent, The (Innocente, L)	tempor convallis nulla neque libero convallis eget eleifend luctus ultricies	4	532	75
1231234512362	9	Happy People: A Year in the Taiga	leo odio porttitor id consequat in consequat ut nulla sed accumsan felis ut	1	278	75
\.


--
-- Data for Name: cart; Type: TABLE DATA; Schema: public; Owner: assadyousuf
--

COPY public.cart (id, total) FROM stdin;
4	0
5	0
6	0
7	0
8	0
9	0
10	0
11	0
12	0
13	0
2	0
1	0.0
\.


--
-- Data for Name: currentlyincart; Type: TABLE DATA; Schema: public; Owner: assadyousuf
--

COPY public.currentlyincart (id, isbn, uniqeid) FROM stdin;
\.


--
-- Data for Name: genre; Type: TABLE DATA; Schema: public; Owner: assadyousuf
--

COPY public.genre (id, name) FROM stdin;
1	Romance
2	Action
3	Thriller
4	Horror
5	Psychological
6	Comedy
7	Mature
8	Erotic
9	Science Fiction
10	Fantasy
11	Science
12	Mathematics
13	Physics
14	Tutorial
15	Catalog
\.


--
-- Data for Name: has; Type: TABLE DATA; Schema: public; Owner: assadyousuf
--

COPY public.has (username, id) FROM stdin;
cdalfaro	1
sarthak	2
tumancio	4
yuelin	5
admin	6
rip	7
sha256	8
tuxedo	9
macistrash	10
xxhacker69xx	11
eatthis	12
nerfthis	13
\.


--
-- Data for Name: hasgenre; Type: TABLE DATA; Schema: public; Owner: assadyousuf
--

COPY public.hasgenre (id, isbn) FROM stdin;
1	1231234512345
2	1231234512346
3	1231234512347
4	1231234512348
5	1231234512349
6	1231234512350
7	1231234512351
8	1231234512352
9	1231234512353
10	1231234512354
11	1231234512355
12	1231234512356
13	1231234512357
14	1231234512358
15	1231234512359
6	1231234512360
1	1231234512361
2	1231234512362
3	1231234512363
4	1231234512364
5	1231234512365
\.


--
-- Data for Name: hasseries; Type: TABLE DATA; Schema: public; Owner: assadyousuf
--

COPY public.hasseries (id, isbn) FROM stdin;
1	1231234512345
2	1231234512346
3	1231234512347
4	1231234512348
5	1231234512349
6	1231234512350
7	1231234512351
8	1231234512352
9	1231234512353
10	1231234512354
11	1231234512355
12	1231234512356
13	1231234512357
14	1231234512358
15	1231234512359
16	1231234512360
1	1231234512361
2	1231234512362
3	1231234512363
4	1231234512364
5	1231234512365
\.


--
-- Data for Name: ordertable; Type: TABLE DATA; Schema: public; Owner: assadyousuf
--

COPY public.ordertable (id, address, books, total, username) FROM stdin;
10	Tempe	{"Prizzis Honor","Prizzis Honor"}	120	cdalfaro
\.


--
-- Data for Name: publisher; Type: TABLE DATA; Schema: public; Owner: assadyousuf
--

COPY public.publisher (id, name, publishdate) FROM stdin;
1	Herzog-Hermann	2020-02-09
2	Ryan, Nitzsche and Little	1912-10-21
3	Kemmer-Hoeger	2010-12-12
4	Walter, Grimes and Kirlin	1912-12-10
5	Wehner Group	1993-08-30
6	Batz and Sons	1940-01-06
7	Kshlerin Inc	1974-12-03
8	Huels, Schamberger and Wilderman	1974-04-08
9	Bernier-Purdy	1923-09-09
\.


--
-- Data for Name: series; Type: TABLE DATA; Schema: public; Owner: assadyousuf
--

COPY public.series (id, name) FROM stdin;
1	The land before time
3	Waterland
4	Small Town Murder Songs
5	Antboy
6	Bullet in the Head
7	Grace
9	Mighty Aphrodite
10	Riders of the Purple Sage
11	Brazilian Western (Faroeste Caboclo)
12	Bad Guy (Nabbeun namja)
13	Fatherland
14	Accident (Yi ngoi)
15	I Want You
16	Rain Over Santiago (Il pleut sur Santiago)
8	In Praise of Love (Eloge de lamour)
2	Killer (Tueur a gages)
\.


--
-- Data for Name: useraccount; Type: TABLE DATA; Schema: public; Owner: assadyousuf
--

COPY public.useraccount (username, password) FROM stdin;
cdalfaro	Admin
sarthak	Admin
tumancio	Admin
yuelin	Admin
admin	Admin
rip	Admin
sha256	Admin
tuxedo	Admin
macistrash	Admin
xxhacker69xx	Admin
eatthis	Admin
nerfthis	Admin
\.


--
-- Data for Name: writtenby; Type: TABLE DATA; Schema: public; Owner: assadyousuf
--

COPY public.writtenby (isbn, authorid) FROM stdin;
1231234512345	1
1231234512346	2
1231234512347	3
1231234512348	4
1231234512349	5
1231234512350	6
1231234512351	7
1231234512352	8
1231234512353	9
1231234512354	10
1231234512355	9
1231234512356	8
1231234512357	7
1231234512358	6
1231234512359	5
1231234512360	4
1231234512361	3
1231234512362	2
1231234512363	1
1231234512364	2
1231234512365	3
\.


--
-- Name: author_id_seq; Type: SEQUENCE SET; Schema: public; Owner: assadyousuf
--

SELECT pg_catalog.setval('public.author_id_seq', 10, true);


--
-- Name: cart_id_seq; Type: SEQUENCE SET; Schema: public; Owner: assadyousuf
--

SELECT pg_catalog.setval('public.cart_id_seq', 32, true);


--
-- Name: currentlyincart_uniqeid_seq; Type: SEQUENCE SET; Schema: public; Owner: assadyousuf
--

SELECT pg_catalog.setval('public.currentlyincart_uniqeid_seq', 35, true);


--
-- Name: genre_id_seq; Type: SEQUENCE SET; Schema: public; Owner: assadyousuf
--

SELECT pg_catalog.setval('public.genre_id_seq', 15, true);


--
-- Name: ordertable_id_seq; Type: SEQUENCE SET; Schema: public; Owner: assadyousuf
--

SELECT pg_catalog.setval('public.ordertable_id_seq', 10, true);


--
-- Name: publisher_id_seq; Type: SEQUENCE SET; Schema: public; Owner: assadyousuf
--

SELECT pg_catalog.setval('public.publisher_id_seq', 9, true);


--
-- Name: series_id_seq; Type: SEQUENCE SET; Schema: public; Owner: assadyousuf
--

SELECT pg_catalog.setval('public.series_id_seq', 16, true);


--
-- Name: author author_pkey; Type: CONSTRAINT; Schema: public; Owner: assadyousuf
--

ALTER TABLE ONLY public.author
    ADD CONSTRAINT author_pkey PRIMARY KEY (id);


--
-- Name: book book_pkey; Type: CONSTRAINT; Schema: public; Owner: assadyousuf
--

ALTER TABLE ONLY public.book
    ADD CONSTRAINT book_pkey PRIMARY KEY (isbn);


--
-- Name: cart cart_pkey; Type: CONSTRAINT; Schema: public; Owner: assadyousuf
--

ALTER TABLE ONLY public.cart
    ADD CONSTRAINT cart_pkey PRIMARY KEY (id);


--
-- Name: currentlyincart currentlyincart_pkey; Type: CONSTRAINT; Schema: public; Owner: assadyousuf
--

ALTER TABLE ONLY public.currentlyincart
    ADD CONSTRAINT currentlyincart_pkey PRIMARY KEY (uniqeid);


--
-- Name: genre genre_pkey; Type: CONSTRAINT; Schema: public; Owner: assadyousuf
--

ALTER TABLE ONLY public.genre
    ADD CONSTRAINT genre_pkey PRIMARY KEY (id);


--
-- Name: has has_pkey; Type: CONSTRAINT; Schema: public; Owner: assadyousuf
--

ALTER TABLE ONLY public.has
    ADD CONSTRAINT has_pkey PRIMARY KEY (username);


--
-- Name: hasgenre hasgenre_pkey; Type: CONSTRAINT; Schema: public; Owner: assadyousuf
--

ALTER TABLE ONLY public.hasgenre
    ADD CONSTRAINT hasgenre_pkey PRIMARY KEY (id, isbn);


--
-- Name: hasseries hasseries_pkey; Type: CONSTRAINT; Schema: public; Owner: assadyousuf
--

ALTER TABLE ONLY public.hasseries
    ADD CONSTRAINT hasseries_pkey PRIMARY KEY (id, isbn);


--
-- Name: ordertable ordertable_pkey; Type: CONSTRAINT; Schema: public; Owner: assadyousuf
--

ALTER TABLE ONLY public.ordertable
    ADD CONSTRAINT ordertable_pkey PRIMARY KEY (id);


--
-- Name: publisher publisher_pkey; Type: CONSTRAINT; Schema: public; Owner: assadyousuf
--

ALTER TABLE ONLY public.publisher
    ADD CONSTRAINT publisher_pkey PRIMARY KEY (id);


--
-- Name: series series_pkey; Type: CONSTRAINT; Schema: public; Owner: assadyousuf
--

ALTER TABLE ONLY public.series
    ADD CONSTRAINT series_pkey PRIMARY KEY (id);


--
-- Name: useraccount useraccount_pkey; Type: CONSTRAINT; Schema: public; Owner: assadyousuf
--

ALTER TABLE ONLY public.useraccount
    ADD CONSTRAINT useraccount_pkey PRIMARY KEY (username);


--
-- Name: writtenby writtenby_pkey; Type: CONSTRAINT; Schema: public; Owner: assadyousuf
--

ALTER TABLE ONLY public.writtenby
    ADD CONSTRAINT writtenby_pkey PRIMARY KEY (isbn);


--
-- Name: book book_publisher_fkey; Type: FK CONSTRAINT; Schema: public; Owner: assadyousuf
--

ALTER TABLE ONLY public.book
    ADD CONSTRAINT book_publisher_fkey FOREIGN KEY (publisher) REFERENCES public.publisher(id);


--
-- Name: currentlyincart currentlyincart_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: assadyousuf
--

ALTER TABLE ONLY public.currentlyincart
    ADD CONSTRAINT currentlyincart_id_fkey FOREIGN KEY (id) REFERENCES public.cart(id);


--
-- Name: currentlyincart currentlyincart_isbn_fkey; Type: FK CONSTRAINT; Schema: public; Owner: assadyousuf
--

ALTER TABLE ONLY public.currentlyincart
    ADD CONSTRAINT currentlyincart_isbn_fkey FOREIGN KEY (isbn) REFERENCES public.book(isbn);


--
-- Name: has has_cartid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: assadyousuf
--

ALTER TABLE ONLY public.has
    ADD CONSTRAINT has_cartid_fkey FOREIGN KEY (id) REFERENCES public.cart(id);


--
-- Name: hasgenre hasgenre_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: assadyousuf
--

ALTER TABLE ONLY public.hasgenre
    ADD CONSTRAINT hasgenre_id_fkey FOREIGN KEY (id) REFERENCES public.genre(id);


--
-- Name: hasgenre hasgenre_isbn_fkey; Type: FK CONSTRAINT; Schema: public; Owner: assadyousuf
--

ALTER TABLE ONLY public.hasgenre
    ADD CONSTRAINT hasgenre_isbn_fkey FOREIGN KEY (isbn) REFERENCES public.book(isbn);


--
-- Name: hasseries hasseries_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: assadyousuf
--

ALTER TABLE ONLY public.hasseries
    ADD CONSTRAINT hasseries_id_fkey FOREIGN KEY (id) REFERENCES public.series(id);


--
-- Name: hasseries hasseries_isbn_fkey; Type: FK CONSTRAINT; Schema: public; Owner: assadyousuf
--

ALTER TABLE ONLY public.hasseries
    ADD CONSTRAINT hasseries_isbn_fkey FOREIGN KEY (isbn) REFERENCES public.book(isbn);


--
-- Name: writtenby writtenby_authorid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: assadyousuf
--

ALTER TABLE ONLY public.writtenby
    ADD CONSTRAINT writtenby_authorid_fkey FOREIGN KEY (authorid) REFERENCES public.author(id);


--
-- Name: writtenby writtenby_isbn_fkey; Type: FK CONSTRAINT; Schema: public; Owner: assadyousuf
--

ALTER TABLE ONLY public.writtenby
    ADD CONSTRAINT writtenby_isbn_fkey FOREIGN KEY (isbn) REFERENCES public.book(isbn);


--
-- PostgreSQL database dump complete
--

