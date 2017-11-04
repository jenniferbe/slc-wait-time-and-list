Feature: estimated wait time for help
  
  As a busy student
  So that I can decide whether to wait in line or not
  I want to know my estimated wait time
  
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

Scenario: students signs up for “drop-in”
  Given I am on the sign up page
  When I fill in the "student_requests" form and click "Submit"
  Then I should see a wait time of "120 min"

Scenario: student visits wait time page
  Given I am on the wait time page for "Alex" "Yang"
  Then I should see a wait time of "90 min"
  
#student email confirmation should have ability to cancel I think

