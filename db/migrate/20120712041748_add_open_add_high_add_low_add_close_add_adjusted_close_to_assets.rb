class AddOpenAddHighAddLowAddCloseAddAdjustedCloseToAssets < ActiveRecord::Migration
  def change
  	add_column :assets, :open, :float
  	add_column :assets, :high, :float
  	add_column :assets, :low, :float
  	add_column :assets, :close, :float
  	add_column :assets, :adjusted_close, :float
  end
end
