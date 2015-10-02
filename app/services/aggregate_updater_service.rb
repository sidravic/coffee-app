class AggregateUpdaterService
  attr_reader :menu_item, :aggregate

  def initialize(menu_item)
    @menu_item = menu_item
  end

  def update_aggregate
    find_and_update_aggregate do
      increment_sales_count
      increment_sales_amount
    end
  end

  private

  def find_and_update_aggregate
    @aggregate = menu_item.sales_aggregate
    yield
    aggregate.save
  end

  def increment_sales_count
    aggregate.sale_count += 1
  end

  def increment_sales_amount
    aggregate.sales_amount_total += menu_item.price_in_cents
  end
end