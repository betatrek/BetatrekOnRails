class AddUidToRsvps < ActiveRecord::Migration
  def change
    add_column :rsvps, :uid, :string
    add_index :rsvps, :uid, unique: true
  end
end
