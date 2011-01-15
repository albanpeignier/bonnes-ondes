Feature: Manage sessions
  In order to use Bonnes-Ondes services
  an user
  wants to open and close sessions
  
  Scenario: Open a new session
    Given I am on the new session page
    And an user "johndoe" exists with password "secret"
    And I fill in "login" with "johndoe"
    And I fill in "password" with "secret"
    When I press "S'identifier"
    Then I should be on the account page
    And I should see "Bienvenue sur votre compte"

  Scenario: Open a new session with a wrong password
    Given I am on the new session page
    And an user "johndoe" exists with password "secret"
    And I fill in "login" with "johndoe"
    And I fill in "password" with "wrong"
    When I press "S'identifier"
    Then I should be on the new session page
    And I should see "Mauvais login ou mot de passe"

  # FIXME compte/logout is called but the homepage has link to "Mon Compte"
  # Scenario: Close the current session
  #   Given I am logged in
  #   When I follow "Quitter"
  #   Then I should be on the homepage
  #   And I should see "Vous n'êtes plus connecté"

  Scenario: Retrieve a lost password
    Given I am on the new password page
    And an user "johndoe" exists with email "johndoe@nowhere.priv"
    And I fill in "email" with "johndoe@nowhere.priv"
    When I press "Envoyer"
    Then I should see "Votre nouveau de passe a été envoyé à johndoe@nowhere.priv"

  Scenario: Retrieve a password for an unknown email
    Given I am on the new password page
    And I fill in "email" with "nobody@nowhere.priv"
    When I press "Envoyer"
    Then I should see "Aucun compte Bonnes-Ondes ne correspond à cet email"
     
