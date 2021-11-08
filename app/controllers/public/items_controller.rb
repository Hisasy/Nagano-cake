class Public::ItemsController < ApplicationController
  before_action :authenticate_customer!, except: [:index]

  def index
    @items = Item.all
    # @item = Item.find(params[:id])
    @items = Item.page(params[:page]).per(8)
    @genres = Genre.all
  end

  def show
    @item = Item.find(params[:id])
    
  end

end
