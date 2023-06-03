module Api
  class AiAnswerController < ApplicationController
    def get
      question = Question.find_by_hashid api_param[:question_id]
      raise 'No question.' if question.nil?
      message = PostOpenAiService.new.call({ :text => question.content })
      render json: {message: message}, status: :ok
    end
    private
    def api_param
      params.permit(:question_id)
    end
  end
end