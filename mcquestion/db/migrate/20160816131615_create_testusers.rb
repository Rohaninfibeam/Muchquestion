class CreateTestusers < ActiveRecord::Migration
  def change
    create_table :testusers do |t|
      t.integer :test_id
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
