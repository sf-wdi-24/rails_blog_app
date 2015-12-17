class AddOwnerIdToPets < ActiveRecord::Migration
  def change
  	change_table :posts do |t|
  		t.belongs_to :owner
  end
end
