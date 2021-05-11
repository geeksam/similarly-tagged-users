class AddUserTags < ActiveRecord::Migration[6.0]
  def change
    create_table :usertags do |t|
      t.integer :user_id
      t.integer :tag_id

      t.index [ :user_id, :tag_id ], unique: true
    end
  end
end
