Feature: request

Scenario: Unsuccessful request
Given an user login the website
When the user visit the request page
Then the user should be on request page
When the user clicks button for send
Then the user should see error message for send

Scenario: Successful request
Given an user login the website
When the user visit the request page
Then the user should be on request page
When the user fills in valid form
Then the user should see success message
