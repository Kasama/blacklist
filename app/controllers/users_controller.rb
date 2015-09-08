class UsersController < ApplicationController

  def new
    if current_user && current_user.admin?
      @user = User.new
    else
      redirect_to root_url, notice: 'Only admins can create new users!'
    end
  end

  def create
    if current_user && current_user.admin?
      @user = User.new user_create_params, admin: '0'
      if @user.save
        redirect_to root_url, notice: 'Signed up!'
      else
        render 'new'
      end
    else
      redirect_to root_url, notice: 'Only admins can create new users!'
    end
  end

  def modify
    redirect_to root_url, notice: 'Please login to be able to change your information' unless current_user
  end

  def change_password
    if current_user
      if current_user.authenticate(params[:old_password])
        if current_user.update_attributes user_edit_params
          redirect_to root_url, notice: 'Password updated successfully'
        else
          render 'modify'
        end
      else
        render 'modify'
      end
    else
      redirect_to root_url, notice: 'Please login to be able to change your information!'
    end
  end

  def user_create_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end

  def user_edit_params
    params.permit(:password, :password_confirmation)
  end

  private :user_edit_params, :user_create_params

end
