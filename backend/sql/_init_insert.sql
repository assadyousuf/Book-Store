INSERT INTO Publisher
 (name, publishDate) 
VALUES
 ('Herzog-Hermann', '2020-02-09'),
 ('Ryan, Nitzsche and Little', '1912-10-21'),
 ('Kemmer-Hoeger', '2010-12-12'),
 ('Walter, Grimes and Kirlin', '1912-12-10'),
 ('Wehner Group', '1993-08-30'),
 ('Batz and Sons', '1940-01-06'),
 ('Kshlerin Inc', '1974-12-03'),
 ('Huels, Schamberger and Wilderman', '1974-04-08'),
 ('Bernier-Purdy', '1923-09-09');

INSERT INTO Series
 (name)
VALUES
 ('The land before time'),
 ('Killer (Tueur à gages)'),
 ('Waterland'),
 ('Small Town Murder Songs'),
 ('Antboy'),
 ('Bullet in the Head'),
 ('Grace'),
 ('In Praise of Love (Éloge de lamour)'),
 ('Mighty Aphrodite'),
 ('Riders of the Purple Sage'),
 ('Brazilian Western (Faroeste Caboclo)'),
 ('Bad Guy (Nabbeun namja)'),
 ('Fatherland'),
 ('Accident (Yi ngoi)'),
 ('I Want You'),
 ('Rain Over Santiago (Il pleut sur Santiago)');

INSERT INTO Genre
 (name)
VALUES
 ('Romance'),
 ('Action'),
 ('Thriller'),
 ('Horror'),
 ('Psychological'),
 ('Comedy'),
 ('Mature'),
 ('Erotic'),
 ('Science Fiction'),
 ('Fantasy'),
 ('Science'),
 ('Mathematics'),
 ('Physics'),
 ('Tutorial'),
 ('Catalog');

/*
 * ISBN: Generate UNIQUE 15 digit numbers, convert to str
 * publisher: ref Publisher.id SERIAL
 * name: Generate fake name
 * description: Generate lorem ipsum text
 * edition: Generate numbers from 1-19
 * NoOfPages: Generate numbers from 15-1999
 */
INSERT INTO Book
 (ISBN, publisher, name, description, edition, NoOfPages)
VALUES
 ('1231234512345', 1, 'Battle of the Bulge', 'montes nascetur ridiculus mus etiam vel augue vestibulum rutrum rutrum', 1, 1000),
 ('1231234512346', 2, 'Replacement Killers, The', 'gravida sem praesent id massa id', 1, 923),
 ('1231234512347', 3, 'How to Survive a Plague', 'ut erat curabitur gravida nisi at nibh in hac habitasse platea dictumst', 6, 723),
 ('1231234512348', 1, 'Margarets Museum', 'orci pede venenatis non sodales sed tincidunt eu felis fusce posuere felis', 1, 543),
 ('1231234512349', 3, 'Skippy', 'vitae consectetuer eget rutrum at lorem integer', 1, 166),
 ('1231234512350', 5, 'Ballerina (La mort du cygne)', 'ligula sit amet eleifend pede libero quis orci nullam molestie', 3, 93),
 ('1231234512351', 1, 'Pompatus of Love, The', 'pede lobortis ligula sit amet eleifend pede libero', 1, 432),
 ('1231234512352', 4, 'Prizzis Honor', 'pellentesque eget nunc donec quis orci eget orci vehicula condimentum curabitur in libero', 1, 117),
 ('1231234512353', 7, 'Small Cuts (Petites coupures)', 'risus semper porta volutpat quam pede lobortis ligula', 1, 261),
 ('1231234512354', 1, 'Adventures of Sharkboy and Lavagirl 3-D, The', 'nec nisi volutpat eleifend donec ut dolor morbi', 1, 728),
 ('1231234512355', 5, 'Jindabyne', 'felis fusce posuere felis sed lacus morbi sem mauris', 1, 319),
 ('1231234512356', 9, 'Innocent, The (Innocente, L)', 'tempor convallis nulla neque libero convallis eget eleifend luctus ultricies', 4, 532),
 ('1231234512357', 2, 'Submarine', 'sodales sed tincidunt eu felis fusce posuere felis sed lacus morbi sem mauris', 1, 696),
 ('1231234512358', 4, 'Twin Falls Idaho', 'ante ipsum primis in faucibus orci luctus et ultrices posuere', 1, 1234),
 ('1231234512359', 6, 'The Missouri Breaks', 'molestie sed justo pellentesque viverra pede ac diam cras pellentesque volutpat', 1, 445),
 ('1231234512360', 3, 'Maiden Heist, The', 'duis at velit eu est congue elementum', 1, 1000),
 ('1231234512361', 6, 'Between the Devil and the Deep Blue Sea', 'nisi venenatis tristique fusce congue diam id ornare imperdiet sapien', 1, 744),
 ('1231234512362', 9, 'Happy People: A Year in the Taiga', 'leo odio porttitor id consequat in consequat ut nulla sed accumsan felis ut', 1, 278),
 ('1231234512363', 8, 'Crocodile Dundee in Los Angeles', 'turpis adipiscing lorem vitae mattis nibh ligula nec', 2, 200),
 ('1231234512364', 7, 'Loser Takes All, The (O hamenos ta pairnei ola)', 'quam sollicitudin vitae consectetuer eget rutrum at lorem integer tincidunt', 1, 192),
 ('1231234512365', 6, 'I Hate Christian Laettner', 'in quam fringilla rhoncus mauris enim leo rhoncus sed vestibulum sit amet', 1, 613);

/*
 * id: ref Series.id SERIAL
 * ISBN: ref Book.ISBN STRING
 */
INSERT INTO HasSeries
 (id, ISBN)
VALUES
 (1, '1231234512345'),
 (2, '1231234512346'),
 (3, '1231234512347'),
 (4, '1231234512348'),
 (5, '1231234512349'),
 (6, '1231234512350'),
 (7, '1231234512351'),
 (8, '1231234512352'),
 (9, '1231234512353'),
 (10, '1231234512354'),
 (11, '1231234512355'),
 (12, '1231234512356'),
 (13, '1231234512357'),
 (14, '1231234512358'),
 (15, '1231234512359'),
 (16, '1231234512360'),
 (1, '1231234512361'),
 (2, '1231234512362'),
 (3, '1231234512363'),
 (4, '1231234512364'),
 (5, '1231234512365');

/*
 * id: ref Genre.id SERIAL
 * ISBN: ref Book.ISBN STRING
 */
INSERT INTO HasGenre
 (id, ISBN)
VALUES
 (1, '1231234512345'),
 (2, '1231234512346'),
 (3, '1231234512347'),
 (4, '1231234512348'),
 (5, '1231234512349'),
 (6, '1231234512350'),
 (7, '1231234512351'),
 (8, '1231234512352'),
 (9, '1231234512353'),
 (10, '1231234512354'),
 (11, '1231234512355'),
 (12, '1231234512356'),
 (13, '1231234512357'),
 (14, '1231234512358'),
 (15, '1231234512359'),
 (6, '1231234512360'),
 (1, '1231234512361'),
 (2, '1231234512362'),
 (3, '1231234512363'),
 (4, '1231234512364'),
 (5, '1231234512365'),
 (2, '1231234512345'),
 (3, '1231234512346'),
 (4, '1231234512347'),
 (5, '1231234512348'),
 (6, '1231234512349'),
 (7, '1231234512350'),
 (8, '1231234512351'),
 (9, '1231234512352'),
 (8, '1231234512360'),
 (13, '1231234512361'),
 (11, '1231234512362'),
 (9, '1231234512363'),
 (7, '1231234512364'),
 (1, '1231234512365');
 
INSERT INTO UserAccount
 (username, passwordHash)
VALUES
 ('cdalfaro', 'A3DBAE59510887AE09559A40EF9DB1B8F87EB07848946BD7D31218EA620E4595'),
 ('sarthak', '1BC0D6CC82F25071783BECA57F499A20934BB6A812BF2636F0EFBFB4268FB28B'),
 ('dart', 'DDCA49F2C2566B151ABBB21569310353329D7AF73582DF1D43A8FA3066377FAE'),
 ('tumancio', '781939D67145589CA6C9ABFE353DE62FFAB49982129C6D6A69F06A98A54CAB9D'),
 ('yuelin', '248488719864CF1421B2FD632BFD170EBC6E62554C60313C0D662E64E6018D41'),
 ('admin', '942EAC5172431EBDBD8AAD8516B2E27931BE6F9AF8CDEB50EC0A0CB8EF831E87'),
 ('rip', '60EEE595C5C540A3DD41BD541A552FDC4A66FD358EF87661B8B31A440C0F1A58'),
 ('sha256', 'E1EF90C5E58735EEDBEFC2B8DC7F62CF1CF35D94C21C347EDC4ECFBB75A178C7'),
 ('tuxedo', '679EAAC16659C013675081E715F7EF761BDD183F1D7F55D079EB46AD6E322AC5'),
 ('macistrash', '2D07ABD38FFC86F448E12B53FF6CE1E23FB0B3F932D2C49083DEB3B36FB76300'),
 ('xxhacker69xx', '8CD799FC26BF042009C4631D666F42341E0BF0AE35942D2AB8D779B4E2358FC5'),
 ('eatthis', 'E20792B6BB0CC5B2955ABACF7F92BDDEF3B5C6DC684CC37987D540075B29A7E1'),
 ('nerfthis', '863252A53C957E2FA7A786712FF42FCD223D2ADC6661CB898945F9376896276B');
 ('kt8d', 'AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA');

INSERT INTO Cart
 (total)
VALUES
 (0),
 (0),
 (0),
 (0),
 (0),
 (0),
 (0),
 (0),
 (0),
 (0),
 (0),
 (0),
 (0),
 (0);

INSERT INTO Has
 (username, cartid)
VALUES
 ('cdalfaro', 1),
 ('sarthak', 2),
 ('dart', 3),
 ('tumancio', 4),
 ('yuelin', 5),
 ('admin', 6),
 ('rip', 7),
 ('sha256', 8),
 ('tuxedo', 9),
 ('macistrash', 10),
 ('xxhacker69xx', 11),
 ('eatthis', 12),
 ('nerfthis', 13);
 ('kt8d', 14);

INSERT INTO OrderConfirmation
 (address)
VALUES
 ('1234 37th ct sw, new york NY 81373'),
 ('54321 19th st ne, houston TX 77444'),
 ('4423 42th ave n, seattle WA 98023'),
 ('49102 33rd ct ne, phoenix AZ 81034'),
 ('4892 52nd st se, richmond VA 82030'),
 ('23042 42nd ave w, denver CO 82543'),
 ('34239 25th bvd n, federal way WA 94320'),
 ('43251 19th ct se, yellowstone TX 38249');

INSERT INTO PayForCart
 (cartid, orderid)
VALUES
 (1, 1),
 (1, 2),
 (2, 3),
 (3, 4),
 (4, 5),
 (5, 6),
 (6, 7),
 (7, 8);
 
INSERT INTO CurrentlyInCart
 (cartid, isbn)
VALUES
 (1, '1231234512345'),
 (1, '1231234512346'),
 (1, '1231234512347'),
 (1, '1231234512348'),
 (2, '1231234512346'),
 (3, '1231234512346'),
 (4, '1231234512346'),
 (5, '1231234512347');

INSERT INTO Contains
 (orderid, isbn)
VALUES
 (1, '1231234512348'),
 (1, '1231234512349'),
 (1, '1231234512350'),
 (2, '1231234512351'),
 (2, '1231234512352'),
 (3, '1231234512352'),
 (3, '1231234512353'),
 (4, '1231234512353'),
 (5, '1231234512353'),
 (5, '1231234512354'),
 (5, '1231234512355'),
 (6, '1231234512356'),
 (6, '1231234512357'),
 (7, '1231234512358'),
 (8, '1231234512359');

INSERT INTO Author
 (firstname, lastname)
VALUES
 ('apple', 'applaud'),
 ('banana', 'bonanza'),
 ('chris', 'cockadoodledoo'),
 ('denver', 'dindin'),
 ('epsilon', 'elephonso'),
 ('fred', 'flintstone'),
 ('greg', 'giraffe'),
 ('heaven', 'halberto'),
 ('ivan', 'imaginary'),
 ('john', 'johnson');

INSERT INTO WrittenBy
 (isbn, authorid)
VALUES
 ('1231234512345', 1),
 ('1231234512346', 2),
 ('1231234512347', 3),
 ('1231234512348', 4),
 ('1231234512349', 5),
 ('1231234512350', 6),
 ('1231234512351', 7),
 ('1231234512352', 8),
 ('1231234512353', 9),
 ('1231234512354', 10),
 ('1231234512355', 9),
 ('1231234512356', 8),
 ('1231234512357', 7),
 ('1231234512358', 6),
 ('1231234512359', 5),
 ('1231234512360', 4),
 ('1231234512361', 3),
 ('1231234512362', 2),
 ('1231234512363', 1),
 ('1231234512364', 2),
 ('1231234512365', 3);