__Bookers2__

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version
3.1.2

* Rails version
6.1.7.4

* Node.js, Yarn, ImageMagick, SQLite

_[Bookers2] is a website with user functionality where you can post your thoughts on books you've read._

[Bookers2] utilizes devise for creating user authentication functionality.
For new registrations, entering a username, email address, and password is required.
During login, entering a username and password is necessary.


Common Features for User Profile, User List, Post Detail, and Post List Screens:

On the left side of the content, user information and a post form are displayed.
User information includes a user image, username, introduction, follower count, and following count.
When viewing your own user profile, a link to the user information editing screen is provided.
When viewing another user's profile, a "Follow" button is displayed.

The post form allows users to submit their thoughts about a book.
Required fields for input are title and opinion.
Tags and ratings can also be added if desired.


Description of Each Screen:

User Profile Screen: The right side of the content displays a user image, title, opinion, tags, likes count, comment count, views count, and ratings. At the bottom, the user's reading frequency and the number of books they've posted reviews for are displayed.

User List Screen: The right side of the content displays each user's user image, name, follower count, following count, and a link to the user profile screen. Additionally, a "Follow" button for other users is displayed. At the top, links to create a group and navigate to the group list screen are provided.

Post Detail Screen: The right side of the content displays a user image, title, opinion, tags, likes count, comment count, and views count. Users can edit or delete their own posts from this screen. At the bottom, a comment form for the post is displayed.

Post List Screen: The right side of the content displays each user's user image, title, opinion, tags, likes count, comment count, views count, and ratings. Posts can be sorted by newest, highest rating, and most likes.

Please note that the translations provided here are based on the information you provided and may need to be reviewed for accuracy within the context of your application.
