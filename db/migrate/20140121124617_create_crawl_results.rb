class CreateCrawlResults < ActiveRecord::Migration
  def change
    create_table :crawl_results,:id=>false do |t|
      t.column :api_type, "int(11) PRIMARY KEY"
      t.integer :offset
      t.datetime :updated_at

      t.timestamps
    end
  end
end
