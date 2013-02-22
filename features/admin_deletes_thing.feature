Feature: admin deletes thing

  As an admin
  I want to delete a thing
  So it will go away
  
  Background:
    Given I am logged in as admin

  Scenario: delete a thing
    When I delete a thing
    Then I should be redirected to the index