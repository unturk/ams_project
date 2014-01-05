Feature: adding new announcement

Scenario: Unsuccessful add
Given an admin login to website
When the admin visit announcement page
Then the admin should be on announcement page
When the admin clicks Add New Announcement
And the admin clicks Add Announcement
Then the admin should see an error message about Add New Announcement

Scenario: successful add
Given an admin login to website
When the admin visit announcement page
Then the admin should be on announcement page
When the admin clicks Add New Announcement
And the admin sumbit valid announcement information
And the admin clicks Add Announcement
Then the admin should see the announcement information

