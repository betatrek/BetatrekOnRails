class CreateAssets < ActiveRecord::Migration
  def change
    create_table :assets do |t|
      t.string :ticker
      t.float :evaluation
      t.integer :volume
      t.integer :market_cap
      t.float :beta

      t.timestamps
    end
  end
end
