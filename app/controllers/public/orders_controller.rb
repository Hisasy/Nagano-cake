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
      @sta = params[:order][:order_address_id].to_i
      @address = Address.find(@sta)
      @order.shipping_postal_code = @address.postal_code
      @order. shipping_address = @address.address
      @order.name = @address.name

    elsif params[:order][:address_option] == "2"
      @order.shipping_postal_code = params[:order][:postal_code]
      @order.shipping_address = params[:order][:address]
      @order.name = params[:order][:name]

      # 新しい住所を追加する際、未入力の項目があったら先に進めない記述
      if @order.shipping_postal_code.blank? or @order.shipping_address.blank? or @order.name.blank?
        render :new
      end

    else
      render :new
      flash.now[:notice] = "住所を入力してください"
    end

  end

  def thanks
  end

  def create
    @order = Order.new(order_params)
    @order.postage = 800
    @cart_items = current_customer.cart_items
    @order.customer_id = current_customer.id

    if @order.save
      @cart_items.each do |cart_item|
        OrderDetail.create!(
          amount: cart_item.amount,
          item_id: cart_item.item_id,
          order_id: @order.id,
          price: cart_item.add_tax_price
          )
      end
      @cart_items.destroy_all
      redirect_to orders_thanks_path

    else
       render :index
    end

  end

  def index
    @orders = current_customer.orders.order(created_at: "DESC")
  end

  def show
    @order = Order.find(params[:id])
    @order.postage = 800
    @order_details = @order.order_details
  end

private

def order_params
    params.require(:order).permit(:method_of_payment, :shipping_postal_code, :shipping_address, :billing_amount, :name)
end

end
