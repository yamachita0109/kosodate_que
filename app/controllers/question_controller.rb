class QuestionController < ApplicationController
  include Pagy::Backend
  before_action :authenticate_user!, except: [:index, :show]
  before_action :fetch_info, except: [:index]

  def index
    param = index_params
    param[:status] = [Question.statuses[:open], Question.statuses[:done]]
    questions = SearchQuestionService.new.call(param)
    @pagy, @questions = pagy(questions)
    @total_count = questions.count(:id)
  end

  def new
  end

  def create
    param = web_params
    param[:user_id] = current_user.id
    question = Question.create! param
    UserMailer.send_post_question(question).deliver_now if question.open?
    show_notice [question.open? ? '投稿しました' : '下書き登録しました']
    redirect_to question_path question.hashid
  rescue ActiveRecord::RecordInvalid => e
    show_alert e.record.errors.full_messages
    redirect_to action: :new
  end

  def edit
    if @question.id.nil?
      render_404
      return
    end
    if @question.user_id != current_user.id
      redirect_to question_path params[:id]
      return
    end
    if @question.done?
      redirect_to question_path params[:id]
      return
    end
    @answer = Answer.where(question_id: @question.id)
  end

  def show
    if @question.id.nil?
      render_404
      return
    end
    if @question.del?
      # TODO 削除されているページを出す
      render_404
      return
    end
    @question.increment!(:view_cnt)
  rescue
    redirect_to root_path
  end

  def update
    if @question.user_id != current_user.id
      redirect_to question_path params[:id]
      return
    end
    param = web_params
    if param[:answer_id].present?
      answer = Answer.find_by(id: param[:answer_id], question_id: @question.id)
      answer.update!({:is_best_answer => true})
      param.delete :answer_id
    end
    @question.update! param
    UserMailer.send_post_question(@question).deliver_now if @question.open?
    show_notice ['更新しました']
    redirect_to action: :show
  rescue ActiveRecord::RecordInvalid => e
    show_alert e.record.errors.full_messages
    redirect_to action: :edit
  end

  def post_answer
    param = answer_params
    param[:user_id] = current_user.id
    param[:question_id] = @question.id
    answer = Answer.create! param
    @question.increment!(:answer_cnt)
    UserMailer.send_post_answer(@question, answer).deliver_now
    show_notice ['コメントしました']
    redirect_to question_path params[:id]
  rescue ActiveRecord::RecordInvalid => e
    show_alert e.record.errors.full_messages
    redirect_to question_path params[:id]
  end

  private
  def fetch_info
    info = Question.find_by_hashid params[:id]
    @question = info.nil? ? Question.new : info
    @user = User.find_by(id: @question.user_id)
  end

  def index_params
    params.permit(:text, :filter, :tag)
  end

  def web_params
    params.require(:question).permit(:title, :tags, :content, :status, :answer_id)
  end

  def answer_params
    params.permit(:content)
  end
end
