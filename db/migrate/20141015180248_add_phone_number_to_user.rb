class AddPhoneNumberToUser < ActiveRecord::Migration
  def up
    add_column :users, :phone_number, :text
  end

  def down
    remove_column :users, :phone_number
  end
end
