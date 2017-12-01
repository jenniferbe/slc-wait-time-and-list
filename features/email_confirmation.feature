Feature: send email confirmation to student first in line

As a tutor
So students get an idea of updated wait time
An email should be sent to the next student before his turn

Background: student requests in database

  Given I am on the app firewall page
  Then I fill in the password correctly for the app firewall page
#  Given I am on the tutor firewall page
#  Then I fill in the password correctly for the tutor firewall page


  Given the following student queues exist:
  | first_name | last_name | sid        | meet_type   | status   | created_at              |
  | Salvador   | Villegas  | 25804240   | drop-in     | finished | 2012-09-10 14:44:24 UTC |
  | Maiki      | Rainton   | 00000000   | drop-in     | waiting  | 2011-09-10 14:44:24 UTC |
  | Nahrae     | Seok      | 25804241   | appointment | waiting  | 2013-09-10 14:44:24 UTC |
  | Alex       | Yang      | 25804242   | drop-in     | waiting  | 2014-09-10 14:44:24 UTC |


Scenario: tutor picks up a new student at beginning
  Given I pick up a new student
  And no students have been sent emails
  Then the next student in the queue should receive an email


Scenario: tutor picks up a new student later in the day
  Given I pick up a new student
  And there are three tutors
  And the first two students have been sent emails
  Then the next student in the queue who hasn't beeen emailed, should receive an email

Scenario: there are no student in waitlist and new student checked in
  Given I am a new student
  And there are no students in queue
  Then I get an email confirmation

Scenario: two tutors pick up new students
  Given two tutors pick up new students
  Then the next two students in the queue who haven't been emailed, should receive emails

Scenario: tutor picks up a new student later in the day, and there are no student in line
  Given I pick up a new student
  And there are no students in the queue who haven't been emailed
  Then do nothing


