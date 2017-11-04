Feature: update active session
  
  As a SLC admin
  So that I can keep track of what the tutors are doing
  I want to see which tutors have an active session
  
  
Background: student requests in database

  Given I am on the app firewall page
  Then I fill in the password correctly for the app firewall page
  Given I am on the tutor firewall page
  Then I fill in the password correctly for the tutor firewall page
 
  Given the following student queues exist:
  | first_name | last_name | sid        |
  | Salvador   | Villegas  | 25804240   |
  | Maiki      | Rainton   | 00000000   |
  | Nahrae     | Seok      | 25804241   |
  | Alex       | Yang      | 25804242   |
  
Scenario: tutor starts session with student
  Given I am on the student line page
  When I click "help" for "Salvador"
  Then I should see "Salvador" in "Active Sessions"
  
Scenario: no students in queue
  Given I am on the student line page
  When I help all the students
  Then I should not see "help"
  
Scenario: tutor ends active session for student
  Given I am on the student line page
  When I click "help" for "Salvador"
  And I click "end" for "Salvador"
  Then I should not see "Salvador"
  
Scenario: no active sessions
  Given I am on the student line page
  Then I should not see "end"