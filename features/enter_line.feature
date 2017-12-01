Feature: enter line for help
  
  As a student
  So that I can receive help with my writing
  I want to get in line
  
Background:Jennifer Signs In
  Given I am on the app firewall page
  Then I fill in the password correctly for the app firewall page

  Given I am on the sign up page
  And I fill in "student_last_name" with "Be"
  And I fill in "student_first_name" with "Jennifer"
  And I fill in "student_sid" with "12345678"
  And I fill in "student_email" with "me@jennifer.com"
  And I select "English R1A" from "course"
  And I click "meet_type_drop-in"
  And I press "Submit"

Scenario: Jennifer wants to wait in line
  And she clicks on "YES"
  Then she should be on the student page
  And she should see "you are now in line!"
  Then "Jennifer" "Be" should be in line
  And she should not see "Hope to see you soon"

Scenario: Jennifer doesn't want to wait in line
  And she clicks on "NO"
  Then she should be on the student page
  And she should see "you are not in line"
  Then "Jennifer" "Be" should not be in line
  And she should not see "you are in line"
  

#have to rethink this senario because current implementation won't let 
#jennifer get to the wait time page. But maybe we should show her wait time
#if she attempts to sign up again.

# Scenario: Jennifer Be wants to sign up but is already in the line
#   Given "Jennifer" "Be" is already in line
#   Given "Jennifer" "Be" is on the wait time page
#   Given she clicks on "yes"
#   Then she should be not be on the confirmation page
#   And "Jennifer" "Be" should see "You are already in line Jennifer"
  
  