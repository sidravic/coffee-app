class OrderCreateService
  INVALID_BARISTA_CODE = 'Invalid Barista code'
  OPEN_ORDER_ERROR = 'Barista already has another open order'

  attr_reader :barista_code, :order, :barista, :errors


  def initialize(barista_code)
    @barista_code = barista_code
    @barista = nil
    @order = nil
    @errors = []
  end

  def create
    find_barista
    open_order if barista

    OrderCreateResponse.new(order, errors)
  end

  private

  def find_barista
    @barista = Barista.find_by_code(barista_code)
    add_errors(INVALID_BARISTA_CODE) if not barista

    barista
  end

  def open_order
    if not has_open_orders?(barista)
      create_order
    else
      add_errors(OPEN_ORDER_ERROR)
    end
  end

  def create_order
    @order = Order.create_for(barista)
  end

  def has_open_orders?(barista)
    barista.orders.open.empty? ? false : true
  end

  def add_errors(message)
    @errors.push(message)
  end
end

class OrderCreateResponse
  attr_accessor :order, :errors, :success

  def initialize(order, errors)
    @errors = errors
    @success = has_errors? ? false : true
    @order = order
  end

  def success?
    success
  end

  def has_errors?
    !errors.empty?
  end
end