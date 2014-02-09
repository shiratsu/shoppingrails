# coding: utf-8
require 'open-uri'
require 'json'
require "date"

class Tasks::RakutenCrawl

  #変数初期化
  @@start       = 0;
  @@apikey      = '1059788590851227265'
  @@loop_limit  = 5
  @@loop_count  = 0
  @@api_url = 'https://app.rakuten.co.jp/services/api/IchibaItem/Search/20130805'
  @@category_name = nil
  @@hits = 30

  # メイン処理
  def self.execute(category_id)



    #まずは、DBから値を取得
    # crawl_result = CrawlResult.find(:all ,:conditions => {:api_type => 1})
    crawl_result = CrawlResult.find(3)
    # crawl_result = CrawlResult.find('SELECT * from crawl_results WHERE api_type = 1')

    #まずは、DBから値を取得
    categories = Category.find(:all, :conditions => {:category_id => category_id})
    #puts @crawl_result.first.offset

    #カテゴリ名を取り出す
    unless categories.blank?
      @@category_name = categories.first.category_name
    end

    #終了ポイントがあれば取り出す
    unless crawl_result.blank?
      @@start = crawl_result.offset
    end

    for @@loop_count in 0..@@loop_limit do
puts category_id.to_s
      self.main(category_id)

    end



    ##ループ結果を保存して終了
    crawl_result.offset = @@start
    crawl_result.save


  end

  def self.main(category_id)
    uri = URI.parse(@@api_url+'?applicationId='+@@apikey+'&genreId='+category_id.to_s+'&offset='+@@start.to_s+'&hits='+@@hits.to_s)
    json = Net::HTTP.get(uri)
    result = JSON.parse(json)
    # puts uri
    # puts result

    return_count = result['pageCount']

    hash = result['Items']
    # puts hash

    #ループでバルクインサート作る
    products_list = []
    crawl_list = []
    image_small_url = '';
    image_medium_url = '';

    hash.each do |product|
      if product['Item']['itemName'] != nil
        # puts product
        if product['Item']['smallImageUrls'][0]['imageUrl'] != nil
          image_small_url = product['Item']['smallImageUrls'][0]['imageUrl']
        end
        if product['Item']['mediumImageUrls'][0]['imageUrl'] != nil
          image_medium_url = product['Item']['mediumImageUrls'][0]['imageUrl']
        end

        products_list << Products.new(api_type:3,
        product_name: product['Item']['itemName'],
        category_name: @@category_name,
        description: product['Item']['catchcopy'],
        url: product['Item']['itemUrl'],
        image_small_url: image_small_url,
        image_medium_url: image_medium_url,
        product_id: product['Item']['itemCode'],
        fixed_price: product['Item']['itemPrice'],
        review_average: product['Item']['reviewAverage'],
        default_price: '',
        sale_price: '',
        period_start: '',
        period_end: '',
        )

      end
    end
    Products.import products_list
    @@start += return_count

  end

end