class QuestionController < ApplicationController
  before_action :authenticate_user!, except: [:show]

  def new
  end

  def create
    param = web_params
    param[:user_id] = current_user.id
    Question.create! param
    show_notice ['登録しました']
    redirect_to question_path param[:id]
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

  def post_answer
    param = web_params
    param[:user_id] = current_user.id
    param[:question_id] = params[:id]
    Answer.create! param
    show_notice ['登録しました']
    redirect_to question_path params[:id]
  rescue ActiveRecord::RecordInvalid => e
    show_alert e.record.errors.full_messages
    redirect_to question_path params[:id]
  end

  def post_reply
    show_notice ['登録しました']
    redirect_to question_path params[:id]
  end

  private
  def web_params
    params.permit(:title, :tags, :content, :status)
  end

end
