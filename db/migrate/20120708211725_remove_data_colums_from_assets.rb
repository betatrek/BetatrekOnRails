class RemoveDataColumsFromAssets < ActiveRecord::Migration
  def change
  	remove_column :assets, :created_at
  	remove_column :assets, :updated_at
  end
end
