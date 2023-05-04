class SearchQuestionService
  def call()
    search()
  end

  private
  def search
    # TODO logic.
    Question.all
  end
end