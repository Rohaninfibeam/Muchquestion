class CreateTestquestions < ActiveRecord::Migration
  def change
    create_table :testquestions do |t|
      t.integer :test_id
      t.integer :question_id

      t.timestamps null: false
    end
  end
end
