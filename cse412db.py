import sys
import getpass
import psycopg2
from psycopg2.errors import UniqueViolation
from tabulate import tabulate
from psycopg2.extensions import AsIs


class cartObject:
    name=""
    price=0.00
    def __init__(self,name,price):
        self.name=name
        self.price=price

try:
    current_username, current_password, cart,currentlyLoggedIn, currentTotal,currentcartid = "", "", [""],False,0,0
    connection = psycopg2.connect(user = "assadyousuf",host = "127.0.0.1", port = "5432", database = "catalog")
    cursor = connection.cursor()

except(Exception, psycopg2.Error) as Error:
    print("Error While connecting to Postgre SQL",Error)


def exit_program():
    connection.close()
    cursor.close()
    quit() #Just ends program 

def main():
    first_menu_options = {'A':logIn, 'B': CreateAccount }
    second_menu_options = {'A':FilterBooksBy, 'B': AddBookToCart, 'C': displayCart,'D': SearchForBooks, 'E':Checkout, 'F':deleteAccount, 'G':LogOut}
    while(True):
        if currentlyLoggedIn == False:
            ans = input("Welcome to CSE412 BookStore! Please Select an option\n A.Log In\n B.Create Account\n C.Quit\n")
            for option in first_menu_options:
                if ans == option:
                    first_menu_options[ans]() 
                elif ans == 'C':
                    exit_program()    
                    
        elif currentlyLoggedIn == True:
            ans = input("Please Select an option\n A.Filter Books By\n B.Add Book To Cart\n C.Display Current Cart\n D.Search For Book\n E.Checkout\n F:Delete Account\n G:LogOut\n")
            for option in second_menu_options:
                if ans == option:
                    second_menu_options[ans]()

    
def logIn():
    global current_username,current_password,currentlyLoggedIn,cart,cursor,currentTotal,currentcartid  
    if currentlyLoggedIn == False:
        username_input, password_input = input(" Username: "), getpass.getpass(" Password: ")
        #verify username_input and password_input exist in the userAccount tables
        cursor.execute("SELECT * FROM useraccount WHERE useraccount.username=%s AND useraccount.password=%s", (username_input,password_input))
        record = cursor.fetchone() 
        if(record == None):
            print("Not a valid username or password\n")
            return

        currentlyLoggedIn = True
        current_username, current_password = record[0], record[1] #setting global user and password to verified user logging in

        #populate cart with names from the books of the tables currentlyInCart naturalJOIN with book
        cursor.execute("SELECT * FROM has NATURAL JOIN cart NATURAL JOIN currentlyincart NATURAL JOIN book;")
        del cart[:] #clears cart 
        currentTotal = 0 #clears current total
        record = cursor.fetchall()
        for row in record: #loops through table and finds the rows where username matches current user logged in and adds books to cart
            if(row[2] == current_username):
                cartEntry = cartObject(row[5],float(row[9]))
                cart.append(cartEntry)
                
        #grabbing totals for each cart:
        cursor.execute("SELECT * FROM has NATURAL JOIN cart NATURAL JOIN currentlyincart NATURAL JOIN book")
        record = cursor.fetchall()
        for row in record: #loops through table and finds the rows where username matches current user logged in and adds books to cart
            if(row[2] == current_username):
                currentTotal = float(row[3])


        #setting cartId of user logging in for local use
        cursor.execute("SELECT * FROM useraccount NATURAL JOIN has WHERE useraccount.username = %s", [current_username])
        record = cursor.fetchone() 
        currentcartid = record[2]

        


    elif currentlyLoggedIn == True:
        print(" Already Logged In. Please Log out to log into another account.\n")

def LogOut():
    global current_username,current_password,currentlyLoggedIn,cart,cursor,cartid,currentTotal,currentcartid
    current_username, current_password, cart,currentlyLoggedIn,currentTotal,currentcartid = "", "", [],False,0,0

def CreateAccount():
    global current_username,current_password,currentlyLoggedIn,cart,cursor,currentTotal,currentcartid 
    newUsername = input("Enter a username for your new Account: ")
    newPassword = getpass.getpass("Enter a password for your new Account: ")
    #add a new user to UserAccount table and create a cart for this user in the cart table
    try:
        cursor.execute("INSERT INTO UserAccount (username, password) VALUES (%s, %s)", [newUsername,newPassword])
        cursor.execute("INSERT INTO Cart (total) VALUES (0)")
        cursor.execute("INSERT INTO has (username, id) VALUES(%s, currval(pg_get_serial_sequence('cart','id')))", [newUsername] )
        connection.commit()
    except UniqueViolation:
        print("You are trying to create an account that already exists!\n")  

        
def FilterBooksBy():
    global current_username,current_password,currentlyLoggedIn,cart,cursor,currentTotal,currentcartid  
    options =  {'A':"Genre", 'B': "ISBN", 'C':"Series" , 'D':"Publisher"}
    ans = input(" Search By:\n A.Genre\n B.ISBN\n C.Series\n D.Publisher\n")
    string = options[ans]
    if ans == 'A' :
        cursor.execute("SELECT book.name,genre.name FROM  genre NATURAL JOIN hasGenre LEFT JOIN book ON hasGenre.isbn=book.isbn;")
        table = cursor.fetchall()
        headers = ["Book Name", string]
        print(tabulate(table,headers, tablefmt="fancy_grid"))   
    elif ans == 'B':
        cursor.execute("SELECT book.name,book.isbn FROM book")
        table = cursor.fetchall()
        headers = ["Book Name", string]
        print(tabulate(table,headers, tablefmt="fancy_grid"))
    elif ans == 'C':
        cursor.execute( "SELECT book.name,Series.name FROM  Series NATURAL JOIN hasSeries LEFT JOIN book ON hasSeries.isbn=book.isbn")
        table = cursor.fetchall()
        headers = ["Book Name", string]
        print(tabulate(table,headers, tablefmt="fancy_grid"))
    elif ans == 'D':
        cursor.execute("SELECT book.name,publisher.name FROM publisher LEFT JOIN book ON publisher.id = book.publisher")
        table = cursor.fetchall()
        headers = ["Book Name", string]
        print(tabulate(table,headers, tablefmt="fancy_grid"))
    elif ans == 'E':
        cursor.execute("SELECT book.name FROM book")




    # ^ We can use the above to just do a simple select where query depending on the variable the user chooses to filer by


def AddBookToCart():
    global current_username,current_password,currentlyLoggedIn,cart,cursor,currentTotal,currentcartid 
    ans = input("Please enter the name of the book that you would like to add to your cart\n") 
    cursor.execute("SELECT * FROM book WHERE book.name=%s",[ans])
    record = cursor.fetchone()
    if len(record) == 0:
        print("Book does not exist in our catalog!\n")
        return
  
    cartEntry = cartObject(record[2],float(record[6]))
    isbn = record[0]
    cart.append(cartEntry)
    
    cursor.execute("SELECT * FROM has NATURAL JOIN cart")
    record = cursor.fetchall()
    for row in record:
        if row[1] == current_username:
            currentTotal+= float(cartEntry.price)
            string = str(currentTotal)
            cursor.execute("UPDATE cart SET total = %s WHERE id=%s",(string,row[0]))    
            cursor.execute("INSERT INTO currentlyincart (id,isbn) VALUES(%s,%s)" ,(row[0],isbn))   
            connection.commit()  


         
    #verify book trying to be bought exists in book table and add to the global cart variable using cart.append("Book Name") and also add it to currentlyInCart Table


def displayCart():
    global current_username,current_password,currentlyLoggedIn,cart,cursor,currentTotal,currentcartid 
    tempTable = []
    if len(cart) == 0:
        print("Cart is empty\n") 
        return

    for book in cart: #Here we can just loop through the cart variable and display everything in there
        tempTable.append([book.name,str(book.price)])     
        #print(book.name+"            "+ str(book.price) + "$")

    headers = ["Book","Price"]
    print(tabulate(tempTable,headers, tablefmt="fancy_grid"))    
       

def SearchForBooks():
     global current_username,current_password,currentlyLoggedIn,cart,cursor,currentTotal,currentcartid
     ans = input(" Please enter the name of the book that you would like to search for in our catalog: \n") 
     cursor.execute("SELECT isbn,name,description,edition,noofpages FROM book WHERE book.name=%s",[ans])
     table = cursor.fetchall()
     headers = ["ISBN","Name", "Description", "Edition","No. Pages" ]
     if len(table) == 0:
        print("Book does not exist in our catalog!\n")
        return

     print(tabulate(table,headers, tablefmt="fancy_grid"))

def Checkout():
    global current_username,current_password,currentlyLoggedIn,cart,cursor,currentTotal,currentcartid

    if len(cart)==0:
        print("Cart is empty!")
        return

    for item in cart:
        currentTotal= currentTotal + item.price
    print("Current Total:" + str(currentTotal) + "\nWould You like to purchase the following books in your cart:")
    displayCart()
    
    
    ans = input("Please answer Y/N\n")
    if ans == "Y" and len(cart)!=0:
        currentTotal = 0.00
        shipping=input("Please enter a shipping address:\n")
        cursor.execute("INSERT INTO orderconfirmation (id, address) VALUES(%s,%s)",[currentcartid,shipping])
        print("Order Confirmed! Shipping books to " + shipping)
        connection.commit()
      





def deleteAccount():
    global current_username,current_password,currentlyLoggedIn,cart,cursor,currentTotal,currentcartid
    
    del cart[:] #clears cart  
    cursor.execute("DELETE FROM useraccount WHERE username = %s", [current_username])
    cursor.execute("DELETE FROM has WHERE has.username=%s",[current_username])
    cursor.execute("DELETE FROM currentlyincart where id = %s", [currentcartid])
    cursor.execute("DELETE FROM orderconfirmation WHERE id=%s",[currentcartid])
    cursor.execute("DELETE FROM cart WHERE cart.id=%s",[currentcartid])
    connection.commit()
   
    connection.commit()

    current_username, current_password, cart,currentlyLoggedIn, currentTotal,currentcartid = "", "", [""],False,0,0

    print("Account sucesfully deleted!\n")





current_username, current_password, cart,currentlyLoggedIn, currentTotal = "", "", [""],False,0
if __name__ == "__main__":
    main()


   


######################################################################################





    
