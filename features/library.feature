@focus
Feature: Library

Scenario: Opening my Library
  Given I am on a new game page
    And my name is 'Player'
  Then I wait 1 second
  When I 'Browse' the 'Library' in my panel
  Then I should see 'Library' window with 60 cards
    And I should not see 'Library' in my panel