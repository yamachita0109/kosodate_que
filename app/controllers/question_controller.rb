class QuestionController < ApplicationController
  # TODO ログインハンドラー

  def new
  end

  def create
    param = strong_params
    # TODO ログインID
    param[:user_id] = 1
    Question.create! param
    # TODO 詳細へリダイレクト（作成メッセージを添えて）
  rescue ActiveRecord::RecordInvalid => e
    show_alert e.record.errors.full_messages
    redirect_to action: :new
  end

  def edit
  end

  def show
  end

  def update
  end

  private
  def strong_params
    params.permit(:title, :tags, :content)
  end

end
