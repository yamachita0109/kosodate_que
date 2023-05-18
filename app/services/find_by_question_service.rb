class FindByQuestionService
  def call(id)
    find(id)
  end

  private
  def find(id)
    Question
      .joins('INNER JOIN users ON users.id = questions.user_id')
      .where(questions: { id: id }).first
  end
end