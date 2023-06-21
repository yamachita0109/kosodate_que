class AddIndexQuestionCntHistories < ActiveRecord::Migration[7.0]
  def change
    add_index :question_cnt_histories, :question_id
  end
end
