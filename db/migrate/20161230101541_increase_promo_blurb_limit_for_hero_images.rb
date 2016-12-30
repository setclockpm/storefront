class IncreasePromoBlurbLimitForHeroImages < ActiveRecord::Migration
  def change
    add_column :hero_images, :promo_blurb_location, :string, limit: 7
    change_column :hero_images, :caption, :string, limit: 50
  end
end
