class Admin::DashboardController < ApplicationController
  http_basic_authenticate_with name: ENV['AUTH_USER'], password: ENV['AUTH_PASS']
  def show
    @category = Category.count
    @product = Product.count
  end
end
