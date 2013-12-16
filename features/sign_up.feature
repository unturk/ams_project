Feature: Signing up

Scenario: Unsuccessful signup
Given a visiter goes to register page
When she submits invalid signup form
Then she should see an error message about signup
And she should stay in the register page

Scenario: Successful signup
Given a visiter goes to register page
When the user submits valid signup form
Then she should see a welcome message
And she should redirected to signin page