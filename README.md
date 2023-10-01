# CSC_ECE_517_Fall2023_Program_2 - Rail Ticketing System

This application enables passengers to register for an account, and sign in using their email and password and then view trains and book tickets . Additionally, passengers have the option to provide feedback on the trains they've used and can explore train options and reviews through various methods

**Sign up today!**  
[http://152.7.177.61:8080/](http://152.7.177.61:8080/)

### Local Setup
- Ruby version: ruby 3.0.2
- Rails version: 6.1.7.6

To set up locally:
1. Run `bundle install`
2. Run `rails s`
3. Run `rails db:migrate`
4. Run `rails db:seed`

**Admin Credentials:**
- Username: admin@example.com
- Password: Admin@pass123

### How-to for Passengers
1. **Signup**
   - Click on signup on home page
   - Fill all the details as per the instructions provided
   - Click on create passenger

2. **Login**
   - Click on login link
   - enter the email with which you have signed up. If not signed-up. Do the sign-up first
   - enter your password
   - click on login button

3. **View details**
   - After logging in, click on the Show and Edit User Details link

4. **Edit details**
   - After logging in, click on on Show and Edit User Details link
   - Click on the Edit link
   - Update the details and click on update passenger button
   
5. **Delete Account**
    - Click on Delete Account link


6. **See the trains**
   - Click on Show Available Trains link
   - You should be able to see all the available trains
   - If you want to search by specific source or destination station or rating, add the appropriate values and click search. The trains will be updated

7. **Search Reviews**
    - Click on Search Reviews link
    - To Search by user, add the name of the passenger who's reviews you want to see
    - To Search by Train, add the train number of the train who's reviews you want to see
    - To see your own reviews, click on 'My Trips - Booking History and Reviews'. You should be able to see those under My Reviews section


8. **View your Tickets**
    - You can simply click on 'Show My Tickets' to view your own tickets as well as the ones you have booked for others.
    - Another way to view your tickets is to click on 'My Trips - Booking History and Reviews' and you will be able to see your ticket there


9. **Add a rating**
    - you can only add ratings to the trains which you have booked seats for
    - To add a rating, click on 'My Trips - Booking History and Reviews'. 
    - Add the reviews and ratings, besides your tickest.
    - click on submit review
    - your review should be visible under my reviews


10. **Book a train**
    - Click on Show Available Trains
    - Click on Book Train link, for the train which you want to book
    - You can either book ticket for yourself or other passengers.
    - To book a train for yourself, click on Book Ticket for yourself
    - Click on okay and then a ticket will be booked. You can see it under your tickets
    - To book for others, Click on Show Available Trains
    - Click on Book Train link, for the train which you want to book
    - Add the email of the passenger who has already signed up and click on Book for another passenger.

11. **Delete a Booking**
    - click on 'My Trips - Booking History and Reviews' and you will be able to see your ticket there
    - Click on cancel for that ticket
    - Your booking will be cancelled.

12. **Logout**
    - Click on logout


### How-to for Admins
1. 2. **Login**
   - Click on login link
   - enter the admin email
   - enter your password
   - click on login button

3. **View details**
   - After logging in, click on the Show and Edit Admin Details link

4. **Edit details**
   - After logging in, click on on Show and Edit Admin Details link
   - Click on the Edit link
   - Update the details and click on update passenger button

5. **Create new train**
    - Click on 'View all Trains'
    - Click on 'Add New Trains'
    - Add all the train details and then click on 'Create Train' button to create the train

6. **View train**
    - Click on 'View all Trains'
    - To filter by either Destination or Termination Station or both, add in the appropriate fields and then click on search
    - The table will be populated with filtered trains 

7. **Edit a Train**
    - Click on 'View all Trains'
    - Click on 'edit' link besides the train which you want to edit
    - Change the fields which you want to edit
    - Click on update train

8. **Delete a Train**
    - Click on 'View all Trains'
    - Click on 'destroy' link besides the train which you want to edit

9. **Create new passenger**
    - Click on 'View all passengers'
    - Click on 'Add New passengers'
    - Add all the passenger details and then click on 'Create passenger' button to create the passenger

10. **View passenger**
    - Click on 'View all passengers'
    - The table will be populated with all passengers 

11. **Edit a passenger**
    - Click on 'View all passengers'
    - Click on 'edit' link besides the passenger which you want to edit
    - Change the fields which you want to edit
    - Click on update passenger

12. **Delete a passenger**
    - Click on 'View all passengers'
    - Click on 'destroy' link besides the passenger which you want to edit


13. **View ticket**
    - Click on 'View all tickets'
    - The table will be populated with filtered tickets 

14. **Edit a ticket**
    - Click on 'View all tickets'
    - Click on 'edit' link besides the ticket which you want to edit
    - Change the field value
    - Click on update ticket

15. **Delete a ticket**
    - Click on 'View all tickets'
    - Click on 'destroy' link besides the ticket which you want to edit

16. **View review**
    - Click on 'View all reviews'
    - The table will be populated with filtered reviews 

17. **Edit a review**
    - Click on 'View all reviews'
    - Click on 'edit' link besides the review which you want to edit
    - Change the field value
    - Click on update review

18. **Delete a review**
    - Click on 'View all reviews'
    - Click on 'destroy' link besides the review which you want to edit

19. **Search Passengers for a particular train**
    - Click on Show users by train
    - Enter the train number
    - The passenger list will be populated
   