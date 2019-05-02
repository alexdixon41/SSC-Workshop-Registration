# SSC-Workshop-Registration
Simple registration management application for iOS, made for CSC 308

<h2>How to use: </h2>

<h3>Login: </h3>
On the first scene, press the login button, then enter the credentials below:
<br><br>
username: asdf@yahoo.com

password: 123456789

<h3>Register for an event</h3>
After logging in, the first scene will display all available events to register for. 

Once you select an event in the TableView, you will see the information about that event including all of the times it is happening.

Press the register button next to one of the listed times to register for the event. An alert will display whether the registration was successful or not.

You can now see this event in the Registered tab.
<h3>Viewing registered events</h3>
After registering for events, press the second tab, "Registered", to see all events that have been registered for.

Pressing the accessory button for an event in the TableView will display an alert with the information for that event, including which time was registered.

<h3>Viewing the Chellgren Success Series webpage</h3>
Pressing the third tab, "Website", will display the website for the Chellgren Success Series workshops on the EKU Student Success Center page.

<h3>Sign out of user account</h3>
Pressing the fourth tab, "Account", will display the account options. Press "Log out" to log out and return to the login screen.

<br><br>
<h4>Additional techniques used:</h4>
<li>Version control with Git, remote repository on GitHub (https://github.com/alexdixon41/SSC-Workshop-Registration/)</li>
<li>Firebase Auth for user authorization and login UI. Users can sign in with an email address and password.</li>
<li>Firebase real-time database for storing event information. Events are synced with the Firebase project database.</li>


<h4>References:</h4>
The Firebase iOS tutorials for setting up Firebase integration, user authentication, sign-in UI, and real-time database, including code examples
  https://firebase.google.com/docs/guides
