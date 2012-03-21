class AddIndexToRsvpsEmail < ActiveRecord::Migration
  def change
  	add_index :rsvps, :email, unique: true
  end
end
