class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title
      t.string :story

      t.timestamps null: false

      t.belongs_to :owner
    end
  end
end
