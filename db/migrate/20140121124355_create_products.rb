class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.integer :api_type
      t.string :product_name
      t.text :description
      t.string :url
      t.string :affiliate_url
      t.integer :category_id
      t.string :category_name
      t.string :maker_name
      t.integer :price
      t.datetime :created_at
      t.datetime :updated_at

      t.timestamps
    end
  end
end
