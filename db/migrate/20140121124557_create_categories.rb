class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories,:id=>false do |t|
      t.column :category_id, "int(11) PRIMARY KEY"
      t.string :category_name
      t.integer :api_type

      t.timestamps
    end
  end
end
