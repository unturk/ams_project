Feature: View renter

Scenario: Showing renter information
Given an admin login the website about view
And given there is a renter in database about view
When the admin visit the renter page about view
When the admin clicks show button
Then the admin should see renter information