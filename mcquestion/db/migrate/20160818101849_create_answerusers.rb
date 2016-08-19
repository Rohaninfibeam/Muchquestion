class CreateAnswerusers < ActiveRecord::Migration
  def change
    create_table :answerusers do |t|
      t.integer :userquestion_id
      t.integer :option_id

      t.timestamps null: false
    end
  end
end
