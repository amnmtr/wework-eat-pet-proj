require 'rails_helper'

RSpec.describe Review, type: :model do
  context 'validations' do
    it 'ensure name is mandatory' do
      review = Review.new(name: nil, rating: 3).save
      expect(review).to eq(false)
    end
    it 'ensure rating between 1 and 5' do
      review = Review.new(name: 'test_review', rating: 6).save
      expect(review).to eq(false)
    end
    it 'ensure review save' do
      cuisine = Cuisine.create(name: "italian")
      restaurant = Restaurant.create(name: "restaurant_dummy", address: "address dummy", accepts_10bis: true, :max_delivery_time => 30, :coordinates => {"lat": 11, "lng": 78}, :cuisine => cuisine)
      review = Review.new(name: 'test_review', rating: 5, restaurant: restaurant).save
      expect(review).to eq(true)
    end
    it { should belong_to(:restaurant) } 
  end
end
