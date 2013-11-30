Feature: Admin Signing in

Scenario: Unsuccessful signin for admin
Given an admin visits the signin page
When he submits invalid signin information
Then he should see an error message

Scenario: Successful signin for admin
Given an admin visits the signin page
And the admin has an account
When the admin submits valid signin information
Then he should see the home page
And he should see a signout link
And he also should see the kiracı takip link