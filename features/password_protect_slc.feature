Feature: password protect slc sign in
As a SLC admin
So that students must sign in physically at the SLC
I want the sign in portal to be password protected
Scenario: Sign in happy path
  Given I am on the app sign in page
  When I fill in the password correctly
  Then I should be on the student sign in page


Scenario: Sign in sad path
  Given I am on the app sign in page
  When I fill in the password incorrectly
  Then I should be on app sign in page
  And I should be told that the password is incorrect

Scenario: Refresh happy path
  Given I am on the student sign in page
  And I am signed in to the app
  Then I should not be redirected
Scenario: Refresh sad path
  Given I am on the student sign in page
  And I am not signed in to the app
  Then I should be redirected to the password login