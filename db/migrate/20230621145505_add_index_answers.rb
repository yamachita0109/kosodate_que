class AddIndexAnswers < ActiveRecord::Migration[7.0]
  def change
    add_index :answers, :question_id
    add_index :answers, :user_id
    add_index :answers, :is_best_answer
  end
end
