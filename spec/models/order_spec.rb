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

require 'rails_helper'

RSpec.describe Order, type: :model do
  context 'validations' do

    it { should validate_presence_of(:order_id) }
    it { should validate_presence_of(:customer_name) }
    it { should validate_presence_of(:time) }
    it { should validate_presence_of(:publish_time) }
    it { should validate_presence_of(:status) }
    
    it { should validate_uniqueness_of(:order_id) }
    
    it { should belong_to(:restaurant) } 

    
    it 'ensure status valid value' do
      order = Order.create(order_id: 'order_uuid', customer_name: 'name dummy', time: '2019-08-06 18:29:57', publish_time: '2019-08-06 18:29:57', status: 'DummyStatus')
      expect(order.valid?).to eq(false)
    end
    it 'ensure order save success' do
      order = Order.create(order_id: 'order_uuid', customer_name: 'name dummy', time: '2019-08-06 18:29:57', publish_time: '2019-08-06 18:29:57', status: 'Received')
      expect(order.errors).to be_empty
    end

  end
end