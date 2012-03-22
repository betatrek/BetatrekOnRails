class AddConfirmedToRsvps < ActiveRecord::Migration
  def change
    add_column :rsvps, :confirmed, :boolean, default: false

    add_column :rsvps, :confirmation_code, :string

  end
end
