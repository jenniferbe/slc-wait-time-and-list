Feature: History
  As an administrator
  So that I can better quantifiably understand how the slc operates
  I want to see a compilable history


Scenario: View one day history
  Given I am on the history page
  And I select "11/9/17" from "history_dates"
  Then I should see the history for that day

Scenario: Download one day's worth of history
  Given I am on the history page
  And I see one day's worth of history
  And I click "Download"
  Then I should see "Download successful"



