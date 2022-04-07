class Admin::CategoriesController < ApplicationController
  http_basic_authenticate_with name: ENV['AUTH_USER'], password: ENV['AUTH_PASS']
  def index
    @category = Category.all
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)

    if @category.save
      redirect_to [:admin, :cateogries], notice: 'Category created!'
    else
      render :new
    end
  end

  private

  def category_params
    params.require(:cateogries).permit(:name)
  end

end
