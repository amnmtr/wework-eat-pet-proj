class CuisinesController < ApplicationController
  def index
    render :json => Cuisine.all.to_json(except: [:created_at, :updated_at, :id])
  end
end
