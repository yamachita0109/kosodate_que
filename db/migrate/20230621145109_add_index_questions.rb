class AddIndexQuestions < ActiveRecord::Migration[7.0]
  def change
    add_index :questions, :status
    add_index :questions, :title
    add_index :questions, :tags
  end
end
