class RestaurantsController < ApplicationController
  before_action :authenticate_user!, :except => [:index, :show]

  def index
    @restaurants = Restaurant.all
  end

  def new
    @restaurant = Restaurant.new
  end

  def create
    #@user = User.find(current_user.id)
    @restaurant =current_user.restaurants.build_with_user(restaurant_params, current_user)
    # @restaurant.user_id = current_user.id
    if @restaurant.save
      redirect_to restaurants_path
    else
      render 'new'
    end
  end

  def show
    @restaurant = Restaurant.find(params[:id])
  end

  def edit
    @restaurant = Restaurant.find(params[:id])
  end

  def update
    @restaurant = Restaurant.find(params[:id])
    @restaurant.update(restaurant_params)
    redirect_to '/restaurants'
  end

  def destroy
    @restaurant = Restaurant.find(params[:id])
    # @restaurant.destroy
    if current_user.restaurants.delete_with_user(@restaurant, current_user[:id])
      flash[:notice] = 'Restaurant deleted successfully'
      redirect_to '/restaurants'
      else
        flash[:notice] = 'Only restaurant owner can delete restaurant'
        redirect_to '/restaurants'
      end
  end


  private

  def restaurant_params
    params.require(:restaurant).permit(:name, :description)
  end

end
