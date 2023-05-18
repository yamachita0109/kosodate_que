module Api
  class ReplyController < ApplicationController
    skip_forgery_protection

    def post
      param = api_param
      param[:user_id] = current_user.id
      answer = Answer.find(param[:answer_id])
      reply = Reply.create! param
      question = Question.find answer.question_id
      UserMailer.send_post_reply(question, answer, reply).deliver_now
      render json: {result: 'ok'}, status: :ok
    end

    private
    def api_param
      params.permit(:answer_id, :content)
    end
  end
end