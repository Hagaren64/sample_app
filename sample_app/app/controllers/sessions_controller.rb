class SessionsController < ApplicationController

# Source used for remember_me
# http://railscasts.com/episodes/274-remember-me-reset-password

  def new
    @title = "Sign in"
  end
  
  def create
    user = User.authenticate(params[:session][:email],
                             params[:session][:password])
    if user.nil?
      flash.now[:error] = "Invalid email/password combination."
      @title = "Sign in"
      render 'new'
    else
      if((params[:remember_me])=="1")
        sign_in_remember user
      else
        sign_in user
      end
      redirect_back_or user
    end
  end
  
  def destroy
    sign_out
    redirect_to root_path
  end
end