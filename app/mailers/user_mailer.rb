class UserMailer < ApplicationMailer
  def send_post_question(question)
    @q = question
    @u = User.find(question.user_id)
    @display_name = display_name
    mail(to: @u.email, subject: '【ママパパQ&A】質問を投稿しました')
  end

  def send_post_answer(question, answer)
    @q = question
    @a = answer
    @u = User.find(question.user_id)
    @display_name = display_name
    mail(to: @u.email, subject: '【ママパパQ&A】質問にコメントされました')
  end

  def send_post_reply(question, answer, reply)
    @q = question
    @a = answer
    @r = reply
    @u = User.find(answer.user_id)
    @display_name = display_name
    mail(to: @u.email, subject: '【ママパパQ&A】リプライされました')
  end

  def send_best_answer(question, answer)
    @q = question
    @a = answer
    @u = User.find(answer.user_id)
    @display_name = display_name
    mail(to: @u.email, subject: '【ママパパQ&A】ベストアンサーに選ばれました')
  end

  private
  def display_name
    if @u.name.present?
      @u.name
    else
      @u.email.sub(/^@/, '')
    end
  end

end