# User log in
def logon():
    print("Welcome to the log in page of CSE412 library management database")
    username = input("Please input your username：")
    if len(username) < 6:
        print("Username cannot be shorter than 6 characters ")
    else:
        email = input("Please input your email address：")
        password = input("Please input your password：")
        if len(password) < 8:
            print("Password cannot be shorter than 8 characters")
        else:
            rpassword = input("Confirm your password：")
            if password == rpassword:
                print("Signup successfully！")
                # Call def, separate each line when adding a new data
                preserve_data(path, [username, '   ' + email, '   ' + password + '\n'])
                login_tips = input('Do you want to log in？(yes/no)')
                if login_tips == 'yes':
                    login()
                else:
                    pass
                return True
            else:
                print("passwords entered are inconsistent, please re-enter！")
                # repeat menu
                logon()


# Save data to file
path = r'user.txt'


def preserve_data(file_path, data):
    # Convert a string to bytes, because write writes a byte stream, not a string. When it is w, it needs to be decoded
    # data = data.encode()
    # Open the file, append data to the file
    with open(file_path, 'a') as wstream:
        # Determine whether it is writable
        if wstream.writable():
            wstream.writelines(data)
        else:
            print("Permission denied!")


# user login
def login():
    print("Welcome to the login page of the library management system")
    tips = input("Have you already signed up？(yes/no)")
    if tips == 'yes':
        while True:
            username = input("Enter your user name：")
            password = input("Enter password：")
            # When reading the file, there may be an exception that the file cannot be found, so use try except
            try:
                # Read the contents of the file
                with open(path, 'rb') as stream:
                    # Read multiple lines and save them in the list. The list is saved in binary, byte
                    result = stream.readlines()
                    # List comprehension, loop through the list, decode bytes into strings and put them
                    # in a new list uesr_list
                    uesr_list = [i.decode() for i in result]

                    # Loop through the list to check if the username and password entered are in the string
                    for i in uesr_list:
                        info = i.split('   ')
                        # print(info)
                        if username == info[0] and password == info[2].rstrip('\r\n'):
                            print("login successful")
                            operate(book_path, username)
                            break
                    else:
                        raise Exception("Username or password is wrong, please re-enter！")

            except Exception as err:
                print(err)
            # Execute the else statement when there is no exception
            else:
                break
    else:
        print("You have not registered yet, please register before logging in！")
        logon()


# Find books
def find_books(path):
    try:
        with open(path, 'r') as rstream:
            # read is a list
            container = rstream.readlines()
            # Remove the newline symbol after each element
            new_container = [books_name.rstrip('\n') for books_name in container]
            for b_name in new_container:
                print("{}".format(b_name))

    except Exception as err:
        print("wrong reason：", err)


# Add book
def add_book(b_path, username):
    # First determine whether it is an administrator before adding
    permission(b_path, username)
    # The additional book cannot be w, otherwise the previous content will be cleared
    with open(b_path, 'a') as wstream:
        # Determine whether it is writable
        if wstream.writable:
            msg = input("Please enter the title：")
            try:
                # whether a book has been added before adding a book
                with open(b_path) as rstream:
                    while True:
                        line = rstream.readline()
                        line = line.rstrip('\n')
                        # When an empty line is found, if it is not found consistent
                        # with the entered book title, add the entered book title
                        if not line:
                            book = '\n' + msg
                            wstream.write(book)
                            print("Added!")
                            break
                        else:
                            # If the book entered is consistent with the line read,
                            # it will prompt that it cannot be added repeatedly
                            if line == msg:
                                print("{}Already existed, please do not add repeatedly".format(msg))
                                break
            except Exception as err:
                print("Error reason：", err)
        else:
            print("Permission denied")


# Edit book
def update_book(b_path, username):
    permission(b_path, username)
    try:
        with open(b_path, 'r') as rstream:
            container = rstream.read()
            # Split the string by'\n', and the result is a list
            container = container.split('\n')
            # print(container)
            # Which books are displayed before deleting
            find_books(book_path)
            book_name = input("Please enter the title of the book to be modified：")
            # modify book titles
            for i in range(len(container)):
                if book_name == container[i]:
                    rbook_name = input("Please enter the revised book title：")
                    container[i] = rbook_name + '\n'
                else:
                    # Each book name in the list is followed by a newline character, which is used for writing a file
                    container[i] = container[i] + '\n'
            with open(b_path, 'w') as wwstream:
                wwstream.writelines(container)
            print("Successfully modified")
    except Exception as err:
        print("Error reason：", err)


# Remove from cart
def del_book(b_path, username):
    permission(path, username)
    try:
        with open(b_path, 'r') as rstream:
            container = rstream.read()
            # Split the string by'\n', and the result is a list
            container = container.split('\n')
            # Which books are on display
            find_books(book_path)
            book_name = input("Please enter the title of the book to be deleted：")
            # Modify book title
            for i in range(len(container) - 1):
                if book_name == container[i]:
                    container.remove(container[i])
                else:
                    # Each book name in the list is followed by a newline character, which is used for writing a file
                    container[i] = container[i] + '\n'
            # print(container)
            # The content after deleting the title of the book is written into the file with writelines writelines
            with open(b_path, 'w') as wwstream:
                wwstream.writelines(container)
            print("successfully deleted")
    except Exception as err:
        print("Error reason：", err)


# add books to cart
def add_cart(username):
    while True:
        print("Book list：")
        find_books(book_path)
        add_books = input("Please select a book：")
        try:
            with open('user_books.txt') as rstream:
                # read one line each time
                lines = rstream.readline()
                lines = lines.rstrip('\n')
                # Save the read content to the list separated by spaces
                #lines = lines.split(' ')
                # Determine whether the book entered has been added
                if add_books not in lines:
                    # Before add a book to cart,
                    # determine whether the user has added it before.
                    # If it has been added, do not do again
                    # for user_book in lines:
                    if username in lines:
                        with open('user_books.txt', 'a') as wstream:
                            # Determine whether you have added to cart before
                            if add_books not in lines:
                                wstream.write(' {}'.format(add_books))
                                print("Successful added to cart")
                                break
                            else:
                                print("You have already added this book, please select another")
                                break
                    else:
                        # Save the selected book to the file with the username
                        with open('user_books.txt', 'a') as wstream:
                            wstream.write('\n{} {}\n'.format(username, add_books))
                            print("Successful added")
                            break
                else:
                    print("<<{}>>Has been added by user {}, please select again~".format(add_books, lines[0]))
        except Exception as err:
            print("Error reason：", err)


# pay for Books
def pay_book(username):
    try:
        with open('user_books.txt') as rstream:
            lines = rstream.readlines()
            # Traverse the list and split the elements into lists
            for i in range(len(lines)):
                # Remove newlines
                lines[i] = lines[i].rstrip('\n')
                lines[i] = lines[i].rstrip(' ')
                lines[i] = lines[i].split(' ')
                for ii in range(len(lines[i]) - 1):
                    # Only print books added by logged-in users
                    if username == lines[i][0]:
                        print("{} You have added books but have not pay the books as follows：".format(username))
                        #print(lines[i][ii + 1])
                        cart_book = {}
                        for cart_books in lines[i]:
                            print(cart_books.replace(',', ' '), end=' ')
                        msg = input("Please select the book you want to buy：")
                        msg.replace(' ', '')
                        with open('user_books.txt') as rstream:
                            lines = rstream.readlines()
                            for i in range(len(lines)):
                                if username in lines[i] and msg in lines[i]:
                                    # Replace msg with an empty string, which means to delete the added book
                                    lines[i] = lines[i].replace(msg, '')
                                    with open('user_books.txt', 'w') as wstream:
                                        # Write the changed list to the file,
                                        # and only change the book information of the current user
                                        wstream.writelines(lines)
                                        print("Paid successfully！")
                                        break

                            with open('user_books.txt') as rstream:
                                lines = rstream.readlines()
                                for i in range(len(lines)):
                                    lines[i] = lines[i].rstrip('\n')
                                    lines[i] = lines[i].rstrip(' ')
                                    lines[i] = lines[i].split(' ')
                                    for ii in range(len(lines[i])):
                                        # After the book is bought successfully, it is determined that
                                        # there is only the user name in the list. If there is only the user name,
                                        # replace the user name with an empty string
                                        if username == lines[i][0] and len(lines[i]) == 1:
                                            lines[i][0] = lines[i][0].replace(lines[i][0], '')
                                            lines.append(lines[i][0])
                                str = ''
                                for i in range(len(lines)):
                                    for ii in range(len(lines[i])):
                                        # Take out the elements in the nested list and concatenate them into a string
                                        str += lines[i][ii] + ' '
                                    str += '\n'
                                # After traversal, delete the nested list in the previous list, and append the string
                                lines.clear()
                                lines.append(str)
                                # Write the updated list to a file
                                with open('user_books.txt', 'w') as wstream:
                                    wstream.writelines(lines)
                    else:
                        print("You have nothing in cart yet")

    except Exception as err:
        print("Error reason：", err)


# user account
def look_person_info(path, username):
    with open(path) as rstream:
        lines = rstream.readlines()
        for info in lines:
            # Split into a list
            info = info.split('   ')
            # print(info)
            if username in info:
                print("----User Account----")
                print("Username：", info[0])
                print("Email Address：", info[1])
                print("Password：", info[2].rstrip(' '))


# Modify Personal Information
def update_password(path, username):
    tips = input("Please choose an operation：\n 1.Modify Email Address\n 2.Change a password\n")

    # Modify email
    if tips == '1':
        new_email = ''
        line = []
        try:
            with open(path) as rstream:
                while True:
                    line = rstream.readline()
                    if not line:
                        break
                    line = line.split('   ')
                    # Remove the newline after the password
                    line[2] = line[2].rstrip('\n')
                    if username == line[0]:
                        new_email = input("Please enter a new email：")
                        line[1] = new_email
                        break
        except Exception as err:
            print(err)

        else:
            # Append all information of the user after the newly modified mailbox to the folder
            with open(path, 'a') as wstream:
                for i in range(len(line)):
                    if i == 0:
                        # To traverse the list, the first list element needs
                        # to be preceded by a newline, followed by a space and other elements
                        line[i] = '\n' + line[i] + '   '
                    else:
                        line[i] = line[i] + '   '
                wstream.writelines(line)
                print("Successfully modified")
            with open(path) as rstream:
                lines = rstream.readlines()
                i = 0
                l = len(lines)
                while i < l:
                    # When the current user name is in the user information line and the new email
                    # is not available, the previous user information will be deleted, and
                    # the information of other users will not be deleted
                    if username in lines[i] and new_email not in lines[i]:
                        lines.remove(lines[i])
                    i += 1
                    l -= 1
                # After deleting the current user information corresponding to the old mailbox,
                # the user information corresponding to the new mailbox and the information of other
                # users are rewritten to the file
                with open(path, 'w') as wstream:
                    wstream.writelines(lines)
    # change Password
    elif tips == '2':
        new_password = ''
        line = []
        try:
            with open(path) as rstream:
                while True:
                    line = rstream.readline()
                    if not line:
                        break
                    line = line.split('   ')
                    # Remove the newline after the password
                    line[2] = line[2].rstrip('\n')
                    if username == line[0]:
                        new_password = input("Please enter a new password：")
                        # Determine whether the new password is consistent with the old password
                        if new_password == line[2]:
                            # Throw an exception
                            raise Exception("The new password cannot be the same as the old password")
                        else:
                            line[2] = new_password
                            break
        # catch the exception
        except Exception as err:
            print(err)

        else:
            # Append all information of the user whose password has been changed to the folder
            with open(path, 'a') as wstream:
                for i in range(len(line)):
                    if i == 0:
                        # To traverse the list, the first list element needs to be preceded by a newline,
                        # followed by a space and other elements
                        line[i] = '\n' + line[i] + '   '
                    else:
                        line[i] = line[i] + '   '
                wstream.writelines(line)
                print("Successfully modified")
            # Delete the user's information before changing the password
            with open(path) as rstream:
                lines = rstream.readlines()
                i = 0
                l = len(lines)
                while i < l:
                    # When the current user name is in the user information line
                    # and the new password is not present, the previous user information
                    # will be deleted, and the information of other users will not be deleted
                    if username in lines[i] and new_password not in lines[i]:
                        lines.remove(lines[i])
                    i += 1
                    l -= 1
                # After deleting the current user information corresponding
                # to the old password, write the user information corresponding
                # to the new password and other user information to the file again
                with open(path, 'w') as wstream:
                    wstream.writelines(lines)


# User's account
def person_information(path, username):
    tips = input("Please select：\n 1.Check account information\n 2.Modify account information\n")
    if tips == '1':
        look_person_info(path, username)
    elif tips == '2':
        update_password(path, username)


# Only administrators can add, delete and modify books
def permission(user_path, username):
    try:
        with open(user_path) as rstream:
            while True:
                line = rstream.readline()
                if not line:
                    break
                line = line.split('   ')
                for i in range(len(line)):
                    line[i] = line[i].rstrip('\n')
                # Determine whether it is an administrator, if it is, you can add it
                if username == 'yuelin':
                    pass
                else:
                    print("Only the administrator {} can perform this operation".format(username))
                    # Not an administrator will return to the operation page
                    operate(path, username)
    except Exception as err:
        print("Error reason：", err)


# You have to have a book_path txt file before running this program
book_path = r'book.txt'


def operate(b_path, username):
    while True:
        msg = input("Please select:\n 1.Find books\n 2.Add Books\n 3.Modify books\n 4.Reomove books\n"
                    " 5.Add to cart\n 6.Buy books\n 7.User account\n 8.log out\n")
        # Find
        if msg == '1':
            find_books(book_path)
        # add
        elif msg == '2':
            add_book(b_path, username)
        # modify
        elif msg == '3':
            update_book(b_path, username)
        # delete
        elif msg == '4':
            del_book(b_path, username)
        # burrow
        elif msg == '5':
            add_cart(username)
        # return
        elif msg == '6':
            pay_book(username)
        # accound info
        elif msg == '7':
            person_information(path, username)

        # log out
        elif msg == '8':
            msg = input("Are you sure to log out？(yes/no)")
            if msg == 'yes':
                break


login()