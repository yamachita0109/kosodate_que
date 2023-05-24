class SearchAnswerService
  def call(param = {})
    @param = param
    search
  end

  private
  def search
    res = Answer
      .joins('INNER JOIN users AS answers_users ON answers.user_id = answers_users.id ')
      .joins('LEFT JOIN replies ON replies.answer_id = answers.id ')
      .joins('LEFT JOIN users AS replies_users ON replies.user_id = replies_users.id ')
      .order(is_best_answer: 'DESC', id: 'DESC')
      .select('
        answers.*
        , answers_users.name AS answer_user_name
        , answers_users.logo AS answer_user_logo
        , replies.id AS reply_id
        , replies.content AS reply_content
        , replies.user_id AS reply_user_id
        , replies_users.name AS reply_user_name
        , replies_users.logo AS reply_user_logo
      ')
    if @param[:question_id].present?
      res = res.where(question_id: @param[:question_id])
    end
    res
  end
end