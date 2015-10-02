require 'rails_helper'

RSpec.describe OrderAddItemService, type: :class do
  before(:each) do
    @barista = Barista.create_with_code('Sid')
    @latte = MenuItem.create({name: 'Latte', price_in_cents: 6_00})
    @americano = MenuItem.create({name: 'Americano', price_in_cents: 4_00})
  end

  describe '.add' do
    context 'when a valid order is used to add an item' do
      context 'and when the order is in the `OPEN` state' do
        it 'should add the item to an order' do
          order = Order.create_for(@barista)
          OrderAddItemService.new(order.id).add(@latte)
          order_add_item_response = OrderAddItemService.new(order.id).add(@americano)
          expect(order_add_item_response.order.menu_items.count).to eql(2)
        end

        it 'should update the price of items in the order' do
          order = Order.create_for(@barista)
          OrderAddItemService.new(order.id).add(@latte)
          order_add_item_response = OrderAddItemService.new(order.id).add(@americano)
          expect(order_add_item_response.order.amount_in_cents).to eql(10_00)
        end

        it 'should return a success response' do
          order = Order.create_for(@barista)
          OrderAddItemService.new(order.id).add(@latte)
          order_add_item_response = OrderAddItemService.new(order.id).add(@americano)
          expect(order_add_item_response.success?).to be_truthy
        end
      end

      context 'and when the order is NOT in the `OPEN` state' do
        it 'should not add the item to the order' do
          order = Order.create_for(@barista)
          order.cancel!

          OrderAddItemService.new(order.id).add(@latte)
          order_add_item_response = OrderAddItemService.new(order.id).add(@americano)
          expect(order_add_item_response.order.menu_items.count).to eql(0)
          expect(order_add_item_response.success?).to be_falsey
        end

        it 'should return an error saying the order is not open' do
          order = Order.create_for(@barista)
          order.cancel!

          OrderAddItemService.new(order.id).add(@latte)
          order_add_item_response = OrderAddItemService.new(order.id).add(@americano)

          expect(order_add_item_response.errors.first).to eql(OrderAddItemService::INVALID_ORDER_STATUS)
        end
      end
    end

    context 'when a invalid order is used to add an item' do
      it 'should return an error denoting error an invalid order' do
        order = Order.create_for(@barista)
        OrderAddItemService.new(order.id).add(@latte)
        order_add_item_response = OrderAddItemService.new(order.id).add(@americano)
        expect(order_add_item_response.success?).to be_truthy
      end
    end
  end

end