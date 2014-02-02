# coding: utf-8
require 'open-uri'
require 'json'
require "date"
require 'amazon/ecs'

class Tasks::AmazonCrawl

  #変数初期化
  @@api_url = 'http://ecs.amazonaws.com/onca/xml'


  # メイン処理
  def self.execute(category_id)

    Amazon::Ecs.options = {
      :associate_tag => 'shiratsu2014-22',
      :AWS_access_key_id => '14GKTW6QN5G14DGTNFG2',
      :AWS_secret_key => 'wZJovZno6tiy0SgOHP6kZEtPp3HbkMNaltp/5Ir7'
    }

    #まずは、DBから値を取得
    now = d.strftime("%Y-%m-%d %H:%M:%S")
    products = Products.find(:all, :conditions => {:api_type => 1,:created_at => now})

    products.each do |item|

      self.main(item.product_name)

    end

  end

  def self.main(name)
    res = Amazon::Ecs.item_search('ruby', :search_index => 'All',:response_group => 'ItemAttributes,Offers, Images ,Reviews', :country => 'jp')
    products_list = []

    if(res.items.length > 0)
      res.items.each do |item|
        puts("asin: #{item.get('ASIN')}")
        puts("url: #{item.get('DetailPageURL')}")
        puts("title: #{item.get('ItemAttributes/Title')}")
        puts("price: #{item.get('ItemAttributes/ListPrice/FormattedPrice')}")
        puts("price: #{item.get('ItemAttributes/ListPrice/Amount').to_s}")
        puts("image: #{item.get('MediumImage/URL')}")
        puts("image: #{item.get('SmallImage/URL')}")
        puts("中古在庫 : #{item.get('OfferSummary/TotalUsed')}")
        puts("中古価格 : #{item.get('OfferSummary/LowestUsedPrice/Amount').to_s}")

        puts item

        products_list << Products.new(api_type:1,
        product_name: item.get('ItemAttributes/Title'),
        category_name: '',
        description: '',
        url: item.get('DetailPageURL'),
        image_small_url: item.get('SmallImage/URL'),
        image_medium_url: item.get('MediumImage/URL'),
        product_id: item.get('ASIN'),
        fixed_price: item.get('ItemAttributes/ListPrice/Amount'),
        used_price: item.get('OfferSummary/LowestUsedPrice/Amount'),
        total_used: item.get('OfferSummary/TotalUsed')
        )

      end
    else
      puts("#{ARGV[0]}: products not found")
    end

    Products.import products_list
    @@start += return_count

  end

end