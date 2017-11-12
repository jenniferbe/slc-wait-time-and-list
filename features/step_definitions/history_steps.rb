require 'uri'
require 'cgi'
require File.expand_path(File.join(File.dirname(__FILE__), "..", "support", "paths"))

module WithinHelpers
  def with_scope(locator)
    locator ? within(locator) { yield } : yield
  end
end
World(WithinHelpers)

Given /^(?:I|She|He) should see the history for (.*)$/ do |date|
  pending
  #query #of entries from Histories where date = #{date}
  #and check against number of rows
end
