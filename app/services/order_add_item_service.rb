class OrderAddItemService
  INVALID_ORDER_ERROR = 'Invalid Order'
  INVALID_ORDER_STATUS = 'Order is not open for update'

  attr_reader :order_id, :order, :errors

  def initialize(order_id)
    @order_id = order_id
    @errors = []
  end

  def add(item)
    add_item_to_order do
      add_item(item)
      update_price
    end

    OrderAddItemResponse.new(order, errors)
  end

  private

  def add_item_to_order
    @order = Order.where(id: order_id).last

    unless order
      add_error('Invalid Order')
      return
    end

    yield
  end

  def add_item(item)
    if order.open?
      @item = item
      order.menu_items.push(item)
    else
      add_error(INVALID_ORDER_STATUS)
    end
  end

  def update_price
    updated_price = order.menu_items.sum(:price_in_cents)
    order.update_attributes(amount_in_cents: updated_price)
  end

  def add_error(message)
    errors.push(message)
  end
end

class OrderAddItemResponse
  attr_reader :errors, :success, :order

  def initialize(order, errors)
    @order = order
    @errors = errors
    @success = has_errors? ? false : true
  end

  def has_errors?
    not errors.empty?
  end

  def success?
    success
  end
end