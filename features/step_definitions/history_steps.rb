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
      password = ENV["tutor_password"]
    else
      password = ENV["slc_password"]
    end
  end
  steps %Q{
    And I fill in "pass" with "#{password}"
    When I click on "Submit"
  }
end