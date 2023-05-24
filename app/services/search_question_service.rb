class SearchQuestionService
  def call(param = {})
    @param = param
    search
  end

  private
  def search
    res = Question.all
    if @param[:user_id].present?
      res = res.where(user_id: @param[:user_id])
    end
    if @param[:status].present?
      res = res.where(status: @param[:status])
    end
    if @param[:text].present?
      res = res.where('CONCAT(title, tags) LIKE ?', "%#{@param[:text]}%")
    end

    case @param[:filter]
    when 'no_answer' then
      res = res.where(answer_cnt: 0)
    when 'done' then
      res = res.where(status: Question.statuses[:done])
    when 'open' then
      res = res.where(status: Question.statuses[:open])
    end

    res = res.order(:id)
    res
  end
end