class MypageController < ApplicationController
  include Pagy::Backend
  before_action :authenticate_user!

  def show
    param = { :user_id => current_user.id, :status => Question.statuses[:wip] }
    @pagy, @questions = pagy(SearchQuestionService.new.call(param))
  end

  def edit
  end

  def update
    param = web_params
    User.find(current_user.id).update! param
    show_notice ['更新しました']
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
    param = { :logo => "/user/#{current_user.id}.jpg" }
    User.find(current_user.id).update! param
    show_notice ['更新しました']
    redirect_to action: :show
  rescue ActiveRecord::RecordInvalid => e
    show_alert e.record.errors.full_messages
    redirect_to action: :show
  end

  private
  def web_params
    params.require(:user).permit(:name, :content, :logo, :twitter_id, :instagram_id, :facebook_id)
  end
end
