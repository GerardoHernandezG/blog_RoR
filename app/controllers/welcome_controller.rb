class WelcomeController < ApplicationController
  before_action :authenticate_admin!, only: [:admin_articles]
  def index
  	# Rails.logger.debug("My object: #{@some_object.inspect}")
  end

  def admin_articles
  	@articles = Article.all
  end  
end
