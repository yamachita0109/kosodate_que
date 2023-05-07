class MypageController < ApplicationController
  before_action :authenticate_user!

  def show
    @user_info = UserInfo.find_by(user_id: current_user.id)
  end

  def edit
    @user_info = UserInfo.find_by(user_id: current_user.id)
  end

  def update
  end
end
