class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.integer :seller_cloud_id
      t.string :name

      t.timestamps null: false
    end
  end
end
