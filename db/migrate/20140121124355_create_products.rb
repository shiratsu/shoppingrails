class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.integer :api_type
      t.string :product_name
      t.text :description
      t.string :url
      t.string :image_small_url
      t.string :image_medium_url
      t.string :affiliate_url
      t.string :product_id
      t.integer :category_id
      t.string :category_name
      t.string :maker_name
      t.integer :fixed_price
      t.integer :default_price
      t.integer :sale_price
      t.integer :period_start
      t.integer :period_end
      t.integer :review_average
      t.integer :total_reviews
      t.integer :total_used
      t.integer :used_price
      t.datetime :created_at
      t.datetime :updated_at

      t.timestamps
    end
  end
end
