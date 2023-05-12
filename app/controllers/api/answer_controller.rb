module Api
  class AnswerController < ApplicationController
    def get
      res = SearchAnswerService.new.call api_param
      rows = res.map {|r| r.id}.uniq.map {|id|
        data = res.filter {|r| r.id == id}
        {
          id: data.first.id,
          question_id: data.first.question_id,
          content: data.first.content,
          good_cnt: data.first.good_cnt,
          is_best_answer: data.first.is_best_answer,
          user_id: data.first.user_id,
          created_at: data.first.created_at,
          replies: data.first.reply_id.nil? ?
            [] : data.map {|d| {id: d.reply_id, user_id: d.reply_user_id, content: d.reply_content}}
        }
      }
      render json: {rows: rows}, status: :ok
    end
    private
    def api_param
      params.permit(:question_id, :order)
    end
  end
end