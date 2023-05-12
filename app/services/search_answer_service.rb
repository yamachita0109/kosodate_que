class SearchAnswerService
  def call(param = {})
    @param = param
    search
  end

  private
  def search
    res = Answer
      .joins('LEFT JOIN replies ON replies.answer_id = answers.id ')
      .order(is_best_answer: 'DESC', id: 'DESC')
      .select('answers.*, replies.id AS reply_id, replies.content AS reply_content, replies.user_id AS reply_user_id')
    if @param[:question_id]
      res = res.where(question_id: @param[:question_id])
    end
    res
  end
end