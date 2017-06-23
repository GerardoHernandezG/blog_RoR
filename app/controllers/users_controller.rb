class UsersController < ApplicationController
	
  before_action :set_user, only: [:edit]
  skip_before_action :verify_authenticity_token
  def index
  end

  def admin_usuarios
  	@user = User.all
  end

  def load_github    
  end

  def login_github
    Github.new basic_auth: 'GerardoHernandezG:Odrare2789.'
  end

  def edit  	
  end

  def update		
		if User.update(user_params)
			redirect_to admin_usuarios_path
		else
			render :edit
		end
  end

  private

  def set_user
		@user = User.find(params[:id])
  end

  def user_params
		params.require(:user).permit(:email,:permission_level)
  end
end
