# == Schema Information
#
# Table name: orders
#
#  id            :bigint           not null, primary key
#  restaurant_id :bigint
#  order_id      :string
#  customer_name :string
#  time          :datetime
#  publish_time  :datetime
#  status        :string
#  info          :json
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class Order < ApplicationRecord
    belongs_to :restaurant, foreign_key: :restaurant_id, optional: true
    validates_presence_of :order_id, :customer_name, :time, :publish_time, :status
    validates_uniqueness_of :order_id
    validates :status, inclusion: { in: ['Received', 'Prepared', 'Packaged', 'Waiting for pickup', 'In route', 'Delivered']}

end
