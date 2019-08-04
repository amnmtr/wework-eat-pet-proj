# == Schema Information
#
# Table name: cuisines
#
#  id         :integer          not null, primary key
#  name       :string
#  icon       :binary
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe Cuisine, type: :model do
  context 'validations' do
    it 'ensure name is mandatory' do
      cuisine = Cuisine.new(:name => nil, :icon => nil).save
      expect(cuisine).to eq(false)
    end
    it 'ensure cuisine save success' do
      cuisine = Cuisine.new(:name => 'test_cuisine', :icon => nil).save
      expect(cuisine).to eq(true)
    end
  end
end
