class CreateCaves < ActiveRecord::Migration
  def change
    create_table :caves do |t|
      t.string :shop_id
      t.string :shop_name
      t.string :log_image
      t.string :address
      t.string :station_name
      t.float :lat
      t.float :lng
      t.string :genre_code
      t.string :genre_name
      t.string :pc_url
      t.string :mobile_url
      t.datetime :created_at
      t.datetime :updated_at

      t.timestamps
    end
  end
end
