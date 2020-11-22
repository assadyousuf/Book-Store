import sys
import getpass
import psycopg2
from psycopg2 import Error



current_username, current_password, cart,currentlyLoggedIn = "", "", [""],False
connection = psycopg2.connect(user = "assadyousuf",host = "127.0.0.1", port = "5432", database = "catalog")
cursor = connection.cursor()
    
def main():
    first_menu_options = {'A':logIn, 'B': CreateAccount }
    second_menu_options = {'A':SearchForBooks, 'B': AddBookToCart, 'C': displayCart,'D': LogOut}
    while(True):
        if currentlyLoggedIn == False:
            ans = raw_input("Welcome to CSE412 BookStore! Please Select an option\n A.Log In\n B.Create Account\n C.Quit\n")
            for option in first_menu_options:
                if ans == option:
                    first_menu_options[ans]() 
                elif ans == 'C':
                    exit_program()    
                    
        elif currentlyLoggedIn == True:
            ans = raw_input("Please Select an option\n A.Search For Book\n B.Add Book To Cart\n C.Display Current Cart\n D.Log Out\n")
            for option in second_menu_options:
                if ans == option:
                    second_menu_options[ans]()

    
def logIn():
    global current_username,current_password,currentlyLoggedIn,cart,cursor  
    if currentlyLoggedIn == False:
        username_input, password_input = raw_input(" Username: "), getpass.getpass(" Password: ")
        #verify username_input and password_input exist in the userAccount tables
        cursor.execute("SELECT * FROM useraccount WHERE useraccount.username=%s AND useraccount.password=%s", (username_input,password_input))
        record = cursor.fetchone() 
        if(record == None):
            print("Not a valid username or password\n")
            return

        currentlyLoggedIn = True
        current_username, current_password = record[0], record[1] #setting global user and password to verified user logging in

        #populate cart with names from the books of the tables currentlyInCart naturalJOIN with book
        cursor.execute("SELECT * FROM has NATURAL JOIN currentlyincart NATURAL JOIN book;")
        del cart[:] #clears cart
        for row in cursor: #loops through table and finds the rows where username matches current user logged in and adds books to cart
            if(row[2] == current_username):
                cart.append(row[4])
        

    elif currentlyLoggedIn == True:
        print(" Already Logged In. Please Log out to log into another account.\n")

def LogOut():
    global current_username,current_password,currentlyLoggedIn,cart,cursor 
    current_username, current_password, cart,currentlyLoggedIn = "", "", [],False

def CreateAccount():
    global current_username,current_password,currentlyLoggedIn,cart,cursor  
    newUsername = raw_input("Enter a username for your new Account: ")
    newPassword = getpass.getpass(" Enter a password for your new Account: ")
    #add a new user to UserAccount table and create a cart for this user in the cart table
    cursor.execute("INSERT INTO UserAccount (username, password) VALUES (%s, %s);", (newUsername,newPassword))
    cursor.execute("INSERT INTO Cart (total) VALUES (0);")
    cursor.execute("INSERT INTO has (username, cartid) VALUES(%s, currval(pg_get_serial_sequence('Cart', 'id')));", newUsername )

        
def SearchForBooks():
    global current_username,current_password,currentlyLoggedIn,cart,cursor  
    ans = raw_input(" Search By:\n A.Genre\n B.ISBN\n C.Series\n D.Publisher E.Name")
    # ^ We can use the above to just do a simple select where query depending on the variable the user chooses to filer by


def AddBookToCart():
    global current_username,current_password,currentlyLoggedIn,cart,cursor  
    ans = raw_input(" Please enter the name of the book that you would like to add to your cart") 
    #verify book trying to be bought exists in book table and add to the global cart variable using cart.append("Book Name")

def displayCart():
    global current_username,current_password,currentlyLoggedIn,cart,cursor 
    if cart.count == 0:
        print("Cart is empty\n") 
        return

    for book in cart: #Here we can just loop through the cart variable and display everything in there
        print(book)



if __name__ == "__main__":
    main()

def exit_program():
    sys.exit() #Just ends program 




######################################################################################





    
