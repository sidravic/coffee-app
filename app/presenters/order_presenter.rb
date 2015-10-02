class OrderPresenter
  include ::CurrencyConversionService
  attr_reader :order, :tea_items, :coffee_items

  def initialize(order)
    @order = order
    @coffee_items = []
    @tea_items = []
  end

  def as_json
    grouped_order_items

    {
        teas: teas_as_json,
        coffees: coffee_as_json
    }
  end

  private

  def grouped_order_items
    all_menu_items = order.menu_items.eager_load(:categories)

    teas = select_teas(all_menu_items)
    coffees = select_coffees(all_menu_items)

    coffee_items.push(teas).flatten!
    tea_items.push(coffees).flatten!
  end

  def select_teas(menu_items)
    menu_items.select{ |mi| mi.categories.collect(&:name).include?('tea') }
  end

  def select_coffees(menu_items)
    menu_items.select{ |mi| mi.categories.collect(&:name).include?('coffee')}
  end

  def teas_as_json
    tea_items.map do |tea|
      {
          name: tea.name,
          price_in_cents: to_dollars(tea.price_in_cents)
      }
    end
  end

  def coffee_as_json
    coffee_items.map do |coffee|
      {
          name: coffee.name,
          price_in_cents: to_dollars(coffee.price_in_cents)
      }
    end
  end
end