class TotalSalesGenerator

  attr_reader :accepted_orders

  def initialize
  end

  def self.generate
    service = new
    service.total_sales
  end

  def total_sales
    @accepted_orders = order.accepted
    @total_sales = accepted_orders.sum(:amount_in_cents)
  end
end