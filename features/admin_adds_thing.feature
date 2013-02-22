Feature: admin adds thing

  As an admin
  I want to add a thing
  So it can be tracked
  
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
