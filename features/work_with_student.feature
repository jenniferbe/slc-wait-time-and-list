Feature: work with new student
  
  As a tutor
  So that I don't get fired
  I want to work with a new student
  
Background:
  Given I am on the app firewall page
  Then I fill in the password correctly for the app firewall page
  Given I am on the tutor firewall page
  Then I fill in the password correctly for the tutor firewall page

  Scenario: working with a student
  Given I am on the student line page
  When I edit student "Salvador"
  Then I should see "Salvador in progress"