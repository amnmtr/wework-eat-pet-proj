# == Schema Information
#
# Table name: restaurants
#
#  id                :integer          not null, primary key
#  name              :string
#  address           :text
#  accepts_10bis     :boolean
#  max_delivery_time :integer
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  coordinates       :json
#  cuisine_id        :integer
#

class Restaurant < ApplicationRecord
  has_many :reviews, foreign_key: :restaurant_id, dependent: :destroy
  belongs_to :cuisine, foreign_key: :cuisine_id
end
