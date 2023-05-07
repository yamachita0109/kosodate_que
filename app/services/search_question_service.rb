class SearchQuestionService
  def call(param = {})
    @param = param
    search
  end

  private
  def search
    res = Question.all
    if @param[:user_id]
      res = res.where(user_id: @param[:user_id])
    end
    if @param[:status]
      res = res.where(status: @param[:status])
    end
    res
  end
end