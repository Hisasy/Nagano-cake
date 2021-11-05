class Admin::OrdersController < ApplicationController

  before_action :authenticate_admin!

  def show
    @order = Order.find(params[:id])
    @order.postage = 800
    @order_detail = @order.order_details
  end

  def update
    @order = Order.find(params[:id])
    
  end
end
