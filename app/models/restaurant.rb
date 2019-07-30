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
  require "json-schema"

  has_many :reviews, foreign_key: :restaurant_id, dependent: :destroy
  belongs_to :cuisine, foreign_key: :cuisine_id

  validates_presence_of :name, :address, :max_delivery_time, :accepts_10bis, :coordinates, :cuisine_id
  validate :coordinates_is_a_json
  validates :max_delivery_time, :numericality => { :greater_than_or_equal_to => 0 }


  GEO_LOCATION_SCHEMA = {
      "type" => "object",
      "required" => ["lat", "lng"],
      "properties" => {
          "lat" => {"type" => "decimal"},
          "lng" => {"type" => "decimal"}
      }
  }


  def coordinates_is_a_json

    begin
      puts "validating coordinates"
      puts GEO_LOCATION_SCHEMA.to_s
      puts coordinates
      JSON::Validator.validate!(GEO_LOCATION_SCHEMA, coordinates)
    rescue JSON::Schema::ValidationError => e
      puts "json validation error " + e.message
      errors.add(:coordinates, e.message)
    end
  end
end
