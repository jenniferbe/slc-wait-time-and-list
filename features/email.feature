
Feature: send email notification to student whose wait time is less than 30 mins

  As a student
  so that I won't miss meeting
  I want to receive an email when the meeting time is close


  Background: student requests in database

    Given I am on the app firewall page
    Then I fill in the password correctly for the app firewall page
#    Given I am on the tutor firewall page
#    Then I fill in the password correctly for the tutor firewall page


    Given the list of students with email:
      | first_name | last_name | sid        | meet_type   | status   | created_at              | email            |
      | Salvador   | Villegas  | 25804240   | drop-in     | finished | 2012-09-10 14:44:24 UTC | Sal@gmail.com    |
      | Maiki      | Rainton   | 00000000   | drop-in     | waiting  | 2011-09-10 14:44:24 UTC | Maiki@gmail.com  |
      | Nahrae     | Seok      | 25804241   | appointment | waiting  | 2013-09-10 14:44:24 UTC | Nah@gmail.com    |
      | Alex       | Yang      | 25804242   | drop-in     | waiting  | 2014-09-10 14:44:24 UTC | Alex@gmail.com   |
      | SJ         | Kwack     | 35804242   | drop-in     | waiting  | 2014-09-10 14:44:24 UTC | SJ@gmail.com     |




  Scenario: There are n tutors and a new student checked in and his/her waiting position is less than n, then get an email
    Given There are 6 tutors
    Given I am on the sign up page
    When I fill in the "student_requests" form and click "Submit"
    Then my waiting position should be 5
    Then I should receive an email

  Scenario: There are n tutors and a new student checked in and his/her waiting position is more than n, then won't get an email
    Given There are 3 tutors
    Given I am on the sign up page
    When I fill in the "student_requests" form and click "Submit"
    Then my waiting position should be 5
    Then I should receive no email

  Scenario: There are n tutors and a new student checked in and his/her waiting position is equal to n, then get an email
    Given There are 5 tutors
    Given I am on the sign up page
    When I fill in the "student_requests" form and click "Submit"
    Then my waiting position should be 5
    Then I should receive an email


  Scenario: There are n tutors and tutor picked up a student, then student in position n should get an email
    Given There are 3 tutors
    Given I am on the sign up page
    When I fill in the "student_requests" form and click "Submit"
    And Tutor picked up "Maiki"
    Then my waiting position should be 4
    Then I should receive an email

  Scenario: There are n tutors and tutor picked up a student, student in position less the # of tutor won't get an email
    Given There are 3 tutors
    Given I am on the sign up page
    When I fill in the "student_requests" form and click "Submit"
    And Tutor picked up "Maiki"
    Then my waiting position should be 4
    Then I should receive an email

  Scenario: There are n tutors and tutor picked up a student, student in position more than the # of tutor won't get an email
    Given There are 3 tutors
    Given I am on the sign up page
    When I fill in the "student_requests" form and click "Submit"
    And Tutor picked up "Maiki"
    Then my waiting position should be 4
    Then I should receive an email

