class ListController < ApplicationController
  def index
    @questions = SearchQuestionService.new.call()
  end
end
