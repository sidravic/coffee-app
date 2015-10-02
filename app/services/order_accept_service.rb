class OrderAcceptService
  INVALID_ORDER_ERROR = 'Invalid Order'
  INVALID_ORDER_STATUS = 'Order is not open for an update.'

  attr_reader :order, :customer_name,
              :order_id, :customer, :errors

  def initialize(order_id, customer_name)
    @order_id = order_id
    @customer_name = customer_name
    @errors = []
  end

  def accept!
    accept_order
    OrderAcceptResponse.new(order, errors)
  end

  private

  def find_order
    @order = Order.where(id: order_id).last
  end

  def accept_order
    find_and_accept_order do
      create_customer
      update_order
      update_aggregates
    end
  end

  def find_and_accept_order
    find_order

    if not order
      add_error(INVALID_ORDER_ERROR)
      return
    end

    if not order.open?
      add_error(INVALID_ORDER_STATUS)
      return
    end

    yield
  end

  def   create_customer
    @customer = order.create_customer(name: customer_name) if order
  end

  def update_order
    order.accept!
  end

  def add_error(message)
    @errors.push(message)
  end

  def update_aggregates
    order.menu_items.each do |menu_item|
      AggregateUpdaterService.new(menu_item).update_aggregate
    end
  end
end

class OrderAcceptResponse
  attr_reader :errors, :order, :success

  def initialize(order, errors)
    @order = order
    @errors = errors
    @success = order_success? ? true : false
  end

  def order_success?
    (errors.empty? and order.accepted?)
  end

  def success?
    success
  end
end