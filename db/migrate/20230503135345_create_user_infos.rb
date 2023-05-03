class CreateUserInfos < ActiveRecord::Migration[7.0]
  def change
    create_table :user_infos do |t|
      t.integer :user_id, null: false
      t.string :name
      t.date :birthday
      t.text :text
      t.string :logo
      t.string :twitter_id
      t.string :instagram_id
      t.string :facebook_id
      t.timestamps
    end
  end
end
