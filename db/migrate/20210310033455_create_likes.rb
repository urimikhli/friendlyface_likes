class CreateLikes < ActiveRecord::Migration[5.2]
  def change
    create_table :likes do |t|
      t.integer :postId
      t.string :user
      t.datetime :date

      t.timestamps
    end
  end
end
