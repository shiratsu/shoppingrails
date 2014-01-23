# coding: utf-8
require 'open-uri'
require 'json'
require "date"

class Tasks::YahooCrawl

  #APIリクエスト回数
  start = 0;
  apikey = 'dj0zaiZpPU0yMGNPVnFnUTJ2NSZzPWNvbnN1bWVyc2VjcmV0Jng9YTQ-'
  category_id=1

  # メイン処理
  def self.execute
    content = open('http://shopping.yahooapis.jp/ShoppingWebService/V1/categorySearch?appid='+apikey+'&category_id='+category_id).read
    req = Net::HTTP::Get.new(url.path)
    res = Net::HTTP.start(url.host, url.port) {|http|
      http.request(req)
    }
    doc = REXML::Document.new(res.body)
    array = []
    statusCode = response.code


  end

end