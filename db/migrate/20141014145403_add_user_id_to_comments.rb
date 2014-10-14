class AddUserIdToComments < ActiveRecord::Migration
  def up
    add_column :comments, :user_id, :integer, null: false
  end

  def down
    remove_column :comments, :user_id
  end

end
