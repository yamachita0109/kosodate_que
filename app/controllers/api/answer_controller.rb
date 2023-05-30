module Api
  class AnswerController < ApplicationController
    def get
      param = api_param
      # 暗号化されているため詰め直す
      param[:question_id] = Question.decode_id(param[:question_id]) if param[:question_id].present?
      res = SearchAnswerService.new.call param
      rows = res.map {|r| r.id}.uniq.map {|id|
        data = res.filter {|r| r.id == id}
        {
          id: data.first.id,
          question_id: data.first.question_id,
          content: data.first.content,
          good_cnt: data.first.good_cnt,
          bad_cnt: data.first.bad_cnt,
          is_best_answer: data.first.is_best_answer,
          user_id: data.first.user_id,
          user_name: data.first.answer_user_name,
          user_logo: data.first.answer_user_logo,
          created_at: data.first.created_at,
          replies: data.first.reply_id.nil? ?
            [] : data.map {|d|
              {
                id: d.reply_id,
                user_id: d.reply_user_id,
                user_name: d.reply_user_name,
                user_logo: d.reply_user_logo,
                content: d.reply_content,
              }
            }.sort_by{|d| d[:id] }
        }
      }
      render json: {rows: rows}, status: :ok
    end
    private
    def api_param
      params.permit(:question_id, :order, :is_self, :is_best)
    end
  end
end