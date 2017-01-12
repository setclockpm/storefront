class CreateSpreeFooters < ActiveRecord::Migration
  def change
    create_table :spree_footers do |t|
      t.string :location

      t.timestamps null: true
    end
  end
end
