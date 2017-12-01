Feature: record start and end times
  
  As a tutor
  So that I can report accurate wait times
  I want to record start and end times
  Background:
    Given I am on the app firewall page
    Then I fill in the password correctly for the app firewall page
#    Given I am on the tutor firewall page
#    Then I fill in the password correctly for the tutor firewall page

  Scenario: record times
  Given I am logged in as a tutor
  And I am on the student line page
  When I fill in "start" and "end" times with "0" and "0"
  Then I should see "start" filled with "0" and "end" filled with "0"
