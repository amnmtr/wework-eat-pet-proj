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

class Cuisine < ApplicationRecord
  has_many :restaurants
  validates_presence_of :name
end
