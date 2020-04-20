Feature: Email verification
As a PhD Qual user
So that I can verify the account whenever I create new user.
A verify account functionality must be present

Scenario: I should get email verification message
Given I am on the register page
When I fill in "user_name" with "test"
And I fill in "user_email" with "test@test.com" 
And I fill in "user_password" with "password12323!" 
And I fill in "user_password_confirmation" with "password12323!" 
And I press "Register"
Then I should see "Please verify your email."
