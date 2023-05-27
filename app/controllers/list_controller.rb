class ListController < ApplicationController
  include Pagy::Backend

  def index
    param = web_params
    param[:status] = [Question.statuses[:open], Question.statuses[:done]]
    questions = SearchQuestionService.new.call(param)
    @pagy, @questions = pagy(questions)
    @total_count = questions.count(:id)
  end

  private
  def web_params
    params.permit(:text, :filter, :tag)
  end

end
