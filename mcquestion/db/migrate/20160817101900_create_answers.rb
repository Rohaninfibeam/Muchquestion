class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.integer :testuser_id
      t.integer :question_id

      t.timestamps null: false
    end
  end
end
