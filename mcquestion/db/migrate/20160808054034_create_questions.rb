class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.text :name
      t.text :question

      t.timestamps null: false
    end
  end
end
