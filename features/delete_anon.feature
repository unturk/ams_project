Feature: deleting annocument

Scenario: Successful delete
Given an admin login the website about delete
And given there is a announcement in database
When the admin visit the announcement page about delete
Then the admin should be on announcement page about delete
When the admin clicks Delete announcement
Then the admin should not see announcement title
