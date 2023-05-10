class SearchAnswerService
  def call(param = {})
    @param = param
    search
  end

  private
  def search
    res = Answer.all.order(is_best_answer: 'DESC')
    if @param[:question_id]
      res = res.where(question_id: @param[:question_id])
    end
    res
  end
end