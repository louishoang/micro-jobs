class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :provider, null: false
      t.string :uid, null: false
      t.string :user_name, null: false
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :avatar_url

      t.timestamps
    end
  end
end
