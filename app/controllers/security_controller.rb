class SecurityController < ApplicationController
  before_action :signed_in?

  def signed_in?
end