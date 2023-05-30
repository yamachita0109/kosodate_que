class SearchQuestionService
  def call(param = {})
    @param = param
    search
  end

  private
  def search
    res = Question.all
      .order(id: 'DESC')
      .joins('INNER JOIN users ON questions.user_id = users.id ')
      .select('
        questions.*
        , users.name AS user_name
        , users.logo AS user_logo
        , users.twitter_id AS user_twitter_id
        , users.instagram_id AS user_instagram_id
        , users.facebook_id AS user_facebook_id
      ')

    res = res.where(id: @param[:id]) if @param[:id].present?
    res = res.where(user_id: @param[:user_id]) if @param[:user_id].present?
    res = res.joins("INNER JOIN answers ON answers.question_id = questions.id AND answers.user_id = #{@param[:answer_user_id]}").group(:id) if @param[:answer_user_id].present?
    res = res.where(status: @param[:status]) if @param[:status].present?
    res = res.where('CONCAT(title, tags) LIKE ?', "%#{@param[:text]}%") if @param[:text].present?
    res = res.where('CONCAT(tags) LIKE ?', "%#{@param[:tag]}%") if @param[:tag].present?

    case @param[:filter]
    when 'no_answer' then
      res = res.where(answer_cnt: 0)
    when 'done' then
      res = res.where(status: Question.statuses[:done])
    when 'open' then
      res = res.where(status: Question.statuses[:open])
    end

    res
  end
end