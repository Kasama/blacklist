class SessionsController < ApplicationController
  def new
  end

  def create

    user = User.authenticate(params[:email], params[:password])
    if user
      session[:user_id] = user.id
      redirect_to root_url, notice: 'Logged in!'
    else
      redirect_to root_url, notice: 'Invalid email or password'
    end

  end

  def destroy
    if current_user
      session[:user_id] = nil
      redirect_to root_url, notice: 'Logged out!'
    else
      redirect_to root_url, notice: 'You need to be logged in to log out!'
    end
  end

end
