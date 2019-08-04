require 'rails_helper'

RSpec.describe Restaurant, type: :model do
  context 'validations' do
    it 'ensure name is mandatory' do
      cuisine = Cuisine.create(name: 'Persian')
      restaurant = Restaurant.new(name: nil, address: 'address', max_delivery_time: 30, accepts_10bis: true, coordinates: {"lat": 11, "lng": 34.6}, cuisine: cuisine).save
      expect(restaurant).to eq(false)
    end
    it { should validate_presence_of(:address) }
    it { should validate_presence_of(:max_delivery_time) }
    it { should validate_presence_of(:accepts_10bis) }
    it { should validate_presence_of(:coordinates) }
    
    it 'ensure coordinates structure lng missing' do
      cuisine = Cuisine.create(name: 'Persian')
      restaurant = Restaurant.new(name: "test", address: 'address', max_delivery_time: 30, accepts_10bis: true, coordinates: {"lat": 11}, cuisine: cuisine).save
      expect(restaurant).to eq(false)
    end
    it 'ensure coordinates structure lat missing' do
      cuisine = Cuisine.create(name: 'Persian')
      restaurant = Restaurant.new(name: "test", address: 'address', max_delivery_time: 30, accepts_10bis: true, coordinates: {"lng": 11}, cuisine: cuisine).save
      expect(restaurant).to eq(false)
    end
    it 'ensure max deliveray time positive integer ' do
      cuisine = Cuisine.create(name: 'Persian')
      restaurant = Restaurant.new(name: "test", address: 'address', max_delivery_time: -1, accepts_10bis: true, coordinates: {"lat": 44, "lng": 11}, cuisine: cuisine).save
      expect(restaurant).to eq(false)
    end
    it 'ensure address is mandatory' do
      cuisine = Cuisine.create(name: 'Persian')
      restaurant = Restaurant.new(name: "test", address: nil, max_delivery_time: 30, accepts_10bis: true, coordinates: {"lat": 11, "lng": 34.6}, cuisine: cuisine).save
      expect(restaurant).to eq(false)
    end
    it { should belong_to(:cuisine) } 
    it { should have_many(:reviews)}
    it 'ensure restaurant save success' do
      cuisine = Cuisine.create(name: 'italian')
      restaurant = Restaurant.create(name: 'restaurant_dummy', address: 'address dummy', accepts_10bis: true, max_delivery_time: 30, coordinates: {"lat": 11, "lng": 78}, cuisine: cuisine)
      expect(restaurant.errors).to be_empty
    end

  end
end
