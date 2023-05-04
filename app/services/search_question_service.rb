class SearchQuestionService
  def call()
    search()
  end

  private
  def search
    Question.all()
  end
end