Feature: Take a quiz
As a PhD Qual user
I should be able to 

Scenario: Quit the session in quiz mode
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

Scenario: Quit the session in pratice mode
Given the following questions exist:
  | question  | option1 | option2 | option3 | option4 | option5 | answer |     category     |
  |  QueCat1  |   AA    |   BB    |    CC   |   DD    |   EE    |   AA   |     Networks     |
  |  QueCat2  |   AA    |   BB    |    CC   |   DD    |   EE    |   BB   |    Algorithms    |
  |  QueCat3  |   AA    |   BB    |    CC   |   DD    |   EE    |   CC   |     Software     |
  |  QueCat4  |   AA    |   BB    |    CC   |   DD    |   EE    |   DD   | Operating System |
And I am on the home page

When I follow "Start Practice"
Then I should be on Pratice Category page
When I check the checkbox "Networks"
When I check the checkbox "Algorithms"
When I press "Start Practice"
When I press "Quit"