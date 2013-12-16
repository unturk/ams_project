Feature: deleting renter

Scenario: Successful delete
Given an admin login the website about delete
And given there is a renter in database
When the admin visit the renter page about delete
Then the admin should be on renter page about delete
When the admin clicks Delete Renter
Then the admin should not see renter name