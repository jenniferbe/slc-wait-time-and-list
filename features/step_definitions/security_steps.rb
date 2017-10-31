require 'uri'
require 'cgi'
require File.expand_path(File.join(File.dirname(__FILE__), "..", "support", "paths"))

module WithinHelpers
  def with_scope(locator)
    locator ? within(locator) { yield } : yield
  end
end
World(WithinHelpers)


Given /^I fill in the password (in)?correctly$/ do |capt|
  pending
end

Given /^I should be told that the password is incorrect$/ do
  pending
end

Given /^I am (not )?signed in to the app$/ do |capt|
  pending
end

Given /^I am (not )?signed in as a tutor$/ do |capt|
  pending
end

Given /^I should (not )?be redirected(?: to ")?([^"]*)(?:")?$/ do |capt1, capt2|
  pending
end

Given /^I should be logged out as a tutor/ do
  pending
end




