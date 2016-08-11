class CreateQuestiontypeassocs < ActiveRecord::Migration
  def change
    create_table :questiontypeassocs do |t|
      t.integer :question_id
      t.integer :questiontype_id

      t.timestamps null: false
    end
  end
end
