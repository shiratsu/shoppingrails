class HomeController < ApplicationController

  def index

    @products = Products.page(params[:page]).per(20)
  end
end
