Feature: work with new student
  
  As a tutor
  So that I don't get fired
  I want to work with a new student
  
Background:
  Given I am on the app firewall page
  Then I fill in the password correctly for the app firewall page
#  Given I am on the tutor firewall page
#  Then I fill in the password correctly for the tutor firewall page

Scenario: working with a student
  Given the following student queues exist:
    | first_name | last_name | sid        | meet_type   | status   | created_at              |
    | Salvador   | Villegas  | 25804240   | waiting     | active_sessions | 2012-09-10 14:44:24 UTC |
  And I am on the student line page
  When I edit student "Salvador"
  Then I should see "Salvador in progress"

Scenario: Finish Working with student
  Given the following student queues exist:
    | first_name | last_name | sid        | meet_type   | status   | created_at              |
    | Salvador   | Villegas  | 25804240   | active     | active_sessions | 2012-09-10 14:44:24 UTC |
  And I am on the student line page
  When I click "Finish" on "Salvador"
  Then I should not see "Salvador"