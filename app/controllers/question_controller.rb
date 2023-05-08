class QuestionController < ApplicationController
  before_action :authenticate_user!, except: [:show]

  def new
  end

  def create
    param = strong_params
    # TODO ログインID
    param[:user_id] = current_user.id
    Question.create! param
    show_notice ['登録しました']
    redirect_to action: :show
  rescue ActiveRecord::RecordInvalid => e
    show_alert e.record.errors.full_messages
    redirect_to action: :new
  end

  def edit
  end

  def show
    @question = FindByQuestionService.new.call params[:id]
    if @question.del?
      # TODO 削除されているページを出す
    end
  rescue
    redirect_to root_path
  end

  def update
  end

  private
  def strong_params
    params.permit(:title, :tags, :content, :status)
  end

end
