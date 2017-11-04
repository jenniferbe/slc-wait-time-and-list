Feature: Specify Appointment Type

  As a tutor
  So that I can know what students to help
  I want students to specify what type of appointment they have
Background:
  Given I am on the app firewall page
  Then I fill in the password correctly for the app firewall page
  Given I am on the tutor firewall page
  Then I fill in the password correctly for the tutor firewall page

  Scenario: Specify drop-in
  Given I am on the sign up page
  And I specify "drop-in"
  When I fill in the "student_requests" form and click "Submit"
  Then I should see a wait time

Scenario: Specify weekly
  Given I am on the sign up page
  And I specify "weekly"
  When I fill in the "student_requests" form and click "Submit"
  Then I should see "thanks"

Scenario: Specify appointment
  Given I am on the sign up page
  And I specify "appointment"
  When I fill in the "student_requests" form and click "Submit"
  Then I should see "thanks"