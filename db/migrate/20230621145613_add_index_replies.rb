class AddIndexReplies < ActiveRecord::Migration[7.0]
  def change
    add_index :replies, :answer_id
    add_index :replies, :user_id
  end
end
