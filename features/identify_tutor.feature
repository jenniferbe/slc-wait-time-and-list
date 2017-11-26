#152666105
Feature: identify tutor.

  As an Admin,
  So that I can know which students a tutor worked with,
  I want tutors to be uniquely identified when they work with students.

Scenario: tutor identified when working with student
  Given "Salvador" "Villegas" is signed up for all three appointments
  And  I am on duty tutoring
  When I click "Activate" for "Villegas" "Salvador" with id "0"
  Then I should see my name on tutor for "Villegas" "Salvador" with id "0" under "Active Session"