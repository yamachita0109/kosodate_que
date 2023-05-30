class Question < ApplicationRecord
  include Hashid::Rails

  enum status: {
    wip: 'WIP', # 作業中
    open: 'OPEN', # 質問中
    done: 'DONE', # 質問終了
    del: 'DELETE' # 質問削除
  }

  validates :title,
    presence: true,
    length: { maximum: 200 }
  validates :tags,
    presence: true,
    length: { maximum: 200 }
  validates :content,
    presence: true,
    length: { maximum: 2000 }
  validates :view_cnt,
    numericality: true
  validates :answer_cnt,
    numericality: true
  validates :status,
    presence: true,
    if: Proc.new { |a| Question.statuses.keys.include?(a) }

  def user_hashid
    User.encode_id user_id
  end
end
