class CreateReplies < ActiveRecord::Migration[7.0]
  def change
    create_table :replies do |t|
      t.integer :answer_id, null: false
      t.integer :position
      t.text :content
      t.integer :user_id, null: false
      t.timestamps
    end
  end
end
