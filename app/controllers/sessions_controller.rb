class SessionsController < ApplicationController
  def new
  	#debugger
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    
    if user && user.authenticate(params[:session][:password])
      # Log the user in and redirect to the user's show page.
      log_in user
      params[:session][:remember_me] == '1' ? remember(user) : forget(user)
      redirect_to user
     else
      #flash[:danger] = 'Invalid email/password combination' # Not quite right!
      flash.now[:danger] = 'Invalid email/password combination'
      #fthe contents of flash.now disappear as soon as there is an additional request
      # Create an error message.
      render 'new'
    end

  end

  def destroy
  	log_out
    redirect_to root_url
  end
end
