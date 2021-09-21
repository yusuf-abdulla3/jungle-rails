require 'rails_helper'

RSpec.describe Product, type: :model do
 describe 'Validations' do

  context "All fields filled out" do
    it "Saves successfully" do
      @category = Category.new
      @category.name = "Big"
      @product = Product.new
      @product.name = "Test"
      @product.price = 14.00
      @product.quantity= 18
      @product.category = @category
      @product.save
      expect(@product.errors.full_messages).to match_array([])
    end
  end
  
  context "Missing name" do
    it "Raises error" do
      @category = Category.new
      @category.name = "Big"
      @product = Product.new
      @product.name = nil
      @product.price = 14.00
      @product.quantity= 18
      @product.category = @category
      @product.save
      expect(@product.errors.full_messages).to include "Name can't be blank"
    end
  end

  context "Missing price" do
    it "Raises error" do
      @category = Category.new
      @category.name = "Big"
      @product = Product.new
      @product.name = "Omar"
      @product.price = nil
      @product.quantity= 18
      @product.category = @category
      @product.save
      expect(@product.errors.full_messages).to include "Price can't be blank"
    end
  end


  context "Missing quantity" do
    it "Raises error" do
      @category = Category.new
      @category.name = "Big"
      @product = Product.new
      @product.name = "Test"
      @product.price = 12
      @product.quantity= nil
      @product.category = @category
      @product.save
      expect(@product.errors.full_messages).to include "Quantity can't be blank"
    end
  end

  context "Missing category" do
    it "Raises error" do
      @category = Category.new
      @category.name = "Big"
      @product = Product.new
      @product.name = "Test"
      @product.price = 12
      @product.quantity= 12
      @product.category = nil
      @product.save
      expect(@product.errors.full_messages).to include "Category can't be blank"
    end
  end

      
  end
end

