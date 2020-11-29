CREATE TABLE Publisher (
  id SERIAL PRIMARY KEY,
  name VARCHAR(63),
  publishDate DATE
);

CREATE TABLE Series (
  id SERIAL PRIMARY KEY,
  name VARCHAR(63)
);

CREATE TABLE Genre (
  id SERIAL PRIMARY KEY,
  name VARCHAR(15)
);

CREATE TABLE Book (
  ISBN VARCHAR(15) PRIMARY KEY ,
  publisher INTEGER NOT NULL REFERENCES Publisher(id),
  CHECK (ISBN <> ''),
  name VARCHAR(63) ,
  description VARCHAR(256),
  edition INTEGER,
  NoOfPages INTEGER 
);

CREATE TABLE HasSeries (
  id INTEGER REFERENCES Series(id),
  ISBN VARCHAR(15) NOT NULL REFERENCES Book(ISBN),
  CHECK (ISBN <> ''),
  PRIMARY KEY (id, ISBN)
);

CREATE TABLE HasGenre (
  id INTEGER REFERENCES Genre(id),
  ISBN VARCHAR(15) NOT NULL REFERENCES Book(ISBN),
  CHECK (ISBN <> ''),
  PRIMARY KEY (id, ISBN)
);

CREATE TABLE UserAccount (
  username VARCHAR(15) PRIMARY KEY,
  passwordHash VARCHAR(128)
);
CREATE TABLE Cart (
  id SERIAL PRIMARY KEY,
  total INTEGER
);
CREATE TABLE Has (
  username VARCHAR(15) PRIMARY KEY,
  cartid INTEGER NOT NULL REFERENCES Cart(id)
);
CREATE TABLE OrderConfirmation (
  id SERIAL PRIMARY KEY,
  address VARCHAR(50)
);
CREATE TABLE PayForCart (
  cartid INTEGER NOT NULL REFERENCES Cart(id),
  orderid INTEGER NOT NULL REFERENCES OrderConfirmation(id)
);
CREATE TABLE CurrentlyInCart (
  cartid INTEGER NOT NULL REFERENCES Cart(id),
  isbn VARCHAR(15) REFERENCES Book(isbn)
);
CREATE TABLE Contains (
  orderid INTEGER PRIMARY KEY REFERENCES OrderConfirmation(id),
  isbn VARCHAR(15) REFERENCES Book(isbn)
);
CREATE TABLE Author (
  id SERIAL PRIMARY KEY,
  firstname VARCHAR(32),
  lastname VARCHAR(32)
);
CREATE TABLE WrittenBy (
  isbn VARCHAR(15) PRIMARY KEY REFERENCES Book(isbn),
  authorid INTEGER REFERENCES Author(id)
);