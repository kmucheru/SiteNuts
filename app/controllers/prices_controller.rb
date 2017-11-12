class PricesController < ApplicationController
  before_action :verify_is_admin, :only => [:new, :edit, :create, :destroy]
  def new
    @price = Price.new
  end

  def create
    @price = Price.new(price_params)
    if @price.save
      redirect_to @price
    else
      render 'new'
    end
  end

  def index
    @prices = Price.all.order('created_at DESC')
  end

  def show
    @price = Price.find(params[:id])
  end

  def edit
    @price = Price.find(params[:id])
  end

  def update
    @price = Price.find(params[:id])
    if @price.update(params[:price].permit(:b_amount, :name, :description, :indepth, :features))
      redirect_to price_path
    else
      render 'edit'
    end
  end

  def destroy
    @price = Price.find(params[:id])
    @price.destroy
    redirect_to prices_path
  end


  private

  def price_params
    params.require(:price).permit(:b_amount, :name, :description, :indepth, :features)
  end

  def verify_is_admin
  (current_user.nil?) ? redirect_to(root_path) : (redirect_to(root_path) unless current_user.admin?)
  end
end
