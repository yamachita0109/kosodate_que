module Api
  class AnswerController < ApplicationController
    def get
      res = SearchAnswerService.new.call api_param
      render json: {rows: res}, status: :ok
    end
    private
    def api_param
      params.permit(:question_id, :order)
    end
  end
end