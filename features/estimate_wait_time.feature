Feature: estimated wait time for help
  
  As a busy student
  So that I can decide whether to wait in line or not
  I want to know my estimated wait time
  
Background: student requests in database
 
  Given the following student queues exist:
  | first_name | last_name | sid        | meet_type   | status   | created_at              |
  | Salvador   | Villegas  | 25804240   | drop-in     | finished | 2012-09-10 14:44:24 UTC |
  | Maiki      | Rainton   | 00000000   | drop-in     | waiting  | 2011-09-10 14:44:24 UTC |
  | Nahrae     | Seok      | 25804241   | appointment | waiting  | 2013-09-10 14:44:24 UTC |
  | Alex       | Yang      | 25804242   | drop-in     | waiting  | 2014-09-10 14:44:24 UTC |

Scenario: students signs up for “drop-in”
  Given I am on the sign up page
  When I fill in the "student_requests" form and click "Submit"
  Then I should see a wait time of "60 min"

Scenario: student visits wait time page
  Given I am on the wait time page for "Alex" "Yang"
  Then I should see a wait time of "30 min"
  
#student email confirmation should have ability to cancel I think

