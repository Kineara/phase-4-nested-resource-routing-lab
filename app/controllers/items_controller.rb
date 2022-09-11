class ItemsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response

  def index
    if params[:user_id]
      user = User.find(params[:user_id])
      items = user.items
      render json: items
    else
      items = Item.all
      render json: items, include: :user
    end
  end

  def show
    if params[:user_id]
      user = User.find(params[:user_id])
      item = user.items.find(params[:user_id])
      render json: item
    else
      item = Item.find(params[:item_id])
      render json: item
    end
  end

  def create 
    if params[:user_id]
      user = User.find(params[:user_id])
      item = user.create_item(name: params[:name], description: params[:description], price: params[:price])
      render json: item, status: :created
    else
      item = Item.create(name: params[:name], description: params[:description], price: params[:price])
    end
  end

  private

  def render_not_found_response
    render json: { error: 'Item not found' }, status: :not_found
  end
end
