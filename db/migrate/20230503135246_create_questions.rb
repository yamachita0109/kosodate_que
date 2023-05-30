class CreateQuestions < ActiveRecord::Migration[7.0]
  def change
    create_table :questions do |t|
      t.string :title
      t.string :tags
      t.text :content
      t.integer :good_cnt, null: false, default: 0
      t.integer :bad_cnt, null: false, default: 0
      t.integer :view_cnt, null: false, default: 0
      t.integer :answer_cnt, null: false, default: 0
      # WIP, OPEN, DONE, DELETE
      t.string :status, null: false, default: 'WIP'
      t.integer :user_id, null: false
      t.timestamps
    end
  end
end
