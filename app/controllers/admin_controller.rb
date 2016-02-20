class AdminController < ApplicationController
  before_action :find_user, :only => [:change_user, :updating_user, :deleting_user]

  def admin_panel
    @users = User.all.order 'email'
    @categories = Category.all.order 'name'
    @current_category = nil
  end

  def change_user
    @user = User.find(params[:user_id])
  end

  def updating_user
    if is_password_blank?
      @user[:email] = get_user_params[:email]
      if @user.save
        redirect_to admin_panel_url
      else
        render 'change_user'
      end
    else
      if @user.update(get_user_params)
        redirect_to admin_panel_url
      else
        render 'change_user'
      end
    end

  end

  def deleting_user
    @user.destroy
    redirect_to admin_panel_url
  end

  private

    def get_user_params
      params.require(:user).permit(:email, :password, :password_confirmation)
    end

    def is_password_blank?
      passwords = params.require(:user).permit(:password, :password_confirmation)
      if passwords[:password].blank? && passwords[:password_confirmation].blank?
        return true
      else
        return false
      end
    end

    def find_user
      @user = User.find(params[:user_id])
    end
end
