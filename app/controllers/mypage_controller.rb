class MypageController < ApplicationController
  include Pagy::Backend
  before_action :authenticate_user!

  def show
    param = { :user_id => current_user.id, :status => Question.statuses[:wip] }
    questions = SearchQuestionService.new.call(param)
    @pagy, @questions = pagy(questions)
    @total_count = questions.count
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
    logo = params[:logo]
    uri = URI.parse(logo)
    data = decode(uri)
    path = "public/user/#{current_user.hashid}.jpg"
    File.binwrite(path, data)
    param = { :logo => "/user/#{current_user.hashid}.jpg" }
    User.find(current_user.id).update! param
    show_notice ['ロゴ画像を登録しました']
    redirect_to action: :show
  rescue ActiveRecord::RecordInvalid => e
    show_alert e.record.errors.full_messages
    redirect_to action: :show
  end

  private
  def web_params
    params.require(:user).permit(:name, :content, :logo, :twitter_id, :instagram_id, :facebook_id)
  end

  def decode(uri)
    opaque = uri.opaque
    data = opaque[opaque.index(",") + 1, opaque.size]
    Base64.decode64(data)
  end
end
