require 'uri'
require 'cgi'
require File.expand_path(File.join(File.dirname(__FILE__), "..", "support", "paths"))

module WithinHelpers
  def with_scope(locator)
    locator ? within(locator) { yield } : yield
  end
end
World(WithinHelpers)


Given /^(?:I|She|He) fill in the password (in)?correctly for (.*)$/ do |capt1, capt2|
  password = "wrongpassword"
  if(capt1 == nil)
    if(capt2 == "the tutor firewall page")
      password = Security.tutor_firewall_password
    else
      password = Security.app_firewall_password
    end
  end
  steps %Q{
    And I fill in "password" with "#{password}"
  }
end

Given /^(?:I|She|He) should be told that the password is incorrect$/ do
  steps %Q{
    And I should see "The password you entered is incorrect."
  }
end

Given /^(?:I am|She is |He is) (not )?signed in to the app$/ do |capt1|
  if(capt1)
    assert_equal(false, Security.logged_in_app?)
  else
    assert_equal(true, Security.logged_in_app?)
  end
end

Given /^(?:I am|She is |He is) (not )?signed in as a tutor$/ do |capt1|
  if(capt1)
    assert_equal(false, Security.logged_in_tutor?)
  else
    assert_equal(true, Security.logged_in_tutor?)
  end
end

Given /^(?:I|She|He) should (not )?be redirected(?: to )?([^"]*)$/ do |capt1, capt2|
    steps %Q{
      I should #{capt1}be on #{capt2}
    }
end

Given /^(?:I|She|He) should be logged out as a tutor/ do
  assert_equal(false, Security.logged_in_tutor?)
end




