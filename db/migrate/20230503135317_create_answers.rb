class CreateAnswers < ActiveRecord::Migration[7.0]
  def change
    create_table :answers do |t|
      t.integer :question_id, null: false
      t.text :content
      t.integer :good_cnt, null: false, default: 0
      t.integer :bad_cnt, null: false, default: 0
      t.boolean :is_best_answer, null: false, default: false
      t.integer :user_id, null: false
      t.timestamps
    end
  end
end
