class NotificationController < ApplicationController
  before_action :authenticate_user!
  def show
    @activities = current_user.get_activities
  end
end
