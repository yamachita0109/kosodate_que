module Api
  class ReplyController < ApplicationController
    skip_forgery_protection

    def post
      param = api_param
      param[:user_id] = current_user.id
      answer = Answer.find(param[:answer_id])
      reply = Reply.create! param
      UserMailer.send_post_reply(answer, reply).deliver_now
      render json: {result: 'ok'}, status: :ok
    end

    private
    def api_param
      params.permit(:answer_id, :content)
    end
  end
end