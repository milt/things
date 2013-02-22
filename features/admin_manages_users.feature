Feature: admin manages users

  As an admin
  I want to manage user roles
  So I can feel in control

  Background:
    Given I am logged in as admin

  Scenario: admin sees list of users
    When I visit the users index
    Then I should see a list of users
    And I should see their roles

  Scenario: admin adds user

  Scenario: admin views user

  Scenario: admin edits user

  Scenario: admin deletes user