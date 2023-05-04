class ListController < ApplicationController
  include Pagy::Backend

  def index
    @pagy, @questions = pagy(SearchQuestionService.new.call())
  end
end
