class CreateAiAnswers < ActiveRecord::Migration[7.0]
  def change
    create_table :ai_answers do |t|
      t.integer :question_id, null: false
      t.text :content
      t.timestamps
    end
  end
end
