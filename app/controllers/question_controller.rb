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
    @tag = param[:tag]
  end

  def new
  end

  def create
    param = web_params
    param[:user_id] = current_user.id
    @question = Question.new param
    if @question.save
      UserMailer.send_post_question(@question).deliver_now if @question.open?
      show_notice [@question.open? ? '投稿しました' : '下書き登録しました']
      redirect_to question_path @question.hashid
    else
      show_alert(@question.errors.full_messages, true)
      render :new
    end
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
      render_404
      return
    end
    @question.increment!(:view_cnt) if @question.open?
    @user = User.find @question.user_id
    @history = QuestionCntHistory.find_by({ :user_id => current_user.id, :question_id => @question.id }) unless current_user.nil?
  rescue
    redirect_to root_path
  end

  def update
    if @question.user_id != current_user.id
      redirect_to question_path params[:id]
      return
    end

    param = web_params
    msg = '更新しました'
    if param[:answer_id].present?
      answer = Answer.find_by_hashid param[:answer_id]
      answer.update!({:is_best_answer => true})
      msg = '解決にしました'
      UserMailer.send_best_answer(@question, answer).deliver_now
    end
    param.delete :answer_id

    if @question.update param
      UserMailer.send_post_question(@question).deliver_now if @question.open?
      show_notice [msg]
      redirect_to action: :show
    else
      show_alert(@question.errors.full_messages, true)
      render action: :edit
    end
  end

  def post_answer
    param = answer_params
    param[:user_id] = current_user.id
    param[:question_id] = @question.id
    answer = Answer.create! param
    @question.increment!(:answer_cnt)
    UserMailer.send_post_answer(@question, answer).deliver_now
    show_notice ['回答しました']
    redirect_to question_path params[:id]
  rescue ActiveRecord::RecordInvalid => e
    show_alert e.record.errors.full_messages
    redirect_to question_path params[:id]
  end

  # good数のみ（様子を見てbad対応も実施）
  def post_cnt
    param = { :user_id => current_user.id, :question_id => @question.id }
    history = QuestionCntHistory.find_by param
    msg = 'いいねしました'
    if history.nil?
      @question.increment!(:good_cnt)
      QuestionCntHistory.create! param
    else
      msg = 'いいねを削除しました'
      @question.decrement!(:good_cnt)
      history.destroy
    end
    show_notice [msg]
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

  def cnt_params
    params.permit(:content)
  end
end
