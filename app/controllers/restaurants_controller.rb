class RestaurantsController < ApplicationController

  include Response
  include ActiveModel
  def index
    @restaurants = Restaurant.all
    # Cuisine.find(@restaurants.cuisine_id)
    # render :json => @restaurants.to_json(:except => [:created_at, :updated_at], include: 'cuisine' )
    render :json => @restaurants.to_json(:except => [:created_at, :updated_at, :cuisine_id], :include => {:reviews => {:except => [:created_at, :updated_at, :restaurant_id]}, :cuisine => {:except => [:created_at, :updated_at]}})
  end

  def averageRating
    @avg = nil
    begin
      @restaurant = Restaurant.find(params["restaurant_id"])
      if !@restaurant.reviews.empty?
        @avg = @restaurant.reviews.reduce(0) { |sum, el| sum + el.rating }.to_f / @restaurant.reviews.size
      end
    rescue ActiveRecord::RecordNotFound  => e
      render json: { errors: e.message }, status: :bad_request
    rescue Exception => e
      render json: { errors: e.message }, status: :internal_server_error
    end

    render  :json => { "average_rating": @avg}
  end

end


