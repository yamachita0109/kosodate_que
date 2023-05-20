class ContactController < ApplicationController
  def new
  end

  def post
    notifier = Slack::Notifier.new(ENV['SLACK_WEBHOOK_URL'])
    notifier.ping <<-"EOS"
<!channel>
email: #{web_params[:email]}
問い合わせ内容
#{web_params[:content]}
    EOS
    show_notice ['お問い合わせしました']
    redirect_to root_path
  end

  private
  def web_params
    params.permit(:email, :content)
  end
end
