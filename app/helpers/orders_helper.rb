module OrdersHelper
  include CurrencyConversionService

  def with_categories(item)
    size = item.categories.sizes.first
    size_text = size ? size.name.to_s : ''
    "#{item.name} #{size_text} #{number_to_currency(to_dollars(item.price_in_cents))}"
  end
end
