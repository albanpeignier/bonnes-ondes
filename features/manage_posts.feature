Feature: Manage posts
  In order to promote his work
  an user
  wants to create, edit and destroy posts

  Background:
  Given I am logged in
  And a show "test" exists with name "Nom de mon émission"
  
  Scenario: Go to the new post page from show page
  Given I am on the "test" show page
  When I follow "Ajouter une information"
  Then I should be on the new post page of "test" show

  Scenario: Create a new post
  Given I am on the new post page of "test" show
  And I fill in "title" with "Titre de mon info"
  And I fill in "slug" with "test"
  And I fill in "description" with "Description de mon info"
  When I press "Créer"
  Then I should be on the "test" post page of "test" show
  And I should see "Votre information est ajoutée"
  And I should see "Titre de mon info"
  And I should see "Description de mon info"

  Scenario: Edit a post
  Given a post "test" exists for "test" show
  And I am on the edit "test" post page of "test" show
  And I fill in "title" with "Nouveau titre de mon info"
  And I fill in "description" with "Nouvelle description de mon info"
  When I press "Modifier"
  Then I should be on the "test" post page of "test" show 
  And I should see "Votre information a été modifiée"
  And I should see "Nouveau titre de mon info"
  And I should see "Nouvelle description de mon info"

  Scenario: Cancel post editing
  Given a post "test" exists for "test" show
  And I am on the edit "test" post page of "test" show
  When I follow "revenir"
  Then I should be on the "test" post page of "test" show 

  Scenario: See the last posts in show page
  Given a post "test" with title "Last updated title" exists for "test" show
  And I am on the "test" show page
  Then I should see "Informations"
  And I should see "Last updated title"

  Scenario: Go to posts page from show page
  Given I am on the "test" show page
  When I follow "Tous les informations"
  Then I should be on the posts page of "test" show

  Scenario: See the show posts
  Given the following posts exist for "test" show
  | title  | description   |
  | Titre 1 | Description 1 |
  | Titre 2 | Description 2 |
  When I am on the posts page of "test" show
  Then I should see "Titre 1"
  And I should see "Titre 2"

  Scenario: Go to the post page from show posts page
  Given a post "test" with title "Post Title" exists for "test" show
  And I am on the posts page of "test" show
  When I follow "Post Title" 
  Then I should be on the "test" post page of "test" show 

  Scenario: Go to the edit post page from show posts page
  Given a post "test" exists for "test" show
  And I am on the "test" post page of "test" show
  When I follow "Modifier" 
  Then I should be on the edit "test" post page of "test" show 

  Scenario: Destroy a post
  Given a post "test" exists for "test" show
  And I am on the "test" post page of "test" show
  When I follow "Supprimer"
  Then the post "test" for show "test" should not exist
  And I should be on the posts page of "test" show
