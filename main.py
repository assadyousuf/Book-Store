import sys
import getpass

current_username, current_password, cart,currentlyLoggedIn = "", "", [],False

def main():
    first_menu_options = {'A':logIn, 'B': CreateAccount }
    second_menu_options = {'A':SearchForBooks, 'B': AddBookToCart, 'C': displayCart,'D': LogOut}
    while(True):
        if currentlyLoggedIn == False:
            ans = input("Welcome to CSE412 BookStore! Please Select an option\n A.Log In\n B.Create Account\n C.Quit\n")
            for option in first_menu_options:
                if ans == option:
                    first_menu_options[ans]() 
                elif ans == 'C':
                    exit_program()    
                    
        elif currentlyLoggedIn == True:
            ans = input("Please Select an option\n A.Search For Book\n B.Add Book To Cart\n C.Display Current Cart\n D.Log Out\n")
            for option in second_menu_options:
                if ans == option:
                    second_menu_options[ans]()

    

def logIn():
    global current_username,current_password,currentlyLoggedIn,cart  
    if currentlyLoggedIn == False:
        username_input, password_input = input(" Username: "), getpass.getpass(" Password: ")
        #verify username_input and password_input exist in the userAccount tables 
        currentlyLoggedIn = True
        #set current_username,current_password, and cart to data read from tables

    elif currentlyLoggedIn == True:
        print(" Already Logged In. Please Log out to log into another account.\n")

def LogOut():
    global current_username,current_password,currentlyLoggedIn,cart  
    current_username, current_password, cart,currentlyLoggedIn = "", "", [],False

def CreateAccount():
    global current_username,current_password,currentlyLoggedIn,cart  
    newUsername = input(" Enter a username for your new Account:")
    newPassword = getpass.getpass(" Enter a password for your new Account: ")
    #add a new user to UserAccount table and create a cart for this user in the cart table
        
def SearchForBooks():
    global current_username,current_password,currentlyLoggedIn,cart  
    ans = input(" Search By:\n A.Genre\n B.ISBN\n C.Series\n D.Publisher E.Name")
    # ^ We can use the above to just do a simple select where query depending on the variable the user chooses to filer by


def AddBookToCart():
    global current_username,current_password,currentlyLoggedIn,cart  
    ans = input(" Please enter the name of the book that you would like to add to your cart") 
    #verify book trying to be bought exists in book table and add to the global cart variable using cart.append("Book Name")

def displayCart():
    global current_username,current_password,currentlyLoggedIn,cart  
    for book in cart: #Here we can just loop through the cart variable and display everything in there
        pass  #print book name



if __name__ == "__main__":
    main()

def exit_program():
    sys.exit() #Just ends program 


    