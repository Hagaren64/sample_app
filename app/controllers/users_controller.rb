class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
	@title = @user.name
  end

  def new
	@user = User.new
    @title = "Sign up"
  end
    
  def create
	#create a new user with all data received from form (in params)
    @user = User.new(params[:user])
	#once @user is defined properly, calling @user.save is all that’s needed to complete the registration
    if @user.save
      # Handle a successful save.
	  flash[:success] = "Welcome to the Sample App!"
	  redirect_to @user
	  #could have also said redirect_to user_path(@user)
    else
		#re-render the signup page if invalid signup data is received.
      @title = "Sign up"
      render 'new'
    end
  end 
  
end