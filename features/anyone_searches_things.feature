Feature: anyone searches things

  As anyone
  I want to search things
  So I can learn about them

  Background:
    Given I am at the things index page
    Given that there are things in the database

  Scenario: seach for a thing
    When I type in the search box
    Then I should see results below
