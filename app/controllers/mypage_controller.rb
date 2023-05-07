class MypageController < ApplicationController
  before_action :authenticate_user!
  before_action :fetch_user_info

  def show
  end

  def edit
  end

  def update
    param = strong_params
    create_or_update param
    show_notice ['登録しました']
    redirect_to action: :show
  rescue ActiveRecord::RecordInvalid => e
    show_alert e.record.errors.full_messages
    redirect_to action: :edit
  end

  def update_logo
    # TODO 画像サイズを圧縮
    logo = params[:logo]
    path = "public/user/#{current_user.id}.jpg"
    File.binwrite(path, logo.read)
    param = {}
    param[:logo] = "/user/#{current_user.id}.jpg"
    create_or_update param
    show_notice ['登録しました']
    redirect_to action: :show
  rescue ActiveRecord::RecordInvalid => e
    show_alert e.record.errors.full_messages
    redirect_to action: :show
  end

  private
  def fetch_user_info
    info = UserInfo.find_by(user_id: current_user.id)
    @user_info = info.nil? ? UserInfo.new : info
  end

  def strong_params
    params.require(:user_info).permit(:name, :birthday, :text, :logo, :twitter_id, :instagram_id, :facebook_id)
  end

  def create_or_update(param)
    if @user_info.nil?
      param[:user_id] = current_user.id
      UserInfo.create! param
    else
      @user_info.update! param
    end
  end
end
