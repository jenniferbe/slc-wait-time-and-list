Feature: Specify Appointment Type

  As a tutor
  So that I can know what students to help
  I want students to specify what type of appointment they have

Background: student requests in database
  Given I am on the sign up page
  And I fill in "student_last_name" with "Kaunda"
  And I fill in "student_first_name" with "Haggai"
  And I fill in "student_sid" with "12345678"
  And I fill in "student_email" with "email@slc.com"
  And I select "English R1A" from "course"

Scenario: Specify drop-in
  And I click "meet_type_drop-in"
  When I press "Submit"
  Then I am on the wait time page for "Haggai" "Kaunda"
  And I follow "YES"
  Then I am on the student line page
  And I should see "Haggai Kaunda"

Scenario: Specify weekly
  And I click "meet_type_weekly"
  When I press "Submit"
  Then I should see "you are now in line!"
  When I am on the student line page
  Then I should see "Haggai Kaunda"

Scenario: Specify appointment
  And I click "meet_type_scheduled"
  When I press "Submit"
  Then I should see "you are now in line!"
  When I am on the student line page
  Then I should see "Haggai Kaunda"