class Admin::HomesController < ApplicationController

  before_action :authenticate_admin!

  def top
    @order = Order.all.order(created_at: "DESC")
  end
end
