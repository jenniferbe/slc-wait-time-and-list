#152666180
Feature: students enter multiple appointments at a time.

  As a student,
  So that I can have a drop_in session while I wait for my weekly_appointment,
  I want to sign up for both at the same time

#move this into a step def
Background: student signed up for 3 appointments

  Given I am on the app firewall page
  Then I fill in the password correctly for the app firewall page
  Given I am on the tutor firewall page
  Then I fill in the password correctly for the tutor firewall page

Scenario: student signs up for multiple appointments
  Given "Salvador" "Villegas" is signed up for all three appointments
  When "Salvador" "Villegas" signs up for any of the three appointments again
  And I am on the student line page
  Then The tutors should see "3" appointments for "Salvador" "Villegas"
