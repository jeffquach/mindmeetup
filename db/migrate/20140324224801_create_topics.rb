class CreateTopics < ActiveRecord::Migration
  def change
    create_table :topics do |t|
      t.string :name
      t.integer :user_id
      t.integer :subject_id

      t.timestamps
    end
  end
end
