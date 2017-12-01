Feature: update active session
  
  As a SLC admin
  So that I can keep track of what the tutors are doing
  I want to see which tutors have an active session
  
  
Background: student requests in database

  Given I am on the app firewall page
  Then I fill in the password correctly for the app firewall page
  Given I am a new, authenticated user
  Given the following student queues exist:
  | first_name | last_name | sid        | meet_type   | status   | created_at              |
  | Salvador   | Villegas  | 25804240   | drop-in     | finished | 2012-09-10 14:44:24 UTC |
  | Maiki      | Rainton   | 00000000   | drop-in     | waiting  | 2011-09-10 14:44:24 UTC |
  | Nahrae     | Seok      | 25804241   | appointment | waiting  | 2013-09-10 14:44:24 UTC |
  | Alex       | Yang      | 25804242   | drop-in     | waiting  | 2014-09-10 14:44:24 UTC |
  
Scenario: tutor starts session with student
  Given I am on the student line page
  When I click "Activate" for "0" with meet_type "drop-in"
  Then I should see "Maiki" in "active_sessions"
  
Scenario: no students in queue
  Given I am on the student line page
  When I help all the students
  Then I should not see "Activate"
  
Scenario: tutor ends active session for student
  Given I am on the student line page
  When I click "Activate" for "0" with meet_type "drop-in"
  And I click "Finish" for "0" with meet_type "drop-in"
  Then I should not see "Maiki"
  
Scenario: no active sessions
  Given I am on the student line page
  Then I should not see "Finish"