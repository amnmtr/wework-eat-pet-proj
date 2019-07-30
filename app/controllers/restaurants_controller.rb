class RestaurantsController < ApplicationController
  include ActiveModel



  end

  def index
    @restaurants = Restaurant.all
    render :json => @restaurants.to_json(except: [:created_at, :updated_at, :cuisine_id], include: {reviews: {except: [:created_at, :updated_at, :restaurant_id]}, cuisine: {except: [:id, :created_at, :updated_at]}})
  end

  def average_rating
    average = nil
    begin
      @restaurant = Restaurant.find(params["restaurant_id"])
      if !@restaurant.reviews.empty?
        average = @restaurant.reviews.average :rating
      end
    rescue ActiveRecord::RecordNotFound  => e
      render json: { errors: e.message }, status: :bad_request
    end

    render  :json => { "average_rating": average}
  end

end


