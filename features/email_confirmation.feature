Feature: send email notification to student whose wait time is less than 30 mins

  As a student
  so that I won't miss meeting
  I want to receive an email when the meeting time is close


  Background: Jeno signs in and His waiting number is 4
    Given the following student queues exist:
      | first_name | last_name | sid        | meet_type   | status   | created_at              |
      | Salvador   | Villegas  | 25804240   | drop-in     | waiting  | 2012-09-10 14:44:24 UTC |
      | Maiki      | Rainton   | 00000000   | drop-in     | waiting  | 2011-09-10 14:44:24 UTC |
      | Nahrae     | Seok      | 25804241   | drop-in     | waiting  | 2013-09-10 14:44:24 UTC |
      | Jeno       | Seok      | 25804243   | drop-in     | waiting  | 2013-09-10 14:44:24 UTC |

  Scenario: There are n tutors and tutor picked up a student, then student in position n should get an email
    Given There are 3 tutors
    And Tutor picked up "Salvador"
    Then "Jeno" 's waiting position should be 3
    Then "Jeno" should receive an email


  Scenario: There are n tutors and tutor picked up a student, student in position less the # of tutor won't get an email
    Given There are 4 tutors
    And Tutor picked up "Salvador"
    Then "Jeno" 's waiting position should be 3
    Then "Jeno" should not receive an email

  Scenario: There are n tutors and tutor picked up a student, student in position more than the # of tutor won't get an email
    Given There are 2 tutors
    And Tutor picked up "Salvador"
    Then "Jeno" 's waiting position should be 3
    Then "Jeno" should not receive an email

  Scenario: There are n tutors and a new student checked in and his/her waiting position is less than n, then get an email
    Given There are 6 tutors
    And "Ray" checked in
    Then "Ray" 's waiting position should be 5
    Then "Ray" should receive an email

  Scenario: There are n tutors and a new student checked in and his/her waiting position is more than n, then won't get an email
    Given There are 3 tutors
    And "Ray" checked in
    Then "Ray" 's waiting position should be 5
    Then "Ray" should not receive an email

  Scenario: There are n tutors and a new student checked in and his/her waiting position is equal to n, then get an email
    Given There are 5 tutors
    And "Ray" checked in
    Then "Ray" 's waiting position should be 5
    Then "Ray" should receive an email


  Scenario: email content
    Given There are 3 tutors
    And Tutor picked up "Salvador"
    Then "Jeno" should receive an email
    When "Jeno" open the email
    Then "Jeno" should see "Your tutoring will be start in 30 mins" in the email subject