Feature: admin edits thing

  As an admin
  I want to edit a thing
  So it has the right info
  
  Background:
    Given I am logged in as admin

  Scenario: edit a thing with valid info
    When I edit a thing with valid parameters
    Then I should be redirected to the thing
    And I should see a confirmation message that it was edited

  Scenario: edit a thing with invalid info
    When I edit a thing with invalid parameters
    Then I should be returned to the edit page
    And I should see a validation error
