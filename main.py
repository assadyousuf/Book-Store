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

class program:
    try:
        #current_username, current_password, cart,currentlyLoggedIn, currentTotal,currentcartid = "", "", [""],False,0,0
        connection = psycopg2.connect(user = "assadyousuf",host = "127.0.0.1", port = "5432", database = "catalog")
        current_username, current_password, cart,currentlyLoggedIn, currentTotal,currentcartid,cursor = "", "", [""],False,0,0,connection.cursor()
        cartTotalupToDate = False

    except(Exception, psycopg2.Error) as Error:
        print("Error While connecting to Postgre SQL",Error)


    def exit_program(self):
        self.connection.close()
        self.cursor.close()
        quit() #Just ends program 

    def main(self):
        first_menu_options = {'A':self.logIn, 'B': self.CreateAccount }
        second_menu_options = {'A':self.FilterBooksBy, 'B': self.AddBookToCart, 'C': self.displayCart,'D': self.SearchForBooks, 'E':self.Checkout, 'F':self.deleteAccount, 'G':self.LogOut}
        while(True):
            if self.currentlyLoggedIn == False:
                ans = input("Welcome to CSE412 BookStore! Please Select an option\n A.Log In\n B.Create Account\n C.Quit\n")
                for option in first_menu_options:
                    if ans == option:
                        first_menu_options[ans]() 
                    elif ans == 'C':
                        self.exit_program()    
                        
            elif self.currentlyLoggedIn == True:
                ans = input("Please Select an option\n A.Filter Books By\n B.Add Book To Cart\n C.Display Current Cart\n D.Search For Book\n E.Checkout\n F:Delete Account\n G:LogOut\n")
                for option in second_menu_options:
                    if ans == option:
                        second_menu_options[ans]()

        
    def logIn(self,username_input,password_input):
        #global current_username,current_password,currentlyLoggedIn,cart,cursor,currentTotal,currentcartid  
        if self.currentlyLoggedIn == False:
            #username_input, password_input = input(" Username: "), getpass.getpass(" Password: ")
            #verify username_input and password_input exist in the userAccount tables
            self.cursor.execute("SELECT * FROM useraccount WHERE useraccount.username=%s AND useraccount.password=%s", (username_input,password_input))
            record = self.cursor.fetchone() 
            if(record == None):
                print("Not a valid username or password\n")
                return False

            self.currentlyLoggedIn = True
            self.current_username, self.current_password = record[0], record[1] #setting global user and password to verified user logging in

            #populate cart with names from the books of the tables currentlyInCart naturalJOIN with book
            self.cursor.execute("SELECT * FROM has NATURAL JOIN cart NATURAL JOIN currentlyincart NATURAL JOIN book;")
            del self.cart[:] #clears cart 
            self.currentTotal = 0 #clears current total
            record = self.cursor.fetchall()
            for row in record: #loops through table and finds the rows where username matches current user logged in and adds books to cart
                if(row[2] == self.current_username):
                    cartEntry = cartObject(row[5],float(row[9]))
                    self.cart.append(cartEntry)
                    
            #grabbing totals for each cart:
            self.cursor.execute("SELECT * FROM has NATURAL JOIN cart")
            record = self.cursor.fetchall()
            for row in record: #loops through table and finds the rows where username matches current user logged in and adds books to cart
                if(row[1] == self.current_username):
                    self.currentTotal += float(row[2])
                    self.cartTotalupToDate=True


            #setting cartId of user logging in for local use
            self.cursor.execute("SELECT * FROM useraccount NATURAL JOIN has WHERE useraccount.username = %s", [self.current_username])
            record = self.cursor.fetchone() 
            self.currentcartid = record[2]

            return True


        elif self.currentlyLoggedIn == True:
            print(" Already Logged In. Please Log out to log into another account.\n")

    def LogOut(self):
       # global current_username,current_password,currentlyLoggedIn,cart,cursor,cartid,currentTotal,currentcartid
        self.current_username, self.current_password, self.cart,self.currentlyLoggedIn,self.currentTotal,self.currentcartid = "", "", [],False,0,0

    def CreateAccount(self,newUsername,newPassword):
       # global current_username,current_password,currentlyLoggedIn,cart,cursor,currentTotal,currentcartid 
       # newUsername = input("Enter a username for your new Account: ")
       # newPassword = getpass.getpass("Enter a password for your new Account: ")
        #add a new user to UserAccount table and create a cart for this user in the cart table
        
        try:
            self.cursor.execute("INSERT INTO UserAccount (username, password) VALUES (%s, %s)", [newUsername,newPassword])
            self.cursor.execute("INSERT INTO Cart (total) VALUES (0)")
            self.cursor.execute("INSERT INTO has (username, id) VALUES(%s, currval(pg_get_serial_sequence('cart','id')))", [newUsername] )
            self.connection.commit()
        except UniqueViolation:
            print("You are trying to create an account that already exists!\n")  
            return False

        return True     

            
    def FilterBooksBy(self,ans):
       # global current_username,current_password,currentlyLoggedIn,cart,cursor,currentTotal,currentcartid  
        options =  {'A':"Genre", 'B': "ISBN", 'C':"Series" , 'D':"Publisher"}
        #ans = input(" Search By:\n A.Genre\n B.ISBN\n C.Series\n D.Publisher\n")
       # string = options[ans]
        if ans == 'Genre' :
            self.cursor.execute("SELECT book.name,genre.name FROM  genre NATURAL JOIN hasGenre LEFT JOIN book ON hasGenre.isbn=book.isbn;")
            table = self.cursor.fetchall()
            headers = ["Book Name", ans]
            #return (tabulate(table,headers, tablefmt="fancy_grid"))
            return table   
        elif ans == 'ISBN':
            self.cursor.execute("SELECT book.name,book.isbn FROM book")
            table = self.cursor.fetchall()
            headers = ["Book Name", ans]
            #return (tabulate(table,headers, tablefmt="fancy_grid"))
            return table
        elif ans == 'Series':
            self.cursor.execute( "SELECT book.name,Series.name FROM  Series NATURAL JOIN hasSeries LEFT JOIN book ON hasSeries.isbn=book.isbn")
            table = self.cursor.fetchall()
            headers = ["Book Name", ans]
            #return (tabulate(table,headers, tablefmt="fancy_grid"))
            return table
        elif ans == 'Publisher':
            self.cursor.execute("SELECT book.name,publisher.name FROM publisher LEFT JOIN book ON publisher.id = book.publisher")
            table = self.cursor.fetchall()
            headers = ["Book Name", ans]
            #return (tabulate(table,headers, tablefmt="fancy_grid"))
            return table
        elif ans == 'Name':
            self.cursor.execute("SELECT book.name FROM book")
            table = self.cursor.fetchall()
            headers = ["Book Name"]
            #return (tabulate(table,headers, tablefmt="fancy_grid"))
            return table






        # ^ We can use the above to just do a simple select where query depending on the variable the user chooses to filer by


    def AddBookToCart(self,nameOfBook):
       # global current_username,current_password,currentlyLoggedIn,cart,cursor,currentTotal,currentcartid 
        #ans = input("Please enter the name of the book that you would like to add to your cart\n") 
        ans = nameOfBook
        self.cursor.execute("SELECT * FROM book WHERE book.name=%s",[ans])
        record = self.cursor.fetchone()
        if len(record) == 0:
            print("Book does not exist in our catalog!\n")
            return False
    
        cartEntry = cartObject(record[2],float(record[6]))
        isbn = record[0]
        self.cart.append(cartEntry)
        
        self.cursor.execute("SELECT * FROM has NATURAL JOIN cart")
        record = self.cursor.fetchall()
        for row in record:
            if row[1] == self.current_username:
                self.currentTotal+= float(cartEntry.price)
                string = str(self.currentTotal)
                self.cursor.execute("UPDATE cart SET total = %s WHERE id=%s",(string,row[0]))    
                self.cursor.execute("INSERT INTO currentlyincart (id,isbn) VALUES(%s,%s)" ,(row[0],isbn))   
                self.connection.commit()  
                self.cartTotalupToDate = False

        return True    

            
        #verify book trying to be bought exists in book table and add to the global cart variable using cart.append("Book Name") and also add it to currentlyInCart Table


    def displayCart(self):
       # global current_username,current_password,currentlyLoggedIn,cart,cursor,currentTotal,currentcartid 
        tempTable = []
        if len(self.cart) == 0:
            print("Cart is empty\n") 
            return "Cart is empty\n"

        for book in self.cart: #Here we can just loop through the cart variable and display everything in there
            tempTable.append([book.name,str(book.price)])     
            #print(book.name+"            "+ str(book.price) + "$")

        headers = ["Book","Price"]
        return tabulate(tempTable,headers, tablefmt="fancy_grid")     
        

    def SearchForBooks(self, bookToSearchFor):
       # global current_username,current_password,currentlyLoggedIn,cart,cursor,currentTotal,currentcartid
       # ans = input(" Please enter the name of the book that you would like to search for in our catalog: \n") 
        ans = bookToSearchFor
        self.cursor.execute("SELECT name,price,description,edition,noofpages FROM book WHERE book.name=%s",[ans])
        table = self.cursor.fetchall()
        headers = ["ISBN","Name", "Description", "Edition","No. Pages" ]
        if len(table) == 0:
            print("Book does not exist in our catalog!\n")
            return "Book does not exist in our catalog!"

        #return tabulate(table,headers, tablefmt="fancy_grid")
        return table

    def Checkout(self,address):
       # global current_username,current_password,currentlyLoggedIn,cart,cursor,currentTotal,currentcartid

        cartItems=[]
        if len(self.cart)==0:
            print("Cart is empty!")
            return False

        
        for item in self.cart:
            if self.cartTotalupToDate==False:
                self.currentTotal= self.currentTotal + item.price
            cartItems.append(item.name)

        print("Current Total:" + str(self.currentTotal) + "\nWould You like to purchase the following books in your cart:")
        self.displayCart()
        
        
       # ans = input("Please answer Y/N\n")


        #if ans == "Y" and len(self.cart)!=0:
        
       # shipping=input("Please enter a shipping address:\n")
        #    self.cursor.execute("INSERT INTO orderconfirmation (id, address) VALUES(%s,%s)",[self.currentcartid,shipping])
        shipping = address
        self.cursor.execute("INSERT INTO orderTable VALUES(DEFAULT,%s,%s,%s)",[shipping,cartItems,self.currentTotal])
        self.currentTotal = 0.00
        self.cursor.execute("DELETE FROM currentlyincart WHERE id = %s",[self.currentcartid])
        self.cursor.execute("UPDATE cart SET total = %s WHERE id=%s",("0",self.currentcartid))
        print("Order Confirmed! Shipping books to " + shipping)
        self.connection.commit()
        del self.cart[:]

        return True    
        





    def deleteAccount(self):
       # global current_username,current_password,currentlyLoggedIn,cart,cursor,currentTotal,currentcartid
        
        del self.cart[:] #clears cart  
        self.cursor.execute("DELETE FROM useraccount WHERE username = %s", [self.current_username])
        self.cursor.execute("DELETE FROM has WHERE has.username=%s",[self.current_username])
        self.cursor.execute("DELETE FROM currentlyincart where id = %s", [self.currentcartid])
        self.cursor.execute("DELETE FROM orderconfirmation WHERE id=%s",[self.currentcartid])
        self.cursor.execute("DELETE FROM cart WHERE cart.id=%s",[self.currentcartid])
        self.connection.commit()
    
        self.connection.commit()

        self.current_username, self.current_password, self.cart,self.currentlyLoggedIn, self.currentTotal,self.currentcartid = "", "", [""],False,0,0

        print("Account sucesfully deleted!\n")

        self.LogOut()

        return True



    



if __name__ == "__main__":
    p = program()
    p.main()


   


######################################################################################





    
