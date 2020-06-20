class PagesController < ApplicationController
  before_action :authenticate_user!, only: [:home]

  def home
    @welcome_calls = WelcomeCall.select{|call| call.start_time > Date.today && call.available == true}
    # @welcome_calls = @welcome_calls.collect(&:start_time)
  end
end
