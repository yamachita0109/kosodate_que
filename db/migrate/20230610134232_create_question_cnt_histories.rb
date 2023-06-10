class CreateQuestionCntHistories < ActiveRecord::Migration[7.0]
  def change
    create_table :question_cnt_histories do |t|
      t.integer :question_id, null: false
      t.integer :user_id, null: false
      # GOOD, BAD
      t.string :status, null: false, default: 'GOOD'
      t.timestamps
    end
  end
end
