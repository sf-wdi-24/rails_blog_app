class AddOwnerIdToPosts < ActiveRecord::Migration

  change_table :posts do |t|
    t.belongs_to :user
    
  end
end
