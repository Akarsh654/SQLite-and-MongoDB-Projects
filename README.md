# CMPUT291-MiniProjects


[SQLite Project](https://github.com/Akarsh654/SQLite-and-MongoDB-Projects/tree/main/MiniProject1%20(SQLite)):
To run the project the user can type python3 miniproj1.py -i filename.db on their command line where filename.db is the name of the database supplied.  
The system begins with a login screen that prompts the user to select and option from:            
1 - Sign up  
2 - Login  
3 – Logout  
The user must type the number 1 or 2 or 3 to select an action.   
For every invalid user input throughout the program, the program displays an error message and prompts the user to enter a valid input.   
 
* If the user selects option 1: The user is prompted to enter a uid which starts with u and is 4 characters longs.  The user is prompted to enter their name.  The user is prompted to enter a password twice.  Then the user is asked which city they live in. Then a thank you message displays and the user is brought back to the login screen. 
* If the user selects option 2: The user is prompted to enter their uid. The user is prompted to enter their password. If the password is correct an interface for the tasks menu appears and the user has to select which task they want to perform. The task menu contains 5 options for a normal user (4 tasks and an option to logout) while the task menu for a privileged user contains 9 options (8 tasks and an option to logout). 
* If the user selects option 3 they logout

The task menu options include:
1.  Post a question
2.  Search for posts
3.  Post action-Answer
4.  Post action-Vote
5.  Post action-Mark as the accepted
6.  Post action-Give a badge
7.  Post action-Add a tag
8.  Post Action-Edit
9.  Logout

<hr>

[MongoDB Project](https://github.com/Akarsh654/SQLite-and-MongoDB-Projects/tree/main/MiniProject2%20(MongoDB)):
This project has 2 phases. 

In Phase1 the system begins by asking the user for the port number they wish to connect to then the database is built from the json files. An array called tags is created for every post which contains every word in the title and body. An index is built on this array to facilitate faster searching.  

The overall time to complete the Phase1 was optimized and we managed to bring it down from 15 minutes to about 3 minutes.

 
In Phase2 the system begins by asking the user for the port number they wish to connect to.  
Then the user is asked if they wish to provide a userid. The user must type y or n to select an action.   
For every invalid user input throughout the program, the program displays an error message and prompts the user to enter a valid input.   
 
If the user selects y: The user is prompted to enter a uid and the user report is displayed.   
Then the menu options are displayed. The task menu contains 6 options, one for each task and one to exit the program.  
If the user selects exit at any point in the program then a goodbye message is displayed and the program is terminated.  

The task menu options include:  
1.  Post a question
2.  Search for questions
3.  Question action-Answer
4.  Question action- List Answers
5.  Post action-Vote
6.  Exit
