Feature: admin manages things

  As an admin
  I want to manage things
  So they can be tracked
  
  Background:
    Given I am logged in as admin

  Scenario: add a valid thing
    Given I am at the things index page
    When I add a new thing with valid parameters
    Then I should be redirected to the thing
    And I should see a confirmation message that it was created

  Scenario: add an invalid thing
    Given I am at the things index page
    When I add a new thing with invalid parameters
    Then I should be returned to the new page
    And I should see a description validation error

  Scenario: view a thing
    When I view a thing
    Then I should see all of its attributes
    And I should be able to edit it
    And I should be able to go back

  Scenario: edit a thing with valid info
    When I edit a thing with valid parameters
    Then I should be redirected to the thing
    And I should see a confirmation message that it was edited

  Scenario: edit a thing with invalid info
    When I edit a thing with invalid parameters
    Then I should be returned to the edit page
    And I should see a validation error

  Scenario: delete a thing
    When I delete a thing
    Then I should be redirected to the index