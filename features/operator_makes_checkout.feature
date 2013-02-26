Feature: operator makes checkout

  As an operator
  I want to check things out to students
  So I they can take them away
  
  Background:
    Given I am logged in as operator
    And I visit the new checkout page

  Scenario: select a patron
    When I search for a patron
    And I select a patron
    Then the patron should be selected
    And I should see their info

  Scenario: select a return time

  Scenario: add a thing to the checkout
    When I search for a thing
    And I select the thing
    Then I should see its availability

  Scenario: remove a thing from the checkout

