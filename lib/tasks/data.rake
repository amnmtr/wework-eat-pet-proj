namespace :data do
  CITY_ID=280
  USER_KEY="64051c9e2b0354b2938b32fcf4cd8fb2"
  ZOMATO_URL = "https://developers.zomato.com/api/v2.1/"
  MAX_ENTITIES=20

  desc "This task does Zomata Cuisines Data import!"
  task :fetch_cuisines  => :environment do
    conn = Faraday.new(
      url: ZOMATO_URL,
      headers: {'Content-Type' => 'application/json', 'user-key' => USER_KEY }
    )

    resp = conn.get('cuisines') do |req|
      req.params['city_id'] = CITY_ID
    end

    JSON.parse(resp.body)["cuisines"].map { |cuisine| initialized_cuisine = Cuisine.find_or_initialize_by(id: cuisine['cuisine']['cuisine_id'])
      initialized_cuisine.name = cuisine['cuisine']['cuisine_name']
      initialized_cuisine.save }
  end
  

  desc "This task does Zomata Restaurants Data import!"
  task :fetch_restaurants  => :environment do
    conn = Faraday.new(
      url: ZOMATO_URL,
      headers: {'Content-Type' => 'application/json', 'user-key' => USER_KEY }
    )
    #Zomato API limits up to 100 restaurants fetch in upto 20 restaurant batches
    (0..80).step(20) do |start|
      resp = conn.get('search') do |req|
        req.params['entity_id'] = CITY_ID
        req.params['entity_type'] = 'city'
        req.params['start'] = start if start != 0
        req.params['count'] = MAX_ENTITIES
      end
      JSON.parse(resp.body)["restaurants"].map { |restaurant| initialized_restaurant = Restaurant.find_or_initialize_by( id: restaurant['restaurant']['id'])
        initialized_restaurant.name = restaurant['restaurant']['name']
        initialized_restaurant.address = restaurant['restaurant']['location']['address']
        initialized_restaurant.accepts_10bis = [true, false].sample
        initialized_restaurant.max_delivery_time = [5, 15, 30, 60, 90].sample
        initialized_restaurant.cuisine = Cuisine.find_by_name(restaurant['restaurant']['cuisines'].split(",").map(&:strip)[0])
        initialized_restaurant.coordinates = {"lat": restaurant['restaurant']['location']['latitude'].to_f, "lng": restaurant['restaurant']['location']['longitude'].to_f}
        restaurant['restaurant']['all_reviews']['reviews'].each do |review|
          initialized_review = initialized_restaurant.reviews.find_or_initialize_by(id: review['review']['id'])
          initialized_review.rating = review['review']['rating']
          initialized_review.name = review['review']['user']['name']
          initialized_review.comment = review['review']['review_text']
          if !initialized_review.save
            puts "Error: failed to save review : " + initialized_review.to_json
          end
        end
        if !initialized_restaurant.save
          puts "Error: failed to save restaurant : " + initialized_restaurant.to_json
        end
        }
    end
  end

  desc "This task does Zomata ALL Data import!"
  task :fetch_all  => [:fetch_cuisines, :fetch_restaurants] do

  end
end 