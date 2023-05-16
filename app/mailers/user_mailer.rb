class UserMailer < ApplicationMailer
  def send_post_question(question)
    @q = question
    @u = User.detail(question.user_id)
    @display_name = display_name
    mail(to: @u.email, subject: '【パパママQA】質問を投稿しました')
  end

  def send_post_answer
    @user = @recipient
    mail(to: @user.email, subject: 'send_post_answer_from')
  end

  def send_post_reply
    @user = @recipient
    mail(to: @user.email, subject: 'send_post_reply_from')
  end

  def send_best_answer
    @user = @recipient
    mail(to: @user.email, subject: 'send_best_answer')
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