## Final Maker's Academy Project: NotaBene
NotaBene is an ed-tech product which encourages independent learning and is aimed at users of all ages and from any background/learning discipline. 
NotaBene has been created using Swift in an Xcode development environment and is designed to be used on iPhones. 
We have built our product and brought it to MVP status as part of our final two week project at the Makers Academy.

## About NotaBene
Our inspiration for NotaBene came from our time at Makers where independent learning and the process of learning to learn were emphasised.
Throughout this course, we found that taking good notes during workshops and while working on our challenges has been a really helpful part of the learning process. However, we would often misplace or forget to review them.
Most of us have already got Notes installed on our phones - but ours is different. NotaBene does more than just store your notes; it also reminds you to review and revise them.

## Team members
1. Olivia Beresford
2. Christine Horrocks
3. Chayya Syal
4. Canace Wong

## Tech used
1. Swift 4
2. Xcode 9.2
3. XP Values
4. BDD
5. Pair Programming
6. Firebase Database

## Features and Functionalities
1. Secure sign up, login and logout  functionalities
2. User can create single and multiple entries in their account
3. View all entries after login and after saving an entry
4. Successful CRUD cycle
5. Text containing hyperlinks automatically become a live link in an entry
6. User can create and set multiple reminders
7. Password reset option
8. User separation; you can’t see other users’ NotaBene accounts or entries
9. Option to upload multiple images from phone library
10. User can also save multiple images in an entry
11. Images can be expanded when in show-view

## Purpose of NotaBene
Students using our app will be able to :
Keep their notes securely in one place.
They will be able to write and read notes while both online and offline. 
Note will sync to Firebase to ensure that if your phone is lost your notes are not. 
Firebase also provides a significant amount of external memory, so you can write as many notes as you need. 
Learners are able to add multiple photos, for example of the classroom board, to each note.
And finally, you can set multiple reminders to ensure that you remember to review important points.

## How to use NotaBene
Create an account
Download NotaBene and open the app. 
You will then be taken to the login/signup page where you will be asked for your email address and password. 
Fill out our signup form and then use those details to login. 
Once logged in, you’ll see a blank page where your future entries will be listed. 

* Create an entry
Tap ‘+’ to create a new entry.
You will be taken to a blank page where you can give your entry a title and a text box where you can start writing your entry (it can be anything from writing a note from your keyboard, inserting hyperlinks or uploading photos from your phone).
Tap ‘done’ whenever you’re ready to save your entry. 
You will then be taken back to the homepage. You should now be able to see the title of your newly created entry. 

* View an entry
At the homepage you will either see a blank page or an entry (from the previous section).
To view it, simply tap the entry, and it will open your screen. You can then tap the text box to continue writing or tap ‘delete’ to remove it. 

* Add a Photo (in a new and/or existing entry)
Tap ‘+’ to create a new entry.
When the new entry page opens, scroll down and tap the ‘+’ on the images button.
You will be able to upload a photo from your phone's photo library.
Select the photos you want, and then tap ‘done’. Your photos should now appear in your entry.
Tap ‘save’ and you’ll be taken back to your list of entries.

* Add a Hyperlink (in a new and/or existing entry)
Tap ‘+’ to create a new entry.
When the new entry page opens, enter a title and tap the text box below it to start writing.
You can add a hyperlink alongside text in an entry by typing ‘www.’ or copying and pasting a link from your browser into the entry.
Tap ‘save’ and the hyperlink should be underlined and highlighted to show that it’s not a piece of text. 

* Set a reminder
You can set a reminder whenever you create an entry or add one to an existing entry.
After you’ve created an entry (following the previous instructions), scroll down to the bottom of your entry. 
You will see a button called ‘set reminder’ - go ahead and tap it!
You will then see a list of dates and times pop up; scroll through to pick a time and day which works for you.
Then tap ‘create reminder’.
Your reminder will then sound at the time and day you’ve picked - even when you’re not logged in!

You can also edit any reminders you’ve created by going into an entry, tapping ‘reminders’ to change the alert to the time/day that you want.

* Forgot your password?
Tap ‘forgot password’ at the login page.
You’ll be asked to enter your email address so that we can send you a link to reset your password.
You should then receive a link in your email inbox (if it’s not there check your spam box).
Click the link which will then take you to our password reset page.
Enter your new password and log back into NotaBene to carry on creating entries!

Congratulations! You’re officially a NotaBener!

## Work Method
NotaBene was built using the Xcode development environment and Swift. The backend database was created using Firebase. 

The architecture of our dataflow is relatively straightforward, though getting it to follow the flow was not!

When working online, the login data first flows to Firebase, which checks the authorisation.
Firebase will then send all the information pertaining to existing entries back to the app to then display in the table.
When a new entry is created the data then flows back to update the Firebase database, which then sends the updated information back to be displayed in the app.
Viewing and editing entries is a little different as instead of retrieving the data from the database it actually persists over the app segue. However, once changes are made it does head straight back to the database to update it. 
Finally the data once again flows from Firebase to the table

## Additional features
In the time limit that we had, there were additional features which we wanted to include in NotaBene, but were unable to.
If we had more time, we would have added the following features:

1.Search bar in an entry which allows a user to filter current entries by letters or words to find the one they want
2. Add in a rating system which allows a user to rate an entry on how useful it was to their learning
3. The rating system would then influence the entries homepage so that the most useful entries would be listed first
4. Add in code snippets where users can copy and paste chunks of code into an entry. In these snippets, key words would change colour like they do in Ruby, JavaScript etc.

## Conclusion
As a team we faced several challenges while creating NotaBene, from working in an unfamiliar dev environment to learning a new language as we were building the app. 
Overall we are happy with our product. It works, is secure, is user friendly and is a useful product which will be of benefit to students from any disciple/level of learning. 

