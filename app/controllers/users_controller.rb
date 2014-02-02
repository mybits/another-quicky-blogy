class UsersController < ApplicationController

  def create
    @user = User.new(user_params)
  end

  private
    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation, :remember_me)
    end

end
