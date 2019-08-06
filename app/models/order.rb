class Order < ApplicationRecord
    belongs_to :restaurant, foreign_key: :restaurant_id, optional: true
    validates_presence_of :order_id, :customer_name, :time, :publish_time, :status
    validates_uniqueness_of :order_id
    validates :status, inclusion: { in: ['Received', 'Prepared', 'Packaged', 'Waiting for pickup', 'In route', 'Delivered']}

end
