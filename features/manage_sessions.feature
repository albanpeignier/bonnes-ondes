Feature: Manage sessions
  In order to use Bonnes-Ondes services
  an user
  wants to open and close sessions
  
  Scenario: Open a new session
    Given I am on the new session page
    And an user "johndoe" exists with password "secret"
    And I fill in "login" with "johndoe"
    And I fill in "password" with "secret"
    When I press "Log in"
    Then I should be on the account page
    And I should see "Bienvenue sur votre compte"

  Scenario: Open a new session with a wrong password
    Given I am on the new session page
    And an user "johndoe" exists with password "secret"
    And I fill in "login" with "johndoe"
    And I fill in "password" with "wrong"
    When I press "Log in"
    Then I should be on the new session page
    And I should see "Mauvais login ou mot de passe"

  Scenario: Close the current session
    Given I am logged in
    When I follow "Quitter"
    Then I should be on the homepage
    And I should see "Vous n'êtes plus connecté"
