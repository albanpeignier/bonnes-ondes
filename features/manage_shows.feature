Feature: Manage shows
  In order to publish his works
  an user
  wants to create, edit and destroy shows
  
  Scenario: Create a new show
  Given I am logged in
  And I am on the new show page
  And I fill in "show_name" with "Nom de mon émission"
  And I fill in "show_slug" with "test"
  And I fill in "description" with "Description de mon émission"
  When I press "Créer"
  Then I should be on the "test" show page 
  And I should see "Votre émission est créée"
  And I should see "Nom de mon émission"
  And I should see "Description de mon émission"

  Scenario: Show must be accessible in sidebar
  Given I am logged in
  And a show "test" exists with name "Nom de mon émission"
  And I am on the account page
  When I follow "Nom de mon émission"
  Then I should be on the "test" show page

  Scenario: Destroy a show
  Given I am logged in
  And a show "test" exists with name "Nom de mon émission"
  And I am on the "test" show page
  When I follow "Supprimer"
  Then the show "test" should not exist
  And I should be on the account page

  Scenario: Go to edit page from show page
  Given I am logged in
  And a show "test" exists with name "Nom de mon émission"
  And I am on the "test" show page
  When I follow "Modifier"
  Then I should be on the edit "test" show page

  Scenario: Edit a show
  Given I am logged in
  And a show "test" exists with name "Nom de mon émission"
  And I am on the edit "test" show page
  And I fill in "show_name" with "Nouveau nom"
  And I fill in "show_description" with "Nouvelle description"
  When I press "Modifier"
  Then I should be on the "test" show page
  And I should see "Nouveau nom"
  And I should see "Nouvelle description"
  And I should see "Votre émission est modifiée"
  
  Scenario: Go to edit show logo page from show page
  Given I am logged in
  And a show "test" exists with name "Nom de mon émission"
  And I am on the "test" show page
  When I follow "Logo"
  Then I should be on the edit "test" show logo page

  Scenario: Edit show logo page when no image exists
  Given I am logged in
  And a show "test" exists with name "Nom de mon émission"
  When I am on the edit "test" show logo page
  Then I should see "Vous n'avez pas encore ajouter d'image dans votre émission" 
  And I should see "Ajouter une nouvelle image"
