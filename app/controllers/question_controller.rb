class QuestionController < ApplicationController
  # TODO ログインハンドラー

  def new
  end

  def create
    _param = strong_params
    # TODO ログインID
    _param[:user_id] = 1
    Question.create(_param)
    # TODO 詳細へリダイレクト（作成メッセージを添えて）
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
