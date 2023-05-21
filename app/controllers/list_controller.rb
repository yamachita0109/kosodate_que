class ListController < ApplicationController
  include Pagy::Backend

  def index
    param = {
      :status => [Question.statuses[:open], Question.statuses[:done]],
      :text => params[:text]
    }
    questions = SearchQuestionService.new.call(param)
    @pagy, @questions = pagy(questions)
    @total_count = questions.count
  end
end
