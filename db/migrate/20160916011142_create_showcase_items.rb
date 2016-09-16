class CreateShowcaseItems < ActiveRecord::Migration
  def change
    create_table :showcase_items do |t|
      t.boolean :front_page

      t.timestamps null: false
    end
  end
end
