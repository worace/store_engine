class ProductsController < ApplicationController
  before_filter :lookup_product, :only => [:show, :edit, :update, :destroy]

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(params[:product])
    if @product.save
      redirect_to product_path(@product), :notice => "WAY TO ADD A PRODUCT!"
    else
      render :new, :notice => "TRY AGAIN FOOL"
    end
  end

  def edit

  end

  def update
    if @product.update_attributes(params[:product])
      redirect_to product_path(@product), :notice => "Updated"
    else
      render :edit
    end
  end

  def show
  end

  def index
    @products = Product.all
    # if !logged_in?
    #   redirect_to signup_path
    # end
  end

  def destroy
    if @product.destroy
      redirect_to products_path
    else
      render :show, :notice => "Couldn't delete!"
    end
  end

  private

  def lookup_product
    @product = Product.find(params[:id])
  end
  
end