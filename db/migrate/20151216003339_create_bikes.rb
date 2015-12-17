class CreateBikes < ActiveRecord::Migration
  def change
    create_table :bikes do |t|
      t.string :name
      t.string :description

      t.timestamps null: false

      t.belongs_to :user
    end
  end
end
