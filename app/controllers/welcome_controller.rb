class WelcomeController < ApplicationController
  before_action :authenticate_admin!, only: [:dashboard]
  def index
  	# Rails.logger.debug("My object: #{@some_object.inspect}")
  end

  def dashboard
  	@articles = Article.all
  end
end
