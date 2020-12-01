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
1	0
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

SELECT pg_catalog.setval('public.cart_id_seq', 33, true);


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
-- PostgreSQL database dump complete
--

