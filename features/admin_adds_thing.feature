Feature: admin adds thing

  As an admin
  I want to add a thing
  So it can be tracked

  Scenario: add a valid thing
    Given I am logged in
    And I am an admin
    When I add a new thing
    And I give valid parameters
    Then I should be returned to the index
    And I should see a confirmation message

  Scenario: add an invalid thing
    Given I am logged in
    And I am an admin
    When I add a new thing
    And I give invalid parameters
    Then I should be returned to the new page
    And I should see a description validation error
