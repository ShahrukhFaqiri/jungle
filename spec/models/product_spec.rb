require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    before do
      @category = Category.new(name: 'Appliances')
      @category.save
    end
    it 'create product with required params' do
      @product = @category.products.create!(name: 'Fridge', price: 4005, quantity: 1, category: @category)
      @product.save
      expect(@product).to be_valid
    end
    it 'empty name should give error' do
      @product = @category.products.new(name: nil, price: 4005, quantity: 1, category: @category)
      @product.save

      expect(@product.errors.full_messages).to include('Name can\'t be blank')
    end
    it 'empty price should give error' do
      @product = @category.products.new(name: 'Fridge', price: nil, quantity: 1, category: @category)
      @product.save

      expect(@product.errors.full_messages).to include('Price is not a number')
    end
    it 'empty quantity should give error' do
      @product = @category.products.new(name: 'Fridge', price: 4005, quantity: nil, category: @category)
      @product.save

      expect(@product.errors.full_messages).to include('Quantity can\'t be blank')
    end
    it 'category cant be undefined or undefined it should give error' do
      @product = Product.new(name: 'Fridge', price: 4005, quantity: 1)
      @product.save

      expect(@product.errors.full_messages).to include('Category can\'t be blank')
    end
  end
end
