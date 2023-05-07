class ListController < ApplicationController
  include Pagy::Backend

  def index
    param = { :status => [Question.statuses[:open], Question.statuses[:done]] }
    @pagy, @questions = pagy(SearchQuestionService.new.call(param))
  end
end
