class CartsController < ApplicationController
  before_action :set_item, only: :update

  def update
    add_cart_item

    Turbo::StreamsChannel.broadcast_replace_to(
      "cart_stream",
      target: "cart_items",
      html: render(partial: "carts/cart")
    )
  end

  def show
    @vendors = Carts::Compare.new(
      JSON.parse(cookies[:cart])
    ).call
    @q = Item.ransack(params[:q])
  end

  def destroy
    cookies[:cart] = [].to_json

    Turbo::StreamsChannel.broadcast_replace_to(
      "cart_stream",
      target: "cart_items",
      html: render(partial: "carts/cart")
    )
  end

  private

  def add_cart_item
    existing_items = JSON.parse(cookies[:cart])

    if existing_items.blank?
      new_item = [@item.id, @item.name, 1]
      cookies[:cart] = [new_item].to_json
      return
    end

    my_item = existing_items.find do |existing_item|
      existing_item[0] == @item.id
    end

    if my_item
      cookies[:cart] = existing_items.tap do
        my_item = existing_items.find do |existing_item|
          existing_item[0] == @item.id
        end

        my_item[2] += 1 if my_item
      end.to_json
    else
      cookies[:cart] = existing_items.push([@item.id, @item.name, 1]).to_json
    end

  rescue JSON::ParserError
    cookies[:cart] = [].to_json
    return
  end

  def set_item
    @item = Item.find(params[:item_id])
  end
end