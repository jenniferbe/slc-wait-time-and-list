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


  Given the following student queues exist:
    | first_name | last_name | sid        | meet_type  | status  | created_at              |
    | Salvador   | Villegas  | 25804240   | drop-in    | waiting | 2012-09-10 14:44:24 UTC |
    | Salvador   | Villegas  | 25804240   | scheduled  | waiting | 2012-09-10 14:44:24 UTC |
    | Salvador   | Villegas  | 25804240   | weekly     | waiting | 2012-09-10 14:44:24 UTC |

Scenario: student signs up for multiple appointments
  Given "Salvador" "Villegas" is signed up for all three appointments
  When "Salvador" "Villegas" signs up for all three appointments again
  Then The tutors should see "6" appointments for "Salvador" "Villegas"
