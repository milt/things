Feature: guest views things

  As a guest
  I want to view things
  So I can be enticed
  
  Scenario: view a thing
    When I view a thing
    Then I should see all of its attributes
    And I should be able to edit it
    And I should be able to go back
