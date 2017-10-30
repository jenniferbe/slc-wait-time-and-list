Feature: password protect data for tutor
  As a tutor
  So that no random user can see the queue data
  I want the queue data to be password protected

  Scenario: Sign in happy path
    Given I am on the sign in page
    When I fill in the password correctly
    And I should be on student queues page


  Scenario: Sign in sad path
    Given I am on the student sign in page
    When I fill in the password incorrectly
    Then I should be on the student sign in page
    And I should be told that the password is incorrect

  Scenario: Refresh happy path
    Given I am on the student queues page
    And I am signed in as a tutor
    And I am signed in to the app
    Then I should not be redirected
  Scenario: Refresh sad path 1 0
    Given I am on the student queues page
    And I am not signed in as a tutor
    And I am signed in to the app
    Then I should be redirected to the student sign in page

  Scenario: Refresh sad path 0 0
    Given I am on the student queues page
    And I am not signed in as a tutor
    And I am not signed in to the app
    Then I should be redirected to the app sign in page

  Scenario: Refresh sad path 0 1
    Given I am on the student queues page
    And I am not signed in to the app
    And I am signed in as a tutor
    Then I should be logged out as a tutor
    And I should be redirected to app sign in page