class ListController < ApplicationController
  include Pagy::Backend

  def index
    param = {
      :status => [Question.statuses[:open], Question.statuses[:done]],
      :text => params[:text],
      :filter => params[:filter],
    }
    questions = SearchQuestionService.new.call(param)
    @pagy, @questions = pagy(questions)
    @total_count = questions.count(:id)
  end
end
