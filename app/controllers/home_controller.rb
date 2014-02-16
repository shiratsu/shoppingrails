class HomeController < ApplicationController

  def index

    start = 0;

    @products = Products.find(:all,:offset => start,:limit => 20)
    # puts @products
    @products.each do |product|
      puts product.product_name
    end
  end
end
