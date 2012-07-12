class AddDateToAssets < ActiveRecord::Migration
  def change
  	add_column :assets, :date, :date
  end
end
