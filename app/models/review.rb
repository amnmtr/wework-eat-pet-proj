# == Schema Information
#
# Table name: reviews
#
#  id            :integer          not null, primary key
#  name          :string
#  rating        :integer
#  comment       :text
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  restaurant_id :integer
#

class Review < ApplicationRecord

  belongs_to :restaurant, foreign_key: :restaurant_id, optional: true

  validates_presence_of :name, :rating
  validates_inclusion_of :rating, :in => 1..5

end
