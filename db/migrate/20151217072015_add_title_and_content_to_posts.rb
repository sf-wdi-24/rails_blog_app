class AddTitleAndContentToPosts < ActiveRecord::Migration
  change_table :posts do |t|
  	t.string :title
  	t.string :content
  end
end
