class OrdersController < ApplicationController
  before_action :authenticate_barista

  def index
  end

  def create
    order_create_response = OrderCreateService.new(current_barista.code).create
    if order_create_response.success?
      redirect_to order_url(order_create_response.order)
    else
      flash[:errors] = order_create_response.errors.join('. ')
      render 'index'
    end
  end

  def show
    @coffees = MenuItem.joins(:categories).where('categories.name = ?', 'coffee').order('name')
    @teas = MenuItem.joins(:categories).where('categories.name = ?', 'tea').order('name')
    @order = Order.find(params[:id])
    @menu_items = @order.menu_items
  end

  def add
    load_menu_items
    @order = Order.find(params[:order_id])
    @menu_items = @order.menu_items
    @item = MenuItem.find(params[:item_id])
    order_add_response = OrderAddItemService.new(@order.id).add(@item)

    if order_add_response.success?
      flash[:notice] = 'item successfully added.'
      render 'show'
    else
      flash[:error] = 'Item could not be added'
      render 'show'
    end
  end

  def accept
    load_menu_items
    @order = Order.find(params[:order_id])
    @menu_items = @order.menu_items

    order_accept_service = OrderAcceptService.new(@order.id, 'Test Customer').accept!
    if order_accept_service.success?
      flash[:notice] = 'Order has been successfully accepted'
      render 'show'
    else
      flash['error'] = 'The order could not be closed at this point.'
      render 'show'
    end
  end

  def destroy
    load_menu_items
    @order = Order.find(params[:id])

    if @order.cancel!
      flash[:notice] = 'Order was successfully cancelled'
      render 'show'
    else
      flash[:notice] = 'Order could not be cancelled at this point'
      render 'show'
    end
  end

  private

  def load_menu_items
    @coffees = MenuItem.joins(:categories).where('categories.name = ?', 'coffee').order('name')
    @teas = MenuItem.joins(:categories).where('categories.name = ?', 'tea').order('name')
  end
end
