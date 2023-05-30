module Api
  class QuestionController < ApplicationController
    def get
      param = api_param
      # 暗号化されているため詰め直す
      param[:id] = Question.decode_id(param[:id]) if param[:id].present?
      param[:user_id] = User.decode_id(param[:user_id]) if param[:user_id].present?
      param[:answer_user_id] = User.decode_id(param[:answer_user_id]) if param[:answer_user_id].present?
      # 公開情報となるため、open, doneの質問のみ取得
      param[:status] = [Question.statuses[:open], Question.statuses[:done]]
      questions = SearchQuestionService.new.call(param)
      rows = questions.map{|question|
        {
          id: question.hashid,
          title: question.title,
          tags: question.tags,
          content: question.content,
          good_cnt: question.good_cnt,
          bad_cnt: question.bad_cnt,
          view_cnt: question.view_cnt,
          answer_cnt: question.answer_cnt,
          status: question.status,
          created_at: question.created_at,
          user_id: question.user_hashid,
          user_name: question.user_name,
          user_logo: question.user_logo,
        }
      }
      render json: {rows: rows}, status: :ok
    end
    private
    def api_param
      params.permit(:id, :user_id, :answer_user_id, :order)
    end
  end
end