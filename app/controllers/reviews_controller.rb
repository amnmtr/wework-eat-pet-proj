class ReviewsController < ApplicationController
  before_action :find_restaurant , only: [:create]

  def index
    render :json => Review.all.to_json(:except => [:created_at, :updated_at, :id, :restaurant_id])
  end

  def new
    @review = Review.new
  end

  def create
    puts "creating a review #{params["review"]}"
    # Parameters: {"review"=>{"name"=>"dsdas", "comment"=>"dasdas", "rating"=>4, "restaurant_id"=>2}}
    @review = @restaurant.reviews.create(review_params)
    #@review = Review.new(review_params)
    #@review.restaurant = @restaurant

    if @review.save
      render json: { msg: "created review"}, status: :ok
    else
      render json: { errors: @review.errors }, status: :unprocessable_entity
    end

  end

  def show
    @review = Review.find(params[:id])
  end

  def update
    @review = Review.find(params[:id])

    if @review.update_attributes(review_params)
      render json: { msg: "updated review"}, status: :ok
    else
      render json: { errors: @review.errors }, status: :unprocessable_entity
    end
  end

  def destroy
    @review = Review.find(params[:id])

    if @review.destroy
      render json: { msg: "deleted review"}, status: :ok
    else
      render json: { errors: @review.errors }, status: :unprocessable_entity
    end
  end

  private

  def review_params
    params.require(:review).permit(:name, :rating, :comment, :restaurant_id)
  end

  def find_restaurant
    @restaurant = Restaurant.find(params["review"]["restaurant_id"])
  end
end
