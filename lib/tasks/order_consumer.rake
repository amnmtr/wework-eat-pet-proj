namespace :queue do

  RABBIT_URL="amqp://guest:guest@rabbitmq"

  desc "start consuming rabbitMQ messages"
  task consume: :environment do
    conn = Bunny.new(RABBIT_URL)
    conn.start
    channel = conn.create_channel
    queue = channel.queue( 'delivery.status_updated', auto_delete: true)

    puts "subscribing"
    queue.subscribe(block: true) do |_, _, payload|
  # DO STUFF
      puts "Consuming!! : " + payload.to_s

      puts "sending to sidekiq worker : " + payload.to_s
      OrderProcessor.perform_async(payload)

    end
  end

  desc "sending a msg"
  task produce: :environment do
      conn = Bunny.new(RABBIT_URL)
      conn.start
      ch = conn.create_channel
      queue = ch.queue('delivery.status_updated', auto_delete: true)
      exchange = ch.default_exchange
      puts 'publsihing msg'
      exchange.publish("hello world", routing_key: queue.name)
  end

end
