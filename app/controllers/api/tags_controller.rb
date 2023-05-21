module Api
  class TagsController < ApplicationController
    def get
      # TODO 動的
      rows = [
        '新生児', '乳児', '0歳児', '1歳児', '2歳児', '3歳児', '年少', '年中', '年長',
        '小学生低学年', '小学生高学年', '中学生', '大学生', '思春期', 'イヤイヤ期', '反抗期', '人見知り'
      ]
      render json: {rows: rows}, status: :ok
    end
  end
end