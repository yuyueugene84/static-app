class UsersController < ApplicationController

  def new
  	@user = User.new
  end

  def show
    @user = User.find(params[:id])
    #debugger
    #The 'printf' function of ruby on rails to check if smth went wrong, check result in server console
  end

  def create
    @user = User.new(user_params)    # Not the final implementation!
    #debugger
    if @user.save
      log_in @user
    	flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
    	#debugger
      # Handle a successful save.
    else
      render 'new'
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
  end

end
