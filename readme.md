# News

Implemented Below Features:
- Used Combine to fetch the network data
- Used Combine and changing the font color to red for each article that are from today

Implemented Below Extra Credit Features:
- Added a login screen (with a log out button) with the user email and password, and saving a list of the articles that the user pressed for each user (The item store in CoreData). Next time when user is log in, he sees the article that he pressed before already grayed out.

Imp Points:
- Used MVVM pattern
- Used CoreData to save and retrieve the details from DB

App Contains Below Screens:
- Login Screen
	- Users has to provide email, password to login.
    - If email is already availabe if he give wrong password then it will show alert for correct password.
    - If email is not availabe then it will treat that as new user.
- News List Screen
	- Users can see list of news articles
    - If user read the article then it will grayed out
- News Details Screen
	- User can see the more details of the news


App screenshots:
<img width="1273" alt="Screenshot 2022-03-30 at 8 38 01 AM" src="https://user-images.githubusercontent.com/2841433/160743559-dc5a80a1-e219-4870-baf0-07b8b0d552e5.png">
