class Public::CartItemsController < ApplicationController

  before_action :authenticate_customer!

  def index
    @cart_items = current_customer.cart_items.all
    @total = @cart_items.inject(0) { |sum, item| sum + item.sub_price }
  end

  def create
    @cart_item = CartItem.new(cart_item_params)
    @cart_item.customer_id = current_customer.id
    @cart_items = current_customer.cart_items.all
    # 数量を変更できるようにする記述
    @cart_items.each do |cart_item|
    # すでにカートにあるitemと新しく追加したitemが同じ場合
      if cart_item.item_id == @cart_item.item_id
      # 数量が追加されていく
      new_amount = cart_item.amount + @cart_item.amount
      # モデル.update_attribute(属性値,値)で条件に一致するモデルオブジェクトを更新する
      cart_item.update_attribute(:amount, new_amount)
      @cart_item.delete
      end
    end
    @cart_item.save
    redirect_to cart_items_path,notice:'カートに商品が追加されました'
  end

  def update
    @cart_item = CartItem.find(params[:id])
    @cart_item.update(cart_item_params)
    redirect_to cart_items_path
  end

  def destroy
    @cart_item = CartItem.find(params[:id])
    @cart_item.destroy
    redirect_to cart_items_path
  end

  def destroy_all
    # 全てを削除するのでfindではなくall
    @cart_items = current_customer.cart_items.all
    @cart_items.destroy_all
    redirect_to cart_items_path
  end

  private

  def cart_item_params
    params.require(:cart_item).permit(:item_id,:customer_id,:amount)
  end

end
