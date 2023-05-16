class QuestionController < ApplicationController
  before_action :authenticate_user!, except: [:show]
  before_action :fetch_question_info

  def new
  end

  def create
    param = web_params
    param[:user_id] = current_user.id
    q = Question.create! param
    show_notice ['登録しました']
    redirect_to question_path q.id
  rescue ActiveRecord::RecordInvalid => e
    show_alert e.record.errors.full_messages
    redirect_to action: :new
  end

  def edit
    @question = FindByQuestionService.new.call params[:id]
    if @question.nil?
      redirect_to question_path params[:id]
      return
    end
  end

  def show
    if @question.del?
      # TODO 削除されているページを出す
      return 
    end
    @question.increment!(:view_cnt) unless current_user.id == @question.user_id
  rescue
    redirect_to root_path
  end

  # TODO BEST answer
  def update
    @question = FindByQuestionService.new.call params[:id]
    if @question.nil?
      return
    end
    @question.update! web_params
    show_notice ['更新しました']
    redirect_to action: :show
  rescue ActiveRecord::RecordInvalid => e
    show_alert e.record.errors.full_messages
    redirect_to action: :edit
  end

  def post_answer
    param = answer_params
    param[:user_id] = current_user.id
    param[:question_id] = params[:id]
    Answer.create! param
    @question.increment!(:answer_cnt)
    show_notice ['投稿しました']
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
  def fetch_question_info
    info = Question.find_by(id: params[:id])
    @question = info.nil? ? Question.new : info
  end

  def web_params
    params.require(:question).permit(:title, :tags, :content, :status)
  end

  def answer_params
    params.permit(:content)
  end
end
