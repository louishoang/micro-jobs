class CreateSmsMessages < ActiveRecord::Migration
  def change
    create_table :sms_messages do |t|
      t.integer :user_id, null: false
      t.string :receiver, null: false
      t.text :text, null: false

      t.timestamps
    end
  end
end
