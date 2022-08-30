class ItemsController < ApplicationController
  before_action :set_item, only: :show

  def index
    @q = Item.ransack(params[:q])
    items = @q.result(distinct: true)

    @pagy, @items = pagy(items)
  end

  def show
    @q = Item.ransack(params[:q])
    @item_prices = @item.item_prices.found.includes(:vendor)
  end

  private

  def set_item
    @item ||= Item.find(params[:id])
  end
end