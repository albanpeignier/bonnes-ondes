Feature: Manage images
  In order to illustrate his work
  an user
  wants to add, associate and destroy images

  Background:
  Given I am logged in
  And a show "test" exists with name "Nom de mon émission"
           
  Scenario: Go to the new image page from show page
  Given I am on the "test" show page
  When I follow "Ajouter une nouvelle image"
  Then I should be on the new image page of "test" show

  # FIXME Image is not valid 
  # Scenario: Create a new image
  # Given I am on the new image page of "test" show
  # And I fill in "image[title]" with "Titre de mon image"
  # And I attach the image file at "image.jpg" to "image[uploaded_data]"
  # When I press "Créer" 
  # Then I should be on the images page of "test" show 
  # And I should see "L'image est ajoutée"
  # And I should see "Titre de mon image"

  Scenario: Go to images page from show page
  Given I am on the "test" show page
  When I follow "Toutes les images"
  Then I should be on the images page of "test" show

  Scenario: See the show images
  Given the following images exist for "test" show
  | title  | 
  | Image 1 |
  | Image 2 |
  When I am on the images page of "test" show
  Then I should see "Image 1"
  And I should see "Image 2"

  Scenario: Go to the image page from show images page
  Given a image "Image Title" exists for "test" show
  And I am on the images page of "test" show
  When I follow "Image Title" 
  Then I should be on the "Image Title" image page of "test" show 

  Scenario: Destroy an image
  Given a image "test" exists for "test" show
  And I am on the "test" image page of "test" show
  When I follow "Supprimer"
  Then the image "test" for show "test" should not exist
  And I should be on the images page of "test" show
  
