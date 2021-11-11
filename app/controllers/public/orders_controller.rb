class Public::OrdersController < ApplicationController

  before_action :authenticate_customer!

  def new
    @order = Order.new
  end

  def comfirm
    @order = Order.new(order_params)
    @cart_items = current_customer.cart_items
    @order.method_of_payment = params[:order][:method_of_payment]
    @order.customer_id = current_customer.id
    @order.postage = 800
    @total = @cart_items.inject(0) { |sum, item| sum + item.sub_price }

    if params[:order][:address_option] == "0"
      @order.shipping_postal_code = current_customer.postal_code
      @order.shipping_address = current_customer.address
      @order.name = current_customer.full_name

    elsif params[:order][:address_option] =="1"
      @address = Address.find(params[:order][:order_address_id])
      @order.shipping_postal_code = @address.postal_code
      @order. shipping_address = @address.address
      @order.name = @address.name

    elsif params[:order][:address_option] == "2"
      @order.shipping_postal_code = params[:order][:postal_code]
      @order.shipping_address = params[:order][:order_address]
      @order.name = params[:order][:name]

    else
      render :new
      flash.now[:notice] = "住所を入力してください"
    end

  end

  def thanks
  end

  def create
  end

  def index
  end

  def show
  end

private

def order_params
    params.require(:order).permit(:method_of_payment, :shipping_postal_code, :shipping_address, :billing_amount, :name)
end

end
