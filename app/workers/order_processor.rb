class OrderProcessor
  include Sidekiq::Worker
  sidekiq_options backtrace: true, queue: :deliveries
  def perform(consumed_order)
    begin
      puts 'sidekiq worker processed ' + consumed_order.to_s
      consumed_order = JSON.parse(consumed_order)
      order = Order.find_or_initialize_by(order_id: consumed_order['order_id'] )
      if order.publish_time.nil? || order.publish_time < consumed_order['publish_time']
        order.customer_name = consumed_order['customer_name']
        order.time = consumed_order['time']
        order.publish_time = consumed_order['publish_time']
        order.status = consumed_order['status']
      end
      

      extra_info = fill_extra_info consumed_order

      if(order.info.nil?)
        order.info = extra_info
      else
        order.info.merge(extra_info)
      end

      order.save!
    rescue => exception
      exception.to_s
    end
  end


  private
  def fill_extra_info (consumed_order)
      extra_info = {}
      extra_info[:courier] = consumed_order['courier'] if !consumed_order['courier'].nil?
      extra_info[:cook] = consumed_order['cook'] if !consumed_order['cook'].nil?
      extra_info[:estimated_time_of_arrival] = consumed_order['estimated_time_of_arrival'] if !consumed_order['estimated_time_of_arrival'].nil?
      extra_info[:signed_by] = consumed_order['signed_by'] if !consumed_order['signed_by'].nil?
  
      return extra_info
  end

end