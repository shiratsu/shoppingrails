# coding: utf-8
require 'net/http'
require 'uri'
require 'json'
require "date"

class Tasks::YahooCategoryCrawl

  # メイン処理
  def self.execute
    d = Date.today
    now = d.strftime("%Y-%m-%d %H:%M:%S")

    #APIリクエスト回数
    start = 0;
    apiRequestLimit = 2000
    apikey = 'dj0zaiZpPU0yMGNPVnFnUTJ2NSZzPWNvbnN1bWVyc2VjcmV0Jng9YTQ-'
    category_id=1

    #jsonとってきてパース
    uri = URI.parse('http://shopping.yahooapis.jp/ShoppingWebService/V1/json/categorySearch?appid='+apikey+'&category_id='+category_id.to_s)
    json = Net::HTTP.get(uri)
    result = JSON.parse(json)

    hash = result['ResultSet']['0']['Result']['Categories']['Children']
    #puts hash

    #ループでバルクインサート作る
    category_list = []
    hash.each do |product|
      if product[1]['Url'] != nil
        puts product[1]['Url']
        puts product[1]['Id']
        puts product[1]['Title']['Medium']
        puts '======================================'
      end
    end
  end

end