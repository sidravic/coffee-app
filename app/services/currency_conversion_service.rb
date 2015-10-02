module CurrencyConversionService
  def to_dollars(amount_in_cents)
    (amount_in_cents/100)
  end

  def to_cents(amount_in_dollars)
    (amount_in_dollars * 100)
  end
end