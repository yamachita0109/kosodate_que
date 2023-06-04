module Api
  class AiAnswerController < ApplicationController
    def get
      question = Question.find_by_hashid api_param[:question_id]
      raise 'No question.' if question.nil?

      ai_answer = AiAnswer.find_by(question_id: question.id)
      if ai_answer.nil?
        message = PostOpenAiService.new.call({ :text => question.content })
        AiAnswer.create!({ question_id: question.id, content: message })
      else
        message = ai_answer.content
      end

      render json: {message: message}, status: :ok
    end
    private
    def api_param
      params.permit(:question_id)
    end
  end
end