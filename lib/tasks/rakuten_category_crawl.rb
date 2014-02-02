# coding: utf-8
require 'net/http'
require 'uri'
require 'json'
require "date"

class Tasks::RakutenCategoryCrawl

  # メイン処理
  def self.execute
    d = Date.today
    now = d.strftime("%Y-%m-%d %H:%M:%S")

    #APIリクエスト回数
    start = 0;
    apiRequestLimit = 2000
    apikey = '1059788590851227265'
    category_id=0
    url = 'https://app.rakuten.co.jp/services/api/IchibaGenre/Search/20120723'

    #jsonとってきてパース
    uri = URI.parse(url+'?applicationId='+apikey+'&genreId='+category_id.to_s+'&format=json')
    json = Net::HTTP.get(uri)
    result = JSON.parse(json)

    # puts result

    hash = result['children']
    # puts hash

    #ループでバルクインサート作る
    category_list = []
    hash.each do |category|
      # puts category
      if category['child']['genreId'] != nil
        category_list << Category.new(category_id: category['child']['genreId'],
        category_name: category['child']['genreName'],
        api_type: 3)
      end
    end
#
    Category.import category_list

  end

end