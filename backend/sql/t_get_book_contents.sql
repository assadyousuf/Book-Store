SELECT 
    bookisbn, -- Book.ISBN, /* bookisbn */
    bookname, -- Book.name, /* bookname */
    bookdesc, -- Book.description, /* bookdesc */
    booked, -- Book.edition, /* booked */
    bookpages, -- Book.NoOfPages, /* bookpages */
    authfirst, -- Author.firstname, /* authfirst */
    authlast, -- Author.lastname, /* authlast */
    pubname, -- Publisher.name, /* pubname */
    pubdate, -- Publisher.publishDate, /* pubdate */
    sername, -- Series.name, /* sername */
    ARRAY_AGG( /* genres */
        MatchedBooks.genre
    ) genres
FROM (
    SELECT
        BookResult.isbn AS bookisbn,
        BookResult.name AS bookname,
        BookResult.description AS bookdesc,
        BookResult.edition AS booked,
        BookResult.NoOfPages AS bookpages,
        AuthorResult.firstname AS authfirst,
        AuthorResult.lastname AS authlast,
        PublisherResult.pubname AS pubname,
        PublisherResult.pubdate AS pubdate,
        SeriesResult.name AS sername,
        GenreResult.name AS genre
    FROM
        (
            SELECT *
            FROM Book
            /* WHERE Book.isbn='1231234512345' */
        ) BookResult
        INNER JOIN
        (
            SELECT *
            FROM
                Genre
                NATURAL JOIN
                HasGenre
            /* WHERE */
        ) GenreResult
        ON GenreResult.isbn=BookResult.isbn
        INNER JOIN
        (
            SELECT
                Publisher.id AS pubid,
                Publisher.name AS pubname,
                Publisher.publishDate AS pubdate
            FROM Publisher
            /* WHERE */
        ) PublisherResult
        ON BookResult.publisher=PublisherResult.pubid
        INNER JOIN
        (
            SELECT *
            FROM 
                Series
                NATURAL JOIN
                HasSeries
            /* WHERE */
        ) SeriesResult
        ON BookResult.isbn=SeriesResult.isbn
        INNER JOIN
        (
            SELECT *
            FROM
                Author
                INNER JOIN
                WrittenBy
                ON Author.id=WrittenBy.authorid
            /* WHERE */
        ) AuthorResult
        ON BookResult.isbn=AuthorResult.isbn
) MatchedBooks
GROUP BY 
    bookisbn, -- Book.ISBN, /* bookisbn */
    bookname, -- Book.name, /* bookname */
    bookdesc, -- Book.description, /* bookdesc */
    booked, -- Book.edition, /* booked */
    bookpages, -- Book.NoOfPages, /* bookpages */
    authfirst, -- Author.firstname, /* authfirst */
    authlast, -- Author.lastname, /* authlast */
    pubname, -- Publisher.name, /* pubname */
    pubdate, -- Publisher.publishDate, /* pubdate */
    sername;