Feature: adding new renter

Scenario: Unsuccessful add
Given an admin login the website
When the admin visit the renter page
Then the admin should be on renter page
When the admin clicks Add New Renter
And the admin clicks Add Renter
Then the admin should see an error message about Add New Renter

Scenario: Successful add
Given an admin login the website
When the admin visit the renter page
Then the admin should be on renter page
When the admin clicks Add New Renter
And the admin sumbit valid renter information