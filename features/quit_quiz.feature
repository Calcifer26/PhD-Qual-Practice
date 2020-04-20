Feature: Take a quiz
As a PhD Qual user
I should be able to 

Scenario: Submit answers in quiz mode
Given the following questions exist:
  | question  | option1 | option2 | option3 | option4 | option5 | answer |     category     |
  |  QueCat1  |   AA    |   BB    |    CC   |   DD    |   EE    |   AA   |     Networks     |
  |  QueCat2  |   AA    |   BB    |    CC   |   DD    |   EE    |   BB   |    Algorithms    |
  |  QueCat3  |   AA    |   BB    |    CC   |   DD    |   EE    |   CC   |     Software     |
  |  QueCat4  |   AA    |   BB    |    CC   |   DD    |   EE    |   DD   | Operating System |
And I am on the home page

When I follow "Start Quiz"
Then I should be on Quiz Category page
When I choose radio button "All"
When I fill in "timervalue" with "1"
And I press "Start Quiz"
When I press "Quit"
# When I choose answer "1" on question "1"
# And I click "Next"
# And I choose answer "2" on question "2"
# And I click "Next"
# And I choose answer "3" on question "3"
# And I click "Next"
# And I choose answer "4" on question "4"
# And I click "Previous"
# And I choose answer "3" on question "2"
# And I click "Next"
# And I click "Next"
# And I Submit quiz
# Then I should see "Show Answer"