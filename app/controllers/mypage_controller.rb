  # require 'RMagick'
class MypageController < ApplicationController
  before_action :authenticate_user!

  def show
  end

  def edit
  end

  def update
    param = web_params
    User.find(current_user.id).update! param
    show_notice ['変更しました']
    redirect_to action: :show
  rescue ActiveRecord::RecordInvalid => e
    show_alert e.record.errors.full_messages
    redirect_to action: :edit
  end

  def update_logo
    logo = params[:logo]
    uri = URI.parse(logo)
    data = decode(uri)
    key = "cdn/user/#{current_user.hashid}.jpg"
    User.find(current_user.id).update!({ :logo => "/#{key}" })
    s3 = Aws::S3::Resource.new(region: Rails.application.config.aws_region)
    obj = s3.bucket(Rails.application.config.aws_bucket).object(key)
    obj.put( body: data )
    show_notice ['ロゴ画像を登録しました']
    redirect_to action: :show
  rescue ActiveRecord::RecordInvalid => e
    show_alert e.record.errors.full_messages
    redirect_to action: :show
  end

  private
  def web_params
    params.require(:user).permit(:name, :content, :logo, :twitter_id, :instagram_id, :facebook_id, :site_url)
  end

  def decode(uri)
    opaque = uri.opaque
    data = opaque[opaque.index(",") + 1, opaque.size]
    Base64.decode64(data)
  end
end
