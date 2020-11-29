import sys
import getpass
import psycopg2
import ron
from psycopg2.errors import UniqueViolation
from psycopg2.extensions import AsIs
from flask import Flask
app = Flask(__name__)

# Global stuff
try:
    # Edit with user & pass & db name , etc if needed
    connection = psycopg2.connect(user = "Vanilla", host = "127.0.0.1", port = "5432", database = "postgres")
    cursor = connection.cursor()
    print("Successfully connected to database...")

except(Exception, psycopg2.Error) as Error:
    print("Error While connecting to Postgre SQL",Error)

# This one is pretty much directly acting with psycopg2 resultsets so i put it here
# Used in
# - GetCart with cart_id param
# - All of the 'find all books by <criteria>' queries (excluding the get-single-book-by-isbn query)
def populate_books_array_from_result_set(books_result_set):
    if (books_result_set == None):
        return ron.response_empty_booklist()
    
    for row in books_result_set:
        print(row) # this helps with setting it up if needed
        pass
        # TODO Perhaps creating a function that returns a dictionary representing a book will help
        # TODO if not None, Convert into a book array, where each book looks like this
        # PRE-REQUISITES: get_books_by_genre should be done
        # PRE-REQUISITES: get_books_by_genre should be done
        # PRE-REQUISITES: get_books_by_genre should be done
        # PRE-REQUISITES: get_books_by_genre should be done
        # PRE-REQUISITES: get_books_by_genre should be done
        # PRE-REQUISITES: get_books_by_genre should be done
        # PRE-REQUISITES: get_books_by_genre should be done
        # PRE-REQUISITES: get_books_by_genre should be done
        # PRE-REQUISITES: get_books_by_genre should be done
        # PRE-REQUISITES: get_books_by_genre should be done
        # PRE-REQUISITES: get_books_by_genre should be done
        # PRE-REQUISITES: get_books_by_genre should be done
        # PRE-REQUISITES: get_books_by_genre should be done cannot stress this enough;
    demo_title_delete_me = 'sample using variables'
    demo_books = [
        {
            'isbn': '1231234512345',
            'title': demo_title_delete_me,
            'description': 'description of the book',
            'edition': 1,
            'pagecount': 321,
            'series': 'series of fortunate happenings',
            'genres': [
                'a genre',
                'maybe more genres'
            ]
        },
        # if there are more books that made it into the resultset (ex: search by genre), continue adding them here
        {
            'isbn': '1231234512346',
            'title': 'another booktitle of book matching criteria',
            'description': 'description of the book',
            'edition': 1,
            'pagecount': 321,
            'series': 'series of fortunate happenings',
            'genres': [
                'a genre',
                'maybe more genres'
            ]
        }
    ]
    res = {'books': demo_books}
    return res

# Flask Routes
@app.route('/login/<username>/<pass_hash>')
def login_attempt(username, pass_hash):
    global cursor
    cursor.execute("SELECT Has.cartid FROM ( Has INNER JOIN ( SELECT username FROM UserAccount WHERE UserAccount.username=%s AND UserAccount.passwordHash=%s ) as RequestedUserAcc ON RequestedUserAcc.username = Has.username );", (username, pass_hash))
    record = cursor.fetchone()
    if (record == None):
        return ron.response_fail_login()
    cart_id = record[0]
    return ron.response_success_login(cart_id)


@app.route('/register/<username>/<pass_hash>')
def register_attempt(username, pass_hash):
    global cursor, connection
    try:
        # Register UserAccount
        cursor.execute("INSERT INTO UserAccount (username, passwordHash) VALUES (%s, %s)", [username,pass_hash])
        cursor.execute("INSERT INTO Cart (total) VALUES (0)")
        cursor.execute("INSERT INTO has (username, cartid) VALUES(%s, currval(pg_get_serial_sequence('cart','id')))", [username] )
        connection.commit()
        
        # Get cartid
        cursor.execute("SELECT Has.cartid FROM ( Has INNER JOIN ( SELECT username FROM UserAccount WHERE UserAccount.username=%s AND UserAccount.passwordHash=%s ) as RequestedUserAcc ON RequestedUserAcc.username = Has.username );", (username, pass_hash))
        record = cursor.fetchone()
        cart_id = record[0]
        return ron.response_success_login(cart_id)
    except UniqueViolation:
        return ron.response_fail_login()


@app.route('/addtocart/<cartid>/<isbn>')
def add_book_to_cart(cartid, isbn):
    global cursor, connection
    cursor.execute("INSERT INTO currentlyincart (cartid, isbn) VALUES (%s, %s)", [cartid,isbn])
    connection.commit()
    return True


@app.route('/getbook/<isbn>')
def get_book(isbn):
    # TODO write SQL query to get book where isbn is equal to the isbn parameter (see & test t_get_book_contents.sql for reference of the resultset)
    cursor.execute("thequeryhere with %s to be replaced by other params", ('i replace that first %s on the left', 'i replace second'))
    record = cursor.fetchone()
    if (record == None):
        return ron.response_fail_distinct_book_by_isbn()
    
    # TODO handle a successful query which is currently inside of "record" and return it in the format above
    # NOTE: SUCCESSFUL EXAMPLE (EXCEPT) the data source will be psycopg2 resultsets, not hardcoded values
    rfield_book_isbn = '1231234512345'
    rfield_book_title = 'I was found exclsively using sql'
    rfield_book_desc = 'Book Description Here'
    rfield_book_ed = 1
    rfield_book_pages = 321
    rfield_book_series = 'Series of fortunate events'
    rfield_book_genres = [
        'romance',
        'comedy'
    ]
    rfield_auth_firstname = 'authorfirstname'
    rfield_auth_lastname = 'authorlastname'
    rfield_pub_name = 'nameofpublisherhere'
    rfield_pub_date = '2020-01-30'
    successful_response_example = {
        'found': True,
        'book': {
            'isbn': rfield_book_isbn,
            'title': rfield_book_title,
            'description': rfield_book_desc,
            'edition': rfield_book_ed,
            'pagecount': rfield_book_pages,
            'series': rfield_book_series,
            'genres': rfield_book_genres
        },
        'author': {
            'first': rfield_auth_firstname,
            'last': rfield_auth_lastname
        },
        'publisher': {
            'name': rfield_pub_name,
            'date': rfield_pub_date
        }
    }
    return successful_response_example


# get cart -> Book[] (no need for author/publisher/series/genres/etc)
@app.route('/getcart/<cartid>')
def get_cart(cartid):
    global cursor
    # TODO do purely in sql
    # cursor.execute("SELECT * FROM has NATURAL JOIN currentlyincart NATURAL JOIN book")
    # record = cursor.fetchall()
    result_set = cursor.fetchall()
    return populate_books_array_from_result_set(result_set)


@app.route('/getbooks/title/<title>') # filter books by isbn -> ResultSet
def get_books_by_title(title):
    # TODO exactly the same as get_cart but for book title (preferably use LIKE so we can get more than one book...)
    pass


@app.route('/getbooks/author/<lastname>') # filter books by author lastname
def get_books_by_author(lastname):
    # TODO exactly the same as get_cart but for author
    pass


@app.route('/getbooks/publisher/<publishername>') # filter books by publisher -> ResultSet
def get_books_by_publisher(publishername):
    # TODO exactly the same as get_cart but for publisher name
    pass


@app.route('/getbooks/genre/<genre>') # filter books by genre -> ResultSet
def get_books_by_genre(genre):
    # TODO exactly the same as get_cart but for genres
    pass


@app.route('/getbooks/series/<series>') # filter books by series -> ResultSet
def get_books_by_series(series):
    # TODO exactly the same as get_cart but for series (preferably use LIKE so we can get more than one book...)
    pass


@app.route("/")
def hello():
    # NOTE: this is never called by the front end except for testing stuff
    return {'books': []}


if __name__ == "__main__":
    app.run(host="0.0.0.0", port="33608", debug="True")

