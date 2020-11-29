# Used by...
# - login
# - register
def response_success_login(cart_id):
    res = {
        'cartid': cart_id
    }
    return res

# Used by...
# - login
# - register
def response_fail_login():
    res = {
        'cartid': -1
    }
    return res


# Used by...
# - all search-books-by queries when zero results
def response_empty_booklist():
    res = {'books': []}
    return res

# Used by...
# - getbook by isbn upon no results found
def response_fail_distinct_book_by_isbn():
    res = {
        'found': False
    }
    return res

