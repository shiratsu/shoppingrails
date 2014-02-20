# coding: utf-8
require 'open-uri'
require 'json'
require "date"

class Tasks::CafeCrawl

  #変数初期化
  @@start       = 0;
  @@apikey      = 'b11772330154a9b4-'
  @@loop_limit  = 5
  @@loop_count  = 0
  @@api_url = 'ttp://webservice.recruit.co.jp/hotpepper/gourmet/v1/'


  # メイン処理
  def self.execute(category_id)



    #まずは、DBから値を取得
    crawl_result = CrawlResult.find(4)

    #終了ポイントがあれば取り出す
    unless crawl_result.blank?
      @@start = crawl_result.offset
    end

    for @@loop_count in 0..@@loop_limit do

      self.main(@@genre_id)

    end



    ##ループ結果を保存して終了
    crawl_result.offset = @@start
    crawl_result.save


  end

  def self.main()
    genre_id = 'G014';
    count = 50
    uri = URI.parse(@@api_url+'key='+@@apikey+'&genre='+genre_id+'&offset='+@@start.to_s+'&count='+count.to_s+'&format=json')
    json = Net::HTTP.get(uri)
    result = JSON.parse(json)
    # puts result

    return_count = result['ResultSet']['totalResultsReturned']

    hash = result['ResultSet']['0']['Result']
    # puts hash

    #ループでバルクインサート作る
    products_list = []
    crawl_list = []

    hash.each do |product|
      if product[1]['Name'] != nil
        # puts product[1]['Name']
        # puts product[1]['Description']
        # puts product[1]['Url']
        # puts product[1]['Image']['Small']
        # puts product[1]['Image']['Medium']
        # puts product[1]['ProductId']
        # puts product[1]['PriceLabel']['FixedPrice']
        # puts product[1]['PriceLabel']['DefaultPrice']
        # puts product[1]['PriceLabel']['SalePrice']
        # puts product[1]['PriceLabel']['PeriodStart']
        # puts product[1]['PriceLabel']['PeriodEnd']
        # puts '======================================'

        products_list << Products.new(api_type:1,
        product_name: product[1]['Name'],
        category_name: @@category_name,
        description: product[1]['Description'],
        url: product[1]['Url'],
        image_small_url: product[1]['Image']['Small'],
        image_medium_url: product[1]['Image']['Medium'],
        product_id: product[1]['ProductId'],
        fixed_price: product[1]['PriceLabel']['FixedPrice'],
        default_price: product[1]['PriceLabel']['DefaultPrice'],
        sale_price: product[1]['PriceLabel']['SalePrice'],
        period_start: product[1]['PriceLabel']['PeriodStart'],
        period_end: product[1]['PriceLabel']['PeriodEnd'],
        )

      end
    end
    Products.import products_list
    @@start += return_count

  end

end