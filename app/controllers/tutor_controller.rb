class TutorController < ApplicationController
  before_action :authenticate_tutor!
end
