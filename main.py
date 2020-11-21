from collections import namedtuple
import sys

currentUserInSession = None
#Class definitions 
class Book:
    name = ""
    ISBN = int
    author_firstName=""
    Author_LastName=""
    SeriesID,SeriesName = int, ""
    GenreID ,GenreName = int, ""
    PublisherID, PublisherName = int, ""
    price = float

    def __init__(self,name,ISBN,Author_FirstName,Author_LastName,price,GenreID,GenreName,PublisherName,PublisherID,SeriesID,SeriesName):
        self.name=name
        self.ISBN= ISBN
        self.author_firstName=Author_FirstName
        self.Author_LastName=Author_LastName
        self.SeriesID= SeriesID
        self.SeriesName= SeriesName
        self.GenreID=GenreID
        self.GenreName=GenreName
        self.PublisherID = PublisherID
        self.publisherName = PublisherName
        self.price = price
    

class cart:
    books = []
    orderConfirmation = False


    def __init__(self):
        #empty
        pass

    def addToCart(self,bookObj):
        if isinstance(bookObj, Book):
            self.books.append(bookObj)


    def confirmOrder(self):
        self.orderConfirmation = True


class UserAccount:
    username = ""
    password = ""
    cart = []
    orderConfirmation = False
    

    def _init_(self, username,password ):
        self.username = username
        self.password = password

    def addBookToCart(self,Book_name):
        self.cart.append(Book_name)

    def confirmOrder(self):
        self.confirmOrder = True


def DisplayBooks(): #prints all books in database
    pass 

def viewCart(currentUserInSession): #prints strings inside of cart list of a user obj
    pass

def findWhatBookToAddInCart(): #prompts user for name of book to add to cart and adds it to cart
    ans = input("What book do you want to add to cart?")
    if ans not in currentUserInSession.Cart: #only adds book if its not already in cart
        currentUserInSession.addBookToCart(ans)


def loggedIn():
    options = { A: DisplayBooks(),
                B: ViewCart(),
                C: findWhatBookToAddInCart(),
                D: currentUserInSession.confirmOrder()
    }
    
    ans = input(
        "A.Display All Books \n B.View Cart\n C.Add Book To Cart\n D.Checkout\n Q.Quit\n")
 
    if ans == 'A' or ans == 'B' or ans == 'C' or ans == 'D':
        options[ans]()
    elif ans == 'D':
        sys.exit()

#This function takes in the UserAccount obj and populates the corresponding cart from the table
def populateUserData(User):
   pass #populate UserAccount.cart list  with values from the cart table
    

#Where the program starts
def printMainMenu():
    userInput = input ("A. Log In\nB. Create Account\n C. Quit")
    if userInput == "B": 
        newUser = UserAccount(input("Create Username:"), input ("Create Password:")) 
        #add above newly created user to userAccount table
    elif userInput == "A":
        userName = input("Username:")
        password = input("Password:")
        #check if user exists then create a userAccount obj for it if user exists in user table and set that as currentUserInSession global var. 
        populateUserData(currentUserInSession)
        #now show main functions user can do once log in is verified and cart info is pulled in
        loggedIn()

  

def main():
    while True:
        printMainMenu()


    

if __name__ == "__main__":
    main()



